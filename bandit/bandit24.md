# [Bandit24->25](https://overthewire.org/wargames/bandit/bandit25.html)

## Level Goal

A daemon is listening on port 30002 and will give you the password for bandit25 if given the password for bandit24 and a secret numeric **4-digit pincode**. There is no way to retrieve the pincode except by going through **all** of the **10000 combinations**, called **brute-forcing**.<br/>
**You do not need to create new connections each time**

## Commands useful to solve the level

- [nc](https://www.commandlinux.com/man-page/man1/nc.1.html)

## Helpful Reading Material

- [Brute force attack](https://en.wikipedia.org/wiki/Brute-force_attack)
- [Brace Expansion](https://www.gnu.org/software/bash/manual/bash.html#Brace-Expansion)
- [Looping Constructs](https://www.gnu.org/software/bash/manual/bash.html#Looping-Constructs)

## Where to start?

We already know that there is a daemon listening on port 30002 which listens for our password. The goal here is to find an efficient way to brute-force the password for the next level.

<details>
<summary><h3 style="display:inline-block">Part 1 : Getting to know the daemon</h3></summary>

This part will be pretty short as we already have experience with daemons (see [bandit14](/bandit/bandit14.md) for more explanations). We will simply connect and try to communicate 
with the daemon to see how we should speak with it.
<details>
<summary>Hint</summary>

By using the `nc` utility, can you figure out the format of the string you should send the daemon in order to craft your brute-force attack?
</details>

<details>
<summary>Solution</summary>

Using nc, we can speak with the daemon and run the following tests :
```bash
bandit24@bandit:/tmp/abcdef.PtK5$ nc localhost 30002
I am the pincode checker for user bandit25. Please enter the password for user bandit24 and the secret pincode on a single line, separated by a space.
bandit24_password 0000
Wrong! Please enter the correct pincode. Try again.
bandit24_pasword 0001
Wrong! Please enter the correct pincode. Try again.
^C
bandit24@bandit:/tmp/abcdef.PtK5$ 
```
Using that information, we know the format of the string we're supposed to send to the daemon to try to bruteforce the password. Let's know try and use this 
knowledge to craft our brute-force attack.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Crafting the attack</h3></summary>

Now that we know how to communicate with the server and that we noticed that indeed, we don't have to open a new connection for each message, let's try to generate all the 
password/pincode combinations for our brute-force attack.

<details>
<summary>Hint</summary>

Using the [Brace Expansion](https://www.gnu.org/software/bash/manual/bash.html#Brace-Expansion) and the 
[Looping Constructs](https://www.gnu.org/software/bash/manual/bash.html#Looping-Constructs) sections of the gnu bash manual, can you figure out a way to generate all the combinations for 
our attack?
</details>

<details>
<summary>Solution</summary>

Let's create our file containing the 10000 combinations

With these to files at hand, we craft our bruteforce attack.
</details>
</details>

<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

</details>

You can now jump to the [next level](/bandit/bandit25.md)
