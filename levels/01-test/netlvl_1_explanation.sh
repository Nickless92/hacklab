function typeit() 
{
    local IFS=''
    while read -n1 c; do
        echo -n "$c"
        sleep .015$((RANDOM%3))
    done <<< "$@"
}

read_level1_explanation()                             #to print data from story.txt file
{
 echo -e "\n"
 for(( i=$1; i<=$2; i++))                             #first argument for loop start second for loop end and third for selection of new lines
  do
     var=$(awk 'NR=='$i'{ print}' Level1_story.txt)   #save i line in variable var
     typeit $var
     sleep .$((RANDOM%3)) ; echo -e "\n"
 echo -e "\n"
done
}

read_level1_explanation 15 19
