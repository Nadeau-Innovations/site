---
# Documentation: https://wowchemy.com/docs/managing-content/

title: "Hardware in the Loop: Training Robot Contact in an Unstructured Environment"
event: Montréal-Python 85 – Koala Poli
event_url: https://www.meetup.com/Montreal-Python/events/277009455
location:
address:
  street:
  city:
  region:
  postcode:
  country:
summary:
abstract: This talk presents the story and software architecture behind an experimentally tested, machine learning framework for robot contact classification and motion control using a KUKA LBR iiwa robot, gRPC, and Python.

# Talk start and end times.
#   End time can optionally be hidden by prefixing the line with `#`.
date: 2021-04-19T18:00:00
# date_end: 2021-04-18T12:27:58-04:00
all_day: false

# Schedule page publish date (NOT event date).
publishDate: 2021-04-18T12:27:58-04:00

authors: []
tags: [robotics,grpc,scipy,machinelearning,python,datascience,ai,scikitlearn,java,kuka,cobot]

# Is this a featured event? (true/false)
featured: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Custom links (optional).
#   Uncomment and edit lines below to show custom links.
# links:
# - name: Follow
#   url: https://twitter.com
#   icon_pack: fab
#   icon: twitter

# Optional filename of your slides within your event's folder or a URL.
url_slides: 2021-04-19_montreal-python.pdf

url_code:
url_pdf:
url_video: https://www.youtube.com/watch?v=oPycMTPJOCY

# Markdown Slides (optional).
#   Associate this event with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
slides: ""

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---

{{< youtube oPycMTPJOCY >}}

## Transcript

- Project Director @ Halodi Robotics, running our worldwide projects and building the North American HQ in Montréal
- Moonlight as a mentor for Techstars and FounderFuel
- Ph.D. at ÉTS focusing on collaborative robotics + machine learning, and mechanical + biomedical engineering at McGill
- Typically find me at the interface of hardware and software.

---

- I’m fortunate to have the opportunity to work at Halodi Robotics and work on collaborative robotics
- We want to bring robots into the human world instead of changing the world for robots
- This is very different from the typical approach in industrial robotics, where entire factories are built around just the robots, not the humans
- We have the dream of creating helper robots for home and healthcare, but that’s a challenging application
- So we’re taking things step-by-step and are starting with “simpler” applications in the human world, such as security guarding, retail, and food packaging
- But while robotics is full of complex problems, let’s focus on my favourite: physical human-robot interaction

---

- How do we make physical human-robot interaction safe?
- How do we make it safe?
- How do we ensure that when robots collide, contact, and crash into humans, that it’s safe?
- Well, that’s what I tried to solve during my Ph.D., and this guiding question led me to create some weird systems.

---

- The original idea of my research was to perform freehand medical ultrasound on human limbs using collaborative robots
- But I soon realized that just the physical interaction between a probe and the human body was a fascinating problem that needed more attention

---

- Pure motion control is not good enough, and tuning the controller and all the parameters for physical human-robot interaction is not trivial
- And every body part or object with different stiffnesses and properties would need its controller tuning

---

- Then I also thought, “wait, this is an unstructured environment; how does the robot know what it’s in contact with?”
- Can I also train a model to tell the difference between a leg and a table just by touch? How about the difference between a calf, knee, and ankle?

---

- So for a typical machine learning and optimization approach, I would collect a lot of training data, apply it to a model, get some output, update the model, and repeat

---

- But where do I put the robot and the actual hardware in this process?

---

- And how should I implement communication between my Python data science stack and the Java-based controller that the robot uses?

---

- Well, to solve the communications issue, gRPC was the answer
- It allowed me to create a client-server model between the robot and my python stack
- The robot was a “server” in the eyes of the data models and training algorithms
- The function callbacks from the optimization loops would call blocking server functions on the robot, which would make the robot move or do something physical
- The return value was the data collected from the robot’s onboard sensors

---

