# Planning
- Clarify First: Ask clarifying questions before executing to understand my requirements clearly.
- Define "Done": If requirements are vague, STOP. Ask: "What does 'done' look like for this task?" Provide a checklist of acceptance criteria before proceeding.

# Agent Behavior
- Execute commands directly rather than printing them for the user to run.
- Don't make unrelated changes, but raise the issue with the user.

# Code Preferences
- Aim for strong type safety. Limit casts, `Any`, and `type: ignore` to when truly necessary.
- Default to immutability. Use mutation only when important for performance.
- Be factual in documentation and comments — avoid salesy adjectives like "sophisticated" or "elegant."
- Write comments sparingly. Only add comments where the motivation for the code would be unclear.
- Avoid comments about the change being made (e.g., "Removed pipenv"). Comments should have long-term value.
- Do not use section separator comments like `# --- Section ---`.

# Git
- Avoid force pushing if possible. Force pushes are acceptable when rebasing. Otherwise, prefer adding a new commit.

# GitHub Pull Requests
- Create all PRs as drafts using the '--draft' option of 'gh pr create'
- When creating a new feature branch, always prefix the branch name with the GitHub username followed by a '/' character
- If the feature branch corresponds to a Jira ticket, include the Jira issue id at the beginning of the pull request title surrounded by brackets.

## Pull Request Descriptions
- Keep descriptions concise and high-level. Don't mention specific files or functions — those are obvious from the diff.
- Don't say "This PR" — it's implied.
- Generate the PR body in a markdown code block so raw markdown can be easily copied.

## Pull Request Reviews
- Look up the associated Jira issue for context before reviewing.
- Read project READMEs before reviewing changes.
- Process review feedback systematically — wait for user input before implementing significant changes.

## GitHub Comments
- Use a collaborative tone. Frame issues as improvement opportunities, not failures.
- Match detail level to issue complexity — brief for simple issues, detailed with reasoning for complex ones.
- Always escape backticks in `gh api` body arguments to prevent shell substitution.

# Python
- Use `uv` instead of `pip` or `pip3` for Python package operations (e.g., `uv pip install`, `uv pip show`, `uv run`).
