#!/usr/bin/env python3
from pathlib import Path as pt
import subprocess as sp 
import sys 

link=f"{sys.argv[1]}"
try:
    pl_name=f"{sys.argv[2]}"
except:
    pl_name=""
ext="mp3"
output_dir=str(pt.home())+"/Music/"
link=link.replace("music","www")

print(link)
def grab_name(url):
    outp=sp.run([ "yt-dlp", 
            "--flat-playlist", 
            "--print", 
            f"%(title)s [%(id)s].{ext}", 
            url],
            capture_output=True,
            text=True)
    out_list = outp.stdout.split("\n")

    return out_list[:-1]

def download(url):
    print("-----------------------------------")
    command=[ "yt-dlp", 
        "--extract-audio",
        "--audio-format",
        "mp3",
        "--embed-metadata",
        "--embed-thumbnail", 
        "--convert-thumbnails", "jpg",
        "--no-overwrites", 
        "-P",output_dir, 
        "--ppa",
        'EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop="\'if(gt(ih,iw),iw,ih)\':\'if(gt(iw,ih),ih,iw)\'"',
        url
    ]
    result=sp.run(command)
    print("-----------------------------------")
    return result.returncode==0

def makem3u(url,name):
    if name=="":name="new"
    with open(f"{output_dir}{name}.m3u","w") as f:
        f.write("#EXTM3U\n")
        for i in grab_name(url):
            f.write("#EXT-X-RATING:0\n")
            f.write(i+'\n')

if "playlist?" in link:
    print(grab_name(link))
    makem3u(link,pl_name)
    if download(link):
        print("playlist downloaded")
    else:
        print("process error")
else:
    print(grab_name(link))
    download(link)
    print("single file downloaded")
