# [Bandit31->32](https://overthewire.org/wargames/bandit/bandit32.html)

## Level Goal

There is a git repository at ssh://bandit31-git@localhost/home/bandit31-git/repo via the port 2220. 
The password for the user bandit31-git is the same as for the user bandit31.

Clone the repository and find the password for the next level.

## Commands useful to solve the level

- [cat](https://www.gnu.org/software/coreutils/manual/coreutils.html#cat-invocation)
- [git-add](https://www.git-scm.com/docs/git-add)
- [git-status](https://git-scm.com/docs/git-status)
- [git-commit](https://git-scm.com/docs/git-commit)
- [git-push](https://git-scm.com/docs/git-push)

## Helpful Reading Material

- [Recording Changes to the Repository](https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository)
- [Gitignore Documentation](https://git-scm.com/docs/gitignore)

## Where to start?

When we `cat` the README.md file, we see that it gives us a set of instructions. We have to create a `key.txt` file 
and "push" it to our remote repository.


<details>
<summary><h3 style="display:inline-block">Part 1 : Stagging the key.txt file</h3></summary>

We need to create a file called `key.txt` with the contents 'May I come in?'. The real challenge 
here will be to stage the `key.txt` file for commit.

<details>
<summary>Hint</summary>

Using the [git-add](https://www.git-scm.com/docs/git-add) man page and the 
[Gitignore Documentation](https://git-scm.com/docs/gitignore), can you figure out a way to stage the `key.txt` file?
</details>

<details>
<summary>Solution</summary>

When we run `git add key.txt`, we get the information that the `key.txt` file has been marked as ignored by git (you 
can `cat` the `.gitignore` file in order to understand why. Thus running the following command :
```bash
git add -f key.txt
```
This allows us to tell git to add the key.txt file even if git has been told to ignore it.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Pushing the key.txt file to the repository</h3></summary>

Now that we've added the key.txt file to the stagging area, we need to push the file to the repository to validate the challenge.
<details>
<summary>Hint</summary>

Using the [git-commit](https://git-scm.com/docs/git-commit) and the [git-push](https://git-scm.com/docs/git-push) man pages, 
can you figure out how to push the file to the repository?
</details>

<details>
<summary>Solution</summary>

Each commit must have a, preferably explicit, commit message. Then after taking our snapshot of the state of the repository, we 
can then push our set of snapshots to the remote repository. We can use the `-m` option of `git commit` to specify the 
message on the command line.

Here are our two commands :
```bash
git commit -m "explicit commit message"
git push
```
As we followed all the instructions, we get the password for the next level in the response.
</details>
</details>

<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. `echo "May I come in?" > key.txt` to create the `key.txt` file.
2. `git add -f key.txt` to forcefully add the `key.txt` file to the stagging area.
3. `git commit -m "explicit message"` to commit the changes
4. `git push` to push our changes to the remote repository
</details>

You can now jump to the [next level](/bandit/bandit32.md)
