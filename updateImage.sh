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
    currentVersion=$(docker images --format json $imageName | jq '.Tag' | grep -v latest | sort -r | sed 's/"//g' | head 1)
    nextVersion=$(echo $currentVersion |awk -F\. '{printf "%s.%s", $1, $2+1}')
    echo "docker base updated, so refreshing uses to version $nextVersion (from $currentVersion)"
    buildImage.sh -v $nextVersion
    pushImage.sh -v $nextVersion
    updateUses.sh -v $nextVersion
fi
