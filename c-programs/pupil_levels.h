#ifndef SCHUELER_LE_H_INCLUDED
#define SCHUELER_LE_H_INCLUDED

void choose_knowledge();
int menu_switch_case_level(WINDOW * name_of_window, int highlight, int choice);

void pupil_levels()
{    
    char *choices_pupil_level[7] =                                           //choices for the pupil levels
    {
        "Back [B]",
        "Exit [ESC]", 
        "Level 1",
        "Level 2",
        "Level 3",
        "Level 4",
        "Level 5",
    };
    
    int yMAx, xMAx = 0;                                                     //variables for the size of the screen
    getmaxyx(stdscr, yMAx, xMAx);                                           //function to get the maximum size of the screen of your comput
    
    WINDOW * menu_pupil_level = newwin(6, xMAx - 12,yMAx - 8, 5);
    box(menu_pupil_level, 0, 0);
    wrefresh(menu_pupil_level);
    keypad(menu_pupil_level, true);
    int highlight = 2;
    int choice = 0;
    while(1)
    {
        int start_of_first_level_place = 1;
        for(int i = 0; i < 7; i++)                                          //prints the choices 
        {
            if(i == highlight)
            {
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
        {
            endwin();
            exit(0);
        }
        else if(choice == 10 && highlight == 2)                      
        {
            //level 1
            //int err = system("../scripts/level_start.sh 1 3 ; clear ; sudo tmux new-session -s lvl01 -d 'lxc exec lvl01-d02 -- tshark -i eno1''\;' split-window -v -d 'lxc shell lvl01-d01' '\;' split-window -h -d 'lxc exec lvl01-d03 -- tshark -i eno1' '\;' attach");         //uses fork(2) to create a child process that executes the shell command
            pupil_levels();
            return;
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