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
	echo -n "Bitte geben Sie Ihren InfXXXX Namen ein: "
	read infName
	if [[ "$infName" =~ ^inf[0-9]{4}$ ]] ; then															#checks if the user puts in a valid Adress
		email=${infName}@hs-worms.de																	#infName + @hs-worms.de --> E-Mail Adress
		echo -n "Ist folgende E-Mail korrekt $email ? [J/N]: "
		read -n 2 answer																					
		case $answer in																					#checks the enter value 
			J|j) 
				echo -e "Sending E-Mail...\n";
				generateCode			
				echo -e "Dein Code lautet: \n$hash\nDieser läuft in $limitInMinutes Minuten ab" | mail -s "Dein Zugangscode für Hacklab" -a FROM:"Team Hacklab <teamhacklab@gmail.com>" $email ;;	#generates Mail Packet
			N|n) enterEmail;;																			#the user can enter his/her email again
			*) echo -e "Wrong option" ; enterEmail;;
		esac
	else
		echo -e "Kein gültiger inf-Name\n"
		enterEmail
	fi
}

function enterCode()
{
	for ((i=1; i<=3; i++));																				#the user can enter his/her code three times
	do
		echo -n "($i. Versuch/3) Bitte geben Sie hier den Code ein, den Sie per E-Mail erhalten haben: "
		read -n 6 eingabe
		if [ "$eingabe" == "$hash" ] && [ $(date +"%s") -lt "$timeLimit" ]; then						#checks if the value the user enters is equivalent to the hash we generated and if the time limit is not over 
				echo -e "\nrichtig"
			i=4
		elif [ $(date +"%s") -gt "$timeLimit" ]; then													#checks if the time limit is over
			echo -e "\n$limitInMinutes minutes are over\n"
			break
		else
				echo -e "\nleider falsch"
		fi
	done
}

enterEmail
enterCode