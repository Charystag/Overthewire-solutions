# [Bandit2->3](https://overthewire.org/wargames/bandit/bandit3.html)

## Level Goal

The password for the next level is stored in a file called **spaces in this filename** located in the home directory

## Commands useful to solve the level

- [ls](https://www.gnu.org/software/coreutils/manual/coreutils.html#ls-invocation)
- [cat](https://www.gnu.org/software/coreutils/manual/coreutils.html#cat-invocation)
- [bash](https://www.gnu.org/software/bash/manual/html_node/index.html)

## Helpful Reading Material

- [Filenames Spaces Linux](https://linuxhandbook.com/filename-spaces-linux/) *Contains Spoilers*

## Where to start?

For this level again, the solution is written in the helpful material. For more explanations, you can read the Walkthrough.


<details>
<summary><h3 style="display:inline-block">Part 1 : Analysing the directory files</h3></summary>

After listing the contents of the directory with `ls`, we can notice the following :

```bash
bandit2@bandit:~$ ls
spaces in this filename
bandit2@bandit:~$
```

Which seems to indicate that there are 4 files in this directory : `spaces`, `in`, `this` and `filename`. 

Let's look into the [ls](https://www.gnu.org/software/coreutils/manual/coreutils.html#ls-invocation) man page, 
and try to look for an option that lists one file per line.

<details>
<summary>Hint</summary>

Options can also be numbers
</details>

<details>
<summary>Solution</summary>

The `-1` option is the option we were looking for

However when using the option we previously found we see the following :

```bash
bandit2@bandit:~$ ls -1
spaces in this filename
bandit2@bandit:~$ 
```

which is exactly the same prompt as before. However, as this option allows us to list one file per line, we know 
for sure that `spaces in this filename` is actually the name of a unique file.
</details>
</details>

<details>
<summary><h3 style="display:inline-block">Part 2 : Printing the file</h3></summary>

Now that we know that the file is called `spaces in this filename`, we need to refer find a way to print this file. 


<details>
<summary>Hint</summary>

By looking into the **QUOTING** section of the [gnu bash manual](https://www.gnu.org/software/bash/manual/html_node/Quoting.html), 
can you retrieve all the **quoting mechanism** that are available to us in order to print this file?
</details>

<details>
<summary>Solution</summary>

There are 3 quoting mechanism that allow us to print this file : 

1. By escaping the spaces with the filename : `spaces\ in\ this\ filename`. As the `\` preserves the litteral value of the 
character immediately following it.

2. By enclosing the filename within **simple** quotes : `'spaces in this filename'`. As the simple quotes preserve the litteral 
value of **all** the characters they enclose

3. By enclosing the filename within **double** quotes : `"spaces in this filename"`. As the double quotes preserve the litteral 
value of all the characters they enclose, appart from `$`, `` ` `` and `\`. As the character we need to preserve is the **space**, 
we can also use the double quotes to achieve this goal.

</details>
</details>


<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. `cat "spaces in this filename"` to print the password to stdout.
</details>

You can now jump to the [next level](/bandit/bandit3.md)
