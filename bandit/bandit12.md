# [Bandit12->13](https://overthewire.org/wargames/bandit/bandit13.html)

## Level Goal

The password for the next level is stored in the file data.txt, which is a **hexdump** of a file that has been **repeatedly compressed**. 
For this level it may be useful to create a directory under /tmp in which you can work. Use mkdir with a hard to guess directory name. 
Or better, use the command “mktemp -d”. Then copy the datafile using cp, and rename it using mv (read the manpages!)

## Commands useful to solve the level

- cp
- mv
- mktemp
- tar
- gzip
- bzip2
- xxd
- file

## Helpful Reading Material

- [Gzip](https://en.wikipedia.org/wiki/Gzip)
- [tar](https://en.wikipedia.org/wiki/Tar_\(computing\))
- [Bzip2](https://en.wikipedia.org/wiki/Bzip2)
- [Hexdump](https://en.wikipedia.org/wiki/Hex_dump)
- [GNU tar manual](https://www.gnu.org/software/tar/manual/tar.html)

## Where to start?

To prepare for our chase, we will follow the instructions and place ourselves in a temporary directory created for the occasion. 
Then, we will repeatedly uncompress our data using different compression utilities until we get the password string.


<details>
<summary><h3 style="display:inline-block">Part 1 : Preparing for the extraction</h3></summary>

To do so, we will use the [mktemp](https://www.gnu.org/software/coreutils/manual/coreutils.html#mktemp-invocation) utility, 
[cd](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html) into it and 
[cp](https://www.gnu.org/software/coreutils/manual/coreutils.html#cp-invocation) our **data.txt** file to our newly created directory.

<details>
<summary>Hint</summary>

Using the 3 links to documentation pages, can you figure out how to move to a temporary directory and copy the data.txt file to it?
</details>

<details>
<summary>Solution</summary>

We will run the following command : 
```bash
cd "$(mktemp -d)" && cp "$HOME"/data.txt .
```
This will move us to a temporary created directory and copy the file that lies at '/home/bandit12/data.txt' to the directory we're in.<br/>
We are now ready to work with this file.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 2 : Getting the binary file</h3></summary>

Now that we're in a temporary directory (which we had to move to because the user bandit12 can't write to their home directory, we'll come back to file permissions in the 
later challenges), we can start working with our file. The only information we have about this file is that its the **hexdump** of a file that has been repeatedly compressed.<br/>
Running `file` on this file doesn't give us much more as it only tells us that the file we're seeing is a text file. We need a utility that can translate back the hexdump of a file 
to its original form.

<details>
<summary>Hint</summary>

Looking at the [hexdump](https://man7.org/linux/man-pages/man1/hexdump.1.html) and the [xxd](https://linux.die.net/man/1/xxd) man pages, can you figure out a way to revert data.txt 
back to its original state?
</details>

<details>
<summary>Solution</summary>

The command we're going to use is the `xxd` command. To use it properly and get the original form of the data.txt file, we're going to specify the *outfile* we want to write to and 
specify `xxd` that we want it to operate in reverse mode.<br/>
Here is the final command :
```bash
xxd -r data.txt outfile
```
Where *outfile* may be any name you want to give to your retrieved data.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Part 3 : Figuring out the procedure we're going to follow to extract all the data</h3></summary>

Now that we have our binary data, I won't go step by step into the solution because even though there are quite a few steps, they ultimately can be resolved to a sequence of 3 actions. 
Our goal is to figure out what are these 3 actions.


<details>
<summary>Hint</summary>

By trying to extract our *outfile* a first time, can you figure out what the sequence of actions is? You might need to use the `file` utility to achieve that goal.
</details>

<details>
<summary>Solution</summary>

Here is the sequence of actions we need to follow to successfully extract all the data that has been compressed :

1. We need to find the compression method of our file by running the `file` utility on it.
2. Then, we might need to rename the file we're looking to uncompress to a file with the right extension (as some compression utilities recognize only some specific extensions)
3. We need to extract the file with the right utility and go back to step 1 until we get an ASCII Text file.

If you're stuck at this time, go to the full solution to get the step by step walkthrough.
</details>
</details>


<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

Running the following sequence of commands :
```bash
cd "$(mktemp -d)" && cp "$HOME"/data.txt . || kill -INT $$
xxd -r data.txt outfile
file --mime-type -b outfile # should print : application/gzip
mv outfile outfile.gz
gunzip outfile.gz
file --mime-type -b outfile # should print : application/x-bzip2
bunzip2 outfile
file --mime-type -b outfile.out # should print : application/gzip
mv outfile.out outfile.gz
gunzip outfile.gz
file --mime-type -b outfile # should print : application/x-tar
tar -xf outfile
file --mime-type -b data5.bin # should print : application/x-tar
tar -xf data5.bin
file --mime-type -b data6.bin # should print : application/x-bzip2
bunzip2 data6.bin
file --mime-type -b data6.bin.out # should print : application/x-tar
tar -xf data6.bin.out
file --mime-type -b data8.bin # should print : application/gzip
mv data8.bin data8.gz
gunzip data8.gz
```
should fully uncompress the file data.txt. We can now run one last time the `file` command on our file **data8**.
```bash
file --mime-type -b data8 # should print : text/plain
```
This shows us that the data8 file contains the password we're looking for, and by running `cat` on this file, we get something along the lines :
```bash
The password is password_string
```
</details>


<details>
<summary><h3 style="display:inline-block">Bonus : One-Liner Solution</h3></summary>

Instead of extracting all these files to another file and renaming that file, we could each time pipe the output of our decompression program to 
the `file` utility. That way it would be possible to analyse the output of the program without creating a new file each time. It is very unoptimized for 
huge files (as you don't know in advance what was the sequence of compressions applied thus meaning you'll have to uncompress the same file 
a lot of times) but it is worth mentionning as once you have this sequence, it can be very useful to have one command rather than a shell script.


<details>
<summary>Hint</summary>

Using only the man pages of the commands we used in the previous section, can you figure out a way to write a pipeline that does the exact same thing without 
creating any file?
</details>

<details>
<summary>Solution</summary>

The command we're looking for is the following : 
```bash
xxd -r data.txt | gunzip -c | bunzip2 -c | gunzip -c | tar --to-command='/usr/bin/tar -xO' -x | bunzip2 -c | tar -xO | gunzip -c
```
You can understand all the options that have been added by reading the man pages of all the utilities involved.
</details>
</details>

You can now jump to the [next level](/bandit/bandit13.md)
