---
# Documentation: https://wowchemy.com/docs/managing-content/

title: "Decoded: Tesla Bot and AI Day"
subtitle: ""
summary: ""
authors: []
tags: []
categories: []
date: 2022-10-07T09:04:31-04:00
lastmod: 2022-10-07T09:04:31-04:00
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: Top
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---

TODO: gifs
- 17:34 entrance and reveal
- 19:45 tasks and semantic and manipulation
- 20:25 "working at Fremont factory"
- "off the shelf actuators" in current proto demo
- same production technique as tesla, high volume, low cost
- less than 20k$ if millions of units
- 28dof
- battery pack looks like Spot; changeable?
- everything integrated into battery pack; sensors etc; using vehicle + energy experience and existing techs to make this more efficient to develop, manufacturing, and cooling, and safety
- leverage existing supply chain and manufacturing channels
- 35:30 FEAs focused on robot damage control; what about human contact?
- 37:30 knee joint not back driveable; efficient and effective design, but what about intrinsic safety?
- actuators similar to powertrain designed for tesla
- 41:00 simulation
- 43:00 roller screws and actuators and clutch; define these things for the reader
  - https://en.wikipedia.org/wiki/Roller_screw
  - https://www.ewellix.com/en/products/ball-and-roller-screws/roller-screws/planetary-roller-screws
  - https://www.moog.com/products/linear-motion/screws/planetary-roller-screws.html
  - https://en.wikipedia.org/wiki/Clutch
  - integrated force and torque sensors
- strain wave gearing and use gif
  - https://en.wikipedia.org/wiki/Strain_wave_gearing
- 44:20 lifting piano
- non backdriveable fingers
- clutches made to remove need to keep motors on; reduce power consumption
- 47:55 software and navigation
  - cars avoid everything, robots should interact with everything; how do we merge software and navigation autopilot approaches?
  - split problem in two? a global navigation problem then refine to a local interaction problem?
- 48:50 keypoint vslam navigation
  - not end to end visual navigation?
- 13 months 1 week August 19, 2021 – September 30, 2022
- 49:00 walking sim
  - only 5mo between first steps and toe off
  - Propulsion (or toe off) is the final stage of the stance phase. It begins immediately as the heel lifts off the ground. During propulsion the foot becomes supinated, allowing the structure of the midfoot to brace tightly producing a rigid lever effect.
  - https://www.footbionics.com/Patients/The+Gait+Cycle.html
- really appreciate how the engineers themselves present their work
  - 50:20 eg Felix and walking
  - empowers the team to stand by their work and be able to explain it to the masses
    -   If you can't explain it simply, you don't understand it well enough.  Albert Einstein
-   55:30 natural motion references using human demonstration and XR trackers
    - HTC vive body trackers https://www.lifewire.com/set-up-full-body-tracking-on-htc-vive-5216963
    - MOCAP
    - NOT SCALABLE? not true imitation learning
- What's next: focus on their factories
  - lets them iterate and hide blemishes internally
  - lets them build their own volume before public release, like AWS
  - lets them focus on a narrow scope for navigation and manuipulation to get a useful rbotus robot early rather than a mediocre jack of all trades robot
- 57:00 barely 6-8mo for all of this
- 10k+ GPUs for autolabelling of Tesla vehicle data
  - shared with robot team?
    - big advantage
- 1:48:45 procedural simulation using collected ground truth data from autolabelling team
- for young engineers learning ML frameworks, hint hint, pytorch should be your goto
- Q&A
- "fastest path to a useful robot that can be made at volume" - elon 2:30:00
  - internally at tesla factories
  - very sure that design and architecture will go through several revisions
    - hence getting it tested in the real world asap to get feedback
      - great product development lesson: target good enough; get feedback; iterate
        - don't wait for perfection
        - Reid Hoffman's quote — “If you are not embarrassed by the first version of your product, you've launched too late.” — is a great example of loss of intent.
