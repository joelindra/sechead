#!/bin/bash

# Colors
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
MAGENTA="\033[0;35m"
BOLD="\033[1m"
NC="\033[0m" # No Color

# Function to generate Clickjacking payload
generate_clickjacking_payload() {
  local url=$1
  local payload_file="clickjacking_payload.html"
  
  cat <<EOF > "$payload_file"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Clickjacking Test</title>
</head>
<body>
  <h1>Clickjacking Test for $url</h1>
  <iframe src="$url" width="100%" height="500px" style="opacity: 0.6;"></iframe>
</body>
</html>
EOF

  echo "--------------------------------------------------------------"
  echo -e "${YELLOW}Clickjacking payload created: ${payload_file}${NC}"
  echo -e "${YELLOW}Open this file in a browser to test the Clickjacking attack.${NC}"
  echo "--------------------------------------------------------------"
}

# Function to check the presence and value of a security header
check_header() {
  local url=$1
  local header=$2
  local result=$(curl -s -I "$url" | grep -i "^$header:")

  if [ -n "$result" ]; then
    echo -e "${header}: ${GREEN}Present${NC} - ${YELLOW}${result}${NC}"
  else
    echo -e "${header}: ${RED}Missing${NC}"
    
    if [ "$header" == "X-Frame-Options" ]; then
      echo -e "${RED}X-Frame-Options header is missing, which makes the site vulnerable to Clickjacking.${NC}"
      read -p "Do you want to generate a Clickjacking payload? (y/n): " choice
      case "$choice" in
        [Yy]* ) generate_clickjacking_payload "$url";;
        [Nn]* ) echo -e "${CYAN}No payload generated.${NC}";;
        * ) echo -e "${RED}Invalid choice. No payload generated.${NC}";;
      esac
    fi
  fi
}

# Function to check security headers for a given URL
check_security_headers() {
  local url=$1
  clear
  echo -e "${CYAN}Checking security headers for $url${NC}"

  headers=(
    "Content-Security-Policy"
    "X-Content-Type-Options"
    "X-Frame-Options"
    "X-XSS-Protection"
    "Strict-Transport-Security"
    "Referrer-Policy"
    "Feature-Policy" # Also check Permissions-Policy as it is the newer name
    "Permissions-Policy"
    "Expect-CT"
    "Cache-Control"
    "Pragma"
  )

  for header in "${headers[@]}"; do
    check_header "$url" "$header"
  done

  echo -e "${CYAN}Security headers check completed.${NC}"
}

# Main script
if [ -z "$1" ]; then
  echo -e "${RED}Usage: $0 <url>${NC}"
  exit 1
fi

input=$1

# Normalize URL
if [[ "$input" =~ ^https?:// ]]; then
  url=$input
else
  url="http://$input"
fi

# Validate URL format
if [[ ! "$url" =~ ^https?:// ]]; then
  echo -e "${RED}Invalid URL format. Please provide a valid URL.${NC}"
  exit 1
fi

check_security_headers "$url"
