function module_menu () {
    echo -ne "
    Please choose a module: 
    $(ColorBlue '1)') Networks (german: Netzwerke)
	$(ColorBlue '2)') Network Security
    $(ColorRed 'back)') Back to previous menu
	$(ColorRed 'esc)') Exit
	Choose a module: 
	"
    read menuinput
    case $menuinput in
    1) echo "you chose networks." ; networks_levels ;;
    2) echo "you chose networks." ; netsec_levels ;; 
    back) menu ;; 
    esc) exit 0 ;;
    *) echo -e $red"Wrong option."$clear; menu;;
    esac

}

function netsec_levels () {  
    
    echo -ne "
    $(ColorBlue '1)') level 1
	$(ColorBlue '2)') level 2
	$(ColorBlue '3)') level 3
	$(ColorBlue '4)') level 4
	$(ColorBlue '5)') level 5
    $(ColorRed 'back)') Back to previous menu
	$(ColorRed 'esc)') Exit
	Choose a level: 
	"
    read menuinput
    case $menuinput in
    1) echo "you chose level 1. this is empty." ; netsec_levels ;;
	2) echo "you chose level 2. this is empty." ; netsec_levels ;;
	3) echo "you chose level 3. this is empty." ; netsec_levels ;;
	4) echo "you chose level 4. this is empty." ; netsec_levels ;; #add shell script to levels, then menu
	5) echo "you chose level 5. this is empty." ; netsec_levels ;;
    back) module_menu ;; 
    esc) exit 0 ;;
    *) echo -e $red"Wrong option."$clear; menu;;
    esac
}

function networks_levels () {  
    
    echo -ne "
    $(ColorBlue '1)') level 1
	$(ColorBlue '2)') level 2
	$(ColorBlue '3)') level 3
	$(ColorBlue '4)') level 4
	$(ColorBlue '5)') level 5
    $(ColorRed 'back)') Back to previous menu
	$(ColorRed 'esc)') Exit
	Choose a level: 
	"
    read menuinput
    case $menuinput in
    1) echo "you chose level 1. starting..." ; ../scripts/level_start.sh 1 3 ; clear ; sudo tmux new-session -s lvl01 -d 'lxc exec lvl01-d02 -- tshark -i eno1'';' split-window -v -d 'lxc shell lvl01-d01' ';' split-window -h -d 'lxc exec lvl01-d03 -- tshark -i eno1' ';' attach; networks_levels ;;
	2) echo "you chose level 2" ; networks_levels ;;
	3) echo "you chose level 3" ; networks_levels ;;
	4) echo "you chose level 4" ; networks_levels ;; #add shell script to levels, then menu
	5) echo "you chose level 5" ; networks_levels ;;
    back) module_menu ;; 
    esc) exit 0 ;;
    *) echo -e $red"Wrong option."$clear; menu;;
    esac
}

function pupil_level () {
    echo -ne "
    $(ColorBlue '1)') level 1
	$(ColorBlue '2)') level 2
	$(ColorBlue '3)') level 3
	$(ColorBlue '4)') level 4
	$(ColorBlue '5)') level 5
    $(ColorRed 'back)') Back to previous menu
	$(ColorRed 'esc)') Exit
	Choose a level: 
	"
    read menuinput
    case $menuinput in
    1) echo "you chose level 1. starting..." ; ../scripts/level_start.sh 1 3 ; clear ; sudo tmux new-session -s lvl01 -d 'lxc exec lvl01-d02 -- tshark -i eno1'';' split-window -v -d 'lxc shell lvl01-d01' ';' split-window -h -d 'lxc exec lvl01-d03 -- tshark -i eno1' ';' attach; pupil_level ;;
	2) echo "you chose level 2" ; menu ;;
	3) echo "you chose level 3" ; menu ;;
	4) echo "you chose level 4" ; menu ;; #add shell script to levels, then menu
	5) echo "you chose level 5" ; menu ;;
    back) menu ;; 
    esc) exit 0 ;;
    *) echo -e $red"Wrong option."$clear; menu;;
    esac
}

function choose_stage () {
    echo -ne "
    $(ColorBlue '1)') Pupil  -  for people who have not attended any modules at HS-Worms
    $(ColorBlue '2)') Student  -  in the next step you can choose between different modules
    $(ColorBlue '3)') Expert  -  you can choose between all levels of pupil and student
    $(ColorRed 'esc)') Exit
    "

    read menuinput
    case $menuinput in 
	1) echo "you have chosen pupil." ; pupil_level ; menu ;; 
	2) echo "you have chosen student." ; module_menu ; menu ;; 
	3) echo "you have chosen expert." ; menu ;; 
    esc) exit 0 ;; 
    *) echo -e $red"Wrong option."$clear; menu;;
    esac
}

function enter_name(){
    echo "Please enter your name, enter esc to exit"
    read name
    if [ $name == "esc" ] ; then
	exit 0 ; 
    fi
    
}


# Color  Variables

green='\e[32m'
blue='\e[34m'
red='\e[31m'
clear='\e[0m'

# Color Functions

ColorGreen(){
    echo -ne $green$1$clear
}
ColorBlue(){
    echo -ne $blue$1$clear
}
ColorRed(){
    echo -ne $red$1$clear
}


menu () {
    
    choose_stage

}

#call menu function 
enter_name
echo -e "Welcome to our hacklab $(ColorGreen $name)!\nThis is a game in which you can start learning how to manipulate networks and defend yourself from cyber attacks.\nTo start, we will need to know how much knowledge you already posess.\nPlease choose one of the following options:\n"
menu
