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
    initscr();
    noecho();
    cbreak();

    char *choices[3] = {
                    "Choice 1",
                    "Choice 2",
                    "Choice 3",
                              };
    int choice = 0;
    int highlight = 0;

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
        choice = wgetch(menuwin);
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