function typeit() 
{
    local IFS=''
    while read -n1 c; do
        echo -n "$c"
        sleep .015$((RANDOM%3))
    done <<< "$@"
}

sleep 1s
fun()                                                 #to print data from story.txt file
{
 for(( i=$1; i<=$2; i++))                             #first argument for loop start second for loop end and third for selection of new lines
  do
     var=$(awk 'NR=='$i'{ print}' story.txt)          #save i line in variable var
     typeit $var                                      #through typit function type every char of var slowly

       if [ $3 == 0 ]; then
	  sleep .$((RANDOM%3)) ; echo -e "---\n"     
       elif [ $3 == 1 ];then
          sleep .$((RANDOM%3)) ; echo -e "\n---\n"
       elif [ $3 == 2 ]; then
          sleep .$((RANDOM%3)) ; echo -e "\n"
       fi
  done
}

read_sleep()
{
read -p "Press any key to continue..." -n1 -s
sleep .$((RANDOM%3)) ; echo -e "\n"
}


fun 1 3 2                                            #type 1-3 line with --- and new line at the end
read_sleep                                           #call read asleep function

sleep 2s
echo -e "dr. blackhat @blckht - march 13\n\ngreetings.\nyou may not know who i am but you will soon find out.\nexpect your current understanding of how the world works to turned on its head.\nexpect me.\n\n---\n()> 0   <-> 2  <3 10)"

sleep 2s
fun 4 4 2                                           #type 4 line with --- and new line at the end

sleep 1s 
fun 5 6 2                                           #type 5-6 line with with --- and new line at the end
read_sleep

sleep .$((RANDOM%3)) ; echo -e "---\n"
fun 7 10 1                                         #type 7-10 with new line then --- and again new line 

fun 11 13 2
read -p "Press any key to continue..." -n1 -s
