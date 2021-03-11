#!/usr/bin/env sh

if [[ -z "${XDG_CONFIG_HOME}" ]]; then
	CONFIG_HOME=$HOME/.config
else
    CONFIG_HOME=$XDG_CONFIG_HOME
fi

theme_file=$(awk '
/^@import "colorschemes/ {
    split($2, arr, "/");
    print substr(arr[2], 0, length(arr[2])-1);
}' $CONFIG_HOME/rofi/themes/shared/settings.rasi)

# 0 - accent
# 1 - background-focus
# 2 - foreground
colors=($(awk '
function print_hex_color(text) {
    print substr(text, 1, length(text)-1);
}
/^\s+accent:/ {
    print_hex_color($2);
}
/^\s+background-focus:/ {
    print_hex_color($2);
}
/^\s+foreground:/ {
    print_hex_color($2);
}' $CONFIG_HOME/rofi/themes/shared/colorschemes/$theme_file))

list=$(i3-msg -t get_config \
    | awk -v pre_mode="<span bgcolor='${colors[1]}' fgcolor='${colors[2]}' weight='heavy'> " \
          -v post_mode=" </span> " \
          -v pre_keybinding="<span fgcolor='${colors[0]}' weight='heavy'>" \
          -v post_keybinding="</span>" \
          -v separator=" " '
$1 == "#" {
    # Strip down the indent characters
    gsub(/^\s+/, "", $0);
    comment = substr($0, 3);
}
match($0, /^[^\s]+mode ".+"/) != 0 {
    mode = pre_mode toupper(substr($2, 2, length($2)-2)) post_mode;
}
match($0, /^}/) != 0 {
    mode = "";
}
$1 == "bindsym" {
    # Strip down the $ character from variables such as $Mod
    gsub(/\$/, "", $2)
    line = pre_keybinding $2 post_keybinding separator comment;
    # Replace $num in the comment by the number found in the keybinding
    if (index(comment, "$num")) {
        gsub(/\$num/, substr($2, match($2, /([[:digit:]]+)$/), length($2)), line);
    }
    print mode line;
}')

echo "$list" \
    | rofi -dmenu \
           -markup-rows \
           -i \
           -p "i3 Keybindings" \
           -theme themes/i3keybindingsmenu.rasi &> /dev/null
