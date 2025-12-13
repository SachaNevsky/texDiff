#!/usr/bin/env python
# -*- coding: ISO-8859-1 -*-


# Preprocessor for serto font for the use with LaTeX.
# Copyright 2001-2013 by Johannes Heinecke
# you can use this and change it as you wish, under the condition
# that the original copyright line is not deleted

# Last changes:
#  2 Nov 2003: major reconstruction, use of three fontfiles
#  12 July 2003: correction on stretch
#  29 September 2007: Possibility to typeset two identical letters without a qusshaya
#  31 March 2013: add SERTOFONTDIR environment variable

FONTFILESERTO="serto.font" # specify absolute path
FONTFILECHALD="assyr.font"
#FONTFILEESTR="estrangelo.font"

# use the environment variable SERTOFONTDIR to specify the directory of the *.font files

import re, sys, string, os.path

# translating syriac unicode points to serto codings

class Letter:
    def __init__(self, 
		 coding, # what coding to use in .ptex-file
		 name,   # name of the letter
		 isolated, # what character to take in isolated usage
		 initial, # what character to take in word-initial usage
		 medial,  # what character to take in word-medial usage
		 final,  # what character to take in word-final usage
		 link): # does it link to the following (# link 0: next letter is initial, 1: next letter is medial, 2: ignore,  8: character is a superscript symbol  9: character is a subscript symbol
	self.coding = coding
	self.name = name
	self.isolated = map(int, isolated.split('+'))
	self.initial = map(int, initial.split('+'))
	self.medial = map(int, medial.split('+'))
	self.final = map(int, final.split('+'))
	self.link = int(link)
	
	if self.isolated[0] == -1: self.isolated = None
	if self.initial[0] == -1: self.initial = None
	if self.medial[0] == -1: self.medial = None
	if self.final[0] == -1: self.final = None
	#sys.stderr.write("%s:%s-%s-%s-%s\n" \
	#		 % (name,self.isolated,self.initial,self.medial,self.final))
	
    def getcontext(self, ctx):
	if ctx == 0: return   self.isolated[0]
	elif ctx == 1: return self.initial[0]
	elif ctx == 2: return self.medial[0]
	elif ctx == 3: return self.final[0]

    def getChar(self, ctx):
	if ctx == 0: 
	    if not self.isolated: return ['']
	    return map(lambda x: "%c" % x, self.isolated)
	    #return int(self.isolated[0])
	elif ctx == 1: 
	    if not self.initial: return ['']
	    return map(lambda x: "%c" % x, self.initial)
	    #return int(self.initial[0])
	elif ctx == 2: 
	    #sys.stderr.write("MEDIAL %s\n" % self.medial)
	    if not self.medial: 
		#sys.stderr.write("NONE:e\n")
		return ['']
	    return map(lambda x: "%c" % x, self.medial)
	    #return int(self.medial[0])
	elif ctx == 3:
	    if not self.final: return ['']
	    return map(lambda x: "%c" % x, self.final)
	    #return int(self.final[0])

