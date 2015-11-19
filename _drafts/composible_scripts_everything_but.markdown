---
layout: post
title:  "Composible Scripts - Everything but the Last-Step"
categories: blog
---

Composible Scripts - Everything but the Last-Step

Bad:

		python uuiq_xml_to_csv.py AMI\ Poll\ Readings.xml | sqlbong -d , "select c8, c11 from data where c1 = 'A2632549'" | sed 's/ /,/g' | plot-columns.py

> Implicit Open inside plot scripts

Good:

		python uuiq_xml_to_csv.py AMI\ Poll\ Readings.xml | sqlbong -d , "select c8, c11 from data where c1 = 'A2632549'" | sed 's/ /,/g' | plot-columns.py | xargs open

> Explicit Open
