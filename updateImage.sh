#! /bin/sh

while getopts :f OPTION
do
    case $OPTION in
	f)
	    force=1
	    ;;
	*)
	    echo "unknown option $OPTARG" 1>&2
	    exit 1
    esac
done

imageName=$(dockerImageName.sh)

if pullLatestDocker.sh || [ -n "$force" ]
then
    currentVersion=$(docker images $imageName | sed 1d | awk '$2 !~ /latest/ { print $2 }' | perl -pe 's/\.(\d)$/.0$1/' | sort -r | head -1)
    nextVersion=$(echo $currentVersion |awk -F\. '{printf "%s.%s", $1, $2+1}')
    echo "docker base updated, so refreshing uses to version $nextVersion (from $currentVersion)"
    buildImage.sh -v $nextVersion
    pushImage.sh -v $nextVersion
    updateUses.sh -v $nextVersion
fi
