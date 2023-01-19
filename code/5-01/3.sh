read filename
case $filename in
	(*.jpg | *.gif | *.png)
		echo "$filename is image"
	;;
        (*.mp3 | *.wav)
                echo "$filename is audio"
        ;;
        (*.txt | *.doc)
                echo "$filename is text"
        ;;
        (*)
                echo "$filename is unknown"
        ;;

esac
