yt-dlp --extract-audio \
  --audio-format mp3 \
  --embed-metadata \
  --embed-thumbnail \
  --no-overwrites \
  --convert-thumbnails jpg \
  "$1" \
  --ppa 'EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop="'"'"'if(gt(ih,iw),iw,ih)'"':'"'if(gt(iw,ih),ih,iw)'"'"'"' \
  -P $HOME/Music/$2
