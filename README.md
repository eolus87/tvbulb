# tvbulb
Wall colour projection based on content of the screen. This project has two main
goals:
1) Developing the SW to either access the content of the screen of a computer 
running windows or in the best case scenario, directly the frame buffer of the GPU.
2) Developing the required HW to send the colors to an addressable array of RGB 
LED lights.

## Background
According to [Wikipedia](https://en.wikipedia.org/wiki/Bias_lighting), Bias 
lighting is a weak light source on the backside of a screen that illuminates
the wall or surface behind and just around the display.

Philips started integrating a similar technology they called "Ambilight" in 
some of their TVs by 2002. A screen or monitor is the ideal place to integrate
this kind of technology as they have a frame buffer that they will feed with
color data before passing it to the panel itself.

## Motivation
Philips implementation of Ambilight has been always restricted to a narrow 
range of their TVs. The response times of this backlighting system was not
great with no further control for the user and no option for any interface 
or API to make any further use of this data.

There are several implementations of 3rd party Bias Lighting. One of the most
promising ones using a Raspberry Pi, an HDMI to AV converter and a frame grabber: 
[Instructables Ambilight](https://www.instructables.com/DIY-Ambilight-With-Raspberry-Pi-and-NO-Arduino-Wor/).
The problem with these are the amount of conversions and devices involved, the
delay in all conversions...

This project was born as a way of trying to get the best of all systems. 
Allowing Ambilight experience, with easier configuration, less moving parts
and higher performance.
