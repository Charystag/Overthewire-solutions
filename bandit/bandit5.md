# [Bandit5->6](https://overthewire.org/wargames/bandit/bandit6.html)

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

The option we're looking for is described [there](https://www.gnu.org/software/findutils/manual/html_mono/find.html#Size). It is the `size` option. <br/>
We are going to invoke it like this : `-size 1033c`.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Option 2 : Not Executable</h3></summary>

The second option we're looking for is an option that allows us to check for the executable permission on the file we encounter. Let's look once again into the 
`find(1)` man page (or the [gnu findutils documentation](https://www.gnu.org/software/findutils/manual/html_mono/find.html)) to find what we need.

<details>
<summary>Hint</summary>

This time, we still need to look at the section 2 of the [gnu findutils documentation](https://www.gnu.org/software/findutils/manual/html_mono/find.html). 
However, we need to look into two different subsections of this section 2 to complete our option.
</details>

<details>
<summary>Solution</summary>

The option we're looking for is described [there](https://www.gnu.org/software/findutils/manual/html_mono/find.html#Mode-Bits). It is the `executable` option. 
However, we need our file to not be executable, so we can see in this [section](https://www.gnu.org/software/findutils/manual/html_mono/find.html#Combining-Primaries-With-Operators) 
that to negate this condition we can use the `-not` operator.<br/>
We are going to invoke our option like this : `-not -executable`.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Building the command</h3></summary>

After getting our two options, the rest of the command is exactly the same as with the previous exercise.<br/>
Here is our command : 
```bash
find inhere -type f -size 1033c -not -executable -execdir file '{}' \; -print
```

We need to print the file after because due to using the execdir option instead of the exec option (see the [security considerations](https://www.gnu.org/software/findutils/manual/html_mono/find.html#Security-Considerations-for-find))
</details>


<details>
<summary><h3 style="display:inline-block">Security concerns : One-liner from previous exercise</h3></summary>

In the [previous level](/bandit/bandit4.md) I gave you a one-liner to solve the level

```bash
find inhere/ -type f -execdir bash -c 'file {} | grep text > /dev/null' \; -execdir cat '{}' \; -quit
```

Although this command gives the right answer, it presents a [security concern](https://www.gnu.org/software/findutils/manual/html_mono/find.html#Problems-with-_002dexec-and-filenames). 
Indeed, if an attacker puts a special filename in your directory, it could lead to the deletion of all of your data. Let's see a safe example right now.
Try running the following [script](/bandit/scripts/bandit5.sh) and understanding its output (you can copy and paste the script into you terminal window): 

```bash
#!/usr/bin/env bash
clear #This is to keep only the script outputs in case you copy-paste it to your terminal window
mkdir -p /tmp/testrm
cd "$(mktemp -d)" && echo "Step 1 - Now in temporary directory" || kill -INT $$
echo "Step 2 - creation of the /tmp/testrm directory, that will be useful to bring out our security concern"
if ls /tmp | grep testrm > /dev/null ; then echo /tmp/testrm is still there; else echo /tmp/testrm is unfortunately gone; fi
echo "Step 3 - Creation of two test files : 'bonjour' and 'bonjour ; rm -rf \$TEST'"
touch bonjour 'bonjour ; rm -rf $TEST'
echo -n "These are the directory files : " ; ls -1
echo "Step 4 - Exporting the TEST variable to contain the value of '/tmp/testrm', the directory we want to delete"
export TEST="/tmp/testrm"
echo "Step 5 - We now run the find command and we use the execdir option to call a bash instance which will run \
the file utility on each file we find"
find -execdir bash -c 'file {}' \;
echo -n "Step 6 - We can now see that our test directory has been removed : "
if ls /tmp | grep testrm > /dev/null ; then echo /tmp/testrm is still there; else echo /tmp/testrm is unfortunately gone; fi
cd "-" && rm -rf "$OLDPWD" && echo "Step 7 - Back in $PWD"
```

In this example we see that our /tmp/testrm directory has been deleted even though we didn't intended at all to do so. 
This is because the command 'rm -rf' has been executed when we tried to execute `file` on our dangerously named file without 
sanitizing the input. Even if it is harmless for this example, if the attacker replaces `$TEST` with `$HOME` it could be 
way more harmful.<br/>
To prevent this from hapenning, instead of the command `find -execdir bash -c 'file {}' \;` we can run the following :

```bash
find -execdir bash -c 'file "$@"' bash '{}' \;
```

to understand precisely what this command do you can go check the -c option in the [bash invocation](https://www.gnu.org/software/bash/manual/bash.html#Invoking-Bash) section of the 
gnu bash manual.
</details>

You can now jump to the [next level](/bandit/bandit6.md)
