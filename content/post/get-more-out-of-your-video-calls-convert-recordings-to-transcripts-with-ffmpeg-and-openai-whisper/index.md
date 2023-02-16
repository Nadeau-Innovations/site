---
# Documentation: https://wowchemy.com/docs/managing-content/

title: "Get More Out of Your Video Calls: Convert Recordings to Transcripts with FFMPEG and OpenAI Whisper"
subtitle: ""
summary: ""
authors: []
tags: [python,wsl,wsl2,openai,whisper,ffmpeg,zoom,google,google meet,microsoft,microsoft teams,teams,video,audio,call,ai,machine learning,ubuntu]
categories: []
date: 2023-02-16T13:25:49-05:00
lastmod: 2023-02-16T13:25:49-05:00
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

Are you tired of sifting through hours of video call recordings to find that one crucial detail? Do you need help taking accurate notes during a fast-paced virtual meeting? If so, converting your video call recordings to transcripts can save you time and improve your productivity.

This blog post will show you how to use FFMPEG and OpenAI Whisper to turn your [Zoom](https://zoom.us/), [Google Meet](https://meet.google.com/), [Microsoft Teams](https://www.microsoft.com/en-ca/microsoft-teams/download-app), or other video call recordings into easily searchable and accessible transcripts.

## What are FFMPEG and OpenAI Whisper?

[FFMPEG](https://ffmpeg.org/) is a powerful open-source tool that allows you to manipulate and convert video and audio files in various formats. [OpenAI Whisper](https://github.com/openai/whisper) is an advanced transcription tool that uses AI to transcribe audio and video files with remarkable accuracy.

## How to Convert Video Call Recordings to Transcripts Using FFMPEG and OpenAI Whisper

### 1) Export your video call recording as an MP4 file

Before converting your video call recording to a transcript, you must export it as an [MP4 file](https://en.wikipedia.org/wiki/MP4_file_format). See the links below for instructions:

- [Zoom: Finding and viewing local recordings](https://support.zoom.us/hc/en-us/articles/206277393-Finding-and-viewing-local-recordings)
- [Google Meet: Record a video meeting](https://support.google.com/a/users/answer/9846751?hl=en)
- [Microsoft Teams: Play and share a meeting recording in Teams](https://support.microsoft.com/en-us/office/play-and-share-a-meeting-recording-in-teams-7d7e5dc5-9ae4-4b94-8589-27496037e8fa)

### 2) Install FFMPEG

FFMPEG is a command-line tool; you'll need to download and install it on your computer before using it. You can [download FFMPEG for free from the official website](https://ffmpeg.org/) or install it using a package manager like `apt` on Ubuntu and Windows WSL. For Ubuntu and Windows WSL users, it's as easy as:

```bash
sudo apt update
sudo apt install -y ffmpeg
```

### 3) Convert the MP4 file to an audio-only file using FFMPEG

Once you have installed FFMPEG, open your terminal and navigate to the folder where your MP4 file is saved. Then, enter the following command to convert the video file to an audio-only file:

```bash
ffmpeg -i input.mp4 -vn -acodec copy output.aac
```

### 4) Install OpenAI Whisper

Whisper is a general-purpose speech recognition AI model, and it is trained on a large dataset of diverse audio. It is also a multi-task model that can perform multilingual speech recognition, speech translation, and language identification. The model is open source and [available to download from its GitHub repository](https://github.com/openai/whisper) or [available as a command line tool through Python](https://pypi.org/project/openai-whisper/).

To install the model as a command line tool, install it with `pipx`. [This official Python tool](https://pypa.github.io/pipx/) allows you to install and run Python applications in isolated environments to avoid dependency issues:

```bash
# install pipx
python3 -m pip install --user pipx
python3 -m pipx ensurepath

# install openai whisper
pipx install openai-whisper
```

Note that you will [also require `nvidia-cudnn`](https://developer.nvidia.com/cudnn) which can be installed on Ubuntu and Windows WSL using:

```bash
sudo apt update
sudo apt install -y nvidia-cudnn
```

### 5) Process the Audio File with OpenAI Whisper

Now that you have an audio file of your video call recording, you can process it with OpenAI Whisper to generate a transcript. You will need a computer with a modern NVIDIA GPU (e.g., a gaming PC). Run the following:

```bash
whisper output.aac
```

This will automatically download the `small` model and export the transcript into several formats, including TXT, JSON, SRT, and VTT:

```sh
.
├── output.aac.json
├── output.aac.srt
├── output.aac.tsv
├── output.aac.txt
└── output.aac.vtt
```

## Why is This Workflow Useful?

Converting your video call recordings to transcripts offers several benefits, including:

- **Time savings**: Rather than spending hours sifting through a long recording, you can quickly search and find the information you need in a transcript.
- **Improved accuracy**: Transcripts are often more accurate than notes taken during a fast-paced virtual meeting.
- **Accessibility**: Transcripts make it easier for people with hearing impairments to participate in virtual meetings and events.

Converting your video call recordings to transcripts using FFMPEG and OpenAI Whisper is a simple and effective way to save time, improve accuracy, and increase accessibility. Following the steps outlined in this blog post, you can quickly and easily turn virtual meetings into searchable and accessible transcripts.
