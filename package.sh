export VERSION="0.7.0"
export DIST_VERSION="1.7.0"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/liberica-21.0.3.jdk
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home

mvn clean package -Dmaven.test.skip=true -Paliyun

mkdir dist

cp target/luyten-${VERSION}.jar dist

jpackage --input ./dist \
  --name Luyten \
  --main-jar luyten-${VERSION}.jar \
  --main-class us.deathmarine.luyten.LuytenOsx \
  --type dmg \
  --app-version ${DIST_VERSION} \
  --icon luyten.icns \
  --java-options '-XX:+UnlockExperimentalVMOptions --enable-preview -Xdock:name=Luyten -XX:+UseG1GC -Xms200M -Xmx200M' \
  --jlink-options '--strip-native-commands --strip-debug --no-man-pages --no-header-files --vm=server'


# https://docs.oracle.com/en/java/javase/21/jpackage/packaging-overview.html

# jlink --compress=2 选项会增加 runtime lib中 shaders.metallib 文件的体积