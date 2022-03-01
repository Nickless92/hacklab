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

#ifndef NAME_H_INCLUDED
#define NAME_H_INCLUDED

<<<<<<< HEAD
<<<<<<< HEAD:c-programs/enterName.h
void choose_knowledge();                                                        //function decleration of the function we use below

void enterName()
=======
void name()
>>>>>>> removed some code we don#t need:c-programs/Name.h
=======
void choose_knowledge();

void enterName()
>>>>>>> changed function names
{
    int yMAx, xMAx = 0;                                                         //variables for the size of the screen
    getmaxyx(stdscr, yMAx, xMAx);                                               //function to get the maximum size of the screen of your computer
    
    WINDOW * namewin = newwin(6, xMAx - 12, yMAx - 8, 5);                       //newwin creates a new window --> WINDOW *newwin(int nlines, int ncols, int begin_y, int begin_x);
    box(namewin, 0, 0);                                                         //describes how the window should look like
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
<<<<<<< HEAD
<<<<<<< HEAD:c-programs/enterName.h
            enterName();
=======
            name();
>>>>>>> removed some code we don#t need:c-programs/Name.h
=======
            enterName();
>>>>>>> changed function names
        }
        else if(username[position_of_current_letter - 21] == 27)                //27 describes the ESC character in Ascii
        {
            endwin();                                                           //closes the current window 
            exit(0);                                                            //and we return to the terminal again
        }
        else 
        {     
            //getstr(username);  
            mvwprintw(namewin, 1, ++position_of_current_letter, "%c", username[position_of_current_letter - 21]);             //each letter will be printed in the box/Window "namewin"
        }
        wrefresh(namewin);                                                      //you need to refresh the window, that the name the user types in is shown   
    } while((username[position_of_current_letter - 21] = getch()) != '\n');     //we want to run the loop until ENTER is pressed
    
<<<<<<< HEAD
    choose_knowledge();                                                         //next level of the menu by calling the function choose_knowledge
=======
    choose_knowledge();
>>>>>>> changed function names
    
    return;
}

#endif