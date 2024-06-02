# [Bandit6->7](https://overthewire.org/wargames/bandit/bandit7.html)

## Level Goal

The password for the next level is stored **somewhere on the server** and has all of the following properties:

-	owned by user bandit7
-	owned by group bandit6
-	33 bytes in size

## Commands useful to solve the level

- `find`
- `cat`

## Helpful Reading Material

- [Root Directory](https://en.wikipedia.org/wiki/Root_directory)
- [Redirection](https://en.wikipedia.org/wiki/Redirection_\(computing\))
- [Null Device](https://en.wikipedia.org/wiki/Null_device)

See [bandit4->5](/bandit/bandit4.md) and [bandit5->6](/bandit/bandit5.md) for more useful material.

## Where to start?

Let's dive right into the solution, as this level is very similar to the two previous ones.

## Walkthrough

We already know about the `size` option, we only need to find about the options that allow us to filter the 
files using the user and group owning the file. The only thing missing is the fact that the file lies somewhere 
on the server. 


<details>
<summary><h3 style="display:inline-block">Part 1 : Designating the root of the server</h3></summary>


<details>
<summary>Hint</summary>

Read about the [Root Directory](https://en.wikipedia.org/wiki/Root_directory)
</details>

<details>
<summary>Solution</summary>

From the reading material, we know that we can designate the root of the server with the character `/`.
The command `find /` will allow us to search everywhere in the server.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Finding the relevant options</h3></summary>

<details>
<summary>Hint</summary>

All the options we're looking for are in the section 2 of the [gnu findutils documentation](https://www.gnu.org/software/findutils/manual/html_mono/find.html)
</details>

<details>
<summary>Solution</summary>

Let's take a look at the [section 2.8](https://www.gnu.org/software/findutils/manual/html_mono/find.html#Owner). In this section we can see the two options :

-	`user`
-	`group`

Thus we can deduce the resulting command : `find / -user bandit7 -group bandit6 -size 33c`. We just have to `cat` the resulting file to get the password.

</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 3 : Getting rid of all the error messages</h3></summary>

Right now, you can see that the output is pretty useless, indeed we need to get rid of all the "Permission denied" messages.<br/>
We need to find a way to get rid of all these error messages, unfortunately `find` doesn't allow us to do so, but there is a way to get rid of these messages 
by putting them in a special file.


<details>
<summary>Hint</summary>

</details>

<details>
<summary>Solution</summary>

</details>
</details>

You can now jump to the [next level](/bandit/bandit7.md)
