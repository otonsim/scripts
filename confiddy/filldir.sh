#!/bin/bash

# a script to automatically configure future arch linux builds.

fillder() {
# creating a temporary fakehome to grease development and protect my actual $HOME
  fakeHOME=/home/m/scripts/confiddy ;

# creating directories only if inside the correct home dir
  if [ "$(pwd)" == "$fakeHOME" ]
  then
	  mkdir -p {bui,aud,vid,img,bui/scripts,bui/SEE,bui/bash,bui/.haskell,bui/proj};
  else
	  echo "you need to be in your home directory, --> '$HOME'";
  fi
}

getgit() {
  if [[ $(which git) == */git ]]
  then
	  echo "-----git exists!------";
  else
          pacman -S git;
  fi
}

getsuckless() {

	## Cloning {dwm,dmenu} from suckless repos. 
  if [[ $(pwd) == "$fakeHOME" ]]
  then
	  git clone http://git.suckless.org/dwm $fakeHOME/bui/proj/dwm;
	  git clone http://git.suckless.org/dmenu $fakeHOME/bui/proj/dmenu;
  else
	  echo "you REAALLLYY  need to be in your home directory, --> '$HOME'";
  fi

  
}

getX11() {
  pacman -S xorg-server xorg-server-utils xorg-xinit mesa xf86-video-nouveau

}


editmake() {
	dwmloc=$fakeHOME/bui/proj/dwm;
	dmenuloc=$fakeHOME/bui/proj/dmenu;

        sed -i -e 's|PREFIX = /usr/local|PREFIX = /usr|g'  -e 's|X11INC = /usr/X11R6/include|X11INC = /usr/include/X11|g' -e 's|X11LIB = /usr/X11R6/lib|X11LIB = /usr/lib/X11|g' {$dwmloc/config.mk,$dmenuloc/config.mk};
	make -C $dwmloc; 
	make -C $dmenuloc; 

        echo "exec dwm" > $fakeHOME/.xinitrc;	
} 



fillder
getgit
getsuckless
editmake
exit 0;
