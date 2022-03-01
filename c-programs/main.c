#include <stdio.h>
#include <ncurses.h>
#include <stdlib.h>
#include <string.h>
#include "Name.h"
#include "menu.h"
#include "schueler_level.h"
#include "student_level.h"
#include "experte_level.h"
#include "netzwerk_sicherheit_level.h"
#include "netzwerk_level.h"
#include "kryptographie.h"
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
