#!/bin/bash

# Declare the ALEO_PID variable at the global scope
ALEO_PID=""

# Function to start the Aleo process
start_aleo() {
    echo "Starting Aleo node..."
    /sonaric/scripts/start.sh &
    ALEO_PID=$!
}

# Function to stop the Aleo process
stop_aleo() {
    echo "Stopping Aleo node..."
    if [ -n "$ALEO_PID" ] && kill -0 $ALEO_PID 2>/dev/null; then
        pkill -TERM -P $ALEO_PID
        sleep 20  # Wait for termination
        if kill -0 $ALEO_PID 2>/dev/null; then
            echo "Forcefully stopping remaining Aleo processes..."
            pkill -KILL -P $ALEO_PID
        fi
        while kill -0 $ALEO_PID 2>/dev/null; do
            sleep 1
        done
        echo "Aleo node stopped."
    else
        echo "No Aleo node process found to stop."
    fi
}


# Function to restart the Aleo process
restart_aleo() {
    echo "Restarting Aleo node"
    if stop_aleo; then
        start_aleo
    else
        echo "Failed to stop the Aleo node properly; restart aborted."
    fi
}


# Signal handler for SIGUSR1
handle_usr1() {
    echo "Signal SIGUSR1 received, restarting Aleo node..."
    restart_aleo
}

# Trap the SIGUSR1 signal and call handle_usr1 when received
trap 'handle_usr1' SIGUSR1

# Start the initial Aleo process
start_aleo

# Wait indefinitely to keep the script running and handle signals
while true; do
    sleep 1  # Sleep for a short duration to keep the loop responsive
done
