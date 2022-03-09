#!/bin/bash

# Color  Variables

green='\e[32m'
light_cyan='\e[96m' 
red='\e[31m'
clear='\e[0m'

# Color Functions

ColorGreen()
{
    echo -ne $green$1$clear
}
Colorlight_cyan()
{
    echo -ne $light_cyan$1$clear
}
ColorRed()
{
    echo -ne $red$1$clear
}

function welcome_screen()
{
    clear                                                                           #clears the window that the window is clean
    cat ../ressources/ascii/Welcome.txt                                             #prints an Ascii graphic
    sleep 2                                                                         #the user can see the graphic for two seconds
    clear
}

function enter_name()
{
    echo -e "\nPlease enter your name, enter x to exit"
    read name
    if [ "$name" == "x" ] ; then                                                    #if the user puts in x the programm is going to exit 
	    exit 0
    else
        return 2                                                                    #return 2 means that the function choose_stage is going to run
    fi 
}

function choose_stage () 
{
    i=1
    while [ $i -ne 4 ]
    do
       echo -ne "$(Colorlight_cyan  "$i"')')"                                       #numers in this form 1)--will be printed  
       awk 'NR=='$i'{ print}' read.txt                                              #Pupil STudent Expert will be read line by line
    i=$(($i+1))
    done
    echo -ne "$(ColorRed 'e(x)it')\n" 
    echo -ne "Please choose your knowledge: "   

    read -n 1 menuinput
    case $menuinput in 
	1) echo -e "\nyou chose pupil.\n" ; return 3 ;;                                 #return 3 means that the function pupil_levels is going to run
	2) echo -e "\nyou chose student.\n" ; return 4 ;;                               #return 4 means that the function module_menu is going to run
	3) echo -e "\nyou chose expert.\n" ; return 7 ;;                                #return 7 means that the function expert_levels is going to run
	x) echo -e "\nyou chose exit" ; exit 0 ;; 
    *) echo -e $red"\nWrong option.\n"$clear; return 2;;                            #return 2 means that the function choose_stage is going to run
    esac
}

function pupil_levels () 
{
    level 6
    Back_exit    
	echo -ne "\nChoose a level: "

    read -n 1 menuinput
    case $menuinput in
    1) echo -e "\nyou chose level 1. starting..." ; return 3 ;;
	2) echo -e "\nyou chose level 2" ; return 3 ;;
	3) echo -e "\nyou chose level 3" ; return 3 ;;
	4) echo -e "\nyou chose level 4" ; return 3 ;;                         
	5) echo -e "\nyou chose level 5" ; return 3 ;;
    b) echo -e "\nyou chose back\n"; return 2 ;;                                    #return 2 means that the function choose_stage is going to run
    x) echo -e "\nyou chose exit" ; exit 0 ;;
    *) echo -e $red"\nWrong option.\n"$clear; return 3;;                            #return 3 means that the function pupil_levels is going to run
    esac
}

function module_menu () 
{
    echo -ne "$(Colorlight_cyan '1)')     -  Networks (german: Netzwerke)\n"
    echo -ne "$(Colorlight_cyan '2)')     -  Network Security\n"
    Back_exit    
    echo -ne "Please choose a module: "

    read -n 1 menuinput
    case $menuinput in
    1) echo -e "\nyou chose networks.\n" ; return 5 ;;                              #return 5 means that the function networks_levels is going to run
    2) echo -e "\nyou chose Network Security.\n" ; return 6 ;;                      #return 6 means that the function netsec_levels is going to run
    b) echo -e "\nyou chose back\n"; return 2 ;;                                    #return 2 means that the function choose_stage is going to run
    x) echo -e "\nyou chose exit" ; exit 0 ;;
    *) echo -e $red"\nWrong option.\n"$clear; return 4;;                            #return 4 means that the function module_menu is going to run
    esac

}

