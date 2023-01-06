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
        parallax: true
        position: bottom
        size: cover
      text_color_light: true
    spacing:
      padding:
      - 200px
      - "0"
      - 200px
      - "0"
- block: portfolio
  id: press
  content:
    filters:
      tags: [press]
      kinds:
        - page
    sort_by: 'Date'
    sort_ascending: false
  design:
    columns: '1'
    view: Compact
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
        parallax: true
        position: center
        size: cover
      text_color_light: true
title: Press
type: landing
---
