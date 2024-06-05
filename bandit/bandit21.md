# [Bandit21->22](https://overthewire.org/wargames/bandit/bandit22.html)

## Level Goal

A program is running automatically at regular intervals from **cron**, the time-based **job scheduler**. 
Look in **/etc/cron.d/** for the configuration and see what command is being executed.

## Commands useful to solve the level

- [cron](https://www.man7.org/linux/man-pages/man8/cron.8.html)
- [crontab(5)](https://man7.org/linux/man-pages/man5/crontab.5.html)
- [crontab(1)](https://man7.org/linux/man-pages/man1/crontab.1.html)

## Helpful Reading Material

- [cron Wikipedia page](https://en.wikipedia.org/wiki/Cron)
- [Understanding crontab in Linux with examples](https://linuxhandbook.com/crontab/)
- [crontab in Linux with examples](https://www.geeksforgeeks.org/crontab-in-linux-with-examples/) *Geekforgeeks article*

## Where to start?

We are now starting a series of levels based on `cron`, which is a job scheduler on Linux. For this series, we are going 
to need to analyse the cron jobs for the users involved in this series of level and see what we informations we can gather 
from this analysis. Let's start with the level21.


<details>
<summary><h3 style="display:inline-block">Part 1 : Retrieving the cronjob for the user bandit22</h3></summary>

Our goal here is to know which script is executed by the cronjob on the session of user bandit22.

<details>
<summary>Hint</summary>

By analysing the files into the `/etc/cron.d` directory, can you retrieve the contents of the script that runs for the 
bandit22 user?
</details>

<details>
<summary>Solution</summary>

Here is the output from the `ls` command for the `/etc/crond.d` directory :
```bash
bandit21@bandit:~$ ls /etc/cron.d
cronjob_bandit15_root  cronjob_bandit17_root  cronjob_bandit22  cronjob_bandit23  cronjob_bandit24  cronjob_bandit25_root  e2scrub_all  otw-tmp-dir  sysstat
bandit21@bandit:~$
```
We see that there is a file named `cronjob_bandit22` in the directory. Let's `cat` the contents of this file :
```bash
bandit21@bandit:~$ cat /etc/cron.d/cronjob_bandit22
@reboot bandit22 /usr/bin/cronjob_bandit22.sh &> /dev/null
* * * * * bandit22 /usr/bin/cronjob_bandit22.sh &> /dev/null
bandit21@bandit:~$
```
This shows us that there is a cronjob running every minute for the user bandit22. We are going to go on and print the contents of the script : 
```bash
bandit21@bandit:~$ cat /usr/bin/cronjob_bandit22.sh 
#!/bin/bash
chmod 644 /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
cat /etc/bandit_pass/bandit22 > /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
bandit21@bandit:~$
```
This finally tells us that the password for the user bandit22 is stored in the temporary file which name is written in the script and that is readable by everyone.

We can go on and finally retrieve this password to jump to the next level.
</details>
</details>

<details>
<summary><h3 style="display:inline-block">Full Solution</h3></summary>

1. `cat /etc/cron.d/cronjob_bandit22` to know which cron job is executed for the user bandit22.
2. `cat /usr/bin/cronjob_bandit22.sh` to view the contents of the script that the cron job for user bandit22 runs
3. `cat tmpfile` to print the password string on stdout.
</details>

You can now jump to the [next level](/bandit/bandit22.md)
