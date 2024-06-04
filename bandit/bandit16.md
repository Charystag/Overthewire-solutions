# [Bandit16->17](https://overthewire.org/wargames/bandit/bandit17.html)

## Level Goal
The credentials for the next level can be retrieved by submitting the password of the current level to a port on localhost in the range **31000 to 32000**. 
First find out which of these ports have a server listening on them. Then find out which of those speak SSL and which don’t. 
There is only **1 server** that will give the next credentials, the others will simply send back to you whatever you send to it.

## Commands useful to solve the level

- [nmap](https://nmap.org/book/man.html)
- [nc](https://linux.die.net/man/1/nc) *Optionnal*

## Helpful Reading Material

- [Port Scanner](https://en.wikipedia.org/wiki/Port_scanner)
- [Nmap commands](https://www.varonis.com/blog/nmap-commands)

## Where to start?

What we need to do here is to find a way to scan the network so we know on which port the server we need to talk to resides. First, let's 
scan the network between the port 31000 and 32000. To do so, we can use two utilities, `nmap` and `nc`


<details>
<summary><h3 style="display:inline-block">Part 1 : Basic Port Scanning with nc</h3></summary>


<details>
<summary>Hint</summary>

By lookint at the **PORT SCANNING** section of the [nc](https://linux.die.net/man/1/nc) man page, can you figure out a way to perform a 
basic scan of the ports between 31000 and 32000 with `nc`?
</details>

<details>
<summary>Solution</summary>

With `nc`, we can use the following command : 
```bash
nc -zv localhost 31000-32000 |& grep -v -E '^nc'
```
Let's break down how it works : 

1. `nc -zv localhost 31000-32000` tells nc to report the open ports between the port 31000 and 32000, writing verbose output to stderr
2. `|&` is a metacharacter that is equivalent to `2 >& 1 |` which means to redirect stdout and stderr through a pipe (see [pipelines](https://www.gnu.org/software/bash/manual/bash.html#Pipelines) 
in the gnu bash manual for more information)
3. `grep -v -E '^nc'` uses the [regular expression](https://man7.org/linux/man-pages/man7/regex.7.html) `^nc` to mach lines beginning by 'nc' and the `-v` option uses the inverted match to match 
only the lines that don't begin with nc (meaning the only lines that didn't report an error).

Here is the output from this command :
```bash
bandit16@bandit:~$ nc -zv localhost 31000-32000 |& grep -v -E '^nc'
Connection to localhost (127.0.0.1) 31046 port [tcp/*] succeeded!
Connection to localhost (127.0.0.1) 31518 port [tcp/*] succeeded!
Connection to localhost (127.0.0.1) 31691 port [tcp/*] succeeded!
Connection to localhost (127.0.0.1) 31790 port [tcp/*] succeeded!
Connection to localhost (127.0.0.1) 31960 port [tcp/*] succeeded!
bandit16@bandit:~$
```
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Basic Port Scanning with nmap</h3></summary>

<details>
<summary>Hint</summary>

By using the **PORT SPECIFICATION AND SCAN ORDER** section of the [nmap](https://linux.die.net/man/1/nmap) man page, can 
you figure out a way to perform a basic scan of the ports between 31000 and 32000 with `nmap`?
</details>

<details>
<summary>Solution</summary>

With `nmap`, it is even more simple. We just need to provide the range of ports to scan as nmap is already a port scanner.

Here is the command we're looking for :
```bash
nmap localhost -p 31000-32000
```
Here is the output from this command :
```bash
Starting Nmap 7.80 ( https://nmap.org ) at 2024-06-04 14:27 UTC
Nmap scan report for localhost (127.0.0.1)
Host is up (0.00013s latency).
Not shown: 996 closed ports
PORT      STATE SERVICE
31046/tcp open  unknown
31518/tcp open  unknown
31691/tcp open  unknown
31790/tcp open  unknown
31960/tcp open  unknown

Nmap done: 1 IP address (1 host up) scanned in 0.05 seconds
```
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 3 : Service detection with nmap</h3></summary>

Now that we have a little more info about the open ports, we can now run a more advance scan using `nmap` on the open ports we found.

<details>
<summary>Hint</summary>

By taking a look at the **SERVICE AND VERSION DETECTION** section of the [nmap](https://linux.die.net/man/1/nmap) man page, can you figure out 
how to know on which port resides the service we want to communicate with ?
</details>

<details>
<summary>Solution</summary>

The `-sV` option is the option we're looking for, it will allow us to identify the service that lies on each port that we're scanning. 
As the scan doesn't need to be full (as 4 out of 5 of these services will echo back to the sender all the information they receive), we will 
enable the option `--version-light` so that the scan takes less time.

The command we're looking for is the following :
```bash
nmap -sV --version-light -p 31046,31518,31691,31790,31960 localhost
```
We could of course, also run this command on the whole set of ports between the range 31000 and 32000 with `nmap -sV --version-light -p 31000-32000`.

Here is the output from this command (`--version-light` is an alias for `--version-intensity 2`):
```bash
bandit16@bandit:~$ nmap -sV --version-intensity 2 localhost -p 31046,31518,31691,31790,31960
Starting Nmap 7.80 ( https://nmap.org ) at 2024-06-04 14:38 UTC
Nmap scan report for localhost (127.0.0.1)
Host is up (0.00013s latency).

PORT      STATE SERVICE     VERSION
31046/tcp open  echo
31518/tcp open  ssl/echo
31691/tcp open  echo
31790/tcp open  ssl/unknown
31960/tcp open  echo
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
SF-Port31790-TCP:V=7.80%T=SSL%I=2%D=6/4%Time=665F2708%P=x86_64-pc-linux-gn
SF:u%r(GenericLines,31,"Wrong!\x20Please\x20enter\x20the\x20correct\x20cur
SF:rent\x20password\n")%r(GetRequest,31,"Wrong!\x20Please\x20enter\x20the\
SF:x20correct\x20current\x20password\n")%r(SSLSessionReq,31,"Wrong!\x20Ple
SF:ase\x20enter\x20the\x20correct\x20current\x20password\n")%r(TLSSessionR
SF:eq,31,"Wrong!\x20Please\x20enter\x20the\x20correct\x20current\x20passwo
SF:rd\n");

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 32.61 seconds
bandit16@bandit:~$
```
We know now that we can use the `s_client` command to send the password to the server listening at 31790 and retrieve the ssh key to connect to bandit 17.
</details>
</details>

<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. `nmap -sV --version-light -p 31000-32000` to retrieve the server that is listening for our password
2. `openssl s_client -ign_eof localhost:31790 < /etc/bandit_pass/bandit16` to retrieve the private ssh key needed to connect to bandit 17.
</details>

You can now jump to the [next level](/bandit/bandit17.md)
