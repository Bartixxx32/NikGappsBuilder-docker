#!/bin/bash

# Function to validate if a string contains only numbers and is within the specified range
validate_input() {
  input="$1"
  # Regular expression to match digits
  digit_pattern="^[0-9]+$"

  if [[ ! "$input" =~ $digit_pattern ]]; then
    echo "Error: First argument must contain only numbers."
    exit 1
  fi

  if ((input < 10 || input > 13)); then
    echo "Error: First argument must be in the range from 10 to 13."
    exit 1
  fi
}

# Function to handle Ctrl+C
ctrl_c() {
  echo "Ctrl+C pressed. Exiting..."
  exit 1
}

# Trap Ctrl+C and execute the ctrl_c function
trap ctrl_c INT

# Check if command-line arguments are provided
if [ $# -eq 2 ]; then
  # If two arguments are provided, use them directly
  validate_input "$1"
  first_page_choice="$1"
  second_page_choice="$2"
else
  # Display the first page using dialog
  dialog --clear --backtitle "CLI GUI" \
    --title "Android Version" \
    --menu "Select an Android version:" 15 40 3 \
    10 "Android 10" \
    11 "Android 11" \
    12 "Android 12" \
    13 "Android 13" 2> /tmp/first_page_choice || {
    echo "Dialog canceled. Exiting..."
    exit 1
  }

  # Capture the choice made on the first page
  first_page_choice=$(cat /tmp/first_page_choice)
  rm /tmp/first_page_choice

  # Display the second page using dialog
  dialog --clear --backtitle "CLI GUI" \
    --title "Gapps Variant" \
    --menu "Select an gapps variant:" 15 40 3 \
    core "Core" \
    basic "Basic" \
    omni "Omni" \
    stock "stock" \
    go "Go" \
    full "Full" 2> /tmp/second_page_choice || {
    echo "Dialog canceled. Exiting..."
    exit 1
  }

  # Capture the choice made on the second page
  second_page_choice=$(cat /tmp/second_page_choice)
  rm /tmp/second_page_choice
fi

# You can now use $first_page_choice and $second_page_choice in your script as needed
git clone -b main --depth=1 https://gitlab.com/nikgapps/$first_page_choice.git $first_page_choice/
git pull $first_page_choice/
nikgapps --androidVersion $first_page_choice --packageList $second_page_choice
