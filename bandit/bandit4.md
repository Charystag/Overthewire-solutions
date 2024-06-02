# [Bandit4->5](https://overthewire.org/wargames/bandit/bandit5.html)

## Level Goal

The password for the next level is stored in the only **human-readable file** in the inhere directory.<br/>
Tip: if your terminal is messed up, try the “reset” command.

## Commands useful to solve the level

- find
- cat

## Helpful Reading Material

- [Regular File](https://www.ibm.com/docs/en/aix/7.3?topic=files-types)
- [Human Readable File](https://en.wikipedia.org/wiki/Human-readable_medium_and_data)
- `find(1)` man page
- [GNU findutils documentation](https://www.gnu.org/software/findutils/manual/html_mono/find.html)

## Where to start?

As there isn't a lot of helpful reading material (because the material is already very complete), we **must** start by opening 
the `find(1)` man page : `man 1 find`

<blockquote>

You can run :
```bash
curl -fsSL --connect-timeout 5 https://raw.githubusercontent.com/Charystag/Scripts/main/colored_man.sh | bash -s 1 find
```
to get the `find(1)` man page with colors

</blockquote>

Now that we got an idea of what the find utility does we need to know exactly what characteristics the file we are looking for has.
- it is **human-readable**.
- it is a **file**

We need to find a way to only for human readable files in a given directory

<details>
<summary><h3 style="display:inline-block">Part 1 : Finding directory files</h3></summary>

During all this level, we are only going to use the `find(1)` utility. In fact, our solution to this level will consist in one unique 
call to the `find(1)` utility. First things first, we need to know how to run the `find` command to list the directory files


<details>
<summary>Hint</summary>

Look at the **SYNOPSIS** section of the `find(1)` man page.
</details>

<details>
<summary>Solution</summary>

When looking in the **SYNOPSIS** section of the `find(1)` man page, we see an optional argument named **starting-point**. This argument 
allows the user to specify a starting directory when running the `find` utility. By default, the starting point is `.` which is the 
current directory.
So, running `find inhere` allows us to list the contents of the **inhere** directory
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Listing only the files</h3></summary>

Before delving deeper into the `find(1)` man page to know how we can use `find` to retrieve the only human-readable file in the inhere directory 
let's take a closer look at the output we got from running `find` alone :
```bash
bandit4@bandit:~$ find
.
./inhere
./inhere/-file01
./inhere/-file02
./inhere/-file08
./inhere/-file06
./inhere/-file00
./inhere/-file04
./inhere/-file05
./inhere/-file07
./inhere/-file03
./inhere/-file09
./.profile
./.bashrc
./.bash_logout
bandit4@bandit:~$
```

From that output, we can notice that find lists all the file in the directories and subdirectories, without ignoring hidden files by default.
We can notice that it lists all the files and directories contained in the starting point, along with the starting point.

Let's now try to list only the regular files within the inhere directory


<details>
<summary>Hint</summary>

Isn't  there a test that you could use in the **TESTS** section of the `find(1)` man page?
</details>

<details>
<summary>Solution</summary>

The option we're looking for is `-type`, which allows us to test for the type of file we're looking for. We'll give the `-type` option the `f` argument 
to only look for **regular files**.<br/>
The command we're looking for is `find inhere -type f`.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 3 : Finding the only human readable file</h3></summary>

Here is the output from the command `find inhere -type f` : 
```bash
bandit4@bandit:~$ find inhere/ -type f
inhere/-file01
inhere/-file02
inhere/-file08
inhere/-file06
inhere/-file00
inhere/-file04
inhere/-file05
inhere/-file07
inhere/-file03
inhere/-file09
bandit4@bandit:~$
```

We could try to manually run `cat` on each file but besides being an ugly as hell solution, it offers a [security risk](https://security.stackexchange.com/questions/56307/can-cat-ing-a-file-be-a-potential-security-risk). 
Thankfully, there is a solution which stands in the `file(1)` utility
We now need to find in the `file(1)` man page how to find the only human readable file within the inhere directory.


<details>
<summary>Hint</summary>

Look into the `file(1)` and the `find(1)` man page. See if there is an **ACTION** in the `find(1)` page that could let you execute the `find` command on the file you retrieved
</details>

<details>
<summary>Solution</summary>

The **ACTION** we're looking for is `-execdir`. We will use the form `-execdir command ;` as it is safer than the `-exec command ;` form (see [security considerations](https://www.gnu.org/software/findutils/manual/html_mono/find.html#Security-Considerations). 
As the `;` is a [metacharacter](https://www.gnu.org/software/bash/manual/html_node/Definitions.html), we will need to escape it with a `\` to pass it to the `find` command. 
For the same reason, we'll have to enclose the brackets `{}` within simple or double quotes<br/>

The command we're looking for is : `find inhere -type f -execdir file '{}' \;`<br/>
Here is an output you could get by running this command : 
```bash
bandit4@bandit:~$ find inhere/ -type f -execdir file "{}" \;
./-file01: data
./-file02: data
./-file08: data
./-file06: data
./-file00: data
./-file04: data
./-file05: data
./-file07: ASCII text
./-file03: data
./-file09: data
bandit4@bandit:~$
```
We can now run the command `cat inhere/-file07` to get the password string
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. `find inhere/ -type f -execdir file "{}" \;` to find all the regular files in the inhere directory and run the `file` utility on them
2. `cat inhere/-file07` to print the contents of the retrieved file
</details>


<details>
<summary><h3 style="display:inline-block">Bonus : One-liner command</h3></summary>

**Useful commands**:

- bash (or any shell)
- find
- file
- grep
- cat


<details>
<summary>Hint</summary>

To get you started, if you want to find (no pun intended) by yourself, here are a few informations to 
get you on the right track.

Here are the `find` options we'll use to achieve our goal :
- type
- execdir (x2)
- quit (optionnal)
</details>

<details>
<summary>Solution</summary>

The command is the following :
```bash
find inhere/ -type f -execdir bash -c 'file {} | grep text > /dev/null' \; -execdir cat '{}' \; -quit
```
Here is a step-by-step overview of the command :

1. The first execdir calls execute the command `file {} | grep text > /dev/null` on each retrieved file in the inhere directory. 

> The redirection to `/dev/null` is to ensure that nothing gets printed on stdout, but the important thing here is actually the 
> [exit status](https://www.gnu.org/software/grep/manual/grep.html#Exit-Status) of the `grep command`.
See [bash invocation](https://www.gnu.org/software/bash/manual/html_node/Invoking-Bash.html) for informations about the `-c` option.

2. The second execdir calls cat on the only **human-readable** file in the inhere directory
3. The quit option allows us to stop the `find` utility once we found what we're looking for. To understand what it does, you can 
replace `grep` by `grep -v` in the previous command
</details>

</details>

You can now jump to the [next level](/bandit/bandit5.md)
