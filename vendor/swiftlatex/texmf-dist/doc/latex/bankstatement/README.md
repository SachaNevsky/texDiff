# README #

More and more banks allow their customers to download posting
records in various formats. By using the `bankstatement` class,
you can create bank statements - as long as a csv format is
available! The `csv-mt940` and `csv-camt` formats - used by
many german Sparkassen - are supported. Moreover, it supports
`csv-standard-bank-na`!

Furthermore, the following languages are supported: english,
german, namibian

You can quite easily add support for other languages or csv
formats. Simply define the order of the keys in the csv data
file and how to use them.

The terminology in this class like `BIC` (Business Identifier
Codes) or `IBAN` (International Bank Account Number) is based on
`SEPA` (Single Euro Payments Area). But you can adjust the
terminology to suit your needs.

License: **LPPL**

Changes in v0.9.2:

* use of `siunitx` to force two decimals, if csv data contains
  other formats like `16.2 -> 16.20`

* added support for Standard Bank (Namibia) and namibian

feature requests by Dr. Eberhard Lisse

* organized package in `dtx` format
