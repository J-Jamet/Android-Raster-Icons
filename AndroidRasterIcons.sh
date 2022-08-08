#! /bin/bash

# files to ignore
IGNORE_FILES=*default*
# input standard extension
INPUT_EXT=.svg
# output standard extension
OUTPUT_EXT=.png
# file name for icon launcher
FILE_IC_LAUNCHER=ic_launcher${INPUT_EXT}
FILE_IC_LAUNCHER_ROUND=ic_launcher_round${INPUT_EXT}

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

# Input arguments

if [ $# -lt 2 ]; then
    echo "Usage: $0 <inputFolder> <outputFolder>"
    echo ""
    echo "Only SVG files in <inputFolder>/16dp/ <inputFolder>/24dp/ <inputFolder>/32dp/ and <inputFolder>/48dp/ folders will be rastered."
    echo "If $FILE_IC_LAUNCHER or $FILE_IC_LAUNCHER_ROUND is in folder <inputFolder>/48dp/ , image <inputFolder>/ic_launcher_web${OUTPUT_EXT} with 512*512 resolution is created in <inputFolder>."
    exit 1
fi

input=$1/
output=$2/

# see https://inkscape.org/fr/doc/inkscape-man.html
# Function to generate vector image to raster image
raster() {
	IN_FILE=$1 # path in file (vector image)
	OUT_FILE=$2 # path out file (raster image)
	SIZE=$3 # size of raster image
	DPI=$4 # resolution of image
	inkscape --export-filename="${OUT_FILE}" -C -w $SIZE -h $SIZE -d $DPI $IN_FILE
}

# resolutions for different sizes of icons
for r in 16 24 32 48
do
	# verify input directory
	resDirectory=${input}${r}dp
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
		if [ "$r" -eq  48 ] && [[ $(basename "$f") = ${FILE_IC_LAUNCHER_ROUND} ]]; then
			sufixOutDir=mipmap
			resDP=""
			raster $f ${output}ic_launcher_round_web${OUTPUT_EXT} 512 160 # Round icon for Web
		fi
		if [ "$r" -eq  48 ] && [[ $(basename "$f") = ${FILE_IC_LAUNCHER} ]]; then
			sufixOutDir=mipmap
			resDP=""
			raster $f ${output}ic_launcher_web${OUTPUT_EXT} 512 160 # Icon for Web
		fi
		
		if [[ $(basename "$f") != ${IGNORE_FILES} ]]; then
			# define each out directory
			ldpiOutDir=${output}${sufixOutDir}-ldpi
			mdpiOutDir=${output}${sufixOutDir}-mdpi
			hdpiOutDir=${output}${sufixOutDir}-hdpi
			xhdpiOutDir=${output}${sufixOutDir}-xhdpi
			xxhdpiOutDir=${output}${sufixOutDir}-xxhdpi
			xxxhdpiOutDir=${output}${sufixOutDir}-xxxhdpi
			# create directory
			mkdir -p ${ldpiOutDir}
			mkdir -p ${mdpiOutDir}
			mkdir -p ${hdpiOutDir}
			mkdir -p ${xhdpiOutDir}
			mkdir -p ${xxhdpiOutDir}
			mkdir -p ${xxxhdpiOutDir}
			# define out file

			outfile=${PREFIX_ICON}$(basename "$f" ${INPUT_EXT})${resDP}${OUTPUT_EXT}
			echo "Create drawables for icon : $f"
			raster $f ${ldpiOutDir}/${outfile} ${ldpiRes} 80
			raster $f ${mdpiOutDir}/${outfile} $r 160
			raster $f ${hdpiOutDir}/${outfile} ${hdpiRes} 240
			raster $f ${xhdpiOutDir}/${outfile} ${xhdpiRes} 320
			raster $f ${xxhdpiOutDir}/${outfile} ${xxhdpiRes} 480
			raster $f ${xxxhdpiOutDir}/${outfile} ${xxxhdpiRes} 640
		fi
	done
done

