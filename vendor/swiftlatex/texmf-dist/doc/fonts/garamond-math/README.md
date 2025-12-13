<!-- README for CTAN -->
# Garamond-Math Ver. 2019-08-16

Garamond-Math is an open type math font matching the [EB Garamond (Octavio Pardo)](https://github.com/octaviopardo/EBGaramond12/) and [EB Garamond (Georg Mayr-Duffner)](https://github.com/georgd/EB-Garamond).
Many mathematical symbols are derived from other fonts (see below), others are made from scratch. The metric is generated with a python script.

## Notes

- *Important notes for this version* 
    - Massive metric adjustment. Now the metric is much closer to that of text.
    - Now it should work with LuaTeX
    - Added larger oprators etc;
    - Reimport Fraktur from [Noto Sans Math](https://github.com/googlefonts/noto-fonts/).

- Stylistic sets: (`StylisticSet={#1,#2,...}` in [`unicode-math`](https://ctan.org/pkg/unicode-math?lang=en) package)

    - `1` → XITS Blackboard `\mathbb`.
    - `2` → Curved `\partial`, which is in style with almost all other fonts.
    - `3` → CM `\mathcal` (lowercase unavailble)
    - `4` → Use semi-bold for `\symbf`
    - `5` → Use extra-bold for `\symbf`
    - `6` → horizontal "bar" for `\hbar`
    - `7` → `\int` variant
    - `8` → Garamond-compatible `\mathcal` (experimental)
    - `9` → `\tilde` variant
    - `10` → out-bending italic h
    - `11` → larger operators

## Known Issue
- Various spacing problems. Though math fonts technically should not be kerned, some pairs looks very ugly (Ex. `VA`); sometimes sub/superscript may also have same problem.
- Fake optical size. EB Garamond does not contain a complete set of glyphs (normal + bold + optical size of both weights). The "optical size `ssty`" is made by interpolating different weights at the present (without this, the double script is too thin to be readable). 

## Technical Staff
- Issues, bug reports, forks and other contributions are welcome. Please visit [GitHub](https://github.com/YuanshengZhao/Garamond-Math/) for development details.

## License

This Font Software is licensed under the [SIL Open Font License](http://scripts.sil.org/OFL), Version 1.1.


