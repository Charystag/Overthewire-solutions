# [Bandit1](https://overthewire.org/wargames/bandit/bandit2.html)

## Level Goal

The password for the next level is stored in a file called **-** located in the home directory

## Commands useful to solve the level

- cat

## Helpful Reading Material

- [Open a dashed filename](https://stackoverflow.com/questions/42187323/how-to-open-a-dashed-filename-using-terminal)
- `man cat`

## Where to start?

The solution to this challenge is actually written in the Reading Material. However, if you would like more explanations. 
You can open the Full Solution to the Challenge

<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

After listing the contents of the directory with `ls`, we can notice the following :

```bash
bandit1@bandit:~$ ls
-
bandit1@bandit:~$
```
This means that the file **-** is actually there. However, when we try print the contents of the file with `cat -` we get 
the following :

```bash
bandit1@bandit:~$ cat -

```
Where cat seems to wait for an input. By running `man cat`, we notice the following text in the Description section :<br/>
With no File, or when File is -, **read standard input**.<br/>
This tells us that cat doesn't interpret **-** as Filename but as a directive that tells it to read from standard input. 
It will echo everything you entered on standard input once you press the *ENTER* key. To tell cat that you're done writting 
to stdin, you can press ctrl+D (^D).<br/>
This is the reason why we need to run `cat ./-` thus specifying the relative path to the file and not only its name to cat

</details>

You can now jump to the [next level](/bandit/bandit2.md)
