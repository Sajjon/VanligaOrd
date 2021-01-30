#!/bin/zsh
password=`swift run GeneratePassword`
prefix="[💡 Viewing Swift output in Unix program 'less']"
suffix="[💡 Press 'Q' to exit 'less' (the password will disappear).]"
echo "${prefix}${password}\n\n${suffix}\n" | less