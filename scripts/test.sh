#!/bin/bash
# Tests that the extension is built correctly

# Array of expected configuration strings
expected_configurations=(
  "xhprof support => enabled"
  "xhprof.collect_additional_info => 0 => 0"
  "xhprof.output_dir => /tmp/xhprof => /tmp/xhprof"
  "xhprof.sampling_depth => 0x7fffffff => 0x7fffffff"
  "xhprof.sampling_interval => 100000 => 100000"
)

# Function to check each configuration
check_configuration() {
  local config="$1"

  # Get the entire PHP configuration output
  local php_info=$(php -i)

  # Check if the php_info contains the expected configuration as is
  if echo "$php_info" | grep -qF "$config"; then
    echo "$config is correctly set"
  else
    echo "ERROR: $config is not properly set"
    exit 1
  fi
}

# Loop through all expected configurations and check each
for config in "${expected_configurations[@]}"; do
  check_configuration "$config"
done
