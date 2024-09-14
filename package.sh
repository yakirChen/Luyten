export VERSION="1.0.0"
export DIST_VERSION="1.0.0"
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/liberica-21.jdk
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-24.jdk/Contents/Home

export PATH=${JAVA_HOME}/bin:$PATH

java -version

mvn clean package -Dmaven.test.skip=true -Paliyun

if [ ! -x dict ]; then
  mkdir dist
fi

cp target/luyten-${VERSION}.jar dist

${JAVA_HOME}/bin/jpackage --verbose --input ./dist \
  --name Luyten \
  --main-jar luyten-${VERSION}.jar \
  --main-class us.deathmarine.luyten.LuytenOsx \
  --type dmg \
  --app-version ${DIST_VERSION} \
  --icon luyten.icns \
  --java-options '-XX:+UnlockExperimentalVMOptions --enable-preview -Xdock:name=Luyten -XX:+UseG1GC -Xms200M -Xmx200M' \
  --jlink-options '--strip-native-commands --strip-debug --no-man-pages --no-header-files' \
  --add-modules java.desktop,java.prefs,java.logging

# https://docs.oracle.com/en/java/javase/21/jpackage/packaging-overview.html

# jlink --compress=2 选项会增加 runtime lib中 shaders.metallib 文件的体积


# https://docs.bell-sw.com/liberica-jdk/21.0.3b12/general/release-notes/
# Liberica Minimal VM
# jlink --vm=minimal
