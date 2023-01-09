# First create the bridge
ip link add br0 type bridge
# Set the bridge as the master of enp5s0
ip link set dev enp5s0 master br0
# Delete the ip address from enp5s0
ip address delete 192.168.2.69 dev enp5s0
# Add the ip address to the bridge
ip address add 192.168.2.69/24 dev br0
# Set the route connections through router ip
ip route add default via 192.168.2.1 dev br0
# bring up up interface
ip link set br0 up
