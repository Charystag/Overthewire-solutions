# [Bandit25->26](https://overthewire.org/wargames/bandit/bandit26.html)

## Level Goal

Logging in to bandit26 from bandit25 should be fairly easy… The shell for user bandit26 **is not /bin/bash**, but something else. 
Find out what it is, how it works and how to break out of it.

## Commands useful to solve the level

- [vi](https://man7.org/linux/man-pages/man1/vi.1p.html)
- [more](https://man7.org/linux/man-pages/man1/more.1.html)
- [cat](https://www.gnu.org/software/coreutils/manual/coreutils.html#cat-invocation)

## Helpful Reading Material

- [Vim Documentation Options](https://vimdoc.sourceforge.net/htmldoc/options.html)
- [passwd(5) man page](https://man7.org/linux/man-pages/man5/passwd.5.html)

## Where to start?

By listing the contents of the directory, we can see that there is a private key that we should use to log in as the user bandit26, this means that 
this isn't where the true challenge of this level is. Let's try and analyse the level following the guidelines at the beginning.


<details>
<summary><h3 style="display:inline-block">Part 1 : Retrieving bandit26 shell</h3></summary>

The first thing we need to do is to retrieve bandit26 shell, as we know that this shell is not /bin/bash.

<details>
<summary>Hint</summary>

Using the [passwd(5) man page](https://man7.org/linux/man-pages/man5/passwd.5.html), can you figure out a way to retrieve the shell that bandit26 
gets when it logs in and to view its contents?
</details>

<details>
<summary>Solution</summary>

Using the `passwd(5)` man page, we know that the informations for the bandit 26 user are stored in the `/etc/passwd` file. This file is readable 
by everyone so we can print its content and `grep` only the lines containing bandit26. Here is the command we'll run, alongside its output :
```bash
bandit25@bandit:~$ cat /etc/passwd | grep bandit26
bandit26:x:11026:11026:bandit level 26:/home/bandit26:/usr/bin/showtext
bandit25@bandit:~$
```
We know from the `passwd(5)` man page that the last field is the bandit26 user's shell : `/usr/bin/showtext`.

Let's print the contents of this file :
```bash
#!/bin/sh

export TERM=linux

exec more ~/text.txt
exit 0
```
We see here that the script sets one variable `TERM` and then runs the `more` utility.

One thing we can already notice is that the `showtext` executable doesn't take any argument, so we won't be able to ssh our way into bandit26 acount 
running a command like we did in [level18](/bandit/bandit18.md). We'll need a find another way to get in.
</details>
</details>

<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

</details>

You can now jump to the [next level](/bandit/bandit26.md)
