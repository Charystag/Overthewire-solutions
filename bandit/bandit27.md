# [Bandit27->28](https://overthewire.org/wargames/bandit/bandit28.html)

## Level Goal

There is a git repository at ssh://bandit27-git@localhost/home/bandit27-git/repo via the port 2220. 
The password for the user bandit27-git is the same as for the user bandit27.

Clone the repository and find the password for the next level.

## Commands useful to solve the level

- [git](https://git-scm.com/docs)
- [git-clone](https://git-scm.com/docs/git-clone)
- [ls](https://www.gnu.org/software/coreutils/manual/coreutils.html#ls-invocation)
- [cat](https://www.gnu.org/software/coreutils/manual/coreutils.html#cat-invocation)

## Helpful Reading Material

- [Git Wikipedia Page](https://en.wikipedia.org/wiki/Git)
- [Git user manual](https://git-scm.com/docs/user-manual)
- [gittutorial-1](https://git-scm.com/docs/gittutorial)

## Where to start?

Here we enter a series of levels that are aimed to teach us the git basics. Let's dive right in and solve the first level


<details>
<summary><h3 style="display:inline-block">Part 1 : Getting the repository</h3></summary>

Our first challenge in our quest to master Git is to unterstand how to get a copy of a guide repository (or clone).

<details>
<summary>Hint</summary>

By doing the first part of the [gittutorial](https://git-scm.com/docs/gittutorial) and reading the 
[git-clone](https://git-scm.com/docs/git-clone) man page, can you figure out a way to retrieve the repository located at 
`ssh://bandit27-git@localhost/home/bandit27-git/repo` ?

> Note : You might need to create a temporary directory

</details>

<details>
<summary>Solution</summary>

Lets first change directory to a temporary directory with `cd "$(mktemp -d /tmp/bandit27git.XXXXX)"`, then we can run the 
following command :
```bash
git clone ssh://bandit27-git@localhost:2220/home/bandit27-git/repo
```
Remember that we have to specify the port as we're not connecting using the port 22 (ssh default's port) but the port 2220.

We can then enter the password for bandit27-git (which is the password for bandit27) and we see the repository `repo` 
appear in our temporary directory.

We can now try to retrieve the password.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Retrieving the password</h3></summary>

For this level, the password retrieval is pretty straightforward.

<details>
<summary>Hint</summary>

Try listing the contents of the directory.
</details>

<details>
<summary>Solution</summary>

By running `cat README.md` we can retrieve the password for the next level.
</details>
</details>

<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. `cd "$(mktemp -d /tmp/bandit27git.XXXXXX)"` to change to a temporary directory
2. `git clone ssh://bandit27-git@localhost:2220/home/bandit27-git/repo` to clone the repository into our directory
3. `cat README` to retrieve the password
</details>

You can now jump to the [next level](/bandit/bandit28.md)
