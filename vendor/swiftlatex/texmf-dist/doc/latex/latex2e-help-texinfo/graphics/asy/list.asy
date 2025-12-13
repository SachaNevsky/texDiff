import settings;
// settings.outformat="pdf";

unitsize(1pt);

void leftbar(picture pic, pair a, pair d, pen p=currentpen)
{
  picture opic;
  // was: Draw(opic,-0.5d--0.5d,p+solid);
  Draw(opic,-0d--0.5d,p+solid);
  add(pic,opic,a);
}
picture leftbar(pair a, pair d, pen p=currentpen)
{
  picture pic;
  leftbar(pic,a,d,p);
  return pic;
}
void rightbar(picture pic, pair a, pair d, pen p=currentpen)
{
  picture opic;
  // was: Draw(opic,-0.5d--0.5d,p+solid);
  Draw(opic,-0.5d--0d,p+solid);
  add(pic,opic,a);
}
picture rightbar(pair a, pair d, pen p=currentpen)
{
  picture pic;
  leftbar(pic,a,d,p);
  return pic;
}

arrowbar BeginLeftBar(real size=0) 
{
  return new bool(picture pic, path g, pen p, margin margin) {
    real size=size == 0 ? barsize(p) : size;
    leftbar(pic,point(g,0),size*dir(g,0)*I,p);
    return true;
  };
}

arrowbar LeftBar(real size=0) 
{
  return new bool(picture pic, path g, pen p, margin margin) {
    int L=length(g);
    real size=size == 0 ? barsize(p) : size;
    leftbar(pic,point(g,L),size*dir(g,L)*I,p);
    return true;
  };
}
arrowbar EndLeftBar(real size=0)=LeftBar; 

arrowbar LeftBars(real size=0) 
{
  return new bool(picture pic, path g, pen p, margin margin) {
    real size=size == 0 ? barsize(p) : size;
    BeginLeftBar(size)(pic,g,p,margin);
    EndLeftBar(size)(pic,g,p,margin);
    return true;
  };
}
arrowbar BeginRightBar(real size=0) 
{
  return new bool(picture pic, path g, pen p, margin margin) {
    real size=size == 0 ? barsize(p) : size;
    rightbar(pic,point(g,0),size*dir(g,0)*I,p);
    return true;
  };
}

arrowbar RightBar(real size=0) 
{
  return new bool(picture pic, path g, pen p, margin margin) {
    int L=length(g);
    real size=size == 0 ? barsize(p) : size;
    rightbar(pic,point(g,L),size*dir(g,L)*I,p);
    return true;
  };
}
arrowbar EndRightBar(real size=0)=LeftBar; 

arrowbar RightBars(real size=0) 
{
  return new bool(picture pic, path g, pen p, margin margin) {
    real size=size == 0 ? barsize(p) : size;
    BeginRightBar(size)(pic,g,p,margin);
    EndRightBar(size)(pic,g,p,margin);
    return true;
  };
}
arrowbar BeginLeftBar=BeginLeftBar(),
  LeftBar=LeftBar(),
  EndLeftBar=EndLeftBar(),
  LeftBars=LeftBars(),
  BeginRightBar=BeginRightBar(),
  RightBar=RightBar(),
  EndRightBar=EndRightBar(),
  RightBars=RightBars();

// Simulate text lines
real em=10pt;  // Computer Modern
real baselineskip=1.2*em;
real textpen_wd=0.8*em;
pen textpen = linewidth(textpen_wd)+mediumgray+squarecap+opacity(0.5);  // simulate text lines
pen surrounding_environmentpen = textpen;  // simulate text lines
pen labelpen = black+font("OT1","cmr","m","it")+fontsize(7);

// basic list 
real pagewidth=8cm;
real pageleftmargin=0.25cm;
real pagerightmargin=0.25cm;
real baseline; // keep track of vert location of baseline

int num_lines_above = 2;
int num_lines_first_item_first_paragraph = 3;
int num_lines_first_item_second_paragraph = 1;
int num_lines_second_item = 3;
int num_lines_below = 2;

// list parameters
// LaTeX's book 10 defaults; not suitable for illustration
// real leftmargin=2.5*em;
// real rightmargin=0*em;
// real topsep=8pt;
// real parskip=0pt;
// real partopsep=2pt;
// real labelwidth=leftmargin;
// real labelsep=0.5*em;
// real parsep=4pt;
// real itemindent=parsep;
// real listparindent=itemindent;
// real itemsep=4pt;
// parameters shown on the diagram
real leftmargin=2.5*em;
real rightmargin=1.5*em;
real topsep=8pt;
real parskip=4pt;
real partopsep=2pt;
real labelwidth=3em;
real labelsep=0.5*em;
real parsep=4pt;
real itemindent=16pt;
real listparindent=5pt;
real itemsep=8pt;

real labelleftedge = (pageleftmargin+leftmargin+itemindent)-(labelwidth+labelsep);
real labelrightedge = labelleftedge+labelwidth;

// helper lines 
// draw((pageleftmargin+leftmargin,0)--(pageleftmargin+leftmargin,-30),green);
// draw((pageleftmargin+leftmargin+itemindent,0)--(pageleftmargin+leftmargin+itemindent,-30),green);
// draw((pageleftmargin+leftmargin+itemindent-labelwidth,0)--(pageleftmargin+leftmargin+itemindent-labelwidth,-30),blue);
// draw((pageleftmargin+leftmargin+itemindent-labelwidth-labelsep,0)--(pageleftmargin+leftmargin+itemindent-labelwidth-labelsep,-30),red);

path lne;

