#!/usr/bin/env python3

import argparse
from calendar import monthrange
import datetime
import os.path
import sys


def GetDateTemplate(date):

    # 2017-03-01 - Wed
    # ----------------
    #
    #
    header = '{0} - {1}\n'.format(date.strftime('%Y-%m-%d'), date.strftime('%a'))
    header += '----------------\n\n\n'
    header += '    [ ]\n\n\n'

    return header


def GetFilename(year, month):

    # March: '03', not '3'
    filename = str(year) + '-' + str(month).zfill(2) + '.txt'

    return filename


def GetFileText(year, month):
    text = "{0}-{1} - Journal\n".format(str(year), str(month).zfill(2))
    text += "=================\n\n\n"
    text += '    [ ]\n\n\n'

    date_start = datetime.datetime(year, month, 1)
    days_in_month = monthrange(year, month)[1]

    date = date_start
    for i in range(days_in_month):
        date = date_start + datetime.timedelta(days=i)
        text += GetDateTemplate(date)

    return text


if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument('year')
    parser.add_argument('month')
    parser.add_argument('path')

    args = parser.parse_args()

    year = int(args.year)
    month = int(args.month)
    path = args.path

    filename = GetFilename(year, month)

    full_path = os.path.join(path, filename)

    # File already exists?  Done and done.
    if os.path.exists(full_path):
        sys.exit(0)

    with open(full_path, 'w') as out:
        out.write(GetFileText(year, month))
