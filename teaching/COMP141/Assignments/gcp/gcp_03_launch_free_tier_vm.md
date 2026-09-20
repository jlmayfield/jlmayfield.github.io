---
layout: page
title: COMP141 - Lab 3 - GCP Setup
permalink: /teaching/COMP141/Assignments/gcp/03_gcp_launch/
---

# Guide 3: Launching & Connecting to Your Free-Tier Linux Instance

This guide walks you through creating a free, cloud-hosted Linux virtual machine (VM) on Google Cloud Platform and connecting to it via SSH (Secure Shell).

---

## GCP Free Tier VM Rules

Google Cloud provides one free VM instance per account under the Always Free program, provided you match these exact settings:

| Setting | Free Tier Value | Notes |
| :--- | :--- | :--- |
| **Machine Type** | `e2-micro` (2 vCPU, 1 GB RAM) | Do NOT select `e2-small` or `e2-medium`. |
| **Region** | `us-central1` (Iowa)<br>`us-east1` (S. Carolina)<br>`us-west1` (Oregon) | Must pick one of these 3 US regions. |
| **Boot Disk Type** | **Standard Persistent Disk** (`pd-standard`) | **Crucial**: Change default "Balanced" or "SSD" to **Standard**. |
| **Boot Disk Size** | **30 GB** or less | Up to 30 GB total disk per month is free. |
| **Network Egress** | 1 GB per month (excluding China & Australia) | Sufficient for all course exercises. |

---

## Part 1: Enabling Compute Engine & Creating the VM

