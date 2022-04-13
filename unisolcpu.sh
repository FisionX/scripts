#!/bin/sh
#This scripts undo cpu isolation with vfio-isolate
unset_cpu() {
        cset set -d system
        cset shield --reset
}
unset_cpu
