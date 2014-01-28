scripts 
=======

My Configurations and scripts for various linux stuff.

xmonad.hs - simple ghetto xmonad config [wip]

uzbl - default uzbl config with a solidified color scheme, and a minimal bar format.

start.css/html - a crappy startpage I made for myself, with complete herp derp in mind. 
                 to use startpages like this, just set your browsers homepage to the location of the files.
                 example 'file:///path/to/crappy/startpage/start.html'

userChrome.css - a minimal[visually] firefox theme. Read the comments in the file for a better description.
                 
1.create a firefox profile by issuing the command 'firefox -p' in a terminal. 
2.follow the profile creation diologue. 
3.create the chrome directory  'mkdir ~/.mozilla/firefox/*profile name*/chrome'. 
4.place the userChrome.css file in ~/.mozilla/firefox/*profile name*/chrome/. 

it requires no visual plugins. I hope to make it usable for everyone, and the new firefox UI.

confiddy - contains two post installation scripts for arch-linux, filldir.sh configures a freshly installed arch system with my
 usual set of directories. then it gits/configures/installs xorg, dwm, and dmenu from arch repos/suckless.org.
read the file for more info.
