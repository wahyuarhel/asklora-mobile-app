#!bin/bash
FILE=config.properties

udid=$(adb devices | tail -n 2 | awk '{ print $1 }')
deviceName=$(adb -s ${udid} shell getprop ro.product.model)
platformVersion=$(adb shell getprop ro.build.version.release).0

if [ -f "$FILE" ]; then
  echo "$FILE exists"
  sed -i "s/udid.*/udid=${udid}/" "$FILE"
  sed -i "s/deviceName.*/deviceName=${deviceName}/" "$FILE"
  sed -i "s/platformVersion.*/platformVersion=${platformVersion}/" "$FILE"
else
  echo "$FILE does not exist"
  echo "udid=${udid}" >> config.properties
  echo "deviceName=${deviceName}" >> config.properties
  echo "platformVersion=${platformVersion}" >> config.properties
fi
