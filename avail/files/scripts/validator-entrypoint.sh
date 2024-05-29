#!/bin/bash

# Declare the AVAIL_PID variable at the global scope
AVAIL_PID=""

# Function to start the avail process
start_avail() {
    /usr/local/bin/start.sh &
    AVAIL_PID=$!
}

# Function to stop the avail process
stop_avail() {
    echo "Stopping avail..."

    # Kill the avail-node process if it is running
    if [ -n "$AVAIL_PID" ] && kill -0 $AVAIL_PID 2>/dev/null; then
        kill -TERM $AVAIL_PID
        # Wait for the process to terminate
        while kill -0 $AVAIL_PID 2>/dev/null; do
            sleep 1
        done
        echo "avail process stopped"
        AVAIL_PID=""  # Reset AVAIL_PID after stopping the process
    else
        echo "No avail process found to stop"
    fi
}

# Function to restart the avail process
restart_avail() {
    echo "Restarting avail process"
    stop_avail

    # Add a delay before starting the avail process again
    echo "Waiting for resources to free up..."
    sleep 10

    start_avail
}

# Signal handler for SIGUSR1
handle_usr1() {
    restart_avail
}

# Trap the SIGUSR1 signal and call handle_usr1 when received
trap 'handle_usr1' SIGUSR1

# Start the initial avail process
start_avail

# Wait indefinitely to keep the script running and handle signals
while true; do
    sleep 1  # Sleep for a short duration to keep the loop responsive
done
