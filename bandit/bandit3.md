# [Bandit3->4](https://overthewire.org/wargames/bandit/bandit4.html)

## Level Goal

The password for the next level is stored in a **hidden file** in the **inhere** directory.

## Commands useful to solve the level

- [cd](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html)
- [ls](https://www.gnu.org/software/coreutils/manual/coreutils.html#ls-invocation)
- [cat](https://www.gnu.org/software/coreutils/manual/coreutils.html#cat-invocation)

## Helpful Reading Material

- [Hidden file and hidden directory](https://en.wikipedia.org/wiki/Hidden_file_and_hidden_directory)
- [What are directories, if everything on Linux is a file?](https://askubuntu.com/questions/1073802/what-are-directories-if-everything-on-linux-is-a-file)
- [inode(7) man page](https://www.man7.org/linux/man-pages/man7/inode.7.html)


## Where to start?

In this challenge, we're now introduced to 2 new notions : **directories** and **hidden files**. The reading material gives valuable information and helps us 
understand better what actually is a directory and what are hidden files. One key takeaway is that hidden files are not safer that regular files, they are 
just not listed by default by listing utilities. However, the information that they are not listed by default already gives us two hints :

1. The file is there
2. We can access it

Now, let's dive into how we are going to actually view and access the file in this hidden directory.

## Let's move, I want to be close to the file I'm looking for


<details>
<summary><h3 style="display:inline-block">Part 1 : the cd builtin</h3></summary>

Let's now meet a new friend, the `cd` [**builtin**](https://www.gnu.org/software/bash/manual/html_node/Shell-Builtin-Commands.html). We will need to use 
this builtin to navigate to the directory named **inhere**.


<details>
<summary>Hint</summary>

`man cd` doesn't work here. Indeed, the `cd` builtin is part of the shell you're using (I'll assume you're using bash). 

However, you can view the [**SHELL BUILTIN COMMANDS**](https://www.gnu.org/software/bash/manual/html_node/Shell-Builtin-Commands.html) section of the 
gnu bash manual.

</details>

<details>
<summary>Solution</summary>

To effectively change directory to the **inhere** directory, we need to run the command `cd inhere`.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : listing hidden files</h3></summary>

Now that we are in the **inhere** directory, if we run the `ls` command, this is the output we get :
```bash
bandit3@bandit:~/inhere$ ls
bandit3@bandit:~/inhere$
```
However, we know that there is a hidden file in this directory, we need to find a way to retrive that file.


<details>
<summary>Hint</summary>

Look at the **DESCRIPTION** section of [ls](https://www.gnu.org/software/coreutils/manual/coreutils.html#ls-invocation). 
The option you're looking for should be near the top

</details>

<details>
<summary>Solution</summary>

The `-a` or `--all` is the option you're looking for. It allows to not ignore the entries starting with a `.`.<br/>
This is the output we get after listing all of our directory contents : 

```bash
bandit3@bandit:~/inhere$ ls --all
.  ..  .hidden
bandit3@bandit:~/inhere$
```
Now that we know that the file we're are looking for, we can print its content with `cat .hidden`
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. `cd inhere` to change directory to the inhere directory
2. `ls --all` to print all the contents of the inhere directory
3. `cat .hidden` to print the hidden file
</details>

## Why move ? I can do everything from my home directory

The idea is basically the same than if we wanted to move, with a slight variation.


<details>
<summary><h3 style="display:inline-block">Part 1 : listing the directory contents</h3></summary>

Up until now, we used the `ls` utility with options but without any argument. We need to find a way to specify a directory to the `ls` command.


<details>
<summary>Hint</summary>

Once again, we'll look in the [ls](https://www.gnu.org/software/coreutils/manual/coreutils.html#ls-invocation) 
man page, but this time we need to have a look in the **SYNOPSYS** section.
</details>

<details>
<summary>Solution</summary>

The command `ls --all inhere` it the command we're looking for. this command will allow us to list the contents of the inhere directory, 
without moving nor ignoring the hidden files.<br/>
Running it gives us the following output :
```bash
bandit3@bandit:~$ ls --all inhere
.  ..  .hidden
bandit3@bandit:~$
```
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : printing the hidden file</h3></summary>


Now that we now that the hidden file in the inhere directory is called `.hidden`, we can run `cat` and give it the relative path 
to the `.hidden` file as an argument : `cat inhere/.hidden`. This will dump the password string to stdout
</details>


<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. `ls --all inhere` to list the contents of the inhere directory
2. `cat inhere/.hidden` to print the contents of the `.hidden` file
</details>

You can now jump to the [next level](/bandit/bandit4.md)
