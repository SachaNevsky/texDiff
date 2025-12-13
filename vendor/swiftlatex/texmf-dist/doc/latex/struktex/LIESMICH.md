StrukTeX - Zeichnen von Nassi-Shneidermann-Struktogrammen
=========================================================

Das LaTeX-Paket `StrukTeX` stellt Makros zur Erzeugung von
Nassi-Shneidermann-Struktogrammen bereit.

Das Paket besteht aus sechs Dateien:
* `LIESMICH`             - diese Datei
* `README`               - diese Datei in einer englischen Version
* `struktex.dtx`         - der Quellcode des Paketes integrierter
                           zweisprachiger Dokumentation
* `struktex.ins`         - das Installationsskript

Installation
------------

Mit
    tex struktex.ins
werden weitere Dateien erzeugt:

 * `struktex.sty`         - das eigentliche Paket
 * `struktex.el`          - eine Stil Datei zur Benutzung mit AUCTeX

 * `strukdoc.sty`        \
 * `struktxf.sty`        |
 * `struktxp.sty`        |
 * `struktex-test-0.nss` |- Dateien für die Formatierung der
 * `struktex-test-1.tex` |  Dokumentation
 * `struktex-test-2.tex` |
 * `struktex-test-3.tex` |
 * `struktex-test-4.tex` /

 * `struktex.makemake`    - Skript zur Erstellung der Datei `Makefile`
                           aus der Datei
 * `struktex.mk`

Mit
    pdflatex struktex.dtx
    makeindex -s gind.ist struktex.idx
    pdflatex struktex.dtx
    pdflatex struktex.dtx
wird dann die formatierte deutschsprachige Dokumentation erzeugt.

Für die Formatierung der Dokumentation werden neben den genannten
Dateien die folgenden Pakete benötigt:
 * `color`
 * `hyperref`
 * `ifthen`
 * `nameref`
 * `pict2e` (empfohlen) oder `curves` oder `emlines`
 * `url`

Abschließend müssen die Dateien `struktex.sty`, struktxf.sty`,
`struktxp.sty`, `struktex.el` (emacs-AUCTeX-Unterstützung)
und `struktex.pdf` in die üblichen Verzeichnisse kopiert werden.

Weitere Informationen sind der Dokumentation zu entnehmen.

Hinweise auf Fehler nehme ich genauso wie Vorschlaege fuer die weitere
Entwicklung gerne entgegen unter j.hoffmann |at| fh-aachen.de.

Diese Dateien unterliegen der LaTeX Project Public License.
Vgl. http://www.ctan.org/tex-archive/help/Catalogue/licenses.lppl.html
zu Details dieser Lizenz.
