#ifndef MENU_H_INCLUDED
#define MENU_H_INCLUDED

void name();
void schueler_le();
void student_level();
void experte_le();
int menu_switch_case(WINDOW * name_of_window, int highlight, int choice);

void menu()
{  
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

        highlight = menu_switch_case(menuwin, highlight, choice);
    }

    if(choice == 10 && highlight == 0)                                          //back button in knowledge
    {
    	name();
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
    
    return;
}

#endif