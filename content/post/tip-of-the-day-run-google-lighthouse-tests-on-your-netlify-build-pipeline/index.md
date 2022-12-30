---
aliases:
- /post/tip-of-the-day-run-google-lighthouse-tests-on-your-netlify-build-pipeline
- /post/2020/5/tip-of-the-day-run-google-lighthouse-tests-on-your-netlify-build-pipeline/
authors: []
categories: []
date: "2020-05-13T08:46:36-04:00"
draft: false
featured: false
image:
  caption: ""
  focal_point: ""
  preview_only: false
lastmod: "2020-05-13T08:46:36-04:00"
projects: []
subtitle: ""
summary: ""
tags:
- audits
- json
- lighthouse
- netlify
- output
- pipeline
- jq
- cli
- documentation
- accessibility
- seo
- performance
- google
- bash
title: 'Tip of the Day: Automate Google Lighthouse Tests on Your Netlify Build Pipeline'
---

[Google Lighthouse](https://developers.google.com/web/tools/lighthouse) is an automation tool for auditing and improving the quality of web pages.
Measured metrics include performance, accessibility, SEO, and best practices.
It also has a [CLI app](https://developers.google.com/web/tools/lighthouse#cli) for command line automation.

[Netlify](https://www.netlify.com/) is a platform for modern static website deployment.
It's one of my favourite tools for hosting and testing websites and documentation (e.g., [my site](https://nadeauinnovations.com/) and [AON3D's documentation](https://docs.aon3d.com/)).

With the goal of automating all my workflows, I wanted to combine my site's Lighthouse audits with a local build and testing pipeline.
Fortunately, Netlify also [offers a CLI](https://docs.netlify.com/cli/get-started/) that replicates the hosted build process and can deploy to obfuscated URLs for previewing and testing sites.

Instead of pretty-printing the output, the Netlify CLI can be flagged to output to JSON.
With a little help from the fantastic [`jq`](https://stedolan.github.io/jq/) (a lightweight and flexible command line JSON processor), we can create a pipeline that automatically performs the following:

1. Builds the site using Netlify
2. Deploys the site to a Netlify preview URL
3. Processes the JSON output to extract the `deploy_url` using `jq`
4. Runs a Google Lighthouse audit on the given URL

From the command line, it simply looks like this:

```bash
lighthouse --view $(netlify deploy --json | jq -r ".deploy_url")
```

Broken down, we have:

- `lighthouse --view`: runs a Lighthouse audit on the given URL
- `netlify deploy --json`: deploys the current directory to a preview URL, does not pretty-print any output, and outputs the deployment data as JSON
- `jq -r ".deploy_url"`: processes the incoming JSON string, extracts the value of the `deploy_url` key, and outputs raw strings

This website's repository [contains a `Makefile`](https://github.com/engnadeau/nicholasnadeau-me/blob/master/Makefile) that uses the above process in a production setting.