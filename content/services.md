---
sections:
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Hero
- block: hero
  content:
    cta:
      label: Get Started
      url: /contact
    text: Expert fractional CTO support tailored to your needs
    title: "**Unlock Your Team's Potential**"
  design:
    background:
      image:
        filename: heroes/collaborating.jpg
        filters:
          brightness: 0.6
        parallax: false
        position: center
        size: cover
      text_color_light: true
    spacing:
      padding:
      - 200px
      - "0"
      - 200px
      - "0"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Key Service Offerings
- block: features
  content:
    items:
    - description: Align technology, people, and processes to achieve outstanding results
      icon: users-cog
      icon_pack: fas
      name: Set Your Team Up for Success
    - description: Drive innovation, boost morale, and share knowledge through expert guidance
      icon: lightbulb
      icon_pack: fas
      name: Empower Your Team
    - description: Optimize your technology strategy and development to scale faster
      icon: rocket
      icon_pack: fas
      name: Accelerate Your Growth
    title: Comprehensive Solutions for Hard Tech Innovation
  id: fractional-cto
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# TODO: Testimonials
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Events and Past Talks
# TODO: better if this was after Success Stories
- block: hero
  content:
    cta:
      label: Schedule a Talk
      url: /contact
    cta_alt:
      label: See Past Events
      url: /event
    text: Empower your team with insights and expertise from past events
    title: Inspiring Talks and Events
  design:
    background:
      image:
        filename: milan.jpg
        filters:
          brightness: 0.6
        parallax: false
        position: center
        size: cover
      text_color_light: true
    spacing:
      padding:
      - 200px
      - "0"
      - 200px
      - "0"
  id: speaking
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Success Stories
- block: portfolio
  content:
    title: Success Stories
    default_button_index: 0
    filters:
      folders:
      - project
      kinds:
      - page
    sort_ascending: false
    sort_by: Date
  design:
    columns: "1"
    flip_alt_rows: true
    view: showcase
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Final CTA Section
- block: hero
  content:
    cta:
      label: Let's Talk
      url: /contact
    title: Ready to Elevate Your Hard Tech Innovation?
    text: Get in touch for a tailored strategy to achieve your goals
  design:
    background:
      image:
        filename: heroes/collaborating.jpg
        filters:
          brightness: 0.6
        parallax: false
        position: center
        size: cover
      text_color_light: true
title: Services
type: landing
---
