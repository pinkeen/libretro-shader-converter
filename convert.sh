#!/usr/bin/env bash

find . -iname '*.cg' | while read src ; do
  dst="${src%.cg}.glsl"
  echo "Converting $src --> $dst"
done

find . -iname '*.cgp' | while read src ; do
  dst="${src%.cgp}.glslp"
  echo "$src --> $dst"
done
