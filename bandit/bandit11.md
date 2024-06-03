# [Bandit11->12](https://overthewire.org/wargames/bandit/bandit12.html)

## Level Goal

The password for the next level is stored in the file **data.txt**, where all lowercase (a-z) and uppercase (A-Z) letters have been **rotated by 13 positions**.

## Commands useful to solve the level

- `tr`
- `file` *Optional*
- `head` *Optional*

## Helpful Reading Material

- [ROT13](https://en.wikipedia.org/wiki/ROT13)
- [Rot13](https://wiki.linuxquestions.org/wiki/Rot13) *Warning : Contains Spoilers*

## Where to start?

By running `file` on our file **data.txt**, we know that our file contains `ASCII text` we can now safely work with it. We know from the Level Goal 
that our file contains rot13 encoded data. Let's first run `head` on our file<br/>
You should get an output close to this one :
```bash
Gur cnffjbeq vf cnffjbeq_fgevat
```

<details>
<summary><h3 style="display:inline-block">Part 1 : Describing our transformation</h3></summary>

ROT13 is the rotation of all the alphabetic characters of half the alphabet (13 positions). The goal of this part is to describe the starting set and the ending set 
of letters as two strings. It will be useful for translating our rotated string back to its original form.


<details>
<summary>Hint</summary>

Using the information you got about ROT13 by reading the wikipedia page and assuming that the base set is the alphabet (first the Uppercase and then the lowercase letters), 
set that we will represent like this : `A-Za-z` which represents the string `ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz`. How would you represent the set of the 
translated characters by ROT13?
</details>

<details>
<summary>Solution</summary>

The set of the translated characters can be represented as `N-ZA-Mn-za-m` which is to be understood as the string `NOPQRSTUVWXYZABCDEFGHIJKLMnopqrstuvwxyzabcdefghijklm`
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Translating our data back to its original form</h3></summary>

Now that we described the starting and ending set of the ROT13 transformation, we need to know how to actually translate our data back to its original form. One thing 
we know from studying the rot13 behavior (and reading the wikipedia page) is that rot13 is a [reciprocal cipher](https://en.wikipedia.org/wiki/Symmetric-key_algorithm#Reciprocal_cipher). 
Which means that rot13 applied to itself gives back the original message.<br/>
Let's take our two sets of strings and see if there is a tool that could help us do the translation.


<details>
<summary>Hint</summary>

By taking a look at the [section 9](https://www.gnu.org/software/coreutils/manual/coreutils.html#Operating-on-characters) of the gnu coreutils documentation, try to see we can use 
one of the tool described there to achieve the desired outcome.
</details>

<details>
<summary>Solution</summary>

By reading the [section 9.1.2](https://www.gnu.org/software/coreutils/manual/coreutils.html#Translating) we can see that the `tr` utility is the right tool for us. By using it with 
the two sets of character we deduced in the previous part and by [redirecting](https://www.gnu.org/software/bash/manual/bash.html#Redirecting-Input) the input from our **data.txt** file, 
we can achieve the desired outcome.<br/>
Here is the full command :
```bash
tr 'A-Za-z' 'N-ZA-Nn-za-m' < data.txt
```
Which will output something along the lines : `The password is password_string`
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. `tr 'A-Za-z' 'N-ZA-Mn-za-m' < data.txt` is the command we use to translate our string back to its original form.
</details>

You can now jump to the [next level](/bandit/bandit12.md)
