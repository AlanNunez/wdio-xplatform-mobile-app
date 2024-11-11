#!/bin/bash

# Set iPhone model and iOS version
iphone_model="${IPHONE_MODEL// /-}"
ios_version="${IOS_VERSION//./-}"
simulator_name="${iphone_model}"

# Verify if the specified runtime is available
if ! xcrun simctl list runtimes | grep -q "com.apple.CoreSimulator.SimRuntime.iOS-$ios_version"; then
    echo "Error: The specified iOS runtime version 'iOS $ios_version' is not available."
    exit 1
fi

# Create a simulator with the specified model and iOS version
simulator_udid=$(xcrun simctl create "$IPHONE_MODEL" "com.apple.CoreSimulator.SimDeviceType.$iphone_model" "com.apple.CoreSimulator.SimRuntime.iOS-$ios_version")

# Export the simulator UDID as an environment variable
export SIMULATOR_UDID="$simulator_udid"
echo "SIMULATOR_UDID=$SIMULATOR_UDID" >> $GITHUB_ENV

# Boot the simulator
xcrun simctl boot "$simulator_udid"

# Open the Simulator app
open -a Simulator
