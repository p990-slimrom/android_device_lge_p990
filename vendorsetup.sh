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

add_lunch_combo slim_p990-userdebug

echo ""
echo "Applying patches for P990"
echo ""

DIR=$(pwd)

mkdir -p out/target/product/p990/obj/KERNEL_OBJ/usr

echo -n "build: merge upstream"
cd $DIR/build/;
git remote add slim https://github.com/SlimRoms/android_build.git
git fetch slim
git pull slim lp5.1
git remote add p990 git@github.com:p990-slimrom/android_build.git
git fetch p990
#git commit -m "merge branch"
#git push p990 HEAD:lp5.1
echo -n ""

echo -n "bionic: merge upstream"
cd $DIR/bionic/;
git remote add slim https://github.com/SlimRoms/android_bionic.git
git fetch slim
git pull slim lp5.1
git remote add p990 git@github.com:p990-slimrom/android_bionic.git
git fetch p990
#git commit -m "merge branch"
#git push p990 HEAD:lp5.1
echo -n ""


echo -n "frameworks_av: merge upstream"
cd $DIR/frameworks/av/;
git remote add slim https://github.com/SlimRoms/frameworks_av.git
git fetch slim
git pull slim lp5.1
git remote add p990 git@github.com:p990-slimrom/frameworks_av.git
git fetch p990
#git commit -m "merge branch"
#git push p990 HEAD:lp5.1
echo -n ""

echo -n "frameworks_native: merge upstream"
cd $DIR/frameworks/native/;
git remote add slim https://github.com/SlimRoms/frameworks_native.git
git fetch slim
git pull slim lp5.1
git remote add p990 git@github.com:p990-slimrom/frameworks_native.git
git fetch p990
#git commit -m "merge branch"
#git push p990 HEAD:lp5.1
echo -n ""

echo -n "frameworks_wilhelm: merge upstream"
cd $DIR/frameworks/wilhelm/;
git remote add slim https://github.com/SlimRoms/frameworks_wilhelm.git
git fetch slim
git pull slim lp5.1
git remote add p990 git@github.com:p990-slimrom/frameworks_wilhelm.git
git fetch p990
#git commit -m "merge branch"
#git push p990 HEAD:lp5.1
echo -n ""

echo -n "hardware_libhardware: merge upstream"
cd $DIR/hardware/libhardware/;
git remote add slim https://github.com/SlimRoms/hardware_libhardware.git
git fetch slim
git pull slim lp5.1
git remote add p990 git@github.com:p990-slimrom/hardware_libhardware.git
git fetch p990
#git commit -m "merge branch"
#git push p990 HEAD:lp5.1
echo -n ""

echo -n "hardware_libhardware_legacy: merge upstream"
cd $DIR/hardware/libhardware_legacy/;
git remote add slim https://github.com/SlimRoms/hardware_libhardware_legacy.git
git fetch slim
git pull slim lp5.1
git remote add p990 git@github.com:p990-slimrom/hardware_libhardware_legacy.git
git fetch p990
#git commit -m "merge branch"
#git push p990 HEAD:lp5.1
echo -n ""

echo -n "external ffmpeg: merge upstream"
cd $DIR/external/ffmpeg/;
git remote add slim https://github.com/SlimRoms/android_external_ffmpeg
git fetch slim
git pull slim lp5.1
git remote add p990 git@github.com:p990-slimrom/android_external_ffmpeg.git
git fetch p990
#git commit -m "merge branch"
#git push p990 HEAD:lp5.1
echo -n ""


cd $DIR/
