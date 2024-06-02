#!/usr/bin/env bash
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
