# !/bin/bash
# v0.0.1
# csaroka@vmware.com

echo "Enter vSphere Cluster Speed Capacity (GHz): "
read vclus_speed
echo "Enter vSphere Cluster Total Processors (Cores): "
read vclus_cores
echo "Enter the deployment value for spec.template.spec.containers.resources.requests.cpu : "
read cpu_request
echo "Enter the deployment value for spec.template.spec.containers.resources.limits.cpu : "
read cpu_limit
echo "Enter the number of pods (Running replicas only) : "
read pods_running

vclus_speed_per_core=$(echo "scale=3; $vclus_speed/$vclus_cores" | bc)
cpu_request_core=$(echo "scale=3; $cpu_request/1000" | bc)
run_pods_request=$(echo "scale=3; $cpu_request_core*$pods_running" | bc)
cpu_limit_core=$(echo "scale=3; $cpu_limit/1000" | bc)
run_pods_limit=$(echo "scale=3; $cpu_limit_core*$pods_running" | bc)

cpu_util_min=$(echo "scale=3; $run_pods_request*$vclus_speed_per_core" | bc)
cpu_util_max=$(echo "scale=3; $run_pods_limit*$vclus_speed_per_core" | bc)


echo "The namespace Capacity and Usaage, CPU Utilization value should report a value within the range of $cpu_util_min to $cpu_util_max GHz."