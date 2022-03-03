# Color  Variables

green='\e[32m'
blue='\e[34m'
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

function enter_name()
{
    echo "Please enter your name, enter esc to exit"
    read name
    if [ "$name" == "esc" ] ; then
	    exit 0
    else
        return 2
    fi 
}

function choose_stage () 
{
    echo -ne "$(ColorBlue '1)') Pupil     -  for people who have not attended any modules at HS-Worms\n"
    echo -ne "$(ColorBlue '2)') Student   -  in the next step you can choose between different modules\n"
    echo -ne "$(ColorBlue '3)') Expert    -  you can choose between all levels of pupil and student\n"
    echo -ne "$(ColorRed 'esc)')         -  Exit\n"

    read menuinput
    case $menuinput in 
	1) echo -e "you chose pupil.\n" ; return 3 ;; 
	2) echo -e "you chose student.\n" ; return 4 ;; 
	3) echo -e "you chose expert.\n" ; return 7 ;; 
    esc) exit 0 ;; 
    *) echo -e $red"Wrong option.\n"$clear; return 2;;
    esac
}

function pupil_levels () 
{
    echo -ne "$(ColorBlue '1)')       -   level 1\n"
	echo -ne "$(ColorBlue '2)')       -   level 2\n"
	echo -ne "$(ColorBlue '3)')       -   level 3\n"
	echo -ne "$(ColorBlue '4)')       -   level 4\n"
	echo -ne "$(ColorBlue '5)')       -   level 5\n"
    echo -ne "$(ColorRed 'back)')    -   Back to previous menu\n"
	echo -ne "$(ColorRed 'esc)')     -   Exit\n\n"
	echo -e "Choose a level: "

    read menuinput
    case $menuinput in
    1) echo -e "you chose level 1. starting..." ; ../scripts/level_start.sh 1 3 ; clear ; sudo tmux new-session -s lvl01 -d 'lxc exec lvl01-d02 -- tshark -i eno1'';' split-window -v -d 'lxc shell lvl01-d01' ';' split-window -h -d 'lxc exec lvl01-d03 -- tshark -i eno1' ';' attach; return 3 ;;
	2) echo -e "you chose level 2" ; return 3 ;;
	3) echo -e "you chose level 3" ; return 3 ;;
	4) echo -e "you chose level 4" ; return 3 ;; #add shell script to levels, then menu
	5) echo -e "you chose level 5" ; return 3 ;;
    back) echo -ne "\n"; return 2 ;; 
    esc) exit 0 ;;
    *) echo -e $red"Wrong option.\n"$clear; return 3;;
    esac
}

function module_menu () 
{
    echo -ne "$(ColorBlue '1)')     -   Networks (german: Netzwerke)\n"
    echo -ne "$(ColorBlue '2)')     -   Network Security\n"
    echo -ne "$(ColorRed 'back)')  -   Back to previous menu\n"
    echo -ne "$(ColorRed 'esc)')   -   Exit\n"
    echo -e "Please choose a module: "

    read menuinput
    case $menuinput in
    1) echo -e "you chose networks.\n" ; return 5 ;;
    2) echo -e "you chose Network Security.\n" ; return 6 ;; 
    back) echo -ne "\n"; return 2 ;; 
    esc) exit 0 ;;
    *) echo -e $red"Wrong option.\n"$clear; return 4;;
    esac

}

