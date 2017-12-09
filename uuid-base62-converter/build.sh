#!/bin/bash -ex

rm -rf out/
mkdir out/

kotlinc-jvm base62.kt -cp ./classpath/friendly-id-1.0.0.jar -include-runtime -d out/base62.jar
