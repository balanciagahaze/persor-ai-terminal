# Persor AI Termux & CMD Agent

This folder contains the client scripts to connect to the Persor AI Terminal interface from your local command line.

## Requirements

- **Termux (Android)**: `curl` or `python`
- **Windows (CMD/PowerShell)**: `python`

## Installation & Usage

### 1. Termux (Android) / Linux / macOS

You can use the `agent.sh` script.

1. Give execution permission:
   ```bash
   chmod +x agent.sh
   ```

2. Run the agent:
   ```bash
   ./agent.sh
   ```
   
   To connect to a local development server or alternative URL:
   ```bash
   ./agent.sh http://localhost:8787
   ```

### 2. Windows (CMD / PowerShell) / Termux (Python Method)

If you have Python installed, this is the recommended method.

1. Install requests (if not installed):
   ```bash
   pip install requests
   ```

2. Run the agent:
   ```bash
   python agent.py
   ```

   To connect to a custom URL:
   ```bash
   python agent.py http://localhost:8787
   ```
