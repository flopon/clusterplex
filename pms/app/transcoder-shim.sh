#!/bin/bash

export LD_LIBRARY_PATH="/usr/lib"

externalTranscoder="/app/transcoder.js"

this_pid=$$

echo "Calling external transcoder: $externalTranscoder" >&2
node $externalTranscoder "$@" &
transcoder_pid=$!

echo "Starting sentinel monitoring pid $this_pid and child pid $transcoder_pid" >&2
/app/sentinel.sh $this_pid $transcoder_pid &

wait $transcoder_pid
