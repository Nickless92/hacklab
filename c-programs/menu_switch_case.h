#include "ncurses.h"

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