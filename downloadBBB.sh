#!/bin/sh
read -p "Copy BBB-Link here: " bbbUrl
read -p "Name of the resultant file: " resultFileName
resultFileName="${resultFileName}.mp4"
meetingId=$(echo $bbbUrl | grep -o "/presentation/[0-9]*\.[0-9]*/.*" | sed "s,/presentation/[0-9]*\.[0-9]*/,,g")
bbbHost=$(echo $bbbUrl | grep -o ".*/playback/presentation" | sed "s#/playback/presentation##g")

echo "Your MeetingID: $meetingId"
echo "Your BBB-Host: $bbbHost"

# Download sound
webcamsUrl="$bbbHost/presentation/$meetingId/video/webcams.mp4"
output="webcams.mp4"

echo "Downloading sound..."
curl -o $output $webcamsUrl

# Download video

deskshareUrl="$bbbHost/presentation/$meetingId/deskshare/deskshare.mp4"
output="deskshare.mp4"

echo $deskshareUrl
echo "Downloading video..."
curl -o $output $deskshareUrl

# Merge

ffmpeg -i webcams.mp4 -i deskshare.mp4 -c copy $resultFileName

if [ $? -eq 0 ]; 
then 
    echo "Merge successful!" 
else 
    echo "Could not merge video and audio. Maybe ffmpeg is not installed: sudo apt install ffmpeg" 
fi
