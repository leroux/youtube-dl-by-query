#!/bin/sh

# queries.txt should be populated before running this script.

# Put your API key in google_api_key.txt.
GOOGLE_API_KEY=$(cat google_api_key.txt)

searchToId()
dlTracks()

searchToId() {
  YTROOT="https://www.youtube.com/watch?v="
  QROOT="https://www.googleapis.com/youtube/v3/search?key=$GOOGLE_API_KEY&part=id&type=video&maxResults=1&q="

  rm -f queries-a.txt out.txt

  sed 's/\ /+/g' queries.txt >> queriesWithPlus.txt

  while read f
  do
    Q=$QROOT$f
    echo $YTROOT$(curl -s $Q | grep "videoId" | cut -d \" -f 4) >> out.txt
  done < queries-a.txt
}

dlTracks() {
  youtube-dl -o 'audio/%(title)s.%(ext)s' -c -w -x -a out.txt
}
