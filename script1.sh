#!/bin/bash 
 
#Author: Thaylon Roberto Muniz da Silva
#Date:28/09/2022

echo "Create by TRMS"
echo "What name of you profile in system"
read nameProfile

echo "Machine Name" 
read machineName

cond=0

	while [ $cond -eq 0 ]
	do
	if [ -d /home/$nameProfile ]; then
		
		if [ -d /home/$nameProfile/MACHINES ]; then
		a=0101010
		else
			mkdir /home/$nameProfile/MACHINES
		fi
			if [ -d /home/$nameProfile/MACHINES/$machineName ];
			 then
				echo "Have a directory with same name which you select to your Machine"
				echo "Select other name from you machine, and writen below"
				read machineName
			else	
			 	mkdir /home/$nameProfile/MACHINES/$machineName 
				mkdir /home/$nameProfile/MACHINES/$machineName/Scripts
				mkdir /home/$nameProfile/MACHINES/$machineName/Files
				mkdir /home/$nameProfile/MACHINES/$machineName/Img
				echo "Machine name" $machineName
				echo "You directory as created sucefuly"
				echo "You want go to he?"
				echo "yes/no"
				read mac
					if [ $mac -eq "yes" ];then
					cd ~/MACHINES/$machineName
					cond=1
					else
					echo "This falied"
					fi
				
			fi
	else
		echo "No have this directory with name of user in your system"
		echo "You can change the name, writing below the new name"
		read nameProfile	
	fi
	done
