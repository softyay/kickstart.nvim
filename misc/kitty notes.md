
# Kitty Terminal Prompt Color

<!-- -->
## Issue

- Prompt shows up without color in Kitty

<!-- -->
## OS

- Linux Ubuntu 24.04


<!-- -->
## Solution

- Worked: yes
- From StackOverflow
  - Accessed on 06/14/25
  - https://unix.stackexchange.com/questions/706179/kitty-terminal-i-dont-have-any-colors-on-ps1-bash-prompt
- Solved by:
  - User: John Mee
  - Date: Feb 12, 2023 at 21:56
  - Body:
    > Kitty may not be recognised as a color terminal... What is the $TERM environment variable set to?
    > 
    > In gnome-terminal it says:
    > 
    > ```
    > $ echo $TERM
    > xterm-256color
    > ```
    > In kitty it says:
    > 
    > ```
    > $ echo $TERM
    > xterm-kitty
    > ```
    > Check your `.bashrc` for this line:
    > 
    > `xterm-color|*-256color) color_prompt=yes;;`
    > Add xterm-kitty to it, like this:
    > 
    > `xterm-color|*-256color|xterm-kitty) color_prompt=yes;;`
    > Now restart kitty.