function networks_levels () 
{  
    echo -ne "$(ColorBlue '1)')       -   level 1\n"
	echo -ne "$(ColorBlue '2)')       -   level 2\n"
	echo -ne "$(ColorBlue '3)')       -   level 3\n"
	echo -ne "$(ColorBlue '4)')       -   level 4\n"
	echo -ne "$(ColorBlue '5)')       -   level 5\n"
    echo -ne "$(ColorRed 'back)')    -   Back to previous menu\n"
	echo -ne "$(ColorRed 'esc)')     -   Exit\n\n"
	echo -e "Choose a level: "

    read menuinput
    case $menuinput in
    1) echo -e "you chose level 1. starting..." ; ../scripts/level_start.sh 1 3 ; ./netlvl_1.sh ; ./netlvl_1_explanation.sh ; clear ; sudo tmux new-session -s lvl01 -d 'lxc exec lvl01-d02 -- tshark -i eno1'\; split-window -v -d 'lxc shell lvl01-d01' \; split-window -h -d 'lxc exec lvl01-d03 -- tshark -i eno1' \; attach; clear ; sh ../levels/01-test/finish.sh ; sleep 3 ; return 5 ;;
	2) echo -e "you chose level 2" ; return 5 ;;
	3) echo -e "you chose level 3" ; return 5 ;;
	4) echo -e "you chose level 4" ; return 5 ;; #add shell script to levels, then menu
	5) echo -e "you chose level 5" ; return 5 ;;
    back) echo -ne "\n"; return 4 ;; 
    esc) exit 0 ;;
    *) echo -e $red"Wrong option.\n"$clear; return 5;;
    esac
}

function netsec_levels () 
{  
    echo -ne "$(ColorBlue '1)')       -   level 1\n"
	echo -ne "$(ColorBlue '2)')       -   level 2\n"
	echo -ne "$(ColorBlue '3)')       -   level 3\n"
	echo -ne "$(ColorBlue '4)')       -   level 4\n"
	echo -ne "$(ColorBlue '5)')       -   level 5\n"
    echo -ne "$(ColorRed 'back)')    -   Back to previous menu\n"
	echo -ne "$(ColorRed 'esc)')     -   Exit\n\n"
	echo -e "Choose a level: "

    read menuinput
    case $menuinput in
    1) echo -e "you chose level 1. this is empty." ;  return 6;;
	2) echo -e "you chose level 2. this is empty." ;  return 6;;
	3) echo -e "you chose level 3. this is empty." ;  return 6;;
	4) echo -e "you chose level 4. this is empty." ;  return 6;; #add shell script to levels, then menu
	5) echo -e "you chose level 5. this is empty." ;  return 6;;
    back) echo -ne "\n"; return 4 ;; 
    esc) exit 0 ;;
    *) echo -e $red"Wrong option.\n"$clear; return 6;;
    esac
}

function expert_levels()
{
    echo -ne "$(ColorBlue '1)')       -   level 1\n"
	echo -ne "$(ColorBlue '2)')       -   level 2\n"
	echo -ne "$(ColorBlue '3)')       -   level 3\n"
	echo -ne "$(ColorBlue '4)')       -   level 4\n"
	echo -ne "$(ColorBlue '5)')       -   level 5\n"
    echo -ne "$(ColorRed 'back)')    -   Back to previous menu\n"
	echo -ne "$(ColorRed 'esc)')     -   Exit\n\n"
	echo -e "Choose a level: "

    read menuinput
    case $menuinput in
    1) echo -e "you chose level 1. this is empty." ;  return 7;;
	2) echo -e "you chose level 2. this is empty." ;  return 7;;
	3) echo -e "you chose level 3. this is empty." ;  return 7;;
	4) echo -e "you chose level 4. this is empty." ;  return 7;; #add shell script to levels, then menu
	5) echo -e "you chose level 5. this is empty." ;  return 7;;
    back) echo -ne "\n"; return 2 ;; 
    esc) exit 0 ;;
    *) echo -e $red"Wrong option.\n"$clear; return 7;;
    esac    
}

main_menu () 
{
    enter_name
    echo -e "Welcome to our hacklab $(ColorGreen $name)!\nThis is a game in which you can start learning how to manipulate networks and defend yourself from cyber attacks.\nTo start, we will need to know how much knowledge you already posess.\nPlease choose one of the following options:\n"
    returnValue=2

    while : ; do
        case $returnValue in
            1) enter_name;;
            2) choose_stage;;
            3) pupil_levels;;
            4) module_menu;;
            5) networks_levels;;
            6) netsec_levels;;
            7) expert_levels;;
            *) exit 0;;
        esac
        returnValue=$?
        [[ $returnValue -ne 0 ]] || break
    done
}

main_menu