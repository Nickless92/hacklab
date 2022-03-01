#ifndef NETZWERK_SICHERHEIT_LE_H_INCLUDED
#define NETZWERK_SICHERHEIT_LE_H_INCLUDED

<<<<<<< HEAD
void choose_modules();
int menu_switch_case(WINDOW * name_of_window, int highlight, int choice);

void netzwork_security_levels(void)
{   
    char *choices_student_level_netsec[7] =                                           //choices for the student network security levels
=======
void netzwerk_sicherheit_le(void)
{   
    char *choices_student_level_netsec[7] =                                           //choices for the "schüler" levels
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
    int yMAx, xMAx = 0;                                                             //variables for the size of the screen
    getmaxyx(stdscr, yMAx, xMAx);                                                   //function to get the maximum size of the screen of your comput
=======
    int yMAx, xMAx = 0;                                                         //variables for the size of the screen
    getmaxyx(stdscr, yMAx, xMAx);                                               //function to get the maximum size of the screen of your comput
>>>>>>> changed names of headers
    
    WINDOW * menu_student_module_netsec = newwin(6, xMAx - 12,yMAx - 8, 5);
    box(menu_student_module_netsec, 0, 0);
    wrefresh(menu_student_module_netsec);
    keypad(menu_student_module_netsec, true);
    int highlight = 2;
    int choice = 0;
    while(1)
    {
        int start_of_first_level_place = 1;
<<<<<<< HEAD
        for(int i = 0; i < 7; i++)                                                  //prints the choices 
=======
        for(int i = 0; i < 7; i++)                                          //prints the choices 
>>>>>>> changed names of headers
        {
            if(i == highlight)
            {
                wattron(menu_student_module_netsec, A_REVERSE);
            }
            if(i == 0)
            {
                mvwprintw(menu_student_module_netsec, 4, xMAx - 35, choices_student_level_netsec[i]);
            }
            else if(i == 1)
            {
                mvwprintw(menu_student_module_netsec, 4, xMAx - 23, choices_student_level_netsec[i]);
            }
            else
            {
                mvwprintw(menu_student_module_netsec, 1, start_of_first_level_place, choices_student_level_netsec[i]);
<<<<<<< HEAD
                start_of_first_level_place+=10;
            }
            wattroff(menu_student_module_netsec, A_REVERSE);
        }
        choice = wgetch(menu_student_module_netsec);                               //returns a single value representing the function key

        highlight = menu_switch_case_level(menu_student_module_netsec, highlight, choice);

        if(choice == 10 && highlight == 0)
        {
        	choose_modules();                                                       //back button
            return;
        }
        else if(choice == 10 && highlight == 1)                                     //exit button
=======
            }
            start_of_first_level_place+=10;
            wattroff(menu_student_module_netsec, A_REVERSE);
        }
        choice = wgetch(menu_student_module_netsec);                               //returns a single value representing the function key
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
        	student_level();
            //back button
        }
        else if(choice == 10 && highlight == 1)
>>>>>>> changed names of headers
        {
            endwin();
            exit(0);
        }
        else if(choice == 10 && highlight == 2)
        {
            //level 1
<<<<<<< HEAD
=======
            //int err = system("/home/test/hacklab/scripts/start_level01.sh >> /home/dominic/container.log 2>&1 | tmux");         //uses fork(2) to create a child process that executes the shell command
>>>>>>> changed names of headers
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