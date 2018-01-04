#!/bin/bash
set -ex

escape_sed() {
 echo $1 | sed \
  -e 's/\//\\\//g' \
  -e 's/\&/\\\&/g'
}

# Replace templates with class
# param $1 dirname
# param $2 class
replace_with() {
 sed -e "s/dirname/$(escape_sed $1)/" \
     -e "s/template/$(escape_sed $2)/" \
     -e "s/test_template/test_$(escape_sed $2)/"
}

ROOT=$(cd $(dirname $0)/..;pwd)

echo ROOT $ROOT

CLASS=$(basename $1|sed -e 's/\.cpp//' -e 's/\.h//')
DIR=$(dirname $1)

echo CLASS $CLASS
echo DIR $DIR


mkdir -p $ROOT/UNITTESTS/$DIR/$CLASS
cat $ROOT/UNITTESTS/template/test_template.cpp | \
	replace_with $DIR $CLASS \
	> $ROOT/UNITTESTS/$DIR/$CLASS/test_$CLASS.cpp

cat $ROOT/UNITTESTS/template/unittest.mk.template | \
	replace_with $DIR $CLASS \
	> $ROOT/UNITTESTS/$DIR/$CLASS/unittest.mk
