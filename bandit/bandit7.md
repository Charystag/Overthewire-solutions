# [Bandit7->8](https://overthewire.org/wargames/bandit/bandit8.html)

## Level Goal

The password for the next level is stored in the file **data.txt** next to the word **millionth**.

## Commands useful to solve the level

- `grep`
- `file` *optionnal*
- `head` *optionnal*
- `wc` *optionnal*
- `cut` *optionnal*

## Helpful Reading Material

- [Grep Wikipedia Page](https://en.wikipedia.org/wiki/Grep)
- [Cut Wikipedia Page](https://en.wikipedia.org/wiki/Cut_\(Unix\))

## Where to start?

This Level is actually pretty easy and straightforward. We'll start by analysing the file and then we'll 
look for the command we need to complete our goal.

<details>
<summary><h3 style="display:inline-block">Part 1 : File Analysis</h3></summary>

Let's first run the `file` utility on our **data.txt** file to know the type of content we have to deal with 
and to ensure that the file is not a malicious file that an attacker may have put in the directory to our intention.<br/>
Here is the output from the `file` command :
```bash
bandit7@bandit:~$ file data.txt 
data.txt: Unicode text, UTF-8 text
bandit7@bandit:~$
```

Now that we know that it is safe to run `cat` or any other utility that operates on **text** files on **data.txt**, let's try to run the 
[head](https://man7.org/linux/man-pages/man1/head.1.html) utility on this file.

> Note : The `head` utility allows us to print only the few first lines (10 by default) of a file.

Here is the output from the `head` utility :
```bash
bandit7@bandit:~$ head data.txt
gallop	hu3ZhCrGRvfaO5jsY6ttvApzVCA2Hjvs
Aurelia's	ikl4F3cK5m6Cl6HAxva6zUAVJhI2Cvc6
stoicism	JiW9ts44udf20bJHe8H5dS1c99Muwz42
embodies	vWheZcAsQHZNnerI3ViW8wqOKIx0kbgR
Plato	dW2U8E5FfuAvNLdGDupP8GAxr922ZV0x
cultivation	A90E75jvWbEKrijFxM4GxqHEw8c8U2Bf
stable	omR4PHolFwbI0IEJsanveA21yWvFy8a7
bedspread	VlBFxuEDi3phEpljbKbahRJvJxfh3k9M
oppressing	hQTiEm5XF3cUQSEiBjh7sekemLOKBrcJ
darnedest	9O2zdCLKVoW5u34P9T7EKTZXcMRE6xh5
bandit7@bandit:~$ 
```

Now we can get a better feel of how our file is built. We can run a last test on the file in order to get an idea of how many data we'll have to search 
in order to retrieve the information we're looking for.<br/>
Let's try to run the [wc](https://man7.org/linux/man-pages/man1/wc.1.html) utility on the file to count how many lines there are in it. We'll give it the `-l` 
option to ensure that only the line count gets printed.<br/>

Here is the output from the `wc` utility :
```bash
bandit7@bandit:~$ wc -l data.txt 
98567 data.txt
bandit7@bandit:~$
```

We now know that there are close to 100k lines in the data.txt file. This analysis is not always useful but it can give valuable insight. Let's now move on 
to the actual challenge, the password retrieval
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Password retrieval</h3></summary>

After learning more about the file structure, we can get a feel of which command will be useful to retrieve our password string. Let's take a look at the 
`grep` utility to know if we can use it to retrieve our password.<br>


<details>
<summary>Hint</summary>

Looking into the [grep man page](https://www.gnu.org/software/grep/manual/grep.html), figure out how we can retrieve any line containing the word **millionth** 
in the file **data.txt**
</details>

<details>
<summary>Solution</summary>

By running the command `grep millionth data.txt` we can retrieve any line containing the word millionth in the file `data.txt`. The password string will be the 
second column of that file
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. `grep millionth data.txt` to retrieve the only line containing the world millionth which also contains the password string, we can now copy and paste this 
password to go to the next level
</details>


<details>
<summary><h3 style="display:inline-block">Bonus : Cutting the output</h3></summary>

Once we ran grep on our file, we get the following output : 
```bash
bandit7@bandit:~$ grep millionth data.txt
millionth	password_string
bandit7@bandit:~$
```

We can now use the `cut(1)` utility to split the line we got into fields and only retrieve 
the field we need.


<details>
<summary>Hint</summary>

To know how to properly use the `cut` utility, look into the [cut](https://www.gnu.org/software/coreutils/manual/coreutils.html#cut-invocation) documentation page.
</details>

<details>
<summary>Solution</summary>

By running the line we got through a pipe and transferring its data to `cut` we can retrieve only the second field.<br/>
Here is the full command :
```bash
grep millionth data.txt | cut -f 2
```
</details>
</details>

You can now jump to the [next level](/bandit/bandit8.md)
