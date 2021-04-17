---
abstract: |
  Modern robotic applications often rely on offline programming to reduce process downtime. In a virtual environment, robot application specialists may program, visualize, and test their robotic application before uploading it to the real production environment, saving time and costs. However, to achieve a high level of fidelity between virtual and production environments, the robot system must be accurate.

  Unfortunately, even though most industrial robots are inherently precise (i.e., repeatable), they are not necessarily very accurate. One cost-effective approach to obtaining a more accurate robot is through calibration, where the actual kinematic and non-kinematic parameters of the robot model are identified and improved upon when compared to the nominal model. This talk introduces pybotics, an open-source Python toolbox for robot kinematics and calibration. The talk will feature the following topics:

  - An introduction to modern industrial robotics
  - Spatial descriptions and transformations
  - Robot kinematics
  - Robot calibration with pybotics + NumPy + SciPy
date: "2017-11-19T00:00:00-05:00"
draft: false
event: PyCon Canada
event_url: https://2017.pycon.ca/schedule/53/
header:
  caption: ""
  image: ""
highlight: true
location: Université du Québec à Montréal
address:
  street: 405 Rue Sainte-Catherine Est
  city: Montréal
  region: QC
  postcode: H2L 2C4
  country: Canada
math: false
projects: []
selected: false
summary: ""
tags:
- robotics
- python
- mechanical
time_start: "2017-11-19T11:00:00-05:00"
title: 'Domo arigato, Mr. Roboto: Calibrating Robots with Python'
url_code: https://github.com/nnadeau/pybotics/
url_pdf: https://github.com/nnadeau/pycon-canada-2017
url_slides: https://github.com/nnadeau/pycon-canada-2017
url_video: ""
aliases:
- /talk/pycon-canada-2017
---

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Why we should calibrate <a href="https://twitter.com/hashtag/robots?src=hash&amp;ref_src=twsrc%5Etfw">#robots</a> and introduction to cool library pyrobotics in <a href="https://twitter.com/hashtag/Python?src=hash&amp;ref_src=twsrc%5Etfw">#Python</a> via <a href="https://twitter.com/EngNadeau?ref_src=twsrc%5Etfw">@EngNadeau</a> at the <a href="https://twitter.com/pyconca?ref_src=twsrc%5Etfw">@pyconca</a> <a href="https://twitter.com/hashtag/PyConCA2017?src=hash&amp;ref_src=twsrc%5Etfw">#PyConCA2017</a> <a href="https://twitter.com/hashtag/Montreal?src=hash&amp;ref_src=twsrc%5Etfw">#Montreal</a> <a href="https://t.co/wivyNGr8bp">pic.twitter.com/wivyNGr8bp</a></p>&mdash; Abhishek Gupta (@atg_abhishek) <a href="https://twitter.com/atg_abhishek/status/932285250734120960?ref_src=twsrc%5Etfw">November 19, 2017</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="instagram-media" data-instgrm-captioned data-instgrm-permalink="https://www.instagram.com/p/BcGcITxlv0M/" data-instgrm-version="8" style=" background:#FFF; border:0; border-radius:3px; box-shadow:0 0 1px 0 rgba(0,0,0,0.5),0 1px 10px 0 rgba(0,0,0,0.15); margin: 1px; max-width:658px; padding:0; width:99.375%; width:-webkit-calc(100% - 2px); width:calc(100% - 2px);"><div style="padding:8px;"> <div style=" background:#F8F8F8; line-height:0; margin-top:40px; padding:50.0% 0; text-align:center; width:100%;"> <div style=" background:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACwAAAAsCAMAAAApWqozAAAABGdBTUEAALGPC/xhBQAAAAFzUkdCAK7OHOkAAAAMUExURczMzPf399fX1+bm5mzY9AMAAADiSURBVDjLvZXbEsMgCES5/P8/t9FuRVCRmU73JWlzosgSIIZURCjo/ad+EQJJB4Hv8BFt+IDpQoCx1wjOSBFhh2XssxEIYn3ulI/6MNReE07UIWJEv8UEOWDS88LY97kqyTliJKKtuYBbruAyVh5wOHiXmpi5we58Ek028czwyuQdLKPG1Bkb4NnM+VeAnfHqn1k4+GPT6uGQcvu2h2OVuIf/gWUFyy8OWEpdyZSa3aVCqpVoVvzZZ2VTnn2wU8qzVjDDetO90GSy9mVLqtgYSy231MxrY6I2gGqjrTY0L8fxCxfCBbhWrsYYAAAAAElFTkSuQmCC); display:block; height:44px; margin:0 auto -44px; position:relative; top:-22px; width:44px;"></div></div> <p style=" margin:8px 0 0 0; padding:0 4px;"> <a href="https://www.instagram.com/p/BcGcITxlv0M/" style=" color:#000; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:normal; line-height:17px; text-decoration:none; word-wrap:break-word;" target="_blank">A little snapshot of my 🤖 #robot #calibration + 🐍 #python #talk at #PyConCA2017</a></p> <p style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; line-height:17px; margin-bottom:0; margin-top:8px; overflow:hidden; padding:8px 0 7px; text-align:center; text-overflow:ellipsis; white-space:nowrap;">A post shared by <a href="https://www.instagram.com/engnadeau/" style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:normal; line-height:17px;" target="_blank"> Nicholas Nadeau, P.Eng., AVS</a> (@engnadeau) on <time style=" font-family:Arial,sans-serif; font-size:14px; line-height:17px;" datetime="2017-11-30T01:16:32+00:00">Nov 29, 2017 at 5:16pm PST</time></p></div></blockquote> <script async defer src="//www.instagram.com/embed.js"></script>

