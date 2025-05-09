# mkconcatlist.sh — create files.txt for FFmpeg’s concat demuxer
#                   with “files 'vids/…’” lines
#
# Usage:
#   ./mkconcatlist.sh                 # scans the current directory
#   ./mkconcatlist.sh /path/to/clips  # scans /path/to/clips
#

set -euo pipefail

DIR="${1:-.}"          # directory to scan, or "." if none given
OUT="vids.txt"        # playlist file to write
PREFIX="normalized/"         # prefix to add in front of every filename

> "$OUT"               # empty/replace the playlist

find "$DIR" -maxdepth 1 -type f -iname '*.mp4' \
  | sort \
  | while IFS= read -r f; do
      base=$(basename "$f")              # strip leading directories
      printf "file '%s%s'\n" "$PREFIX" "$base" >> "$OUT"
    done

echo "Wrote $(wc -l < "$OUT") entries to $OUT"

rm output/*
sleep 5

ffmpeg -f concat -safe 0 -i vids.txt -vf "fps=15,scale=320:172:force_original_aspect_ratio=decrease, pad=320:172:(ow-iw)/2:(oh-ih)/2" \
        -c:v mjpeg -pix_fmt yuvj420p -q:v 7 -an output/output.mjpeg