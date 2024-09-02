export VERSION=$1
export V=$2
export ARCH=$3

java -version

if [ ! -x dict ]; then
  mkdir dist
fi

cp target/luyten-${VERSION}.jar dist

jpackage --verbose --input ./dist \
  --name Luyten \
  --mac-package-name Luyten \
  --main-jar luyten-${VERSION}.jar \
  --main-class us.deathmarine.luyten.LuytenOsx \
  --type dmg \
  --app-version ${VERSION} \
  --icon luyten.icns \
  --java-options '-XX:+UnlockExperimentalVMOptions --enable-preview -Xdock:name=Luyten -XX:+UseG1GC -Xms200M -Xmx200M' \
  --jlink-options '--strip-native-commands --strip-debug --no-man-pages --no-header-files'


mv Luyten-${VERSION}.dmg Luyten-${V}-${ARCH}.dmg

# https://docs.oracle.com/en/java/javase/21/jpackage/packaging-overview.html

# jlink --compress=2 选项会增加 runtime lib中 shaders.metallib 文件的体积


# https://docs.bell-sw.com/liberica-jdk/21.0.3b12/general/release-notes/
# Liberica Minimal VM
# jlink --vm=minimal
