# [Bandit23->24](https://overthewire.org/wargames/bandit/bandit24.html)

## Level Goal

A program is running automatically at regular intervals from cron, the time-based job scheduler. Look in /etc/cron.d/ 
for the configuration and see what command is being executed.

NOTE: This level requires you to create your own first shell-script. This is a very big step and you should be proud of yourself when you beat this level!

NOTE 2: Keep in mind that your shell script is removed once executed, so you may want to keep a copy around…

## Commands useful to solve the level

- [chmod](https://www.gnu.org/software/coreutils/manual/coreutils.html#chmod-invocation)
- [stat](https://www.gnu.org/software/coreutils/manual/coreutils.html#stat-invocation)
- [touch](https://www.gnu.org/software/coreutils/manual/coreutils.html#touch-invocation)
- [timeout](https://www.gnu.org/software/coreutils/manual/coreutils.html#timeout-invocation)

## Helpful Reading Material

- [File Permissions](https://www.gnu.org/software/coreutils/manual/html_node/File-permissions.html)
- [Filename Expansion](https://www.gnu.org/software/bash/manual/html_node/Filename-Expansion.html)
- [Looping Constructs](https://www.gnu.org/software/bash/manual/html_node/Looping-Constructs.html)
- [Conditional Constructs](https://www.gnu.org/software/bash/manual/html_node/Conditional-Constructs.html)
- [Shebang Unix](https://en.wikipedia.org/wiki/Shebang_\(Unix\))
- [Can a file that is executable be read](https://serverfault.com/questions/351672/can-a-file-that-is-executable-be-read) *ServerFault Discussion*
- [How does the #! shebang work ?](https://stackoverflow.com/questions/3009192/how-does-the-shebang-work) *StackOverflow Discussion*
- [Shell script working without shebang, why?](https://stackoverflow.com/questions/12296308/shell-script-working-fine-without-shebang-line-why) *StackOverflow Discussion*
- [Execute vs Read bit. How do directory permissions in Linux work](https://unix.stackexchange.com/questions/21251/execute-vs-read-bit-how-do-directory-permissions-in-linux-work) *UnixStackexchange Discussion*

## Where to start?

The goal of this level, is to have you write your first shell script (if you didn't write one before). Even though the shell scripts we're going to 
write in this level are pretty simple, I think it is a very good occasion to learn more about **File Permissions** so that after beating this level 
you'll understand deeply what they mean and how to set them properly.

> On a more personal note, even though I did a lot of bash scripting before, and thus thought that this level would be a piece of cake, it took 
> me 3 days to figure out the solution to that level. Not because I couldn't write a script but because I never cared that much about file permissions 
> so you can trust me, I'll set you on the right track for thinking about file permissions in a Linux environment.

For the script retrieval, as with the previous level, I'll let you see the [level 21](/bandit/bandit21) and then come back when the script is in front 
of your eyes.


<details>
<summary><h3 style="display:inline-block">Part 1 : Script analysis</h3></summary>

In this first part, we're going to analyse the script in order to know what it is about and how to use it to retrieve the password for the next level.

<details>
<summary>Hint</summary>

Using the useful commands and the helpful reading material, can you figure out what the script does?
</details>

<details>
<summary>Solution</summary>

We already know from the [previous level](/bandit/bandit22.md) that the script changes the directory to `/var/spool/bandit24/foo` as `bandit24` is the 
value contained in the `myname` variable.

The script then executes as follows :

1. for all the files and the hidden files in the directory, it executes a loop (see [Filename Expansion](https://www.gnu.org/software/bash/manual/html_node/Filename-Expansion.html) 
for more explanations about how the patterns are matched).
2. In this loop, if the filename is not '.' or '..', then it does the test that follows.
3. The call to the [stat](https://www.gnu.org/software/coreutils/manual/coreutils.html#stat-invocation) command only prints the username of the owner of the file. 
So if the owner is bandit23 (which is us), it runs the following command.
4. The call to the [timeout](https://www.gnu.org/software/coreutils/manual/coreutils.html#timeout-invocation) utility runs the script for **at most** 60 seconds and then 
sends a [SIGKILL](https://www.man7.org/linux/man-pages/man7/signal.7.html) signal to the script to ensure it stops.
5. Regardless of whether the script was executed or not, the script is removed, which means that the directory ends up being totally empty at the end of the cronjob execution.

</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Creating a basic script</h3></summary>

Now that we know what the program does, we understand that we just need to create a script and put it in the right folder (which is /var/spool/bandit24/foo) and if properly 
written it will give us the password for the bandit24 level.
<details>
<summary>Hint</summary>

Using the [previous level](/bandit/bandit22.md), can you design a simple script to print bandit24 password in a way we can retrieve it? Recall that all output is redirected to 
[/dev/null](https://man7.org/linux/man-pages/man4/null.4.html), which means you may have to create a file where bandit24 will be able to write the password to.
</details>

<details>
<summary>Solution</summary>

For this basic script, we'll copy the model of [bandit22](/bandit/bandit22). This means that we'll write a simple script that prints the password to a custom file. Here is 
the script we'll use :
```bash
#!/usr/bin/env bash

filename="$(echo Hello my fellow mates | md5sum | cut -d ' ' -f 1)"
cat /etc/bandit_pass/bandit24 > /tmp/${filename}
```
We're going to store this script in a file called `script` (but you can use any name you want) and copy this file to the right location, which is `/var/spool/bandit24/foo`. 
We will then run a for loop to check for the script presence in this folder (in order to know whether or not the script has executed and to see if it has done what we want)

1. First, we're going to go in a temporary directory (with `cd "$(mktemp -d /tmp/hello_fellow_mates.XXXXXXXXXX)"`) *Don't worry about the funny name template, I just though 
it was funnier that just using tmp everytime*
2. Then we are going to write our script to a file called `script`
3. Then we are going to run the following commands :
```bash
cp script /var/spool/bandit24/foo/script
echo -n Waiting for cronjob
while stat /var/spool/bandit24/foo/script >& /dev/null ; do echo -n . ; sleep 1 ; done 
echo -e '\n'cronjob executed
```
The last part allows us to monitor (using the `stat` command that returns true if it found the script at the specified location) the script and see when it is executed (thus 
meaning that we should expect an output).
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 3 : Setting the right file permissions</h3></summary>

Once the cronjob has executed, when we try to run `cat /tmp/"$(echo Hello my fellow mates | md5sum | cut -d ' ' -f 1)"`, we see the following output :
```bash
bandit23@bandit:/tmp/hello_fellow_mates.1JNCwI8su9$ cat /tmp/$(echo Hello my fellow mates | md5sum | cut -d ' ' -f 1)
cat: /tmp/af1eebe9db8a5242b192026716ddde8f: No such file or directory
bandit23@bandit:/tmp/hello_fellow_mates.1JNCwI8su9$
```

Wtf Chary, you told us that this script was working??

Well, bear with me because it is. The only thing we need is to give bandit24 the **permission** to execute it. Until now, it was not executing because bandit24 wasn't granted 
the rights to run the script, thus deleting it without even running it.
<details>
<summary>Hint</summary>

By reading the [File Permissions](https://www.gnu.org/software/coreutils/manual/html_node/File-permissions.html) section of the gnu coreutils documentation, can you 
figure out how to set the right file permissions for the script to actually execute?
</details>

<details>
<summary>Solution</summary>

Lets run a quick [stat](https://www.gnu.org/software/coreutils/manual/coreutils.html#stat-invocation) on our script file. We will run the following command :
```bash
stat -c '%A Uid: (%u/%U)  Gid: (%g/%G)' script
```
to print only the relevent information. Here is the output from that command :
```bash
-rw-rw-r-- Uid: (11023/bandit23)  Gid: (11023/bandit23)
```
This tells us no one is allowed to execute the script. As bandit24 is not in the group bandit 23 (see the [group](https://linux.die.net/man/5/group) man page for more informations about it). 
We can deduce that bandit24 belongs in the *others* category.

By running the following command :
```bash
chmod o+x script
```
We can allow the other users to execute the script, thus allowing bandit24 to execute the script. We can then run our precedent set of commands : 
```bash
cp script /var/spool/bandit24/foo/script
echo -n Waiting for cronjob
while stat /var/spool/bandit24/foo/script >& /dev/null ; do echo -n . ; sleep 1 ; done 
echo -e '\n'cronjob executed
```
And then, when we run `cat /tmp/"$(echo Hello my fellow mates | md5sum | cut -d ' ' -f 1)"`, we can see the password printed to stdout.
</details>
</details>

<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. `cd "$(mktemp -d)"` to change directory to a temporary directory
2. `echo -e "#!/usr/bin/env bash\ncat /etc/bandit_pass/bandit24 > /tmp/\"$(echo Hello my fellow mates | md5sum | cut -d ' ' -f 1)\" > script"` to create the script that we'll 
use to print the password in our dedicated file.
3. `chmod o+x script` to give bandit24 permission to execute the script
3. `cat /tmp/"$(echo Hello my fellow mates | md5sum | cut -d ' ' -f 1)"` to retrieve the password
</details>


<details>
<summary><h3 style="display:inline-block">Bonus : Creating a file inside the directory</h3></summary>

We learned how to create a file to store the password in, let's now go one step further and see if we can figure out how to create a script that creates a file containing 
the password within our temporary directory.
<details>
<summary>Hint</summary>

Using what we did before and the [Helpful Reading Material](#Helpful-Reading-Material), can you figure out a way to write a script that will be able to create a file in 
our temporary directory? You will have to make another call to chmod to get all the file permissions right.
</details>

<details>
<summary>Solution</summary>

Here is our script :
```bash
#!/usr/bin/env bash

cat /etc/bandit_pass/bandit24 > /tmp/hello_fellow_mates.1JNCwI8su9/bandit24_pass
```

Let's run a quick `stat`, but this time on our directory :
```bash
bandit23@bandit:/tmp/hello_fellow_mates.1JNCwI8su9$ stat -c '%A Uid: (%u/%U)  Gid: (%g/%G)' .
drwx------ Uid: (11023/bandit23)  Gid: (11023/bandit23)
bandit23@bandit:/tmp/hello_fellow_mates.1JNCwI8su9$
```
Here we can see that others don't have any right to write to the directory nor to access its files. Let's call `chmod` on our directory to set the right permissions :
```bash
chmod o+wx .
```
Then, by putting our script back into the `/var/spool/bandit24/foo` directory, we will see the file `bandit24_pass` created after the cronjob execution.
</details>
</details>

You can now jump to the [next level](/bandit/bandit24.md)
