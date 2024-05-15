#! /bin/bash


echo -e "\e[35m
░█████╗░██╗░░░██╗████████╗░█████╗░██████╗░██████╗░░█████╗░██████╗░███████╗
██╔══██╗██║░░░██║╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝
███████║██║░░░██║░░░██║░░░██║░░██║██████╔╝██████╔╝██║░░██║██████╦╝█████╗░░
██╔══██║██║░░░██║░░░██║░░░██║░░██║██╔═══╝░██╔══██╗██║░░██║██╔══██╗██╔══╝░░
██║░░██║╚██████╔╝░░░██║░░░╚█████╔╝██║░░░░░██║░░██║╚█████╔╝██████╦╝███████╗
╚═╝░░╚═╝░╚═════╝░░░░╚═╝░░░░╚════╝░╚═╝░░░░░╚═╝░░╚═╝░╚════╝░╚═════╝░╚══════╝\e[0m"

echo ""

echo -e "\e[31m usage: autoprobe.sh <memory image> \e[0m"


# Display menu options
while true; do
    echo "Menu Options:"
    echo "1. Process Investigation"
    echo "2. Exit"

    read -p "Enter your choice (1 or 2): " choice

    case $choice in
        1)
            echo ""
            echo -e "\e[92mProcess Investigation:\e[0m"
            echo ""
            echo -e "\e[94m---------------------\e[0m"
            echo -e "\e[1m \e[33mAutoprobe Methodology\e[0m \e[0m"
            echo -e "\e[94m--------------------\e[0m"
            echo ""
            echo -e "\e[1m \e[92m1. Identifying the image\e[0m \e[0m"
            echo -e "\e[1m \e[33m2. Listing processes using pslist\e[0m \e[0m"
            echo -e "\e[1m \e[33m3. Listing processes using psscan\e[0m \e[0m"
            echo -e "\e[1m \e[33m4. listing processes using psxview\e[0m \e[0m"
            echo -e "\e[1m \e[35m5. Comparing the results to identify suspicious processese[0m \e[0m \e[0m"
            echo -e "\e[1m \e[35m6. Filtering and categorizing processes (singleton, windows core, non-core)\e[0m \e[0m"
            echo -e "\e[1m \e[35m7. Inspecting handles for selected processes\e[0m \e[0m"

            echo ""
            
            read -p "press Enter to continue..."

            # Run the process investigation section of the script
            # Add your existing code for process investigation here

            echo ""



# Function to delete existing results and exports folders
delete_existing_folders() {
    if [ -d "results" ]; then
        rm -r results
    fi
    if [ -d "exports" ]; then
        rm -r exports
    fi
}

# Check if results and exports folders exist
if [ -d "results" ] || [ -d "exports" ]; then
    
    delete_existing_folders
fi
echo ""


# Create new results and exports folders
mkdir results
mkdir exports




# echo ""






echo -e "\e[33m scanning results will be saved in the /results folder \e[0m"
echo -e  "\e[33m files extracted from memory will be saved to the /exports folder \e[0m"

echo ""


res=results
exp=exports

# echo ""


# echo ""

date > $res/imageinfo_"$1"\_.txt
volatility -f $1 imageinfo | tee -a $res\imageinfo_"$1"\_.txt

echo ""
echo -e " \e[1m \e[31m enter the KDBG signature to use for this memory image,example win2000xbbf1 \e[0m \e["

read kdbg

echo ""

echo -e "\e[33m the operating system profile selected is : --profile=\e[0m"$kdbg

exec 2>/dev/null

# automating pslist and psscan

echo -e "listing processes \e[31m{pslist}\e[0m"

