---
title: "git cheatsheet (1)"
date: 2016-02-13T23:11:08+08:00
description: ""
categories: []
slug: "git-cheatsheet-01"
tags: ["Git", "Tips"]
---


## 1. Basic git workflow
#### git init
`init` sets up all the tools Git needs to begin tracking changes made to the project.
```bash
$ pwd
/home/redfish-lee/workspace/sourcecode
$ git init
Initialized empty Git repository in /home/.../sourcecode/.git/
```
#### git workflow
Consists of editing files in the working directory, adding files to the staging area, and saving changes to a Git repository. In Git, we save changes with a commit.

#### git status
In the output, notice the file in **red** under **untracked** files. Untracked means that Git sees the file but has not started tracking changes yet.
```bash
$ git status
On branch master
Initial commit
Untracked files:
	(use "git add <file>..." to include in what will be committed)
		scene-1.txt
```

#### git add
Add file you want to track with and check using `git status` again. Here Git tells us the file was added to the **staging area**.`new file: scene-1.txt` is in **green** text.
```bash
$ git add scene-1.txt
$ git status
On branch master
Initial commit
Changes to be committed:
	(use "git rm --cached <file>..." to unstage)
        new file:   scene-1.txt
```

#### git diff
Since the file is tracked, we can check the differences between the working directory and the staging area with:
```bash
$ git diff filename
```
And you can see some `(+) insert` or `(-) delete`clearly.

#### git commit
A commit is the last step in our Git workflow. A commit permanently stores changes from the staging area inside the repository. `-m` can commit without opening it.
```bash
$ git commit -m "new line"
```

#### git log
Commits are stored chronologically in the repository and can be viewed with:
```bash
$ git log
commit 367f5fbf8d4e09b8cb7d97367e51b3a4491aeb5b
Author: redfish-lee <redfish.tbc@gmail.com>
Date:   Sat Feb 13 07:38:46 2016 -0500
	new line of dialogue
```
The 40-character code is called a **SHA**. It uniquely identifies the commit.

- - -

## 2. HOW TO BACKTRACK IN GIT
Git offers a few eraser-like features that allow us to undo mistakes during project creation.

#### HEAD commit
The commit **currently on** is known as the `HEAD commit`.Often be the  most recently one.
```bash
$ git show HEAD
```
Compared to`git log`, it also shows **all the file changes that were committed**.

#### git checkout (restore)
```bash
$ git checkout HEAD filename
```
This will restore the file in your **working directory** to look exactly as it did when you **last made a commit**. Or you could rewrite the file if you remember what it was before.

#### git reset
Resets the file in the staging area to be the same as the HEAD commit.
```bash
$ git reset HEAD filename
```
 - It does **not** discard file changes from the working directory, it **just removes them from the staging area.**
 - Unstage the file from the staging area. Thus, the reset file won't br counted when you make a commit.


#### git reset using SHA
This command works by using the first **7 characters** of the SHA of a *previous commit*. If the SHA of the previous commit is `5d692065cf51a2f50ea8e7b19b5a7ae512f633ba`
```bash
$ git reset 5d69206
```

<center>
    <img src="https://imgur.com/IUNV75O.jpg" >
</center>

 - You have in essence rewinded the project's history
 - All commits that came after your reset destination (5d69206) will dissappear.


## 3. GIT BRANCHING
Learn How to Manage Multiple Versions of a Project with Branching. `branch` `merge`
#### Which Branch am I on
```bash
$ git branch
 * master
```
`*` represent which brance you're on.

#### Branch Diagram
Circles are commits. New Branch is a different version of the Git project. It contains commits from Master but also has commits that Master does not have.

<center>
    <img src="https://i.imgur.com/hD5ddgT.jpg" >
</center>

#### About New Branch
```bash
$ git branch new_branch
$ git branch
	* master
      new_branch
$ git checkout new_branch
$ git branch
	  master
    * new_branch
```
 - Use `checkout` to change between branches.
 - New branch inherite **all** commits in the master branch.


#### Merge
 - New branch is the giver branch, since it provides the changes.
 - Master is the receiver branch, since it accepts those changes.
 - Switch to master branch and merge a branch to current one (master).

```bash
$ git merge new_branch
Updating 79a1cc5..0e13229
Fast-foward
resume.txt | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)
```

#### Merge Conflicts
Assume that master branch is modified after created a new branch. And if you want to merge 2 branches, Git wouldn't know which changes you want to keep.

To keep the modified master branch or applied the new branch to the original master branch, check which file cause the conflicts.

```bash
CONFLICT (content): Merge conflict in resumé.txt
Automatic merge failed; fix conflicts and then commit the result
```

In the file you'll see:
```bash
<<<<<<< HEAD
master version of line
=======
new_branch version of line
>>>>>>> new_branch
```
Choose which version you want to keep and **delete all of Git's special markings**. Remember to commit clearly.
```
$ git commit -m "resolve merge conflict"
```

#### Delete Branch
In Git, you create branches to work on a new project feature, but the end goal is to merge that feature into the master branch. After the branch has been integrated into master, it has served its purpose and can be deleted.
```bash
$ git branch -d branch_name
```


## 4. GIT TEAMWORK
Remote is a shared Git repository that allows multi-collaborators to work on the same Git project from different locations independently, and merge changes together when they are ready to.
 1. Fetch and merge changes from the remote
 2. Create a branch to work on a new project feature
 3. Develop the feature on your branch and commit your work
 4. Fetch and merge from the remote again in case new commits were made while you were working
 5. Push your branch up to the remote for review
- - -

#### git clone
```bash
$ git clone remote_location clone_name
```
 - **remote_location:** where to go to find the remote. A **web address** or a **filepath** is fine.
 - **clone name:** the name you give to the directory in which Git will clone the repository.
 - **origin:** Git gives the remote address the name `origin` implicitly when you clone, so that you can refer to it more conveniently.


#### git remote
```bash
$ git remote -v
origin    /home/ccuser/workspace/.../science-quizzes (fetch)
origin    /home/ccuser/workspace/.../science-quizzes (push)
```

#### git fetch
If someone change the remote, that means your clone is not up-to-date. Use `fetch` to see if changes have been made to the remote and bring changes down to your local copy.
```bash
$ git fetch
remote: Counting objects: 6, done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 5 (delta 1), reused 0 (delta 0)
Unpacking objects: 100% (5/5), done.
From /home/ccuser/workspace/curriculum-a/science-quizzes
 * [new branch]      master     -> origin/master
```
 - `git fetch` will not merge changes from the remote into your local repository. It brings those changes onto what's called a **remote branch**.
 - New commits are fetched to your local copy of the Git project as `origin/master` branch. Your local master branch has not been updated yet...


#### git merge
To integrate `origin/master` into local master branch, use `git merge`.
```bash
$ git merge origin/master
Updating a2ba090..bc87a1a
Fast-forward
 biology.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
```
The check the `HEAD log`, you'll see the local copy update correctly.

#### git push
This will push your branch up to the remote, **origin**.
```bash
$ git push origin your_branch_name
...
To /home/ccuser/workspace/curriculum/science-quizzes
 * [new branch]      bio-questions -> bio-questions
```
 - Git informs us that the branch bio-questions was pushed up to the remote.
 - From there, **the repository holder** can review your branch and merge your work into the master branch, making it part of the definitive project version.


## 5. Notice
- Remember to add the file from directory to stage area. And when it is modified, you need to **add it again to update the file in stage area**.
- Before giving a commit, check git status to verify files in staging area is good to commit.
- `git pull` = `git fetch` + `git merge origin/master`
`origin/master`: remote branch
`master`       : local branch
