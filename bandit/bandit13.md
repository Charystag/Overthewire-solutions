# [Bandit13->14](https://overthewire.org/wargames/bandit/bandit14.html)

## Level Goal

## Commands useful to solve the level

-	[ssh](https://man7.org/linux/man-pages/man1/ssh.1.html)
- 	[scp](https://man7.org/linux/man-pages/man1/scp.1.html)
-	[ls](https://www.gnu.org/software/coreutils/manual/coreutils.html#ls-invocation)
-	[chmod](https://www.gnu.org/software/coreutils/manual/coreutils.html#chmod-invocation)
-	[stat](https://www.gnu.org/software/coreutils/manual/coreutils.html#stat-invocation)

## Helpful Reading Material

- [SSH keys](https://help.ubuntu.com/community/SSH/OpenSSH/Keys)
- [Secure Copy Protocol](https://en.wikipedia.org/wiki/Secure_copy_protocol)
- [Is using a public key to ssh any better than saving a password?](https://security.stackexchange.com/questions/3887/is-using-a-public-key-for-logging-in-to-ssh-any-better-than-saving-a-password) 
*security stackexchange discussion*
- [Password vs public key for authentication](https://crypto.stackexchange.com/questions/59120/password-vs-public-key-for-authentication) *cryptography stackexchange discussion*
- [File Permissions](https://www.gnu.org/software/coreutils/manual/html_node/File-permissions.html)

## Where to start?

First, we need to know what is in our directory. Here is the output from the `ls` command :
```bash
bandit13@bandit:~$ ls
sshkey.private
bandit13@bandit:~$
```
from now on we can already use that ssh key to connect to bandit14 user. However, we'll first retrieve the ssh key on our machine so that we can log into the user bandit14 without 
the need to be logged in as the user bandit13.


<details>
<summary><h3 style="display:inline-block">Part 1 : Retrieval of the ssh key</h3></summary>

To retrieve the ssh key using the ssh protocol, we're going to need the command that stands for **secure copy**, the `scp` command.


<details>
<summary>Hint</summary>

Reading the `scp` [man page](https://man7.org/linux/man-pages/man1/scp.1.html), can you figure out a way to retrieve the ssh key from the bandit13 user on the overthewire server?
</details>

<details>
<summary>Solution</summary>

We'll have to run the command while not connected to the remote server, as the scp protocol will connect to the remote server and retrieve the file for us.<br/>
From the scp man page, we know the following : "The **source** and **target** may be specified as a local pathname, a remote host with optional path in the form 
\[user@\]host:\[path\], or a URI in the form scp://\[user@\]host\[:port\]\[/path\]. 
Local file names can be made explicit using absolute or relative pathnames to avoid scp treating file names containing ‘:’ as host specifiers.". One precision to add is 
that the `path` argument is starting from the user's home directory.

Thus we can deduce the structure of the call we have to make :
- For the source, we will specify the URI as follows : `scp://bandit13@bandit.labs.overthewire.org:2220/sshkey.private`
- For the target, we will specify the local pathname we want to store the file in, let's say : `./bandit14_sshkey`

Thus, the command we're looking for is : `scp scp://bandit13@bandit.labs.overthewire.org:2220/home/bandit13/sshkey.private ./bandit14_sshkey`
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Setting the right file permissions</h3></summary>

Now that we have a private ssh key, we need to use it to connect other ssh. To do so, as it is a private ssh key, it must meet some requirements on the file permissions. Our 
goal is to set the right file permissions for us to be allowed to connect to the user bandit14.


<details>
<summary>Hint</summary>

By looking into the **FILES** section of the ssh [man page](https://www.gnu.org/software/coreutils/manual/html_node/File-permissions.html) and the chmod 
[gnu documentation page](https://www.gnu.org/software/coreutils/manual/coreutils.html#chmod-invocation), can you figure out the right file permissions for the private key and 
set them accordingly?
</details>

<details>
<summary>Solution</summary>

In the portion describing the file `~/.ssh/id_rsa`, we can read that this file should be readable by the user and should **not** be accessible by others.<br/>
Running the `stat` utility on the file gives us the file permissions of our ssh private key. Here is the output from this command :
```bash
Charystag@Charystag:~/Documents/Overthewire$ stat bandit14_sshkey 
  File: bandit14_sshkey
  Size: 1679      	Blocks: 8          IO Block: 4096   regular file
Device: 804h/2052d	Inode: 8913955     Links: 1
Access: (0640/-rw-r-----)  Uid: ( 1001/ Charystag)   Gid: ( 1001/ Charystag)
Access: 2024-06-03 21:05:42.285372019 +0200
Modify: 2024-06-03 21:05:11.765802230 +0200
Change: 2024-06-03 21:05:11.765802230 +0200
 Birth: 2024-06-03 21:05:11.733802682 +0200
Charystag@Charystag:~/Documents/Overthewire$
```
We can now see, (helping ourselves from the documentation about [file permissions](https://www.gnu.org/software/coreutils/manual/html_node/File-permissions.html)) that this file 
is readable and writable by the user and readable by the other members of the user's group. As we don't need to write data to the private key file, we can restrict the permissions 
to the minimum, we'll only allow the current user (us) to write to the file.<br/>
The following call to the `chmod` utility will allow us to achieve our goal : `chmod 400 bandit14_sshkey`
</details>
</details>

You can now jump to the [next level](/bandit/bandit14.md)
