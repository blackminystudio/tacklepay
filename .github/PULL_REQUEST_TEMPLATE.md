### Release

[Release]
[Add Jira link here]

### Description

- Brief description of the changes.

### Screenshots

[Add screenshots]

### Tips

Any tips for testing it?

---

### IMPORTANT:

- (REQUIRED) Coverage Screenshots for the tests written
- (REQUIRED) UI Screenshots for the UI implementation written

### Author preparation checklist

- [ ] Current branch is rebased with latest 'Staging' branch
- [ ] PR is targeting only one issue
- [ ] Commit messages are descriptive, consistent, and follow the project's guidelines.
- [ ] Branch name matches with at least `<jira link reference>-<short change description>`
- [ ] Primary reviewer is set as assignee to the PR
- [ ] No unnecessary changes on `pubspec.lock`
- [ ] All added TODOs have associated Github issue references
- [ ] \*.iml and, pubsepc_overrides.yaml are not checkedin
- [ ] All hard coded strings are present in constants file

### Primary reviewer checklist

- [ ] All items in the author checklist is checked or not applicable
- [ ] All files including .lock and assets are reviewed
- [ ] Reasonable UI flows/cases related to the change are manually tested
- [ ] No commented-out code or unnecessary debug statements.
- [ ] No spelling or grammatical errors in code comments or documentation.
- [ ] No sensitive data (e.g., API keys, credentials) is hardcoded or exposed.
- [ ] The branch is up-to-date with the target branch (e.g., staging).
- [ ] The code adheres to established coding standards.

### Pre-merge checklist

- [ ] Two approvals received. (Changes affecting automatic PR verification, like new linter rules, formatting rules, Github workflow configurations)

---
