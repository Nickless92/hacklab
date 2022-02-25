#include <stdio.h>
#include <ncurses.h>
#include <stdlib.h>
#include <string.h>

// void enterName(int window_xMAx, int window_yMAx)
// {
//     WINDOW * namewin = newwin(6, window_xMAx - 12, window_yMAx - 8, 5);          //creates a new window
//     box(namewin, 0, 0);                                                         //describes how the window should look like 
//     mvwprintw(namewin, 1, 1, "Please enter a name: ");                          //prints text in the box
//     mvwprintw(namewin, 4, window_xMAx - 25, "EXIT [ESC]");
//     refresh();                                                                  //you have to refresh the screen that you can see the text
//     wrefresh(namewin);                                                          //refreshes the window
//     char username[] = {};                                                       //char array to save the name the user entered
//     int position_of_current_letter = 21;                                        //we need this, because the name the user entered should be printed next to th string "Please enter a name: "
//     while((username[position_of_current_letter - 21] = getch()) != '\n')        //we don't want to create an additional counter so we take the position_of_current_letter and subtract 21 --> we get the first(++) position of the array
//     {
//         if(username[position_of_current_letter - 21] == 127)                    //127 is delete character
//         {
//             //goto EINGABE;
//             enterName(window_xMAx, window_yMAx);
//             //username[] = '\0';
//             //how can we delete the last character???????
//         }
//         else if(username[position_of_current_letter - 21] == 27)
//         {
//             endwin();
//             exit(0);
//         }
//         else
//         {
//             mvwprintw(namewin, 1, ++position_of_current_letter, "%c", username[position_of_current_letter - 21]);             //each letter will be printed in the box "namewin"
//         }
//         wrefresh(namewin);                                                      //you need to refresh the window, that the name the user types in is shown
//     }
//     return; 
// }

int chooseKnowledge(int window_xMAx, int window_yMAx)
{
    char *choices_knowledge_level[5] =                                          //choices for the knowledge level
    {                   
        "Back [B]",
        "Exit [ESC]",                                     
        "Schüler",
        "Student",
        "Experte",
    };

    WINDOW * menuwin = newwin(6, window_xMAx - 12, window_yMAx - 8, 5);                       //for every "level" of the menu you need to create a new window
    box(menuwin, 0, 0);
    wrefresh(menuwin);
    keypad(menuwin, true);                                                      //the keypad option enables the keypad of the user's terminal
    mvwprintw(menuwin, 1, 1, "Please choose your knowledge:");
    int highlight = 2;
    int choice = 0;
    while(choice != 10)                                                         //loop that the user can choose an option of his knowledge
    {
        for(int i = 0; i < 5; i++)                                              //prints all choices of "choices_knowledge_level"
        {
            if(i == highlight)
            {
                wattron(menuwin, A_REVERSE);                                    //A_REVERSE marks one choice --> wattron (window attribute on)
            }
            if(i == 0)                                                          //we want to print the exit button on the right bottom
            {
                mvwprintw(menuwin, 4, window_xMAx - 35, choices_knowledge_level[i]);
            }
            else if(i == 1)
            {
                mvwprintw(menuwin, 4, window_xMAx - 23, choices_knowledge_level[i]);
            }
            else
            {
                mvwprintw(menuwin, i, 1, choices_knowledge_level[i]);       //the other choices are printed
            }
            wattroff(menuwin, A_REVERSE);                                       //without a mark
        }
        choice = wgetch(menuwin);                                               //we get the character the user puts in
        if (highlight == 0)                                                     //if the highlight is on the exit button 
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
            case 27:                                                           //highlights the exit button
                highlight = 1;
                break;
            default:
                break;
            }
        }
    }    
    return highlight;
}