- For those not familiar with gRPC, we define our service using a language-neutral proto file that can auto-generate boilerplate code in basically every language.
- Python and Java in this case
- It’s a lot of fun because it integrates nicely into CI/CD. All my services and codebases can use the same core proto definition, and their interfaces can stay in sync.
- First, we define a service that contains a set of functions we’d like to call from our client.
- In this example, we have a “RobotService” that has a “Move” command.
- It requires an array of joints as an input and returns a SessionResult message object.
- Those message objects are then defined below.

---

- On the python side, we define a class for our client with the service stub boilerplate

---

- for the actual training and optimization, we can call the robot as if it were a simple function provider
- we connect to the robot through our controller client class and call services whenever we need
- here’s an example of using Scipy’s differential optimization with a simple callback objective function that has the robot run a motion session
- The result of that session may contain a bunch of data from the robot that we then evaluate to obtain a single float value that we’re trying to minimize

---

- And here’s where this particular example was used in real life.
- The human body is a deformable surface and an unstructured environment, a safety concern and a challenge for trajectory planning and control.
- I was trying to optimize for the smoothest, bounce-free motion along a limb while performing ultrasound.

---

- to tune the parameters, differential evolution was used with the robot in the loop
- each time the “evaluate fitness” step is run, that’s the actual robot with the Java controller being called from the scipy optimization function through gRPC to run a session with a given vector of motion settings
- it responds to the python data processing client with a SessionResult filled with force sensor data that then is converted to a single float measure of fitness or quality

---

- Through real-world sessions with a collaborative robot, the framework tuned motion control for optimal and safe trajectories along the human leg phantom.
- Hundreds of sessions were performed,  and generations of candidate solutions were developed

---

- And here we have the result of this particular experiment: smooth motion

---

- So from an experimental design perspective, the big win with something like this is that I can set it and forget it, letting it collect all the data and run its own sessions on its own
- This leads me to one of the simplest and silliest experiments I ever designed...

---

- Guess what I did here...

---

- Yup, I had the robot learn to poke
- Robotic medical ultrasound is an example of a task where simply stopping the robot upon contact detection may not be an appropriate reaction strategy.
- The robot should have an awareness of body contact location to plan force-controlled trajectories along the human body properly
- So Here I made a framework for robot contact classification using robot force sensor data

---

- We wanted to build a classifier model that answered the question: “What was involved in the contact event?”

---

- To gather the data to train the classifier, the robot was programmed to poke until a force condition was triggered with several different scenario types

---

- Built on the same communications architecture where the python data science and machine learning stack treated the robot as a server with callable functions through gRPC
- Once again, the big win with something like this is that I can set it and forget it, letting it collect the training data for me
- I can also quickly test my code by mocking the robot “server” from the client’s perspective
- This allows for a beautiful separation of concerns and a more robust codebase

---

- Back to the application… On the machine learning side, We turned to scikit-learn for a simple, quick, and effective pipeline
- With just half a second of single-axis force data, some preprocessing steps, and a decision tree classifier, we were able to have the robot know WHAT was involved in the contact event, not just that a collision occurred

---

- The code is quite simple too
- Scikit-learn makes it trivial to create and train pipelines, even branching pipelines with multiple preprocessing steps
- This lets us test our hypotheses quickly and effectively

---

- Beyond machine learning applications, I’ve used this python data stack connecting through gRPC to hardware for a variety of applications, including robot calibration with laser systems
- The FARO laser was also controlled with gRPC

---

- And this is why I love this architecture for bringing hardware into the loop: it’s scalable and testable
- All these hardware devices become abstract servers that provide a set of callable functions to a client
- The client doesn’t need to know what they are or how they’re implemented, which makes it great for testing and mocking
- The hardware controllers don’t need to know anything about machine learning, data science, or application stuff; they focus on what they need to do to execute the function properly
- All my interfaces can stay versioned and in sync with autogenerated boilerplate and proto files
- And from a hardware engineering perspective, my experiment design and setup time is significantly reduced through automation and a well-defined interface
