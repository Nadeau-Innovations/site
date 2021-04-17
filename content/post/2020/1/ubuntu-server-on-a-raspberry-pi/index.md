---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Ubuntu Server on a Raspberry Pi"
subtitle: ""
summary: ""
authors: []
tags: ["bash", "device", "fail2ban", "hostname", "raspberry", "ssh", "sudo", "ubuntu"]
categories: []
date: 2020-01-13
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---

As a follow up to [a previous post about Raspberry Pi setups]({{< ref "post/2019/2/raspberry-pi-setup" >}}), I recently found out that [Ubuntu has an official server distribution for Raspberry Pi](https://ubuntu.com/download/raspberry-pi).

Here are my steps to setting up a Raspberry Pi for development and testing.

## Ubuntu Server Image

- Download the [official Ubuntu Raspberry Pi image](https://ubuntu.com/download/raspberry-pi)
- Write the disk image to an SD card using [`balenaEtcher`](https://www.balena.io/etcher/) or similar
- Insert the SD card into the Raspberry Pi and boot the device

## Connect to the Device

Find your PC's IP:

```bash
# alias for `ip address`
ip a
```

Scan your network for the new device:

```bash
sudo nmap -sn <BASE IP>/24

# e.g., scan between 192.168.1.0 and 192.168.1.255
sudo nmap -sn 192.168.1.0/24
```

`ssh` to the new device:

```bash
# default username and password is `ubuntu`
ssh ubuntu@<Device IP>
```

## Update Device Settings

### Add New User Account

Add a non-root user that's not the default account:

```bash
sudo adduser nicholas
sudo adduser nicholas sudo, admin
```

Switch to the new user:

```bash
sudo su - nicholas
```

Remove the old, default account

```bash
sudo pkill -u ubuntu
sudo deluser -remove-home ubuntu
```

Install `fail2ban`: [^1]

[^1]: https://www.lifewire.com/harden-ubuntu-server-security-4178243

```bash
sudo apt install fail2ban
```

Edit `fail2ban` settings:

```bash
sudo vim /etc/fail2ban/jail.local
```

Add the following:

```bash
[sshd]
enabled = true
port = 22
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
```

Restart `fail2ban` to use the new settings:

```bash
sudo systemctl restart fail2ban
```

### Use a Public Key for `ssh`

From your local machine, copy your `ssh` public key to the new device:

```bash
ssh-copy-id nicholas@<Device IP>
```

Update the `ssh` config on the device:

```bash
sudo vim /etc/ssh/sshd_config
```

Update the following for better security:

```bash
AllowUsers nicholas
LoginGraceTime 1m
PermitRootLogin no
ChallengeResponseAuthentication no
PasswordAuthentication no
UsePAM no
```

### Update Device Hostname

Change the hostname name in `/etc/hostname`:

```bash
sudo vim /etc/hostname
```

Change the hostname in `/etc/hosts`:

```bash
sudo vim /etc/hosts
```

Add the following line to `/etc/hosts`:

```bash
127.0.1.1	<MY NEW HOSTNAME>
```

Keep your new hostname on reboot, by editing the following: [^2] [^3] [^4]

[^2]: https://askubuntu.com/questions/1028633/host-name-reverts-to-old-name-after-reboot-in-18-04-lts
[^3]: https://www.techrepublic.com/article/how-to-change-the-hostname-on-ubuntu-18-04/
[^4]: https://askubuntu.com/questions/59458/error-message-sudo-unable-to-resolve-host-none

```bash
sudo vim /etc/cloud/cloud.cfg
```

Change the file to have:

```bash
preserve_hostname: yes
```

Install `avahi-daemon` to broadcast hostname on network: [^5]

[^5]: https://unix.stackexchange.com/a/255713

```bash
sudo apt install avahi-daemon
```
