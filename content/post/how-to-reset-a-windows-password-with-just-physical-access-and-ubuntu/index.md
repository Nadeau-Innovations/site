---
aliases:
- /post/2020/9/how-to-reset-a-windows-password-with-just-physical-access-and-ubuntu/
authors: []
categories: []
date: "2020-09-23T07:48:36-04:00"
draft: false
featured: false
image:
  caption: ""
  focal_point: ""
  preview_only: false
lastmod: "2020-09-23T07:48:36-04:00"
projects: []
subtitle: ""
summary: ""
tags:
- windows
- ubuntu
- usb
- pentest
- infosec
- it
title: How to Reset a Windows Password With Just Physical Access and an Ubuntu USB
---

For the majority of my career I've worked at small companies.
It's not uncommon that in addition to engineering I also have to play the role of IT specialist.
In this role, there have been a few occurrences of being locked out of a Windows PC (often due to an employee leaving the company and have no IT offboarding process).
Luckily, with just physical access and a USB key preloaded with Ubuntu, resetting the user password and gaining access to a PC isn't all that difficult.

The overall process looks like this:

1. Boot the PC into Ubuntu using the USB
2. Access the Windows partition and change the user account settings using [`chntpw`](https://en.wikipedia.org/wiki/Chntpw)
3. Reset the PC and boot into Windows with the new credentials

## Prerequisites

- Bootable USB flash drive [loaded with Ubuntu](https://ubuntu.com/tutorials/create-a-usb-stick-on-ubuntu)
- Target PC

## Boot into Ubuntu

Booting a PC from a USB is typically a quick process.
Often, the hardest part is figuring out what key combination is required to change the boot media from the startup screen.
Depending on the PC brand, the key that accesses the boot menu may be different:

- Lenovo PCs tend to use `F12`.[^lenovo]
- HP computers may require modifying the boot order in the BIOS first using `F10`.[^hp]
- Dell systems appear to use either `F11` or `F12`.[^dell]

Regardless of the brand or system, there's a good chance that you may have to reset the PC a couple times before getting the right key combination.
Once you successfully boot Ubuntu from the USB, select [`Try Ubuntu without installing`](https://ubuntu.com/tutorials/try-ubuntu-before-you-install#3-boot-from-usb-flash-drive).

[^lenovo]: https://support.lenovo.com/ca/en/solutions/ht104668
[^hp]: https://support.hp.com/in-en/document/c00364979
[^dell]: https://www.dell.com/support/article/en-ca/sln317102/booting-to-the-advanced-startup-options-menu-in-windows-10

## Changing Windows Account Settings from Ubuntu

Now that we're loaded into Ubuntu, it's time to modifying the Windows user account settings.

1. Open `Terminal` (keyboard shortcut `Ctrl-Alt+T`).
2. Enable additional `apt` repositories.

    ```bash
    sudo add-apt-repository universe
    sudo add-apt-repository multiverse
    sudo apt update
    ```

3. Install `chntpw`.

    ```bash
    sudo apt install chntpw
    ```

4. Navigate to the directory containing the Security Account Manager (SAM) database file in the Windows partition. Typically, the Windows partition is mounted under `/media` as a long hexidecimal string. From this mount, we want to navigate to `Windows/System32/config` (e.g., `/media/ABC123DEF456/Windows/System32/config`).

    ```bash
    cd /media/<WINDOWS MOUNT>/Windows/System32/config
    ```

5. Run `sudo chntpw SAM` to see a list of users and to change the admin password or use `sudo chntpw –u <username> SAM` to change the password of a specific user. I personally recommend setting the password to `Clear (blank) user password`.
6. Turn off the PC.
7. Remove the USB drive.
8. Boot back into Windows
9. Log in!

## References

- https://commons.lbl.gov/display/itfaq/Reset+Windows+Password+using+chntpw+and+Ubuntu
- https://www.howtogeek.com/howto/14369/change-or-reset-windows-password-from-a-ubuntu-live-cd/