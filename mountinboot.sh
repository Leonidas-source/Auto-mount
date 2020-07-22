#!/bin/bash
reg() {
  clear
  echo "Do you have a folder for your partition?
  1) Yes
  2) No"
  read answr2
  [ "$answr2" == "1" ] && ihavefolder
  [ "$answr2" == "2" ] && idonthavefolder
  clear
}
sw() {
  clear
  lsblk
  echo "Set your swap partition"
  read answr7
  clear
  answr8=$(lsblk -f $answr7 -o UUID | sed s/"UUID"/""/g | sed '/^$/d;s/[[:blank:]]//g')
  echo "UUID="$answr8 none swap defaults 0 0 | cat >> /etc/fstab
}
ihavefolder() {
  clear
  ls
  echo "What is your folder name?"
  read answr3
  clear
  answr10=$(readlink -f $answr3)
  clear
  lsblk
  echo "Set your partition"
  read answr11
  clear
  answr12=$(lsblk -f $answr11 -o FSTYPE | sed s/"FSTYPE"/""/g)
  clear
  answr13=$(lsblk -f $answr11 -o UUID | sed s/"UUID"/""/g | sed '/^$/d;s/[[:blank:]]//g')
  echo "UUID="$answr13 $answr10 $answr12 defaults,rw 0 0 | cat >> /etc/fstab
}
idonthavefolder() {
  clear
  echo "Set name for your folder"
  read answr4
  mkdir $answr4
  clear
  answr5=$(readlink -f $answr4)
  clear
  lsblk
  echo "Set your partition"
  read answr6
  clear
  answr9=$(lsblk -f $answr6 -o FSTYPE | sed s/"FSTYPE"/""/g)
  clear
  answr14=$(lsblk -f $answr6 -o UUID | sed s/"UUID"/""/g | sed '/^$/d;s/[[:blank:]]//g')
  echo "UUID="$answr14 $answr5 $answr9 defaults,rw 0 0 | cat >> /etc/fstab
}
clear
echo "Set your partition type
1) Regular
2) Swap"
read answr
clear
[ "$answr" == "1" ] && reg
[ "$answr" == "2" ] && sw
