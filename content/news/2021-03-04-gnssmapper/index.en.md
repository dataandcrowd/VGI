---
title: 'gnssmapper: A new python package released'
author: Hyesop Shin
date: '2021-03-04'
slug: gnssmapper
categories:
  - Package
tags:
  - python
  - gnss
  - package
subtitle: ''
summary: ''
authors: []
lastmod: '2021-03-04T07:39:37Z'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
---

## gnssmapper: our new package

A few days ago, our team member Terry has release a python package [`gnssmapper`](https://pypi.org/project/gnssmapper/).
`gnssmapper` creates 3D maps from gnss (Global Navigation Satellite System) data via Andriod mobile devices. The package is written in python and relies on [GeoPandas](https://geopandas.org/) objects.

## What does it do?
The gnssmapper package:
* reads 'raw' GNSS data from Google's gnsslogger app, available for Android phones
* processes data into a set of observations
* estimates building heights based on the observations
* simulates observations for algorithm testing

Note: It does not include any functionality for processing GNSS data in order to estimate position, and assumes position data is available from the log file, or calculated elsewhere.

## Further enquiries
For further enquiries, please contact Terry (terence.lines@glasgow.ac.uk).