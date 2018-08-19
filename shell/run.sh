workspace=$(cd "$(dirname "$0")"; pwd)/..

mkdir -p $workspace/log
mkdir -p $workspace/log/pid/

cd $workspace/../../skynet
./skynet ${workspace}/etc/${1}.cfg

cd $workspace/log
tail -f $1.log
