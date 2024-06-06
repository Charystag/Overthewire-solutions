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
- [Does ssh run commands rather than itself in a login shell](https://unix.stackexchange.com/questions/744263/does-ssh-run-commands-rather-than-shell-itself-in-a-login-shell) *Unix StackExchange 
Discussion*
- [Vim various commands](https://vimdoc.sourceforge.net/htmldoc/various.html)

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

One thing we can already notice is that the `showtext` executable doesn't take any argument, so we won't be able to ssh our way into bandit26 account 
running a command like we did in [level18](/bandit/bandit18.md) (see 
[how ssh commands are run](https://unix.stackexchange.com/questions/744263/does-ssh-run-commands-rather-than-shell-itself-in-a-login-shell) for more 
explanations). We'll have to find another way to get in.

</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Let's scroll that thing</h3></summary>

When we first ssh our way into bandit26, we see that the `showtext` executable is ran. It prints the text **bandit26** in ASCII art and then exits.

We already know that the `showtext` executable uses more, the real challenge here is to take advantage of the `more` capabilities to run commands. 
To do so, we need to make it scrollable so that it shows its command prompt.
<details>
<summary>Hint</summary>

By doing some tests with files on your own computer, can you figure out when more is scrollable and where it isn't? Doing so, could you make it 
scrollable when logging in into bandit26 and find which command to run to get a text editor?
</details>

<details>
<summary>Solution</summary>

Although it is not very intuitive, you might have noticed that when the window size is smaller than the number of text lines, `more` becomes scrollable. 
We're going to use this capability of the `more` utility to break out of it. Let's minimize our window to less than 6 lines and then ssh into bandit26. 

> There might be a more elegant solution through the use of a terminal multiplexer like [tmux](https://github.com/tmux/tmux/wiki) but the idea will basically 
> be the same. I'll provide a solution using `tmux(1)` once I learn to use it.

We can now enter commands (see [more](https://man7.org/linux/man-pages/man1/more.1.html) man page for the full list). We are going to use the `v` command 
in order to open the vim editor.

We can now bring our window size back to normal.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 3 : Byebye showtext</h3></summary>

Now that we got inside `vim`, we have to get rid of this nice yet useless shell and get a real one.
<details>
<summary>Hint</summary>

Using the [various remaining commands](https://vimdoc.sourceforge.net/htmldoc/various.html) file of the vim help manual, 
can you figure out a way to get a shell while in the vim editor?

</details>

<details>
<summary>Solution</summary>

The command `:shell` is the one we need. Remember that you need to press `<ESC>` first to get into normal mode. 
However, when running it for the first time we can see that nothing **seems** to happen. The truth is that something 
really happened in front of our eyes. The shell of the user bandit26 was launched and then exited as it is the `showtext` executable.

> To convince yourself that it really happened, you can minimize the window to less than 6 lines before running the `:shell` command

We now need to change the default shell for user bandit26 in order to finally get out of that showtext hell.

</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 4 : Getting bash back</h3></summary>

We now know that we can run a shell, let's try to change the default shell to `/usr/bin/bash` in order to actually run a shell.
<details>
<summary>Hint</summary>

Using the [Vim Documentation Options](https://vimdoc.sourceforge.net/htmldoc/options.html), can you figure out how to view, then change, the 
shell we're using when running the `:shell` command?
</details>

<details>
<summary>Solution</summary>

The command we're looking for is `:set` which allows us to view/change settings for the options we specify.

By running `:set shell` we can view the shell we're using (which in our case outputs `/usr/bin/showtext`).

To change the shell, we just have to run `:set shell=/usr/bin/bash`, we can then run `:shell` and get a shell for the user bandit26.
</details>
</details>

<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. Minimize the window and ssh into bandit26 account to make the `more` utility scrollable.
2. Enter the `v` command to open the ViM text editor
3. `:set shell=/usr/bin/bash` in order to set the default shell to a real shell
4. `:shell` to open the bash shell for the user bandit26

</details>

You can now jump to the [next level](/bandit/bandit26.md)