void user_chose_schueler(int window_xMAx, int window_yMAx)
{
    char *choices_schueler_level[7] =                                            //choices for the "schüler" levels
    {
        "Back [B]",
        "Exit [ESC]",
        "Level 1",
        "Level 2",
        "Level 3",
        "Level 4",
        "Level 5",
    };

    WINDOW * menu_schueler_level = newwin(6, window_xMAx - 12, window_yMAx - 8, 5);
    box(menu_schueler_level, 0, 0);
    wrefresh(menu_schueler_level);
    keypad(menu_schueler_level, true);
    int highlight = 2;
    int choice = 0;
    while(1)
    {
        int start_of_first_level_place = 1;
        for(int i = 0; i < 7; i++)                                          //prints the choices 
        {
            if(i == highlight)
            {
                wattron(menu_schueler_level, A_REVERSE);
            }
            if(i == 0)
            {
                mvwprintw(menu_schueler_level, 4, window_xMAx - 35, choices_schueler_level[i]);
            }
            else if(i == 1)
            {
                mvwprintw(menu_schueler_level, 4, window_xMAx - 23, choices_schueler_level[i]);
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
            //back button
        }
        else if(choice == 10 && highlight == 1)
        {
            endwin();
            exit(0);
        }
        else if(choice == 10 && highlight == 2)
        {
            //level 1
            //int err = system("/home/test/hacklab/scripts/start_level01.sh >> /home/dominic/container.log 2>&1 | tmux");         //uses fork(2) to create a child process that executes the shell command
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
}

void user_chose_student(int window_xMAx, int window_yMAx)
{
    char *choices_student_level[5] =                                            //choices for the "student" levels
    {
        "Level 1",
        "Level 2",
        "Level 3",
        "Level 4",
        "Level 5",
    };

    WINDOW * menu_student_level = newwin(6, window_xMAx - 12, window_yMAx - 8, 5);
    box(menu_student_level, 0, 0);
    wrefresh(menu_student_level);  
    keypad(menu_student_level, true);
    int highlight = 0;
    int choice = 0;
    while(1)
    {
        int start_of_first_level_place = 2;
        for(int i = 0; i < 5; i++)                                          //prints the choices 
        {
            if(i == highlight)
            {
                wattron(menu_student_level, A_REVERSE);
            }
            mvwprintw(menu_student_level, 1, start_of_first_level_place, choices_student_level[i]);
            start_of_first_level_place+=10;
            wattroff(menu_student_level, A_REVERSE);
        }
        choice = wgetch(menu_student_level);                               //returns a single value representing the function key
        switch (choice)                                                     //we dont want to go out of the menu
        {
        case KEY_LEFT:                                                      //case you go out of the menu at the top
            highlight--;
            if(highlight == -1)
            {
                highlight = 4;
            }
            break;
        case KEY_RIGHT:                                                     //case you go out of the menu at the bottom
            highlight++;
            if(highlight == 5)
            {
                highlight = 0;
            }
            break;
        case 10:
            break;
        default:
            break;
        }
        if(choice == 10 && highlight == 0)
        {
            //int err = system("/home/test/hacklab/scripts/start_level01.sh >> /home/dominic/container.log 2>&1 | tmux");         //uses fork(2) to create a child process that executes the shell command
        }
    }
}

int chooseModule(int window_xMAx, int window_yMAx)
{
    char *choices_modules[5] =                                          //choices for the knowledge level
    {                   
        "Back [B]",
        "Exit [ESC]",                                     
        "Netzwerke",
        "Network Security",
        "Kryptographie",
    };

    WINDOW * menu_student_module = newwin(6, window_xMAx - 12, window_yMAx - 8, 5);                       //for every "level" of the menu you need to create a new window
    box(menu_student_module, 0, 0);
    wrefresh(menu_student_module);
    keypad(menu_student_module, true);                                                      //the keypad option enables the keypad of the user's terminal
    mvwprintw(menu_student_module, 1, 1, "Please choose your knowledge:");
    int highlight = 2;
    int choice = 0;
    while(choice != 10)                                                         //loop that the user can choose an option of his knowledge
    {
        for(int i = 0; i < 5; i++)                                              //prints all choices of "choices_knowledge_level"
        {
            if(i == highlight)
            {
                wattron(menu_student_module, A_REVERSE);                                    //A_REVERSE marks one choice --> wattron (window attribute on)
            }
            if(i == 0)                                                          //we want to print the exit button on the right bottom
            {
                mvwprintw(menu_student_module, 4, window_xMAx - 35, choices_modules[i]);
            }
            else if(i == 1)
            {
                mvwprintw(menu_student_module, 4, window_xMAx - 23, choices_modules[i]);
            }
            else
            {
                mvwprintw(menu_student_module, i, 1, choices_modules[i]);       //the other choices are printed
            }
            wattroff(menu_student_module, A_REVERSE);                                       //without a mark
        }
        choice = wgetch(menu_student_module);                                               //we get the character the user puts in
        if (highlight == 0)                                                     //if the highlight is on the exit button 
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
            case 27:                                                           //highlights the exit button
                highlight = 1;
                break;
            default:
                break;
            }
        }
    }    
    return highlight;
}    

void user_chose_experte(int window_xMAx, int window_yMAx)
{
    char *choices_experte_level[5] =                                        //choices for the "experte" levels
    {
        "Level 1",
        "Level 2",
        "Level 3",
        "Level 4",
        "Level 5",
    };
    WINDOW * menu_experte_level = newwin(6, window_xMAx - 12, window_yMAx - 8, 5);
    box(menu_experte_level, 0, 0);
    wrefresh(menu_experte_level);
    int highlight = 2;
    int choice = 0;
    while(1)
    {
        int start_of_first_level_place = 1;
        for(int i = 0; i < 7; i++)                                          //prints the choices 
        {
            if(i == highlight)
            {
                wattron(menu_experte_level, A_REVERSE);
            }
            if(i == 0)
            {
                mvwprintw(menu_experte_level, 4, window_xMAx - 35, choices_experte_level[i]);
            }
            else if(i == 1)
            {
                mvwprintw(menu_experte_level, 4, window_xMAx - 23, choices_experte_level[i]);
            }
            else
            {
                mvwprintw(menu_experte_level, 1, start_of_first_level_place, choices_experte_level[i]);
            }
            start_of_first_level_place+=10;
            wattroff(menu_experte_level, A_REVERSE);
        }
        choice = wgetch(menu_experte_level);                               //returns a single value representing the function key
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
            //back button
        }
        else if(choice == 10 && highlight == 1)
        {
            endwin();
            exit(0);
        }
        else if(choice == 10 && highlight == 2)
        {
            //level 1
            //int err = system("/home/test/hacklab/scripts/start_level01.sh >> /home/dominic/container.log 2>&1 | tmux");         //uses fork(2) to create a child process that executes the shell command
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
}


int main()
{
    initscr();                                                                  //initialize the screen
    noecho();                                                                   //suppresses to show the symbols you type in                                          
    cbreak();                                                                   //disables line buffering
    curs_set(0);                                                                //disables the curser

    //int choice = 0;                                                             //variable for your choice in the menu
    int highlight = 0;                                                          //shows which choice is highlighted

    int xMAx, yMAx = 0;                                                         //variables for the size of the screen
    getmaxyx(stdscr, yMAx, xMAx);                                               //funktion to get the maximum size of the screen of your computer

    WINDOW * namewin = newwin(6, xMAx - 12, yMAx - 8, 5);                       //create a new window
    box(namewin, 0, 0);                                                         //describes how the window should look like 
    mvwprintw(namewin, 1, 1, "Please enter a name: ");                          //prints text in the box
    mvwprintw(namewin, 4, xMAx - 25, "EXIT [ESC]");
    refresh();                                                                  //you have to refresh the screen that you can see the text
    wrefresh(namewin);                                                          //refreshes the window
    char username[] = {};                                                       //char array to save the name the user entered
    int position_of_current_letter = 21;                                        //we need this, because the name the user entered should be printed next to th string "Please enter a name: "
    while((username[position_of_current_letter - 21] = getch()) != '\n')        //we don't want to create an additional counter so we take the position_of_current_letter and subtract 21 --> we get the first(++) position of the array
    {
        if(username[position_of_current_letter - 21] == 127)                    //127 is delete character
        {
            //goto EINGABE;

            //how can we delete the last character???????
        }
        else if(username[position_of_current_letter - 21] == 27)
        {
            endwin();
            exit(0);
        }
        else
        {
            mvwprintw(namewin, 1, ++position_of_current_letter, "%c", username[position_of_current_letter - 21]);             //each letter will be printed in the box "namewin"
        }
        wrefresh(namewin);                                                      //you need to refresh the window, that the name the user types in is shown
    }

    highlight = chooseKnowledge(xMAx, yMAx);

    if(highlight == 0)
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
        user_chose_schueler(xMAx, yMAx);
    }
    else if(highlight == 3)                                     //10 means enter and 1 means "Student" in the menu
    {
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
    }

    endwin();                                                                   //we need to close the window

    return 0; 
}