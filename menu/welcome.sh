function typeit() 
{
    local IFS=''
    while read -n1 c; do
        echo -n "$c"
        sleep .015$((RANDOM%3))
    done <<< "$@"
}

echo ../ressources/ascii/Welcome.txt