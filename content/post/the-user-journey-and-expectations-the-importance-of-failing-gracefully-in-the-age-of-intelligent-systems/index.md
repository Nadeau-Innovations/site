---
# Documentation: https://wowchemy.com/docs/managing-content/

title: "The User Journey and Expectations: The Importance of Failing Gracefully in the Age of Intelligent Systems"
subtitle: ""
summary: ""
authors: []
tags: []
categories: []
date: 2023-03-15
lastmod: 2023-03-08T15:14:47-05:00
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  filename: "heroes/crash.jpg"
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

In today's world, technology is everywhere. From smartphones to intelligent systems and robots, we are surrounded by machines that make our lives easier and more efficient. However, as we increasingly rely on hard tech and intelligent systems, ensuring their functional safety and reliability becomes even more critical. This is especially true when humans and AI or robotics work together in manufacturing, transportation, and healthcare. This blog post will explore the concept of "failing gracefully" and why intelligent systems must do so, especially when humans are involved.

## What is "Failing Gracefully"?

When we talk about "failing gracefully," we refer to a system's ability to handle errors or unexpected situations without causing harm to itself, others, or the environment. In other words, it's the ability to fail in a way that minimizes the impact of the failure.

For example, in robotics, emergency stops are a standard failure mode. While this is often perfectly normal and relatively safe in industrial robotics, it can be catastrophic and dangerous in collaborative robotics with physical human-robot interaction (pHRI). Suddenly stopping and clamping a human to the environment during an emergency stopping event may be safe for the robot but not for the human.

## Explicit vs. Implicit Failure Modes

There are two types of failure modes: explicit and implicit. Explicit failures, such as an error message or system crash, are immediately apparent to the user. Some examples would be:

- A mobile robot collision due to lousy localization and mapping
- HTTP status codes, such as 404 Not Found
- A 3D printer tool head crashing, causing the print to fail

Implicit failures, on the other hand, are not immediately apparent, don't raise an error, and may go unnoticed for some time, causing long-term damage, harm, or other issues. Examples include:

- A UI button that doesn't perform the intended backend operation
- Adaptive cruise control that doesn't detect the car in front of it

{{< youtube "aX7KypGlitg" >}}

## User Expectations and the User Journey

The user experience plays a significant role in determining acceptable failure types. Users have different expectations depending on the context and the task at hand. For example, a user might be willing to tolerate a system crash in a video game but not in a medical device.

Similarly, the user journey, or the steps involved in completing a task, can also affect the acceptable failure type. The user may be willing to start again if a failure occurs early. However, if the failure occurs late in the process, it could cause significant frustration and a loss of time or resources. For example, in high-performance 3D printing, spools of PEEK (one of the highest-performance polymers in the world) cost around $600/kg. Failures should occur quickly in the print job to avoid wasting expensive material.

## The Trust Contract

Failing gracefully is part of the trust contract between users and intelligent systems. Users rely on these systems to perform tasks correctly and safely. If a system fails in a way that causes harm or damage, it can erode the user's trust in the system and the organization that developed it. On the other hand, if a system fails gracefully, it can reinforce the user's confidence.

## Silent Failures

Silent failures go unnoticed by the user, which can be dangerous and annoying. For example, if a self-driving car fails to detect an obstacle but does not alert the driver, it could cause a severe accident. Similarly, if a medical device fails to administer medication but does not notify the medical staff, it could risk the patient's life. Silent failures can also be annoying because they can cause the user to waste time or redo work only after they realize on their own that a failure occurred.

Failing gracefully is crucial to intelligent systems, especially when humans are involved. Explicit and implicit failure modes, user expectations, and the user journey all play a role in determining what types of failures are acceptable. Failing gracefully is part of the trust contract between users and intelligent systems, and silent failures can be dangerous and annoying. As hard tech and intelligent systems become more prevalent, ensuring their safety and reliability will become even more critical.
