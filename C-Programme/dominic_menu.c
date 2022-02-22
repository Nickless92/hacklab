#include <stdio.h>
#include <ncurses.h>
#include <string.h>
#include <menu.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdlib.h>


<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 33-comment-existing-code
int main()
{
    initscr();                                                                  //initialize the screen
    noecho();                                                                   //suppresses to show the symbols you type in                                          
    cbreak();                                                                   //disables line buffering

    char *choices[3] = {                                                        //choices for the first part of the menu
<<<<<<< HEAD
=======

int main()
{
    initscr();
    noecho();
    cbreak();

    char *choices[3] = {
>>>>>>> Menu
=======
>>>>>>> 33-comment-existing-code
                    "Choice 1",
                    "Choice 2",
                    "Choice 3",
                              };
    int choice = 0;
    int highlight = 0;

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 33-comment-existing-code
    int yMAx, xMAx = 0;                                                         //variables for the size of the screen
    getmaxyx(stdscr, yMAx, xMAx);                                               //funktion to get the maximum size of the screen of your computer

    WINDOW * namewin = newwin(6, xMAx - 12, yMAx - 8, 5);                       //create a new window
    box(namewin, 0, 0);                                                         //describes how the window should look like 
    mvwprintw(namewin, 1, 1, "Please enter a name: ");                          //prints text in the box
    refresh();                                                                  //you have to refresh the screen that you can see the text
    wrefresh(namewin);                                                          //refreshes the window
    char c[] = '\0';                                                            //char array to save the name the user entered
    int position_of_first_letter = 21;                                          //we need this, because the name the user entered should be printed next to th string "Please enter a name: "
    while((c[position_of_first_letter - 21] = getch()) != '\n')                 //we don't want to create an additional counter so we take the position_of_first_letter and subtract 21 --> we get the first(++) position of the array
    {
        mvwprintw(namewin, 1, ++position_of_first_letter, "%c", c[position_of_first_letter - 21]);             //each letter will be printed in the box "namewin"
        wrefresh(namewin);                                                      //you need to refresh the window
    }
    
    WINDOW * menuwin = newwin(6, xMAx - 12, yMAx - 8, 5);                       //for every "level" of the menu you need to create a new window
    box(menuwin, 0, 0);
    refresh();
    wrefresh(menuwin);
    keypad(menuwin, true);                                                      //the keypad option enables the keypad of the user's terminal

    while(1)                                                                    //loop taht the user can choose an option 
<<<<<<< HEAD
=======
    int yMAx, xMAx = 0;
    getmaxyx(stdscr, yMAx, xMAx);

    WINDOW * namewin = newwin(6, xMAx - 12, yMAx - 8, 5);
    box(namewin, 0, 0);
    mvwprintw(namewin, 1, 1, "Please enter a name: ");
    refresh();
    wrefresh(namewin);
    char c = '\0';
    int counter = 21;
    while((c = getch()) != '\n')
    {
        mvwprintw(namewin, 1, ++counter, "%c", c);
        wrefresh(namewin);
    }
    
    WINDOW * menuwin = newwin(6, xMAx - 12, yMAx - 8, 5);
    box(menuwin, 0, 0);
    refresh();
    wrefresh(menuwin);
    keypad(menuwin, true);

    while(1)
>>>>>>> Menu
=======
>>>>>>> 33-comment-existing-code
    {
        for(int i = 0; i < 3; i++)
        {
            if(i == highlight)
            {
                wattron(menuwin, A_REVERSE);
            }
            mvwprintw(menuwin, i + 1, 1, choices[i]);
            wattroff(menuwin, A_REVERSE);
        }
<<<<<<< HEAD
<<<<<<< HEAD
        choice = wgetch(menuwin);                                               //returns a single value representing the function key
=======
        choice = wgetch(menuwin);
>>>>>>> Menu
=======
        choice = wgetch(menuwin);                                               //returns a single value representing the function key
>>>>>>> 33-comment-existing-code
        switch (choice)
        {
        case KEY_UP:
            highlight--;
            if(highlight == -1)
            {
                highlight = 0;
            }
            break;
        case KEY_DOWN:
            highlight++;
            if(highlight == 3)
            {
                highlight = 2;
            }
        default:
            break;
        }

        if (choice == 10 && highlight == 0)
        {
            WINDOW * conainerisloading = newwin(6, xMAx - 12, yMAx - 8, 5);
            box(conainerisloading, 0, 0);
            mvwprintw(conainerisloading, 1, 1, "Level is setting up...");
            refresh();
            wrefresh(conainerisloading);
            int err = system("/home/test/hacklab/scripts/start_level01.sh >> /home/test/container.log 2>&1");

            break;
        }
    }

    printw("Your choice was: %s", choices[highlight]);

    getch();
    endwin();

    return 0; 
}