# [Bandit](https://overthewire.org/wargames/bandit/bandit3.html)

## Level Goal

The password for the next level is stored in a file called **spaces in this filename** located in the home directory

## Commands useful to solve the level

- ls
- cat

## Helpful Reading Material

- [Filenames Spaces Linux](https://linuxhandbook.com/filename-spaces-linux/)

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

Let's run `man ls` and try to look for an option that lists one file per line.

<blockquote>

To get the `man ls` page with colors you can run : 
```bash
curl -fsSL https://raw.githubusercontent.com/Charystag/Scripts/main/colored_man.sh | bash -s ls
```

</blockquote>

<details>
<summary>Hint</summary>

Options can also be numbers
</details>

<details>
<summary>Solution</summary>

The `-1` option is the option we were looking for
</details>

However when using the option we previously found we see the following :

```bash
bandit2@bandit:~$ ls -opt
spaces in this filename
bandit2@bandit:~$ 
```

which is exactly the same prompt as before. However, as this option allows us to list one file per line, we know 
for sure that `spaces in this filename` is actually the name of a unique file.

</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Printing the file</h3></summary>

Now that we know that the file is called `spaces in this filename`, we need to refer to this file. From now on, I know 
only three ways to print this file (they might be slight variations in the technique though). It is by using one of 
the 3 **quoting mechanism** described in `man bash` under the **QUOTING** section.

<blockquote>

You can either :

1. run the following :
```bash
bash <(curl -fsSL --connect-timeout 5 https://raw.githubusercontent.com/Charystag/man_reader/master/man_reader.sh) bash 'QUOTING'
```
to get the right `man` section with syntaxical highlighting

2. visit this [link](https://www.gnu.org/software/bash/manual/html_node/Quoting.html) to get the right section on the internet

</blockquote>

1. By escaping the spaces with the filename : `spaces\ in\ this\ filename`. As the `\` preserves the litteral value of the 
character immediately following it.

2. By enclosing the filename within **simple** quotes : `'spaces in this filename'`. As the simple quotes preserve the litteral 
value of **all** the characters they enclose

3. By enclosing the filename within **double** quotes : `"spaces in this filename"`. As the double quotes preserve the litteral 
value of all the characters they enclose, appart from `$`, `` ` `` and `\`. As the character we need to preserve is the **space**, 
we can also use the double quotes to achieve this goal.

</details>


<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

Now that we know how to refer to the file, we can print it using cat as with the two previous exercises.
`cat "spaces in this filename"` will dump the password string on stdout.
</details>

You can now jump to the [next level](/bandit/bandit3.md)