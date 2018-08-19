workspace=$(cd "$(dirname "$0")"; pwd)/..

mkdir -p $workspace/log
mkdir -p $workspace/log/pid/

cd $workspace/../../skynet
./skynet ${workspace}/etc/monitor.cfg

cd $workspace/log
tail -f monitor.log
