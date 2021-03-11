#!/bin/bash

# settings
colLengh=$(tput cols)


# Menu
menuSel=""

# Style
clear='\e[0;39m'
red='\e[31m'
green='\e[32m'
yellow='\e[33m'
italic='\e[3m'
mainMenu='\e[3;33m'

if [ "$EUID" -ne 0 ]
  then echo -e "${red}\n ✖ Please run as root!\n"
  exit
fi

function divisor {
  for (( i=1; i<=$colLengh; i++ ))
  do
    echo -n "-"
  done
  
  echo -e "\n"
}

function infoHelp {
  if [ "$1" != "-h" ] && [ "$1" != "--help" ]; then
    divisor;
    echo -e "${red}  ✖ Unknown parameter passed:  $1${clear}\n";
    divisor;
  fi

  echo -e "${mainMenu}Usage:${clear} install.sh <option>\n"
  echo -e "${mainMenu}Operations:${clear}"
  echo -e "   install.sh {-c  --current}
   | Installs the configs on the current machine\n"
  echo -e "   install.sh {-n  --new}
   | Installs the configs on a new partition\n"
   echo -e "   install.sh {-h  --help}
   | Shows this help message"

   echo -e "\n" 

}

function newMachine {
  echo -e "\n${red}! Beyond this point there is not going back !${clear}\n"
  echo -e "${yellow}Please select a partition: ${clear}"

  disks=$(lsblk -o NAME,SIZE)
  disksFormatted=(${disks//\\n/ })

  numberOfPartitions=$(( (( ${#disksFormatted[@]} - 4)) / 2 ))

  for (( i=4; i<${#disksFormatted[@]}; i=i+2 ))
  do
    diskFormatted="[$(( i/2 - 1 ))] - ${disksFormatted[$i]} ${disksFormatted[$i+1]}"
    (( partitionN++ ))
    echo $diskFormatted
  done
  
  divisor;

  read partition

  while [ $partition -gt $numberOfPartitions ]
  do
    echo -e "${yellow}Please select a partition:${clear}"
    read partition
  done

  selectedPartition=${disksFormatted[$(( partition*2+2 ))]/├─/}
  selectedPartition=${selectedPartition/└─/}

  echo -e "\n${green}You selected: ${selectedPartition}${clear}"

  if [ ! -d "/mnt/newinstall" ]; then
    mkdir /mnt/newinstall
  fi

  sudo mount /dev/${selectedPartition} /mnt/newinstall
  echo -e "${green}Partition mounted!${clear}"

  pacstrap -i /mnt/newinstall base base-devel git nano --noconfirm
}

function currentMachine {
  echo "currentMachine"
}


while [[ "$#" > 0 ]]; do case $1 in
  -h|--help) infoHelp $1; shift; shift;;
  -n|--new) newMachine; shift; shift;;
  -c|--current) currentMachine; shift; shift;;
  *) infoHelp $1; shift;;
esac; done
