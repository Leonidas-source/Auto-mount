#!/bin/bash
reg() {
  clear
  echo "Do you have a folder for your partition(yes/no)?"
  read answr2
  [ "$answr2" == "yes" ] && ihavefolder
  [ "$answr2" == "no" ] && idonthavefolder
  clear
}
sw() {
  clear
  lsblk
  echo "Set your swap partition"
  read answr7
  clear
  lsblk -f $answr7
  echo "Set UUID for swap partition"
  read answr8
  echo "UUID="$answr8 none swap defaults 0 0 | cat >> /etc/fstab
}
ihavefolder() {
  clear
  ls
  echo "What is your folder name?"
  read answr3
  clear
  readlink -f $answr3
  echo "Copy path to the folder"
  read answr10
  clear
  lsblk
  echo "Set your partition"
  read answr11
  clear
  lsblk -f $answr11
  echo "Set your filesystem"
  read answr12
  clear
  lsblk -f $answr11
  echo "Set UUID for your partition"
  read answr13
  echo "UUID="$answr13 $answr10 $answr12 defaults,rw 0 0 | cat >> /etc/fstab
}
idonthavefolder() {
  clear
  echo "Set name for your folder"
  read answr4
  mkdir $answr4
  clear
  readlink -f $answr4
  echo "Copy path to the folder"
  read answr5
  clear
  lsblk
  echo "Set your partition"
  read answr6
  clear
  lsblk -f $answr6
  echo "Set your filesystem"
  read answr9
  clear
  lsblk -f $answr6
  echo "Set UUID for your partition"
  read answr14
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
