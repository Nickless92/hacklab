function typeit() 
{
    local IFS=''
    while read -n1 c; do
        echo -n "$c"
        sleep .015$((RANDOM%3))
    done <<< "$@"
}

sleep 1s
typeit "It is Sunday. You are scrolling through social media as usual. "
sleep .$((RANDOM%3)) ; echo -e "\n"
typeit "Tweeble, as always, recommends tweebs to you. "
sleep .$((RANDOM%3)) ; echo -e "\n"
typeit "Most of them are not really interesting, but one catches your attention:"
sleep .$((RANDOM%3)) ; echo -e "\n\n"
read -p "Press any key to continue..." -n1 -s
sleep .$((RANDOM%3)) ; echo -e "\n"

sleep 3s
echo -e "dr. blackhat @blckht - march 13\n\ngreetings.\nyou may not know who i am but you will soon find out.\nexpect your current understanding of how the world works to turned on its head.\nexpect me.\n\n---\n()> 0   <-> 2  <3 10)"
sleep 2s
echo -e "\n"
typeit "Oh, just a troll, you think to yourself. Your gut feeling says otherwise. "
sleep .$((RANDOM%3)) ; echo -e "\n"
sleep 1s 
typeit "Instead of just dismissing this, you find yourself on their profile and read the other tweebs made by this account. "
sleep .$((RANDOM%3)) ; echo -e "\n"
typeit "Weird. "
echo -e "\n"
read -p "Press any key to continue..." -n1 -s
sleep .$((RANDOM%3)) ; echo -e "\n"

sleep .$((RANDOM%3)) ; echo -e "---\n"
typeit "@blckht: 66 years ago American scientists John Bardeen and Walter Houser Brattain observe the basic principles of the transistor, a key element for the electronics revolution of the 20th century. Fun fact!"
sleep .$((RANDOM%3)) ; echo -e "\n---\n"
typeit "@ladbible: it takes .666 seconds to check your drip HAHA lol"
sleep .$((RANDOM%3)) ; echo -e "\n---\n"
typeit "@tourism: check out this 66-minute escape room in neuwied!"
sleep .$((RANDOM%3)) ; echo -e "\n---\n"
typeit "@commonwhitegirl: 6 fingers would be more useful than 5 amirite"
sleep .$((RANDOM%3)) ; echo -e "\n---\n"

typeit "It seems like there is a message hidden in the numbers of each tweet... what does it say?"
sleep .$((RANDOM%3)) ; echo -e "\n"

typeit "Ah yes, that's right. Its 66.666.66.6. Seems like an IP adress. Let\'s visit that."
sleep .$((RANDOM%3)) ; echo -e "\n"
typeit "You try accessing the adress, but you can only see \"Access Denied\". You go to inspect the page, and you see in the source code that only certain IPs can access the site ... "
echo -e "\n"
read -p "Press any key to continue..." -n1 -s