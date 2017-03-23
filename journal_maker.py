#!/usr/bin/env python3


import datetime
import os.path


def GetDateString(date):
    return date.strftime('%Y-%m-%d')


def GetDateFilename(date):
    return GetDateString(date) + '.journal'


def FileExists(path, date):
    filename = GetDateFilename(date)
    filepath = os.path.join(path, filename)
    return os.path.exists(filepath)


# To be used someday when I want to port over undone todos
def GetFilenamePrevious(path):
    filename_previous = None

    date = datetime.datetime.now()

    max_days = 30
    i = 0
    while not filename_previous and i < max_days:
        date += datetime.timedelta(days=-1)
        if FileExists(path, date):
            filename_previous = target_filename
        i += 1

    return filename_previous


def GetJournalTemplate(date):
    return '''{0} - {1}
================

    'sup?
    

    Todo
    ----

    [ ] example
    
    
    Retro
    -----
    
    
    ### Task 1'''.format(GetDateString(date), date.strftime('%a'))


journals_path = "/home/tsomkes/temp"

#filename_previous = GetFilenamePrevious(journals_path)
#path_previous = None
#if filename_previous:
#    path_previous = os.path.join(journals_path, filename_previous)

today = datetime.datetime.now()
path_today = os.path.join(journals_path, GetDateFilename(today))

tomorrow = today + datetime.timedelta(days=1)
path_next = os.path.join(journals_path, GetDateFilename(tomorrow))

for date in [today, tomorrow]:
    if not FileExists(journals_path, date):
        with open(os.path.join(journals_path, GetDateFilename(date)), 'w') as out:
            out.write(GetJournalTemplate(date))
