# Android Raster Icons

Build and convert SVG Inkscape custom icons of Android App in each raster image with right resolution.

![preview](https://raw.githubusercontent.com/J-Jamet/Android-Raster-Icons/HEAD/template_ic_launcher.jpg)

![preview](https://raw.githubusercontent.com/J-Jamet/Android-Raster-Icons/HEAD/previewIcons.jpg)

## Usage

1. [Inkscape](https://inkscape.org/fr/) must be installed on your linux machine.

2. Use the **default_ic_launcher.svg** and **default_ic_launcher_round.svg** to create main application icons. *(rename as **ic_launcher.svg** and **ic_launcher_round.svg**)*

3. Use the **default.svg** files to create global icons. *(rename each icon with the convention **ic_[name].svg**)*

4. *Launch script with :*

```
./AndroidRasterIcons.sh <inputFolder> <outputFolder>
```

**Note** : All files containing the word `default` will be ignored.

Only SVG files in **inputFolder/16dp/** , **inputFolder/24dp/** , **inputFolder/32dp/** , and **inputFolder/48dp/** will be rastered.

If **ic_launcher.svg** is in folder **inputFolder/48dp/** , image **outputFolder/ic_launcher_web.png** with 512x512 resolution is created in **outputFolder/** .

## Example
```
# Create phone svg icon with inkscape, place in ./inputFolder/32dp/ic_phone.svg and launch script
./AndroidRasterIcons.sh ./inputFolder ./outputFolder

# ./inputFolder/32dp/ic_phone.svg -> ./outputFolder/drawable-ldpi/ic_phone_32dp.png
#                                 -> ./outputFolder/drawable-mdpi/ic_phone_32dp.png
#                                 -> ./outputFolder/drawable-hdpi/ic_phone_32dp.png
#                                 -> ./outputFolder/drawable-xhdpi/ic_phone_32dp.png
#                                 -> ./outputFolder/drawable-xxhdpi/ic_phone_32dp.png
#                                 -> ./outputFolder/drawable-xxxhdpi/ic_phone_32dp.png
```

OutFile names have resolution as suffix and are automatically saved in **outputFolder/drawable-ldpi/** , **outputFolder/drawable-mdpi/** , **outputFolder/drawable-hdpi/** , **outputFolder/drawable-xhdpi/** , **outputFolder/drawable-xxhdpi/** , **outputFolder/drawable-xxxhdpi/** .

Each resolution folder contains uninterpreted pattern **default.svg** for create icon with [Inkscape](https://inkscape.org/). Use guidelines for generate icons with margin.

**IMPORTANT** : check raster image for **ldpi** and **hdpi** with software like [GIMP](http://www.gimp.com/) for manually remove blur.

*Bash file tested on ubuntu*

## License

Copyright (c) 2016 JAMET Jeremy

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

