# [Bandit28->29](https://overthewire.org/wargames/bandit/bandit29.html)

## Level Goal

There is a git repository at ssh://bandit28-git@localhost/home/bandit28-git/repo via the port 2220. 
The password for the user bandit28-git is the same as for the user bandit28.

Clone the repository and find the password for the next level.

## Commands useful to solve the level

- [git-log](https://git-scm.com/docs/git-log)
- [git-show](https://www.git-scm.com/docs/git-show)


## Helpful Reading Material

- [giteveryday](https://www.git-scm.com/docs/giteveryday) *A useful minimum set of commands for Everyday Git*

## Where to start?

For more informations about how to clone the repository, see the [previous level](/bandit/bandit27.md).

From now on, I'll assume that you already retrieved the git repository in your temporary directory.


<details>
<summary><h3 style="display:inline-block">Part 1 : Viewing the history</h3></summary>

In this level, when we `cat` the README.md file in the directory, we have a series of x's instead of the password 
like in the previous level. Of course, this series of x's isn't the password so we'll need to find a way to retrieve 
it.

<details>
<summary>Hint</summary>

As git stores the whole history of the file modifications, looking at the [git-log](https://git-scm.com/docs/git-log) 
man page, can you figure out a way to view the history of the git repository?
</details>

<details>
<summary>Solution</summary>

By running the `git-log` command, we can see that the commit history talks about missing data that has been added and 
the commit we're on talks about a memory leak. Our next goal will be to check for differences between the `HEAD` which is 
the point we're on in the history (usually after the last commit) and the commit that talks about missing data.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Retrieving the password</h3></summary>

Now that we know where the information we'd like to retrieve might be, we need for a way to check if this information 
is actually there.
<details>
<summary>Hint</summary>

Looking at the [git-show](https://git-scm.com/docs/git-show) man page, can you figure out a way to view the differences 
between the README at the current commit and the README at the previous commit?
</details>

<details>
<summary>Solution</summary>

Using the `git-show` command, we can provide the hash of the commit we want to view 

> Note : We don't need to provide the full hash and the 5 first characters are usually enough

Let's run the following command in our terminal :
```bash
git show f08b9
```
This will print the last change in the `README.md` file, thus printing the password string.
</details>
</details>

<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. `git log` to view all the commit history.
2. `git show f08b9` to view the difference with the previous commit.
</details>

You can now jump to the [next level](/bandit/bandit29.md)
