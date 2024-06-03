# [Bandit8->9](https://overthewire.org/wargames/bandit/bandit9.html)

## Level Goal

The password for the next level is stored in the file **data.txt** and is the only line of text that occurs only **once**

## Commands useful to solve the level

- `sort`
- `uniq`

## Helpful Reading Material

- [Pipes Linux](https://tldp.org/LDP/lpg/node10.html)
- [Redirections Bash](https://www.gnu.org/software/bash/manual/html_node/Redirections.html)

## Where to start?

To get more information about the file analysis, go to the [previous challenge](/bandit/bandit7.md).

We now need to get the only line of text that occurs only **once** in the file **data.txt**. To do so we'll do the process in reverse.


<details>
<summary><h3 style="display:inline-block">Part 1 : Uniquifying the file</h3></summary>

The `uniq` utility allows us to discard repeated input lines, what it does is that it compares the consecutive lines to see if they're (or aren't) 
identical to each other.


<details>
<summary>Hint</summary>

Using the [uniq gnu documentation](https://www.gnu.org/software/coreutils/manual/coreutils.html#uniq-invocation), can you figure out what option we need 
to keep only the input lines that occurs only **once**?
</details>

<details>
<summary>Solution</summary>

The option `-u` is the option we'll need to complete our goal. Let's break down what it does. Here is a quote from the documentation :

The `-u` option : "Discard the last line that would be output for a repeated input group. When used by itself, this option causes uniq to print unique lines, and nothing else."<br/>
First let's try and see what would be the last line outputed for a repeated input group : it is the first line of the group. This means that `uniq -u` discards the only line which 
would be outputed for a group. This indeed means that `uniq -u` only prints the unique lines.

However we know from the same documentation that `uniq` operates on consecutive lines, thus we need a way to make the lines consecutive to compare them.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Sorting text files</h3></summary>

We need a way to `sort` the input to apply our `uniq` filter to it.

<details>
<summary>Hint</summary>

By looking into the [sort gnu documentation](https://www.gnu.org/software/coreutils/manual/coreutils.html#sort-invocation), can you figure out how to sort the input for the uniq filter to work?
</details>

<details>
<summary>Solution</summary>

It's fairly simple, we don't need any option at all. By running `sort data.txt`, we will output the result of the sorted output to stdout.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

`sort data.txt | uniq -u` is the full command that will allow us to get the full password string.

1. `sort data.txt` will allow us to sort the input in order for uniq to see the consecutive repeated lines.
2. `|` the pipe will allow the sort and uniq processes to communicate.
3. `uniq -u` will dump the only **unique** line to stdout.
</details>

You can now jump to the [next level](/bandit/bandit9.md)
