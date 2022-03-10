#!/bin/bash

function getCurrentTimeAndTimeLimit()
{
	limitInMinutes=10
	currentTime=$(date +"%s")
	timeLimit=$((currentTime + $limitInMinutes*60))	
}

function generateCode()
{
	RANDOM=$$
	getCurrentTimeAndTimeLimit
	for i in `seq 1`
	do
		hash=$(echo $RANDOM | sha256sum | cut -c1-6)
	done	
}

function enterEmail()
{
	echo -n "Bitte geben Sie Ihren InfXXXX Namen ein: "
	read infName
	email=${infName}@hs-worms.de
	echo -n "Ist folgende E-Mail korrekt $email ? [J/N]: "
	read -n 2 answer
	case $answer in
		J|j) 
			echo -e "Sending E-Mail...\n";
			generateCode
			echo -e "Dein Code lautet: \n$hash\nDieser läuft in $limitInMinutes Minuten ab" | mail -s "Dein Zugangscode für Hacklab" -a FROM:"Team Hacklab <teamhacklab@gmail.com>" $email ;;
		N|n) enterEmail;;
		*) echo -e "Wrong option" ; enterEmail;;
	esac
}

function enterCode()
{
	for ((i=1; i<=3; i++));
	do
		echo -n "($i. Versuch/3) Bitte geben Sie hier den Code ein, den Sie per E-Mail erhalten haben: "
		read -n 6 eingabe
		if [ "$eingabe" == "$hash" ] && [ $(date +"%s") -lt "$timeLimit" ]; then
				echo -e "\nrichtig"
			i=4
		elif [ $(date +"%s") -gt "$timeLimit" ]; then
			echo -e "\n$limitInMinutes minutes are over\n"
			break
		else
				echo -e "\nleider falsch"
		fi
	done
}

enterEmail
enterCode