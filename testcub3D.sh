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

progress_anim(){
    printf "     "
    while :;
    do
        printf "\b\b\b\b\b[   ]"
        sleep 0.5
        printf "\b\b\b\b\b[.  ]"
        sleep 0.5
        printf "\b\b\b\b\b[.. ]"
        sleep 0.5
        printf "\b\b\b\b\b[...]"
        sleep 0.5
    done
}
#For good map
good_map(){
    i=1
    tot_test=$#
    tot_test=$(($tot_test+1))
    while [ $i -lt $tot_test ]
        do
            test=${!i}
            touch $outputs_file/$test
            $pwd_cub3d/cub3D $tests_file/$test > $outputs_file/$test \
            2>> $outputs_file/$test & cub_pid=$! 0> /dev/null
            sleep 0.1
            kill $cub_pid 2> /dev/null
            if [ $? = 0 ]
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
            $pwd_cub3d/cub3D $tests_file/$test > $outputs_file/$test \
            2>> $outputs_file/$test & cub_pid=$! 0> /dev/null
            sleep 0.3
            kill $cub_pid 2> /dev/null
            var=$(srcs/compare/comp $outputs_file/$test error_msg.txt)
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
        $pwd_cub3d/cub3D $tests_file/basic.cub $save > $outputs_file/$save.txt \
        2>> $outputs_file/$save.txt & cub_pid=$! 0> /dev/null
        sleep 0.1
        kill $cub_pid 2> /dev/null
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
        tmp=$(($i%2))
        if [ $tmp = 0 ]
        then
            str_KO+='\n'
        else
            str_KO+='\t'
        fi
        str_KO+=$test_KO
        i=$((i+1))
    done
    if [ $1 -ne 0 ]
        then
        echo -e "[\033[1;31mKO\033[1;0m]\033[0m"
        echo -e "\033[31mnames and outputs of the KO tests are in KO_outputs/\033[0m"
    else
        echo -e "[\033[1;32mOK\033[1;0m]\033[0m"
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
    echo -e "\"$arg\" invalid option"
    echo -e "usage: testcub3D.sh"
    echo -e "    or testcub3D.sh bonus"
    exit
fi

if [ -f $pwd_cub3d/cub3D ]
    then
    echo -n ""
else
    echo -e "\nCompilation of \033[33;1mcub3d\033[0;1m: [\033[1;31mKO\033[0;1m]"
    exit
fi

rm -rf $outputs_file
mkdir $outputs_file

###########################
########## TESTS ##########
###########################

echo -e "\033[34;1m"
cat title.txt
echo -e "\n\n\033[1;36mYou need to get the good map : basic\033[0;1m \033[1;32m✔\033[0;1m \
\033[1;36mfor the rest of the tester !\033[0m"
printf "\n"

printf "\033[33;1mTester is lauching "
progress_anim & pro_pid=$!

str=""
KO=0

basic(){
    $pwd_cub3d/cub3D $tests_file/basic.cub > $outputs_file/basic.cub \
    2>> $outputs_file/basic.cub & cub_pid=$! 0> /dev/null
    sleep 0.1
    kill $cub_pid 2> /dev/null
    if [ $? = 0 ]
    then
        count=$(($count+1))
        rm  $outputs_file/basic.cub
    else
    check=x
    fi
}

basic 2> /dev/null

good_map good_map0.cub good_map1..cub good_map2.cub good_map3.cub good_map4.cub \
good_map5.cub good_map6.cub 2> /dev/null
str0=$str
KO0=$KO

########### INFO ERR ############

KO=0
str=""
error_map info_error0.cub info_error1.cub info_error10.cub info_error11.cub \
info_error12.cub info_error13.cub info_error2.cub info_error3.cub info_error4.cub \
info_error5.cub info_error6.cub info_error7.cub info_error8.cub info_error9.cub 2> /dev/null
str1=$str
KO1=$KO

############ COLOR ERR ###########

KO=0
str=""
error_map color_error0.cub color_error1.cub color_error2.cub color_error3.cub \
color_error4.cub color_error5.cub 2> /dev/null
str2=$str
KO2=$KO

############ MAP ERR ###########

KO=0
str=""
error_map map_error0.cub map_error1.cub map_error10.cub map_error11.cub \
map_error12.cub map_error13.cub map_error14.cub map_error15.cub map_error16.cub \
map_error17.cub map_error18.cub map_error19.cub map_error2.cub map_error20.cub \
map_error21.cub map_error22.cub map_error23.cub map_error24.cub map_error3.cub \
map_error4.cub map_error5.cub map_error6.cub map_error7.cub map_error8.cub \
map_error9.cub 2> /dev/null
str3=$str
KO3=$KO

############ FILE ERR ###########

KO=0
str=""
error_map file_error0.cu file_error1.Cub file_error2.cubi file_not_found.cub 2> /dev/null
str4=$str
KO4=$KO

############ SAVE ERR ###########

KO=0
str=""
save_error --sav -save --saves 2> /dev/null
str5=$str
KO5=$KO

kill $pro_pid
wait $pro_pid 2> /dev/null

###########################
######## DISPLAY #########
###########################

if [ $check = ✔ ]
then
    echo -e "\r\033[0mbasic \033[1;32m$check                  \033[0m"
else
    echo -e "\r\033[0mbasic \033[1;31m$check                  \033[0m"
fi

echo -ne "\n\033[1mGood map     : "
print_result $KO0 $str0

echo -ne "\n\033[1mInfo error   : "
print_result $KO1 $str1

echo -ne "\n\033[1mColor error  : "
print_result $KO2 $str2

echo -ne "\n\033[1mMap error    : "
print_result $KO3 $str3

echo -ne "\n\033[1mFile error   : "
print_result $KO4 $str4

echo -ne "\n\033[1mSave error   : "
print_result $KO5 $str5
echo -e "\033[3mMake sure that no window opens when you put in argument '--save'\033[0m\n"

if [ $count -eq $nb_test ]
    then
    echo -e "[ \033[1;32m$count / $nb_test\033[0m ]"
    echo -e "\033[1;32mGreat !\033[0;1m\n"
else
    echo -e "[ \033[1;31m$count / $nb_test\033[0m ]"
    echo -e "\033[1;31mLOL try again !\033[0m\n"
fi

rm error_msg.txt
