#!/usr/bin/env python3
"""Check a markdown file against the sentence-construction rules in CLAUDE.md.

Usage: check-style.py <file.md> [<file.md> ...]

Reports only what a machine can judge reliably: em-dashes, sentence length,
paragraph length, contractions, compound tenses, and a "Actually" sentence
start. Everything else in the rules needs a human read.

Fenced code blocks, indented code, tables, headings and link targets are
excluded, because they legitimately contain long lines and stray punctuation.

Exit codes: 0 clean, 1 findings, 2 usage error.
"""

import re
import sys

MAX_INSTRUCTION_WORDS = 20
MAX_PROSE_WORDS = 25
MAX_PARA_SENTENCES = 6

# Anything matching these is prose the rules apply to.
SKIP_PREFIXES = ("|", "#", ">", "    ", "\t")


def strip_frontmatter(text):
    """Drop a leading YAML frontmatter block.

    A skill's `description` is a trigger string read by the model, not prose the
    user reads, so the sentence rules do not apply to it.
    """
    if text.startswith("---\n"):
        end = text.find("\n---", 3)
        if end != -1:
            return text[end + 4 :]
    return text


def strip_noise(text):
    """Remove fenced code, inline code, links and emphasis markers."""
    text = re.sub(r"```.*?```", " ", text, flags=re.S)
    text = re.sub(r"~~~.*?~~~", " ", text, flags=re.S)
    # Double-quoted spans are quoted examples, not the author's own prose. A
    # document about the rules must be able to name a banned construction.
    text = re.sub(r'"[^"\n]{1,80}"', " ", text)
    return text


def clean_sentence(s):
    s = re.sub(r"`[^`]*`", "X", s)
    s = re.sub(r"\[([^\]]*)\]\([^)]*\)", r"\1", s)
    s = re.sub(r"\*\*|\*|__|_", "", s)
    return re.sub(r"\s+", " ", s).strip()


def units(text):
    """Yield (is_list_item, text) for each paragraph or list item.

    List items are kept separate so consecutive bullets never merge into one
    apparent sentence.
    """
    out = []
    cur = []
    cur_list = False

    def flush():
        if cur:
            out.append((cur_list, " ".join(cur)))

    for line in text.split("\n"):
        stripped = line.strip()
        if not stripped or stripped.startswith(SKIP_PREFIXES):
            flush()
            cur.clear()
            cur_list = False
            continue
        if re.match(r"^\s*([-*+]|\d+\.)\s", line):
            flush()
            cur.clear()
            cur_list = True
            cur.append(re.sub(r"^\s*([-*+]|\d+\.)\s", "", line).strip())
        else:
            cur.append(stripped)
    flush()
    return out


def sentences(unit_text):
    # A bold or italic lead-in ending in a full stop is a label, not the first
    # clause of the sentence after it. Drop it so the two are counted apart.
    unit_text = re.sub(r"^\s*(\*\*|__)[^*_]{1,120}?[.:!?](\*\*|__)\s*", "", unit_text)
    parts = re.split(r'(?<=[.!?])\s+(?=[A-Z"“(])', unit_text)
    return [clean_sentence(p) for p in parts if clean_sentence(p)]


def check(path):
    try:
        with open(path, encoding="utf-8") as fh:
            raw = fh.read()
    except OSError as exc:
        print(f"cannot read {path}: {exc}", file=sys.stderr)
        return 2

    body = strip_noise(strip_frontmatter(raw))
    findings = []

    # Em-dashes. Absolute rule, so report every one with its line number.
    in_fence = False
    for n, line in enumerate(raw.split("\n"), 1):
        if line.strip().startswith(("```", "~~~")):
            in_fence = not in_fence
            continue
        if in_fence or line.strip().startswith("|"):
            continue
        for _ in range(line.count("—")):
            findings.append((n, "em-dash", line.strip()[:90]))

    long_s = []
    long_p = []
    other = []

    for is_list, unit_text in units(body):
        sents = sentences(unit_text)
        if not is_list and len(sents) > MAX_PARA_SENTENCES:
            long_p.append((len(sents), sents[0][:70]))
        for s in sents:
            words = len(s.split())
            limit = MAX_INSTRUCTION_WORDS if is_list else MAX_PROSE_WORDS
            if words > limit:
                long_s.append((words, limit, s))

    for pat, label, flags in (
        (r"\b(?:has|have|had) been\b", "compound tense", re.I),
        (r"\b(?:is|are|was|were) being\b", "compound tense", re.I),
        (r"(?:^|[.!?]\s+)(Actually)\b", '"Actually" sentence start', 0),
        (r"\b\w+(?:'|’)(?:t|re|ve|ll|d|m)\b", "contraction", re.I),
        # Filler that sounds meaningful. State the consequence instead.
        (r"\bload[- ]bearing\b", "banned phrase (say what breaks)", re.I),
        (r"\bnot cosmetic\b", "banned phrase (say what breaks)", re.I),
        (r"\bnot decoration\b", "banned phrase (say what breaks)", re.I),
        (r"\bnot a formality\b", "banned phrase (say what breaks)", re.I),
        (r"\brather than defensive\b", "banned phrase (say what breaks)", re.I),
    ):
        for m in re.finditer(pat, body, flags=flags):
            # Prefer the capture group when the pattern needs leading context.
            hit = m.group(1) if m.groups() else m.group(0)
            other.append((label, re.sub(r"\s+", " ", hit).strip()))

    print(f"\n=== {path} ===")

    if findings:
        print(f"\nem-dashes: {len(findings)}  (rule: never use one)")
        for n, _, snippet in findings[:10]:
            print(f"  line {n}: {snippet}")
        if len(findings) > 10:
            print(f"  ... and {len(findings) - 10} more")

    if long_s:
        long_s.sort(reverse=True)
        print(f"\nover-long sentences: {len(long_s)}")
        for words, limit, s in long_s[:10]:
            print(f"  [{words}w, limit {limit}] {s[:110]}")
        if len(long_s) > 10:
            print(f"  ... and {len(long_s) - 10} more")

    if long_p:
        print(f"\nparagraphs over {MAX_PARA_SENTENCES} sentences: {len(long_p)}")
        for count, first in long_p:
            print(f"  [{count} sentences] {first}...")

    if other:
        print(f"\nother: {len(other)}")
        for label, text in other[:12]:
            print(f"  {label}: {text}")

    total = len(findings) + len(long_s) + len(long_p) + len(other)
    if total == 0:
        print("\nclean")
        return 0

    print(f"\ntotal findings: {total}")
    return 1


def main():
    if len(sys.argv) < 2:
        print(__doc__, file=sys.stderr)
        return 2
    worst = 0
    for path in sys.argv[1:]:
        worst = max(worst, check(path))
    return worst


if __name__ == "__main__":
    sys.exit(main())
