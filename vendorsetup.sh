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

echo -n "Apply ggc4.8 changes"
cd $DIR/build/; git fetch https://github.com/p990-slimrom/android_build.git && git cherry-pick 4ccbe6c8a0ff44e9a78c510c9e7460258f8f35ea
cd $DIR/dalvik/; git fetch https://github.com/p990-slimrom/android_dalvik.git && git cherry-pick 39dcfa086cba4b381aba26f0417c9074a0b53d68
cd $DIR/frameworks/av/; git fetch https://github.com/p990-slimrom/frameworks_av.git && git cherry-pick a7fdaecf3523070643bb4eaacdc447b81f8c13fa
cd $DIR/frameworks/base/;  git fetch https://github.com/p990-slimrom/frameworks_base.git && git cherry-pick 29bb62af80040218495d04f1bedaa3d60397d48e
cd $DIR/bootable/recovery/; git fetch https://github.com/p990-slimrom/bootable_recovery.git && git cherry-pick 7927f8cbb00b2d708d318e5a2d7fb719691e1685
cd $DIR/external/chromium/; git fetch https://github.com/IAmTheOneTheyCallNeo/android_external_chromium tachyon-2.0 && git cherry-pick 6dae14a200d444fc7e834bc2369437d37851d376
cd $DIR/external/chromium/; git fetch https://github.com/p990-slimrom/platform_external_chromium.git && git cherry-pick fbdf3f1c685c036ee248c634a61e80605768b5cd
cd $DIR/external/oprofile/; git fetch https://github.com/IAmTheOneTheyCallNeo/android_external_oprofile tachyon-2.0 && git cherry-pick d2564470a30a2e643fb61714a5e8590a6e8cdc2b
cd $DIR/external/e2fsprogs/; git fetch https://github.com/IAmTheOneTheyCallNeo/android_external_e2fsprogs tachyon-2.0 && git cherry-pick 75088ae111d6c09fb1a5fdf2eccacbeb54d1b76c
cd $DIR/bionic/; git fetch https://github.com/IAmTheOneTheyCallNeo/android_bionic tachyon-2.0 && git cherry-pick f071fb6eef62cc4928d0521460599fab04b9969f
cd $DIR/external/stlport/; git fetch https://github.com/IAmTheOneTheyCallNeo/android_external_stlport tachyon-2.0 && git cherry-pick f164acdbbbdfef50bf0aa374607b56d243a18938
cd $DIR/external/clang/; git fetch https://github.com/IAmTheOneTheyCallNeo/android_external_clang tachyon-2.0 && git cherry-pick e41d99927139ba9afd3c76ebbaac9cd582396424
cd $DIR/external/dnsmasq/; git fetch https://github.com/IAmTheOneTheyCallNeo/android_external_dnsmasq tachyon-2.0 && git cherry-pick 50676d05317cc2b0cdbe6f24ddb991c53483fd57
cd $DIR/frameworks/compile/slang/; git fetch https://github.com/IAmTheOneTheyCallNeo/android_frameworks_compile_slang tachyon-2.0 && git cherry-pick 01cd0efe7e9da2e4b91ac76f3da0281f9245b30b
cd $DIR/external/iputils/; git fetch https://github.com/IAmTheOneTheyCallNeo/android_external_iputils tachyon-2.0 && git cherry-pick 87c334c3fb0fac0ee92be50c24563f612b70973d
cd $DIR/external/openssh/; git fetch https://github.com/IAmTheOneTheyCallNeo/android_external_openssh tachyon-2.0 && git cherry-pick 7a152c43552233bbf611c206c611e62a39b17656
cd $DIR/frameworks/rs/; git fetch https://github.com/IAmTheOneTheyCallNeo/android_frameworks_rs tachyon-2.0 && git cherry-pick c54f191fddec7089b8c8eb1b66d38a10f75c4eb5
cd $DIR/frameworks/native/; git fetch https://github.com/IAmTheOneTheyCallNeo/android_frameworks_native tachyon-2.0 && git cherry-pick 9570c494e5b18afd670542d90b8c85cb8e347aa4
cd $DIR/device/generic/goldfish/; git fetch https://github.com/IAmTheOneTheyCallNeo/android_device_generic_goldfish tachyon-2.0 && git cherry-pick fa6c45a973752922be36de28cfe526e7b8a3af03
cd $DIR/libcore/; git fetch https://github.com/IAmTheOneTheyCallNeo/android_libcore tachyon-2.0 && git cherry-pick c8e1d82487c016b3e13b1d3b7d1f3fef84784219
cd $DIR/frameworks/opt/net/voip/; git fetch https://github.com/IAmTheOneTheyCallNeo/android_frameworks_opt_net_voip tachyon-2.0 && git cherry-pick 9c2ce1fc56ad08ee0b3c8279d257b5c5ded7be32
cd $DIR/frameworks/wilhelm/; git fetch https://github.com/IAmTheOneTheyCallNeo/android_frameworks_wilhelm tachyon-2.0 && git cherry-pick ef9ec68e2011b9f4290c27f90082ddf218866625
#cd $DIR/hardware/qcom/gps/; git fetch https://github.com/IAmTheOneTheyCallNeo/android_hardware_qcom_gps tachyon-2.0 && git cherry-pick 4bf8441c46cddcdc9f604d1a012166e05530744c
#cd $DIR/external/lsof/; git fetch https://github.com/IAmTheOneTheyCallNeo/android_external_lsof tachyon-2.0 && git cherry-pick 44e30c310ed2f0c0ac4e8488fd37d51f91f933bf
cd $DIR/frameworks/ex/; git fetch https://github.com/IAmTheOneTheyCallNeo/android_frameworks_ex tachyon-2.0 && git cherry-pick a59bcbaa97ad8d62bd2e5d06d25f411c4aa06253
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

echo "Apply patch to external/skia"
echo -n "Apply patch 0001-external-skia-patch.patch"
(cd external/skia; git am ../../device/lge/p990/patches/0001-external-skia-patch.patch) > /dev/null 2>&1
if [ $? == 0 ]; then
	echo "     [DONE]"
else
	(cd external/skia; git am --abort)
	echo "     [FAIL]"
fi
echo "Apply patch to bionic"
echo -n "Apply patch 0003-Add-tegra2-to-bionic.patch"
(cd bionic; git am ../device/lge/p990/patches/0003-Add-tegra2-to-bionic.patch) > /dev/null 2>&1
if [ $? == 0 ]; then
	echo "     [DONE]"
else
	(cd bionic; git am --abort)
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

echo "Apply patch to hardware/libhardware"
echo -n "Apply patch 0001-Star-audio-patch.patch"
(cd hardware/libhardware; git am ../../device/lge/p990/patches/0001-Star-audio-patch.patch) > /dev/null 2>&1
if [ $? == 0 ]; then
	echo "     [DONE]"
else
	(cd hardware/libhardware; git am --abort)
	echo "     [FAIL]"
fi
