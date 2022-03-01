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

#ifndef MENU_H_INCLUDED
#define MENU_H_INCLUDED

	void menu()
{
    initscr();                                                                  //initialize the screen
    noecho();                                                                   //suppresses to show the symbols you type in                                          
    //cbreak();                                                                   //disables line buffering
    curs_set(0);                                                                //disables the curser
    
    char *choices_knowledge_level[5] =                                          //choices for the knowledge level
    {                   
        "Back [B]",
        "Exit [ESC]",                                     
        "Schüler",
        "Student",
        "Experte",
    };
    
    int choice = 0;                                                             //variable for your choice in the menu
    int highlight = 0;                                                          //shows which choice is highlighted
    int yMAx, xMAx = 0;                                                         //variables for the size of the screen
    getmaxyx(stdscr, yMAx, xMAx);                                               //function to get the maximum size of the screen of your comput
    
    WINDOW * menuwin = newwin(6, xMAx - 12, yMAx - 8, 5);                       //for every "level" of the menu you need to create a new window
    box(menuwin, 0, 0);
    
    wrefresh(menuwin);
    keypad(menuwin, true);                                                      //the keypad option enables the keypad of the user's terminal
    mvwprintw(menuwin, 1, 1, "Please choose your knowledge: ");
    highlight = 2;
    while(choice != 10)                                                         //loop that the user can choose an option of his knowledge
    {
        for(int i = 0; i < 5; i++)                                              //prints all choices of "choices_knowledge_level"
        {
            if(i == highlight)
            {
                wattron(menuwin, A_REVERSE);                                    //A_REVERSE marks one choice --> wattron (window attribute on)
            }
            if(i == 0)                                                          //we want to print the back button on the right bottom
            {
                mvwprintw(menuwin, 4, xMAx - 35, choices_knowledge_level[i]);
            }
            else if(i == 1)                                                     //we want to print the exit button on the right bottom
            {
                mvwprintw(menuwin, 4, xMAx - 23, choices_knowledge_level[i]);
            }
            else
            {
                mvwprintw(menuwin, i, 1, choices_knowledge_level[i]);           //the other choices are printed
            }
            wattroff(menuwin, A_REVERSE);                                       //window attribute off --> the other possibilities are not marked
        }
        choice = wgetch(menuwin);                                               //we get the character the user puts in
        if (highlight == 0)                                                     //the back button is highlighted 
        {
            switch (choice) 
            {
            case KEY_LEFT:                                                      //we can go to the main menu again by pressing the left arrow key 
                highlight = 2;
                break;
            case KEY_RIGHT:                                                     //by pressing the right arrow key, exit is highlighted
                highlight = 1;
                break;
            default:
                break;
            };
        } 
        else if(highlight == 1)                                                 //the exit button is highlighted
        {
            switch (choice) 
            {
            case KEY_LEFT:                                                      //we can go to the back button again by pressing the left key 
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
            case KEY_UP:                                                        //case is carried out when the user enters the up arrow key at the keyboard
                highlight--;
                if(highlight == 1)                                              //case you go out of the menu at the top
                {
                    highlight = 4;
                }
                break;
            case KEY_DOWN:                                                      //case is carried out when the user enters the down arrow key at the keyboard
                highlight++;
                if(highlight == 5)                                              //case you go out of the menu at the bottom
                {
                    highlight = 2;
                }
                break;
            case 'B':
            case 'b':
                highlight = 0;
                break;
            case 27:                                                            //highlights the exit button
                highlight = 1;
                break;
            default:
                break;
            }
        }
    }
     if(choice == 10 && highlight == 0)                                          //back button in knowledge
    {
    	name();
        //goto NAMENSEINGABE;
    }
    else if(choice == 10 && highlight == 1)                                     //exit button in knowledge --> when the exit button was choosen we exit the programm
    {
        endwin();
        exit(0);
    }
    else if(choice == 10 && highlight == 2)                                     //exit button in knowledge --> when the exit button was choosen we exit the programm
    {
        schueler_le();
    }
    else if(choice == 10 && highlight == 3)                                     //exit button in knowledge --> when the exit button was choosen we exit the programm
    {
        student_level();
    }
    else if(choice == 10 && highlight == 4)                                     //exit button in knowledge --> when the exit button was choosen we exit the programm
    {
        experte_le();
    }
    

}

#endif
