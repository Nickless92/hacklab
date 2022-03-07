function typeit() 
{
    local IFS=''
    while read -n1 c; do
        echo -n "$c"
        sleep .015$((RANDOM%3))
    done <<< "$@"
}

echo -e "\n"
typeit "to enter, one needs to make it look like they are accessing the website from the ip listed in the web page."
sleep .$((RANDOM%3)) ; echo -e "\n"
typeit "to do this, one can use something that is called an ip-spoofing attack. one fakes their own sending ip address, just like writing a different sender on a packet."
sleep .$((RANDOM%3)) ; echo -e "\n"
typeit "some tools used for ip spoofing and to monitor a network are hping and tshark."
sleep .$((RANDOM%3)) ; echo -e "\n"
typeit "to find more about both, use the command man in front of the tool you would like to know more about."
sleep .$((RANDOM%3)) ; echo -e "\n"
typeit "just like this: man ping ."
echo -e "\n"