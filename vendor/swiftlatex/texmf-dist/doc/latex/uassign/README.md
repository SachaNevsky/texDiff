Version:	1.01
Date:		September 23, 2015
Author:		Nathan Esau
Package:	uassign

# Overview

## Description

The purpose of the uassign package is to provide simple question and solution
style environments for typesetting university assignments. The uassign package
was designed with the following objectives in mind:

* Simplicity: uassign package is small and easy to modify
* Hide environments: ability to produce a question sheet (questions only) and
  solution sheet (solutions only) or both. This is done by passing the
  hidequestion or hideanswers option to the package
* Flexibility: the uassign package doesn't create conflicts with other packages,
  such as hyperref when included. Commands which could cause conflicts with
  other packages are used only when certain options are passed to the uassign
  package

Environments:	question, solution, example, exsolution, definition
Commands:		ientry
Options:		hidequestions, hideanswer, assignheader, notesheader, links
Packages used:	ifthen, hyperref, bookmark, color, enumerate, amsmath, amsthm,
				fancyhdr, titlesec