function networks_levels () 
{  
    level 6
    Back_exit  
	echo -ne "\nChoose a level: "

    read -n 1 menuinput
    case $menuinput in
    1)  ../levels/01-test/create_network_level01_session.sh;                        #splits tmux in different windows    
        return 5 ;;                                                                 #return 5 means that the function networks_levels is going to run
	2) echo -e "\nyou chose level 2" ; return 5 ;;
	3) echo -e "\nyou chose level 3" ; return 5 ;;
	4) echo -e "\nyou chose level 4" ; return 5 ;; 
	5) echo -e "\nyou chose level 5" ; return 5 ;;
    b) echo -e "\nyou chose back\n"; return 4 ;;                                    #return 4 means that the function module_menu is going to run
    x) echo -e "\nyou chose exit"; exit 0 ;;
    *) echo -e $red"\nWrong option.\n"$clear; return 5;;                            #return 5 means that the function networks_levels is going to run
    esac
}

function netsec_levels ()  
{  
    level 6
    Back_exit        
	echo -ne "Choose a level: "

    read -n 1 menuinput
    case $menuinput in
    1) echo -e "\nyou chose level 1. this is empty." ;  return 6;;
	2) echo -e "\nyou chose level 2. this is empty." ;  return 6;;
	3) echo -e "\nyou chose level 3. this is empty." ;  return 6;;
	4) echo -e "\nyou chose level 4. this is empty." ;  return 6;; 
	5) echo -e "\nyou chose level 5. this is empty." ;  return 6;;
    b) echo -e "\nyou chose back\n"; return 4 ;;                                    #return 4 means that the function module_menu is going to run
    x) echo -e "\nyou chose exit" ; exit 0 ;;
    *) echo -e $red"\nWrong option.\n"$clear; return 6;;                            #return 6 means that the function netsec_levels is going to run
    esac
}

function expert_levels()
{
    level 6
    Back_exit
    echo -ne "Choose a level: "

    read -n 1 menuinput
    case $menuinput in
    1) echo -e "\nyou chose level 1. this is empty." ;  return 7;;
	2) echo -e "\nyou chose level 2. this is empty." ;  return 7;;
	3) echo -e "\nyou chose level 3. this is empty." ;  return 7;;
	4) echo -e "\nyou chose level 4. this is empty." ;  return 7;; 
	5) echo -e "\nyou chose level 5. this is empty." ;  return 7;;
    b) echo -e "\nyou chose back\n"; return 2 ;;                                    #return 2 means that the function choose_stage is going to run
    x) echo -e "\nyou chose exit" ; exit 0 ;;
    *) echo -e $red"\nWrong option.\n"$clear; return 7;;                            #return 7 means that the function expert_levels is going to run
    esac    
}

Back_exit()
{
	echo -ne "$(ColorRed 'b)ack')  -  Back to previous menu\n"
	echo -ne "$(ColorRed 'e(x)it')\n" 
}

level()
{
	i=1
	while [ $i -ne $1 ]                                                             #loop from 1 till the given paramter $1 is the parameter
	  do
	    echo -ne "$(Colorlight_cyan " $i"')')" "   -  Level " $i "\n"
	    i=$(($i+1))
<<<<<<< HEAD
	  done 
=======
	done 
>>>>>>> 94-write-story-into-own-file-and-read-from-file-instead-of-multiple-echos-and-typeits
 }

main_menu () 
{
    enter_name
    clear
    welcome="Welcome to hacklab"
    game="This is a game in which you can start learning how to manipulate networks and defend yourself from cyber attacks.
    To start, we will need to know how much knowledge you already posess.\nPlease choose one of the following options:\n"
    echo -e "$welcome $(ColorGreen $name)!\n$game"
    returnValue=2

    while : ; do
        case $returnValue in
            1) enter_name;;                                                         #is going to run if a function returns 1
            2) choose_stage;;                                                       #is going to run if a function returns 2
            3) pupil_levels;;                                                       #is going to run if a function returns 3 
            4) module_menu;;                                                        #is going to run if a function returns 4
            5) networks_levels;;                                                    #is going to run if a function returns 5
            6) netsec_levels;;                                                      #is going to run if a function returns 6
            7) expert_levels;;                                                      #is going to run if a function returns 7
            *) exit 0;;
        esac
        returnValue=$?
        [[ $returnValue -ne 0 ]] || break
    done
}

welcome_screen
main_menu

