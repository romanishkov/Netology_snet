read folder
if [[ ! -d $folder ]]; then
	mkdir $folder
else
	echo 'This directory already exists!'
fi;
