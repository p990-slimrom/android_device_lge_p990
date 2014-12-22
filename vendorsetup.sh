#
# Copyright 2012 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

add_lunch_combo cm_p990-userdebug
add_lunch_combo slim_p990-userdebug

echo ""
echo "Applying patches for P990"
echo ""

echo "Apply patches related to SlimRom"
echo -n "revert dpi changes"
cd vendor/slim/; git fetch https://github.com/p990-slimrom/vendor_slim.git && git cherry-pick dec1c9af22385a73aba37835b4eed38f057e5d6e > /dev/null 2>&1
if [ $? == 0 ]; then
       echo "     [DONE]"
else
       (cd vendor/slim/; git cherry-pick --abort)
       echo "     [FAIL]"
fi


echo -n "remove SliomOTA"
cd packages/apps/SlimCenter/; git fetch https://github.com/p990-slimrom/packages_apps_SlimCenter.git && git cherry-pick 1fdec6e946901d7d0a0f5e5f147fca6dc81ee9da > /dev/null 2>&1
if [ $? == 0 ]; then
       echo "     [DONE]"
else
       (cd packages/apps/SlimCenter/; git cherry-pick --abort)
       echo "     [FAIL]"
fi

cd packages/apps/SlimCenter/; git fetch https://github.com/p990-slimrom/packages_apps_SlimCenter.git && git cherry-pick 4109dd21a6c7386f017417f982722a123f024364 > /dev/null 2>&1
if [ $? == 0 ]; then
       echo "     [DONE]"
else
       (cd packages/apps/SlimCenter/; git cherry-pick --abort)
       echo "     [FAIL]"
fi


echo "Apply patch to build/core"
echo -n "0001-Don-t-use-Block-based-ota-if-defined-in-the-boardcon.patch"
(cd build/core; git am ../../device/lge/p990/patches/0001-Don-t-use-Block-based-ota-if-defined-in-the-boardcon.patch) > /dev/null 2>&1
if [ $? == 0 ]; then
       echo "     [DONE]"
else
       (cd build/core; git am --abort)
       echo "     [FAIL]"
fi

echo "Apply patch to frameworks/native"
echo -n "Apply patch 0002-DisplayDevice-Backwards-compatibility-with-old-EGL.patch"
(cd frameworks/native; git am ../../device/lge/p990/patches/0002-DisplayDevice-Backwards-compatibility-with-old-EGL.patch) > /dev/null 2>&1
if [ $? == 0 ]; then
       echo "     [DONE]"
else
       (cd frameworks/native; git am --abort)
       echo "     [FAIL]"
fi

echo "Apply patch to frameworks/native"
echo -n "Apply patch 0001-Fix-layer-dump-for-tegra2.patch"
(cd frameworks/native; git am ../../device/lge/p990/patches/0001-Fix-layer-dump-for-tegra2.patch) > /dev/null 2>&1
if [ $? == 0 ]; then
       echo "     [DONE]"
else
       (cd frameworks/native; git am --abort)
       echo "     [FAIL]"
fi

echo "Apply patch to external/ffmpeg"
echo -n "Apply patch 0001-FFMPEG-Backwards-compatibility-with-non-neon-devices.patch"
(cd external/ffmpeg; git am ../../device/lge/p990/patches/0001-FFMPEG-Backwards-compatibility-with-non-neon-devices.patch) > /dev/null 2>&1
if [ $? == 0 ]; then
	echo "     [DONE]"
else
	(cd external/ffmpeg; git am --abort)
	echo "     [FAIL]"
fi
