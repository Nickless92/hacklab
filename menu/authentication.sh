#!/bin/bash

function generateCode()
{
	RANDOM=$$
	for i in `seq 1`
	do
		hash=$(echo $RANDOM | sha256sum | cut -c1-6)
	done	
}

function enterEmail()
{
	echo -n "Bitte geben Sie Ihre E-mail Adresse ein: "
	read email
	echo -n "Ist folgende E-Mail korrekt $email ? [J/N]: "
	read -n 2 answer
	case $answer in
		J|j) 
			echo -e "Dein Code lautet: \n$hash" | mail -s "Dein Zugangscode für Hacklab" $email ;
			echo -e "Sending E-Mail...\n";;
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
		if [ "$eingabe" == "$hash" ]; then
				echo -e "\nrichtig"
			i=4
		else
				echo -e "\nleider falsch"
		fi
	done
}

generateCode
enterEmail
enterCode