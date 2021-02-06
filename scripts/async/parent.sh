#!/bin/bash
# the parent process
echo "Parent: starting...."
echo "Parent: launching child script..."
./child.sh &      # start the child process and run in the backend (with &)
pid=$!       # get the child process's PID ($! stores the the last job's PID which was put into the background)
echo "Parent: chiuld (PID=$pid) launched."
echo "Parent: continuing..."
sleep 2
echo "Parent: pausing to wait for child to finish..."
wait $pid
echo "Parent: child is finished. Continuing..."
echo "Parent: parent is done. Exiting."
