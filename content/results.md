---
sections:
- block: hero
  content:
    title: '**Forward-thinking innovation**'
  design:
    background:
      image:
        filename: engineering-team.jpg
        filters:
          brightness: 0.6
        parallax: true
        size: cover
      text_color_light: true
    spacing:
      padding:
      - 200px
      - "0"
      - 200px
      - "0"
- block: portfolio
  content:
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
- block: hero
  content:
    cta:
      label: Let's Talk
      url: /contact
    title: Ready to get started?
  design:
    background:
      image:
        filename: engineer.jpg
        filters:
          brightness: 0.6
        parallax: true
        position: top
        size: cover
      text_color_light: true
title: Results
type: landing
---
