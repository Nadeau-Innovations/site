---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Download iCal Calendar Data Using Python"
subtitle: ""
summary: ""
authors: []
tags: ["calendar", "data", "fire", "ics", "ical", "python","pandas"]
categories: []
date: 2020-06-25T08:32:04-04:00
lastmod: 2020-06-25T08:32:04-04:00
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

Sometimes you need access to your calendar data, such as when making synchronization tools.
In my particular case, I use my calendar as a high-level time-tracking tool which I then sync with [Clockify](https://clockify.me/) using their API.
To achieve synchronization, I first have to extract the raw event data from my calendar.

## Outlook ICS URL

If you're using Outlook, you can find your ICS URL here:

![](2020-06-25-08-47-02.png)

## Google Calendar ICS URL

If you're using Google Calendar, you can find your ICS URL here:

![](2020-06-25-08-45-34.png)

## Python Code

The following code snippet is an example Python script that connects to your calendar's ICS URL, downloads all the events, and dumps them to a CSV file.
The code may also be found in my [snippets repo](https://github.com/nnadeau/snippets).

The previously obtained ICS URL can either be set as an environment variable (e.g., `export CAL_ICS_URL=<URL>`) or set using the `--url` argument in the CLI.

The following non-standard library packages are required: [`fire`](https://github.com/google/python-fire), [`pandas`](https://pandas.pydata.org/), and [`ics`](https://github.com/C4ptainCrunch/ics.py).

```python
import logging
import os
from datetime import date, datetime
from pathlib import Path
from typing import Optional
from urllib.request import urlopen

import fire
import pandas as pd
from ics import Calendar

logger = logging.getLogger(__file__)


def main(output: Optional[str] = None, url: Optional[str] = os.getenv("CAL_ICS_URL")):
    # get calendar
    if not url:
        logger.error("URL argument or CAL_ICS_URL env variable must be set")
        quit()

    logger.info("Reading calendar")
    cal = Calendar(urlopen(url).read().decode("iso-8859-1"))

    # get events
    events = [e.__dict__ for e in cal.events]
    logger.info(f"Fetched {len(events)} events")

    # create dataframe
    df = pd.DataFrame(events)

    # dump output
    if not output:
        now = datetime.now().strftime("%Y-%m-%d")
        output = Path(__file__).parent / f"{now}_calendar.csv".resolve()
        output = output.resolve()
    else:
        output = Path(output)
    logger.info(f"Saving to {output.resolve()}")
    df.to_csv(output, index=False)


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    fire.Fire(main)

```

Since this script is built with the awesome [Python Fire](https://github.com/google/python-fire) library, it can easily be run as a command line tool:

```bash
# default args
python3 download_ical.py

# with args
python3 download_ical.py --output my-output.csv --url https://outlook.office365.com/owa/calendar/abc/xyz/calendar.ics
```
