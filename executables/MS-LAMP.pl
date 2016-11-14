use Tk;
use Tk::PNG;
#$HOME="/home/user/MS-LAMP";
$HOME="C:/Users/Dell/Desktop/MS-LAMP/MS-LAMP";
$PDFCOMMAND="evince"; 
# evince is a PDF reader. The user needs to mention the command for the PDF opener to read pdf files associated with this programme.
$STRUCTURECOMMAND="pymol";
#pymol is software used to view mol sructure files. The user needs to install pymol and use the command as above or install a similar software such as JMOL and use corresponding command to view structure.

 
#use Win32::OLE;
use vars qw($mtbimg);
$cover=new MainWindow;
$cover->geometry("1000x620+0+0");
$col = "white";
$col2="black";
$col3="brown";
$col4="navy blue";
$col8="brown";
$col5="navy blue";
$col6="dark grey";
$col7="light grey";
$cover->configure(-background=>$col);
$fonttype="tahoma";
$cover->title("MS - LAMP  : Mass Spectrometry based Lipid(ome) Analyzer & Molecular Platform");
#****************************************MAIN WINDOW DISPLAY**********************************
&mainwindow;

sub mainwindow
{$lamphead=$cover->Frame(-relief=>raised,-highlightbackground =>$col2,-highlightthickness=>'5')->pack(-side=>top,-fill=>x);
$heading=$lamphead->Label(-text=>"M S - L A M P ",-font=>'{times new roman} 40 bold',-background=>$col6,-foreground=>$col4)->pack(-side=>top,-fill=>x);
$heading=$lamphead->Label(-text=>"Mass Spectrometry based Lipid(ome) Analyzer & Molecular Platform\n",-font=>'{times new roman} 20 bold',-background=>$col6,-foreground=>$col5)->pack(-side=>top,-fill=>x);
$space=$cover->Label(-text=>"",-font=>'{times new roman} 15 bold',-background=>$col)->pack(-side=>top,-fill=>x);

$mtbbtn=$cover->Button(-text=>"Click here to search Mycobacterium tuberculosis Lipidome MS-LAMP (2518 lipids)",-font=>'{times new roman} 18 bold',-background=>$col6,-foreground=>$col5,-command=>\&mtb)->pack(-side=>top,-fill=>x);
$mtbsource=$cover->Label(-text=>"Based on database: Mycobacteria Research Laboratories, Colorado State University (www.mrl.colostate.edu)",-font=>'{times new roman} 12 bold',-background=>$col7,-foreground=>$col2,-relief=>raised)->pack(-side=>top,-fill=>x);
$space=$cover->Label(-text=>"\n\n",-font=>'arial 5',-background=>$col)->pack(-side=>top);
$lipidomebtn=$cover->Button(-text=>"Click here to search General Lipidome MS-LAMP (37572 lipids)",-font=>'{times new roman} 18 bold',-relief=>raised,-background=>$col6,-foreground=>$col5,-command=>\&all)->pack(-side=>top,-fill=>x);
$lipidsource=$cover->Label(-text=>"Based on database: LIPID MAPS Consortium (www.lipidmaps.org) ",-font=>'{times new roman} 12 bold',-background=>$col7,-foreground=>$col2,-relief=>raised)->pack(-side=>top,-fill=>x);



$emptylbl=$cover-> Label(-text=>"\n\n",-font=>'arial 5',-background=>$col)->pack(-side=>top,-fill=>x);

$generalintro=$cover->Frame(-background=>$col)->pack(-side=>top,-anchor=>center,-fill=>x);
$generalintro3=$generalintro->Frame(-background=>$col)->pack(-anchor=>center,-fill=>x,-side=>top);
$generalintro1=$generalintro->Frame(-background=>$col)->pack(-anchor=>center,-fill=>x);
$generalinto=$generalintro3->Label(-text=>"A brief overview of this software",-foreground=>$col2,-background=>$col7,-relief=>raised,-font=>"{times new roman} 12 bold")->pack(-fill=>x,-ipady=>4);
#$generalinto=$generalintro1->Button(-text=>"Click here to listen (Audio)",-command=>\&introspeech,-foreground=>$col8,-background=>$col7,-relief=>raised,-font=>"{times new roman} 12 bold")->pack(-anchor=>center,-side=>left,-ipadx=>170);
$generalinto=$generalintro1->Button(-text=>"Click here to read (.pdf) ",-command=>\&s1,-foreground=>$col8,-background=>$col7,-relief=>raised,-font=>"{times new roman} 12 bold")->pack(-fill=>x,-ipadx=>170);

$framelogos=$cover->Frame(-background=>$col)->pack(-side=>top,-fill=>x);
$igib=$framelogos->Photo(-file=>"$HOME/logo/igib.png");
$about=$framelogos->Photo(-file=>"$HOME/logo/about.png");
$help=$framelogos->Photo(-file=>"$HOME/logo/help.png");
$space=$framelogos->Label(-text=>"\n",-background=>$col)->pack(-fill=>'x',-side=>top);
$framelogos1=$framelogos->Frame(-background=>$col)->pack(-side=>top,-anchor=>center);
$helplogo=$framelogos1->Button(-image=>$help,-relief=>raised,-borderwidth=>5,-command=>\&hf)->pack(-side=>left);
$space=$framelogos1->Label(-text=>" ",-background=>$col)->pack(-side=>left);
$igiblogo=$framelogos1->Label(-image=>$igib,-relief=>raised,-borderwidth=>5)->pack(-side=>left);
$space=$framelogos1->Label(-text=>" ",-background=>$col)->pack(-side=>left);
$aboutlogo=$framelogos1->Button(-image=>$about,-relief=>raised,-borderwidth=>5,-command=>\&aboutinfo)->pack(-side=>left);

}


