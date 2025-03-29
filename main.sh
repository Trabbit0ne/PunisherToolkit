#!/bin/bash

# -----------------------------------
# | PUNISHER TOOLKIT - RAPS SOCIETY |
# -----------------------------------

# Clear the screen
clear

# Define color codes
declare -A colors=(
    [red]="\e[38;5;196m"
    [green]="\e[32m"
    [yellow]="\e[1;33m"
    [blue]="\e[34m"
    [purple]="\e[1;35m"
    [cyan]="\e[36m"
    [bgred]="\e[41m"
    [bggreen]="\e[42m"
    [bgyellow]="\e[43m"
    [bgblue]="\e[44m"
    [bgpurple]="\e[45m"
    [bgcyan]="\e[46m"
    [reset]="\e[0m"
)

# FUNCTIONS

# Display the banner
banner() {
    echo -e "${colors[red]}"
    [[ -f ressources/banner.txt ]] && cat ressources/banner.txt
    echo -e "${colors[reset]}"
    echo -e "                    [ ${colors[yellow]}PUNISHER TOOLKIT${colors[reset]} ]\n"
}

# Display the help menu
help_menu() {
    echo -e "${colors[yellow]}Commands & Usage:${colors[reset]}"
    echo -e "--------------------"
    echo -e " ${colors[green]}help${colors[reset]}      - Show this menu"
    echo -e " ${colors[green]}ls${colors[reset]}        - List files & directories"
    echo -e " ${colors[green]}clear${colors[reset]}     - Clear the screen"
    echo -e " ${colors[green]}use [tool_name]${colors[reset]} - Use a tool"
    echo -e " ${colors[green]}exit${colors[reset]}      - Exit the toolkit"
    echo -e "--------------------"
}

# Generic function to execute tools
use_tool() {
    local tool="$1"
    local tool_dir="modules/$tool"

    if [[ -d "$tool_dir" ]]; then
        if [[ -f "$tool_dir/base.sh" ]]; then
            clear
            banner
            echo -e "${colors[cyan]}Using tool: ${tool}${colors[reset]}"
            bash "$tool_dir/base.sh"
            read -p "Press [ENTER] to continue..."
            clear
            banner
        else
            echo -e "${colors[red]}Error: base.sh not found in $tool_dir!${colors[reset]}"
        fi
    else
        echo -e "${colors[red]}Error: Tool '$tool' does not exist!${colors[reset]}"
    fi
}

# MAIN FUNCTION

main() {
    banner
    while true; do
        time_stamp=$(date +"%Y-%m-%d %H:%M:%S")
        echo -e "[${colors[green]}$time_stamp${colors[reset]}]"
        read -rp ">>> " command

        case "$command" in
            ls) ls ;;
            help) help_menu ;;
            clear) clear; banner ;;
            use\ *) 
                tool_name="${command#use }"
                use_tool "$tool_name"
                ;;
            exit)
                echo -e "${colors[yellow]}Exiting...${colors[reset]}"
                break
                ;;
            "")
                continue
                ;;
            *)
                echo -e "${colors[red]}Invalid command! Type 'help' for usage.${colors[reset]}"
                ;;
        esac
    done
}

# Run main function
main
