
OUTPUT="output"
VIDS="vids.txt"
FILE="${1:-.}"


if [ ! -d "$VIDS" ]; then
    touch vids.txt
fi

if [ ! -d "$OUTPUT" ]; then
    mkdir -p output
fi

ffmpeg-normalize "$FILE" -c:a aac -b:a 192k -ext mp4

