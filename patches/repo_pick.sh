#!/bin/bash

if [ -f ~/bin/paths-11.0.sh ]; then
	source ~/bin/paths-11.0.sh
fi

if [ "${android}" = "" ]; then
    # If there is no configuration file use the android build system vars
	android="${ANDROID_BUILD_TOP}"
fi

# This is hardcoded for the p990 device tree
if [ "${android}" = "" ]; then
    # device/lge/p990/patches
	android="../../../.."
fi

#Store the current path
path=$(pwd)

if [ "${path}" = "${android}" ]; then
    # Add all changes from review.cyanogenmod.com with the following syntax:
    #   cherries+=(<change>)
    # where <change> is the id of the patch

    # Workspace: Quad interpolator
    cherries+=(63036)

    # Now execute the script
    ${android}/build/tools/repopick.py -b ${cherries[@]}

else
    #C opy it so that it is in the android root dir
    echo "Copy repo_pick.sh to android root: ${android}"
    cp -a "repo_pick.sh" "${android}/repo_pick.sh"
    echo $(cd "${android}" && /bin/bash "./repo_pick.sh" && cd "${path}")
    
fi
