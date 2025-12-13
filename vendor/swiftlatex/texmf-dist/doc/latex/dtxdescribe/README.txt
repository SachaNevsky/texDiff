The LaTeX dtxdescribe package
Describe additional object types in dtx source files.

v1.01 — 2019/03/22
Copyright 2016–2019 Brian Dunn — www.BDTechConcepts.com
LaTeX Project Public License, version 1.3

The doc package includes tools for describing macros and environments in
LATEX source dtx format. The dtxdescribe package adds additional tools for
describing booleans, lengths, counters, keys, packages, classes, options, files,
commands, arguments, and other objects.

Each item is given a margin tag similar to \DescribeEnv, and is listed in
the index by itself and also by category. Each item may be sorted further by
an optional class. All index entries except code lines are hyperlinked.

Descriptions are best accompanied by examples, so the environment
dtxexample is provided. Contents are displayed verbatim along with a
caption and cross-referencing. They are then \input and executed, and the
result is shown.
