<<<<<<< HEAD
#ifndef SCHUELER_LE_H_INCLUDED
#define SCHUELER_LE_H_INCLUDED

void choose_knowledge();
int menu_switch_case_level(WINDOW * name_of_window, int highlight, int choice);

void pupil_levels()
{    
    char *choices_pupil_level[7] =                                           //choices for the pupil levels
=======
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

#ifndef SCHUELER_LE_H_INCLUDED
#define SCHUELER_LE_H_INCLUDED

<<<<<<< HEAD

=======
void choose_knowledge();
int menu_switch_case_level(WINDOW * name_of_window, int highlight, int choice);
>>>>>>> changed function names

void pupil_levels()
{    
    char *choices_schueler_level[7] =                                           //choices for the "schüler" levels
>>>>>>> changed names of headers
    {
        "Back [B]",
        "Exit [ESC]", 
        "Level 1",
        "Level 2",
        "Level 3",
        "Level 4",
        "Level 5",
    };
    
<<<<<<< HEAD
    int yMAx, xMAx = 0;                                                     //variables for the size of the screen
    getmaxyx(stdscr, yMAx, xMAx);                                           //function to get the maximum size of the screen of your comput
    
    WINDOW * menu_pupil_level = newwin(6, xMAx - 12,yMAx - 8, 5);
    box(menu_pupil_level, 0, 0);
    wrefresh(menu_pupil_level);
    keypad(menu_pupil_level, true);
=======
                                                              //shows which choice is highlighted
    int yMAx, xMAx = 0;                                                         //variables for the size of the screen
    getmaxyx(stdscr, yMAx, xMAx);                                               //function to get the maximum size of the screen of your comput
    
    WINDOW * menu_schueler_level = newwin(6, xMAx - 12,yMAx - 8, 5);
    box(menu_schueler_level, 0, 0);
    wrefresh(menu_schueler_level);
    keypad(menu_schueler_level, true);
>>>>>>> changed names of headers
    int highlight = 2;
    int choice = 0;
    while(1)
    {
        int start_of_first_level_place = 1;
        for(int i = 0; i < 7; i++)                                          //prints the choices 
        {
            if(i == highlight)
            {
<<<<<<< HEAD
                wattron(menu_pupil_level, A_REVERSE);
            }
            if(i == 0)
            {
                mvwprintw(menu_pupil_level, 4, xMAx - 35, choices_pupil_level[i]);
            }
            else if(i == 1)
            {
                mvwprintw(menu_pupil_level, 4, xMAx - 23, choices_pupil_level[i]);
            }
            else
            {
                mvwprintw(menu_pupil_level, 1, start_of_first_level_place, choices_pupil_level[i]);
                start_of_first_level_place+=10;
            }
            wattroff(menu_pupil_level, A_REVERSE);
        }
        choice = wgetch(menu_pupil_level);                                  //we get the user input
        highlight = menu_switch_case_level(menu_pupil_level, highlight, choice);        

        if(choice == 10 && highlight == 0)                                  //back button
        {
        	choose_knowledge();
            return;
        }
        else if(choice == 10 && highlight == 1)                             //exit button
=======
                wattron(menu_schueler_level, A_REVERSE);
            }
            if(i == 0)
            {
                mvwprintw(menu_schueler_level, 4, xMAx - 35, choices_schueler_level[i]);
            }
            else if(i == 1)
            {
                mvwprintw(menu_schueler_level, 4, xMAx - 23, choices_schueler_level[i]);
            }
            else
            {
                mvwprintw(menu_schueler_level, 1, start_of_first_level_place, choices_schueler_level[i]);
            }
            start_of_first_level_place+=10;
            wattroff(menu_schueler_level, A_REVERSE);
        }
        choice = wgetch(menu_schueler_level);                               //returns a single value representing the function key
        if(highlight == 0)
        {
            switch (choice) 
            {
            case KEY_LEFT:                                                      //we can go to the menu again by pressing the left key 
                highlight = 2;
                break;
            case KEY_RIGHT:
                highlight = 1;
                break;
            default:
                break;
            };        
        }
        else if(highlight == 1)
        {
            switch (choice) 
            {
            case KEY_LEFT:                                                      //we can go to the menu again by pressing the left key 
                highlight = 0;
                break;
            default:
                break;
            };            
        }   
        else
        {
            switch (choice)                                                     //we dont want to go out of the menu
            {
            case KEY_LEFT:                                                        //case is carried out when the user enters the up arrow key at the keyboard
                highlight--;
                if(highlight == 1)                                              //case you go out of the menu at the top
                {
                    highlight = 6;
                }
                break;
            case KEY_RIGHT:                                                      //case is carried out when the user enters the down arrow key at the keyboard
                highlight++;
                if(highlight == 7)                                              //case you go out of the menu at the bottom
                {
                    highlight = 2;
                }
                break;
            case 'B':
            case 'b':
                highlight = 0;
                break;
            case 27:                                                           //highlights the exit button
                highlight = 1;
                break;
            default:
                break;
            }
        }
        if(choice == 10 && highlight == 0)
        {
        	choose_knowledge();
        }
        else if(choice == 10 && highlight == 1)
>>>>>>> changed names of headers
        {
            endwin();
            exit(0);
        }
<<<<<<< HEAD
        else if(choice == 10 && highlight == 2)                      
        {
            //level 1
            //int err = system("../scripts/level_start.sh 1 3 ; clear ; sudo tmux new-session -s lvl01 -d 'lxc exec lvl01-d02 -- tshark -i eno1''\;' split-window -v -d 'lxc shell lvl01-d01' '\;' split-window -h -d 'lxc exec lvl01-d03 -- tshark -i eno1' '\;' attach");         //uses fork(2) to create a child process that executes the shell command
            pupil_levels();
            return;
=======
        else if(choice == 10 && highlight == 2)
        {
            //level 1
<<<<<<< HEAD
            //int err = system("/home/test/hacklab/scripts/start_level01.sh >> /home/dominic/container.log 2>&1 | tmux");         //uses fork(2) to create a child process that executes the shell command
>>>>>>> changed names of headers
=======
            int err = system("../scripts/level_start.sh 1 3 ; clear ; sudo tmux new-session -s lvl01 -d 'lxc exec lvl01-d02 -- tshark -i eno1''\;' split-window -v -d 'lxc shell lvl01-d01' '\;' split-window -h -d 'lxc exec lvl01-d03 -- tshark -i eno1' '\;' attach");         //uses fork(2) to create a child process that executes the shell command
            pupil_levels();
>>>>>>> changed function names
        }
        else if(choice == 10 && highlight == 3)
        {
            //level 2
        }
        else if(choice == 10 && highlight == 4)
        {
            //level 3
        }
        else if(choice == 10 && highlight == 5)
        {
            //level 4
        }
        else if(choice == 10 && highlight == 6)
        {
            //level 5
        }
    }
<<<<<<< HEAD
    return;
=======
>>>>>>> changed names of headers
}

#endif