echo -e "\e[33m
╭━╮╱╭┳━━━┳━━━━┳━━━╮
┃┃╰╮┃┃╭━╮┃╭╮╭╮┃╭━━╯
┃╭╮╰╯┃┃╱┃┣╯┃┃╰┫╰━━╮
┃┃╰╮┃┃┃╱┃┃╱┃┃╱┃╭━━╯
┃┃╱┃┃┃╰━╯┃╱┃┃╱┃╰━━╮
╰╯╱╰━┻━━━╯╱╰╯╱╰━━━╯\e[0m"


echo -e "\e[94m The pslist module list the processes from memory like the task manager does, 
so it will not be able to find terminated processes and processes hidden by rootkits..\e[0m"

echo -e "\e[94mThe windows kernel uses the EPROCESS data structure to describe each running process
pslist traverses the list of active process structures that the Windows kernel maintains.\e[0m"

echo -e "\e[35m more on: \e[0m"
echo -e "\e[92m http://akovid.blogspot.com/2014/02/difference-between-pslist-and-psscan.html\e[0m"

echo ""

volatility -f $1 --profile=$kdbg pslist | tee -a $res/pslist_"$1"\_.txt  


echo ""

echo -e  "\e[36m Now Let's look at the parent child relationships of the above listed processes..
by \e[33mpslist module\e[0m  \e[0m"



# Prompt user to press Enter to continue

echo -e "\e[94m Press enter to continue\e[0m"

read -p "Press Enter to continue..."

volatility -f $1 --profile=$kdbg pstree --output=dot --output-file=$res/pstree_"$1"\_.dot

xdot $res/pstree_"$1"\_.dot



echo ""



echo -e "\e[92m
╭━╮╱╭┳━━━┳━━━━┳━━━╮
┃┃╰╮┃┃╭━╮┃╭╮╭╮┃╭━━╯
┃╭╮╰╯┃┃╱┃┣╯┃┃╰┫╰━━╮
┃┃╰╮┃┃┃╱┃┃╱┃┃╱┃╭━━╯
┃┃╱┃┃┃╰━╯┃╱┃┃╱┃╰━━╮
╰╯╱╰━┻━━━╯╱╰╯╱╰━━━╯\e[0m"

echo -e "\e[103mThe psscan module scans the whole memory for process structures 
and is able to find both hidden an terminated processes.\e[0m"

volatility -f $1 --profile=$kdbg psscan | tee -a $res/psscan_"$1"\_.txt



echo ""

echo -e "\e[31m Now Let's look at the parent child relationship 
from the above psscan result \e[0m "

# Prompt user to press Enter to continue

echo -e "\e[94m Press enter to continue\e[0m"

read -p "Press Enter to continue..."


volatility -f $1 --profile=$kdbg psscan --output=dot --output-file=$res/psscan_"$1"\_.dot

xdot $res/psscan_"$1"\_.dot




echo -e "\e[103m By comparing the results from both pslist and psscan 
will show which processes where actually hidden or terminated\e[0m"


cat $res/psscan_"$1"\_.txt | grep -E --color $(cat $res/pslist_"$1"\_.txt $res/psscan_"$1"\_.txt | cut -d " " -f2 | sort | uniq -c | grep "1" | cut -d " " -f8 | grep -v "-" | tr '\n' '|')

echo ""

echo -e "\e[34mthe process name in red shows that these processes are not preasent in the pslist result\e[0m"

echo ""

echo -e "\e[33mpsscan plugin relies on proc tag which is a great way to identify
processes.But it turns out that if an attacker can somehow install a
kernel driver on a system then they can modify the proc tag for their purposes..\e[0m"

echo ""

echo -e "\e[94mUsing the Volatility psxview plugin, 
we can see if the process appears in pslist and psscan plugin by the boolean value True. 
 A False within the column indicates that the process is not found in that area.
This allows the analyst to review the list and determine if there’s a legitimate reason for that.\e[0m"

echo ""

volatility -f $1 --profile=$kdbg psxview | tee -a $res/psxview_"$$1"\_.txt

echo ""

echo -e "\e[92mresults of psxview after applying some rules..\e[0m"

volatility -f $1 --profile=$kdbg psxview -R | tee -a $res/psxviewrules_"$1"\_.txt 


echo ""
echo ""

echo -e "
█▀▀ ░▀░ █▀▀▄ █▀▀▀ █░░ █▀▀ ▀▀█▀▀ █▀▀█ █▀▀▄ 　 █▀▀█ █▀▀█ █▀▀█ █▀▀ █▀▀ █▀▀ █▀▀ 
▀▀█ ▀█▀ █░░█ █░▀█ █░░ █▀▀ ░░█░░ █░░█ █░░█ 　 █░░█ █▄▄▀ █░░█ █░░ █▀▀ ▀▀█ ▀▀█ 
▀▀▀ ▀▀▀ ▀░░▀ ▀▀▀▀ ▀▀▀ ▀▀▀ ░░▀░░ ▀▀▀▀ ▀░░▀ 　 █▀▀▀ ▀░▀▀ ▀▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀ "

echo -e "\e[94m singleton processes are programs or services on acomputer
that are designed to run only one instance at a time. 
This means that no matter how many times you try to start the process,
it will only run one copy\e[0m"

echo ""

echo -e "\e[94mOffset(V)  Name                    PID   PPID   Thds     Hnds   Sess  Wow64 Start                          Exit                          \e[0m"

grep -E -i "(system|winit|lsass|lsm|services|smss|logonUI|rdpclip|wisptis|WaaSMediSvc)" $res/pslist_$1\_.txt > $res/pslist_singletons_$1\_.txt

cat $res/pslist_singletons_$1\_.txt




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




echo ""

echo -e "
░█▄─░█ █▀▀█ █▀▀▄ 　 █▀▀ █▀▀█ █▀▀█ █▀▀ 　 █▀▀█ █▀▀█ █▀▀█ █▀▀ █▀▀ █▀▀ █▀▀ █▀▀ █▀▀ 
░█░█░█ █──█ █──█ 　 █── █──█ █▄▄▀ █▀▀ 　 █──█ █▄▄▀ █──█ █── █▀▀ ▀▀█ ▀▀█ █▀▀ ▀▀█ 
░█──▀█ ▀▀▀▀ ▀──▀ 　 ▀▀▀ ▀▀▀▀ ▀─▀▀ ▀▀▀ 　 █▀▀▀ ▀─▀▀ ▀▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀ "


echo -e "\e[94m*************\e[0m"
echo -e "\e[36mPSLIST\e[0m"
echo -e "\e[94m*************\e[0m"


echo -e "\e[34mThese processes are highly\e[0m \e[31mSUSPICIOUS\e[0m "


echo -e "\e[93mBecause these processes are typically user-installed applications, 
background services, or utilities that provide additional functionalities 
beyond what the operating system offers by default\e[0m"


grep -E -i -v "(System Idle Process|System|smss|csrss|wininit|services|lsass|svchost|explorer|winlogon|spoolsv|lsass|dllhost|dwm|taskhost|spoolsv|lsaiso|SearchIndexer|RuntimeBroker|SecurityHealthService|NisSrv|WmiPrvSE|PresentationFontCache|csrss|winlogon|LogonUI|fontdrvhost|WUDFHost|WmiApSrv|wininit|conhost|taskhostw|rdpclip|wisptis|WaaSMedicSvc)" $res/pslist_$1\_.txt > $res/pslist_Noncore_$1\_.txt


cat $res/pslist_Noncore_$1\_.txt




echo -e "
░█▄─░█ █▀▀█ █▀▀▄ 　 █▀▀ █▀▀█ █▀▀█ █▀▀ 　 █▀▀█ █▀▀█ █▀▀█ █▀▀ █▀▀ █▀▀ █▀▀ █▀▀ █▀▀ 
░█░█░█ █──█ █──█ 　 █── █──█ █▄▄▀ █▀▀ 　 █──█ █▄▄▀ █──█ █── █▀▀ ▀▀█ ▀▀█ █▀▀ ▀▀█ 
░█──▀█ ▀▀▀▀ ▀──▀ 　 ▀▀▀ ▀▀▀▀ ▀─▀▀ ▀▀▀ 　 █▀▀▀ ▀─▀▀ ▀▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀ "


echo -e "\e[94m*************\e[0m"
echo -e "\e[36mPSSCAN\e[0m"
echo -e "\e[94m*************\e[0m"

echo -e "\e[33m On analysing the results from psscan and pslist we can find the processes which are terminated\e[0m"


grep -E -i -v "(System Idle Process|System|smss|csrss|wininit|services|lsass|svchost|explorer|winlogon|spoolsv|lsass|dllhost|dwm|taskhost|spoolsv|lsaiso|SearchIndexer|RuntimeBroker|SecurityHealthService|NisSrv|WmiPrvSE|PresentationFontCache|csrss|winlogon|LogonUI|fontdrvhost|WUDFHost|WmiApSrv|wininit|conhost|taskhostw|rdpclip|wisptis|WaaSMedicSvc)" $res/psscan_$1\_.txt > $res/psscan_Noncore_$1\_.txt


cat $res/psscan_Noncore_$1\_.txt

# Inform the user that all processes have been listed
echo -e "\e[94mAll processes have been listed. Now, let's look at the handles.\e[0m"

while true; do
    # Prompt the user to enter the PID for the specific process they want to examine handles for
    echo -e "\e[92mEnter the PID of the process for which you want to examine handles:\e[0m"

    read -p "Enter the PID of the process for which you want to examine handles: " pid

    # Run Volatility's handles plugin to gather information about objects and handles for the specified process
    echo -e "\e[92mAnalyzing objects and handles for process $pid\e[0m"
    volatility -f $1 --profile=$kdbg handles -p $pid | tee -a results/handles_$pid.txt

    echo ""
    echo -e "\e[33mAnalysis completed for process $pid\e[0m"
    echo ""

    # Ask the user if they want to analyze handles for another process
    echo -e "\e[94mDo you want to analyze handles for another process? (yes/no): \e[0m"

    read -p "Do you want to analyze handles for another process? (yes/no): " choice

    if [ "$choice" != "yes" ]; then
        break
    fi
done

echo -e "\e[96mHandle analysis completed for the processes.\e[0m"

            ;;
        2)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter 1 or 2."
            ;;
    esac
done
