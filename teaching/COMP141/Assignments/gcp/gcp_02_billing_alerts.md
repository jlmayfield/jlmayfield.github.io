---
layout: page
title: COMP141 - Lab 3 - GCP Setup
permalink: /teaching/COMP141/Assignments/gcp/02_gcp_billing/
---


# Guide 2: Setting Up Budget & Billing Alerts in GCP

Even though this course utilizes Google Cloud's **Free Tier** and course education credits, setting up budget alerts is a critical best practice in cloud computing. A budget alert monitors your spending and sends email notifications if your account incurs charges, ensuring you are never surprised by unexpected costs.

Follow this step-by-step guide to set up a **$1.00 Budget Alert**.

---

## Objectives

- Understand GCP Billing structure.
- Create a low-cost budget threshold ($1.00 USD).
- Configure real-time email notifications for spending thresholds (50%, 90%, 100%).

---

## Step-by-Step Instructions

### Step 1: Open the GCP Billing Console
1. Log in to the [Google Cloud Console](https://console.cloud.google.com/).
2. Open the Navigation Menu (the **☰ hamburger menu** in the top-left corner).
3. Scroll down and select **Billing**.
   *(If prompted to choose a billing account, select your Education Billing Account associated with your course credits).*

---

### Step 2: Navigate to Budgets & Alerts
1. In the left-hand navigation menu of the Billing page, click **Budgets & alerts**.
2. Click the **+ Create Budget** button near the top of the screen.

---

### Step 3: Define Budget Scope (Step 1 of 3)
1. **Name**: Enter a descriptive name, such as `Course Budget Alert` or `COMP141-Zero-Cost-Alert`.
2. **Time range**: Select **Monthly**.
3. **Projects**: Leave set to **All projects** (or select your specific course project).
4. **Services**: Leave set to **All services**.
5. Click **Next** at the bottom of the form.

---

### Step 4: Set the Budget Amount (Step 2 of 3)
1. **Budget type**: Select **Specified amount**.
2. **Target amount**: Enter `1.00` (or `0.01` if you want an alert for any penny spent).
   > **Note**: Setting the target to $1.00 means you will receive alerts well before spending any meaningful amount of money.
3. Click **Next**.

---

### Step 5: Configure Alert Thresholds & Notifications (Step 3 of 3)
1. **Trigger thresholds**: By default, GCP provides rules for actual and forecasted spending. Set/verify the following rules:
   - **50% of budget** ($0.50 actual spent)
   - **90% of budget** ($0.90 actual spent)
   - **100% of budget** ($1.00 actual spent)
2. **Actions & Notifications**:
   - Check the box for **"Email alerts to billing admins and users"**.
   - Make sure your Monmouth College email address is listed as a Billing Account Administrator (this is default for your account).
3. Click **Finish**.

---

## Verifying Your Budget Alert

1. You should now see your newly created budget listed under **Budgets & alerts**.
2. The status card will show **$0.00 of $1.00 spent** along with a progress bar.
3. If your account ever exceeds $0.50, $0.90, or $1.00 in a month, Google will automatically send an alert email to your inbox.

---

## Best Practices for Cost Prevention

- **Always select Free-Tier eligible resources** (see Guide 3).
- **Shut down or delete unused VM instances** when finished with assignments if they are not needed.
- **Do not request static external IP addresses** or external load balancers unless instructed, as idle static IPs incur small hourly fees.
- **Check your GCP Console dashboard weekly** to verify $0 total spending.

---