<blockquote class="instagram-media" data-instgrm-captioned data-instgrm-permalink="https://www.instagram.com/p/Bbt_-1JF4rI/" data-instgrm-version="8" style=" background:#FFF; border:0; border-radius:3px; box-shadow:0 0 1px 0 rgba(0,0,0,0.5),0 1px 10px 0 rgba(0,0,0,0.15); margin: 1px; max-width:658px; padding:0; width:99.375%; width:-webkit-calc(100% - 2px); width:calc(100% - 2px);"><div style="padding:8px;"> <div style=" background:#F8F8F8; line-height:0; margin-top:40px; padding:50% 0; text-align:center; width:100%;"> <div style=" background:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACwAAAAsCAMAAAApWqozAAAABGdBTUEAALGPC/xhBQAAAAFzUkdCAK7OHOkAAAAMUExURczMzPf399fX1+bm5mzY9AMAAADiSURBVDjLvZXbEsMgCES5/P8/t9FuRVCRmU73JWlzosgSIIZURCjo/ad+EQJJB4Hv8BFt+IDpQoCx1wjOSBFhh2XssxEIYn3ulI/6MNReE07UIWJEv8UEOWDS88LY97kqyTliJKKtuYBbruAyVh5wOHiXmpi5we58Ek028czwyuQdLKPG1Bkb4NnM+VeAnfHqn1k4+GPT6uGQcvu2h2OVuIf/gWUFyy8OWEpdyZSa3aVCqpVoVvzZZ2VTnn2wU8qzVjDDetO90GSy9mVLqtgYSy231MxrY6I2gGqjrTY0L8fxCxfCBbhWrsYYAAAAAElFTkSuQmCC); display:block; height:44px; margin:0 auto -44px; position:relative; top:-22px; width:44px;"></div></div> <p style=" margin:8px 0 0 0; padding:0 4px;"> <a href="https://www.instagram.com/p/Bbt_-1JF4rI/" style=" color:#000; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:normal; line-height:17px; text-decoration:none; word-wrap:break-word;" target="_blank">#pyconca2017 Montréal</a></p> <p style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; line-height:17px; margin-bottom:0; margin-top:8px; overflow:hidden; padding:8px 0 7px; text-align:center; text-overflow:ellipsis; white-space:nowrap;">A post shared by <a href="https://www.instagram.com/paulywill/" style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:normal; line-height:17px;" target="_blank"> Paul W. Gamble</a> (@paulywill) on <time style=" font-family:Arial,sans-serif; font-size:14px; line-height:17px;" datetime="2017-11-20T13:28:47+00:00">Nov 20, 2017 at 5:28am PST</time></p></div></blockquote> <script async defer src="//www.instagram.com/embed.js"></script>

<blockquote class="instagram-media" data-instgrm-captioned data-instgrm-permalink="https://www.instagram.com/p/Bbrt8XBjF-3/" data-instgrm-version="8" style=" background:#FFF; border:0; border-radius:3px; box-shadow:0 0 1px 0 rgba(0,0,0,0.5),0 1px 10px 0 rgba(0,0,0,0.15); margin: 1px; max-width:658px; padding:0; width:99.375%; width:-webkit-calc(100% - 2px); width:calc(100% - 2px);"><div style="padding:8px;"> <div style=" background:#F8F8F8; line-height:0; margin-top:40px; padding:50.0% 0; text-align:center; width:100%;"> <div style=" background:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACwAAAAsCAMAAAApWqozAAAABGdBTUEAALGPC/xhBQAAAAFzUkdCAK7OHOkAAAAMUExURczMzPf399fX1+bm5mzY9AMAAADiSURBVDjLvZXbEsMgCES5/P8/t9FuRVCRmU73JWlzosgSIIZURCjo/ad+EQJJB4Hv8BFt+IDpQoCx1wjOSBFhh2XssxEIYn3ulI/6MNReE07UIWJEv8UEOWDS88LY97kqyTliJKKtuYBbruAyVh5wOHiXmpi5we58Ek028czwyuQdLKPG1Bkb4NnM+VeAnfHqn1k4+GPT6uGQcvu2h2OVuIf/gWUFyy8OWEpdyZSa3aVCqpVoVvzZZ2VTnn2wU8qzVjDDetO90GSy9mVLqtgYSy231MxrY6I2gGqjrTY0L8fxCxfCBbhWrsYYAAAAAElFTkSuQmCC); display:block; height:44px; margin:0 auto -44px; position:relative; top:-22px; width:44px;"></div></div> <p style=" margin:8px 0 0 0; padding:0 4px;"> <a href="https://www.instagram.com/p/Bbrt8XBjF-3/" style=" color:#000; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:normal; line-height:17px; text-decoration:none; word-wrap:break-word;" target="_blank">Learning from Nicholas Nadeau about debugging robots with Python at #PyConCA2017.</a></p> <p style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; line-height:17px; margin-bottom:0; margin-top:8px; overflow:hidden; padding:8px 0 7px; text-align:center; text-overflow:ellipsis; white-space:nowrap;">A post shared by <a href="https://www.instagram.com/myles/" style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:normal; line-height:17px;" target="_blank"> Myles Braithwaite</a> (@myles) on <time style=" font-family:Arial,sans-serif; font-size:14px; line-height:17px;" datetime="2017-11-19T16:12:41+00:00">Nov 19, 2017 at 8:12am PST</time></p></div></blockquote> <script async defer src="//www.instagram.com/embed.js"></script>
