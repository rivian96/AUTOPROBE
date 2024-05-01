#! /bin/bash

#script to run volatility plugins

echo -e "\e[36m
░█████╗░██╗░░░██╗████████╗░█████╗░██████╗░██████╗░░█████╗░██████╗░███████╗
██╔══██╗██║░░░██║╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝
███████║██║░░░██║░░░██║░░░██║░░██║██████╔╝██████╔╝██║░░██║██████╦╝█████╗░░
██╔══██║██║░░░██║░░░██║░░░██║░░██║██╔═══╝░██╔══██╗██║░░██║██╔══██╗██╔══╝░░
██║░░██║╚██████╔╝░░░██║░░░╚█████╔╝██║░░░░░██║░░██║╚█████╔╝██████╦╝███████╗
╚═╝░░╚═╝░╚═════╝░░░░╚═╝░░░░╚════╝░╚═╝░░░░░╚═╝░░╚═╝░╚════╝░╚═════╝░╚══════╝\e[0m"

echo -e "\e[31mHello, World!\e[0m"

# echo "usage: autoprobe.sh <memory image>"

# echo "example: ./autoprobe.sh memory_image.dat"

# echo ""

# #start of autoporbe script
# echo "******************"
# echo "**autoprobe has started**"
# echo "******************"
# echo ""

# echo "scanning results will be saved in the /results folder"
# echo "files extracted from memory will be saved to the /exports folder"
# echo ""

# #setup operations

# mkdir results
# mkdir exports

# res=results
# exp=exports

# echo ""
# echo "identifying the KDBG signature with imageinfo,results pending"
# echo ""

# date > $res/imageinfo_"$1"\_.txt
# volatility -f $1 imageinfo | tee -a $res\imageinfo_"$1"\_.txt

# echo ""
# echo "enter the KDBG signature to use for this memory image,example win2000xbbf1"
# read kdbg
# echo ""

# echo "the operating system profile selected is : --profile="$kdbg

# exec 2>/dev/null