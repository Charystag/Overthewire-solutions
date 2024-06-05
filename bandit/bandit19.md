# [Bandit19->20](https://overthewire.org/wargames/bandit/bandit20.html)

## Level Goal

To gain access to the next level, you should use the **setuid binary** in the homedirectory. 
Execute it without arguments to find out how to use it. 
The password for this level can be found in the usual place (/etc/bandit\_pass), after you have used the setuid binary.

## Commands useful to solve the level

- [cat](https://www.gnu.org/software/coreutils/manual/coreutils.html#cat-invocation)

## Helpful Reading Material

- [setuid on wikipedia](https://en.wikipedia.org/wiki/Setuid)
- [setUID and getUID bits](https://www.gnu.org/software/coreutils/manual/html_node/Directory-Setuid-and-Setgid.html)
- [Difference between euid and uid](https://stackoverflow.com/questions/27669950/difference-between-euid-and-uid) *StackOverflow Discussion*

## Where to start?

The only thing we have in our directory is an executable called `bandit20-do`, the instructions for this level tell us that we should 
execute it without arguments to find out how to use it.


<details>
<summary><h3 style="display:inline-block">Part 1 : Using the setuid binary</h3></summary>

When running the executable without arguments, we see the following : 
```bash
Run a command as another user.
  Example: ./bandit20-do id
```
We need to find out how to use this executable to print the password for the next level on stdout.

<details>
<summary>Hint</summary>

Using the example of the `bandit20-do` executable, can you figure out the command to execute to print the bandit20 password to stdout?
</details>

<details>
<summary>Solution</summary>

When running the example, we can see the following output : 
```bash
bandit19@bandit:~$ ./bandit20-do id
uid=11019(bandit19) gid=11019(bandit19) euid=11020(bandit20) groups=11019(bandit19)
bandit19@bandit:~$
```
We can see that our effective user id (euid) is bandit20 when we run this executable, which means that we can do everything that the user 
bandit20 can do.

By running the [stat](https://www.gnu.org/software/coreutils/manual/coreutils.html#stat-invocation) command on the file `/etc/bandit_pass/bandit20` 
we see the following output :
```bash
  File: /etc/bandit_pass/bandit20
  Size: 33        	Blocks: 8          IO Block: 4096   regular file
Device: 10301h/66305d	Inode: 517599      Links: 1
Access: (0400/-r--------)  Uid: (11020/bandit20)   Gid: (11020/bandit20)
Access: 2024-06-04 21:38:04.747961484 +0000
Modify: 2023-10-05 06:19:06.591227890 +0000
Change: 2023-10-05 06:19:06.595227900 +0000
 Birth: 2023-10-05 06:19:06.591227890 +0000
```
This tells us that the file is only readable by the user bandit20, however thanks to the `bandit20-do` executable, we are the user bandit20. We can 
thus `cat` this file and retrieve the password string.<br/>
Here is the final command :
```bash
./bandit20-do cat /etc/bandit_pass/bandit20
```
</details>
</details>

<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1.	`./bandit20-do cat /etc/bandit_pass/bandit20` to print the password string on stdout.
</details>

You can now jump to the [next level](/bandit/bandit20.md)
