#!/bin/bash

# .---------------------------------.
# | PUNISHER TOOLKIT - TrabbitOne   |
# '---------------------------------'

# Clear the screen
clear

# Define color codes
declare -A color=(
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
    echo -e "${color[red]}"
    [[ -f ressources/banner.txt ]] && cat ressources/banner.txt
    echo -e "${color[reset]}"
    echo -e "                    [ ${color[yellow]}PUNISHER TOOLKIT${color[reset]} ]\n"
}

# Display the help menu
help_menu() {
    echo -e "${color[yellow]}Commands & Usage:${color[reset]}"
    echo -e "--------------------"
    echo -e " ${color[green]}help${color[reset]}      - Show this menu"
    echo -e " ${color[green]}ls${color[reset]}        - List files & directories"
    echo -e " ${color[green]}clear${color[reset]}     - Clear the screen"
    echo -e " ${color[green]}use [tool_name]${color[reset]} - Use a tool"
    echo -e " ${color[green]}exit${color[reset]}      - Exit the toolkit"
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
            echo -e "${color[cyan]}Using tool: ${tool}${color[reset]}"
            bash "$tool_dir/base.sh"
            read -p "Press [ENTER] to continue..."
            clear
            banner
        else
            echo -e "${color[red]}Error: base.sh not found in $tool_dir!${color[reset]}"
        fi
    else
        echo -e "${color[red]}Error: Tool '$tool' does not exist!${color[reset]}"
    fi
}

# MAIN FUNCTION

main() {
    banner
    while true; do
        time_stamp=$(date +"%Y-%m-%d %H:%M:%S")
        echo -e "[${color[green]}$time_stamp${color[reset]}]"
        read -rp ">>> " command

        case "$command" in
            ls) ls ;;
            help) help_menu ;;
            clear) clear; banner ;;
            use\ *)
                tool_name="${command#use }"
                use_tool "$tool_name"
                echo
                ;;
            exit)
                echo -e "${color[yellow]}Exiting...${color[reset]}"
                break
                ;;
            modules)
                echo
                ls -1 modules/ | sed 's/^/ -> /'
                echo
                ;;
            "")
                continue
                ;;
            *)
                echo -e "${color[red]}Invalid command! Type 'help' for usage.${color[reset]}"
                ;;
        esac
    done
}

# Run main function
main
