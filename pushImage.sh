#! /bin/sh

while getopts :pv: OPTION
do
    case $OPTION in
	v)
	    version=$OPTARG
	    ;;
	p)
	    doPush=1
	    ;;
	*)
	    echo "invalid option $OPTARG" 1>&2
	    exit 1
    esac
done

if [ -z "$version" ]
then
    echo "missing version" 1>&2
    exit 1
fi

imageName=$(dockerImageName.sh)

if [ -n "$doPush" ]
then
    echo "pushing image to docker hub"
    docker push $imageName:$version
else
    echo "skipping push as not explicitly requested."
fi
