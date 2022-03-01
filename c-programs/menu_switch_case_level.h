#include "ncurses.h"

int menu_switch_case_level(WINDOW * name_of_window, int highlight, int choice)
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
        switch(choice)
        {
            case KEY_LEFT:
                highlight--;
                if(highlight == 1)
                {
                    highlight = 6;
                }
                break;
            case KEY_RIGHT:
                highlight++;
                if(highlight == 7)
                {
                    highlight = 2;
                }
                break;
            case 'B':
            case 'b':
                highlight = 0;
                break;
            case 27:
                highlight = 1;
                break;
            default:
                break;
        }
        return highlight;
    }   
}