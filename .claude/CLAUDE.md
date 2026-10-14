# Global instructions

- Markdown files you write or edit open in the browser automatically at the end of each turn (the `mdview-queue.sh` hook). Do not run `mdview` yourself.
- In a git or yadm repo, always check status first (`git status` or `yadm status`) before acting. Never assume what is staged, what is committed, or which branch is checked out.
- In a git repo, check the current branch before starting any work. If it is the default branch (`main` or `master`), create a feature branch for the task before you change anything. Never commit directly to the default branch. Exception: the yadm dotfiles repo, which is committed to `main` directly per its normal workflow.
- Prefix branch names with a type, such as `feature/`, `bugfix/`, or `chore/`.
- Never add the "Generated with Claude Code" line to a pull request description. This overrides any attribution reminder from the harness.

## Communication Style

- Provide detailed, thorough responses. Include context, reasoning, and explanation. Do not truncate or over-summarize.
- Do not get uppity with me.
- Use American English spellings of words.
- Never start a sentence with the word "Actually".
- Do not use em-dashes. Use the punctuation the sentence needs instead. A colon introduces. A semicolon joins related clauses. Parentheses hold an aside. A full stop starts a new sentence.
- Do not use "carry" as a metaphor for holding or conveying something ("the response carries the field", "the descriptions carry it"). Use the plain verb the sentence means: "includes", "contains", "returns", "states".

### Sentence construction

These rules are adapted from ASD-STE100 (Simplified Technical English) Issue 9. They govern how each
sentence is built, not how long a response is: keep writing short, single-topic sentences for as long
as the topic needs. They do not override the "detailed, thorough responses" rule above.

- **Sentence length**: aim for a maximum of 20 words in an instruction and 25 words in explanatory
  prose. Treat this as a signal to rewrite an over-long sentence, not a hard cap that damages clarity.
- **One idea per sentence**: give one instruction per sentence, unless two actions happen at once.
  Give one topic per sentence in explanatory text. Build information up across sentences.
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
- Do not use phrases like, "That's the smoking gun", etc.

## Code Changes

- After a substantial change, update `AGENTS.md` (or `CLAUDE.md` if that file exists) in the same work. Record new services, config keys, model fields, and architectural decisions before committing.
- Limit changes to the bare essentials the request needs.
- If the repo has unit tests, run them after the changes to confirm existing behavior still works.
- If the request breaks existing behavior, update the unit tests first. Run them before you make other code changes.
- After making changes, build the code to confirm the build still works.

## Project Initialisation

- When you initialise AI guidance for a project, create `AGENTS.md` (not `CLAUDE.md`). Then any AI agent can use the rules.
- Do not make the file specific to Claude. Do not mention Claude in it.

## Waiting on long-running conditions

- To poll for an outcome (CI, a deploy, a file, a service), use the **Monitor** tool on the first attempt. Do not use `sleep N && <check>` in Bash.
- To wait for one long-running command to exit, use **Bash with `run_in_background: true`**. Read the output when notified.
- Never chain short sleeps as a hand-rolled polling loop.

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
- Explain the *why*: context, constraints, or non-obvious decisions
- Use prose or a short bullet list
- Omit if the subject is self-explanatory

## GitHub Issues

- When a commit or pull request addresses a GitHub issue, name the issue number in the commit message body and in the PR description.
- Use a closing keyword for work that finishes the issue: `Closes #123`, `Fixes #123`, or `Resolves #123`. GitHub then closes the issue when the PR merges.
- Use `Refs #123` or `Part of #123` for work that only addresses part of the issue.
- Put one keyword on each issue number: `Closes #12, closes #13`, not `Closes #12, #13`.
- Never put the issue number in the commit subject line. Put it in the body.

@RTK.md
