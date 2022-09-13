---
aliases:
- /post/debugging-anacron
authors: []
categories: []
date: "2020-01-12T18:39:48-05:00"
draft: false
featured: false
image:
  caption: ""
  focal_point: ""
  preview_only: false
lastmod: "2020-01-12T18:39:48-05:00"
projects: []
subtitle: ""
summary: ""
tags:
- anacron
- bin
- command
- cron
- flag
- home
- job
- life
- myscript
- ""
- path
- root
- solution
- step
- task
- tool
title: Debugging Anacron
---


I like to automate things and `anacron`/`cron` are some of my go-to tools for getting the job done.

But, recently I was having issues with `anacron` and couldn't for the life of me figure out why one of my daily tasks wasn't running.
I had followed all the basic steps, such as making sure the executable was only alphanumeric and didn't contain any extension (e.g., `myscript` = good, `myscript.sh` = bad), but my task was still not running.
When I ran `run-parts --test /etc/cron.daily`, my task showed up as one of the listed tasks.
When I repeat the same command without the `--test` flag, my task works perfectly.

So what was wrong?

Well, I had completely forgotten that `anacron` runs as `root`, not as my user.
One of the commands called within my task was installed as a locally for my user, not globally.
When I had performed the `run-parts` tests, I was also running as my user, which is why everything appeared to be working.

The solution was to simply have the full path to the command (i.e., `/home/nicholas/.local/bin/my-command`) in the task instead of just calling the command directly (i.e., `my-command`)
