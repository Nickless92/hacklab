#include <sys/types.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

//const char path_to_start_level01[] = "/home/test/hacklab/scripts/start_level01.sh";


int main()
{
    //1.     open the welcome menu --> in menu.c
    //2.     enter the username
    //3.     choose if you are a pupil, student or an expert 
    //3a.    choose a level you want to play
    if (auswahl == pupil)
    {
        int pupil_level = fork();
        if (pupil_level == -1)
        {
            return -1;
        }

        if (pupil_level == 0)               //child process
        {
            //Shell Script is running which creates a number of container
            //execl(path_to_start_level01, path_to_start_level01, NULL, NULL);
        }
        else                        //parent process
        {
            wait(NULL);
        }
    }
    else if (auswahl == student)
    {
        int student_level = fork();
        if (student_level == -1)
        {
            return -1;
        }

        if (student_level == 0)               //child process
        {
            //Shell Script is running which creates a number of container
            //execl(path_to_start_level01, path_to_start_level01, NULL, NULL);
        }
        else                        //parent process
        {
            wait(NULL);
        }        
    }
    else if (auswahl == expert)
    {
        int expert_level = fork();
        if (expert_level == -1)
        {
            return -1;
        }

        if (expert_level == 0)               //child process
        {
            //Shell Script is running which creates a number of container
            //execl(path_to_start_level01, path_to_start_level01, NULL, NULL);
        }
        else                        //parent process
        {
            wait(NULL);
        }        
    }
    return 0;
}