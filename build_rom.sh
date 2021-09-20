# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/StyxProject/manifest -b R -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/officialputuid/RMX2001-StyxProject --depth 1 -b MASTER .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom (vanilla)
source build/envsetup.sh
lunch styx_RMX2001-user
export TZ=Asia/Makassar #put before last build command
m styx-ota

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
