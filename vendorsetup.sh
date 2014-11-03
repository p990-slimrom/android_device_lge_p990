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

DIR=$(pwd)
echo -n "revert dpi changes"
cd $DIR/vendor/slim/; git fetch https://github.com/p990-slimrom/vendor_slim.git && git cherry-pick dec1c9af22385a73aba37835b4eed38f057e5d6e


#echo -n "apply JustArchi's ArchiDroid Optimizations V3"
#cd $DIR/build/; git fetch https://github.com/SlimKatXperia/android_build.git && git cherry-pick 6b734ccc7aa260b113e07bc84577e4414362f9e3

#echo -n "Apply gcc4.8 changes"
#cd $DIR/build/; git fetch https://github.com/p990-slimrom/android_build.git && git cherry-pick 99ef9408ab4b04b440cc9aeed9d37f849c7b9723

#removed for the moment
#echo -n "remove the selinux packages"
#cd $DIR/build/; git fetch https://github.com/p990-slimrom/android_build.git && git cherry-pick 0564f2b5031c60f146aaf7e500835dea4f4d4e92

echo -n "Prepare for gcc4.8"
cd $DIR/build/; git fetch https://github.com/p990-slimrom/android_build.git && git cherry-pick 290113bbcde13c112d22571b0c3cd418faa645c9
cd $DIR/build/; git fetch https://github.com/p990-slimrom/android_build.git && git cherry-pick a4a021597c0fa477520c93f5b4831619fdf860c9

#echo -n "Apply extFAT patch"
#cd $DIR/external/fuse/; git fetch https://github.com/JustArchi/android_external_fuse.git && git cherry-pick 78ebbc4404de260862dca5f0454bffccee650e0d

#echo -n "Apply patch to external/valgrind"
#cd $DIR/external/valgrind/; git fetch https://github.com/XperiaSTE/android_external_valgrind.git && git cherry-pick 679a4e571ef77f47892a785e852d8219c1e6807a

#echo -n "Apply blueZ changes to bionic"
#cd $DIR/bionic/; git fetch https://github.com/SlimKatXperia/android_bionic.git && git cherry-pick ce07db5aa9855e1910ea0436ff1d7fbd7ffd74ba

echo -n "remove SliomOTA"
cd $DIR/packages/apps/SlimCenter/; git fetch https://github.com/p990-slimrom/packages_apps_SlimCenter.git && git cherry-pick 1fdec6e946901d7d0a0f5e5f147fca6dc81ee9da
cd $DIR/packages/apps/SlimCenter/; git fetch https://github.com/p990-slimrom/packages_apps_SlimCenter.git && git cherry-pick 4109dd21a6c7386f017417f982722a123f024364

cd $DIR/


echo "Apply patch to frameworks/base"
echo -n "Apply patch 0001-framework-base-patch.patch"
(cd frameworks/base; git am ../../device/lge/p990/patches/0001-framework-base-patch.patch) > /dev/null 2>&1
if [ $? == 0 ]; then
       echo "     [DONE]"
else
       (cd frameworks/base; git am --abort)
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

echo "Apply patch to frameworks/av"
echo -n "Apply patch 0001-ifdef-for-ICS-Audio-Blob-compatibility.patch"
(cd frameworks/av; git am ../../device/lge/p990/patches/0001-ifdef-for-ICS-Audio-Blob-compatibility.patch) > /dev/null 2>&1
if [ $? == 0 ]; then
	echo "     [DONE]"
else
	(cd frameworks/av; git am --abort)
	echo "     [FAIL]"
fi

echo -n "Apply patch 0002-Add-missing-functions-and-signatures-for-older-OMX-v.patch"
(cd frameworks/av; git am ../../device/lge/p990/patches/0002-Add-missing-functions-and-signatures-for-older-OMX-v.patch) > /dev/null 2>&1
if [ $? == 0 ]; then
	echo "     [DONE]"
else
	(cd frameworks/av; git am --abort)
	echo "     [FAIL]"
fi

echo "Apply patch to external/chromium_org"
echo -n "Apply patch 0001-Work-around-broken-GL_TEXTURE_BINDING_EXTERNAL_OES-q.patch"
(cd external/chromium_org; git am ../../device/lge/p990/patches/0001-Work-around-broken-GL_TEXTURE_BINDING_EXTERNAL_OES-q.patch) > /dev/null 2>&1
if [ $? == 0 ]; then
	echo "     [DONE]"
else
	(cd external/chromium_org; git am --abort)
	echo "     [FAIL]"
fi
