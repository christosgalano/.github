# GitHub Actions - Guide

## Composite action

When creating a composite action that uses a bash script, **always** run the following after committing:

```bash
git update-index --chmod=+x bash_script
```
