#!/bin/sh
#this script is for cpu isolation using vfio-isolate
set_cpu() {
        #replace this set with the CPUs you want to keep for the host
        cset set -c 0,6,1,7 -s system
		#moves task to non isolated CPUs
        cset proc -m -f root -t system
        cset proc -k -f root -t system --force

        #replace this set with the CPUs you want to dedicate to the guest
        cset shield -c 2-5,8-11 -k on

        #optional - set affinity of kernel's writeback bdi-flush threads.
        #for me this is core 0,4,6,8 and hyperthreads
        #echo 151151 > /sys/bus/workqueue/devices/writeback/cpumask
        #0001 0101 0001 0001 0101 0001
}
set_cpu
