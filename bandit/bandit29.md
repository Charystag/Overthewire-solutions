# [Bandit29->30](https://overthewire.org/wargames/bandit/bandit30.html)

## Level Goal

There is a git repository at ssh://bandit29-git@localhost/home/bandit29-git/repo via the port 2220. 
The password for the user bandit29-git is the same as for the user bandit29.

Clone the repository and find the password for the next level.

## Commands useful to solve the level

- [git-branch](https://www.git-scm.com/docs/git-branch)
- [git-diff](https://www.git-scm.com/docs/git-diff)

## Helpful Reading Material

- [Branches in a nutshell](https://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell)
See [bandit27](/bandit/bandit27) and [bandit28](/bandit/bandit28) for more helpful reading material

## Where to start?

Once again, I'll assume that you already cloned the repository (see [bandit27](/bandit/bandit27) for 
more informations).


<details>
<summary><h3 style="display:inline-block">Part 1 : Viewing all the branches</h3></summary>

When we try to view the log and to show the differences in the repository, we don't get any relevant information.

Another great capability of git is the ability to `branch`. A branch is a line of development which is totally independent from all the others from 
the point when it has been created. 

<details>
<summary>Hint</summary>

By looking at the [git-branch](https://www.git-scm.com/docs/git-branch) man page, can you figure out a way to list all the branches in 
the repository?
</details>

<details>
<summary>Solution</summary>

We want to list all the branches of the repository. Let's run the following command :
```bash
git branch -a
```
This will list all the local branches (which is only master at the moment) and all the remote tracking branches.
The following command outputs 3 branches : `dev`, `master` and `sploits-dev`. Let's now see if we can retrieve the password in one of these 
two other branches.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Viewing the differences between the branches</h3></summary>

Now that we know that there are multiple branches, we'll try to view the differences between the README.md file and the files on 
the other branches
<details>
<summary>Hint</summary>

Looking at the [git-diff](https://git-scm.com/docs/git-diff) man page, can you figure out a way to view the differences between the master branch and the 
other branches?
</details>

<details>
<summary>Solution</summary>

Let's try and run the following command :
```bash
git diff remotes/origin/dev
```

> We need to use remotes/origin/dev because the dev branch is not tracked locally. To track the remotes/origin/dev locally you'd have to run 
> `git checkout dev` first.

When running the following command, we can see that the password is on the `dev` branch and use it to connect to the next level.
</details>
</details>

<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. `git branch -a` to view all the branches in the repository
2. `git diff remotes/origin/dev` to view the changes between the `dev` branch and the master branch

</details>

> One key takeaway of this level may be the Git mantra : **branch early and branch often**

You can now jump to the [next level](/bandit/bandit30.md)
