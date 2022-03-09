// SPDX-FileCopyrightText: 2022 Bassam-Khaled Thiab <inf3891@hs-worms.de>
// SPDX-FileCopyrightText: 2022 Dominic Meyer <inf3644@hs-worms.de>
// SPDX-FileCopyrightText: 2022 Felix Rheinheimer <felix.rheinheimer@hs-worms.de>
// SPDX-FileCopyrightText: 2022 Jean-Arole Fotsing <inf3608@hs-worms.de>
// SPDX-FileCopyrightText: 2022 Katrin Vollhardt <inf3493@hs-worms.de>
// SPDX-FileCopyrightText: 2022 Steve Landry Tchamabe <infXXXX@hs-worms.de>
// SPDX-FileCopyrightText: 2022 Syed Saad-Ullah <inf3664@hs-worms.de>
// SPDX-FileCopyrightText: 2022 Thierry-Junior Djeutchou-Njieyong <inf3494@hs-worms.de>
//
// SPDX-License-Identifier: GPL-3.0-or-later

#include <stdio.h>
#include <ncurses.h>
#include <string.h>
#include <menu.h>
#include <stdlib.h>           // added for exit() function
#include <unistd.h> 

void fail(char *msg) {
    endwin();
    puts(msg);
    exit(EXIT_FAILURE);
}

int main(int argc, char **argv)
{
	    char name[20];
		char str2[]="Option 2: Student";
		int container;
	    printf("Willkommen in Hacklab\n");
        printf("Bitte geben Sie Ihre Benutzername ein\n");
        scanf("%s", name);
		printf("Danke %s fuer Ihre Name eintippen\n",name);
		//printf("Bitte wahlen Sie jetzt zu welchem Katogorie Sie gehören?");
        
    /* Commandline argument currently unused */
    (void) argc;
    (void) argv;

    int i, c;
    (void) c;                       // c is currently unused
    char project[]="HackLab";
    int szer, dlug; //the value of the length and width of the terminal

    initscr();
    raw();
    noecho();
    keypad(stdscr, TRUE);

    /* Test to see if terminal has colors */
    if (has_colors() == false) {
        fail("Colors unavailable\n");
    }

    if (start_color() != OK) {
        fail("Unable to start colors\n");
    }

    //init_pair(1, COLOR_BLUE, COLOR_BLACK); //wybór kolorów

    getmaxyx(stdscr, szer, dlug); //getting terminal sizes
    move(szer/2, (dlug-strlen(project))/2); //in the middle
    printw(project); 
	printw("\n\t\t\tBitte wahlen Sie jetzt zu welchem Katogorie Sie gehören?");
    refresh();//We refresh (otherwise it will not be displayed)
    WINDOW * menuwin=newwin(7, dlug-12, szer-9, 6); //We define and create a 'window'
    box(menuwin, 0, 0);
    refresh();//refresh again to make the window reappear
    wrefresh(menuwin);//we refresh the window itself
    keypad(menuwin, TRUE);//we enable the keyboard operation in the window
    
    char *list[] = {
        "Option 1: Schueler",
        "Option 2: Student",
        "Option 3: Expert",
        "Exit",
    };
    int wybor;
    int zaznacz=0;
    while(1)//this whole loop is used to create a menu with the highlight of the selected item continuously
    {
        for(i = 0; i < 4; i++) {
            if(i == zaznacz)
                wattron(menuwin, A_REVERSE);
            mvwprintw(menuwin, i+1, 1, list[i]);
            if (i == zaznacz)
                wattroff(menuwin, A_REVERSE);
        }
        wybor = wgetch(menuwin);
        switch(wybor)
        {
        case KEY_UP:
            zaznacz--;
            if(zaznacz < 0) zaznacz = 0;//protection against going "outside" the menu
            break;
        case KEY_DOWN:
            zaznacz++;
            if(zaznacz > 3) zaznacz = 3;
            break;
        default:
            break;
        }

        if(wybor==10) break;
    }
     
    
    printw("\n        gewaehlte %s", list[zaznacz]);
	
   
    /* Wait for user to press enter to exit */
    if(wybor==10 && zaznacz==0){
			const char path_to_start_level01[] = "/home/test/hacklab/scripts/start_level01.sh";
            printf(" Die Container werden geladen...\n");
            //execl(path_to_start_level01, path_to_start_level01, "&", NULL);
			container=system("/home/test/hacklab/scripts/start_level01.sh >> /home/test/container.log 2>&1");
			 
		}
	
    if(wybor==10&&zaznacz==1){
       getmaxyx(stdscr, szer, dlug); //getting terminal sizes
    move(szer/2, (dlug-strlen(project))/2); //in the middle
    printw("\n\n\t\t\tWelche Module moechten Sie üben?"); 
    refresh();//We refresh (otherwise it will not be displayed)
    WINDOW * menuwin=newwin(7, dlug-12, szer-9, 6); //We define and create a 'window'
    box(menuwin, 0, 0);
    refresh();//refresh again to make the window reappear
    wrefresh(menuwin);//we refresh the window itself
    keypad(menuwin, TRUE);//we enable the keyboard operation in the window
    
    char *list[] = {
        "Option 1: Netzwerk",
        "Option 2: Netzwerk Security",
        "Option 3: Kryptography",
        "Exit",
    };
    int wybor;
    int zaznacz=0;
    while(1)//this whole loop is used to create a menu with the highlight of the selected item continuously
    {
        for(i = 0; i < 4; i++) {
            if(i == zaznacz)
                wattron(menuwin, A_REVERSE);
            mvwprintw(menuwin, i+1, 1, list[i]);
            if (i == zaznacz)
                wattroff(menuwin, A_REVERSE);
        }
        wybor = wgetch(menuwin);
        switch(wybor)
        {
        case KEY_UP:
            zaznacz--;
            if(zaznacz < 0) zaznacz = 0;//protection against going "outside" the menu
            break;
        case KEY_DOWN:
            zaznacz++;
            if(zaznacz > 3) zaznacz = 3;
            break;
        default:
            break;
        }

        if(wybor==10) break;
    }
     
    
    printw("\n        gewaehlte %s", list[zaznacz]);
	
    refresh();
    
   
	
		 /* Wait for user to press enter to exit */
    getch();
	

    /* Need to cleanup before exit */


    /* Need to cleanup before exit */
    endwin();
	}












		
    

    return 0;
}