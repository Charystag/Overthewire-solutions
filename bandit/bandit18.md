# [Bandit18->19](https://overthewire.org/wargames/bandit/bandit19.html)

## Level Goal

The password for the next level is stored in a file **readme** in the homedirectory. 
Unfortunately, someone has modified **.bashrc** to log you out when you log in with SSH.

## Commands useful to solve the level

- [ssh](https://linux.die.net/man/1/ssh)
- [cat](https://www.gnu.org/software/coreutils/manual/coreutils.html#cat-invocation)

## Helpful Reading Material

- [What is the purpose of .bashrc](https://unix.stackexchange.com/questions/129143/what-is-the-purpose-of-bashrc-and-how-does-it-work) *Unix StackExchange discussion*
- [Bash invocation](https://www.gnu.org/software/bash/manual/bash.html#Invoking-Bash)
- [Difference between login shell and non-login shell](https://unix.stackexchange.com/questions/38175/difference-between-login-shell-and-non-login-shell) *Unix StackExchange discussion*

## Where to start?

We know that someone has modified our `.bashrc` file in order to log us out when we log in using SSH. The `.bashrc` file is a file where commands are read from when bash 
is invoked as an interactive shell that is not a login shell (see [bash invocation](https://www.gnu.org/software/bash/manual/bash.html#Invoking-Bash) for more informations).
What we are going to do is to find out how to retrieve the `readme` file from bandit18 home directory.


<details>
<summary><h3 style="display:inline-block">Part 1 : Running a command on the remote host</h3></summary>

As we are anyway login in using the ssh protocol, we need to find a way to run a command non-interactively on the remote host.
<details>
<summary>Hint</summary>

Once again, look into the [ssh](https://linux.die.net/man/1/ssh) man page, find a way to execute a command on the remote host instead of an interactive shell.
</details>

<details>
<summary>Solution</summary>

To do so, we just need to append the command we want to run at the end of our ssh command, it will then be run instead of an interactive shell when we log in 
into the user bandit18. Our ssh command is the following :
```bash
ssh -l bandit18 -p 2220 bandit.labs.overthewire.org cat readme
```
Because we need to `cat` the readme file in bandit18 home directory. It will print the password string to sdout and exit.
</details>
</details>

<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. `ssh ssh://bandit18@bandit.labs.overthewire.org:2220 cat readme` to cat the readme file in bandit18 home directory.

</details>

You can now jump to the [next level](/bandit/bandit19.md)
