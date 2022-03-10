#!/bin/bash

function getStartTimeAndTimeLimit()
{
	limitInMinutes=10																					#time limit until the code isn't useable anymore
	startTime=$(date +"%s")																				#time when the code is generated
	timeLimit=$((startTime + $limitInMinutes*60))														#time Limit + startTime
}

function generateCode()
{
	RANDOM=$$																							#generates a random value from 0 through 32767
	getStartTimeAndTimeLimit																			
	for i in `seq 1`
	do
		hash=$(echo $RANDOM | sha256sum | cut -c1-6)													#generates the sha256sum hash of RANDOM=$$
	done	
}

function enterEmail()
{
	echo -e "**********AUTHENTICATION**********\n"
	echo -n "Please enter your infXXXX name: "
	read infName
	if [[ "$infName" =~ ^inf[0-9]{4}$ ]] ; then															#checks if the user puts in a valid Adress
		email=${infName}@hs-worms.de																	#infName + @hs-worms.de --> E-Mail Adress
		echo -n "Is $email correct? [J/N]: "
		read -n 2 answer																					
		case $answer in																					#checks the enter value 
			J|j) 
				echo -e "Sending email...\n";
				generateCode			
				echo -e "Your authentication code is: \n$hash\nIt runs out in $limitInMinutes minutes." | mail -s "Your authentication code for hacklab" -a FROM:"Team Hacklab <teamhacklab@gmail.com>" $email ;;	#generates Mail Packet
			N|n) enterEmail;;																			#the user can enter his/her email again
			*) echo -e "Wrong option" ; enterEmail;;
		esac
	else
		echo -e "$infName is not a valid inf-name\n"
		enterEmail
	fi
}

function enterCode()
{
	for ((i=1; i<=3; i++));																				#the user can enter his/her code three times
	do
		echo -n "(Try $i/3) Please enter your authentication code, we send you by email: "
		read -n 6 eingabe
		if [ "$eingabe" == "$hash" ] && [ $(date +"%s") -lt "$timeLimit" ]; then						#checks if the value the user enters is equivalent to the hash we generated and if the time limit is not over 
			clear
			echo -e "\nsuccessful"
			break;
		elif [ $(date +"%s") -gt "$timeLimit" ]; then													#checks if the time limit is over
			echo -e "\n$limitInMinutes minutes are over\n"
			break
		else
			echo -e "\nwrong code!"
			main
		fi
	done
}

function main()
{
	clear
	enterEmail
	enterCode	
}

main