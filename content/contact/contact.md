---
widget: contact
headless: true  # This file represents a page section.

# ... Put Your Section Options Here (title etc.) ...
title: Contact Me
subtitle: ''
weight: 10

content:
  # Automatically link email and phone or display as text?
  autolink: true

  # Email form provider
  form:
    provider: netlify
    formspree:
      id:
    netlify:
      # Enable CAPTCHA challenge to reduce spam?
      captcha: true

  # Contact details (edit or remove options as required)
#   email: test@example.org
#   phone: 888 888 88 88
  address:
    street: 1275 Av. des Canadiens-de-Montréal
    city: Montréal
    region: QC
    postcode: H3B 0G4
    country: Canada
    country_code: CA
  coordinates:
    latitude: '45.496'
    longitude: '-73.570'
#   directions: Enter Building 1 and take the stairs to Office 200 on Floor 2
#   office_hours:
#     - 'Monday 10:00 to 13:00'
#     - 'Wednesday 09:00 to 10:00'
#   appointment_url: 'https://calendly.com'
  contact_links:
    - icon: twitter
      icon_pack: fab
      name: Twitter
      link: 'https://twitter.com/EngNadeau'
    - icon: linkedin
      icon_pack: fab
      name: LinkedIn
      link: 'https://www.linkedin.com/in/engnadeau'

design:
  # Choose how many columns the section has. Valid values: '1' or '2'.
  columns: '2'
---
