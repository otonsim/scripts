#!/bin/bash

fakeHOME=/home/m/scripts/confiddy ;

if [ $(pwd) = $fakeHOME ]
then 
	rm -r {bui,aud,vid,img,.xinitrc};
else 
	echo "calm down, you almost just buggered the whole thing!"
fi

exit 0;
