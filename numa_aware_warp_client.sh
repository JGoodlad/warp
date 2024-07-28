#!/bin/sh

echo "Determining NUMA configuration..."

echo "Network interfaces:"
ip link show

echo "Numa info:"
numactl --hardware

# NUMA detection
export NIC_INTERFACE=$(ip link show | grep -v lo | awk 'NR==1 {print $2}' | tr -d ':')
# export NIC_NUMA_NODE=$(cat /sys/class/net/${NIC_INTERFACE}/device/numa_node)
export NIC_NUMA_NODE="0"

echo "NIC interface name: $NIC_INTERFACE"
echo "NUMA node with NIC: $NIC_NUMA_NODE"

echo "Command to run: exec numactl --cpunodebind=$NIC_NUMA_NODE --membind=$NIC_NUMA_NODE ./warp client"

exec numactl --cpunodebind=$NIC_NUMA_NODE --membind=$NIC_NUMA_NODE ./warp client