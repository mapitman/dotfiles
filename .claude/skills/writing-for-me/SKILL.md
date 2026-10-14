---
name: writing-for-me
description: >-
  The user's sentence-construction and communication rules, applied to prose you
  write into a file. Read this BEFORE writing or editing any markdown document
  the user will read: a plan, a design or research doc, an ADR, a README, a
  summary, a report, or a wiki page. The rules live in CLAUDE.md. That file
  loads once at session start and fades over a long task, so violations cluster
  in documents written late. Contains the rules, the reasoning behind the ones
  broken most often, and a checker script. The script counts the mechanical
  violations so the draft is measured rather than eyeballed.
---

# Writing prose for this user

## Why this skill exists

The rules live in `CLAUDE.md`, which loads once at session start. Over a long
task they fade while the work in front of you stays sharp. The measured result:
a plan written late in a session contained **30 em-dashes**, under a rule that
forbids them outright.

The failure is not disagreement with the rules. It is that chat replies get the
attention and file writes do not. Read this skill immediately before writing
prose into a file, and run the checker before showing the user the result.

## The rules

These are the user's, from `CLAUDE.md`. They are reproduced here rather than
referenced, because a pointer is what already failed.

### Absolute

- **No em-dashes.** Not one. Use the punctuation the sentence actually needs.
  A colon introduces. A semicolon joins related clauses. Parentheses hold an
  aside. A full stop starts a new sentence.
- **Never start a sentence with "Actually".**
- **American spellings.** Behavior, serialize, initialize, analyze, catalog.
- **No contractions.** Write "do not", not "don't".
- **Do not get uppity.**

### Sentence construction

Adapted from ASD-STE100. These govern how each sentence is built, not how long
the response is. Keep writing for as long as the topic needs.

- **Length.** Maximum 20 words in an instruction, 25 in explanatory prose. Treat
  a breach as a signal to rewrite, not a hard cap that damages clarity.
- **One idea per sentence.** One instruction per sentence. Build information up
  across sentences instead of packing it into one.
- **Paragraphs.** One topic each, six sentences maximum.
- **Vertical lists.** When text turns complex, use a list rather than a long
  sentence with embedded clauses.
- **Condition first.** "If the pipeline fails, check the job log."
- **Active voice.** Use the passive only when the actor is unknown or irrelevant.
- **Simple tenses only.** Present, past, future, infinitive, imperative. Avoid
  "has been failing", "had been configured", "is being rebuilt".
- **Verbs, not nominalizations.** "Configure the service", not "perform
  configuration of the service".
- **Imperative for instructions.**
- **One term for one thing.** Never vary wording for stylistic variety. If it is
  the `users` table in one sentence, it is not "the accounts table" in the next.
- **Compound nouns: three words maximum.**
- **No omitted words** to compress a sentence.
- **Explicit connectives.** Use "however", "therefore", "then" to make the
  relationship between sentences clear.
- **Warnings before the step they apply to**, never after.
- **Notes give information, not instructions.** Never bury an instruction in an
  aside.

### Scope

Detailed and thorough responses are still wanted. Include context, reasoning and
explanation. The sentence rules constrain construction, not depth. Do not use
them as an excuse to truncate or over-summarize.

## Banned phrases

These sound meaningful and say nothing. The reader has to decode a metaphor to reach a
fact you could have stated outright.

| Do not write | Write the actual consequence |
|---|---|
| "X is load-bearing" | "Without X, the filter matches nothing" |
| "required, not cosmetic" | "Do not remove X. It does Y." |
| "not decoration", "not a formality" | Say what breaks when it is removed |
| "rather than defensive" | Say what goes wrong without the check |
| "the response carries the field", "the descriptions carry it" | The plain verb: "includes", "contains", "returns", "states" |

The test: delete the phrase and read the sentence again. If nothing is lost, it was
filler. If something is lost, state that thing directly instead.

This applies to code comments as much as to prose. A comment saying a comparer is
"load-bearing" tells the next developer nothing. A comment saying an ordinal comparison
would match nothing tells them exactly why the line exists.

## The three that get broken most

Watch these specifically. They account for nearly every violation.

**Em-dashes.** The reflex is strong and the rule is absolute. Most em-dashes are
doing one of three jobs, and each has a correct replacement:

| Job the em-dash was doing | Use instead |
|---|---|
| Introducing a definition or list | A colon |
| Joining two related independent clauses | A semicolon, or a full stop |
| Setting off an aside | Parentheses, or commas |

**Sentence length.** Long sentences arrive when a qualification gets bolted onto
a finished thought. When a sentence passes 25 words, the fix is almost always a
full stop before the qualification, not a rewrite.

**One term for one thing.** Synonym variety reads as elegance and causes real
confusion. Pick the term the codebase uses, then repeat it. Source material
often uses different words from the code. The code wins. Put the source wording
in a comment that records where it came from.

## Before showing the user

Run the checker on every markdown file you wrote or edited:

```sh
python3 ~/.claude/skills/writing-for-me/scripts/check-style.py <file.md>
```

It reports em-dashes with line numbers, over-long sentences, over-long
paragraphs, contractions, compound tenses, and a banned "Actually" opening.
Sentence length is measured against the right limit for prose or instructions.
It skips fenced code, indented code, tables, headings and block quotes. Those
legitimately hold long lines and stray punctuation.

Exit 0 means clean. Exit 1 means findings.

Fix what it reports, then run it again. Do not report a document as finished
while the checker still returns findings.

### What the checker cannot see

It counts what a machine can judge. A clean run is necessary, not sufficient.
Re-read for these yourself:

- Passive voice where an actor exists.
- Nominalizations hiding a verb.
- The same thing called two different names.
- An instruction buried inside a note or an aside.
- A warning placed after the step it applies to.
- Compound nouns over three words.

## Editing an existing document

The document belongs to the user once they have seen it.

- Make only the change asked for. Never restore earlier wording they cut.
- Match the length and tone already present.
- Every edit is a chance to cut, not only to add. After several rounds, re-read
  the whole document: iteration adds length that no single edit appears to add.
- Run the checker again after editing. New prose reintroduces old habits.
