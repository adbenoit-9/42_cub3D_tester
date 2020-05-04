#!/bin/bash

##########################################################################################
###################################### TESTER CUB3D ######################################
##########################################################################################

pwd_cub3d=..

#first line message in error case
echo "Error" > correct.txt

#OK message
echo "destroy window done." > correct2.txt
echo "" > empty.txt

nb_test=42
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
            $pwd_cub3d/cub3d $tests_file/$test > $outputs_file/$test
            var=$(srcs/compare/comp $outputs_file/$test correct2.txt)
            if [ var = 0 ]
                then
                var=$(srcs/compare/comp $outputs_file/$test empty.txt)
            fi
            if [ $var = $ok ]
                then
                count=$(($count+1))
                rm  $outputs_file/$test
            else
                KO=$(($KO+1))
                str+=" $test"
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
            $pwd_cub3d/cub3d $tests_file/$test > $outputs_file/$test
            var=$(srcs/compare/comp $outputs_file/$test correct.txt)
            if [ $var = $ok ]
                then
                count=$(($count+1))
                rm  $outputs_file/$test
            else
                KO=$(($KO+1))
                str+=" $test"
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
        $pwd_cub3d/cub3d $tests_file/basic.cub $save > $outputs_file/$save.txt
        var=$(srcs/compare/comp $outputs_file/$save.txt correct.txt)
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
    while [ $i -lt $tot_test ]
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
        echo "[\033[1;32mOK\033[0;1m]"
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

rm tests_bonus/*
all_tests=$(ls tests/)
echo $all_test
if [ -z $arg ]
    then
    make
    tests_file=tests
    outputs_file=KO_outputs
elif [ $arg = "bonus" ]
    then
    make bonus
    tests_file=tests_bonus
    outputs_file=KO_bonus_outputs
    add_bonus $all_tests
else
    echo "\"$arg\" invalid option"
    echo "usage: testcub3D.sh"
    echo "    or testcub3D.sh bonus"
    exit
fi

rm -rf KO_outputs
rm -rf KO_bonus_outputs
mkdir $outputs_file/

if [ -f $pwd_cub3d/cub3d ]
    then
    continue
else
    echo "\nCompilation of \033[33;1mcub3d\033[0;1m: [\033[1;31mKO\033[0;1m]"
    exit
fi
printf "\n\n"



str=""
KO=0
$pwd_cub3d/cub3d $tests_file/basic.cub > $outputs_file/basic.cub
var=$(srcs/compare/comp $outputs_file/basic.cub correct2.txt)
if [ var = 0 ]
    then
    var=$(srcs/compare/comp $outputs_file/basic.cub empty.txt)
fi
if [ $var = $ok ]
    then
    count=$(($count+1))
    rm  $outputs_file/basic.cub
else
    KO=$(($KO+1))
    str+=" basic.cub"
    check=𐄂
fi

good_map test.cub test11..cub test19.cub test32.cub test33.cub
str0=$str
KO0=$KO
#######################

KO=0
str=""
error_map test0.cub test1.cub test15.cub test16.cub test17.cub test20.cub test21.cub test24.cub test25.cub test27.cub test28.cub test29.cub test34.cub
str1=$str
KO1=$KO
#######################

KO=0
str=""
error_map test3.cub test8.cub test14.cub test26.cub test35.cub test36.cub
str2=$str
KO2=$KO
#######################

KO=0
str=""
error_map test4.cub test5.cub test6.cub test7.cub test9.cub test18.cub test22.cub test23.cub test30.cub test31.cub
str3=$str
KO3=$KO
#######################

KO=0
str=""
error_map test10.cu test12.Cub test13.cubi absent.cub
str4=$str
KO4=$KO
#######################

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
echo "\033[1;36mYou need to get the good map : basic\033[0;1m \033[1;32m✔\033[0;1m \033[1;36mfor the rest of the tester !\033[0m"
printf "\n"

printf "Good map     : "

if [ $KO0 != 0 ]
    then
        echo "[\033[1;31mKO\033[0;1m]"
        if [ $check = ✔ ]
            then
            echo "basic \033[1;32m$check\033[0;1m"
        else
            echo "basic \033[1;31m$check\033[0;1m"
        fi
        echo "\033[7mFailed :$str0\033[0m"
else
        echo "[\033[1;32mOK\033[0;1m]"
        echo "basic \033[1;32m$check\033[0;1m"
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

if [ $count -eq $nb_test ]
    then
    echo "[ \033[1;32m$count / $nb_test\033[0;1m ]"
    echo "\033[1;32mGreat !\033[0;1m\n"
else
    echo "[ \033[1;31m$count / $nb_test\033[0;1m ]"
    echo "\033[1;31mLOL try again !\033[0;1m\n"
fi

make fclean
rm correct.txt
rm correct2.txt
rm empty.txt