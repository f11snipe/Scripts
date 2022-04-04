#! /bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi


read -p "Enter the directory location: " DIR

echo "Dir location you enter to save progress $DIR"

read -p "Enter the IP: " IP

echo "The IP you are using $IP"

read -p "Add Dir name if Ctf: " Ctf     

cd $DIR

mkdir Results

cd Results

# If you want Ctf box name Directory otherwise Make Ip name Directory

if [$Ctf != ""]; then
mkdir $Ctf
cd $Ctf
else
mkdir $IP
cd $IP 
fi

# Tools list you can add in the one you use mostly or use same 

echo -e "Select multiple tools for scan

   #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
   #  1. Nmap                          #
   #  2. Dirsearch                     #
   #  3. Nikto                         #
   #  4. Sublister                     #
   #  5. Gobuster                      #
   #  6. Sqlmap                        #
   #  7. Wpscan                        #
   #  8. Hamster     
   #  9. Nuclei
   #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
"

read -a tools;

for tool in $tools
do

case $tool in
        1) nmap -sC -sV -p- -T4 -n -v $IP -oN nmap ;;
        2) sudo dirsearch -u $IP -q -r -e php,js,db,xml,html -i 200-299,300-399,500-599 -format simple -o dirsearch;;
        3) nikto -url $IP -no404 -C all -Format txt -o nikto;;
        4) sublist3r -d $IP -o sublister;;
        5) gobuster dir $IP -w /usr/share/wordlists/dirbuster/directory-list-lowercase-2.3-medium.txt -q -t 3 -r -x php,js,db,xml,html -o gobuster;;
        6) sudo nuclei -u $IP 

        *) 
        
        echo "invalid option script restarting"
        clear
        sleep 3;;
esac
done


# remove history

rm -rf /home/clown/.zsh_history

rm -rf /home/clown/.bash_history

