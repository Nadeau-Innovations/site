+++
title = "Setting Up a Raspberry Pi for Dev Side-projects"
date = 2019-02-10T10:40:22-05:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["bash", "boot", "connectivity", "dev", "device", "listenaddress", "login", "openssh", "passwd", "password", "port", "raspberry", "root", "ssh", "sudo", "user123"]
categories = []

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
+++

The Raspberry Pi is a great device for dev side-projects, such as a home media station, an IoT device, or a local server.
Here are some of my go-to configurations when setting one up.

<!--more-->

## Booting with Connectivity

- Create a `wpa_supplicant.conf` in the `boot` directory for wireless connections
  - More info [here](https://www.raspberrypi.org/documentation/configuration/wireless/wireless-cli.md)
- Create a `ssh` file in the `boot` directory to enable SSH

## OpenSSH

- OpenSSH options are set in `/etc/ssh/sshd_config`

```bash
# disable root login
PermitRootLogin no

# allow only specific users
AllowUsers user1 user2

# allow only specific groups
AllowGroups groupA groupB

# change sshd port number
Port 123

# change login grace time
LoginGraceTime 1m

# restrict the interface to login
ListenAddress 192.168.1.123
ListenAddress 192.168.0.456

# disconnect ssh when no activity
ClientAliveInterval 300
ClientAliveCountMax 0
```

## Security

### Add User and Password

```bash
sudo /usr/sbin/useradd --groups sudo -m user123
sudo passwd user123
```

### Reset Root Password

```bash
sudo passwd root
```

### Disable Default Pi Account

```bash
sudo passwd --lock pi
```
