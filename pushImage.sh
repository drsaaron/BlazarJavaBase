#! /bin/sh

while getopts :v: OPTION
do
    case $OPTION in
	v)
	    version=$OPTARG
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

docker push $imageName:$version
