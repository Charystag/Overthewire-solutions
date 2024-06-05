# [Bandit22->23](https://overthewire.org/wargames/bandit/bandit23.html)

## Level Goal

A program is running automatically at regular intervals from cron, the time-based job scheduler. 
Look in /etc/cron.d/ for the configuration and see what command is being executed.

NOTE: Looking at shell scripts written by other people is a very useful skill. 
The script for this level is intentionally made easy to read. 
If you are having problems understanding what it does, try executing it to see the debug information it prints.

## Commands useful to solve the level

- [whoami](https://www.gnu.org/software/coreutils/manual/coreutils.html#whoami-invocation)
- [md5sum](https://www.gnu.org/software/coreutils/manual/coreutils.html#md5sum-invocation)
- [cut](https://www.gnu.org/software/coreutils/manual/coreutils.html#cut-invocation)

## Helpful Reading Material

- [Command Substitution in bash](https://www.gnu.org/software/bash/manual/bash.html#Command-Substitution)
- [MD5 message-digest algorithm](https://en.wikipedia.org/wiki/MD5)

## Where to start?

To know how to retrieve the script for this level, you can refer to the [previous level](/bandit/bandit21.md). 
We will focus only on the script analysis for this challenge


<details>
<summary><h3 style="display:inline-block">Part 1 : Script analysis and password retrieval</h3></summary>

When we retrieve the script from the file `/usr/bin/cronjob_bandit23.sh`, we can see that it defines two variables 
and that it uses them to print the password for the next level into a file in the `/tmp` directory.

<details>
<summary>Hint</summary>

Using the useful commands, can you figure out what the script does and in which file it prints the password for the 
next level?
</details>

<details>
<summary>Solution</summary>

Let's analyse this script.

- The `myname` variable hold the output of the command `whoami`, which prints the username associated with the current 
user id. As this script is ran by bandit23, we know that the value of the myname variable is bandit23.
- The `mytarget` variable holds the output of the following pipeline (where `myname` has been replaced by its value) : 
`echo I am user bandit23 | md5sum | cut -d ' ' -f 1`.

The `md5sum` utility will hash the phrase it receives on standard input and output something following this format :
```bash
hashed_phrase filename
```
with hashed\_phrase and filename separated by a space (here filename is `-` because the file is standard input). 
Finally, the cut utility will retrieve only the first field (by splitting the fields using the space character), which 
is the hash of our phrase.

As standard input and standard error are redirected to [/dev/null](https://man7.org/linux/man-pages/man4/null.4.html), 
we won't see the output from the echo command, however we can notice that the password for bandit23 is printed in the file 
`/tmp/hashed_phrase`.

Thus, we know that by running the following command :
```bash
cat /etc/8ca319486bfbbc3663ea0fbe81326349
```
we can retrieve the password for the bandit23 user.
</details>
</details>

<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. `cat /etc/8ca319486bfbbc3663ea0fbe81326349` to retrieve the password for the next level

</details>

You can now jump to the [next level](/bandit/bandit23.md)
