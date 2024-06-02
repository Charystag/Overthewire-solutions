# [Bandit](https://overthewire.org/wargames/bandit/bandit6.html)

## Level Goal

The password for the next level is stored in a file somewhere under the inhere directory and has all of the following properties:

- **human-readable**
- **1033 bytes in size**
- **not executable**

## Commands useful to solve the level

- file
- find
- cat

## Helpful Reading Material

- [What does the execute permission do?](https://superuser.com/questions/117704/what-does-the-execute-permission-do)

## Where to start?

The solution is very similar to the one of the [previous level](/bandit/bandit4.md) so check that one for a more in-depth explanation. 
For this level, I will give less explanations and only add complements to teach you about where to find the relevant information. 
Without further ado, let's dive right into the solution.

## Walkthrough

The goal of this exercise is to add options to the `find` command, so that the file we're retrieving meets all the requirements.
We'll try to find the options one after the other into the `find(1)` man page (also available [here](https://www.gnu.org/software/findutils/manual/html_mono/find.html)).

<blockquote>

You can run :
```bash
curl -fsSL --connect-timeout 5 https://raw.githubusercontent.com/Charystag/Scripts/main/colored_man.sh | bash -s find
```
to view the `find(1)` man page with colors.

</blockquote>

<details>
<summary><h3 style="display:inline-block">Option 1 : File Size</h3></summary>

The first option we're looking for is an option that allows us to check for the file size. Let's look in the `find(1)` man page to see if we can 
find the option we need.
<details>
<summary>Hint</summary>

Try to look in the section 2 of the [gnu findutils documentation](https://www.gnu.org/software/findutils/manual/html_mono/find.html).
</details>

<details>
<summary>Solution</summary>

The option we're looking for is described [there](https://www.gnu.org/software/findutils/manual/html_mono/find.html#Size). It is the `size` option.
We are going to invoke it like this `-size 1033c`.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Option 2 : Not Executable</h3></summary>

The second option we're looking for is an option
</details>


You can now jump to the [next level](/bandit/bandit6.md)
