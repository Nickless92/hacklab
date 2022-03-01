#ifndef MENU_H_INCLUDED
#define MENU_H_INCLUDED

void enterName();                                                               //function declerations of the functions we use below
void pupil_levels();
void choose_modules();
void expert_levels();
int menu_switch_case(WINDOW * name_of_window, int highlight, int choice);

void choose_knowledge()
{  
    char *choices_knowledge_level[5] =                                          //choices for the knowledge level
    {                   
        "Back [B]",
        "Exit [ESC]",                                     
        "Pupil    -  for people who have not attended any modules at HS-Worms",
        "Student  -  in the next step you can choose between different modules",
        "Expert   -  you can choose between all levels of pupil and student",
    };
    
    int choice = 0;                                                             //variable for the character
    int highlight = 0;                                                          //shows which choice is highlighted
    int yMAx, xMAx = 0;                                                         //variables for the size of the screen
    getmaxyx(stdscr, yMAx, xMAx);                                               //function to get the maximum size of the screen of your computer
    
    WINDOW * menuwin = newwin(6, xMAx - 12, yMAx - 8, 5);                       //for every "level" of the menu you need to create a new window
    box(menuwin, 0, 0);
    
    wrefresh(menuwin);
    keypad(menuwin, true);                                                      //the keypad option enables the keypad of the user's terminal
    mvwprintw(menuwin, 1, 1, "Please choose your knowledge: ");
    highlight = 2;
    while(choice != 10)                                                         //loop that the user can choose an option of his knowledge
    {
        for(int i = 0; i < 5; i++)                                              //prints all choices of "choices_knowledge_level"
        {
            if(i == highlight)
            {
                wattron(menuwin, A_REVERSE);                                    //A_REVERSE marks one choice --> wattron (window attribute on)
            }
            if(i == 0)                                                          //we want to print the back button at the right bottom
            {
                mvwprintw(menuwin, 4, xMAx - 35, choices_knowledge_level[i]);
            }
            else if(i == 1)                                                     //we want to print the exit button at the right bottom
            {
                mvwprintw(menuwin, 4, xMAx - 23, choices_knowledge_level[i]);
            }
            else
            {
                mvwprintw(menuwin, i, 1, choices_knowledge_level[i]);           //the other choices are printed
            }
            wattroff(menuwin, A_REVERSE);                                       //window attribute off --> the other possibilities are not marked
        }
        choice = wgetch(menuwin);                                               //we get the character the user puts in

        highlight = menu_switch_case(menuwin, highlight, choice);
    }

    if(choice == 10 && highlight == 0)                                          //back button in knowledge | choice 10 = ENTER
    {
    	enterName();
        return;
    }
    else if(choice == 10 && highlight == 1)                                     //exit button in knowledge --> when the exit button was choosen we exit the programm
    {
        endwin();
        exit(0);
    }
    else if(choice == 10 && highlight == 2)                                     //pupil button 
    {
        pupil_levels();
        return;
    }
    else if(choice == 10 && highlight == 3)                                     //student button
    {
        choose_modules();
        return;
    }
    else if(choice == 10 && highlight == 4)                                     //expert button
    {
        expert_levels();
        return;
    }
    return;
}

#endif