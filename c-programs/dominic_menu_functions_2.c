#include <stdio.h>
#include <ncurses.h>
#include <stdlib.h>
#include <string.h>

// void createWindow(char name_of_window[], int nlines, int ncols, int y, int x, int border_vertical, int border_horizontal)
// {
//     WINDOW * name_of_window = newwin(nlines, ncols, y, x);
//     box(name_of_window, border_vertical, border_horizontal);
// }

char *enterName(WINDOW * name_of_window, int startY, int startX, int yMAx, int xMAx)
{
    char username[] = {};
    char message[] = "Please enter a name: ";
    int position_of_current_letter = strlen(message);

    mvwprintw(name_of_window, startY, startX, "Please enter a name: ");                          //prints text in the box
    mvwprintw(name_of_window, 4, xMAx - 25, "EXIT [ESC]");
    refresh();
    wrefresh(name_of_window);

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
            mvwprintw(name_of_window, 1, ++position_of_current_letter, "%c", username[position_of_current_letter - 21]);             //each letter will be printed in the box/Window "namewin"
        }
        wrefresh(name_of_window);                                                      //you need to refresh the window, that the name the user types in is shown   
    } while((username[position_of_current_letter - 21] = getch()) != '\n');

    return username;
}

int menu_switch_case(WINDOW * name_of_window, int highlight, int choice)
{
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
        return highlight;
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
        return highlight;        
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
        return highlight;
    }
}

int menu_switch_case_level(WINDOW * name_of_window, int highlight, int choice)
{
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
        return highlight;
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
        return highlight;          
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
        return highlight;
    }   
}


int chooseKnowledge(WINDOW * name_of_window, int yMAx, int xMAx)
{
    char *choices_knowledge_level[5] =                                          //choices for the knowledge level
    {                   
        "Back [B]",
        "Exit [ESC]",                                     
        "Pupil    -  for people who have not attended any modules at HS-Worms",
        "Student  -  in the next step you can choose between different modules",
        "Expert   -  you can choose between all levels of pupil and student",
    };

    wrefresh(name_of_window);
    keypad(name_of_window, true);                                                      //the keypad option enables the keypad of the user's terminal
    mvwprintw(name_of_window, 1, 1, "Please choose your knowledge: ");
    int highlight = 2;
    int choice = 0;
    while(choice != 10)                                                         //loop that the user can choose an option of his knowledge
    {
        for(int i = 0; i < 5; i++)                                              //prints all choices of "choices_knowledge_level"
        {
            if(i == highlight)
            {
                wattron(name_of_window, A_REVERSE);                                    //A_REVERSE marks one choice --> wattron (window attribute on)
            }
            if(i == 0)                                                          //we want to print the back button on the right bottom
            {
                mvwprintw(name_of_window, 4, xMAx - 35, choices_knowledge_level[i]);
            }
            else if(i == 1)                                                     //we want to print the exit button on the right bottom
            {
                mvwprintw(name_of_window, 4, xMAx - 23, choices_knowledge_level[i]);
            }
            else
            {
                mvwprintw(name_of_window, i, 1, choices_knowledge_level[i]);           //the other choices are printed
            }
            wattroff(name_of_window, A_REVERSE);                                       //window attribute off --> the other possibilities are not marked
        }
        choice = wgetch(name_of_window);                                               //we get the character the user puts in

        highlight = menu_switch_case(name_of_window, highlight, choice);
    }
    return highlight;
}

int user_chose_pupil(WINDOW * name_of_window, int yMAx, int xMAx)
{
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

    wrefresh(name_of_window);
    keypad(name_of_window, true);
    int choice = 0;
    int highlight = 2;
    while(1)
    {
        int place = 2;                                                      //the first letter of the menu level should be printed at the upper left corner of the box
        for(int i = 0; i < 7; i++)                                          //prints the choices 
        {
            if(i == highlight)
            {
                wattron(name_of_window, A_REVERSE);
            }
            if(i == 0)
            {
                mvwprintw(name_of_window, 4, xMAx - 35, choices_schueler_level[i]);
            }
            else if(i == 1)
            {
                mvwprintw(name_of_window, 4, xMAx - 23, choices_schueler_level[i]);
            }
            else
            {
                mvwprintw(name_of_window, 1, place, choices_schueler_level[i]);
                place+=10;                
            }
            wattroff(name_of_window, A_REVERSE);
        }
        choice = wgetch(name_of_window);                               //returns a single value representing the function key
        highlight = menu_switch_case_level(name_of_window, highlight, choice);
    }
    return highlight;
}