class Serto:
    def __init__(self, elatex=0):
	self.elatex=elatex # eLaTeX needs \TeXXeTstate=1
	self.tabelle = {} # style: {"_d": Letter-Object}
	self.transtabelle = {} # style: "_d": \d{d}
	self.usingUTF8 = False

	self.inlineS = re.compile("(<S>)(.*?)(</S>)")
	self.inlineT = re.compile("(<T>)(.*?)(</T>)")
	self.inlineST = re.compile("(<ST>)(.*?)(</ST>)")

	self.inlineC = re.compile("(<C>)(.*?)(</C>)")
	self.inlineCT = re.compile("(<CT>)(.*?)(</CT>)")

	self.inlineE = re.compile("(<E>)(.*?)(</E>)")
	self.inlineET = re.compile("(<ET>)(.*?)(</ET>)")

	self.tabelle["serto"] = {}
	self.transtabelle["serto"] = {}
	self.readfont(FONTFILESERTO, 
		      self.tabelle["serto"],
		      self.transtabelle["serto"])
	#print  self.tabelle["serto"]

	self.tabelle["chaldean"] = {}
	self.transtabelle["chaldean"] = {}
	self.readfont(FONTFILECHALD, 
		      self.tabelle["chaldean"],
		      self.transtabelle["chaldean"])

	self.UnicodeTable = { 0x0710: "'",
		0x0712: "b",
		0x0713: "g",
		0x0714: "g", #gamal garshuni
		0x0715: "d",
		0x0717: "h",
		0x0718: "w",
		0x0719: "z",
		0x071a: ".h",
		0x071b: ".t",
		0x071c: ".t", # teth garshuni
		0x071d: "y",
		0x071f: "k",
		0x0720: "l",
		0x0721: "m",
		0x0722: "n",
		0x0723: "s",
		0x0724: "s", # final semkath
		0x0725: "`",
		0x0726: "p",
		0x0728: ".s",
		0x0729: "q",
		0x072a: "r",
		0x072b: "^s",
		0x072c: "t",
		0x0308: "P", # syame 
		0x0730: "a",
		0x0731: "A",
		0x0732: ":a",
		0x0733: "=a",
		0x0734: "=A",
		0x0735: ":=a",
		0x0736: "e",
		0x0737: "E",
		0x0738: ":e",
		0x0739: ":e",
		0x073a: "i",
		0x073b: "I",
		0x073c: ":i",
		0x073d: "u",
		0x073e: "U",
		0x073f: ":u",
		0x0740: ":=a",
		0x0741: "*",
		0x0742: "+",
		#punctuation listed in unicode not completed implemented in serto
		0x0700: ".:.",
		0x0701: ".",
		0x0702: ".",
		0x0703: ":",
		0x0704: ":",
		0x0705: ":",
		0x0706: ":",
		0x0707: ":",
		0x0708: ":",
		0x0709: ":",
		0x070D: ".X.",
	}
	

	#print "zzzzzz",UnicodeTable

    def readfont(self, filename, tabelle, transtabelle):
	dirname = os.environ.get("SERTOFONTDIR")
	if not dirname:
		dirname = os.path.dirname(sys.argv[0])
	#print "eeee", dirname
	fp = open("%s/%s" % (dirname, filename), "r") 
	lines = fp.readlines()
	fp.close()


	#self.tabelle = {} # "_d": (isol, init, med, fin, link)
	#self.tabelle = {} # "_d": Letter-Object
	#self.transtabelle = {} # "_d": \d{d}
	self.fontname = ""
	status = "syriac"
	self.errct = 0
	for z in lines:
	    if len(z) < 2:
		continue
	    if z[0] == "#":
		if z[:6] == "#FONT:":
		    a = string.split(z)
		    self.fontname = string.strip(a[1])
		    #self.textframe.thetext.config(font=self.fontname)
		    #self.testlabel.config(font=self.fontname)
		elif z[:7] == "#TRANS:":
		    status = "transliterate"
		continue

	    felder = string.split(z)
	    if status == "syriac":
		if len(felder) < 7:
		    self.errct = self.errct + 1
		    print "ERROR:", z
		else:
		    #print z, int(felder[2])
		    #self.tabelle[felder[0]] = (int(felder[2]), 
			#		       int(felder[3]), 
			#		       int(felder[4]),
			#		       int(felder[5]),
			#		       int(felder[6]))
		    tabelle[felder[0]] = Letter(felder[0], 
						felder[1], 
						felder[2], 
						felder[3], 
						felder[4],
						felder[5],
						felder[6])
	    else:
		if len(felder) < 2:
		    #print "WARNING:", z
		    transtabelle[felder[0]] = felder[0]
		else:
		    transtabelle[felder[0]] = felder[1]


    def tokenize(self, str, xlen, style="serto"):
	ix = 0
	self.tokens = []
	self.digits = []
	number = 0 # 

	while(ix < xlen): #for ix in range(xlen):
	    #print "IX", ix, str
	    if str[ix] == "\\":
		command = "\\"
		ix = ix + 1
		while(ix < xlen):
		    if not str[ix] in string.letters:
			break
		    else:
			command = command + str[ix]
			ix = ix + 1
		self.tokens.append(command)
	    elif str[ix] in "{}":
		self.tokens.append(str[ix])
		ix = ix + 1
	    else:
		for ll in range(5, 0, -1):
		    if self.tabelle[style].has_key(str[ix:ix+ll]):
			if ll == 1 and str[ix:ix+ll] in "aeiou" \
			   and (len(self.tokens) == 0 \
				or self.tokens[-1] == "~"):
			    #self.tokens.append("'" + str[ix:ix+ll])
			    self.tokens.extend(["'", str[ix:ix+ll]])
			    #pass
			else:
			    if len(self.tokens) \
			       and str[ix:ix+ll] == self.tokens[-1] \
			       and self.tabelle[style][str[ix:ix+ll]].link != 3 \
			       and str[ix:ix+ll] not in ["~", "0", "1", 
							 "2", "3", "4", 
							 "5", "6", "7", 
							 "8", "9", "--"]:
				# insert shadda
				self.tokens.append("Q")
			    else:
				self.tokens.append(str[ix:ix+ll])
			ix = ix + ll
			break # for-loop
		else:
		    ix = ix + 1
	
	#print "TOKENS",self.tokens

    def transtokenize(self, str, xlen, style="serto"):
	ix = 0
	self.tokens = []
	self.digits = []
	number = 0 # 
	while(ix < xlen): #for ix in range(xlen):
	    #print "IX", ix,
	    for ll in range(5, 0, -1):
		if self.transtabelle[style].has_key(str[ix:ix+ll]):
		    if ll == 1 and str[ix:ix+ll] in "aeiou" \
		       and (len(self.tokens) == 0 \
			    or self.tokens[-1] == "~"):
			self.tokens.append("'" + str[ix:ix+ll])
			#self.tokens.extend(["'", str[ix:ix+ll]])
		    else:
			#if len(self.tokens) \
			#   and str[ix:ix+ll] == self.tokens[-1] \
			#   and self.tabelle[str[ix:ix+ll]][4] != 3 \
			#   and str[ix:ix+ll] not in ["~", "0", "1", "2", "3", "4", 
			#			     "5", "6", "7", "8", "9"]:
			#    """insert shadda"""
			#    self.tokens.append("Q")
			#else:
			    self.tokens.append(str[ix:ix+ll])
		    ix = ix + ll
		    break # for-loop
	    else:
		ix = ix + 1
	
	#print "TRANSTOKENS",self.tokens
 


    def transliterate(self, syrisch, style="serto"):
	if self.usingUTF8:
		line = unicode(syrisch, "utf8")
		newline = ""
		for c in line:
			#print "eee %x" % ord(c), self.UnicodeTable.has_key(ord(c)), 
			#print c.encode("utf8")
			sertocode = self.UnicodeTable.get(ord(c), c) 
			newline += sertocode
			#print "[%s]"  % sertocode, newline
		syrisch = newline

	syrisch = string.replace(syrisch, " ", "~")
	self.transtokenize(syrisch, len(syrisch), style)
	#self.err("TOKEN %s" %self.tokens)
	ret = []
	oldtok = ""
	for tok in self.tokens:
	    if tok == "~": # blank
		ret.append(" ")
	    #elif tok == "Q": # shadda
		#ret.append(ret[-1])
	    #elif tok == "+": # soft sign under begadkefat
		#if len(ret):
		#    ret[-1] = self.spec.get(oldtok+tok, oldtok+tok)
	    else:
		ret.append(self.transtabelle[style].get(tok, tok))
	    #oldtok = tok
	
	return string.join(ret, "")

    def syriacise(self, style="serto"):
	# replace tokens by serto letters, take into account context
	ix = 0
	out = []
	digits = []
	self.maxlen = len(self.tokens)
	#sys.stderr.write("%s\n" % self.tokens)
	number = 0
	for i in range(self.maxlen):
	    if self.tokens[i][0] in "\\{}":
		out.append(self.tokens[i])

	    elif self.tabelle[style][self.tokens[i]].medial == -1: 
		#print "skipping letter"
		continue
	    else:
		form = self.context(i, style=style)

		if self.tokens[i] in ["0", "1", "2", "3", "4", 
				      "5", "6", "7", "8", "9"]:
		    number = 1
		    digits.append(chr(self.tabelle[style][self.tokens[i]].getcontext(form)))
		else:
		    if number == 1:
			number = 0
			digits.reverse()
			out.extend(digits)
			digits = []
		    #out.append(chr(self.tabelle[self.tokens[i]][form]))
		    #out.append("%c" %(self.tabelle[self.tokens[i]].getcontext(form)))
		    for c in self.tabelle[style][self.tokens[i]].getChar(form):
			#sys.stderr.write("LETTER: %s\n" % c)
			out.append(c)
		#print self.tokens[i], form, self.tabelle[self.tokens[i]][form]

	if number:
	    number = 0
	    digits.reverse()
	    out.extend(digits)


	#for i in out: print "%d" % ord(i),
	#print
	#if not self.elatex:
	#    out.reverse()

	# This kills empty letters, caused by -1 in .font-file
	return string.join(out, "") 
	

    def context(self, ix, style="serto"):
	"""returns 0 if letter is isolated
	1 if letter is initial
	2 if letter is medial
	3 if letter is final"""

	if self.before(ix, style) and self.next(ix, style):
	    return 2
	elif self.before(ix, style) and not self.next(ix, style):
	    return 3
	elif not self.before(ix, style) and self.next(ix, style):
	    return 1
	else:
	    return 0


    def next(self, ix, style="serto"):
	"""returns 1 if next token is a letter"""
	for i in range(ix+1, self.maxlen):
	    if self.tokens[i][0] in "\\{}":
		return 0
	    elif self.tabelle[style][self.tokens[i]].link in [2,3]:
		continue
	    elif self.tokens[i] not in ["~", "!", ",", ".", ";", "?"] :
		return 1
	    else:
		return 0
	return 0

    def before(self, ix, style="serto"):
	"""returns 1 if preceding token is a letter"""
	for i in range(ix-1, -1, -1):
	    if self.tokens[i][0] in "\\{}":
		return 0
	    elif self.tabelle[style][self.tokens[i]].link == 2:
		continue
	    elif  self.tokens[i] != "~":
		if self.tabelle[style][self.tokens[i]].link == 0:
		    return 0
		else:
		    return 1
	    else:
		return 0
	return 0





    def convert(self, transcript, style="serto"):
	# interface function
	# dummy blank
	if self.usingUTF8:
		line = unicode(transcript, "utf8")
		newline = ""
		for c in line:
			#sys.stderr.write( "eee %d %s\n" % (ord(c), self.UnicodeTable.has_key(ord(c))))
			#sys.stderr.write( c.encode("utf8") + "\n")
			sertocode = self.UnicodeTable.get(ord(c), c) 
			newline += sertocode
			#sys.stderr.write( "[%s]\n"  % sertocode)
		transcript = newline.encode("utf8")
		
	transcript = string.replace(transcript, " ", "~")
	self.tokenize(transcript, len(transcript), style)
	return self.syriacise(style)


    def texify(self, word, style="serto"):
	res = []
	for ll in serto.convert(word, style):
	    # ll: position of current syriac character in font table
	    #sys.stdout.write("LETTER: 0x%x\n" % (ord(ll)))
	    #sys.stderr.write("LETTER: %s\n" % ord(ll))

	    if ord(ll) < 16:
		#print "WWWWWWWWW", len(res), res
		if len(res):
		    res[-1] = "\\uppersyriac{%d}{%s}" % (ord(ll), res[-1])
		else:
		    res.append("\\uppersyriac{%d}{A}" % (ord(ll))) # A: Olaf
	    elif ord(ll) < 32:
		if len(res):
		    res[-1] = "\\lowersyriac{%d}{%s}" % (ord(ll), res[-1])
		else:
		    res.append("\\lowersyriac{%d}{A}" % (ord(ll)))
	    elif ord(ll) < 127 and ord(ll) not in [34,35,36,37,38,95]: 
		res.append(ll)
	    else:
		# special (active) TeX-characters, charactes > 127
		res.append("\\char%d{}" % ord(ll))
	if not self.elatex:
	    res.reverse()
	return string.join(res, "")

    def inlineserto(self, matchobject):
	return "{\\serto\\beginR %s\\endR}" % self.texify(matchobject.group(2))

    def inlinechaldean(self, matchobject):
	return "{\\assyr\\beginR %s\\endR}" \
	       % self.texify(matchobject.group(2), "chaldean")

    def inlinetrans(self, matchobject):
	return "\\emph{%s}" % self.transliterate(matchobject.group(2))

    def inlinesertotrans(self, matchobject):
	return "{\\serto\\beginR %s\\endR} \\emph{%s}" \
	       % (self.texify(matchobject.group(2)),
		  self.transliterate(matchobject.group(2)))
    def inlinechaldeantrans(self, matchobject):
	return "{\\assyr\\beginR %s\\endR} \\emph{%s}" \
	       % (self.texify(matchobject.group(2), "chaldean"),
		  self.transliterate(matchobject.group(2), "chaldean"))
    def err(self, s):
	sys.stderr.write(s + "\n")

