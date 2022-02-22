#include <stdio.h>
#include <ncurses.h>
#include <string.h>
#include <menu.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdlib.h>


int main()
{
    initscr();                                                                  //initialize the screen
    noecho();                                                                   //suppresses to show the symbols you type in                                          
    cbreak();                                                                   //disables line buffering

    char *choices_knowledge_level[3] =                                          //choices for the knowledge level
    {                                                        
        "Schüler",
        "Student",
        "Experte",
    };
    char *choices_schueler_level[5] =                                            //choices for the "schüler" levels
    {
        "Level 1",
        "Level 2",
        "Level 3",
        "Level 4",
        "Level 5",
    };
    char *choices_student_level[5] =                                            //choices for the "student" levels
    {
        "Level 1",
        "Level 2",
        "Level 3",
        "Level 4",
        "Level 5",
    };
        char *choices_experte_level[5] =                                        //choices for the "experte" levels
    {
        "Level 1",
        "Level 2",
        "Level 3",
        "Level 4",
        "Level 5",
    };
    int choice = 0;
    int highlight = 0;

    int yMAx, xMAx = 0;                                                         //variables for the size of the screen
    getmaxyx(stdscr, yMAx, xMAx);                                               //funktion to get the maximum size of the screen of your computer

    WINDOW * namewin = newwin(6, xMAx - 12, yMAx - 8, 5);                       //create a new window
    box(namewin, 0, 0);                                                         //describes how the window should look like 
    mvwprintw(namewin, 1, 1, "Please enter a name: ");                          //prints text in the box
    refresh();                                                                  //you have to refresh the screen that you can see the text
    wrefresh(namewin);                                                          //refreshes the window
    char username[] = {};                                                                   //char array to save the name the user entered
    int position_of_first_letter = 21;                                          //we need this, because the name the user entered should be printed next to th string "Please enter a name: "
    while((username[position_of_first_letter - 21] = getch()) != '\n')          //we don't want to create an additional counter so we take the position_of_first_letter and subtract 21 --> we get the first(++) position of the array
    {
        mvwprintw(namewin, 1, ++position_of_first_letter, "%c", username[position_of_first_letter - 21]);             //each letter will be printed in the box "namewin"
        wrefresh(namewin);                                                      //you need to refresh the window
    }

    WINDOW * menuwin = newwin(6, xMAx - 12, yMAx - 8, 5);                       //for every "level" of the menu you need to create a new window
    box(menuwin, 0, 0);
    //refresh();
    wrefresh(menuwin);
    keypad(menuwin, true);                                                      //the keypad option enables the keypad of the user's terminal

    while(1)                                                                    //loop that the user can choose an option 
    {
        for(int i = 0; i < 3; i++)                                              //go through the choices 
        {
            if(i == highlight)
            {
                wattron(menuwin, A_REVERSE);
            }
            mvwprintw(menuwin, i + 1, 1, choices_knowledge_level[i]);
            wattroff(menuwin, A_REVERSE);
        }
        choice = wgetch(menuwin);                                               //returns a single value representing the function key
        switch (choice)                                                         //we dont want to go out of the menu
        {
        case KEY_UP:                                                            //case you go out of the menu at the top
            highlight--;
            if(highlight == -1)
            {
                highlight = 0;
            }
            break;
        case KEY_DOWN:                                                          //case you go out of the menu at the bottom
            highlight++;
            if(highlight == 3)
            {
                highlight = 2;
            }
        default:
            break;
        }

        if (choice == 10 && highlight == 0)                                     //10 means enter
        {
            WINDOW * conainerisloading = newwin(6, xMAx - 12, yMAx - 8, 5);     //new window for "Level is setting up..."
            box(conainerisloading, 0, 0);
            mvwprintw(conainerisloading, 1, 1, "Level is setting up...");
            //refresh();
            wrefresh(conainerisloading);
            int err = system("/home/test/hacklab/scripts/start_level01.sh >> /home/dominic/container.log 2>&1");       //uses fork(2) to create a child process that executes the shell command

            break;
        }
        else if(choice == 10 && highlight == 1)
        {
            WINDOW * menu_schueler_level = newwin(6, xMAx - 12, yMAx - 8, 5);
            box(menu_schueler_level, 0, 0);
            wrefresh(menu_schueler_level);
            keypad(menu_schueler_level, true);
            for(int i = 0; i < 5; i++)                                              //go through the choices 
            {
                if(i == highlight)
                {
                   wattron(menu_schueler_level, A_REVERSE);
                }
                mvwprintw(menu_schueler_level, i + 1, 1, choices_schueler_level[i]);
                wattroff(menu_schueler_level, A_REVERSE);
            }
        }
    }

    printw("Your choice was: %s", choices_knowledge_level[highlight]);

    getch();
    endwin();

    return 0; 
}