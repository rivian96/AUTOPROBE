#! /bin/bash



echo -e "\e[35m
░█████╗░██╗░░░██╗████████╗░█████╗░██████╗░██████╗░░█████╗░██████╗░███████╗
██╔══██╗██║░░░██║╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝
███████║██║░░░██║░░░██║░░░██║░░██║██████╔╝██████╔╝██║░░██║██████╦╝█████╗░░
██╔══██║██║░░░██║░░░██║░░░██║░░██║██╔═══╝░██╔══██╗██║░░██║██╔══██╗██╔══╝░░
██║░░██║╚██████╔╝░░░██║░░░╚█████╔╝██║░░░░░██║░░██║╚█████╔╝██████╦╝███████╗
╚═╝░░╚═╝░╚═════╝░░░░╚═╝░░░░╚════╝░╚═╝░░░░░╚═╝░░╚═╝░╚════╝░╚═════╝░╚══════╝\e[0m"



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


# Prompt user to press Enter to continue

echo -e "\e[94m Press enter to continue\e[0m"

read -p "Press Enter to continue..."

echo ""

echo -e "\e[94manalysing processes from pslist\e[0m"

echo ""
echo""

echo -e "
█▀▀ ░▀░ █▀▀▄ █▀▀▀ █░░ █▀▀ ▀▀█▀▀ █▀▀█ █▀▀▄ 　 █▀▀█ █▀▀█ █▀▀█ █▀▀ █▀▀ █▀▀ █▀▀ 
▀▀█ ▀█▀ █░░█ █░▀█ █░░ █▀▀ ░░█░░ █░░█ █░░█ 　 █░░█ █▄▄▀ █░░█ █░░ █▀▀ ▀▀█ ▀▀█ 
▀▀▀ ▀▀▀ ▀░░▀ ▀▀▀▀ ▀▀▀ ▀▀▀ ░░▀░░ ▀▀▀▀ ▀░░▀ 　 █▀▀▀ ▀░▀▀ ▀▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀ "

echo -e "\e[93m singleton processes are programs or services on acomputer
that are designed to run only one instance at a time. 
This means that no matter how many times you try to start the process,
it will only run one copy\e[0m"

echo ""

echo -e "\e[94mOffset(V)  Name                    PID   PPID   Thds     Hnds   Sess  Wow64 Start                          Exit                          \e[0m"

grep -E -i "(system|winit|lsass|lsm|services|smss|logonUI|rdpclip|wisptis|WaaSMediSvc)" $res/pslist_$1\_.txt > $res/pslist_singletons_$1\_.txt

cat $res/pslist_singletons_$1\_.txt

# Prompt user to press Enter to continue

echo -e "\e[94m Press enter to continue\e[0m"

read -p "Press Enter to continue..."


echo -e "\e[93m
█░░░█ ░▀░ █▀▀▄ █▀▀▄ █▀▀█ █░░░█ █▀▀ 　 █▀▀ █▀▀█ █▀▀█ █▀▀ 
█▄█▄█ ▀█▀ █░░█ █░░█ █░░█ █▄█▄█ ▀▀█ 　 █░░ █░░█ █▄▄▀ █▀▀ 
░▀░▀░ ▀▀▀ ▀░░▀ ▀▀▀░ ▀▀▀▀ ░▀░▀░ ▀▀▀ 　 ▀▀▀ ▀▀▀▀ ▀░▀▀ ▀▀▀ 

█▀▀█ █▀▀█ █▀▀█ █▀▀ █▀▀ █▀▀ █▀▀ █▀▀ █▀▀ 
█░░█ █▄▄▀ █░░█ █░░ █▀▀ ▀▀█ ▀▀█ █▀▀ ▀▀█ 
█▀▀▀ ▀░▀▀ ▀▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀ \e[0m"

echo -e "\e[35mWindows core processes are essential programs or services 
that are fundamental to the operation of the Windows operating system...\e[0m"


echo ""

grep -E -i "(System Idle Process|System|smss|csrss|wininit|services|lsass|svchost|explorer|winlogon|spoolsv|lsass|dllhost|dwm|taskhost|spoolsv|lsaiso|SearchIndexer|RuntimeBroker|SecurityHealthService|NisSrv|WmiPrvSE|PresentationFontCache|csrss|winlogon|LogonUI|fontdrvhost|WUDFHost|WmiApSrv|wininit|conhost|taskhostw|rdpclip|wisptis|WaaSMedicSvc)" $res/pslist_$1\_.txt > $res/pslist_windowscore_$1\_.txt


echo -e "\e[94mOffset(V)  Name                    PID   PPID   Thds     Hnds   Sess  Wow64 Start                          Exit                          \e[0m"

cat $res/pslist_windowscore_$1\_.txt

# Prompt user to press Enter to continue

echo -e "\e[94m Press enter to continue\e[0m"

read -p "Press Enter to continue..."


echo ""

echo -e "\e[95m
░█▄─░█ █▀▀█ █▀▀▄ 　 █▀▀ █▀▀█ █▀▀█ █▀▀ 　 █▀▀█ █▀▀█ █▀▀█ █▀▀ █▀▀ █▀▀ █▀▀ █▀▀ █▀▀ 
░█░█░█ █──█ █──█ 　 █── █──█ █▄▄▀ █▀▀ 　 █──█ █▄▄▀ █──█ █── █▀▀ ▀▀█ ▀▀█ █▀▀ ▀▀█ 
░█──▀█ ▀▀▀▀ ▀──▀ 　 ▀▀▀ ▀▀▀▀ ▀─▀▀ ▀▀▀ 　 █▀▀▀ ▀─▀▀ ▀▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀\e[0m"

echo -e "\e[34mThese processes are highly\e[0m \e[31mSUSPICIOUS\e[0m "

echo -e "\e[95mBecause these processes are typically user-installed applications, 
background services, or utilities that provide additional functionalities 
beyond what the operating system offers by default\e[0m"


grep -E -i -v "(System Idle Process|System|smss|csrss|wininit|services|lsass|svchost|explorer|winlogon|spoolsv|lsass|dllhost|dwm|taskhost|spoolsv|lsaiso|SearchIndexer|RuntimeBroker|SecurityHealthService|NisSrv|WmiPrvSE|PresentationFontCache|csrss|winlogon|LogonUI|fontdrvhost|WUDFHost|WmiApSrv|wininit|conhost|taskhostw|rdpclip|wisptis|WaaSMedicSvc)" $res/pslist_$1\_.txt > $res/pslist_Noncore_$1\_.txt

echo -e "\e[94mOffset(V)  Name                    PID   PPID   Thds     Hnds   Sess  Wow64 Start                          Exit                          \e[0m"

cat $res/pslist_Noncore_$1\_.txt


# Prompt user to press Enter to continue

echo -e "\e[94m Press enter to continue\e[0m"

read -p "Press Enter to continue..."



echo -e "\e[31m Now Let's look at the parent child relationship  \e[0m "

volatility -f $1 --profile=$kdbg psscan --output=dot --output-file=psscan.dot

xdot psscan.dot
