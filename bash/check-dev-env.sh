#!/bin/bash

PROGRAM=${0##*/} # the version
VERSION="$PROGRAM v1.0.0"
LOG_TIME_FORMAT="%F %T"

PYTHON=python3.9
PIP=pip3.9

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

function loggging() {
    local message=$1
    echo "$(date +"$LOG_TIME_FORMAT") $message"
}

function eeloggging() {
    local message=$1
    echo -e "$(date +"$LOG_TIME_FORMAT") ${RED}$message${NC}"
}

function ggloggging() {
    local message=$1
    echo -e "$(date +"$LOG_TIME_FORMAT") ${GREEN}$message${NC}"
}

# Function to check if Python is installed
function check_python_installed() {
  if command -v $PYTHON &> /dev/null; then
    python_version=$($PYTHON --version 2>&1)
    ggloggging "Python version: $python_version"
  else
    eeloggging "Python is not installed."
    exit 1
  fi
}

# Function to check if pip is installed
function check_pip_installed() {
  if command -v $PIP &> /dev/null; then
    pip_version=$($PIP --version 2>&1)
    ggloggging "Pip version: $pip_version"
  else
    eeloggging "Pip is not installed."
    exit 1
  fi
}

# Function to check if a Python module is installed
function check_python_module() {
  local module=$1
  $PYTHON -c "import $module" &> /dev/null
  if [ $? -eq 0 ]; then
    ggloggging "Python module '$module' is installed."
  else
    eeloggging "Python module '$module' is not installed."
  fi
}

# Function to check if a Python module is installed
function check_env_var() {
  local ENV_VAR=$1
  local VAR_VALUE="${!ENV_VAR}"
  if [ -z "$VAR_VALUE" ]; then
    eeloggging "The '$ENV_VAR' environment variable is not set."
  else
    ggloggging "The '$ENV_VAR' environment variable is set to $VAR_VALUE."
  fi
}

# Check if Python is installed and get its version
check_python_installed
check_pip_installed

# Example usage to check for specific Python modules
check_python_module pyspark

check_env_var SPARK_LOCAL_IP
check_env_var JAVA_HOME

loggging "End $VERSION"