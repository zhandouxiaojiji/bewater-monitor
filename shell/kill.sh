#ps -Al | grep skynet | cut -c 10-16 | xargs kill -9

workspace=$(cd "$(dirname "$0")"; pwd)/..
pid=`cat $workspace/log/pid/${1}.pid`
kill -9 $pid
