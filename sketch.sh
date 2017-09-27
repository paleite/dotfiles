# Latest version my current license works with: 43.2
wget https://download.sketchapp.com/sketch-43.2-39069.zip &&\
  unzip -qq sketch-43.2-39069.zip -d sketch/ &&\
  mv -f sketch/Sketch.app /Applications/ &&\
  rm sketch-43.2-39069.zip &&\
  rm -rf sketch/
