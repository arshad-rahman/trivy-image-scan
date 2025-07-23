# 🔐 Trivy Image Scan

Automate daily vulnerability scans of your Docker images using Trivy and Bash.

---

## 📋 Table of Contents

- [Features](#features)  
- [Prerequisites](#prerequisites)  
- [Configuration](#configuration)  
- [Installation](#installation)  
- [Usage](#usage)  
- [Scheduling - Cron](#scheduling---cron)  
- [Contributing](#contributing)  

---

## Features

- Scans specified Docker images for **HIGH** & **CRITICAL** vulnerabilities  
- Generates a dated report file under a configurable directory  
- Sends the report via email to your security team  
- Simple, readable Bash script with zero external dependencies (aside from Trivy & mail)  

---

## Prerequisites

- **Docker** & **Trivy** installed on the host  
- **mailutils** or **bsd-mailx** for email delivery  
- **Bash** shell  

Install on Ubuntu/Debian:

```bash
sudo apt update
sudo apt install -y trivy mailutils
````

---

## Configuration

Open `daily_trivy_scan.sh` and adjust these variables:

```bash
# List of images to scan
IMAGES=(
  "nginx:latest"
  "yourregistry/yourapp:prod"
)

# Directory where reports are saved
REPORT_DIR="/opt/trivy-reports"

# Email settings
EMAIL_TO="security-team@example.com"
EMAIL_SUBJECT="Daily Trivy Scan Report: $(date +'%Y-%m-%d')"
```

---

## Installation

Clone the repository and make the script executable:

```bash
git clone https://github.com/arshad-rahman/trivy-image-scan.git
cd trivy-image-scan
chmod +x daily_trivy_scan.sh
```

---

## Usage

Run a one‑off scan:

```bash
./daily_trivy_scan.sh
```

Check the generated report:

```bash
ls /opt/trivy-reports
tail -n 50 /opt/trivy-reports/trivy_report_$(date +'%Y-%m-%d').txt
```

---

## Scheduling - Cron

Add a cron entry to run the script daily at 1 AM:

```cron
0 1 * * * /path/to/trivy-image-scan/daily_trivy_scan.sh >> /var/log/trivy-scan.log 2>&1
```

---

## Contributing

Contributions and suggestions are welcome!

1. Fork this repository
2. Create a branch:

   ```bash
   git checkout -b feature/your-feature
   ```
3. Commit your changes:

   ```bash
   git commit -m "Add awesome feature"
   ```
4. Push to your branch:

   ```bash
   git push origin feature/your-feature
   ```
5. Open a Pull Request

---

<p align="center">  
  Made with ❤️ by Arshad Rahman  
</p>