### Step 1: Navigate to Compute Engine
1. Open [Google Cloud Console](https://console.cloud.google.com/).
2. Open the Navigation Menu (the **☰ hamburger menu**).
3. Hover over **Compute Engine** and click **VM instances**.
4. If prompted to enable the Compute Engine API, click **Enable** and wait a moment for initialization.

---

### Step 2: Configure VM Instance Details
Click the **Create Instance** button at the top of the VM instances page. Configure the following fields carefully:

#### 1. Name & Region
- **Name**: Enter `comp141-linux-vm` (use lower-case letters, numbers, and hyphens only).
- **Region**: Choose one of the approved free regions:
  - `us-central1 (Iowa)` *(recommended)*
  - `us-east1 (South Carolina)`
  - `us-west1 (Oregon)`
- **Zone**: Any zone (e.g., `us-central1-a`).

#### 2. Machine Configuration
- **Preset**: Select **General-purpose**.
- **Series**: Select **E2**.
- **Machine type**: Select **e2-micro (2 vCPU, 1 GB memory)**.
  > You will see an estimated monthly cost on the right side of the screen. As long as you follow the free-tier parameters, your free credits/free tier allowance will cover this cost ($0 out-of-pocket).

#### 3. Boot Disk (CRITICAL STEP)
By default, GCP selects a Balanced Persistent Disk. You **must** change this to stay in the Free Tier!

1. Under the **Boot disk** section, click **Change**.
2. **Operating System**: Select **Debian** or **Ubuntu**.
   - *Recommended*: **Debian GNU/Linux 12 (bookworm)** or **Ubuntu 24.04 LTS**.
3. **Boot disk type**: Change from "Balanced Persistent Disk" to **Standard Persistent Disk**.
4. **Size (GB)**: Enter `30`.
5. Click **Select** at the bottom of the pop-up.

#### 4. Firewall & Networking
- Ensure **SSH** access is allowed (enabled by default on GCP VMs).

#### 5. Create the Instance
Double-check all settings against the table above, then click **Create** at the bottom of the page. Wait 30–60 seconds for the VM to start (a green checkmark will appear next to `comp141-linux-vm`).

#### 6. Identify Your VM's External IP Address
Once the VM finishes launching:
1. You will be on the **VM instances** page (`Compute Engine > VM instances`).
2. Look at the table of virtual machines and locate the row for **`comp141-linux-vm`**.
3. Find the column labeled **External IP** (located between *Internal IP* and *Connect*).
4. You will see a public IPv4 address (e.g., `34.123.45.67`):
   - Hover over the address and click the **Copy IP address** icon (📋) next to it to copy it to your clipboard.
   - **Do not confuse this with the Internal IP** (which usually starts with `10.x.x.x` and is only accessible within Google Cloud's private network).
   - *Reminder*: This address is **ephemeral**. If you stop and restart your instance, Google will assign a new External IP. Always check this column after starting the VM.

---

### Step 3: Enable Incoming UDP Traceroute in GCP Firewall

By default, Google Cloud's firewall allows `ping` (ICMP) and `SSH` (TCP port 22), but blocks unsolicited incoming UDP traffic. Because standard Unix and macOS `traceroute` commands probe destinations using UDP ports `33434`–`33534`, traceroute packets sent to your VM's external IP will time out (`* * *`) at the final hop unless we open this port range.

To configure your firewall so the VM responds to incoming UDP traceroute requests:

1. In the Google Cloud Console, open the Navigation Menu (**☰**) in the top-left corner.
2. Navigate to **VPC network > Firewall**.
3. Click **+ Create Firewall Rule** at the top of the page.
4. Fill in the following details:
   - **Name**: `allow-udp-traceroute`
   - **Network**: `default`
   - **Priority**: `1000` (default)
   - **Direction of traffic**: `Ingress`
   - **Action on match**: `Allow`
   - **Targets**: Select **All instances in the network**.
   - **Source IPv4 ranges**: Enter `0.0.0.0/0`.
   - **Protocols and ports**:
     - Check **Specified protocols and ports**.
     - Check **UDP**.
     - Enter port range: `33434-33534`.
5. Click **Create** at the bottom.

> [!NOTE]
> Creating firewall rules in Google Cloud is completely free of charge. Because this rule targets **All instances in the network**, your `comp141-linux-vm` will immediately respond to incoming traceroute probes without any additional setup.

---

## Part 2: Connecting to Your VM via In-Browser SSH

For most class exercises, connecting directly through your web browser is the quickest and easiest method—no extra software installation or SSH key configuration is required.

*(If you would like to connect from your local terminal or manage instances from the command line using `gcloud`, see **[Guide 4: Your VM from the CLI](gcp_04_your_vm_from_the_cli.md)**).*

---

### Connecting with GCP In-Browser SSH

1. Return to **Compute Engine > VM instances** in the Google Cloud Console.
2. Find `comp141-linux-vm` in your list of instances.
3. In the **Connect** column, click the **SSH** button.
4. A new browser window will open, automatically establishing an encrypted SSH connection to your Linux terminal.
5. Once loaded, you will see a Linux command prompt similar to:
   ```bash
   username@comp141-linux-vm:~$
   ```

---

## Part 3: Essential First Linux Commands

Once connected to your shell, verify your system configuration by executing these introductory commands:

1. **Check OS Details**:
   ```bash
   cat /etc/os-release
   ```
2. **Check System Architecture & Kernel**:
   ```bash
   uname -a
   ```
3. **Check Available Disk Space**:
   ```bash
   df -h
   ```
4. **Update Package Manager**:
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```
5. **Install Essential Tools** (e.g., `git`, `curl`, `nano`, `tmux`, `build-essential`):
   ```bash
   sudo apt install -y git curl nano tmux build-essential
   ```

---

## Part 4: Testing Network Connectivity (Ping & Traceroute)

You can verify that your VM and firewall rules are working properly by testing network connectivity from your personal computer's terminal:

1. Look at your VM on the **VM instances** page and copy its **External IP** address.
2. Open a terminal or PowerShell prompt on your personal computer:
   - **Test Ping**:
     ```bash
     ping <EXTERNAL_IP>
     ```
     *(Press `Ctrl+C` to stop).* The VM should immediately return ICMP replies.
   - **Test Traceroute**:
     - On macOS or Linux (uses UDP ports 33434–33534):
       ```bash
       traceroute <EXTERNAL_IP>
       ```
     - On Windows (uses ICMP):
       ```bash
       tracert <EXTERNAL_IP>
       ```
3. Because we added the `allow-udp-traceroute` firewall rule, the traceroute will show every network hop all the way to your VM's external IP at the final hop!

---

## Managing Your VM (Stopping & Starting)

- **Stopping your VM**: When not working on assignments for extended periods, you can stop the VM to conserve compute resources.
  - In GCP Console, check the box next to `comp141-linux-vm` and click **Stop** ⏹ at the top.
  - Alternatively, run `sudo shutdown -h now` inside the SSH terminal.
- **Restarting your VM**: Select `comp141-linux-vm` in GCP Console and click **Start / Resume** ▶.
  > **Note on IP Addresses**: When you stop and restart a VM, its **External IP address** may change (ephemeral IP). Use the new External IP or the GCP Browser SSH button to reconnect.

---

## Troubleshooting Checklist

| Problem | Cause | Solution |
| :--- | :--- | :--- |
| **SSH connection times out** | Firewall blocking port 22 or VM starting up | Wait 1 minute and retry. Ensure default network firewall rules allow SSH. |
| **Traceroute times out (`* * *`)** | Ingress firewall blocking UDP ports 33434–33534 | Ensure the `allow-udp-traceroute` rule is created under **VPC network > Firewall** with target *All instances in the network*. |
| **Billed unexpectedly** | Selected SSD or non-free region/machine type | Go to VM details, check disk type (must be Standard Persistent Disk) and machine type (`e2-micro`). |
| **Browser pop-up blocked** | Browser blocked the new SSH window | Allow pop-ups from `console.cloud.google.com` in your browser address bar. |

---

