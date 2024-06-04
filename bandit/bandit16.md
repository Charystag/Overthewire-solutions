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
</details>
</details>

<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

</details>

You can now jump to the [next level](/bandit/bandit17.md)
