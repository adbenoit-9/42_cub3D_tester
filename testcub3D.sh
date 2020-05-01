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
            touch KO_outputs/$test
            $pwd_cub3d/cub3d tests/$test > KO_outputs/$test
            var=$(srcs/comp KO_outputs/$test correct2.txt)
            if [ var = 0 ]
                then
                    var=$(srcs/comp KO_outputs/$test empty.txt)
            fi
            if [ $var = $ok ]
                then
                    count=$(($count+1))
                    rm  KO_outputs/$test
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
            touch KO_outputs/$test
            $pwd_cub3d/cub3d tests/$test > KO_outputs/$test
            var=$(srcs/comp KO_outputs/$test correct.txt)
            if [ $var = $ok ]
                then
                    count=$(($count+1))
                    rm  KO_outputs/$test
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
            touch KO_outputs/$save.txt
            $pwd_cub3d/cub3d tests/basic.cub $save > KO_outputs/$save.txt
            var=$(srcs/comp KO_outputs/$save.txt correct.txt)
            if [ $var = $ok ]
                then
                    count=$(($count+1))
                    rm  KO_outputs/$save.txt
            else
                     KO=$(($KO+1))
                    str+=" $save"
            fi
            i=$((i+1))
    done
}

print_result(){
    if [ $KO != 0 ]
    then
        echo "[\033[1;31mKO\033[0;1m]"
        echo "\033[7mFailed :$str\033[0m"
    else
        echo "[\033[1;32mOK\033[0;1m]"
fi
}

###########################
######## EXCUTION #########
###########################

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
echo "\033[1;36mYou need to get the good map : basic\033[0;1m \033[1;32m$check\033[0;1m \033[1;36mfor the rest of the tester !\033[0m"
printf "Good map     : "

str=""
KO=0
$pwd_cub3d/cub3d tests/basic.cub > KO_outputs/$test
var=$(srcs/comp output correct2.txt)
if [ var = 0 ]
    then
        var=$(srcs/comp KO_outputs/$test empty.txt)
fi
if [ $var = $ok ]
    then
        count=$(($count+1))
    else
        KO=$(($KO+1))
        str+=" basic.cub"
        check=𐄂
fi

good_map test.cub test11..cub test19.cub test32.cub test33.cub

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

#######################

KO=0
str=""
printf "Info error   : "

error_map test0.cub test1.cub test15.cub test16.cub test17.cub test20.cub test21.cub test24.cub test25.cub test27.cub test28.cub test29.cub test34.cub
print_result

#######################

KO=0
str=""
printf "Color error  : "

error_map test3.cub test8.cub test14.cub test26.cub test35.cub test36.cub
print_result

#######################

KO=0
str=""
printf "Map error    : "

error_map test4.cub test5.cub test6.cub test7.cub test9.cub test18.cub test22.cub test23.cub test30.cub test31.cub
print_result

#######################

KO=0
str=""
printf "File error   : "

error_map test10.cu test12.Cub test13.cubi absent.cub
print_result

#######################

KO=0
str=""
printf "Save error   : "

save_error --sav -save --saves
print_result

#######################

printf "\n"
if [ $count -eq $nb_test ]
    then
    {
        echo "[ \033[1;32m$count / $nb_test\033[0;1m ]"
        echo "\033[1;32mGreat !\033[0;1m\n"
    }
    else
        {
        echo "[ \033[1;31m$count / $nb_test\033[0;1m ]"
        echo "\033[1;31mLOL try again !\033[0;1m\n"
    }
fi

make fclean
rm *.txt