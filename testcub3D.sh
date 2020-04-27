#!/bin/bash

pwd_cub3d=..

#first line massage in error case
echo "Error" > correct.txt
#OK message
echo "destroy window done." > correct2.txt

count=0
make
printf "\n"
echo "\033[34;1mTESTS\033[0;1m"
printf "\n"
echo "you need to get the good map [\033[1;32mOK\033[0;1m] for the rest of the tester !"
printf "Good map  :\n"
$pwd_cub3d/cub3d tests/test.cub > output.txt
var=$(srcs/comp output.txt correct2.txt)
ok=1
if [ $var = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

###########################
printf "\nInfo error  :\n"
$pwd_cub3d/cub3d tests/test0.cub > output.txt
var0=$(srcs/comp output.txt correct.txt)
if [ $var0 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

$pwd_cub3d/cub3d tests/test1.cub > output.txt
var1=$(srcs/comp output.txt correct.txt)
if [ $var1 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

$pwd_cub3d/cub3d tests/test15.cub > output.txt
var15=$(srcs/comp output.txt correct.txt)
if [ $var15 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

$pwd_cub3d/cub3d tests/test16.cub > output.txt
var16=$(srcs/comp output.txt correct.txt)
if [ $var16 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

$pwd_cub3d/cub3d tests/test17.cub > output.txt
var17=$(srcs/comp output.txt correct.txt)
if [ $var17 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

######################################
printf "\nColor error :\n"
$pwd_cub3d/cub3d tests/test3.cub > output.txt
var3=$(srcs/comp output.txt correct.txt)
if [ $var3 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

$pwd_cub3d/cub3d tests/test8.cub > output.txt
var8=$(srcs/comp output.txt correct.txt)
if [ $var8 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

$pwd_cub3d/cub3d tests/test14.cub > output.txt
var14=$(srcs/comp output.txt correct.txt)
if [ $var14 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

########################################
 printf "\nMap error :\n"
$pwd_cub3d/cub3d tests/test4.cub > output.txt
var4=$(srcs/comp output.txt correct.txt)
if [ $var4 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

$pwd_cub3d/cub3d tests/test5.cub > output.txt
var5=$(srcs/comp output.txt correct.txt)
if [ $var5 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

$pwd_cub3d/cub3d tests/test6.cub > output.txt
var6=$(srcs/comp output.txt correct.txt)
if [ $var6 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

$pwd_cub3d/cub3d tests/test7.cub > output.txt
var7=$(srcs/comp output.txt correct.txt)
if [ $var7 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

$pwd_cub3d/cub3d tests/test9.cub > output.txt
var9=$(srcs/comp output.txt correct.txt)
if [ $var9 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

$pwd_cub3d/cub3d tests/test18.cub > output.txt
var18=$(srcs/comp output.txt correct.txt)
if [ $var18 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

#######################################
printf "\nFile error :\n"
$pwd_cub3d/cub3d tests/test10.cu > output.txt
var10=$(srcs/comp output.txt correct.txt)
if [ $var10 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

$pwd_cub3d/cub3d tests/test11..cub > output.txt
var11=$(srcs/comp output.txt correct2.txt)
if [ $var11 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

$pwd_cub3d/cub3d tests/test12.Cub > output.txt
var12=$(srcs/comp output.txt correct.txt)
if [ $var12 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

$pwd_cub3d/cub3d tests/test13.cubi > output.txt
var13=$(srcs/comp output.txt corrects.txt)
if [ $var13 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

$pwd_cub3d/cub3d srcs/absent.cub > output.txt
var19=$(srcs/comp output.txt correct.txt)
if [ $var19 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

#####################################
printf "\n--save error :\n"
$pwd_cub3d/cub3d tests/test.cub --sav > output.txt
var20=$(srcs/comp output.txt correct.txt)
if [ $var20 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

$pwd_cub3d/cub3d tests/test.cub -save > output.txt
var21=$(srcs/comp output.txt correct.txt)
if [ $var21 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

$pwd_cub3d/cub3d tests/test.cub --saves > output.txt
var22=$(srcs/comp output.txt correct.txt)
if [ $var22 = $ok ]
    then
    {
        count=$(($count+1))
        echo "[\033[1;32mOK\033[0;1m]"
    }
    else
        echo "[\033[1;31mKO\033[0;1m]"
fi

printf "\n"
if [ $count -eq 23 ]
    then
    {
        echo "[ \033[1;32m$count / 23\033[0;1m ]"
        echo "\033[1;32mGood job my love !\033[0;1m"
    }
    else
        {
        echo "[ \033[1;31m$count / 23\033[0;1m ]"
        echo "\033[1;31mLOL try again !\033[0;1m"
    }
fi

make fclean
rm *.txt