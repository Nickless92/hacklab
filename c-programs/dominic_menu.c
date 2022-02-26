#include <stdio.h>
#include <ncurses.h>
#include <stdlib.h>
#include <string.h>

int main()
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
    char *choices_schueler_level[7] =                                           //choices for the "schüler" levels
    {
        "Back [B]",
        "Exit [ESC]", 
        "Level 1",
        "Level 2",
        "Level 3",
        "Level 4",
        "Level 5",
    };
    char *choices_modules[5] =                                                  //choices for the different modules like Netzwerke, NetSec and Krypto
    {                   
        "Back [B]",
        "Exit [ESC]",                                     
        "Netzwerke",
        "Network Security",
        "Kryptographie",
    };
    char *choices_student_level_netzwerke[7] =                                  //choices for the "student" levels in module Netzwerke
    {
        "Back [B]",
        "Exit [ESC]", 
        "Level 1",
        "Level 2",
        "Level 3",
        "Level 4",
        "Level 5",
    };
    char *choices_student_level_netsec[7] =                                     //choices for the "student" levels in module Netsec
    {
        "Back [B]",
        "Exit [ESC]", 
        "Level 1",
        "Level 2",
        "Level 3",
        "Level 4",
        "Level 5",
    };
    char *choices_student_level_krypto[7] =                                     //choices for the "student" levels in module Krypto
    {
        "Back [B]",
        "Exit [ESC]", 
        "Level 1",
        "Level 2",
        "Level 3",
        "Level 4",
        "Level 5",
    };
    char *choices_experte_level[7] =                                            //choices for the "experte" levels
    {
        "Back [B]",
        "Exit [ESC]", 
        "Level 1",
        "Level 2",
        "Level 3",
        "Level 4",
        "Level 5",
    };

    int choice = 0;                                                             //variable for your choice in the menu
    int highlight = 0;                                                          //shows which choice is highlighted
    int yMAx, xMAx = 0;                                                         //variables for the size of the screen
    getmaxyx(stdscr, yMAx, xMAx);                                               //function to get the maximum size of the screen of your computer

    WINDOW * namewin = newwin(6, xMAx - 12, yMAx - 8, 5);                       //WINDOW creates a new window
    box(namewin, 0, 0);                                                         //box describes how the window should look like 
    WINDOW * menuwin = newwin(6, xMAx - 12, yMAx - 8, 5);                       //for every "level" of the menu you need to create a new window
    box(menuwin, 0, 0);
    WINDOW * menu_schueler_level = newwin(6, xMAx - 12, yMAx - 8, 5);
    box(menu_schueler_level, 0, 0);
    WINDOW * menu_student_module = newwin(6, xMAx - 12, yMAx - 8, 5);
    box(menu_student_module, 0, 0);
    WINDOW * menu_student_module_netzwerke = newwin(6, xMAx - 12, yMAx - 8, 5);
    box(menu_student_module_netzwerke, 0, 0);
    WINDOW * menu_student_module_netsec = newwin(6, xMAx - 12, yMAx - 8, 5);
    box(menu_student_module_netsec, 0, 0);
    WINDOW * menu_student_module_krypto = newwin(6, xMAx - 12, yMAx - 8, 5);
    box(menu_student_module_krypto, 0, 0);
    WINDOW * menu_experte_level = newwin(6, xMAx - 12, yMAx - 8, 5);
    box(menu_experte_level, 0, 0);
    WINDOW * conainerisloading = newwin(6, xMAx - 12, yMAx - 8, 5);             //new window for "Level is setting up..."
    box(conainerisloading, 0, 0);

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
    //getnstr(username, 25);
    //while ((username[position_of_current_letter - 21] = getch()) != '\n');
    
    /*while((username[position_of_current_letter - 21] = getch()) != '\n')        //we don't want to create an additional counter so we take the position_of_current_letter and subtract 21 --> we get the first(++) position of the array
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
    }*/

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
        //goto NAMENSEINGABE;
    }
    else if(choice == 10 && highlight == 1)                                     //exit button in knowledge --> when the exit button was choosen we exit the programm
    {
        endwin();
        exit(0);
    }
    else if (choice == 10 && highlight == 2)                                    //10 means enter and 2 means "Schüler" in the menu
    {
        wrefresh(menu_schueler_level);
        keypad(menu_schueler_level, true);
        choice = 0;
        highlight = 2;
        while(1)
        {
            int place = 2;                                                      //the first letter of the menu level should be printed at the upper left corner of the box
            for(int i = 0; i < 7; i++)                                          //prints the choices 
            {
                if(i == highlight)
                {
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
                    mvwprintw(menu_schueler_level, 1, place, choices_schueler_level[i]);
                    place+=10;                
                }
                wattroff(menu_schueler_level, A_REVERSE);
            }
            choice = wgetch(menu_schueler_level);                               //returns a single value representing the function key
            if(highlight == 0)                                                  //back button
            {
                switch(choice)
                {
                case KEY_LEFT:
                    highlight = 2;
                    break;
                case KEY_RIGHT:
                    highlight = 1;
                default:
                    break;
                }
            }
            else if(highlight == 1)                                             //exit button
            {
                switch(choice)
                {
                case KEY_LEFT:
                    highlight = 0;
                    break;
                default:
                    break;
                }
            }
            else
            {
                switch(choice)
                {
                    case KEY_LEFT:
                        highlight--;
                        if(highlight == 1)
                        {
                            highlight = 6;
                        }
                        break;
                    case KEY_RIGHT:
                        highlight++;
                        if(highlight == 7)
                        {
                            highlight = 2;
                        }
                        break;
                    case 'B':
                    case 'b':
                        highlight = 0;
                        break;
                    case 27:
                        highlight = 1;
                        break;
                    default:
                        break;
                }
            }    
            if(choice == 10 && highlight == 0)                                  //back button
            {
                //back
            }
            else if(choice == 10 && highlight == 1)                             //exit button
            {
                //exit
                endwin();
                exit(0);
            }
            else if(choice == 10 && highlight == 2)                             //Level 1
            {
                mvwprintw(conainerisloading, 1, 1, "Level is setting up...");
                refresh();
                wrefresh(conainerisloading);
                //int err = system("/home/dominic/hacklab/scripts/level_start.sh 1 3 ; clear ; sudo lxc exec lvl01-d01 -- tmux");         //uses fork(2) to create a child process that executes the shell command lxc exec lvl01-d01 -- tmux
                int err = system("../scripts/reusable/level_start.sh 1 3 ; clear ; sudo lxc exec lvl01-d01 -- tmux");         //uses fork(2) to create a child process that executes the shell command lxc exec lvl01-d01 -- tmux
                if(err == -1)
                {
                    fprintf(stderr, "child process could not be created");
                }
                //back to the menu
                endwin();
                exit(0);
            }
            else if(choice == 10 && highlight == 3)                             //Level 2
            {
                //Level 2
            }
            else if(choice == 10 && highlight == 4)                             //Level 3
            {
                //Level 3
            }
            else if(choice == 10 && highlight == 5)                             //Level 4
            {
                //Level 4
            }
            else if(choice == 10 && highlight == 6)                             //Level 5
            {
                //Level 5
            }
        }
    }
    else if(choice == 10 && highlight == 3)                                     //10 means enter and 3 means "Student" in the menu
    {
        wrefresh(menu_student_module);
        keypad(menu_student_module, true);
        mvwprintw(menu_student_module, 1, 1, "Please choose a module: ");

        highlight = 2;
        choice = 0;
        while(choice != 10)                                                     //loop that the user can choose a module
        {
            for(int i = 0; i < 5; i++)                                          //prints all choices of "choices_modules"
            {
                if(i == highlight)
                {
                    wattron(menu_student_module, A_REVERSE);                    //A_REVERSE marks one choice --> wattron (window attribute on)
                }
                if(i == 0)                                                      //we want to print the back button on the right bottom
                {
                    mvwprintw(menu_student_module, 4, xMAx - 35, choices_modules[i]);
                }
                else if(i == 1)                                                 //we want to print the exit button on the right bottom
                {
                    mvwprintw(menu_student_module, 4, xMAx - 23, choices_modules[i]);
                }
                else
                {
                    mvwprintw(menu_student_module, i, 1, choices_modules[i]);   //the other choices are printed
                }
                wattroff(menu_student_module, A_REVERSE);                       //the other possibilities are not highlighted
            }
            choice = wgetch(menu_student_module);                               //we get the character the user puts in
            if (highlight == 0)                                                 //the back button is highlighted 
            {
                switch (choice) 
                {
                case KEY_LEFT:                                                  //we can go to the menu again by pressing the left key 
                    highlight = 2;
                    break;
                case KEY_RIGHT:                                                 //press the right arrow key --> exit button is highlighted
                    highlight = 1;
                    break;
                default:
                    break;
                };
            } 
            else if(highlight == 1)                                             //the exit button is highlighted
            {
                switch (choice) 
                {
                case KEY_LEFT:                                                  //press the left arrow key --> back button is highlightedy 
                    highlight = 0;
                    break;
                default:
                    break;
                };            
            }
            else 
            {
                switch (choice)                                                 //we dont want to go out of the menu
                {
                case KEY_UP:                                                    //case is carried out when the user enters the up arrow key at the keyboard
                    highlight--;
                    if(highlight == 1)                                          //case you go out of the menu at the top
                    {
                        highlight = 4;                                          //the last choice of the menu is highlighted
                    }
                    break;
                case KEY_DOWN:                                                  //case is carried out when the user enters the down arrow key at the keyboard
                    highlight++;
                    if(highlight == 5)                                          //case you go out of the menu at the bottom
                    {
                        highlight = 2;                                          //the first choice of the menu is highlighted
                    }
                    break;
                case 'B':
                case 'b':
                    highlight = 0;
                    break;
                case 27:                                                        //highlights the exit button (27 = ESC)
                    highlight = 1;
                    break;
                default:
                    break;
                };
            }
        }

        if(choice == 10 && highlight == 0)                                      //back Button
        {
            //back
        }
        else if(choice == 10 && highlight == 1)                                 //exit button
        {
            endwin();
            exit(0);
        }
        else if(choice == 10 && highlight == 2)                                 //Netzwerke
        {
            //Netzwerke
            wrefresh(menu_student_module_netzwerke);
            keypad(menu_student_module_netzwerke, true);
            choice = 0;
            highlight = 2;
            while(1)
            {
                int place = 2;
                for(int i = 0; i < 7; i++)                                          //prints the choices 
                {
                    if(i == highlight)
                    {
                        wattron(menu_student_module_netzwerke, A_REVERSE);
                    }
                    if(i == 0)
                    {
                        mvwprintw(menu_student_module_netzwerke, 4, xMAx - 35, choices_student_level_netzwerke[i]);
                    }
                    else if(i == 1)
                    {
                        mvwprintw(menu_student_module_netzwerke, 4, xMAx - 23, choices_student_level_netzwerke[i]);
                    }
                    else
                    {
                        mvwprintw(menu_student_module_netzwerke, 1, place, choices_student_level_netzwerke[i]); 
                        place+=10;               
                    }
                    wattroff(menu_student_module_netzwerke, A_REVERSE);
                }
                choice = wgetch(menu_student_module_netzwerke);                               //returns a single value representing the function key
                if(highlight == 0)
                {
                    switch(choice)
                    {
                    case KEY_LEFT:
                        highlight = 2;
                        break;
                    case KEY_RIGHT:
                        highlight = 1;
                    default:
                        break;
                    }
                }
                else if(highlight == 1)
                {
                    switch(choice)
                    {
                    case KEY_LEFT:
                        highlight = 0;
                        break;
                    default:
                        break;
                    }
                }
                else
                {
                    switch(choice)
                    {
                        case KEY_LEFT:
                            highlight--;
                            if(highlight == 1)
                            {
                                highlight = 6;
                            }
                            break;
                        case KEY_RIGHT:
                            highlight++;
                            if(highlight == 7)
                            {
                                highlight = 2;
                            }
                            break;
                        case 'B':
                        case 'b':
                            highlight = 0;
                            break;
                        case 27:
                            highlight = 1;
                            break;
                        default:
                            break;
                    }
                }
                if(choice == 10 && highlight == 0)
                {
                    //back
                }
                else if(choice == 10 && highlight == 1)
                {
                    //exit
                    endwin();
                    exit(0);
                }
                else if(choice == 10 && highlight == 2)
                {
                    //Level 1
                    //int err = system("/home/test/hacklab/scripts/start_level01.sh >> /home/dominic/container.log 2>&1 | tmux");         //uses fork(2) to create a child process that executes the shell command
                }
                else if(choice == 10 && highlight == 3)
                {
                    //Level 2
                }
                else if(choice == 10 && highlight == 4)
                {
                    //Level 3
                }
                else if(choice == 10 && highlight == 5)
                {
                    //Level 4
                }
                else if(choice == 10 && highlight == 6)
                {
                    //Level 5
                }
            }
        }
        else if(choice == 10 && highlight == 3)                                 //Network Security
        {
            //Network Security
            wrefresh(menu_student_module_netsec);
            keypad(menu_student_module_netsec, true);
            choice = 0;
            highlight = 2;
            while(1)
            {
                int place = 2;
                for(int i = 0; i < 7; i++)                                          //prints the choices 
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
                        mvwprintw(menu_student_module_netsec, 1, place, choices_student_level_netsec[i]); 
                        place+=10;               
                    }
                    wattroff(menu_student_module_netsec, A_REVERSE);
                }
                choice = wgetch(menu_student_module_netsec);                               //returns a single value representing the function key
                if(highlight == 0)
                {
                    switch(choice)
                    {
                    case KEY_LEFT:
                        highlight = 2;
                        break;
                    case KEY_RIGHT:
                        highlight = 1;
                    default:
                        break;
                    }
                }
                else if(highlight == 1)
                {
                    switch(choice)
                    {
                    case KEY_LEFT:
                        highlight = 0;
                        break;
                    default:
                        break;
                    }
                }
                else
                {
                    switch(choice)
                    {
                        case KEY_LEFT:
                            highlight--;
                            if(highlight == 1)
                            {
                                highlight = 6;
                            }
                            break;
                        case KEY_RIGHT:
                            highlight++;
                            if(highlight == 7)
                            {
                                highlight = 2;
                            }
                            break;
                        case 'B':
                        case 'b':
                            highlight = 0;
                            break;
                        case 27:
                            highlight = 1;
                            break;
                        default:
                            break;
                    }
                }
                if(choice == 10 && highlight == 0)
                {
                    //back
                }
                else if(choice == 10 && highlight == 1)
                {
                    //exit
                    endwin();
                    exit(0);
                }
                else if(choice == 10 && highlight == 2)
                {
                    //Level 1
                    //int err = system("/home/test/hacklab/scripts/start_level01.sh >> /home/dominic/container.log 2>&1 | tmux");         //uses fork(2) to create a child process that executes the shell command
                }
                else if(choice == 10 && highlight == 3)
                {
                    //Level 2
                }
                else if(choice == 10 && highlight == 4)
                {
                    //Level 3
                }
                else if(choice == 10 && highlight == 5)
                {
                    //Level 4
                }
                else if(choice == 10 && highlight == 6)
                {
                    //Level 5
                }
            }
        }
        else if(choice == 10 && highlight == 4)                                 //Krypto
        {
            //Krypto
            wrefresh(menu_student_module_krypto);
            keypad(menu_student_module_krypto, true);
            choice = 0;
            highlight = 2;
            while(1)
            {
                int place = 2;
                for(int i = 0; i < 7; i++)                                          //prints the choices 
                {
                    if(i == highlight)
                    {
                        wattron(menu_student_module_krypto, A_REVERSE);
                    }
                    if(i == 0)
                    {
                        mvwprintw(menu_student_module_krypto, 4, xMAx - 35, choices_student_level_krypto[i]);
                    }
                    else if(i == 1)
                    {
                        mvwprintw(menu_student_module_krypto, 4, xMAx - 23, choices_student_level_krypto[i]);
                    }
                    else
                    {
                        mvwprintw(menu_student_module_krypto, 1, place, choices_student_level_krypto[i]);  
                        place+=10;              
                    }
                    wattroff(menu_student_module_krypto, A_REVERSE);
                }
                choice = wgetch(menu_student_module_krypto);                               //returns a single value representing the function key
                if(highlight == 0)
                {
                    switch(choice)
                    {
                    case KEY_LEFT:
                        highlight = 2;
                        break;
                    case KEY_RIGHT:
                        highlight = 1;
                    default:
                        break;
                    }
                }
                else if(highlight == 1)
                {
                    switch(choice)
                    {
                    case KEY_LEFT:
                        highlight = 0;
                        break;
                    default:
                        break;
                    }
                }
                else
                {
                    switch(choice)
                    {
                        case KEY_LEFT:
                            highlight--;
                            if(highlight == 1)
                            {
                                highlight = 6;
                            }
                            break;
                        case KEY_RIGHT:
                            highlight++;
                            if(highlight == 7)
                            {
                                highlight = 2;
                            }
                            break;
                        case 'B':
                        case 'b':
                            highlight = 0;
                            break;
                        case 27:
                            highlight = 1;
                            break;
                        default:
                            break;
                    }
                }
                if(choice == 10 && highlight == 0)
                {
                    //back
                }
                else if(choice == 10 && highlight == 1)
                {
                    //exit
                    endwin();
                    exit(0);
                }
                else if(choice == 10 && highlight == 2)
                {
                    //Level 1
                    //int err = system("/home/test/hacklab/scripts/start_level01.sh >> /home/dominic/container.log 2>&1 | tmux");         //uses fork(2) to create a child process that executes the shell command
                }
                else if(choice == 10 && highlight == 3)
                {
                    //Level 2
                }
                else if(choice == 10 && highlight == 4)
                {
                    //Level 3
                }
                else if(choice == 10 && highlight == 5)
                {
                    //Level 4
                }
                else if(choice == 10 && highlight == 6)
                {
                    //Level 5
                }
            }
        }
    }
    else if(choice == 10 && highlight == 4)                                     //10 means enter and 4 means "Experte" in the menu
    {
        wrefresh(menu_experte_level);
        keypad(menu_experte_level, true);
        choice = 0;
        highlight = 2;
        while(1)
        {
            int place = 2;
            for(int i = 0; i < 7; i++)                                          //prints the choices 
            {
                if(i == highlight)
                {
                    wattron(menu_experte_level, A_REVERSE);
                }
                if(i == 0)
                {
                    mvwprintw(menu_experte_level, 4, xMAx - 35, choices_experte_level[i]);
                }
                else if(i == 1)
                {
                    mvwprintw(menu_experte_level, 4, xMAx - 23, choices_experte_level[i]);
                }
                else
                {
                    mvwprintw(menu_experte_level, 1, place, choices_experte_level[i]);  
                    place+=10;              
                }
                wattroff(menu_experte_level, A_REVERSE);
            }
            choice = wgetch(menu_experte_level);                                //returns a single value representing the function key
            if(highlight == 0)
            {
                switch(choice)
                {
                case KEY_LEFT:
                    highlight = 2;
                    break;
                case KEY_RIGHT:
                    highlight = 1;
                default:
                    break;
                }
            }
            else if(highlight == 1)
            {
                switch(choice)
                {
                case KEY_LEFT:
                    highlight = 0;
                    break;
                default:
                    break;
                }
            }
            else
            {
                switch(choice)
                {
                    case KEY_LEFT:
                        highlight--;
                        if(highlight == 1)
                        {
                            highlight = 6;
                        }
                        break;
                    case KEY_RIGHT:
                        highlight++;
                        if(highlight == 7)
                        {
                            highlight = 2;
                        }
                        break;
                    case 'B':
                    case 'b':
                        highlight = 0;
                        break;
                    case 27:
                        highlight = 1;
                        break;
                    default:
                        break;
                }
            }
            if(choice == 10 && highlight == 0)                                  //back button
            {
                //back
            }   
            else if(choice == 10 && highlight == 1)                             //exit button
            {
                //exit
                endwin();
                exit(0);
            }
            else if(choice == 10 && highlight == 2)                             //Level 1
            {
                //Level 1
                //int err = system("/home/test/hacklab/scripts/start_level01.sh >> /home/dominic/container.log 2>&1 | tmux");         //uses fork(2) to create a child process that executes the shell command
            }
            else if(choice == 10 && highlight == 3)                             //Level 2
            {
                //Level 2
            }
            else if(choice == 10 && highlight == 4)                             //Level 3
            {
                //Level 3
            }
            else if(choice == 10 && highlight == 5)                             //Level 4
            {
                //Level 4
            }
            else if(choice == 10 && highlight == 6)                             //Level 5
            {
                //Level 5
            }
        }
    }

    endwin();                                                                   //we need to close the window

    return 0; 
}



// WINDOW * conainerisloading = newwin(6, xMAx - 12, yMAx - 8, 5);     //new window for "Level is setting up..."
// box(conainerisloading, 0, 0);
// mvwprintw(conainerisloading, 1, 1, "Level is setting up...");
// //refresh();
// wrefresh(conainerisloading);
// int err = system("/home/test/hacklab/scripts/start_level01.sh >> /home/dominic/container.log 2>&1");       //uses fork(2) to create a child process that executes the shell command