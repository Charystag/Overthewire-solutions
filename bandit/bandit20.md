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
<summary><h3 style="display:inline-block">Part 1 : Setting up a TCP server that sends the password</h3></summary>

The first part of this challenge is to set up a TCP server that we will use to send the password to any host that would be trying to connect.

<details>
<summary>Hint</summary>

Using the **CLIENT/SERVER MODEL** of the [nc](https://linux.die.net/man/1/nc) command, can you figure out a way to set up a server that will 
listen for incoming connections and send the password to any client that listens to it?
</details>

<details>
<summary>Solution</summary>

Let's copy the exact same code from the `nc` man page example. Here is the command we're going to use :
```bash
nc -l 1234
```
We can now notice that we have an open TCP server that listens for incoming connections. However our server is pretty basic (as it does absolutely nothing), however 
it can communicate through its standard input and output. Let's try to redirect the standard input of the server from a file.

By running the following command :
```bash
nc -l 1234 < /etc/bandit_pass/bandit20
```
We have a server listening on the port 1234 that will send the password for bandit20 to any host that tries to connect ot it.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Running the TCP server as a background process</h3></summary>

After running our command, we can notice that the TCP server is waiting and that we won't have any access to our terminal while the server is still 
running. Our goal here is to find a way to keep the server open and to communicate with it using the same terminal session.
<details>
<summary>Hint</summary>

By using the [Helpful Reading Material](#Helpful-Reading-Material), can you figure out a way to run our server as a background process so that you can 
continue communicating with the server using your current terminal session?
</details>

<details>
<summary>Solution</summary>

To continue communicating with the server using the current terminal session, we need to launch it asynchronously, this means that the exit status of our command 
will be 0 and that `bash` won't wait for the completion of your command to give us back the control of our terminal session.

Here is the command we're going to execute.
```bash
nc -l 1234 < /etc/bandit_pass/bandit20 &
```
It will tell bash to run this process as a background process, which will allow us to run our TCP client to retrieve the password for the next level.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 3 : Communicating with our server</h3></summary>

Now that we have a server running and listening on the port 1234, we can use our executable to communicate with it. This part is pretty straightforward so there 
won't be any Hint.

<details>
<summary>Solution</summary>

We just need to run the executable `suconnect` and to specify it the right port number.

Here is the output from that command :
```bash
bandit20@bandit:~$ ./suconnect 1234
Read: bandit20_pass
Password matches, sending next password
bandit21_pass
[1]+  Done                    nc -l 1234 < /etc/bandit_pass/bandit20
bandit20@bandit:~$
```
You can see that on the last line, bash reports that the our server in the background has returned as it closes after receiving one connection.
</details>
</details>

<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1.	`nc -l port_number < /etc/bandit_pass/bandit20 &` to run a server listing on **port_number** in the background.
2.	`./suconnect port_number` to retrieve the password for the next level.

</details>

You can now jump to the [next level](/bandit/bandit21.md)
