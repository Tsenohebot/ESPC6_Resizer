# ESPC6_Resizer
Collection of shell scripts to resize videos to fit on to the ESP32-c6-LCD screen module.

This only works with this specific board: https://www.amazon.co.uk/Waveshare-Microcontroller-Development-Single-Core-Processor/dp/B0DHTMYTCY/ref=asc_df_B0DHTMYTCY?mcid=b63c2caea3dd3d73af7e205c14745755&hvocijid=1543053578099097364-B0DHTMYTCY-&hvexpln=74&tag=googshopuk-21&linkCode=df0&hvadid=696285193871&hvpos=&hvnetw=g&hvrand=1543053578099097364&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9046205&hvtargid=pla-2281435176858&psc=1&gad_source=1

This is due to the 320x172 resolution display.

Ok so basically follow this guide:  https://www.instructables.com/Train-Scene-Decoration/

This should set you up with the code that can be flashed to onto the board and be ready to accept videos from the SD card.

**Note: The guide mentions the miniTV repo, which works but is missing one crucial dependancy**

```
#include "PINS_ESP32-C6-LCD-1_47.h"

```
 **This header is needed to get the lcd pins configured correctly using the Dev Device Pins library. But this header is not included in the Dev Device Pins library, neither v0.0.1 nor v0.0.2, you need to download the main branch from git and add that in as a library for it to work:
https://github.com/moononournation/Dev_Device_Pins**

## Other dependancies:

ffmpeg-normalize: needed to import and normalize files before formatting them, not strictly needed if you are sure all your input files are the same encoding.

To install use PIP:
```
pip3 install ffmpeg-normalize
```

## Usage:

```
./import.sh <filename>
```
Use this to encode all files to the same baseline mp4 format. This will also create the vids.txt manifest file and the output folder, so run it atleast once even if you have nothing to normalize.

Also the normalize folder will contain all your videos that will then be combined into a single MJPEG file when format is run.

```
./format <dir>
```
Use the directory that you want to convert your videos from, mostly the normalize folder. (the dir bit will probably be removed in the future)

After this, the output.mjpeg can be found in the output directory and copied over to the SD card.