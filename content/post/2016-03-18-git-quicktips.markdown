---
title: "git quicktips (2)"
date: 2016-02-13T23:11:08+08:00
description: ""
categories: []
slug: "git-cheatsheet-02"
tags: ["Git", "Tips"]
---


## Some Reference Links
- [How to Write a Git Commit Message](http://chris.beams.io/posts/git-commit/)

## Some Conventions
- Use imperative mood in the subject line, like
```Update getting started documentation```
    - Can be checked by: `If applied, this commit will <COMMIT SUBJECT>`
- Do not end with period `.`
- Capitalize the subject line

## Tips
***Add SSH key to authenticate push behavior***
```
$ ssh-keygen
$ cat ~/.ssh/id_rsa.pub                
# Copy SHA to your public key
$ git remote set-url origin git@github.com:username/repo.git
```
***Add remote depo***
```
$ git remote -v
$ git remote add upstream <URL>
```
***Merge from remote depo***

`pull` is to **fetch** then **merge**

```
$ git checkout master
$ git pull upstream master             # no local commits
$ git pull --rebase upstream master    # with local commits and avoid merge log
$ git push origin master
```
***Stash working directory to non-added & newly created***
```
$ git stash -k -u
```

***Remove/Reset Commits***
```
$ git reset --soft HEAD^          # Delete last commit with changes remaining
$ git reset --hard HEAD^          # Delete HEAD and change to previous version
$ git reset --hard ORIG_HEAD      # Reset to specific HEAD address
$ git push <upstream name> -f     # Force to push to remote depo

# Combination above reset and push can be altered by below
# (SHA-7)^ means the parent of SHA-7, + as a forced non-fastforward push.
$ git push upstream +dd61ab32^:master
```

***Recommit Last Commit***
```
$ git commit --amend
# Then there'll be a editor window to some add-files and commit name
# Remember that this is a NEW commit compared to the miss-committed one
```
