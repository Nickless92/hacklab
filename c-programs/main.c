// SPDX-FileCopyrightText: 2022 Bassam-Khaled Thiab <inf3891@hs-worms.de>
// SPDX-FileCopyrightText: 2022 Dominic Meyer <inf3644@hs-worms.de>
// SPDX-FileCopyrightText: 2022 Felix Rheinheimer <felix.rheinheimer@hs-worms.de>
// SPDX-FileCopyrightText: 2022 Jean-Arole Fotsing <inf3608@hs-worms.de>
// SPDX-FileCopyrightText: 2022 Katrin Vollhardt <inf3493@hs-worms.de>
// SPDX-FileCopyrightText: 2022 Steve Landry Tchamabe <infXXXX@hs-worms.de>
// SPDX-FileCopyrightText: 2022 Syed Saad-Ullah <inf3664@hs-worms.de>
// SPDX-FileCopyrightText: 2022 Thierry-Junior Djeutchou-Njieyong <inf3494@hs-worms.de>
//
// SPDX-License-Identifier: GPL-3.0-or-later

#include <stdio.h>
#include <ncurses.h>
#include <stdlib.h>
#include <string.h>
<<<<<<< HEAD
<<<<<<< HEAD
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

<<<<<<< HEAD

int main()
{
    initscr();                                                                  //initialize the screen
    noecho();                                                                   //suppresses to show the symbols you type in                                                                                         
    curs_set(0);                                                                //disables the curser
=======
#include "Name.h"
=======
#include "enterName.h"
>>>>>>> fuer thierry
#include "menu.h"
#include "schueler_level.h"
#include "student_level.h"
#include "experte_level.h"
#include "netzwerk_sicherheit_level.h"
#include "netzwerk_level.h"
#include "kryptographie.h"
=======
>>>>>>> changed names of headers

<<<<<<< HEAD
int main()
{
    initscr();                                                                  //initialize the screen
    noecho();                                                                   //suppresses to show the symbols you type in                                                                                         
    curs_set(0);                                                                //disables the curser
<<<<<<< HEAD
    
<<<<<<< HEAD
    int yMAx, xMAx = 0;                                                         //variables for the size of the screen
    getmaxyx(stdscr, yMAx, xMAx);                                               //function to get the maximum size of the screen of your comput
    
    WINDOW * namewin = newwin(6, xMAx - 12, yMAx - 8, 5);                       //WINDOW creates a new window
    box(namewin, 0, 0);  
    mvwprintw(namewin, 1, 1, "Please enter a name: ");                          //prints text in the box
    mvwprintw(namewin, 4, xMAx - 25, "EXIT [ESC]");
    refresh();                                                                  //you have to refresh the screen that you can see the new text
    wrefresh(namewin);                                                          //refreshes the window
    char username[] = {};                                                       //char array to save the name the user entered
    int position_of_current_letter = 21;                                        //we need this, because the name the user entered should be printed next to th string "Please enter a name: "
    
    
    do
    {
        if(username[position_of_current_letter - 21] == 127)                    //127 describes the delete character in Ascii
        {
            //goto EINGABE;

            //how can we delete the last character???????
        }
        else if(username[position_of_current_letter - 21] == 27)                //27 describes the ESC character in Ascii
        {
            endwin();                                                           //closes the current window 
            exit(0);                                                            //and we return to the terminal again
        }
        else 
        {       
            mvwprintw(namewin, 1, ++position_of_current_letter, "%c", username[position_of_current_letter - 21]);             //each letter will be printed in the box/Window "namewin"
        }
        wrefresh(namewin);                                                      //you need to refresh the window, that the name the user types in is shown   
    } while((username[position_of_current_letter - 21] = getch()) != '\n');

	//name():
	menu();
	//schueler_le();
	 //highlight = 0;
	 //chooseKnowledge(xMAx, yMAx);

    /*if(highlight == 0)
    {
        //back button
        //enterName(xMAx, yMAx);
    }
    else if(highlight == 1)                                     //when the exit button was choosen we exit the programm
    {
        endwin();
        exit(0);
    }
    else if (highlight == 2)                                    //10 means enter and 0 means "Schüler" in the menu
    {
        schueler_le();
    }*/
    /*else if(highlight == 3)                                     //10 means enter and 1 means "Student" in the menu
    {s
        highlight = chooseModule(xMAx, yMAx);
        if(highlight == 0)
        {
            //back button
        }
        else if(highlight == 1)
        {
            endwin();
            exit(0);
        }
        else if(highlight == 2)
        {
            //Netzwerke
        }
        else if(highlight == 3)
        {
            //Network Security
        }
        else if(highlight == 4)
        {
            //Kryptographie
        }
    }
    else if(highlight == 4)                                     //10 means enter and 0 means "Experte" in the menu
    {
        user_chose_experte(xMAx, yMAx);
    }*/
>>>>>>> lezter stand
=======
=======

>>>>>>> fuer thierry
    name();
>>>>>>> removed some code we don#t need

    enterName();                                                                //function that the user can enter a name
=======
    enterName();
>>>>>>> changed function names

<<<<<<< HEAD
    endwin();                                                                   ////we initialized the scrren so we need to close the window again

=======
>>>>>>> fuer thierry
	return 0;
}