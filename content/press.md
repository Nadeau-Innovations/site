---
sections:
- block: hero
  content:
    text: Company news, editorial features, and press releases.
    title: '**Press and Newsroom**'
  design:
    background:
      image:
        filename: news.jpg
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
    filters:
      kinds:
      - page
      tags:
      - press
    sort_ascending: false
    sort_by: Date
  design:
    columns: "1"
    view: Compact
  id: press
- block: hero
  content:
    cta:
      label: Let's Talk
      url: /contact
    title: Ready for your next project?
  design:
    background:
      image:
        filename: marker.jpg
        filters:
          brightness: 0.6
        parallax: false
        position: center
        size: cover
      text_color_light: true
title: Press
type: landing
---