#ifndef EXPERTE_LEVEL_H_INCLUDED
#define EXPERTE_LEVEL_H_INCLUDED





void experte_le(void)
{
    initscr();                                                                  //initialize the screen
    noecho();                                                                   //suppresses to show the symbols you type in                                          
    //cbreak();                                                                   //disables line buffering
    curs_set(0);                                                                //disables the curser
    
    char *choices_experte_level[7] =                                           //choices for the "schüler" levels
    {
        "Back [B]",
        "Exit [ESC]", 
        "Level 1",
        "Level 2",
        "Level 3",
        "Level 4",
        "Level 5",
    };
    
                                                              //shows which choice is highlighted
    int yMAx, xMAx = 0;                                                         //variables for the size of the screen
    getmaxyx(stdscr, yMAx, xMAx);                                               //function to get the maximum size of the screen of your comput
    
   
    WINDOW * menu_experte_level = newwin(6, xMAx - 12,yMAx - 8, 5);
    box(menu_experte_level, 0, 0);
    wrefresh(menu_experte_level);
    keypad(menu_experte_level, true);
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
                mvwprintw(menu_experte_level, 4, xMAx - 35, choices_experte_level[i]);
            }
            else if(i == 1)
            {
                mvwprintw(menu_experte_level, 4, xMAx - 23, choices_experte_level[i]);
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
        	menu();
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


#endif
