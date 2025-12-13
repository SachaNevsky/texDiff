This package (ab)uses the inline enumeration capabilities of `enumitem` to add
a « displayed » enumeration mode, triggered by adding `gathered` to the key-val
option list of the `enumerate` environment. The end result is similar to a
regular `enumerate` environment wrapped in a `multicols` environment, with the
following advantages:

* gathered enumerate can pack items depending on their actual width rather than
  a fixed, constant number per line.
* gathered enumeration fills items in a line-major order (instead of
  column-major order), which my students found less confusing. YMMV.
