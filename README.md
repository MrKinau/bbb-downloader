# bbb-downloader

Powershell-Script which download BBB recordings and merges sound and deskshare using FFMPEG.

## Usage (windows)

1. Clone this repo or download and extract it.
2. Run Powershell as administrator (Windows-Search "Powershell" -> Right-click "Run as Administrator").
3. cd into the downloaded directory `bbb-downloader`.
4. Run `set-executionpolicy unrestricted` to allow executing unsigned scripts.
5. Run `.\downloadBBB.ps1`.
6. Copy the URL to the playback after the prompt `Copy BBB-Link here`. This should look like this `https://bbb.example.com/playback/presentation/2.0/playback.html?meetingId=375240faa7265529b58e0efe9f5fe793-b8b2b763a50993de7dfd0`.
7. Choose a file name after the prompt `Name of the resultant file` (without the .mp4 ending).

## Usage (Unix)

1. Clone this repo or download and extract it.
2. Open a terminal.
3. cd into the downloaded directory `bbb-downloader`.
4. Run `chmod +x downloadBBB.sh` to allow the executing of this script.
5. Run `./downloadBBB.sh`.
6. Copy the URL to the playback after the prompt `Copy BBB-Link here`. This should look like this `https://bbb.example.com/playback/presentation/2.0/playback.html?meetingId=375240faa7265529b58e0efe9f5fe793-b8b2b763a50993de7dfd0`.
7. Choose a file name after the prompt `Name of the resultant file` (without the .mp4 ending).