MainLoop;

sub s1
{system("$PDFCOMMAND $HOME/Help/S123.pdf");}

sub hf
{system("$PDFCOMMAND $HOME/Help/Help.pdf");}

sub aboutinfo
{$aboutwindow=$cover->Toplevel();
$aboutwindow->geometry("650x500+200+0");
$aboutwindow->title("MS - LAMP  : Mass Spectrometry based Lipid(ome) Analyzer & Molecular Platform - Version 1.0");
$aboutwindow->configure(-background=>$col);
$head=$aboutwindow->Label(-text=>"Mass Spectrometry based Lipid(ome) Analyzer & Molecular Platform (MS-LAMP)",-font=>'{$fonttype} 12 bold',-background=>$col)->pack(-side=>top);
$aid=$aboutwindow->Label(-text=>"can be used to aid analysis and interpretation of electrospray ionization (ESI) and\n matrix assisted laser desorption and ionization (MALDI) mass spectrometric data of lipid(s/ome)",-font=>'{$fonttype} 10',-background=>$col)->pack(-side=>top);

$emptylblrog=$aboutwindow-> Label(-text=>"\n\n",-font=>'$fonttype 5',-background=>$col)->pack(-side=>top,-fill=>x);
$programmedby=$aboutwindow->Label(-background=>$col,-text=>"Programmed by",-font=>'{$fonttype} 11 bold underline')->pack(-side=>top); 
$programmedaid=$aboutwindow->Label(-background=>$col,-text=>"Gurpreet Singh",-font=>'{$fonttype} 11')->pack(-side=>top); 
$programmedcol=$aboutwindow->Label(-background=>$col,-text=>"Lovely Professional University, Punjab",-font=>'{$fonttype} 10')->pack(-side=>top); 
$researchsuperby=$aboutwindow->Label(-background=>$col,-text=>"\n\nResearch, Conception and Guidance",-font=>'{$fonttype} 11 bold underline')->pack(-side=>top); 
$researchsuperaid=$aboutwindow->Label(-background=>$col,-text=>"Dr. V. Sabareesh",-font=>'{$fonttype} 11')->pack(-side=>top); 
$researchsuperaid=$aboutwindow->Label(-background=>$col,-text=>"Scientist\nCouncil of Scientific and Industrial Research (CSIR) -\nInstitute of Genomics and Integrative Biology (IGIB) \nA93-94 Naraina Industrial Area, Phase 1, Naraina, New Delhi",-font=>'{times new roman} 10')->pack(-side=>top); 
$acknowledgementsfor=$aboutwindow->Label(-background=>$col,-text=>"\n\nAcknowledgements",-font=>'{$fonttype} 11 bold underline')->pack(-side=>top); 
$acknowledgementsname=$aboutwindow->Label(-background=>$col,-text=>"Mohit Ohri, Varun Suroliya,\n Karishma Jasrotia, Varinder Tinna, Tavleen Kaur",-font=>'{$fonttype} 11')->pack(-side=>top); 
$date=$aboutwindow->Label(-background=>$col,-text=>"\n\nstarted July 2011, Updated upto November 2012",-font=>'{$fonttype} 11')->pack(-side=>top); 

}
sub mtb{system("perl $HOME/executables/mtb/mtb.pl")};
sub all{system("perl $HOME/executables/all/all.pl")};
sub introspeech()
 {
$text = "Hi ! Welcome to , MS - LAMP :  Mass Spectrometry based Lipidome Analyzer & Molecular Platform . This Sofware has been developed to enable ,the identification of lipids from the data obtained from , Mass Spectrometry . The software consists of 2 databases, one ,Mycobacterium tuberculosis MS LAMP  and, two, General Lipidome MS LAMP. 
These databases have been divided into eight categories . The categories are , Fattee acyls , Glycerolipids , Glycerophospho lipids , Polyketides , Prenol lipids , Saccharo lipids , Sphingo lipids and Sterol Lipids. The, Mycobacterium tuberculosis button ,can be cliked to search within the database of , Mycobacterium tuberculosis , containing  two thousand five hundered and eighteen lipids. Following this, you will be re-directed to Mycobacterium tuberculosis lipidome search window , containing variety of search options. Similarly ,The , General Lipidome MS LAMP, button can be clicked to search across , thirty seven thousand five hundered and seventy two, lipids. Following this , you will be directed to General lipidome MS-LAMP search window . If you want me to repeat  , Click me Again. Thank you! ";
$tts = Win32::OLE->new("SAPI.SpVoice") or die "Sapi.SpVoice failed";
$tts->{Rate}=-2;
$tts->{Volume}=200000;
$tts->Speak("$text");
};
sub lipidomespeech()
 {
$text = "The Button Below can be cliked to search across , thirty thousand four hundered and seventy six, lipids , divided into various categories.
	The categories are , Fatti acyls , Glycero lipids , Glycero phospho lipids , Sphingo lipids , Sterol Lipids , Saccharo lipids , Prenol lipids & Polyketides .
	Following this you will be re-directed to window ,  containing variety of search options. To repeat , Click me Again. Thank you";
$tts = Win32::OLE->new("SAPI.SpVoice") or die "Sapi.SpVoice failed";
$tts->{Rate}=-1;
$tts->{Volume}=200000;
$tts->Speak("$text");
};
sub mtbspeech
{
$text = "The Button Below can be cliked to search within the database of ,Mycobacterium tuberculosis , containing  two thousand five hundered and eighteen lipids.
	Following this you will be re-directed to window ,  containing variety of search options. To repeat  , Click me Again. Thank you!";

$tts = Win32::OLE->new("SAPI.SpVoice") or die "Sapi.SpVoice failed";
$tts->{Rate}=-1;
$tts->{Volume}=200000;
$tts->Speak("$text");
};
