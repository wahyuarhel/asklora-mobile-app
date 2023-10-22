file="../version.properties"

while IFS='=' read -r key value
do
    key=$(echo $key | tr '.' '_')
    eval ${key}=\${value}
done < "$file"

VERSION_NAME=${major}'.'${minor}'.'${patch}

VERSION_CODE=$(( $major * 10000 + $minor * 100 + $patch))

sed -i "" "/flutter.versionName=/ s/=.*/=$VERSION_NAME/" android/local.properties
sed -i "" "/flutter.versionCode=/ s/=.*/=$VERSION_CODE/" android/local.properties
sed -i "" "/flutter.buildMode=/ s/=.*/=release/" android/local.properties

plutil -replace CFBundleShortVersionString -string $VERSION_NAME ios/Runner/Info.plist
plutil -replace CFBundleVersion -string $VERSION_CODE ios/Runner/Info.plist

NEW_PATCH=$(( $patch + 1 ))

sed -i "" "/patch=/ s/=.*/=$NEW_PATCH/" "../version.properties"

#TODO: Open this in CI/CD Pipeline
#git add version.properties
#git commit -m "Updated the version.properties file"

