# [Bandit9->10](https://overthewire.org/wargames/bandit/bandit10.html)

## Level Goal

The password for the next level is stored in the file **data.txt** in one of the few **human-readable** strings, preceded by several ‘=’ characters.

## Commands useful to solve the level

- [file](https://linux.die.net/man/1/file)
- [strings](https://man7.org/linux/man-pages/man1/strings.1.html)
- [grep](https://www.gnu.org/software/grep/manual/grep.html)

## Helpful Reading Material

- [Strings Utility](https://en.wikipedia.org/wiki/Strings_\(Unix\))

## Where to start?

As with the two previous levels, we are going to start by running `file` on our data.txt file.<br/>
Here is the output from this command :
```bash
bandit9@bandit:~$ file data.txt 
data.txt: data
bandit9@bandit:~$
```
We can now see that we are not dealing with a text file anymore, thus meaning that we can't use the utilities we're used to to retrieve our password.


<details>
<summary><h3 style="disPlay:inline-block">Part 1 : Printing human-readable strings</h3></summary>

To safely print human-readable strings in non text files, we can use the `strings` command. We need to figure out how to use this command to print the 
few human-readle strings in **data.txt**

<details>
<summary>Hint</summary>

Try to look in the `strings(1)` [man page](https://man7.org/linux/man-pages/man1/strings.1.html) and find out how to use the `strings` utility to achieve this goal
</details>

<details>
<summary>Solution</summary>

We can use the `--all` option to ensure that all the file is scanned (this should be the default behavior but under certain implementations, the default behavior could 
be different so this we'll prevent the exploitation of any BFD library vulnerabilities).<br/>
Thus, the command we're looking for is `strings --all data.txt`, which will dump the **human-readable** strings to stdout.<br/>
Now, we just need to grep the character '=' in this output and look for the password string.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

Here is the full command :
```bash
strings --all data.txt | grep =
```
We then need to look for the string that looks the most like what could be a password string, preceded by several '=' characters
</details>


<details>
<summary><h3 style="display:inline-block">Bonus : Using the size of the password string</h3></summary>

We know that the password string is a 33 characters long string, so we know that the line we're looking for is at least 33 characters long. 
We are going to find a way to display only the (at least) 33 characters long strings in data.txt.


<details>
<summary>Hint</summary>

Reading the `strings(1)` [man page](https://man7.org/linux/man-pages/man1/strings.1.html), can you figure out an option to achieve this goal?
</details>

<details>
<summary>Solution</summary>

The option we're looking for is the `-n` option, we'll call it with `-33` which means that we're looking for at least 33 characters long strings.

Here is the full command :
```bash
strings --all -33 data.txt
```
This command prints only one line, which contains the password we're looking for.
</details>
</details>

You can now jump to the [next level](/bandit/bandit10.md)
