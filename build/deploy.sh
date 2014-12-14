#!/bin/sh
cd `dirname $0`/../src

OLD=`cat ./addon.xml | grep '<addon' | grep 'version="' | grep -E -o 'version="[0-9\.]+"' |  grep -E -o '[0-9\.]+'`
echo "Old version: $OLD"
echo -n 'New version: '
read NEW

sed -e "s/version=\"$OLD\"/version=\"$NEW\"/g" ./addon.xml > ./addon2.xml
mv ./addon2.xml ./addon.xml


sed -e "s/script.module.xbmcup\" version=\"[^\"]*\"/script\.module\.xbmcup\" version=\"$NEW\"/g" ../../plugin.video.visionette/src/addon.xml > ../../plugin.video.visionette/src/addon2.xml
mv ../../plugin.video.visionette/src/addon2.xml ../../plugin.video.visionette/src/addon.xml


sed -e "s/script.module.xbmcup\" version=\"[^\"]*\"/script\.module\.xbmcup\" version=\"$NEW\"/g" ../../plugin.audio.lastvk/src/addon.xml > ../../plugin.audio.lastvk/src/addon2.xml
mv ../../plugin.audio.lastvk/src/addon2.xml ../../plugin.audio.lastvk/src/addon.xml


rm -rf ../script.module.xbmcup
rm -f ./script.module.xbmcup.zip
mkdir ../script.module.xbmcup
cp -r ./* ../script.module.xbmcup/

cd ../
zip -rq ./script.module.xbmcup.zip ./script.module.xbmcup

cp ./script.module.xbmcup.zip ../repository.hal9000/repo/script.module.xbmcup/script.module.xbmcup-$NEW.zip

rm -rf ./script.module.xbmcup
rm -f ./script.module.xbmcup.zip

`../repository.hal9000/build/build.sh`
