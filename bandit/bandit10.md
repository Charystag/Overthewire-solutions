# [Bandit10->11](https://overthewire.org/wargames/bandit/bandit11.html)

## Level Goal

The password for the next level is stored in the file **data.txt**, which contains **base64** encoded data.

## Commands useful to solve the level

- `base64`
- `file` *Optional*
- `head` *Optional*

## Helpful Reading Material

- [Base64](https://en.wikipedia.org/wiki/Base64)
- [Base64-encoding](https://www.redhat.com/sysadmin/base64-encoding)
- [What is the base64 encoding used for](https://stackoverflow.com/questions/201479/what-is-base-64-encoding-used-for) *StackOverflow discussion*

## Where to start?

By running `file` on our file **data.txt**, we know that our file contains `ASCII text` we can now safely work with it. We know from the Level Goal 
that our file contains base64 encoded data. Let's first run `head` on our file<br/>
You should get an output close to this one :
```bash
VGhlIHBhc3N3b3JkIGlzIHBhc3N3b3JkX3N0cmluZwo=
```

As the solution is pretty straightforward I will give it right away, however it will still be hidden if you want to search by yourself first. Go and 
check the base64 [gnu documentation page](https://www.gnu.org/software/coreutils/manual/coreutils.html#base64-invocation) to see if you can find how to 
decode our password string.


<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

We will use the option `-d` (decode) of the `base64` utility.<br/>
Thus, running the following command :
```bash
base64 -d data.txt
```
will print a string which should look like this one : `The password is password_string` to stdout.
</details>

You can now jump to the [next level](/bandit/bandit11.md)
