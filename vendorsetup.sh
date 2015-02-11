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

#echo -n "apply JustArchi's ArchiDroid Optimizations V3"
#cd $DIR/build/; git fetch https://github.com/SlimKatXperia/android_build.git && git cherry-pick 6b734ccc7aa260b113e07bc84577e4414362f9e3

#echo -n "Apply gcc4.8 changes"
#cd $DIR/build/; git fetch https://github.com/p990-slimrom/android_build.git && git cherry-pick 99ef9408ab4b04b440cc9aeed9d37f849c7b9723

#removed for the moment
#echo -n "remove the selinux packages"
#cd $DIR/build/; git fetch https://github.com/p990-slimrom/android_build.git && git cherry-pick 0564f2b5031c60f146aaf7e500835dea4f4d4e92

echo -n "build: merge upstream"
cd $DIR/build/;
git remote add slim https://github.com/SlimRoms/android_build.git
git fetch slim
git pull slim kk4.4
git remote add p990 git@github.com:p990-slimrom/android_build.git
git fetch p990
#git commit -m "merge branch"
#git push p990 HEAD:kk4.4
echo -n ""

echo -n "SlimVendor: merge upstream"
cd $DIR/vendor/slim/;
# git fetch https://github.com/p990-slimrom/vendor_slim.git && git cherry-pick dec1c9af22385a73aba37835b4eed38f057e5d6e
git remote add slim https://github.com/SlimRoms/vendor_slim.git
git fetch slim
git pull slim kk4.4
git remote add p990 git@github.com:p990-slimrom/vendor_slim.git
git fetch p990
#git commit -m "merge branch"
#git push p990 HEAD:kk4.4
echo -n ""

echo -n "Settings: merge upstream"
cd $DIR/packages/apps/Settings/;
git remote add slim https://github.com/SlimRoms/packages_apps_Settings.git
git fetch slim
git pull slim kk4.4
git remote add p990 git@github.com:p990-slimrom/packages_apps_Settings.git
git fetch p990
#git commit -m "merge branch"
#git push p990 HEAD:kk4.4
echo -n ""

echo -n "SlimCenter: merge upstream"
cd $DIR/packages/apps/SlimCenter/;
git remote add slim https://github.com/SlimRoms/packages_apps_SlimCenter.git
git fetch slim
git pull slim kk4.4
git remote add p990 git@github.com:p990-slimrom/packages_apps_SlimCenter.git
git fetch p990
#git commit -m "merge branch"
#git push p990 HEAD:kk4.4
echo -n ""

echo -n "frameworks_base: merge upstream"
cd $DIR/frameworks/base;
git remote add slim https://github.com/SlimRoms/frameworks_base.git
git fetch slim
git pull slim kk4.4
git remote add p990 git@github.com:p990-slimrom/frameworks_base.git
git fetch p990
#git commit -m "merge branch"
#git push p990 HEAD:kk4.4
echo -n ""

echo -n "frameworks_native: merge upstream"
cd $DIR/frameworks/native;
git remote add slim https://github.com/SlimRoms/frameworks_native.git
git fetch slim
git pull slim kk4.4
git remote add p990 git@github.com:p990-slimrom/frameworks_native.git
git fetch p990
#git commit -m "merge branch"
#git push p990 HEAD:kk4.4
echo -n ""

echo -n "frameworks_av: merge upstream"
cd $DIR/frameworks/av;
git remote add slim https://github.com/SlimRoms/frameworks_av.git
git fetch slim
git pull slim kk4.4
git remote add p990 git@github.com:p990-slimrom/frameworks_av.git
git fetch p990
#git commit -m "merge branch"
#git push p990 HEAD:kk4.4
echo -n ""

cd $DIR/
