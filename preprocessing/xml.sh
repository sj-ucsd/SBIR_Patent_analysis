#!/bin/bash
head -1000682 ipa230720.xml > ip4.xml
sed -i'' -e '/<?xml/d' ip4.xml
sed -i'' -e '/DOCTYPE/d' ip4.xml
ex -sc '1i|<root>' -cx ip4.xml
ex -sc '$a|</root>' -cx ip4.xml
