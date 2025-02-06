# To check the leaks:
while true;
do
	leaks ./minishell;
done


# To check file descriptors:
while true;
do
	lsof -c;
done

# Tests:

## File Redirections & Edge Cases:

echo "test" > "out>file"
echo "test" > ""
echo "test" > "   "
echo "test" > "/dev/null/test"  # Should fail


echo "test1" > out1 > out2 > out3 < in1
echo "test2" > out1 >> out2 > out3 < in1
echo "test3" >> out1 > out2 >> out3 < in1


echo "hello" >> /nonexistent/path/output.txt


ls | grep "c" | cat -e | head -n 3 | sort -r | wc -l



## Pipes & Complex Chaining:

ls | grep "c" | cat -e | head -n 3 | sort -r | wc -l


echo "hello" | notacommand | wc -l


echo | cat | cat | cat | sort | wc -l


cat < /dev/zero | head -c 10 | wc -c
cat < /dev/urandom | tr -dc 'A-Za-z0-9' | head -c 100



## Environment Variables & Expansion:

echo "Hello $UNSET_VAR"
echo "$UNSET_VAR World"
export VAR=""
echo "Value: $VAR"
unset VAR
echo "Unset: $VAR"


export STR="Hello    World"
echo $STR
echo "$STR"
echo '$STR'
echo \$STR
echo "`echo $STR`"


export A="B"
export B="C"
echo ${!A}


## Command Execution & Exit Codes:

""
"   "


/bin/ls -al /nonexistentfolder
./not_a_script
./directory_as_command/


touch script.sh
chmod +x script.sh
echo '#!/bin/bash\necho "Hello"' > script.sh
./script.sh


sleep 10 &
jobs
kill %1
fg %1


false
echo $?  # Should print 1
true
echo $?  # Should print 0
ls /nonexistent
echo $?  # Should print 2


## Input Handling & Parsing:

echo "hello ; |"
echo "hello | |"
echo "hello > <"
echo "hello ; ;"


echo "hello
echo 'world
echo "hello'world


echo >| out
echo <
echo >>
echo |
echo ;


## Built-in Commands (cd, export, unset, env, echo, pwd, exit):


cd /nonexistentpath
cd ..
cd /
cd ~
cd ../../../../../..


export A B C
unset A B C
env | grep A


echo -n -n -nnnn hello
echo "hello -n -n -nnnn"


exit "invalid argument"
exit 999999999999999999999
exit -999999999999999999999



