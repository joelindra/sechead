![image](https://github.com/user-attachments/assets/b1e78897-c3bd-473f-abe7-3ca524ae2e78)

## **Security Headers Checker**

This Bash script is designed to assess the security posture of web applications by checking the presence and configuration of essential security headers in their HTTP responses. It includes functions to log messages with timestamps, check specific headers, and iterate through a list of common security headers for analysis.

# **Features:**

## Color Coding:

Uses ANSI escape codes to provide colored output for better readability:
Green for positive results (e.g., header present).
Red for negative results (e.g., header missing).
Yellow for warnings and informative messages.
Cyan for general messages and headers.
Magenta for emphasis.
Bold for highlighting.
No Color (NC) to reset color.
Generate Clickjacking Payload:

If the X-Frame-Options header is missing, the script offers to generate a Clickjacking payload.
Creates an HTML file with an iframe that embeds the target URL, allowing for Clickjacking testing.
Outputs the location of the generated file and instructions to open it in a browser.
Check Security Headers:

## Checks the presence of various HTTP security headers:
Content-Security-Policy
X-Content-Type-Options
X-Frame-Options
X-XSS-Protection
Strict-Transport-Security
Referrer-Policy
Feature-Policy (also checks Permissions-Policy as it is the newer name)
Expect-CT
Cache-Control
Pragma
Reports whether each header is present or missing, providing detailed output for each.
URL Validation and Normalization:

## Checks if the input URL starts with http:// or https://. If not, it prepends http://.
Validates the URL format to ensure it starts with http:// or https://.
User Interaction:

Prompts the user to decide whether to generate a Clickjacking payload if the X-Frame-Options header is missing.
Handles user input to either generate the payload, skip it, or show an error message for invalid choices.
Clear Screen:

Clears the terminal screen before starting the security headers check for a cleaner output display.

**Usage:**
- bash sechead.sh [target]
