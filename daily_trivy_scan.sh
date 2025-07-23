#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# === CONFIGURATION ===
IMAGES=(
  "nginx:latest"
  "yourregistry/yourapp:prod"
)
REPORT_DIR="/opt/trivy-reports"
DATE=$(date +"%Y-%m-%d")
REPORT_FILE="$REPORT_DIR/trivy_report_$DATE.txt"
EMAIL_TO="security-team@example.com"
EMAIL_SUBJECT="Daily Trivy Scan Report: $DATE"

# === PREPARE ===
mkdir -p "$REPORT_DIR"
> "$REPORT_FILE"

# === RUN SCANS ===
for img in "${IMAGES[@]}"; do
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] Scanning $img" | tee -a "$REPORT_FILE"
  trivy image --quiet --no-progress --severity HIGH,CRITICAL "$img" \
    | tee -a "$REPORT_FILE"
  echo -e "\n" >> "$REPORT_FILE"
done

# === SEND EMAIL ===
echo "[$(date +'%Y-%m-%d %H:%M:%S')] Sending report to $EMAIL_TO" | tee -a "$REPORT_FILE"
mail -s "$EMAIL_SUBJECT" "$EMAIL_TO" < "$REPORT_FILE"

echo "[$(date +'%Y-%m-%d %H:%M:%S')] Trivy scan complete: $REPORT_FILE"
