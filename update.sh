#!/bin/bash

function updateOnsenui {  
  libPath="package.json";
  newVersion=${1}
  echo $newVersion

  for D in */; do
    if [ $D != "node_modules/" ]; then
      echo "Update target:: ${D}${libPath}";
      (cd $D && git checkout master && git pull)
      sed -i '' -e "s/\"onsenui\"\ *:\ *\"[~^]*[0-9]\.[0-9]\.[0-9]\"/\"onsenui\":\ \"~${newVersion}\"/" ${D}${libPath} 
      sed -i '' -e "s/\"version\"\ *:\ *\".*\"/\"version\":\ \"2\.4\.0+20180301\.1\"/" ${D}${libPath} 
      (cd $D && git add -A && git commit -m "Update onsenui in package.json.")
      (cd $D && git tag -f 2.4.0 )
    fi
  done
}

newVersion=${1}

if [[ $newVersion =~ [0-9]\.[0-9]\.[0-9] ]]; then
    updateOnsenui $newVersion
  else
    echo "Please use version string format like 'x.x.x'."
fi