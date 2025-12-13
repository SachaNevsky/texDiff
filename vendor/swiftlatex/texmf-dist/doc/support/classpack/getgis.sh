%%
%% This is file `getgis.sh',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% classpack.dtx  (with options: `lxp')
%% This file was generated from an XML master source.
%% Amendments and corrections should be notified to the
%% maintainer for inclusion in future versions.
%%
%% Reusable XML
%%
%% In , I said that one of the benefits of using XML for software
%% generation and documentation was the re-usability of the data. Here
%% are a couple of simple examples.
$ lxprintf -e productname "%s\n" . classpack.xml |\
  sort | uniq -c | sort -k 1nr
%%
%% Checking that all element types have been described!

\endinput
%%
%% End of file `getgis.sh'.
