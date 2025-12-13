#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# -*- mode:python -*-
import os
import time
import codecs
from git import Repo
import locale
# Locales for date set up to de_DE
# Please edit to you needs
try:
    locale.setlocale(locale.LC_ALL, 'de_DE.utf8')
except:
    try:
        locale.setlocale(locale.LC_ALL, 'de_DE')
    except:
        print ("Fehler: bitte prüfen Sie das Ergebnis von 'locale -d' und fügen es in das Script ein.")

# set up the git repo
# path is the current working directory
pathrepo = os.getcwd()
repo = Repo(pathrepo)
assert not repo.bare
git = repo.git
headcommit = repo.head.commit
index = repo.index

# get the commited/changed files and date/author/commit
commFiles = git.diff_tree('-r', 'ORIG_HEAD', 'HEAD',
                          no_commit_id=True, name_only=True).split("\n")

# iterate through all files and write the gfi help-files
for fl in commFiles:
    flname, flext = os.path.splitext(fl)
    if flext == '.tex':
        rawdate = int(git.log('-1', fl, pretty='format:"%at"').split('"')[1])
        date = [time.strftime("%d. %B %Y %H:%M", time.localtime(rawdate)),
                time.strftime("%d", time.localtime(rawdate)),
                time.strftime("%m", time.localtime(rawdate)),
                time.strftime("%Y", time.localtime(rawdate)),
                time.strftime("%H", time.localtime(rawdate)),
                time.strftime("%M", time.localtime(rawdate))]
        author = [git.log('-1', fl, pretty='format:"%an"').split('"')[1],
                  git.log('-1', fl, pretty='format:"%ae"').split('"')[1]]
        commit = [git.log('-1', fl, pretty='format:"%H"').split('"')[1],
                  git.log('-1', fl, pretty='format:"%h"').split('"')[1]]
        f = codecs.open(flname+".gfi", "w", encoding="utf-8")
        f.write("% gitfile-info control file\n")
        f.write("\\gfiSetDate{" + date[1] + "}{" + date[2] + "}{" + date[3]
                + "}{" + date[4] + "}{" + date[5] + "}{" + date[0] + "}\n")
        f.write("\\gfiSetAuthor{" + author[0] + "}{" + author[1] + "}\n")
        f.write("\\gfiSetCommit{" + commit[0] + "}{" + commit[1] + "}")
        f.close