int user_chose_student(WINDOW * name_of_window, int yMAx, int xMAx)
{
    char *choices_modules[5] =                                                  //choices for the different modules like Netzwerke, NetSec and Krypto
    {                   
        "Back [B]",
        "Exit [ESC]",                                     
        "Netzwerke",
        "Network Security",
        "Kryptographie",
    };

    wrefresh(name_of_window);
    keypad(name_of_window, true);
    mvwprintw(name_of_window, 1, 1, "Please choose a module: ");

    int highlight = 2;
    int choice = 0;
    while(choice != 10)                                                     //loop that the user can choose a module
    {
        for(int i = 0; i < 5; i++)                                          //prints all choices of "choices_modules"
        {
            if(i == highlight)
            {
                wattron(name_of_window, A_REVERSE);                    //A_REVERSE marks one choice --> wattron (window attribute on)
            }
            if(i == 0)                                                      //we want to print the back button on the right bottom
            {
                mvwprintw(name_of_window, 4, xMAx - 35, choices_modules[i]);
            }
            else if(i == 1)                                                 //we want to print the exit button on the right bottom
            {
                mvwprintw(name_of_window, 4, xMAx - 23, choices_modules[i]);
            }
            else
            {
                mvwprintw(name_of_window, i, 1, choices_modules[i]);   //the other choices are printed
            }
            wattroff(name_of_window, A_REVERSE);                       //the other possibilities are not highlighted
        }
        choice = wgetch(name_of_window);                               //we get the character the user puts in
        highlight = menu_switch_case(name_of_window, highlight, choice);
    }
    return highlight;
}


int user_chose_netzwerke(WINDOW * name_of_window, int yMAx, int xMAx)
{
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

    wrefresh(name_of_window);
    keypad(name_of_window, true);
    int choice = 0;
    int highlight = 2;
    while(1)
    {
        int place = 2;
        for(int i = 0; i < 7; i++)                                          //prints the choices 
        {
            if(i == highlight)
            {
                wattron(name_of_window, A_REVERSE);
            }
            if(i == 0)
            {
                mvwprintw(name_of_window, 4, xMAx - 35, choices_student_level_netzwerke[i]);
            }
            else if(i == 1)
            {
                mvwprintw(name_of_window, 4, xMAx - 23, choices_student_level_netzwerke[i]);
            }
            else
            {
                mvwprintw(name_of_window, 1, place, choices_student_level_netzwerke[i]); 
                place+=10;               
            }
            wattroff(name_of_window, A_REVERSE);
        }
        choice = wgetch(name_of_window);                               //returns a single value representing the function key
        highlight = menu_switch_case_level(name_of_window, highlight, choice);
    }
    return highlight;
}



int main()
{
    initscr();                                                                  //initialize the screen
    noecho();                                                                   //suppresses to show the symbols you type in                                          
    //cbreak();                                                                 //disables line buffering
    curs_set(0);                                                                //disables the curser

    int yMAx, xMAx = 0;                                                         //variables for the size of the screen
    getmaxyx(stdscr, yMAx, xMAx);                                               //function to get the maximum size of the screen of your computer
    int highlight = 0;

    WINDOW * namewin = newwin(6, xMAx - 12, yMAx - 8, 5);                       //WINDOW creates a new window
    box(namewin, 0, 0);                                                         //box describes how the window should look like 
    WINDOW * menu_knowledge = newwin(6, xMAx - 12, yMAx - 8, 5);                       //for every "level" of the menu you need to create a new window
    box(menu_knowledge, 0, 0);
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


    char username = enterName(namewin, 1, 1, yMAx, xMAx);

    highlight = chooseKnowledge(menu_knowledge, yMAx, xMAx);

    if(highlight == 0)
    {
        wrefresh(namewin);
        username = enterName(namewin, 1, 1, yMAx, xMAx);
    }
    else if(highlight == 1)
    {
        endwin();
        exit(0);
    }
    else if(highlight == 2)
    {
        highlight = user_chose_pupil(menu_schueler_level, yMAx, xMAx);
    }
    else if(highlight == 3)
    {
        highlight = user_chose_student(menu_student_module, yMAx, xMAx);

        if(highlight == 0)
        {
            highlight = chooseKnowledge(menu_knowledge, yMAx, xMAx);
        }
        else if(highlight == 1)
        {
            endwin();
            exit(0);
        }
        else if(highlight == 2)
        {
            highlight = user_chose_netzwerke(menu_student_module_netzwerke, yMAx, xMAx);
        }
    }

    endwin();

    return 0;
}