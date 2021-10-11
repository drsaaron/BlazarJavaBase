# BlazarJavaBase

this project will provide support to build a base docker image for all my java applications.

* `buildImage.sh` builds an image with a user-supplied version which is assumed to be of the form <major release>.<minor release>
* `pushImage.sh` pushes the image, again with the user-supplied version number
* `updateUses.sh` updates the Docker file in all the repos that use this image as a base
* `updateImage.sh` pulls the latest parent image, and if it is changed build a new image, pushses it, and updates the uses
