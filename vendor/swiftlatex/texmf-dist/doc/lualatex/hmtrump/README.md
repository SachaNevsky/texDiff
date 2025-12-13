# hmtrump Package

## What is this?

You will be able to describe playing cards using *hmtrump* package.
**This package needs LuaLaTeX**.

sample.tex is sample file.

## How to use?

1. Install NKD04 Playing Card's Index font
1. \usepackage{hmtrump} in preamble
1. To describe cards, use \trump{*rank*}{*suit*}

+ *rank*: 1 to 9, T (meaning 10), J, Q, K
+ *suit*: S (Spade), H (Hard), D (Diamond), C (Club), x (no suits)

## Manual

[hmtrump.pdf](hmtrump.pdf) is manual, written in Japanese.

## 日本語でok

トランプのルールを TeX で執筆する人に向けて作ったパッケージです。
トランプのカードの記号を手軽に出力することができます。
[hmtrump-sample.tex](hmtrump-sample.tex) がサンプルファイルになっています。

[hmtrump.pdf](hmtrump.pdf) がマニュアルです。ご一読ください。

### 使い方

**LuaLaTeX** を必要とします（fontspec パッケージを内部で読み込みます）。

まずはじめに、同梱の NKD04 Playing Card's Index フォントをインストールしてください。

プリアンブルに \usepackage{hmtrump} と書けば使用することができます。

トランプのカードを出力するには \trump{*rank*}{*suit*} とします。
*rank* は 1〜9 の数字または T(10), K, Q, J を指定し、*suit* には S, H, D, C, x
（スペード、ハート、ダイヤ、クラブ、スートなし）を指定します。

その他提供される命令はマニュアルを参照してください。

## License

このパッケージに含まれる成果物は、クリエイティブ・コモンズ 表示--継承
ライセンスの元で配布を行う。

This package is licensed under a Creative Commons Attribution-ShareAlike
4.0 International License.

NKD04 Playing Card's Index フォントのライセンスは、配布元で示されている通りの
条件に従う。すなわち、商用私用問わず自由に使用でき、配布元
[http://hwm3.gyao.ne.jp/shiroi-niwatori/nishiki-teki.htm](http://hwm3.gyao.ne.jp/shiroi-niwatori/nishiki-teki.htm)
を示せば再配布も可能である。原文は[ここ](./nkd04_playing_cards_index/LICENSE)を参照。

NKD04 Playing Card's Index is licensed under following;
There is no restriction on using NKD04 Playing Card's Index regardless
of private or commercial, and it is possible to redistribute this.
In the case of redistribution, please specify this distribution source
([http://hwm3.gyao.ne.jp/shiroi-niwatori/nishiki-teki.htm](http://hwm3.gyao.ne.jp/shiroi-niwatori/nishiki-teki.htm)).
For further information, pleas see [here](./nkd04_playing_cards_index/LICENSE).
