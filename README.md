# Android Icons Rasterer

Convert SVG Inkscape custom icons of Android App in each raster image with right resolution.

## Usage

[Inkscape](https://inkscape.org/fr/) must be installed.

```
./Android_Icons_Rasterer.sh <inputFolder> <outputFolder>
```

Only SVG files in **inputFolder/16dp/** , **inputFolder/24dp/** , **inputFolder/32dp/** , and **inputFolder/48dp/** will be rastered.

If **ic_launcher.svg** is in folder **inputFolder/48dp/** , image **inputFolder/ic_launcher_web.png** with 512x512 resolution is created in **inputFolder/** .

OutFile names have resolution as suffix and are automatically saved in **outputFolder/drawable-ldpi/** , **outputFolder/drawable-mdpi/** , **outputFolder/drawable-hdpi/** , **outputFolder/drawable-xhdpi/** , **outputFolder/drawable-xxhdpi/** , **outputFolder/drawable-xxxhdpi/** .

Each resolution folder contains uninterpreted pattern **default.svg** for create icon with [Inkscape](https://inkscape.org/fr/).

*Bash file tested on ubuntu*
