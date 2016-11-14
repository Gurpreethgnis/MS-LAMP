use Tk;
use Tk::PNG;

$HOME="/home/user/MS-LAMP";
#Provide the path for MS-LAMP here.

$PDFCOMMAND="evince"; 
# evince is a PDF reader. The user needs to mention the command for the PDF opener to read pdf files associated with this programme.
$STRUCTURECOMMAND="pymol";
#pymol is software used to view mol sructure files. The user needs to install $STRUCTURECOMMAND and use the command as above or install a similar software such as JMOL and use corresponding command to view structure.

use vars qw($HOME $PDFCOMMAND $STRUCTURECOMMAND);

#use Win32::OLE;
$cover=new MainWindow;
$cover->geometry("1030x570+0+0");
$col = "white";
$col2="black";
$col3="blue";
$col4="dark grey";
$col5="navy blue";
$col6="light grey";
$col7="brown";
$cover->configure(-background=>$col);
$cover->title("MS-LAMP : General Lipidome");
&assignphotos;
&mainwindow;

MainLoop;

sub assignphotos
{
$rangeimg =$cover->Photo(-file=>"$HOME/logo/rom.png");
$massimg =$cover->Photo(-file=>"$HOME/logo/mzion.png");
$formulaeimg =$cover->Photo(-file=>"$HOME/logo/formulae.png");
$lmidimg =$cover->Photo(-file=>"$HOME/logo/lmid.png");
$lmzimg =$cover->Photo(-file=>"$HOME/logo/lmz.png");
}
sub mainwindow
{# defining the heading or the title
$lamphead=$cover->Frame(-relief=>raised,-highlightbackground => $col2,-highlightthickness=>'5')->pack(-side=>top,-fill=>x);
$heading=$lamphead->Label(-text=>"M S - L A M P ",-font=>'{times new roman} 40 bold',-background=>$col4,-foreground=>$col5)->pack(-side=>top,-fill=>x);
$heading=$lamphead->Label(-text=>"Mass Spectrometry based Lipid(ome) Analyzer & Molecular Platform\n",-font=>'{times new roman} 20 bold',-background=>$col4,-foreground=>$col5)->pack(-side=>top,-fill=>x);
$catlbl=$cover-> Label(-text=>"",-font=>'{times new roman} 4',-background=>$col,-foreground=>white)->pack(-side=>top,-fill=>x);
$heading=$cover->Label(-text=>"General Lipidome  MS - LAMP (37572 Lipids)",-font=>'{times new roman} 18 bold',-background=>$col6,-foreground=>$col2)->pack(-side=>top,-fill=>x);
#$lipidomeintro=$cover->Button(-text=>"Click to listen about search options (Audio)",-command=>\&lipidomespeech,-borderwidth=>5,-foreground=>$col7,-background=>$col6,-font=>"{times new roman} 12 bold",-borderwidth=>5)->pack(-side=>top,-fill=>x);
$emptylbl=$cover-> Label(-text=>" ",-font=>'arial 15',-background=>$col)->pack(-side=>top,-fill=>x);
$catlbl=$cover-> Label(-text=>"Choose a Query Type",-font=>'{times new roman} 18 bold',-justify=>right,-background=>$col6,-foreground=>$col2)->pack(-side=>top,-fill=>x);
$catlbl=$cover-> Label(-text=>"",-font=>'{times new roman} 24',-background=>$col,-foreground=>white)->pack(-side=>top,-fill=>x);
$buttons=$cover->Frame(-background=>$col)->pack(-side=>top);

$spacemass=$buttons->Label(-text=>" ",-background=>$col)->pack(-side=>left);

$massframe=$buttons->Frame(-background=>$col)->pack(-side=>left,-fill=>x);
$btnlblmass=$massframe->Button(-text=>"Query Type 1",-font=>'{times new roman} 12 bold',-relief=>'raised',-borderwidth=>'5',-background=>$col6,-foreground=>$col7,-command=>\&mass)->pack(-side=>top,-fill=>x);
$massbtn=$massframe->Label(-image=>$massimg,-relief=>'raised',-borderwidth=>'5',-highlightbackground => $col2,-highlightthickness=>'5')->pack(-side=>top);
$btnhelpmass=$massframe->Button(-text=>"Need Help?",-font=>'{times new roman} 12 bold',-command=>\&QT1,-relief=>'raised',-borderwidth=>'5',-background=>$col6,-foreground=>$col7)->pack(-side=>top,-fill=>x);

$spacelmz=$buttons->Label(-text=>" ",-background=>$col)->pack(-side=>left);

$lmzframe=$buttons->Frame(-background=>$col)->pack(-side=>left,-fill=>x);
$btnlblmz=$lmzframe->Button(-text=>"Query Type 2",-font=>'{times new roman} 12 bold',-relief=>'raised',-borderwidth=>'5',-background=>$col6,-foreground=>$col7,-command=>\&lmz)->pack(-side=>top,-fill=>x);
$lmzbtn=$lmzframe->Label(-image=>$lmzimg,-relief=>'raised',-highlightbackground => $col2,-highlightthickness=>'5',-borderwidth=>'5')->pack(-side=>top);
$btnhellmz=$lmzframe->Button(-text=>"Need Help?",-font=>'{times new roman} 12 bold',-relief=>'raised',-command=>\&QT2,-borderwidth=>'5',-background=>$col6,-foreground=>$col7)->pack(-side=>top,-fill=>x);

$spacerange=$buttons->Label(-text=>"  ",-background=>$col)->pack(-side=>left);
$rangeframe=$buttons->Frame(-background=>$col)->pack(-side=>left,-fill=>x);
$btnlblrange=$rangeframe->Button(-text=>"Query Type 3",-font=>'{times new roman} 12 bold',-relief=>'raised',-borderwidth=>'5',-background=>$col6,-foreground=>$col7,-command=>\&range)->pack(-side=>top,-fill=>x);
$rangebtn=$rangeframe->Label(-image=>$rangeimg,-highlightbackground => $col2,-highlightthickness=>'5',-relief=>'raised',-borderwidth=>'5')->pack(-side=>top);
$btnhelprange=$rangeframe->Button(-text=>"Need Help?",-font=>'{times new roman} 12 bold',-relief=>'raised',-command=>\&QT3,-borderwidth=>'5',-background=>$col6,-foreground=>$col7)->pack(-side=>top,-fill=>x);

$spaceformulae=$buttons->Label(-text=>" ",-background=>$col)->pack(-side=>left);
$formulaeframe=$buttons->Frame(-background=>$col)->pack(-side=>left,-fill=>x);
$btnlblformulae=$formulaeframe->Button(-text=>"Query Type 4",-font=>'{times new roman} 12 bold',-borderwidth=>'5',-relief=>'raised',-background=>$col6,-foreground=>$col7,-command=>\&formulae)->pack(-side=>top,-fill=>x);
$formulaebtn=$formulaeframe->Label(-image=>$formulaeimg,-relief=>'raised',-borderwidth=>'5',-highlightbackground => $col2,-highlightthickness=>'5')->pack(-side=>top);
$btnhelpformulae=$formulaeframe->Button(-text=>"Need Help?",-font=>'{times new roman} 12 bold',-relief=>'raised',-command=>\&QT4,-borderwidth=>'5',-background=>$col6,-foreground=>$col7)->pack(-side=>top,-fill=>x);

$spacelampid=$buttons->Label(-text=>" ",-background=>$col)->pack(-side=>left);
$lmidframe=$buttons->Frame(-background=>$col)->pack(-side=>left,-fill=>x);
$btnlblmid=$lmidframe->Button(-text=>"Query Type 5",-font=>'{times new roman} 12 bold',-borderwidth=>'5',-relief=>'raised',-background=>$col6,-foreground=>$col7,-command=>\&lmid)->pack(-side=>top,-fill=>x);
$lmidbtn=$lmidframe->Label(-image=>$lmidimg,-relief=>'raised',-highlightbackground => $col2,-highlightthickness=>'5',-borderwidth=>'5')->pack(-side=>top);
$btnhelplmid=$lmidframe->Button(-text=>"Need Help?",-font=>'{times new roman} 12 bold',-relief=>'raised',-command=>\&QT5,-borderwidth=>'5',-background=>$col6,-foreground=>$col7)->pack(-side=>top,-fill=>x);


};





