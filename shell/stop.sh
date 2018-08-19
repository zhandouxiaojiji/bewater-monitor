workspace=$(cd "$(dirname "$0")"; pwd)/..
tmp=$workspace/script/stop_conf.lua
echo "return \"$1\"" > $tmp

cd $workspace/../../skynet
./skynet ${workspace}/etc/stop.cfg

rm $tmp

