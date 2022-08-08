#! /bin/sh 

imageName=drsaaron/blazarjavabase

while getopts :fv: OPTION
do
    case $OPTION in
	f)
	    force=TRUE
	    ;;
	v)
	    version=$OPTARG
	    ;;
	*)
	    echo "invalid option $OPTARG" 1>&2
	    exit 1
    esac
done

# build the image
buildDocker.sh $@ -n $imageName -u $(id -u) -U $(whoami) -g $(id -g) -G blazar

# purge old
purgeOldImages.sh -i $imageName
