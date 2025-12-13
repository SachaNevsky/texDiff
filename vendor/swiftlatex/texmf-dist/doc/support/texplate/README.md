# TeXplate

![Language: Kotlin](https://img.shields.io/badge/Language-Kotlin-blue.svg?style=flat-square)
![Minimum JRE: 8.0](https://img.shields.io/badge/Minimum_JRE-8.0-blue.svg?style=flat-square)
![Current version](https://img.shields.io/badge/dynamic/json.svg?color=blue&label=Latest%20release&query=%24.0.name&url=https%3A%2F%2Fgitlab.com%2Fapi%2Fv4%2Fprojects%2F13793875%2Frepository%2Ftags&style=flat-square)

TeXplate is a tool for creating document structures based on templates. The application name is a word play on _TeX_ and _template_, so the purpose seems quite obvious: we want to provide an easy and straightforward framework for reducing the typical code boilerplate when writing TeX documents. Also note that one can easily extrapolate the use beyond articles and theses: the application is powerful enough to generate _any_ text-based structure, given that a corresponding template exists.

## Basic use

Our tool is a typical command line application, so we need to invoke it by simply typing `texplate` in the terminal:

```bash
$ texplate 
 ______         __   __          ___             __             
/\__  _\       /\ \ /\ \        /\_ \           /\ \__          
\/_/\ \/    __ \ `\`\/'/'  _____\//\ \      __  \ \ ,_\    __   
   \ \ \  /'__`\`\/ > <   /\ '__`\\ \ \   /'__`\ \ \ \/  /'__`\ 
    \ \ \/\  __/   \/'/\`\\ \ \L\ \\_\ \_/\ \L\.\_\ \ \_/\  __/ 
     \ \_\ \____\  /\_\\ \_\ \ ,__//\____\ \__/.\_\\ \__\ \____\
      \/_/\/____/  \/_/ \/_/\ \ \/ \/____/\/__/\/_/ \/__/\/____/
                             \ \_\                              
                              \/_/                              

TeXplate 1.0.2, a document structure creation tool
Copyright (c) 2020, Island of TeX
All rights reserved.

Missing required option '--output=<output>'
Usage: texplate [-c=<configuration>] -o=<output> [-t=<template>]
                [-m=<String=String>...]...
  -c, --config=<configuration>
                          The configuration file in which the tool
                            can read template data, for automation
                            purposes. Make sure to follow the correct
                            specification when writing a
                            configuration file.
  -m, --map=<String=String>...
                          The contextual map that provides the data
                            to be merged in the template. This
                            parameter can be used multiple times. You
                            can specify a map entry with the
                            key=value syntax (mind the entry
                            separator).
  -o, --output=<output>   The output file in which the chosen
                            template will be effectively written.
                            Make sure the directory has the correct
                            permissions for writing the output file.
  -t, --template=<template>
                          The template and. The tool will search both
                            user and system locations and set the
                            template model accordingly, based on your
                            specs.
```



Provided that TeXplate is properly available in the underlying operating system, we will get a lovely, colorful output in our terminal, along with a couple of scary messages telling that some required options are missing. Our tool provides four options, described as follows. Strictly speaking, there is only one mandatory option. The remainder might be optional, depending on certain scenarios.

### Output

Referred as either`-o` (short representation) or `--output` (long representation), this option holds the output file in which the chosen template will be effectively written. The name is arbitrary, so you can use anything to your heart's desires. Keep in mind, however, that an existing file will be mercilessly overwritten. Also, make sure the path has the proper permissions for writing the output file.

### Template

Referred as either `-t` (short representation) or `--template` (long representation), this option holds the reference to the template to be potentially merged with data and properly generated. The provided string should match the template identifier, otherwise TeXplate will raise an error complaining about the missing reference.

### Map

Referred as either `-m` (short representation) or `--map` (long representation), this option holds a map entry, defined as a `key=value` ordered pair (mind the `=` symbol used as entry separator). This option can be used multiple times. The map entry denotes a variable in the template context, where the key is the variable name and the value is set to be the initial state of such variable.

## Examples

For instance, let us generate a document named `doc1.tex`, based on the standard `article` class:

```bash
$ texplate -t article -o doc1.tex
 ______         __   __          ___             __             
/\__  _\       /\ \ /\ \        /\_ \           /\ \__          
\/_/\ \/    __ \ `\`\/'/'  _____\//\ \      __  \ \ ,_\    __   
   \ \ \  /'__`\`\/ > <   /\ '__`\\ \ \   /'__`\ \ \ \/  /'__`\ 
    \ \ \/\  __/   \/'/\`\\ \ \L\ \\_\ \_/\ \L\.\_\ \ \_/\  __/ 
     \ \_\ \____\  /\_\\ \_\ \ ,__//\____\ \__/.\_\\ \__\ \____\
      \/_/\/____/  \/_/ \/_/\ \ \/ \/____/\/__/\/_/ \/__/\/____/
                             \ \_\                              
                              \/_/                              

TeXplate 1.0.2, a document structure creation tool
Copyright (c) 2020, Island of TeX
All rights reserved.

Configuration file mode disabled .................. [ DONE ]
Entering full command line mode ................... [ DONE ]

Please, wait...

Obtaining reference ............................... [ DONE ]
Composing template ................................ [ DONE ]
Validating data ................................... [ DONE ]
Merging template and data ......................... [ DONE ]

Done! Enjoy your template!
Written: 112 B
```

And that is it! We provided the template name (`-t article`) and the output (`-o doc1.tex`). Checking the contents of `doc1.tex`:

```tex
\documentclass{article}

\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}

\begin{document}

\end{document}
```

We could enhance the template generation by providing further options to it. Let us say we want to include A4 as the paper size for our document and use XeTeX as engine. The command line is as follows (we omitted the full output for reducing verbosity):

```bash
$ texplate -t article -o doc2.tex -m options=a4paper -m xetex=true
```

For this example, we added two map entries referring to the class option and the support for newer engines (please refer to the user manual for more details on template options). The newly generated `doc2.tex` document is as follows:

```tex
\documentclass[a4paper]{article}

\usepackage{fontspec}

\begin{document}

\end{document}
```

Now, let us provide some packages to our document, as well as language support:

```bash
$ texplate -t article -o doc3.tex -m options=a4paper -m xetex=true \
-m babel=spanish,english -m packages=longtable,siunitx,array
```

Checking the contents of `doc3.tex`:

```tex
\documentclass[a4paper]{article}

\usepackage{fontspec}

\usepackage[spanish,english]{babel}

\usepackage{longtable}
\usepackage{siunitx}
\usepackage{array}

\begin{document}

\end{document}
```

And that is it! Make sure to take a look at the user manual to learn more about TeXplate!

## License

This application is licensed under the [New BSD License](https://opensource.org/licenses/BSD-3-Clause). Please note that the New BSD License has been verified as a GPL-compatible free software license by the [Free Software Foundation](http://www.fsf.org/), and has been vetted as an open source license by the [Open Source Initiative](http://www.opensource.org/).

## The team

TeXplate is brought to you by Ben Frank and Paulo Cereda. If you want to support TeX development by a donation, the best way to do this is donating to the [TeX Users Group](https://www.tug.org/donate.html).

