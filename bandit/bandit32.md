# [Bandit32->33](https://overthewire.org/wargames/bandit/bandit33.html)

## Level Goal

After all this git stuff its time for another escape. Good luck!

## Commands useful to solve the level

- [bash](https://www.gnu.org/software/bash/manual/html_node/index.html)
- [man](https://man7.org/linux/man-pages/man1/man.1.html)

## Helpful Reading Material

- [Man Page](https://en.wikipedia.org/wiki/Man_page)
- [Special Parameters](https://www.gnu.org/software/bash/manual/html_node/Special-Parameters.html)

## Where to start?

To be honest I don't have the same experience with the uppercase shell than the one I had with the 
showtext executable. I hated showtext because it litteraly did nothing and wasn't acknowledging my 
inputs when the uppercase shell seems to be yelling and trolling me and I find that kinda funny. 
Let's now dive into the challenge.

The problem seems pretty obvious to spot, everything we type is converted 
to uppercase, so our first goal is to understand the shell we've been given.

<details>
<summary><h3 style="display:inline-block">Part 1 : Getting to know the uppercase shell</h3></summary>

We'll start by trying to input some commands and get to know what is the uppercase shell really doing. 
Then, using that insight, we will try to figure out what we can actually do with that shell.

<details>
<summary>Hint</summary>

By testing and trying to run some commands, can you describe the effects of the uppercase shell and can 
you see what type of input will be unaffected by the effects of that shell?
</details>

<details>
<summary>Solution</summary>

Now that we made some tests with the uppercase shell, we can notice that it converts all of our input to uppercase 
before feeding it to an actual shell. From that, we can deduce that the only input that will stay unaffected by the 
effect of this shell will be shell variables (as they are usually already uppercase).
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Getting an actual shell</h3></summary>

Knowing that shell variables are unaffected by the uppercase shell, we'll need to use that feature to get an actual shell.
<details>
<summary>Hint</summary>

Using the [special parameters](https://www.gnu.org/software/bash/manual/html_node/Special-Parameters.html) section of the 
gnu bash manual, can you figure out which variable to use to get a shell?
</details>

<details>
<summary>Solution</summary>

As the uppercase shell actually converts our input to uppercase before feeding it to an actual shell, the `$0` variable 
contains the name of the shell it invokes. Thus, by running the following command :
```bash
$0
```
We can then get an actual shell and use it to `cat` the bandit33 password.
</details>
</details>

<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. `$0` to get an actual shell (which will in fact be [sh](https://man7.org/linux/man-pages/man1/dash.1.html))
2. `cat /etc/bandit_pass/bandit33` to get the password for the next level.

</details>

You can now jump to the [next level](/bandit/bandit33.md)
