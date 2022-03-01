#include <stdio.h>
#include <ncurses.h>
#include <stdlib.h>
#include <string.h>
#include "enterName.h"
#include "choose_knowledge.h"
#include "pupil_levels.h"
#include "choose_modules.h"
#include "expert_levels.h"
#include "network_security_levels.h"
#include "netzwerk_levels.h"
#include "kryptographie_levels.h"
#include "menu_switch_case.h"
#include "menu_switch_case_level.h"


int main()
{
    initscr();                                                                  //initialize the screen
    noecho();                                                                   //suppresses to show the symbols you type in                                                                                         
    curs_set(0);                                                                //disables the curser

    name();

    endwin();         

	return 0;
}