#-------------------------------------------------------
if __name__ == "__main__":
    sys.stderr.write("serto - LaTeX - preprocessor\n(c) Johannes Heinecke\n")

    if len(sys.argv) < 2:
	sys.stderr.write("usage:\n  serto.py [-o] inputfile\n")
	sys.stderr.write("    -o: for usage with an older version of LaTeX which cannot typeset right-to-left scripts elatex\n\n")
	sys.exit(1)

    else:
	sys.stderr.write("\n")
	import getopt

	elatex = 1
	optlist,comargs = getopt.getopt(sys.argv[1:], "")

	for (o,a) in optlist:
	    if o == "-o":
		elatex = 0

	serto = Serto(elatex=elatex)
	fp = open(comargs[0])

	#mode = "latin"
	mode = ["latin"]
	z = fp.readline()
	while (z):
	    #print "LINE", z,
	    if z.find("\usepackage[utf8]{inputenc}") > -1:
		serto.usingUTF8 = True
	    #print 'QQQ',z, mode
	    if z[:-1] == "<SERTO>":
		# must be on a single line (will be deleted)
		if not elatex:
		    sys.stderr.write("using <SERTO> without the -e option (and elatex) may not work!\n")
		#mode = "serto"
		mode.append("serto")
		print '{\\serto\\beginR %'

	    elif string.strip(z[:-1]) == "</SERTO>":
		#mode = "latin"
		del mode[-1]
		#print '\\endR}%'  # causes problems in last line
		print '}%'

	    elif z[:-1] == "<CHALDEAN>":
		# must be on a single line (will be deleted)
		if not elatex:
		    sys.stderr.write("using <CHALDEAN> without the -e option (and elatex) may not work!\n")
		#mode = "chaldean"
		mode.append("chaldean")
		print '{\\assyr\\beginR %'

	    elif string.strip(z[:-1]) == "</CHALDEAN>":
		#mode = "latin"
		del mode[-1]
		#print '\\endR}%'  # causes problems in last line
		print '}%'


	    elif z[:-1] == "<TRANS>":
		#mode = "trans"
		mode.append("trans")
                print '{\\it %'

	    elif string.strip(z[:-1]) == "</TRANS>":
		#mode = "latin"
		del mode[-1]
		print '}%'



#	    elif z[:-1] == "<SERTOTRANS>":
#		mode = "sertotrans"
#		print '{\\serto\\beginR %'
#
#	    elif string.strip(z[:-1]) == "</SERTOTRANS>":
#		mode = "latin"
#		print '\\endR}%'



	    else:
		#print "mmm", mode, z
		if mode[-1] == "latin":
		    #sys.stdout.write(serto.inlineS.sub(serto.inlineserto, z))
		    a = serto.inlineS.sub(serto.inlineserto, z)
		    b = serto.inlineT.sub(serto.inlinetrans, a)
		    c = serto.inlineST.sub(serto.inlinesertotrans, b)
		    d = serto.inlineC.sub(serto.inlinechaldean, c)
		    e = serto.inlineCT.sub(serto.inlinechaldeantrans, d)
		    sys.stdout.write(e)
		elif mode[-1] == "trans":
		    print serto.transliterate(z)
		else:
		    if z[:-1] == "": print "\n\\beginR",
		    else:
			print serto.texify(z, mode[-1])


	    #print "rrrrr", mode
	    z = fp.readline()


	fp.close()
	sys.exit(serto.errct)
