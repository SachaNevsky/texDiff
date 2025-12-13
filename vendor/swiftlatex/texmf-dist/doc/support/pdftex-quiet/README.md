# pdftex-quiet

This is a tool in BASH serving to reduce the output of `pdftex` command and see only relevant errors in red bold font to fight them ASAP.

Originally, I've started this as [the TeX StackExchange answer](https://tex.stackexchange.com/a/459470/134632).

Currently, [you can find this repository in a Comprehensive TeX Archive Network (CTAN)](https://ctan.org/pkg/pdftex-quiet) under `/support/pdftex-quiet`.

## Quickinstall the latest version

```bash
curl -s https://gitlab.com/jirislav/pdftex-quiet/raw/latest/pdftex-quiet | \
	sudo tee /usr/local/bin/pdftex-quiet >/dev/null \
	&& sudo chmod +x /usr/local/bin/pdftex-quiet \
	&& sudo ln -sf /usr/local/bin/pdf{,la}tex-quiet
```

## Installation from git

Download this repository:

```bash
git clone https://gitlab.com/jirislav/pdftex-quiet.git
cd pdftex-quiet
```

Simply copy the bash script to your `$PATH`:

```bash
cp pdftex-quiet /usr/local/bin/
chmod +x /usr/local/bin/pdftex-quiet

# Make sure we support also pdflatex-quiet command (pdflatex is also a symlink to pdftex command)
ln -sf /usr/local/bin/pdf{,la}tex-quiet
```

## Usage

Usage is the same as with `pdftex` and `pdflatex` (it supports all the arguments except the `[COMMANDS]`, **but the filename is mandatory!**).

```bash
# Keep in mind that the last argument should always be the filename to compile 
# and it's mandatory! (unless you only want to print a help)
pdftex-quiet --output-format dvi --output-directory=/tmp my_tex_source.tex

# Print help
pdftex-quiet --help

# But most probably you simply want to run the pdftex without modifications:
pdftex-quiet my_tex_source.tex

# Also you might want to use LaTeX instead:
pdflatex-quiet my_tex_source.tex
```

## Licence

See the `LICENCE` file.

## Credits

This [project's avatar](https://www.shareicon.net/warning-attention-error-notice-signs-signaling-815477) was designed by [Flaticon](https://profile.flaticon.com/license/free).
