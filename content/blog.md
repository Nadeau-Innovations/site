---
sections:
- block: hero
  content:
    text: Explore the latest trends, strategies, and best practices in hard tech and business innovation
    title: '**Innovative Insights**'
  design:
    background:
      image:
        filename: heroes/cobot.jpg
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
- block: collection
  id: posts
  content:
    count: 5
    filters:
      folders:
        - post
      author: ""
      category: ""
      tag: ""
      publication_type: ""
      featured_only: false
      exclude_featured: false
      exclude_future: false
      exclude_past: false
    offset: 0
    sort_by: 'Date'
    sort_ascending: false
  design:
    view: compact
    columns: '1'
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
