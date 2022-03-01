#ifndef KRYPTOGRAPHIE_LE_H_INCLUDED
#define KRYPTOGRAPHIE_LE_H_INCLUDED

void choose_modules();
int menu_switch_case(WINDOW * name_of_window, int highlight, int choice);

void kryptographie_levels(void)
{    
    char *choices_student_level_krypto[7] =                                           //choices for the "schüler" levels
    {
        "Back [B]",
        "Exit [ESC]", 
        "Level 1",
        "Level 2",
        "Level 3",
        "Level 4",
        "Level 5",
    };

    int yMAx, xMAx = 0;                                                         //variables for the size of the screen
    getmaxyx(stdscr, yMAx, xMAx);                                               //function to get the maximum size of the screen of your comput
    
    WINDOW * menu_student_module_krypto = newwin(6, xMAx - 12,yMAx - 8, 5);
    box(menu_student_module_krypto, 0, 0);
    wrefresh(menu_student_module_krypto);
    keypad(menu_student_module_krypto, true);
    int highlight = 2;
    int choice = 0;
    while(1)
    {
        int start_of_first_level_place = 1;
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
                mvwprintw(menu_student_module_krypto, 1, start_of_first_level_place, choices_student_level_krypto[i]);
                start_of_first_level_place+=10;
            }
            wattroff(menu_student_module_krypto, A_REVERSE);
        }
        choice = wgetch(menu_student_module_krypto);                               //returns a single value representing the function key
        highlight = menu_switch_case_level(menu_student_module_krypto, highlight, choice);

        if(choice == 10 && highlight == 0)
        {
        	choose_modules();
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
    return;
}

#endif