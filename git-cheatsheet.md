# My Git Cheatsheet

### Fetching remote branch after fresh cloning of repo
```bash
git checkout <branchname>
# Don't freak out because you think you created new branch, 
# You didn't, just look closely you just got your branch back
```

### Getting diff
```bash
git diff  # see diff of unstaged tracked files
git diff --staged  # see diff of staged files
git diff HEAD  # see diff of all tracked (staged and unstaged) files
```

### Removing local changes
```bash
git checkout .  # remove unstaged tracked changes
git clean -f  # remove unstaged untracked changes
git reset --hard  # removes staged and unstaged tracked changes
git stash -u  # removes all tracked and untracked changes
```
