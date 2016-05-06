#! /bin/bash

# files to ignore
IGNORE_FILES=*default*
# file name for icon launcher
FILE_IC_LAUNHCER=ic_launcher*
# out directory
OUT_PATH=./output
# input standard extension
INPUT_EXT=.svg
# output standard extension
OUTPUT_EXT=.png

# ------------------------------------------------------------------------
#
# Android Icons Rasterer
#
# Copyright 2016 Jeremy JAMET
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ------------------------------------------------------------------------

# see https://inkscape.org/fr/doc/inkscape-man.html
# Function to generate vector image to raster image
raster() {
	IN_FILE=$1 # path in file (vector image)
	OUT_FILE=$2 # path out file (raster image)
	SIZE=$3 # size of raster image
	inkscape -z -f $IN_FILE -e ${OUT_FILE} -D -w $SIZE -h $SIZE
}

# resolutions for different sizes of icons
for r in 16 24 32 48
do
	# verify input directory
	resDirectory=${r}dp
	if [ ! -d "$resDirectory" ]; then
	  	# control if directory of each resolution exists
		continue
	fi

	# define each resolution
	ldpiRes=$(echo $r*0.75 | bc)
	hdpiRes=$(echo $r*1.5 | bc)
	xhdpiRes=$(echo $r*2 | bc)
	xxhdpiRes=$(echo $r*3 | bc)
	xxxhdpiRes=$(echo $r*4 | bc)

	for f in ${resDirectory}/*${INPUT_EXT}
	do
		# Contextual Icons / Notification icons / Action bar icons
		sufixOutDir=drawable
		resDP=_${r}dp

		# Launcher icons
		if [ "$r" -eq  48 ] && [[ $(basename "$f") =~ ${FILE_IC_LAUNCHER} ]]; then
			sufixOutDir=mipmap
			resDP=""
			render $f ${OUT_PATH}/ic_launcher_web${OUTPUT_EXT} 512 # Web
		fi

		if [[ $(basename "$f") != ${IGNORE_FILES} ]]; then
			# define each out directory
			ldpiOutDir=${OUT_PATH}/${sufixOutDir}-ldpi
			mdpiOutDir=${OUT_PATH}/${sufixOutDir}-mdpi
			hdpiOutDir=${OUT_PATH}/${sufixOutDir}-hdpi
			xhdpiOutDir=${OUT_PATH}/${sufixOutDir}-xhdpi
			xxhdpiOutDir=${OUT_PATH}/${sufixOutDir}-xxhdpi
			xxxhdpiOutDir=${OUT_PATH}/${sufixOutDir}-xxxhdpi
			# create directory
			mkdir -p ${ldpiOutDir}
			mkdir -p ${mdpiOutDir}
			mkdir -p ${hdpiOutDir}
			mkdir -p ${xhdpiOutDir}
			mkdir -p ${xxhdpiOutDir}
			mkdir -p ${xxxhdpiOutDir}
			# define out file

			outfile=${PREFIX_ICON}$(basename "$f" ${INPUT_EXT})${resDP}${OUTPUT_EXT}
			echo "Create drawables for contextual icon : $f"
			raster $f ${ldpiOutDir}/${outfile} ${ldpiRes}
			raster $f ${mdpiOutDir}/${outfile} $r
			raster $f ${hdpiOutDir}/${outfile} ${hdpiRes}
			raster $f ${xhdpiOutDir}/${outfile} ${xhdpiRes}
			raster $f ${xxhdpiOutDir}/${outfile} ${xxhdpiRes}
			raster $f ${xxxhdpiOutDir}/${outfile} ${xxxhdpiRes}
		fi
	done
done