- social robotics is a future enhancement/problem, not a short term focus
  - actuators and tasks come first
- localized control ROM that can't be updated over the intenet
  - localized stop buttons and controls
  - prevent terminator
- Similar to AWS, Dojo and teslabot will start as internal tools that scale up to the point where public release can subsidize their cost and crreate new revenue streams
- Start with simple tasks, eg loading parts, carry from one end of the factoy, etc
  - BLS material movers
    - even just 1 robot for every 100 humans is 60k robots
      - to put in perspective, there's only around 3.5M industrial robots in the world
        - https://www.automation.com/en-us/articles/october-2022/ifr-presents-world-robotics-report-2022
        - that's just one application of humanoid robots
      - number of useful situations will grow exponentially; start small and focused
- three to five year target is reasonable if scope is focused

Every big tech reveal has its partisan commentators that will argue back and forth about the merits of the technology, but it might be timely that Tesla AI Day coincided with the [text message dump from the Twitter v. Elon debacle](https://time.com/6218578/elon-musk-texts-twitter/), because if we ask the question, ***what did you get done this week?***, well, in the case of Tesla, quite a bit.

There has already been a flood of articles and thoughtpices about the bot, [some salty and negative](https://spectrum.ieee.org/robotics-experts-tesla-bot-optimus), [others pure hype](https://ca.finance.yahoo.com/news/tesla-optimus-robot-change-world-182110412.html?guccounter=1).
Let's take a more nuanced look at the event and the robot.

{{< youtube ODSJsviD_SU >}}

## The Event

Let start with the elephant in the room: a biped prototype robot was revealed, it appeared to work well enough for a demo, and the hype continues.
There's no deyning that Tesla AI Day is more than just a tech event; its a markerting and recruitment event.

On the financial marketing side, it appears that Elon has impeccable timing, hosting the uplifting event just before [poor Q3 results and other negative news](https://electrek.co/2022/10/04/tesla-tsla-plunges-elon-musk-agrees-buy-twitter/).

From a recruitment perspective, its an incredible opportunity to showcase the team, foster FOMO, and build in public.
The team definitely deserves kudos for their accomplishments and the velocity at which they executed.

<iframe src="https://www.linkedin.com/embed/feed/update/urn:li:share:6982076559851483136" allowfullscreen="" title="Embedded post" width="504" height="559" frameborder="0"></iframe>

Finally, aside from the recruitment angle, I don't believe the event was meant to impress expert engineers and roboticists.
Instead, there is a different target audience, the type of audience that helps maintain the hype, [generate over $10B in revenue through Model 3 preorders](https://www.theguardian.com/technology/2016/apr/04/tesla-motors-sells-10bn-model-3-two-days), and pumps the stock such that it has a P/E ratio of 10x Toyota.

{{< tweet user="EngNadeau" id="1576035850625814528" >}}

## Overall Design

I'm gonna do a full writeup on the actuator system tonight, wanna go deep and see what we can understand, the first prototype is Apptroniks system and not really tesla, 2nd prototype is really interesting

TLDR: Teslabot is a classical humanoid that focuses on stiff position control with force/torque sensing, most of their focus seems to be on the robustness and reliability of stiff systems in contacts. It is about 1/5 the power to weight of Aria, it is not designed for dynamic motions and contacts, does not have any sensible path to safety, and power efficiency is going to be very bad. I would not write them off as they have shown how fast they can iterate and have “unlimited” money, but they did not solve anything yet on the hardware side, and the software for walking is a replica of the Asimo controller from 2007 (ZMP with heelstrike/toe-off).


## Controls, Mobility, and Locomotion



The gait looked very wobbly?

They choose the direction of planetary roller plus force sensor which makes their robot jerky and not natural.

On the locomotion side their work does not (yet!) look very impessive to me. Their gait is quite slow and not very dynamic. It is hard to say exactly what kind of control algorithms they are using but it loos like it could be one of the quite dated Zero Moment Point or Capture Point criterias that used to be very popular a while ago. But it does certainly not look cutting edge compared to some recent demonstrations  of bipedal locomotion on Atlas or Cassie for example.

Aslo it has bend knees and impacts very softly

No straight leg impact

They also seem to use 6 DoF per leg and therefore can walk fully actuated.

@Toni Garcia it is possible to maintain balance and a fixed position if the system is fully actuated for some joint position/velocity combinations. But usually the stability margin (the range of disturbances the system can handle) would be very small there.

Yeah, I meant loss of actuation due to the clutch. So fully locked.

Super curious why they want it.

Agree. Trading off safety and stability to safe some energy here and there just seems like a bad idea.

maybe they just lock some of them for performing manipulation, but also there that would not be ideal I think

That is why I am not sure whether it really makes sense to use a clutch there. I would assume their will be some delay when you want to reactivate a certain joint which is generally not nice for stabilizing the robot. Interesting design choice for sure.

The first that stands out is the lack of a Y-axis in the torso, this will limit the robot's ability to work while sitting on its knees or a chair in addition to leaning over counters that are above hip-y height.

These numbers generally make sense for a humanoid in their size and weight and are comparable to other “classical humanoids” like Honda-Asimo, UBTech-Walker, DLR-Toro, and IIT-Walkman. What stands out is the very high knee/hip torque which is smart when relying on ZMP-style walking (always in balance). It also follows that there is no way they are reaching their original goal of 54kg with these actuators.

The advantage of this system is that the friction reduces the need for active holding torque, and Tesla also claims it wants to use the clutches to reduce power in holding torque. This comes back to the system being built for static, not dynamic, balance and motions. When you lock the joints in your upper body to save power while holding a large mass, you lose controllability. You would normally like to use that large mass to help you balance and to make your gait more efficient. This also comes down to how much the robot will be standing in the corner vs doing work, I’m a bit surprised that they so openly talk about optimizing for not doing work.

## Manipulation

the sequence where the robot grabs the watering can is quite impressive if that's a realistic result (and not just 100 attempts)

28 DoF , not including hands. hands not backdriveable so they can maintain a grasp for extended periods of time. the thumb has more than one DoF it seems. The hand is really strong, they had a standalone hand demo mounted on a stick and it seems to be more or less minituarized in the hand itself, and it is very strong. i was able to pick up a coke can and turn it upside down without any slippage in the grasp.


The magic of friction. With high friction pads on the fingers, the force applied by the fingers need to be less than without high friction materials for picking up the same object.

We'll have those pads

Also hard to say how impressed we sould be on the few manipulation tasks they showed. If that translated to a wide range of objects it would be very impressive but it could also be that they ust got them work for these select few controlled tasks by tuning the knobs and datasets. Any opinions on that?

This looks like staged precomputed trajectories without any significant contacts or external wrenches. Which is trivial for any system, so doesn't really tell us anything

 However, despite the added footage from the robot’s sensors, we have no idea how this was actually done—whether it was autonomous or not, or how many tries it took to get right. There’s also a clip of a robot picking up an object and attempting to place it in a bin, but the video cuts right before the placement is successful. This makes me think that we’re seeing carefully curated best-case scenarios for performance.

## Safety

this version looks decent... if they dress it then it would look pretty good (ignoring the nasty pinch points in arms).

weight goal of 73kg... oof

Do graphs of weight vs impact energy

Nothing back drivable. Clamping hazards

as a product designer it shocks me how much other robotics companies just blatantly ignores pinch points

There seem to be no thoughts currently around the large reflected inertia, the mass of the robot (73kg), or pinch-points when it comes to human safety.


## Supply Chain and Cost
Price point of 20k USD, do we believe that?

the development platform uses off the shelf actuators, but the latest uses their own (but couldn't balance or hold its own weight yet)

Their price targe is really ambitious, the cost target should be even lower that 20K USD (they might want to earn money 😅 ). I'm not sure they believe in this target, I have my reservations. But they can squeeze the supply chain a lot, and Tesla has so many products at high volume.

Cost of harmonic drives is a well known issue even in high volumes, the patents expired and prices vary from 400$-1.500$ for component sets depending on load capability and quality/backlash.

Planetary rollers are generally more complex and expensive than ball screws as the rollers and screws need to be very precisely ground after hardening to match and mesh nicely with rolling contact. This will clearly drive the cost of the system.


## Motors and Actuation
I don't understand motors well, but this seems more complicated than ours right?
Based on the rotation speeds of the different stages in the motor on the left it seemed like it has a really high gear ratio, or am I seeing wrong?
and if so, does this mean that it's not soft like ours?

Yes, high gear ration with mechanical locking, weather it's a clutch for the rotary or (maybe, not sure) self locking wedge effect for the ball screw.

0 compliance

Very interesting that they added a clutch and high gear ratio since with high gear ratio the holding torque required to e.g. compensate gravity while standing should be much lower than with a low gear ratio motor 🤔

I assume it's for holding weights in the upper body, basically arms

It makes "sense" from a power efficiency standpoint in the hips/torso when carrying objects but requires classical stable gaits

how will these respond when you bump the robot? I guess it's stiff and not softly moving with the motions?

If they do this, then yes. The apptronik system the started with is semi-compliant through series elastic

chatted with some of their hand / motor people. the new prototype doesn't have any wires, so it's hard to know what the wiring layout looks like

their motor housings are heavy but i was told that the motor housing doubles as structural support for the whole robot

We do that as well. Our advantage is that they need a lot of steel for the gearing, and that is very heavy. We don't :)

The hardware stack is overall very traditional, the fact that actuators passively locks makes the robot inheritely unsafe and not backdrivable, but they can maintain position without power consumption (caveat: you cannot mantain position and balance, @michael agree?)

This is a modern HarmonicDrive variable impedance actuator, originally pioneered by DLR in the DLR-Arm (2003) and later Toro robots. This was commercialized through the Kuka LWR series robots and formed the basis for the Franka Panda, which was made by a breakout group from Kuka. Honorable mentions that also did a lot of work in this space is IIT (Walkman). The novel part here is the contact-less torque sensor, torque sensors have traditionally been the reliability problem for these drives and also suffer from drift over time. But even if they solved that problem the inherent actuator dynamics has the same problems.

SHOW GIFS OF MY PHD

Generally, high positioning accuracy requires high stiffness at the price of high robot mass relative to its payload. In contrast, the robotic systems developed at DLR (arms, hands, a humanoid manipulator) are designed for interaction with humans in unstructured, everyday environments. In such applications, high absolute positioning accuracy cannot be exploited due to limited accuracy of position information about the surrounding environment, while its side-effects in design (high stiffness and mass) are clearly undesired. However, the robots are operated at relatively low velocities compared to industrial robots, thus enabling higher gear ratios. The main requirements for the electronic design result from the high number of sensors, such as joint torque sensors, redundant position sensing, and wrist force-torque sensing.

The basic concept here is you can get away with masking your inertia by using your torque sensor and motor to detect collision forces and control them as long as you move slowly. Inner loop joint torque controllers are used to reduce the negative effects of high motor inertia and friction due to the gears. The system is still stiff enough to do high-speed movements in non-collision states, but cannot do high-speed collisions as that is outside of the controllable bandwidth. StrainWave gearing has large hysteresis and friction in addition to sinusoidal torque ripple, requiring high reliance/gains on the torque sensor, adding phase delays and further decreasing bandwidth. When asked about the bandwidth, the engineer did not want to answer, and Elon claimed bandwidth of more like 10-20Hz than 1 Hz, which would be normal for this type of system in low load conditions (bandwidth drops exponentially with load). This is the same system as used in the Honda Asimo and UBTech Walker. The mention of contactless torque sensors is interesting as drift and reliability issues have generally plagued torque sensors in these systems.

If your gear is 20% efficient, you need to provide 5x the torque at your motor, and motor losses follow torque squared, further driving inefficiencies. They also use cross-roller bearings, which, while being very stiff, have significant friction. This will reduce the efficiency even further. I would be very surprised if they manage anything above 20-50% system efficiency on these actuators.

A planetary roller screw has rollers on the nut side, as shown in Figure 2, or on the shaft side, as shown in Figure 3. The threaded rollers are placed between a shaft (inner screw) and a nut (outer screw), providing more contact points than balls. Ball screws are primarily suitable for drive mechanisms that give priority to efficiency and transparency, whereas planetary roller screws are suitable when high load capacity, long service life, and high speed are required. Tesla is here choosing to sacrifice dynamic performance and efficiency for impact proofing and reliability. The torque transparency and compliance of roller screws are very similar to StrainWave gears as described in the previous chapter, although slightly better as they are a function of efficiency. The potential for jamming rollers creates very large ripples on torque.


## Software, Perception, and AI

the software story seems less mature, they seem to be making a lot of similar high level design choices as FSD = perception + planning. their choice to do mocap retargeting is kind of interesting, curious why they didn't just do teleop

They are good at talking😄. My impression is that the hardware is very immature and underwhelming. The software seemed really good

We can also see that they went for a static neck relying on the cameras to cover the FOV. This will obviously limit HRI, but also cause some occlusion problems as the cameras should translate forward on looking down to increase useful FOV.

## Batteries

The fact that they integrated so many electronics in the battery pack, and that they packaged so much energy inside that volume is also impressive. I'm tempted to think that the robot will be heavier than the forty something kg they targeted last year, but I don't have data to back up.

Current weight spec seems to be 73 kg.

I’m guessing the torso cavity they have is significantly larger than ours, which is why they can fit such a large battery pack. Looks like the same form factor cells and a pretty standard configuration, even though the tried to make it sound new and exciting. Integrating electronics like that is standard for all smaller battery packs, but not in EVs.

I wonder if they’re heavy weight offsets the large capacity compared to our smaller capacity and lighter robot

I think I heard they also integrate some level of sensing electronics in there

They also have some buffy fans for the BP

When she says sensing, she’s just describing what every BMS does, sensing the state of the battery pack in terms of voltages, currents, temperatures etc.

The fans might very well not be for the battery, unless they consume way more power than they presented, the pack shouldn’t need it. Perhaps some compute is bolted to it as well?

I’m sure they’re battery will have quite good kWh/kg and kW/kg ratios though

I think battery + PDB might get hot enough?

I assumed there is some compute in the BP when she said sensing

Unless they have what we call compute in there, which would be pretty cool, it should just be a BMS. I think they probably have those fans to cool something other than the battery 😊

@Fredrik Larsen our battery is 400 Wh from memory, is that right. Also curious about their power consumption when they have a 2300Wh battery..

It's a different order of magnitude, so I think we should look into this

I read somewhere they provide "24h service with one charge"

Close, a bit over 500Wh, I agree though, I’m slightly concerned that the input I was given for required capacity might have been too optimistic. The next step up in capacity for us would be around 750Wh.
With our current envelope, there is no space for a larger pack,  but we could potentially make it with a slightly larger back.

I assume Aria will be more power efficient than Optimus, due to different actuators (less friction), and significantly lower weight.

Also, I assume Optimus have some serious on board compute, dissipating quite some power, while Aria has kinda minimal on board compute.

Let's see that. I still remember the day Jesper smiled at me and told me he wants a 200W computer 🫠

## Product Market Fit

 Ignoring that last bit about changing the entire economy, and possibly also ignoring the time frame because “next few months or years” is not particularly meaningful, the push to make Tesla Bot useful is another substantial advantage that Tesla has. Unlike most companies working on humanoid robots, Tesla is potentially its own biggest customer, at least initially, and having these in-house practical tasks for the robot to train on could really help accelerate development.

 BLS material movers and security
