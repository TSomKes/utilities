#! /usr/bin/env python3

from datetime import date
import os

def GetHeading(date):
    heading = str(date)
    w = len(heading)
    heading += '\n' + '=' * len(heading)
    return heading

dirTarget = os.getcwd()

dateToday = date.today()

filename = str(dateToday) + ".py"

fullPath = os.path.join(dirTarget, filename)

if not os.path.isfile(fullPath):
    print(GetHeading(dateToday))