sub lipidomespeech()
 {
$text = "Welcome to,General lipidome MS-LAMP search window . you can search here , by 5 different types of query ";
 $text1="By entering, a molecular mass or m by zee  range! , for example , 200 to 300"; 
$text2="By entering, Single molecular mass or m by zee value, for example ,querying 309.366 as M, H, negative ion. It corresponds to ,molecular mass of ,Flavonoid , a Polyketide";
$text3="By entering, Molecular formula!, for example ,C29 , H50 ,O2. This can be molecular formula of alpha tocopherol (Vitamin-E) , a Prenol Lipid ";
$text4="By entering, L M I D , a unique twelve character alphanumerical identifier, as defined in, LIPID MAPS consortium";
$text5="by uploading ,a text file, containing list of m by z values";
$text6="click me again ";
$text7="if you want 2 repeat";
$text8="Query Type one";
$text9="Query Type two";
$text10="Query Type three";
$text11="Query Type four";
$text12="Query Type five";
$text13="Thank you!";
$tts = Win32::OLE->new("SAPI.SpVoice") or die "Sapi.SpVoice failed";
$tts->{Rate}=-3;
$tts->{Volume}=200000;
$tts->Speak("$text");
$tts->Speak("$text8");
$tts->Speak("$text2");
$tts->Speak("$text9");
$tts->Speak("$text5");
$tts->Speak("$text10");
$tts->Speak("$text1");
$tts->Speak("$text11");
$tts->Speak("$text3");
$tts->Speak("$text12");
$tts->Speak("$text4");
$tts->Speak("$text7");
$tts->Speak("$text6");
$tts->Speak("$text13");
};

sub QT1{system("$PDFCOMMAND $HOME/Help/QT1.pdf")};
sub QT2{system("$PDFCOMMAND $HOME/Help/QT2.pdf")};
sub QT3{system("$PDFCOMMAND $HOME/Help/QT3.pdf")};
sub QT4{system("$PDFCOMMAND $HOME/Help/QT4.pdf")};
sub QT5{system("$PDFCOMMAND $HOME/Help/QT5.pdf")};


sub lmz{system("perl $HOME/executables/all/QT2.pl")};
sub range{system("perl $HOME/executables/all/QT3.pl")};
sub mass{system("perl $HOME/executables/all/QT1.pl")};
sub formulae{system("perl $HOME/executables/all/QT4.pl")};
sub lmid{system("perl $HOME/executables/all/QT5.pl")};
