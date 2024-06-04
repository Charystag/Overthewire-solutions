# [Bandit15->16](https://overthewire.org/wargames/bandit/bandit16.html)

## Level Goal

The password for the next level can be retrieved by submitting the password of the current level to **port 30001** on **localhost** using **SSL encryption**.

Helpful note: Getting “HEARTBEATING” and “Read R BLOCK”? Use -ign\_eof and read the “**CONNECTED COMMANDS**” section in the manpage. 
Next to ‘R’ and ‘Q’, the ‘B’ command also works in this version of that command…

## Commands useful to solve the level

- [s\_client](https://www.openssl.org/docs/man1.0.2/man1/s_client.html)

## Helpful Reading Material

- [OpenSSL Cookbook](https://www.feistyduck.com/library/openssl-cookbook/online/)
- [OpenSSL Wikipedia Page](https://en.wikipedia.org/wiki/OpenSSL)
- [Transport Layer Security](https://en.wikipedia.org/wiki/Transport_Layer_Security)

## Where to start?

For the network analysis and password retrieval, you can go to the [previous challenge](/bandit/bandit14.md). In this challenge 
I'm only going to show how to use the `s_client` command from the `openssl` program to efficiently 
communicate with our server.


<details>
<summary><h3 style="display:inline-block">Part 1 : Communicating with the SSL server</h3></summary>

Our first goal is to lean how to open a connection with our SSL server, to do so we are going to use the [s\_client](https://www.openssl.org/docs/man1.0.2/man1/s_client.html) command.


<details>
<summary>Hint</summary>

By looking at the [s\_client](https://www.openssl.org/docs/man1.0.2/man1/s_client.html) man page and only looking for the fields that talk about **connecting** to the SSL server, 
can you figure out a way to open a connection with the server? *The server will read all its input from stdin*
</details>

<details>
<summary>Solution</summary>

By running the command `openssl s_client localhost:30001` or `openssl s_client -connect localhost:30001`, you can open a connection with the server.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Sending the password to the server using the client</h3></summary>

Now that we've opened a connection to the server, we want to send the password. We could copy and paste the password, press enter and then ^C the client 
and it would actually work but this is not what we are going to do here.

As the password is contained within the file `/etc/bandit_pass/bandit15`, it would be way easier to just redirect the input from that file. However, when we 
do it like this, no password appears on the standard output. Our goal is to fix that issue.


<details>
<summary>Hint</summary>

By looking at the **CONNECTED COMMANDS** section of the [s\_client](https://www.openssl.org/docs/man1.0.2/man1/s_client.html) man page, try to understand why we can 
observe such a behavior and then, look at the **OPTIONS** section to see if you can retrieve an option that will fix this behavior.
</details>

<details>
<summary>Solution</summary>

We can observe such behavior because at the end of any file, there is an EOF character that is interpreted by our `s_client` command as a signal to close the connection. 
By using the option `-ign_eof` we can explicitely tell `s_client` to keep the connection open, and thus receive the password from the server.<br/>
Here is our final command :
```bash
openssl s_client -ign_eof localhost:30001 < /etc/bandit_pass/bandit15
```
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. `openssl s_client -quiet localhost:30001 < /etc/bandit_pass/bandit15` to retrieve the password from the SSL server
</details>

You can now jump to the [next level](/bandit/bandit16.md)
