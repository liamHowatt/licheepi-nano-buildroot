set -e

echo $1
stty -F /dev/ttyS1 $1 raw
pppd /dev/ttyS1 $1 nodetach lock noauth local debug dump nocrtscts passive 192.168.11.1:192.168.11.0
