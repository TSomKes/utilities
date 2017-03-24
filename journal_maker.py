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
            pass
#            filename_previous = target_filename
        i += 1

    return filename_previous


def GetJournalTemplate(path, date):
    template_path = os.path.join(path, 'templates/template.journal')
    date_string = GetDateString(date) + ' - ' + date.strftime('%a')
    with open(template_path, 'r') as template_file:
        template = template_file.read()
        template = template.replace('[[DATE]]', date_string)
        print(template)

    return template


journals_path = "/home/tsomkes/temp"

# filename_previous = GetFilenamePrevious(journals_path)
# path_previous = None
# if filename_previous:
#     path_previous = os.path.join(journals_path, filename_previous)

today = datetime.datetime.now()
path_today = os.path.join(journals_path, GetDateFilename(today))

tomorrow = today + datetime.timedelta(days=1)
path_next = os.path.join(journals_path, GetDateFilename(tomorrow))

for journal_date in [today, tomorrow]:
    if not FileExists(journals_path, journal_date):
        with open(os.path.join(journals_path,
                               GetDateFilename(journal_date)),
                  'w') as out:
            out.write(GetJournalTemplate(journals_path, journal_date))
