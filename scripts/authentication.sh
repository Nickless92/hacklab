#!/bin/bash


RANDOM=$$

#zufall=$RANDOM

for i in `seq 1`
do

	echo $RANDOM > data
	#cat data
	hash=$(sha256sum data | cut -c1-6)
	#echo $hash
done
echo -n "Bitte geben Sie Ihre E-mail Adresse ein: "
read email
echo -e "Dein Code lautet: \n$hash" | mail -s "Dein Zugangscode für Hacklab" $email

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
