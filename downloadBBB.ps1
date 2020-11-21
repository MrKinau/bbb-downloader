# Variables - CHANGE THIS TO YOUR NEEDS

$bbbHost = "https://scalelite.rlp.net" # no "/" at end 

# Functions

Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

function DownloadFile
{
    param($downloadUrl, $output, $description)
    Write-Host "Downloading $description..."
    Invoke-WebRequest -Uri $downloadUrl -OutFile $output
}

# Request user input BBB Link

$bbbUrl = Read-Host -Prompt 'Copy BBB-Link here'
$resultFileName = Read-Host -Prompt 'Name of the resultant file'
$resultFileName += ".mp4"
$parts = $bbbUrl -split "meetingId="
$meetingId = $parts[1]
Write-Host "Your MeetingID: $meetingId"

# Download sound

$webcamsUrl = "$bbbHost/presentation/$meetingID/video/webcams.mp4"
$output = "webcams.mp4"

DownloadFile $webcamsUrl $output "sound"

# Download video

$deskshareUrl = "$bbbHost/presentation/$meetingID/deskshare/deskshare.mp4"
$output = "deskshare.mp4"

DownloadFile $deskshareUrl $output "video"

# Download FFMPEG (if-not exists)

$ffmpegPath = ".\ffmpeg.exe"
$ffmpegVersion = "4.3.1-2020-11-08"

if (Test-Path($ffmpegPath)) {
    Write-Host "$ffmpegPath, already downloaded"
} else {
    $ffmpegUrl = "https://github.com/GyanD/codexffmpeg/releases/download/$ffmpegVersion/ffmpeg-$ffmpegVersion-full_build.zip"
    $output = "ffmpeg.zip"

    DownloadFile $ffmpegUrl $output "ffmpeg.zip"

    # Unzipping and moving

    Write-Host "Unzipping ffmpeg.zip..."
    Unzip ".\$output" "."

    Write-Host "Move ffmpeg.exe..."
    Move-Item -Path ".\ffmpeg-$ffmpegVersion-full_build\bin\ffmpeg.exe" -Destination "."

    Write-Host "Delete ffmpeg.zip..."
    Remove-Item -Recurse -Force ".\ffmpeg-$ffmpegVersion-full_build"
    Remove-Item -Force ".\ffmpeg.zip"
}

# Convert to one videofile

Write-Host "Merging video and audio..."
Invoke-Expression ".\ffmpeg.exe -i webcams.mp4 -i deskshare.mp4 -c copy $resultFileName"