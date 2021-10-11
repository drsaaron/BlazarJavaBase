#! /bin/sh

while getopts :v: OPTION
do
    case $OPTION in
	v)
	    version=$OPTARG
	    ;;
	*)
	    echo "unknown option $OPTARG" 1>&2
	    exit 1
    esac
done

if [ -z "$version" ]
then
    echo "missing version" 1>&2
    exit 1
fi

imageName=$(grep imageName buildImage.sh | awk -F = '{ print $2 }')

grep -Fi $imageName ../*/Dockerfile |
    while read file
    do
	echo "updating $file"
	perl -i -pe "s%$imageName:[\d\.]+%$imageName:$version%" $file
    done
