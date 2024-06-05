# [Bandit20->21](https://overthewire.org/wargames/bandit/bandit21.html)

## Level Goal

There is a **setuid binary** in the homedirectory that does the following: it makes a connection to **localhost** on the port **you specify** 
as a commandline argument. It then reads a line of text from the connection and compares it to the password in the previous level (bandit20). 
If the password is correct, it will transmit the password for the next level (bandit21).

NOTE: Try connecting to your own network daemon to see if it works as you think

## Commands useful to solve the level

- [nc](https://linux.die.net/man/1/nc)
- [bash](https://www.gnu.org/software/bash/manual/bash.html)

## Helpful Reading Material

- [Bash Job Control](https://www.gnu.org/software/bash/manual/bash.html#Job-Control)
- [List of Commands](https://www.gnu.org/software/bash/manual/bash.html#Lists)
- [How to move a running process to background UNIX](https://stackoverflow.com/questions/46283647/how-to-move-a-running-process-to-background-unix) *StackOverflow Discussion*

## Where to start?

We can start this level by running the executable `su_connect` without any argument to try and get a better feel of what we should do with this program.

Here is the output from this command :
```bash
Usage: ./suconnect <portnumber>
This program will connect to the given port on localhost using TCP. If it receives the correct password from the other side, the next password is transmitted back.
```
What we can deduce at this moment is that the program `suconnect` is a TCP client, this means that we need to set up a server in order for our `suconnect` client to 
communicate with.


<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

</details>

You can now jump to the [next level](/bandit/bandit21.md)
