---
layout: page
title: COMP141 - Lab 3 - GCP Setup
permalink: /teaching/COMP141/Assignments/gcp/04_gcp_cli/
---

# Guide 4: Your VM from the CLI

While the Google Cloud web console is great for visual setup, managing cloud infrastructure from your local command line is faster, scriptable, and a fundamental skill in computing and software engineering.

This guide covers how to:
1. Install and configure the **Google Cloud CLI (`gcloud`)** on your local machine.
2. Create your **Free-Tier VM** directly from the terminal.
3. Connect to your VM using your local terminal via `gcloud compute ssh` and standard OpenSSH.
4. Start, stop, and inspect your VM using CLI commands.

---

## Part 1: Setting Up the Google Cloud CLI (`gcloud`)

### Step 1: Install the Google Cloud SDK
If you do not already have `gcloud` installed on your personal computer:
- Download the installer for your operating system (macOS, Linux, or Windows) from the official site:
  - [https://cloud.google.com/sdk/docs/install](https://cloud.google.com/sdk/docs/install)
- Follow the installation instructions for your OS, then restart your terminal or PowerShell prompt.

Verify the installation by running:
```bash
gcloud version
```

---

### Step 2: Authenticate with Your Monmouth College Google Account
Authenticate your CLI with the Google Account you created using your college email address:

```bash
gcloud auth login
```

1. A browser window will open automatically.
2. Sign in using your **`@monmouthcollege.edu`** Google account (the account you registered in Guide 1).
3. Click **Allow** to grant the Google Cloud SDK permission to access your account.
4. Return to your terminal.

---

### Step 3: Set Your Default Project and Region/Zone
Setting defaults prevents you from having to pass `--project` and `--zone` flags to every command.

1. **Find your Project ID**:
   ```bash
   gcloud projects list
   ```
   Note the `PROJECT_ID` column (e.g., `monmouth-comp141-123456`).

2. **Set your active project**:
   ```bash
   gcloud config set project YOUR_PROJECT_ID
   ```

3. **Set default compute region and zone** (choose an Always Free eligible zone, such as `us-central1-a`):
   ```bash
   gcloud config set compute/region us-central1
   gcloud config set compute/zone us-central1-a
   ```

4. **Verify your configuration**:
   ```bash
   gcloud config list
   ```

---

## Part 2: Creating Your Free-Tier VM via CLI

> [!NOTE]
> If you already created `comp141-linux-vm` via the web console in **Guide 3**, you do **not** need to create it again! You can jump straight to **Part 3: Connecting via Local Terminal**.

If you wish to create your VM from the command line, run the following command. It is configured to strictly comply with Google Cloud's **Always Free** tier parameters:

```bash
gcloud compute instances create comp141-linux-vm \
    --zone=us-central1-a \
    --machine-type=e2-micro \
    --image-family=debian-12 \
    --image-project=debian-cloud \
    --boot-disk-type=pd-standard \
    --boot-disk-size=30GB
```

### What Each Flag Does (Free-Tier Rules):
- `--zone=us-central1-a`: Uses the `us-central1` free-tier eligible region.
- `--machine-type=e2-micro`: Specifies the free-tier eligible instance type (2 vCPUs, 1 GB memory).
- `--image-family=debian-12` & `--image-project=debian-cloud`: Installs Debian 12 (bookworm). *(For Ubuntu 24.04 LTS instead, use `--image-family=ubuntu-2404-lts --image-project=ubuntu-os-cloud`)*.
- `--boot-disk-type=pd-standard`: **Critical!** Google defaults to balanced or SSD disks. You must specify `pd-standard` (Standard Persistent Disk) for the free tier.
- `--boot-disk-size=30GB`: Stays within the 30 GB monthly persistent disk free allowance.

Once executed, GCP will display a summary table showing your new VM, its internal IP, external IP, and status (`RUNNING`).

### How to Identify Your Instance's External IP Address

You can view and extract your VM's public external IP address from the command line in several ways:

1. **Directly from the creation output table**:
   The `gcloud compute instances create` command prints a table as soon as the instance is ready. Locate the **`EXTERNAL_IP`** column:
   ```text
   NAME              ZONE           MACHINE_TYPE  PREEMPTIBLE  INTERNAL_IP  EXTERNAL_IP    STATUS
   comp141-linux-vm  us-central1-a  e2-micro                   10.128.0.2   34.123.45.67   RUNNING
   ```
   *(In this example, `34.123.45.67` is the external IP. Do not confuse it with `INTERNAL_IP`, which is a private `10.x.x.x` address that only works inside Google Cloud).*

2. **At any time using `gcloud compute instances list`**:
   To view all instances along with their status and IP addresses:
   ```bash
   gcloud compute instances list
   ```

3. **Print only the External IP (useful for copy-pasting or shell scripts)**:
   ```bash
   gcloud compute instances describe comp141-linux-vm \
       --zone=us-central1-a \
       --format="get(networkInterfaces[0].accessConfigs[0].natIP)"
   ```
   This command extracts only the raw IP address string (e.g., `34.123.45.67`).

> [!NOTE]
> This external IP address is **ephemeral**. If you stop and restart your instance, Google Cloud will automatically allocate a new external IP address. Run `gcloud compute instances list` or the `describe` command above to look up the updated address whenever you start the VM.

---

### Step 2: Enable Incoming UDP Traceroute in GCP Firewall

By default, Google Cloud blocks unsolicited incoming UDP traffic. Because Unix and macOS `traceroute` commands send UDP probes on ports `33434`–`33534`, your VM will not respond to incoming traceroutes unless this port range is opened.

Run the following command in your terminal to create the firewall rule:

```bash
gcloud compute firewall-rules create allow-udp-traceroute \
    --direction=INGRESS \
    --priority=1000 \
    --network=default \
    --action=ALLOW \
    --rules=udp:33434-33534 \
    --source-ranges=0.0.0.0/0
```

### What Each Flag Does:
- `--direction=INGRESS`: Filters inbound traffic arriving at your instances.
- `--network=default`: Applies the rule across your project's `default` VPC network.
- `--action=ALLOW`: Permits matching packets through the firewall.
- `--rules=udp:33434-33534`: Opens destination ports `33434` through `33534` for the UDP protocol.
- `--source-ranges=0.0.0.0/0`: Accepts traceroute probes originating from any IP address on the internet.

*(Note: If you already created this firewall rule via the web console in Guide 3, you do not need to run this command again).*

---

## Part 3: Connecting to Your VM from Your Local Terminal

### Option A: Using `gcloud compute ssh` (Recommended & Easiest)

The Google Cloud CLI provides an automated SSH wrapper. It automatically generates SSH keys, uploads your public key to your Google Cloud account metadata, and opens an SSH session—all in one command:

```bash
gcloud compute ssh comp141-linux-vm --zone=us-central1-a
```
*(If you configured your default zone in Part 1, you can simply run `gcloud compute ssh comp141-linux-vm`).*

- **First-time prompt**: If this is your first time connecting, `gcloud` will ask if you want to generate an SSH key pair. Press **Y**, then press **Enter** twice to proceed with an empty passphrase (or set a passphrase if you prefer).
- You are now connected to your remote Linux shell directly in your local terminal!
- To exit the remote session, type:
  ```bash
  exit
  ```

---

### Option B: Using Standard OpenSSH (`ssh` command)

If you prefer using your system's native `ssh` client or configuring tools like VS Code Remote-SSH, you can set up standard SSH keys:

1. **Generate an SSH key pair on your computer**:
   ```bash
   ssh-keygen -t ed25519 -C "your_username@monmouthcollege.edu" -f ~/.ssh/gcp_key
   ```
   *(Press Enter twice to set no passphrase, or enter a passphrase).*

2. **Display your public key**:
   ```bash
   cat ~/.ssh/gcp_key.pub
   ```
   Copy the entire output string (starts with `ssh-ed25519` and ends with your username).

3. **Add the public key to GCP**:
   - In [Google Cloud Console](https://console.cloud.google.com/), navigate to **Compute Engine > Metadata > SSH Keys**.
   - Click **Edit**, then click **+ Add Item**.
   - Paste the public key string into the box and click **Save**.

4. **Find your VM's External IP**:
   ```bash
   gcloud compute instances list
   ```
   Look under the `EXTERNAL_IP` column.

5. **Connect using standard `ssh`**:
   ```bash
   ssh -i ~/.ssh/gcp_key your_username@EXTERNAL_IP
   ```

---

### Option C: Verifying Connectivity via Ping & Traceroute

Once your VM is running and the `allow-udp-traceroute` firewall rule is in place, verify connectivity from your local machine:

1. Retrieve your VM's external IP:
   ```bash
   gcloud compute instances list
   ```
2. Test ping (ICMP):
   ```bash
   ping <EXTERNAL_IP>
   ```
   *(Press `Ctrl+C` to stop).*
3. Test traceroute (UDP):
   - On macOS or Linux:
     ```bash
     traceroute <EXTERNAL_IP>
     ```
   - On Windows:
     ```bash
     tracert <EXTERNAL_IP>
     ```
   Because of the `allow-udp-traceroute` firewall rule, the traceroute will successfully trace each network hop and receive replies all the way to your VM!

---

## Part 4: Managing Your VM (Start, Stop, and Status)

You can manage the lifecycle of your virtual machine directly from your terminal.

### 1. Check VM Status
List all instances in your project and their running state:
```bash
gcloud compute instances list
```

To quickly get only the current status (`RUNNING` or `TERMINATED`):
```bash
gcloud compute instances describe comp141-linux-vm --zone=us-central1-a --format="get(status)"
```

### 2. Stop Your VM
When you are not actively using your instance, stop it to conserve resources:
```bash
gcloud compute instances stop comp141-linux-vm --zone=us-central1-a
```
Wait a few seconds until the command confirms that the instance has stopped.

### 3. Start Your VM
When you are ready to work again, power the VM back on:
```bash
gcloud compute instances start comp141-linux-vm --zone=us-central1-a
```

> [!WARNING]
> When you stop and start an instance, its **External IP address** changes (ephemeral IP). If you use `gcloud compute ssh comp141-linux-vm`, the CLI automatically connects to the updated IP. If you use standard `ssh`, run `gcloud compute instances list` to find the new IP address.

### 4. Delete Your VM (Cleanup Only)
If you ever need to completely remove the instance:
```bash
gcloud compute instances delete comp141-linux-vm --zone=us-central1-a
```
Google Cloud will ask for confirmation before deleting the VM and its boot disk.

---

## Command Quick-Reference Cheat Sheet

| Task | Command |
| :--- | :--- |
| **Authenticate** | `gcloud auth login` |
| **List Projects** | `gcloud projects list` |
| **Set Active Project** | `gcloud config set project YOUR_PROJECT_ID` |
| **Set Default Zone** | `gcloud config set compute/zone us-central1-a` |
| **List All VMs** | `gcloud compute instances list` |
| **Create Free-Tier VM** | `gcloud compute instances create comp141-linux-vm --zone=us-central1-a --machine-type=e2-micro --image-family=debian-12 --image-project=debian-cloud --boot-disk-type=pd-standard --boot-disk-size=30GB` |
| **Allow UDP Traceroute** | `gcloud compute firewall-rules create allow-udp-traceroute --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=udp:33434-33534 --source-ranges=0.0.0.0/0` |
| **Connect via SSH** | `gcloud compute ssh comp141-linux-vm` |
| **Stop VM** | `gcloud compute instances stop comp141-linux-vm` |
| **Start VM** | `gcloud compute instances start comp141-linux-vm` |
| **Delete VM** | `gcloud compute instances delete comp141-linux-vm` |

---

## Troubleshooting CLI Issues

- **`gcloud: command not found`**:
  - Make sure you followed the installer's instructions to add `gcloud` to your system `PATH`. Restart your terminal window after installation.
- **Permission Denied or Authentication Errors**:
  - Run `gcloud auth login` again and ensure you log in with your `@monmouthcollege.edu` Google account.
  - Verify your active project with `gcloud config get-value project`.
- **Instance Not Found**:
  - Ensure you specified the correct zone where your VM was launched (e.g., `--zone=us-central1-a`), or check `gcloud compute instances list` to confirm where it resides.
- **SSH Connection Refused or Timeout**:
  - Confirm that the VM is in `RUNNING` status by running `gcloud compute instances list`. If it was stopped, start it first with `gcloud compute instances start comp141-linux-vm`.
- **Traceroute Times Out (`* * *`)**:
  - Verify that the firewall rule exists with `gcloud compute firewall-rules list --filter="name=allow-udp-traceroute"`. If missing, run the firewall creation command from Part 2.
