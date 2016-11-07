#!/bin/bash
filename=$1

sed -i "s///g" $filename
sed -i "s/-//g" $filename
sed -i "s/|//g" $filename
sed -i "s/\\\//g" $filename
sed -i "s:/::g" $filename
sed -i 's/^[ \t]*//' $filename
