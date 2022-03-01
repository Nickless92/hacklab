#ifndef STUDENT_LEVEL_H_INCLUDED
#define STUDENT_LEVEL_H_INCLUDED

void choose_knowledge();                                                                //function declerations of the functions we use below
void network_levels();
void netzwork_security_levels();
void kryptographie_levels();
int menu_switch_case(WINDOW * name_of_window, int highlight, int choice);

void choose_modules()
{    
    char *choices_modules[5] =                                                          //choices for the knowledge level
    {                   
        "Back [B]",
        "Exit [ESC]",                                     
        "Netzwerke",
        "Network Security",
        "Kryptographie",
    };
    
    int yMAx, xMAx = 0;                                                                 //variables for the size of the screen
    getmaxyx(stdscr, yMAx, xMAx);                                                       //function to get the maximum size of the screen of your comput
    
    WINDOW * menu_student_module = newwin(6,xMAx - 12, yMAx - 8, 5);                    //for every "level" of the menu you need to create a new window
    box(menu_student_module, 0, 0);
    wrefresh(menu_student_module);
    keypad(menu_student_module, true);                                                  //the keypad option enables the keypad of the user's terminal
    mvwprintw(menu_student_module, 1, 1, "Please choose a module: ");
    int highlight = 2;
    int choice = 0;
    while(choice != 10)                                                                 //loop that the user can choose a module
    {
        for(int i = 0; i < 5; i++)                                                      //prints all choices of "choices_modules"
        {
            if(i == highlight)
            {
                wattron(menu_student_module, A_REVERSE);                                //A_REVERSE marks one choice --> wattron (window attribute on)
            }
            if(i == 0)                                                                  //we want to print the exit button at the right bottom
            {
                mvwprintw(menu_student_module, 4, xMAx - 35, choices_modules[i]);
            }
            else if(i == 1)
            {
                mvwprintw(menu_student_module, 4, xMAx - 23, choices_modules[i]);
            }
            else
            {
                mvwprintw(menu_student_module, i, 1, choices_modules[i]);               //the other choices are printed
            }
            wattroff(menu_student_module, A_REVERSE);                                   //without a mark
        }
        choice = wgetch(menu_student_module);                                           //we get the character the user puts in
        highlight = menu_switch_case(menu_student_module, highlight, choice);

        if(choice == 10 && highlight == 0)
        {
        	choose_knowledge();                                                         //back button
            return;
        }
        else if(choice == 10 && highlight == 1)
        {
            endwin();
            exit(0);
        }
        else if(choice == 10 && highlight == 2)
        {
        	network_levels();                                                           // Netzwerke button
            return;
        }
        else if(choice == 10 && highlight == 3)
        {
        	netzwork_security_levels();                                                 //Network Security button
            return;
        }
        else if(choice == 10 && highlight == 4)
        {
        	kryptographie_levels();                                                     //Kryptographie button
            return;
        }  
    }    
    return;
}

#endif