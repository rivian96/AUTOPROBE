#! /bin/bash



echo -e "\e[35m
░█████╗░██╗░░░██╗████████╗░█████╗░██████╗░██████╗░░█████╗░██████╗░███████╗
██╔══██╗██║░░░██║╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝
███████║██║░░░██║░░░██║░░░██║░░██║██████╔╝██████╔╝██║░░██║██████╦╝█████╗░░
██╔══██║██║░░░██║░░░██║░░░██║░░██║██╔═══╝░██╔══██╗██║░░██║██╔══██╗██╔══╝░░
██║░░██║╚██████╔╝░░░██║░░░╚█████╔╝██║░░░░░██║░░██║╚█████╔╝██████╦╝███████╗
╚═╝░░╚═╝░╚═════╝░░░░╚═╝░░░░╚════╝░╚═╝░░░░░╚═╝░░╚═╝░╚════╝░╚═════╝░╚══════╝\e[0m"


echo -e "\e[33m AUTOMATED MEMORY
                FORENSICS FRAMEWORK\e[0m"

echo -e "\e[31m usage: autoprobe.sh <memory image> \e[0m"


# echo ""




# echo ""

echo -e "\e[33m scanning results will be saved in the /results folder \e[0m"
echo ""
echo -e  "\e[33m files extracted from memory will be saved to the /exports folder \e[0m"
# echo ""

# #setup operations

mkdir results
mkdir exports



res=results
exp=exports

# echo ""


# echo ""

date > $res/imageinfo_"$1"\_.txt
volatility -f $1 imageinfo | tee -a $res\imageinfo_"$1"\_.txt

echo ""
echo -e " \e[31m enter the KDBG signature to use for this memory image,example win2000xbbf1 \e[0m "

read kdbg

echo ""

echo -e "\e[33m the operating system profile selected is : --profile=\e[0m"$kdbg

exec 2>/dev/null

# automating pslist and psscan

echo -e "listing processes \e[31m{pslist}\e[0m"

volatility -f $1 --profile=$kdbg pslist | tee -a $res/pslist_"$1"\_.txt  

echo ""
echo -e "listing process \e[31m {psscan}\e[0m "

volatility -f $1 --profile=$kdbg psscan --output=dot --output-file=psscan.dot

xdot psscan.dot


# Prompt user to press Enter to continue

echo " press enter to continue"

read -p "Press Enter to continue..."


