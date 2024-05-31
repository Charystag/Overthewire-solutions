# [Bandit0->1](https://overthewire.org/wargames/bandit/bandit1.html)

## Level Goal

The password for the next level is stored in a file called **readme** located in the home directory. Use this password to log into bandit1 using SSH. Whenever you find a password for a level, use SSH (on port 2220) to log into that level and continue the game.

## Commands useful to solve the level

- ls
- cat

## Helpful Reading Material

- [Home Directory](https://en.wikipedia.org/wiki/Home_directory)
- [What is a Home Directory](https://tecadmin.net/what-is-a-home-directory/)

## Where to start ?

We know that the password for the next level is stored in a file called **readme** which is located in the home directory. First thing to know is that when we log as a user we end up in the user home directory. That is how we know that we automatically begin in user **bandit0** home directory.


<details>
<summary><h3 style="display:inline-block">Part 1 : Listing Files</h3></summary>


<details>
<summary>Hint</summary>

Why don't you look into `man ls` to ensure that the file you're looking for is really there?

<blockquote>

:bulb: You can run : 
```bash
curl -fsSL --connect-timeout 10 https://raw.githubusercontent.com/Charystag/Scripts/main/colored_man.sh | bash -s ls
```
to print the same man page with syntaxical highlighting

</blockquote>
</details>

<details>
<summary>Solution</summary>

The command we are looking for is `ls`. This will allow us to list the directory files and ensure that the file we are looking for is there
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Printing File</h3></summary>


After running the command `ls`, you should get this output :

```bash
bandit0@bandit:~$ ls
readme
bandit0@bandit:~$
```

Now we need to know how to print the contents of the readme file
<details>
<summary>Hint</summary>

Same as before, we can run the command `man cat` to get to know the `cat` utility.


<blockquote>

:bulb: You can run : 
```bash
curl -fsSL --connect-timeout 10 https://raw.githubusercontent.com/Charystag/Scripts/main/colored_man.sh | bash -s cat
```
to print the same man page with syntaxical highlighting

</blockquote>
</details>

<details>
<summary>Solution</summary>

The command we're looking for is `cat readme`. It will allow us to retrieve the contents of the readme file.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

The command `cat readme` will output a prompt similar to this one

```bash
bandit0@bandit:~$ cat readme
password_string
bandit0@bandit:~$
```

Where password\_string is a 33 alphanumeric characters password string.<br/>

We can then copy this string with ctrl+shift+c and paste it with ctrl+shift+v

</details>

You can now jump to the [next level](/bandit/bandit1.md) 
