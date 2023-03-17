---
sections:
- block: hero
  content:
    title: '**Forward-thinking innovation**'
  design:
    background:
      image:
        filename: heroes/engineering-team.jpg
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
    title: Transform Your Hard Tech Vision Into Reality
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
title: Results
type: landing
---
