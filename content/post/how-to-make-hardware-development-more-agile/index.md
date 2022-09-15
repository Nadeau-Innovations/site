---
aliases:
- /post/2021/5/how-to-make-hardware-development-more-agile/
authors: []
categories: []
date: "2021-05-11T16:52:23-04:00"
draft: false
featured: false
image:
  caption: ""
  focal_point: ""
  preview_only: false
lastmod: "2021-05-11T16:52:23-04:00"
projects: []
subtitle: ""
summary: ""
tags:
- agile
- hardware
- engineering
- robotics
title: How to Make Hardware Development More Agile
---

People say that you can't do agile hardware development.
I don't believe that.

While I'm not a fan of all the hype and buzz around "Agile," I do believe in the core principles.

Agile is about following a set of development values, not adding more overheard or overzealous processes.
We want work to be transparent, efficient, and continuously improved.

## Waterfall

Traditionally, hardware engineering follows a [waterfall methodology](https://en.wikipedia.org/wiki/Waterfall_model).
While on paper, this seems quite logical from a planning perspective and allows for lots of stakeholder gates, it begins to fall apart when you realize that we never have all the requirements at the start.
Waterfall subscribes to the idea that what you want initially is what you get at the end.

There's little room for significant changes in direction.
In game theory or economics, it assumes that hardware design is a game of perfect information.

## Agile

On the other hand, [Agile](https://en.wikipedia.org/wiki/Agile_software_development) subscribes to the idea that design is a game with incomplete information.
While Waterfall is very stakeholder-focused and provides lots of oversight, an agile approach breaks this rigidity and primarily focuses on end-users and outcomes.

## Gates and Stakeholder Anxiety

What about gates and design reviews?
If we pivot our thinking, a traditional design project can be considered an [initiative](https://www.atlassian.com/agile/project-management/epics-stories-themes), with the waterfall gates and design reviews as the [epics](https://www.atlassian.com/agile/project-management/epics-stories-themes).
Each epic segment has a set of "customers," stakeholders and gatekeepers, each with their own user stories that must be resolved.
By combining this project management mindset with software-style [continuous integration and continuous delivery (CI/CD)](https://en.wikipedia.org/wiki/CI/CD), we can iterate and respond to new information within the development process.

Requirements aren't just collected at the beginning.
Testing isn't just done at the end.
Traditional gates and design reviews essentially become demo days because everyone has been involved throughout the process.
Interestingly, when done well, agile hardware becomes even more transparent to stakeholders.

## Deliberate R&D

I enjoy this mindset because it allows for a more apparent distinction between R&D and production.
R&D is an initiative with a series of epics.
Transfer to production (TTP) is also an initiative with a series of epics.
Each of these initiatives has different timelines, stakeholders, and even designers/developers.

All too often (especially in startups), R&D units become production systems because someone was willing to pay (I often blame Sales for my stress).
This front-loaded value becomes a long-term cost, as supporting beta systems in the field is never easy.
Rarely is design for maintenance considered when prototyping.
Customer experience is marred when they expected enterprise but received prototype.

When customers are part of the development process (e.g., as beta partners), we have a more straightforward path to success.

## Apply the Manifesto

The [Agile Manifesto](https://agilemanifesto.org/), while based on software development, can easily be transposed to hardware development.
It focuses on four values:

- Individuals and interactions over processes and tools
  - Invest in your team and their diversity (both in terms of cross-functional skills and culture) rather than just fancy tools and rigid processes.
- Working hardware over comprehensive documentation
  - Feedback and testing are the priority. Get your hardware into real-world applications ASAP.
- Customer collaboration over contract negotiation
  - Stakeholders are the most important resource and should be involved at all stages of development, not just at gates.
- Responding to change over following a plan
  - Measure twice, cut once. With more iterations, testing, and feedback early, we can achieve better overall output later.

## Apply the Principles

From the manifesto's values, we can derive the [agile principles](https://agilemanifesto.org/principles.html) and alter them for hardware:

- Our highest priority is to satisfy the customer through early and continuous delivery.
- Welcome changing requirements, even late in development. Agile processes harness change for the customer's competitive advantage.
- Deliver working hardware frequently, from a couple of weeks to a couple of months, with a preference for the shorter timescale.
- Business people and designers must work together daily throughout the project.
- Build projects around motivated individuals. Give them the environment and support they need, and trust them to get the job done.
- The most efficient and effective method of conveying information to and within a development team is face-to-face conversation.
- Working hardware is the primary measure of progress.
- Agile processes promote sustainable development. The sponsors, developers, and users should be able to maintain a constant pace indefinitely.
- Continuous attention to technical excellence and good design enhances agility.
- Simplicity--the art of maximizing the amount of work not done--is essential.
- The best architectures, requirements, and designs emerge from self-organizing teams.
- At regular intervals, the team reflects on becoming more effective, then tunes and adjusts its behaviour accordingly.

## Agile in Action

At [Halodi Robotics](https://halodi.com/careers), our hardware engineering team follows these agile concepts.
Our teams are cross-functional and not siloed into traditional disciplines (e.g., mechanical team, electrical team).
Every sprint cycle (~2 weeks), we 3D print all the new hardware designed for fit and functional testing.
This continuous feedback allows stakeholders to see physical progress and requirements to be validated.

{{< youtube u8VPIeIAMVQ >}}