---
title: "Evolutionary Motion Control Optimization in Physical Human-Robot Interaction"
date: 2018-10-01
publishDate: 2019-11-16T19:04:18.676185Z
authors: ["Nicholas A. Nadeau", "I. A. Bonev"]
publication_types: ["1"]
abstract: ""
featured: false
publication: "*2018 IEEE/RSJ International Conference on Intelligent Robots and Systems (IROS)*"
tags: ["biomedical ultrasonics","evolutionary computation","force control","human-robot interaction","medical robotics","motion control","optimisation","phantoms","trajectory control","evolutionary motion control optimization","medical freehand ultrasound","trajectory planning","optimal trajectories","human leg phantom","physical human-robot interaction","online tuning","collaborative robot","medical ultrasound motion","parallel force-impedance control","differential evolution","phri","mean absolute error","ultrasonic imaging","task analysis","tuning","legged locomotion","force","robot kinematics","control", "environment", "evolution", "force", "interaction", "motion", "phri", "robots", "trajectory", "ultrasound"]
doi: "10.1109/IROS.2018.8593598"
abstract: "Given that the success of an interaction task depends on the capability of the robot system to handle physical contact with its environment, pure motion control is often insufficient. This is especially true in the context of medical freehand ultrasound where the human body is a deformable surface and an unstructured environment, representing both a safety concern and a challenge for trajectory planning and control. The systematic tuning of practical high degree-of-freedom physical human-robot interaction (pHRI) tasks is not trivial and there are many parameters to be tuned. While traditional tuning is generally performed *ad hoc* and requires knowledge of the robot and environment dynamics, we propose a simple and effective online tuning framework using differential evolution (DE) to optimize the motion parameters for parallel force/impedance control in a pHRI and medical ultrasound motion application. Through real-world experiments with a KUKA LBR iiwa 7 R800 collaborative robot, the DE framework tuned motion control for optimal and safe trajectories along a human leg phantom. The optimization process was able to successfully reduce the mean absolute error of the motion contact force to 0.537N through the evolution of eight motion control parameters."

url_pdf: "https://www.researchgate.net/publication/330591310_Evolutionary_Motion_Control_Optimization_in_Physical_Human-Robot_Interaction"
url_source: "https://ieeexplore.ieee.org/document/8593598"


aliases:
- /publication/nadeau-2018-evolutionary
- /publication/2018/10/nadeau-2018-evolutionary
---

## Design

![The  high-level  steps  of  differential  evolution](featured.png)

The  high-level  steps  of  differential  evolution  (DE): (1) A population of candidate solution vectors is initialized;(2)  Mutations  are  generated  for  each  candidate;  (3)  The mutations  are  crossed  with  the  original  candidates;  (4)  The fitness of the crossed candidates is scored; (5) The population is updated based on the scored fitness. Steps 2-5 are repeated until a convergence criterion is met.

## Results

![Evolutionary Motion Control](kuka-evo_1.gif)

![Evolutionary Motion Control](kuka-evo_4.gif)

## Presentations

This work has been featured in [Python meetup talks]({{< ref "event/2021/4/hardware-in-the-loop-training-robot-contact-in-an-unstructured-environment" >}}) and [IEEE webinars]({{< ref "event/2021/10/ieeeembs-robotics-webinar" >}}):

{{< youtube oPycMTPJOCY >}}

{{< youtube bpuirrU7Ovo >}}
