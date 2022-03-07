#!/bin/bash

# Color  Variables

green='\e[32m'
blue='\e[33m' #yellow
#blaue='\e[36m'  #cyan
#blue='\e[34m'
red='\e[31m'
clear='\e[0m'

# Color Functions

ColorGreen()
{
    echo -ne $green$1$clear
}
ColorBlue()
{
    echo -ne $blue$1$clear
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
       echo -ne "$(ColorBlue  "$i"')')"                                                  #numers in this form 1)--will be printed  
       awk 'NR=='$i'{ print}' read.txt                                                  #Pupil STudent Expert will be read line by line
    i=$(($i+1))
    done
    echo -ne "$(ColorRed '(x)')   -  To Exit the Menu)\n"    

    read -n 1 menuinput
    case $menuinput in 
	1) echo -e "\nyou chose pupil.\n" ; return 3 ;;                                 #return 3 means that the function pupil_levels is going to run
	2) echo -e "\nyou chose student.\n" ; return 4 ;;                               #return 4 means that the function module_menu is going to run
	3) echo -e "\nyou chose expert.\n" ; return 7 ;;                                #return 7 means that the function expert_levels is going to run
	x)printf "\n" exit 0 ;; 
    *) echo -e $red"\nWrong option.\n"$clear; return 2;;                                #return 2 means that the function choose_stage is going to run
    esac
}

function pupil_levels () 
{ 
    Level 6
    Back_exit
    echo -e "Choose a level: "
    read -n 1 menuinput
    case $menuinput in
    1) echo -e "\nyou chose level 1. starting..." ; return 3 ;;
	2) echo -e "\nyou chose level 2" ; return 3 ;;
	3) echo -e "\nyou chose level 3" ; return 3 ;;
	4) echo -e "\nyou chose level 4" ; return 3 ;;                         
	5) echo -e "\nyou chose level 5" ; return 3 ;;
    b) echo -ne "\n"; return 2 ;;                                                   #return 2 means that the function choose_stage is going to run
    x)printf "\n" exit 0 ;;

    *) echo -e $red"\nWrong option.\n"$clear; return 3;;                            #return 3 means that the function pupil_levels is going to run
    esac
}

function module_menu () 
{
    echo -ne "$(ColorBlue '1)')       -   Networks (german: Netzwerke)\n"
    echo -ne "$(ColorBlue '2)')       -   Network Security\n"
    Back_exit    
#echo -ne "$(ColorRed 'b)ack')    -   Back to previous menu\n"
    #echo -ne "$(ColorRed 'e(x)it')   -   Exit\n"
    echo -e "Please choose a module: "

    read -n 1 menuinput
    case $menuinput in
    1) echo -e "\nyou chose networks.\n" ; return 5 ;;                              #return 5 means that the function networks_levels is going to run
    2) echo -e "\nyou chose Network Security.\n" ; return 6 ;;                      #return 6 means that the function netsec_levels is going to run
    b) echo -ne "\n"; return 2 ;;                                                   #return 2 means that the function choose_stage is going to run
    x)printf "\n" exit 0 ;;
    *) echo -e $red"\nWrong option.\n"$clear; return 4;;                            #return 4 means that the function module_menu is going to run
    esac

}

function networks_levels () 
{  
   Level 6
   Back_exit
   echo -e "Choose a level: "

    read -n 1 menuinput
    case $menuinput in
    1) clear ; echo -e "\nyou chose level 1. starting..." ; 
        (../scripts/level_start.sh 1 3 &) ;                                         #containers getting started
        ./netlvl_1.sh ;                                                             #story time :)
        ./netlvl_1_explanation.sh ;                                                 #explanation for the level
        sleep 10 ;                                                                  #the user gets some time to read the task
        sudo tmux new-session -s lvl01 -d 'lxc exec lvl01-c02 -- tshark -i eno1'\;  #splits tmux in different windows
            split-window -v -d 'lxc shell lvl01-c01' \; 
            split-window -h -d 'lxc exec lvl01-c03 -- tshark -i eno1' \; attach ;    
        sudo lxc exec lvl01-c01 -- touch command.txt ;                              #creates a file in the container where the user has to save his/her command
        clear ; 
        ../levels/01-test/finish.sh ;                                               #evaluation of the level
        sleep 3 ;                                                                   #the user can see if he won or he lost
        return 5 ;;                                                                 #return 5 means that the function networks_levels is going to run
	2) echo -e "\nyou chose level 2" ; return 5 ;;
	3) echo -e "\nyou chose level 3" ; return 5 ;;
	4) echo -e "\nyou chose level 4" ; return 5 ;; 
	5) echo -e "\nyou chose level 5" ; return 5 ;;
    b) echo -ne "\n"; return 4 ;;                                                   #return 4 means that the function module_menu is going to run
    x)printf "\n" exit 0 ;;
    *) echo -e $red"\nWrong option.\n"$clear; return 5;;                            #return 5 means that the function networks_levels is going to run
    esac
}

function netsec_levels ()  
{  
        Level 6
        Back_exit        
	echo -e "Choose a level: "
    read -n 1 menuinput
    case $menuinput in
    1) echo -e "\nyou chose level 1. this is empty." ;  return 6;;
	2) echo -e "\nyou chose level 2. this is empty." ;  return 6;;
	3) echo -e "\nyou chose level 3. this is empty." ;  return 6;;
	4) echo -e "\nyou chose level 4. this is empty." ;  return 6;; 
	5) echo -e "\nyou chose level 5. this is empty." ;  return 6;;
    b) echo -ne "\n"; return 4 ;;                                                   #return 4 means that the function module_menu is going to run
    x)printf "\n" exit 0 ;;
    *) echo -e $red"\nWrong option.\n"$clear; return 6;;                            #return 6 means that the function netsec_levels is going to run
    esac
}

function expert_levels()
{
   Level 6
   Back_exit
   echo -e "Choose a level: "

    read -n 1 menuinput
    case $menuinput in
    1) echo -e "\nyou chose level 1. this is empty." ;  return 7;;
	2) echo -e "\nyou chose level 2. this is empty." ;  return 7;;
	3) echo -e "\nyou chose level 3. this is empty." ;  return 7;;
	4) echo -e "\nyou chose level 4. this is empty." ;  return 7;; 
	5) echo -e "\nyou chose level 5. this is empty." ;  return 7;;
    b) echo -ne "\n"; return 2 ;;                                                   #return 2 means that the function choose_stage is going to run
    x)printf "\n" exit 0 ;;
    *) echo -e $red"\nWrong option.\n"$clear; return 7;;                            #return 7 means that the function expert_levels is going to run
    esac    
}

Back_exit()
{
	echo -ne "$(ColorRed ' b)') -  Back to previous menu\n"
	echo -ne "$(ColorRed '(x)') -  to exit the menu\n"
}
Level()
{
	i=1
	while [ $i -ne $1 ]                                                         #loop from 1 till the given paramter $1 is the parameter
	  do
	    echo -ne "$(ColorBlue " $i"')')" "   -  Level " $i "\n"
	    i=$(($i+1))
	  done 
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

