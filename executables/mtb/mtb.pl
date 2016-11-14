use Tk;
use Tk::PNG;
#use Win32::OLE;

$HOME="/home/user/MS-LAMP";
#Provide the path for MS-LAMP here.

$PDFCOMMAND="evince"; 
# evince is a PDF reader. The user needs to mention the command for the PDF opener to read pdf files associated with this programme.
$STRUCTURECOMMAND="shotwell";
#shotwell is software used to view image files. The user needs to install shotwell and use the command as above or install a similar software and use corresponding command to view structure.

use vars qw($HOME $PDFCOMMAND $STRUCTURECOMMAND);


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
$cover->title("MS-LAMP : Mycobacterium tuberculosis Lipidome MS-LAMP");
&assignphotos;
&mainwindow;

MainLoop;

sub assignphotos
{
$rangeimg =$cover->Photo(-file=>"$HOME/logo/rom.png");
$massimg =$cover->Photo(-file=>"$HOME/logo/mzionmtb.png");
$formulaeimg =$cover->Photo(-file=>"$HOME/logo/formulaemtb.png");
$lmidimg =$cover->Photo(-file=>"$HOME/logo/lmid.png");
$lmzimg =$cover->Photo(-file=>"$HOME/logo/lmz.png");
}
sub mainwindow
{# defining the heading or the title
$lamphead=$cover->Frame(-relief=>raised,-highlightbackground => $col2,-highlightthickness=>'5')->pack(-side=>top,-fill=>x);
$heading=$lamphead->Label(-text=>"M S - L A M P ",-font=>'{times new roman} 40 bold',-background=>$col4,-foreground=>$col5)->pack(-side=>top,-fill=>x);
$heading=$lamphead->Label(-text=>"Mass Spectrometry based Lipid(ome) Analyzer & Molecular Platform\n",-font=>'{times new roman} 20 bold',-background=>$col4,-foreground=>$col5)->pack(-side=>top,-fill=>x);
$catlbl=$cover-> Label(-text=>"",-font=>'{times new roman} 4',-background=>$col,-foreground=>white)->pack(-side=>top,-fill=>x);
$heading=$cover->Label(-text=>"Mycobacterium tuberculosis Lipidome MS-LAMP (2518 Lipids)",-font=>'{times new roman} 18 bold',-background=>$col6,-foreground=>$col2)->pack(-side=>top,-fill=>x);
#$lipidomeintro=$cover->Button(-text=>"Click to listen about search options (Audio)",-command=>\&lipidomespeech,-borderwidth=>5,-foreground=>$col7,-background=>$col6,-font=>"{times new roman} 12 bold",-borderwidth=>5)->pack(-side=>top,-fill=>x);
$emptylbl=$cover-> Label(-text=>" ",-font=>'arial 15',-background=>$col)->pack(-side=>top,-fill=>x);
$catlbl=$cover-> Label(-text=>"Choose a Query Type",-font=>'{times new roman} 18 bold',-justify=>right,-background=>$col6,-foreground=>$col2)->pack(-side=>top,-fill=>x);
$catlbl=$cover-> Label(-text=>"",-font=>'{times new roman} 24',-background=>$col,-foreground=>white)->pack(-side=>top,-fill=>x);
$buttons=$cover->Frame(-background=>$col)->pack(-side=>top);

$spacemass=$buttons->Label(-text=>"\t",-background=>$col)->pack(-side=>left);

$massframe=$buttons->Frame(-background=>$col)->pack(-side=>left,-fill=>x);
$btnlblmass=$massframe->Button(-text=>"Query Type 1",-font=>'{times new roman} 12 bold',-relief=>'raised',-borderwidth=>'5',-background=>$col6,-foreground=>$col7,-command=>\&mass)->pack(-side=>top,-fill=>x);
$massbtn=$massframe->Label(-image=>$massimg,-relief=>'raised',-borderwidth=>'5',-highlightbackground => $col2,-highlightthickness=>'5')->pack(-side=>top);
$btnhelpmass=$massframe->Button(-text=>"Need Help?",-font=>'{times new roman} 12 bold',-command=>\&QT1,-relief=>'raised',-borderwidth=>'5',-background=>$col6,-foreground=>$col7)->pack(-side=>top,-fill=>x);

$spacelmz=$buttons->Label(-text=>"\t\t",-background=>$col)->pack(-side=>left);

$lmzframe=$buttons->Frame(-background=>$col)->pack(-side=>left,-fill=>x);
$btnlblmz=$lmzframe->Button(-text=>"Query Type 2",-font=>'{times new roman} 12 bold',-relief=>'raised',-borderwidth=>'5',-background=>$col6,-foreground=>$col7,-command=>\&lmz)->pack(-side=>top,-fill=>x);
$lmzbtn=$lmzframe->Label(-image=>$lmzimg,-relief=>'raised',-highlightbackground => $col2,-highlightthickness=>'5',-borderwidth=>'5')->pack(-side=>top);
$btnhellmz=$lmzframe->Button(-text=>"Need Help?",-font=>'{times new roman} 12 bold',-relief=>'raised',-command=>\&QT2,-borderwidth=>'5',-background=>$col6,-foreground=>$col7)->pack(-side=>top,-fill=>x);

$spacerange=$buttons->Label(-text=>"\t\t",-background=>$col)->pack(-side=>left);
$rangeframe=$buttons->Frame(-background=>$col)->pack(-side=>left,-fill=>x);
$btnlblrange=$rangeframe->Button(-text=>"Query Type 3",-font=>'{times new roman} 12 bold',-relief=>'raised',-borderwidth=>'5',-background=>$col6,-foreground=>$col7,-command=>\&range)->pack(-side=>top,-fill=>x);
$rangebtn=$rangeframe->Label(-image=>$rangeimg,-highlightbackground => $col2,-highlightthickness=>'5',-relief=>'raised',-borderwidth=>'5')->pack(-side=>top);
$btnhelprange=$rangeframe->Button(-text=>"Need Help?",-font=>'{times new roman} 12 bold',-relief=>'raised',-command=>\&QT3,-borderwidth=>'5',-background=>$col6,-foreground=>$col7)->pack(-side=>top,-fill=>x);

$spaceformulae=$buttons->Label(-text=>"\t\t",-background=>$col)->pack(-side=>left);
$formulaeframe=$buttons->Frame(-background=>$col)->pack(-side=>left,-fill=>x);
$btnlblformulae=$formulaeframe->Button(-text=>"Query Type 4",-font=>'{times new roman} 12 bold',-borderwidth=>'5',-relief=>'raised',-background=>$col6,-foreground=>$col7,-command=>\&formulae)->pack(-side=>top,-fill=>x);
$formulaebtn=$formulaeframe->Label(-image=>$formulaeimg,-relief=>'raised',-borderwidth=>'5',-highlightbackground => $col2,-highlightthickness=>'5')->pack(-side=>top);
$btnhelpformulae=$formulaeframe->Button(-text=>"Need Help?",-font=>'{times new roman} 12 bold',-relief=>'raised',-command=>\&QT4,-borderwidth=>'5',-background=>$col6,-foreground=>$col7)->pack(-side=>top,-fill=>x);

};





sub lipidomespeech()
 {
$text = "Welcome to,Mycobacterium tuberculosis lipidome, MS-LAMP search window . you can search here , by 4 different types of query ";
 $text1="By entering, a molecular mass or m by zee range! , for example , 200 to 300"; 

$text2="By entering, Single molecular mass or m by zee value , for example ,querying 369.37268 as ,M, H, positive ion. it corresponds to ,molecular mass of ,Mycocerosic acid (C24) , a Fatty Acyl";
$text3="By entering, Chemical formula!, for example ,C31 , H62 ,O2. It corresponds to Phthioceranic acid (C31) , a Fatty Acyl ";
 

$text5="by uploading ,a text file, containing list of molecular mass or m by z values";
$text6="click me again ";
$text7="if you want 2 repeat";
$text8="Query Type one";
$text9="Query Type two";
$text10="Query Type three";
$text11="Query Type four";
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

sub lmz{system("perl $HOME/executables/mtb/QT2.pl")};
sub range{system("perl $HOME/executables/mtb/QT3.pl")};
sub mass{system("perl $HOME/executables/mtb/QT1.pl")};
sub formulae{system("perl $HOME/executables/mtb/QT4.pl")};



