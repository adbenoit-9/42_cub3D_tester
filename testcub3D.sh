#!/bin/bash

##########################################################################################
###################################### TESTER CUB3D ######################################
##########################################################################################

pwd_cub3d=..

#first line message in error case
echo "Error" > error_msg.txt

nb_test=60
count=0
ok=1
check=✔
arg="$@"

############################
######## FUNCTIONS #########
############################

#For good map
good_map(){
    i=1
    tot_test=$#
    tot_test=$(($tot_test+1))
    while [ $i -lt $tot_test ]
        do
            test=${!i}
            touch $outputs_file/$test
            $pwd_cub3d/cub3D $tests_file/$test > $outputs_file/$test 2> failed.txt
            var=$(srcs/compare/comp $outputs_file/$test error_msg.txt)
            if [ $var -ne $ok ]
                then
                var=$(srcs/compare/comp $outputs_file/$test failed.txt)
            fi
            if [ $var -ne $ok ]
                then
                count=$(($count+1))
                rm  $outputs_file/$test
            else
                KO=$(($KO+1))
                str+="\n- $test"
            fi
            i=$((i+1))
    done
    return $KO
}

#For map/info error
error_map(){
    i=1
    tot_test=$#
    tot_test=$(($tot_test+1))
    while [ $i -lt $tot_test ]
        do
            test=${!i}
            touch $outputs_file/$test
            $pwd_cub3d/cub3D $tests_file/$test > $outputs_file/$test
            var=$(srcs/compare/comp $outputs_file/$test error_msg.txt)
            if [ $var = $ok ]
                then
                count=$(($count+1))
                rm  $outputs_file/$test
            else
                KO=$(($KO+1))
                str+="\n- $test"
            fi
            i=$((i+1))
    done
}

#For --save error
save_error(){
    i=1
    tot_test=$#
    tot_test=$(($tot_test+1))
    while [ $i -lt $tot_test ]
        do
        save=${!i}
        touch $outputs_file/$save.txt
        $pwd_cub3d/cub3D $tests_file/basic.cub $save > $outputs_file/$save.txt
        var=$(srcs/compare/comp $outputs_file/$save.txt error_msg.txt)
        if [ $var = $ok ]
            then
            count=$(($count+1))
            rm  $outputs_file/$save.txt
        else
            KO=$(($KO+1))
            str+=" $save"
        fi
        i=$((i+1))
    done
}

print_result(){
    i=2
    tot_KO=$#
    tot_KO=$(($tot_KO+1))
    str_KO=""
    while [ $i -lt $tot_KO ]
        do
        test_KO=${!i}
        str_KO+=' '
        str_KO+=$test_KO
        i=$((i+1))
    done
    if [ $1 != 0 ]
        then
        echo "[\033[1;31mKO\033[0;1m]"
        echo "\033[7mFailed : $str_KO\033[0m"
    else
        echo "[\033[1;32mOK\033[0m]"
    fi
}

add_bonus(){
    i=1
    tot_test=$#
    tot_test=$(($tot_test+1))
    while [ $i -lt $tot_test ]
        do
        test=${!i}
        srcs/add_bonus_inf/add tests/$test add_bonus_inf.txt tests_bonus/$test
        i=$((i+1))
    done
}

###########################
######## EXCUTION #########
###########################

all_tests=$(ls tests/)

if [ -z $arg ]
    then
    make 1> /dev/null
    tests_file=tests
    outputs_file=KO_outputs
elif [ $arg = "bonus" ]
    then
    make bonus
    tests_file=tests_bonus
    outputs_file=KO_bonus_outputs
    rm -rf tests_bonus
    mkdir tests_bonus
    add_bonus $all_tests
else
    echo "\"$arg\" invalid option"
    echo "usage: testcub3D.sh"
    echo "    or testcub3D.sh bonus"
    exit
fi

if [ -f $pwd_cub3d/cub3D ]
    then
    continue
else
    echo "\nCompilation of \033[33;1mcub3d\033[0;1m: [\033[1;31mKO\033[0;1m]"
    exit
fi
printf "\n\n"

rm -rf $outputs_file
mkdir $outputs_file

str=""
KO=0
$pwd_cub3d/cub3D $tests_file/basic.cub > $outputs_file/basic.cub 2> failed.txt
var=$(srcs/compare/comp $outputs_file/basic.cub error_msg.txt)
if [ $var -ne $ok ]
    then
    var=$(srcs/compare/comp $outputs_file/basic.cub failed.txt)
fi
if [ $var -ne $ok ]
    then
    count=$(($count+1))
    rm  $outputs_file/basic.cub
else
    KO=$(($KO+1))
    str+="\nbasic.cub"
    check=𐄂
fi

good_map test.cub test11..cub test19.cub test32.cub test33.cub test42.cub test44.cub
str0=$str
KO0=$KO
########### INFO ERR ############

KO=0
str=""
error_map test0.cub test1.cub test15.cub test16.cub test17.cub test20.cub test21.cub \
test24.cub test25.cub test27.cub test28.cub test29.cub test34.cub test43.cub
str1=$str
KO1=$KO
############ COLOR ERR ###########

KO=0
str=""
error_map test3.cub test8.cub test14.cub test26.cub test35.cub test36.cub
str2=$str
KO2=$KO
############ MAP ERR ###########

KO=0
str=""
error_map test4.cub test5.cub test6.cub test7.cub test9.cub test18.cub test22.cub test23.cub \
test30.cub test31.cub test37.cub test38.cub test39.cub test40.cub test41.cub test45.cub \
test46.cub test47.cub test48.cub test49.cub test50.cub test51.cub test52.cub test53.cub test54.cub
str3=$str
KO3=$KO
############ FILE ERR ###########

KO=0
str=""
error_map test10.cu test12.Cub test13.cubi absent.cub
str4=$str
KO4=$KO
############ SAVE ERR ###########

KO=0
str=""
save_error --sav -save --saves
str5=$str
KO5=$KO

###########################
######## DISPLAY #########
###########################

echo "\033[4;34;1mTESTER CUB3D\033[0;1m\033[1;34;1m $1\033[0;1m"
printf "\n"
echo "\033[1;36mYou need to get the good map : basic\033[0;1m \033[1;32m✔\033[0;1m \
\033[1;36mfor the rest of the tester !\033[0m"
printf "\n"

printf "Good map     : "

if [ $KO0 != 0 ]
    then
        echo "[\033[1;31mKO\033[0m]"
        if [ $check = ✔ ]
            then
            echo "basic \033[1;32m$check\033[0;1m"
        else
            echo "basic \033[1;31m$check\033[0;1m"
        fi
        echo "\033[7mFailed :$str0\033[0m"
else
        echo "[\033[1;32mOK\033[0m]"
        echo "basic \033[1;32m$check\033[0m"
fi

printf "Info error   : "
print_result $KO1 $str1

printf "Color error  : "
print_result $KO2 $str2

printf "Map error    : "
print_result $KO3 $str3

printf "File error   : "
print_result $KO4 $str4

printf "Save error   : "
print_result $KO5 $str5
echo "\033[3mMake sure that no window opens when you put in argument '--save'\033[0m\n"

if [ $count -eq $nb_test ]
    then
    echo "[ \033[1;32m$count / $nb_test\033[0m ]"
    echo "\033[1;32mGreat !\033[0;1m\n"
else
    echo "[ \033[1;31m$count / $nb_test\033[0m ]"
    echo "\033[31mLOL try again !\033[3;31m\n-> Errors in KO_outputs\033[0m"
fi

rm error_msg.txt
rm failed.txt