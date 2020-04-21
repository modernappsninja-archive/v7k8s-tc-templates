# !/bin/bash

echo "Enter vSphere Cluster Speed Capacity (GHz): "
read vclus_speed
echo "Enter vSphere Cluster Total Processors (Cores): "
read vclus_cores
echo "Enter the vSphere Namespace Capacity and Usage Limit for CPU(GHz): "
read vns_cpu_limit

vclus_speed_per_core=$(echo "scale=4; $vclus_speed/$vclus_cores" | bc)
k8s_ns_cpu_limit=$(echo "scale=4; $vns_cpu_limit/$vclus_speed_per_core" | bc)
millicores_output=$(echo "scale=4; $k8s_ns_cpu_limit*1000" | bc)

echo "An equivalent of $k8s_ns_cpu_limit cores, or $millicores_output millicores, is available to the namespace." 
