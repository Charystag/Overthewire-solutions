# [Bandit0](https://overthewire.org/wargames/bandit/bandit0.html)

## Level Goal

The goal of this level is for you to log into the game using **SSH**. <br/>
The host to which you need to connect is **bandit.labs.overthewire.org**, on port **2220**. <br/>
The username is **bandit0** and the password is **bandit0**.

## Commands useful to solve the level

- ssh(1)

## Helpful Reading Material

- [Secure Shell](https://en.wikipedia.org/wiki/Secure_Shell)
- man ssh

## Where to start?

We know that we need to use ssh to log into the game and already know that there is only one command that may be useful to solve the challenge. After reading about what is the secure shell on wikipedia, let's dive right into it and run the following command : `man ssh`

> :bulb: You can run
<blockquote>

```bash
curl -fsSL --connect-timeout 10 https://raw.githubusercontent.com/Charystag/Scripts/main/colored_man.sh | bash -s ssh
```
To get the same man page with the colors enabled
</blockquote>

<details>
<summary><h3 style="display:inline-block">Part 1 : Host Specification</h3></summary>


<details>
<summary>Hint</summary>

Look in the ssh man page, in the <b style="color:red">DESCRIPTION</b> section, right after the <b style="color:red">SYNOPSIS</b> there should be, near the beginning, the name of an item that could already be found in the <b style="color:red">SYNOPSIS</b> section
</details>

<details>
<summary>Solution</summary>

The argument we are looking for is the one name **destination** this argument is the **host** we are trying to connect to. <br/>
For now, our command looks like : `ssh bandit.labs.overthewire.org`
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Port Specification</h3></summary>

After running this command, we can see the following prompt in the terminal :

```bash

                      This is an OverTheWire game server. 
            More information on http://www.overthewire.org/wargames

!!! You are trying to log into this SSH server on port 22, which is not intended.

Charystag@bandit.labs.overthewire.org: Permission denied (publickey).

```

So we need to use the **port** that was specified in the challenge rules

<details>
<summary>Hint</summary>

Try to look again in the **SYNOPSIS** and **DESCRIPTION** sections of the ssh man page and see if you can manage to find how to specify a port to connect to the remote host
</details>

<details>
<summary>Solution</summary>

Using the `-p` option allows us to specify a port to connect to. Our updated command ends up looking like this : `ssh -p 2220 bandit.labs.overthewire.org`

> :bulb: Beware that the option parameters have to be before any non-option parameters

</details>
</details>
