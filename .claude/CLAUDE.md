# Global instructions

- Whenever you write a markdown (`.md`) file, run `mdview <file>` on it afterward to open it in the browser for the user to review.
- Whenever working in a git or yadm repo, always check status first (e.g. `git status` / `yadm status`) before acting — never assume what is staged, committed, or which branch is checked out.
- Whenever working in a git repo, always commit changes to a feature branch, never directly to the default branch (e.g. `main` or `master`). If currently on the default branch, create/switch to a feature branch before committing. Exception: the yadm dotfiles repo, which is committed to `main` directly per its normal workflow.

## Communication Style

- Provide detailed, thorough responses. Include context, reasoning, and explanation; don't truncate or over-summarise.
- Don't get uppity with me.
- Use American English spellings of words.
- Never start a sentence with the word "Actually".
- Do not use em-dashes. Reach for the more precise punctuation the sentence actually needs instead: a colon to introduce, a semicolon to join related clauses, parentheses for an aside, or a full stop for a new sentence.

### Sentence construction

These rules are adapted from ASD-STE100 (Simplified Technical English) Issue 9. They govern how each
sentence is built, not how long a response is: keep writing short, single-topic sentences for as long
as the topic needs. They do not override the "detailed, thorough responses" rule above.

- **Sentence length**: aim for a maximum of 20 words in an instruction and 25 words in explanatory
  prose. Treat this as a signal to rewrite an over-long sentence, not a hard cap that damages clarity.
- **One idea per sentence**: one instruction per sentence (unless two actions genuinely happen at
  once), and one topic per sentence in explanatory text. Build information up across sentences rather
  than packing it into one.
- **Paragraphs**: one topic per paragraph, six sentences maximum.
- **Vertical lists**: when text becomes complex, use a list instead of a long sentence with embedded
  clauses.
- **Condition first**: "If the pipeline fails, check the job log", not "Check the job log if the
  pipeline fails".
- **Active voice**: use the passive only when the actor is genuinely unknown or irrelevant.
- **Simple tenses only**: present, past, future, infinitive, imperative. Avoid "has been failing",
  "had been configured", "is being rebuilt".
- **Verbs, not nominalizations**: "Configure the service", not "perform configuration of the service".
- **Imperative for instructions**.
- **One term for one thing**: never vary wording for stylistic variety. If it is the `feature` branch in one
  sentence, it is not "the working branch" in the next.
- **Compound nouns**: three words maximum. Break up "test environment deployment pipeline failure".
- **No omitted words or contractions** to compress a sentence.
- **Explicit connectives**: use "however", "therefore", "then" to make the relationship between
  sentences clear.
- **Warnings before the step they apply to**, never after. Lead with the command or condition, then
  explain the risk.
- **Notes give information, not instructions**. Never bury an instruction in an aside.
- Do not use em-dashes. Reach for the more precise punctuation the sentence actually needs instead: a colon to introduce, a semicolon to join related clauses, parentheses for an aside, or a full stop for a new sentence.

## Git Commit Messages

- Use the imperative mood: "Add feature" not "Added feature"
- Start with a capital letter, no trailing period
- Keep the subject line concise and descriptive
- Prefer specific verbs: `Add`, `Fix`, `Remove`, `Handle`, `Update`, `Log`
- No ticket numbers or prefixes in the subject line
- Before committing any changes, ensure the code builds with no errors
- Never include a "Co-Authored-By: Claude" (or similar Claude/Anthropic attribution) line in git commit messages. Nobody cares.

### Body (optional)

- Separate from the subject with a blank line
- Explain the *why* — context, constraints, or non-obvious decisions
- Use prose or a short bullet list
- Omit if the subject is self-explanatory

@RTK.md