// lines above list
baseline=0;
lne = (pageleftmargin,baseline)--(pagewidth-pagerightmargin,baseline); 
draw(lne,surrounding_environmentpen);
for (int line_no=0; line_no<(num_lines_above-1); ++line_no) {
  baseline = baseline-baselineskip;
  lne=(pageleftmargin,baseline)--(pagewidth-pagerightmargin,baseline);
  draw(lne,surrounding_environmentpen);
}
label("Surrounding environment, preceding material",(0.5*(pageleftmargin+pagewidth-pagerightmargin),baseline),labelpen);
real bot_preceding_material = baseline-0.5*textpen_wd;

// list first item 
baseline=baseline-baselineskip-topsep-parskip-partopsep;
real top_item_one = baseline+0.5*textpen_wd;
draw((labelleftedge,baseline)--(labelrightedge,baseline),textpen);  // label
label("Label",(0.5*(labelleftedge+labelrightedge),baseline),labelpen);
draw((labelrightedge+labelsep,baseline)--(pagewidth-pagerightmargin-rightmargin,baseline),textpen); // rest of label line
label("\makebox[0em][l]{First item}",((pageleftmargin+leftmargin)+3.5em,baseline),labelpen);
for (int line_no=0; line_no<(num_lines_first_item_first_paragraph-1); ++line_no) {
  baseline = baseline-baselineskip;
  draw((pageleftmargin+leftmargin,baseline)--(pagewidth-pagerightmargin-rightmargin,baseline),textpen);
}
real bot_item_one_par_one = baseline-0.5*textpen_wd;

// first item's second paragraph
baseline = baseline-baselineskip-parsep;
real top_item_one_par_two = baseline+0.5*textpen_wd;
draw((pageleftmargin+leftmargin+listparindent,baseline)--(pagewidth-pagerightmargin-rightmargin,baseline),textpen);
label("\makebox[0em][l]{First item, second paragraph}",((pageleftmargin+leftmargin)+3.5em,baseline),labelpen);
for (int line_no=0; line_no<(num_lines_first_item_second_paragraph-1); ++line_no) {
  baseline = baseline-baselineskip;
  draw((pageleftmargin+leftmargin,baseline)--(pagewidth-pagerightmargin-rightmargin,baseline),textpen);
}
real bot_item_one = baseline-0.5*textpen_wd;

// list second item 
baseline=baseline-baselineskip-itemsep-parsep;
real top_item_two = baseline+0.5*textpen_wd;
draw((labelleftedge,baseline)--(labelrightedge,baseline),textpen);  // label
label("Label",(0.5*(labelleftedge+labelrightedge),baseline),labelpen);
draw((labelrightedge+labelsep,baseline)--(pagewidth-pagerightmargin-rightmargin,baseline),textpen); // rest of label line
label("\makebox[0em][l]{Second item}",((pageleftmargin+leftmargin)+3.5em,baseline),labelpen);
for (int line_no=0; line_no<(num_lines_second_item-1); ++line_no) {
  baseline = baseline-baselineskip;
  draw((pageleftmargin+leftmargin,baseline)--(pagewidth-pagerightmargin-rightmargin,baseline),textpen);
}
real bot_item_two = baseline-0.5*textpen_wd;

// lines after list
baseline=baseline-baselineskip-topsep-parsep-partopsep;
real top_following_material = baseline+0.5*textpen_wd;
label("Surrounding environment, following material",(0.5*(pageleftmargin+pagewidth-pagerightmargin),baseline),labelpen);
draw((pageleftmargin,baseline)--(pagewidth-pagerightmargin,baseline),surrounding_environmentpen);
for (int line_no=0; line_no<(num_lines_below-1); ++line_no) {
  baseline = baseline-baselineskip;
  draw((pageleftmargin,baseline)--(pagewidth-pagerightmargin,baseline),surrounding_environmentpen);
}

// vertical markers
real v_x = pagewidth-pagerightmargin+6pt;
draw(Label("{\scriptsize $v_0$}",red),reverse((v_x,bot_preceding_material)--(v_x,top_item_one)),red,bar=LeftBars);
draw(Label("{\scriptsize $v_1$}",red),reverse((v_x,bot_item_one_par_one)--(v_x,top_item_one_par_two)),red,bar=LeftBars);
draw(Label("{\scriptsize $v_2$}",red),reverse((v_x,bot_item_one)--(v_x,top_item_two)),red,bar=LeftBars);
draw(Label("{\scriptsize $v_3$}",red),reverse((v_x,bot_item_two)--(v_x,top_following_material)),red,bar=LeftBars);

// horizontal markers
real h_y_top = top_item_one+3pt;
draw(Label("{\scriptsize $h_0$}",blue),reverse((labelleftedge,h_y_top)--(labelrightedge,h_y_top)),blue,bar=LeftBars);
draw(Label("{\scriptsize $h_1$}",blue),reverse((labelrightedge,h_y_top)--(labelrightedge+labelsep,h_y_top)),blue,bar=LeftBars);

real h_y_mid = bot_item_one-3pt;
draw(Label("{\scriptsize $h_2$}",blue),(pageleftmargin+leftmargin,h_y_mid)--(pageleftmargin+leftmargin+listparindent,h_y_mid),blue,bar=LeftBars);

real h_y_bot = bot_item_two-3pt;
draw(Label("{\scriptsize $h_3$}",blue),(pageleftmargin,h_y_bot)--(pageleftmargin+leftmargin,h_y_bot),blue,bar=LeftBars);
draw(Label("{\scriptsize $h_4$}",blue),(pageleftmargin+leftmargin,h_y_bot)--(pageleftmargin+leftmargin+itemindent,h_y_bot),blue,bar=LeftBars);
draw(Label("{\scriptsize $h_5$}",blue),(pagewidth-pagerightmargin-rightmargin,h_y_bot)--(pagewidth-pagerightmargin,h_y_bot),blue,bar=LeftBars);


