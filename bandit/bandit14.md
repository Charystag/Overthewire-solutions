# [Bandit14->15](https://overthewire.org/wargames/bandit/bandit15.html)

## Level Goal

The password for the next level can be retrieved by submitting the **password** of the current level to **port 30000** on **localhost**.

## Commands useful to solve the level

- [nc](https://linux.die.net/man/1/nc)
- [nmap](https://nmap.org/book/man.html)

## Helpful Reading Material

- [Netcat](https://en.wikipedia.org/wiki/Netcat)
- [Nmap](https://en.wikipedia.org/wiki/Nmap)
- [Port Computing](https://en.wikipedia.org/wiki/Port_\(computer_networking\))
- [Localhost](https://en.wikipedia.org/wiki/Localhost)
- [Ip address](https://computer.howstuffworks.com/web-server5.htm)
- [Ip address Wikipedia](https://en.wikipedia.org/wiki/IP_address)
- [Ip address basics](https://whatismyipaddress.com/ip-basics)

## Where to start?

We have to start by reading a lot of documentation, to understand a bit more what we have to do and what we're talking about. 
First things first, before even trying to send the password, we need to retrieve it first.


<details>
<summary><h3 style="display:inline-block">Part 1 : Password retrieval</h3></summary>

We need to retrieve the password by finding in which file it is stored, the information for the password file is actually displayed 
at the beginning of each level, when we connect to the user we're accessing over ssh.


<details>
<summary>Hint</summary>

By using the prompt we get when logging in to bandit14 (or any other overthewire user), can you figure out where is the password for 
bandit14 stored?
</details>

<details>
<summary>Solution</summary>

Let's start by recalling the instructions for each level :
```bash

  This machine might hold several wargames.
  If you are playing "somegame", then:

    * USERNAMES are somegame0, somegame1, ...
    * Most LEVELS are stored in /somegame/.
    * PASSWORDS for each level are stored in /etc/somegame_pass/.

```
This tells us that the password we're looking for is in the file `/etc/bandit_pass/bandit14`. Let's run a quick `stat` on this file 
to ensure we can read it. Here is the output from this command :
```bash
  File: /etc/bandit_pass/bandit14
  Size: 33        	Blocks: 8          IO Block: 4096   regular file
Device: 10301h/66305d	Inode: 517564      Links: 1
Access: (0400/-r--------)  Uid: (11014/bandit14)   Gid: (11014/bandit14)
Access: 2024-06-03 22:30:53.614318247 +0000
Modify: 2023-10-05 06:19:04.167222286 +0000
Change: 2023-10-05 06:19:04.167222286 +0000
 Birth: 2023-10-05 06:19:04.167222286 +0000
```
As we're logged in as user `bandit14`, we know we can access this file which contains the 33 bytes password string we need to complete 
this level.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Port scanning</h3></summary>

We know that there is a service listening on port **30000**, let's start by scanning the port 30000 to get a better idea of how to communicate with the 
service listening on port 30000.


<details>
<summary>Hint</summary>

Using only the [description section](https://nmap.org/book/man.html) of the nmap man page, can you figure out how to scan the localhost network in order 
to see which ports are in use?
</details>

<details>
<summary>Solution</summary>

The command we're looking for is `nmap localhost`, which will allow us to scan the network at 127.0.0.1. Here is the output from this command :
```bash
bandit14@bandit:~$ nmap localhost
Starting Nmap 7.80 ( https://nmap.org ) at 2024-06-04 10:17 UTC
Nmap scan report for localhost (127.0.0.1)
Host is up (0.00022s latency).
Not shown: 993 closed ports
PORT      STATE SERVICE
22/tcp    open  ssh
1111/tcp  open  lmsocialserver
1122/tcp  open  availant-mgr
1840/tcp  open  netopia-vo2
4321/tcp  open  rwhois
8000/tcp  open  http-alt
30000/tcp open  ndmps

Nmap done: 1 IP address (1 host up) scanned in 0.11 seconds
bandit14@bandit:~$
```
We can see that the port **30000** is open and accepts tcp connections. This tells us that we need to send the password using the tcp protocol.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 3 : Password sending</h3></summary>

Now that we know that we need to send the password using the tcp protocol, we need a tool that is able to do that for us. Here is when the `nc` tool comes in handy.

<details>
<summary>Hint</summary>

By using the **TALKING TO SERVERS** section of the `nc(1)` [man page](https://linux.die.net/man/1/nc), can you figure out how to send the password to the server?
</details>

<details>
<summary>Solution</summary>

`nc` will have to read the password from stdin to send it to the server, there are a few ways to do so but one command you could run is the following :
```bash
nc localhost 30000 < /etc/bandit_pass/bandit14
```
which redirects stdin from the file containing the pasword for user bandit 14. Once this is done, you should see the following output :
```bash
bandit14@bandit:~$ nc localhost 30000 < /etc/bandit_pass/bandit14
Correct!
password_string

bandit14@bandit:~$
```
where pasword\_string is our 33 bytes characters password string.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. `cat /etc/bandit_pass/bandit14 | nc localhost 30000` to send the password to the service listening at localhost:30000.
</details>

You can now jump to the [next level](/bandit/bandit15.md)
