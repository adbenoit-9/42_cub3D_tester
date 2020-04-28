#!/bin/bash

pwd_cub3d=..

#first line massage in error case
echo "Error" > correct.txt
#OK message
echo "destroy window done." > correct2.txt

nb_test=25
count=0
ok=1
make
if [ -f $pwd_cub3d/cub3d ]
    then
        continue
    else
        echo "\nCompilation of \033[33;1mcub3d\033[0;1m: [\033[1;31mKO\033[0;1m]"
        exit
fi
printf "\n\n"
echo "\033[4;34;1mTESTER CUB3D\033[0;1m"
printf "\n"
KO=0
str=""
check=✔
col=32
echo "\033[1;36mYou need to get the good map : basic\033[0;1m \033[1;32m$check\033[0;1m \033[1;36mfor the rest of the tester !\033[0m"
printf "Good map     : "
$pwd_cub3d/cub3d tests/basic.cub > output.txt
var=$(srcs/comp output.txt correct2.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" basic"
        check=𐄂
        col=31
fi

$pwd_cub3d/cub3d tests/test.cub > output.txt
var=$(srcs/comp output.txt correct2.txt)
ok=1
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" test"
fi

$pwd_cub3d/cub3d tests/test11..cub > output.txt
var=$(srcs/comp output.txt correct2.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" test11"
fi

$pwd_cub3d/cub3d tests/test19.cub > output.txt
var=$(srcs/comp output.txt correct2.txt)
ok=1
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" test19"
fi

if [ $KO != 0 ]
    then
        echo "[\033[1;31mKO\033[0;1m]"
        if [ $check = ✔ ]
            then
                echo "basic \033[1;32m$check\033[0;1m"
            else
                echo "basic \033[1;31m$check\033[0;1m"
        fi
        echo "\033[7mFailed :$str\033[0m"
    else
        echo "[\033[1;32mOK\033[0;1m]"
        echo "basic \033[1;32m$check\033[0;1m"
fi
###########################
KO=0
str=""
printf "Info error   : "
$pwd_cub3d/cub3d tests/test0.cub > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" test0"
fi

$pwd_cub3d/cub3d tests/test1.cub > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" test1"
fi

$pwd_cub3d/cub3d tests/test15.cub > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" test15"
fi

$pwd_cub3d/cub3d tests/test16.cub > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" test16"
fi

$pwd_cub3d/cub3d tests/test17.cub > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" test15"
fi 

if [ $KO != 0 ]
    then
        echo "[\033[1;31mKO\033[0;1m]"
        echo "\033[7mFailed :$str\033[0m"
    else
        echo "[\033[1;32mOK\033[0;1m]"
fi

######################################
KO=0
str=""
printf "Color error  : "
$pwd_cub3d/cub3d tests/test3.cub > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" test3"
fi

$pwd_cub3d/cub3d tests/test8.cub > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" test8"
fi

$pwd_cub3d/cub3d tests/test14.cub > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" test14"
        echo "[\033[1;31mKO\033[0;1m]"
fi

if [ $KO != 0 ]
    then
        echo "[\033[1;31mKO\033[0;1m]"
        echo "\033[7mFailed :$str\033[0m"
    else
        echo "[\033[1;32mOK\033[0;1m]"
fi

########################################
KO=0
str=""
printf "Map error    : "
$pwd_cub3d/cub3d tests/test4.cub > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" test4"
fi

$pwd_cub3d/cub3d tests/test5.cub > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" test5"
fi

$pwd_cub3d/cub3d tests/test6.cub > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" test6"
fi

$pwd_cub3d/cub3d tests/test7.cub > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" test7"
fi

$pwd_cub3d/cub3d tests/test9.cub > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" test9"
fi

$pwd_cub3d/cub3d tests/test18.cub > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" test18"
fi

if [ $KO != 0 ]
    then
        echo "[\033[1;31mKO\033[0;1m]"
        echo "\033[7mFailed :$str\033[0m"
    else
        echo "[\033[1;32mOK\033[0;1m]"
fi

#######################################
KO=0
str=""
printf "File error   : "
$pwd_cub3d/cub3d tests/test10.cu > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" test10"
fi

$pwd_cub3d/cub3d tests/test12.Cub > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" test12"
fi

$pwd_cub3d/cub3d tests/test13.cubi > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" test13"
fi

$pwd_cub3d/cub3d srcs/absent.cub > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" absent"
fi

if [ $KO != 0 ]
    then
        echo "[\033[1;31mKO\033[0;1m]"
        echo "\033[7mFailed :$str\033[0m"
    else
        echo "[\033[1;32mOK\033[0;1m]"
fi

#####################################
KO=0
str=""
printf "Save error   : "
$pwd_cub3d/cub3d tests/test.cub --sav > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" --sav"
fi

$pwd_cub3d/cub3d tests/test.cub -save > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" -save"
fi

$pwd_cub3d/cub3d tests/test.cub --saves > output.txt
var=$(srcs/comp output.txt correct.txt)
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" --saves"
fi

if [ $KO != 0 ]
    then
        echo "[\033[1;31mKO\033[0;1m]"
        echo "\033[7mFailed :$str\033[0m"
    else
        echo "[\033[1;32mOK\033[0;1m]"
fi

#####################################
printf "\n"
if [ $count -eq $nb_test ]
    then
    {
        echo "[ \033[1;32m$count / $nb_test\033[0;1m ]"
        echo "\033[1;32mGood job my love !\033[0;1m"
    }
    else
        {
        echo "[ \033[1;31m$count / $nb_test\033[0;1m ]"
        echo "\033[1;31mLOL try again !\033[0;1m\n"
    }
fi

make fclean
rm *.txt