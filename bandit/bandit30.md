# [Bandit30->31](https://overthewire.org/wargames/bandit/bandit31.html)

## Level Goal

There is a git repository at ssh://bandit30-git@localhost/home/bandit30-git/repo via the port 2220. 
The password for the user bandit30-git is the same as for the user bandit30.

Clone the repository and find the password for the next level.

## Commands useful to solve the level

- [git-tag](https://git-scm.com/docs/git-tag)
- [git-show](https://git-scm.com/docs/git-show)

## Helpful Reading Material

- [Tagging](https://git-scm.com/book/en/v2/Git-Basics-Tagging)

## Where to start?

Once again, if you need information about retrieving the repository, go check [bandit27](/bandit/bandit27.md) level.

Here, we can notice that nothing we did precedently works. As we had to do with the other levels, we have to learn another 
git capability and use it to retrieve the password.


<details>
<summary><h3 style="display:inline-block">Part 1 : Viewing the points of interest in the history</h3></summary>

One capability of git is to **tag** some commits as important, let's see if we can use it to our advantage and 
retrieve the password.

<details>
<summary>Hint</summary>

Using the [git-tag](https://git-scm.com/docs/git-tag) command, can you figure out how to view all the tags of the 
git repository?
</details>

<details>
<summary>Solution</summary>

Let's run the following command :
```bash
git tag
```
This allows us to list all the tags within the git repository. This command outputs a `secret` tag which seems to be the door that 
separates us from our password.

</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Retrieving the information</h3></summary>

Now that we got our tag, we have to retrieve the information that's hidden within it.
<details>
<summary>Hint</summary>

Using again the [git-show](https://git-scm.com/docs/git-show) man page, can you find a way to retrieve the informations within the 
`secret` tag?
</details>

<details>
<summary>Solution</summary>

Let's run the following command :
```bash
git show secret
```
This command let's us view the informations that were added during the tag creation. Of course they include this level password, thus allowing 
us to jump to the next level.
</details>
</details>

<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. `git tag` to list all the tags in the repository.
2. `git show secret` to view the informations within the secret tag and retrieve our password.

</details>

You can now jump to the [next level](/bandit/bandit31.md)
