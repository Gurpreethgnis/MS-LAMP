#!/usr/local/bin/perl

use Tk;
use Tk::MainWindow;
use Tk::Photo;
use Tk::Entry;
use Tk::Button;
use Tk::Menu;
use Tk::Menubutton;
use Tk::Widget ;
use Tk::Toplevel;
use Tk::Text;
use Tk::Scrollbar;
use Tk::Radiobutton;
use Tk::Checkbutton;
use Tk::NoteBook;
use Tk::Frame;
use Tk::MainWindow;
use Tk::ROText;
use Tk::Balloon;
use Tk::Dialog;
use Tk::DialogBox;
use Tk;
use Tk::PNG;


$HOME="/home/user/MS-LAMP";
#Provide the path for MS-LAMP here.

$PDFCOMMAND="evince"; 
# evince is a PDF reader. The user needs to mention the command for the PDF opener to read pdf files associated with this programme.
$STRUCTURECOMMAND="shotwell";
#shotwell is software used to view image files. The user needs to install shotwell and use the command as above or install a similar software and use corresponding command to view structure.

use vars qw($HOME $PDFCOMMAND $STRUCTURECOMMAND);



#use Spreadsheet::WriteExcel;
#use Spreadsheet::WriteExcel::Chart::Column;
#use Spreadsheet::WriteExcel::Chart::Pie;
use vars qw(@uppermz @lowermz $mass $gp $gl $pk $pr $round $st $cq $sfl $mac $mak $mono $di $diac $diak $diacak $diakac $tri $triac $all $spl $opl $flor $clor $brom $iod $sl $sp $workbook);
use vars qw($counterkpos $counter2khpos $counterk2hneg $counter2lihpos $counterlipos $counterli2hneg $countermhpos $countermampos $counternapos $counternahpos $countermhneg $counterachneg $counternahneg $countermmass $counterclneg);
use vars qw($massentered $range @mzval $lenmz $counterentirelipidome $activeoptionone $activeoptiontwo $masschoice);
use vars qw($open $relativeintensityvalue @lstrcq $lstrcq $ogll $lstrogll);
use vars qw($countersulfo $countermonoglycero $counterdiglycero  $countertriglycero  $countermainhalo $countermainglycero $countermainphospho $countercustomcheck $countersphingophospho $counterglycerophospho $counterotherphospho);

#**************************** Main Window Display********************************
$m = new MainWindow;
$m->geometry("1010x630+0+0");
$fontty="times new roman";
$col="white";
$col1="dark grey";
$col2="light grey";
$col3="brown";
$col4="black";
$col5="navy blue";
$m->configure(-background=>$col);
&rangemain;

MainLoop;

#************** call to conversion of files to hashes**********************************


#******************** Main Window Display to enter mass*****************************

sub rangemain
{$fontty="times new roman";
$col="white";
$col1="dark grey";
$col2="light grey";
$col3="brown";
$col4="black";
$col5="navy blue";

	$counterentirelipidome=0;$counterfasearch=0;$countergpsearch=0;$counterglsearch=0;$counterstsearch=0;
	$counterspsearch=0;$counterslsearch=0;$counterpksearch=0;$counterprsearch=0;
	$countermainphospho=0;$countersphingophospho=0;
	$countersulfo =0;$countermonoglycero =0; $counterdiglycero =0;  $countertriglycero =0; $countermainhalo=0;$countermainglycero=0;$countermainphospho=0;$countercustomcheck=0; $countersphingophospho=0; $counterotherphospho =0;
	$counterotherglycero=0;$countermainglycero=0;	
	$counter2lihpos=0;$counterlipos=0;$counterli2hneg=0;$countermhpos=0;$countermampos=0;$counternapos=0;$counternahpos=0;$countermhneg=0;$counterachneg=0;$counternahneg=0;$countermmass=0;$counterclneg=0;
	$counterkpos=0;$counter2khpos=0;$counterk2hneg=0;$mass=0;@mz=@mzval=@intensity=@relative=@charge="";

	
	$m->title("MS - LAMP - M. tb Lipidome MS-LAMP - Query Type 2 : List of Molecular Masses or m/z values ");
	$sfmn=$m->Label( -text=>"Query Type 2 : List of Molecular Masses or m/z values ",-font=>"{$fontty} 18 bold",-background =>$col1,-foreground =>$col5,-relief => ridge,-borderwidth=>3)
			->pack(-side=>top,-fill=>x);
	$fc=$m->Frame(-background=>white,-foreground=>black)->pack(-side=>top,-fill=>x);
		
	&bothcheck;

	sub bothcheck
	{$activeoptionone=$activeoptiontwo=0;
	$frameboth=$fc->Frame(-background=>$col2)->pack(-side=>top,-fill=>x);
	$frameboth1=$frameboth->Frame(-background=>$col2)->pack(-side=>top,-fill=>x,-anchor=>center);
	$frameboth2=$frameboth->Frame(-background=>$col2)->pack(-side=>top,-fill=>x,-anchor=>center);

	$space=$frameboth1->Label(-text=>"",-background=>$col2)->pack(-side=>top);
	$message=$frameboth1->Label(-text=>"" ,-background=>$col2,-foreground=>"navy blue",-font=>"tahoma 12 bold")->pack(-side=>left);
	$message=$frameboth1->Label(-text=>"          To upload .txt file of Molecular Masses or m/z values " ,-background=>$col2,-foreground=>$col3,-font=>"{$fontty} 12")->pack(-side=>left);
	$choice1=$frameboth1->Checkbutton(-text=>"Molecular Mass or m/z & no intensity values ",-font=>"{$fontty} 10",-background=>$col2,-foreground=>$col4,-command=>\&frameonecall)->pack(-side=>left);
	$choiceblank=$frameboth1->Label(-text=>"",-font=>"{$fontty} 10",-background=>$col2,-foreground=>$col4)->pack(-side=>left);
	$choice2=$frameboth1->Checkbutton(-text=>"To set user-defined threshold for relative intensity (%)",-font=>"{$fontty} 10",-background=>$col2,-foreground=>$col4,-command=>\&frametwocall)->pack(-side=>left);
	$choiceblank=$frameboth2->Label(-text=>"(Not for Molecular Masses, only for m/z values)                      ",-font=>"{$fontty} 10",-background=>$col2,-foreground=>"navy blue")->pack(-side=>bottom,-anchor=>e);
	}
	sub frameone
	{$activeoptionone=1;$activeoptiontwo=0;
	$frameone=$fc->Frame(-background=>$col2)->pack(-side=>top,-fill=>x,-anchor=>center);
	$frameone1=$frameone->Frame(-background=>$col2)->pack(-side=>top,-fill=>x,-anchor=>center);
	$frameone2=$frameone->Frame(-background=>$col2)->pack(-side=>top,-fill=>x,-anchor=>center);
	$frameone3=$frameone->Frame(-background=>$col2)->pack(-side=>top,-anchor=>center);
	$goback=$frameone1->Button(-text=>"Back",-font=>"{$fontty} 12 bold",-background=>$col1,-foreground=>$col3,-command=>\&mainchoice)->pack(-side=>top,-fill=>x,-anchor=>center);
	$choice1=$frameone2->Label(-text=>"To upload .txt file containing Molecular Mass or m/z & no intensity values",-background=>$col2,-foreground=>$col4,-font=>"{$fontty} 12 bold")->pack(-side=>top);
	$fileupload=$frameone2->Button(-text=>"Click here to upload .txt file",-font=>"{$fontty} 12 bold",-background=>$col1,-foreground=>$col3,-command=>\&choosefile)->pack(-side=>top,-fill=>x);
	$masschoice=0;
	$monoiso=$frameone3->Radiobutton(-text=>"Monoisotopic  ",-font=>"{times new roman} 10 bold",-value=>"0",-variable=>\$masschoice,-foreground=>$col4,-background=>$col2)->pack(-side=>left,-anchor=>center);
	$averagemass=$frameone3->Radiobutton(-text=>"Average  ",-font=>"{times new roman} 10 bold",-value=>"1",-variable=>\$masschoice,-foreground=>$col4,-background=>$col2)->pack(-side=>left,-anchor=>center);

	}
	sub frametwo
	{$activeoptionone=0;$activeoptiontwo=1;
	$frametwo=$fc->Frame(-background=>$col2)->pack(-side=>top,-fill=>x,-anchor=>center);
	$frametwo1=$frametwo->Frame(-background=>$col2)->pack(-side=>top,-fill=>x,-anchor=>center);
	$frametwo2=$frametwo->Frame(-background=>$col2)->pack(-side=>top,-fill=>x,-anchor=>center);
	$frametwo3=$frametwo->Frame(-background=>$col2)->pack(-side=>top,-anchor=>center);	
	$goback=$frametwo1->Button(-text=>"Back",-background=>$col1,-font=>"{$fontty} 8 bold",-foreground=>$col3,-command=>\&mainchoice)->pack(-side=>top,-fill=>x,-anchor=>center);
	$scroll=$frametwo2->Frame(-background=>$col2)->pack(-side=>top,-fill=>x);
	$labelofscroll =$scroll->Label(-text=> "User-Defined Threshold for Relative Intensity (%)",-font=>"arial 8 bold",-background=>$col2,-foreground=>$col4)->pack(-side=>top);
	$scl =$scroll-> Scale(-orient=>'h', -digit=>1,-from=>5, -to=>99,-variable=>\$relativeintensityvalue, -tickinterval=>5,-background=>$col1,-foreground=>$col4)->pack(-side=>top,-ipadx=>20,-anchor=>center,-fill=>x);			
	$fileupload=$frametwo->Button(-text=>"Click here to upload .txt file containing m/z & relative intensity values",-font=>"{tahoma} 8 bold",-background=>$col1,-foreground=>$col3,-command=>\&choosefile)->pack(-side=>top,-fill=>x);
	$masschoice=0;
	$monoiso=$frametwo3->Radiobutton(-text=>"Monoisotopic ",-font=>"{times new roman} 10 bold",-value=>"0",-variable=>\$masschoice,-foreground=>$col4,-background=>$col2)->pack(-side=>left,-anchor=>center);
	$averagemass=$frametwo3->Radiobutton(-text=>"Average ",-font=>"{times new roman} 10 bold",-value=>"1",-variable=>\$masschoice,-foreground=>$col4,-background=>$col2)->pack(-side=>left,-anchor=>center);

	}
	sub mainchoice{ if($activeoptionone eq 0 &&$activeoptiontwo eq 1){&packforgettwo;&bothcheck;};
			if($activeoptionone eq 1 &&$activeoptiontwo eq 0){&packforgetone;&bothcheck;}}			
	sub frameonecall{&packforgetboth;&frameone;}
	sub frametwocall{&packforgetboth;&frametwo;}
	sub packforgetboth{$frameboth->packForget();}
	sub packforgetone{$frameone->packForget();}
	sub packforgettwo{$frametwo->packForget();}
	$iontype=$m->Label(-text=>"Choose Molecular Mass / Type of Ion",-font=>"arial 10 bold",-background=>$col1,-foreground=>$col4)->pack(-side=>top,-anchor=>center,-fill=>x);
	$frameiontype=$m->Frame(-background=>white,-foreground=>black)->pack(-side=>top,-anchor=>center);
	$windowrange=$m->Label     (-text=>"Window Range (+/-)",-font=>"arial 10 bold",-background=>$col1,-foreground=>$col4)->pack(-side=>top,-anchor=>center,-fill=>x);
	$framewrange=$m->Frame()->pack(-side=>top,-anchor=>center);
	$range="0.5";
		$mbyz=$framewrange->Label(-text=>"Molecular Mass or m/z  :   ",-font=>"{calibri} 10 bold",-activebackground=>"sky blue",-foreground=>black,-background=>white)->pack(-side=>left);
		$pointzz5=$framewrange->Radiobutton(-text=>"0.005 ",-font=>"{calibri} 10 bold",-activebackground=>"sky blue",-value=>"0.005",-variable=>\$range,-foreground=>black,-background=>white)->pack(-side=>left);
		$pointz1=$framewrange->Radiobutton(-text=>"0.01 ",-font=>"{calibri} 10 bold",-activebackground=>"sky blue",-value=>"0.01",-variable=>\$range,-foreground=>black,-background=>white)->pack(-side=>left);
		$pointz5=$framewrange->Radiobutton(-text=>"0.05 ",-font=>"{calibri} 10 bold",-activebackground=>"sky blue",-value=>"0.05",-variable=>\$range,-foreground=>black,-background=>white)->pack(-side=>left);
		$point1=$framewrange->Radiobutton(-text=>"0.1 ",-font=>"{calibri} 10 bold",-activebackground=>"sky blue",-value=>"0.1",-variable=>\$range,-foreground=>black,-background=>white)->pack(-side=>left);
		$point25=$framewrange->Radiobutton(-text=>"0.25 ",-font=>"{calibri} 10 bold",-activebackground=>"sky blue",-value=>"0.25",-variable=>\$range,-foreground=>black,-background=>white)->pack(-side=>left);
		$point5=$framewrange->Radiobutton(-text=>"0.5 ",-font=>"{calibri} 10 bold",-activebackground=>"sky blue",-value=>"0.5",-variable=>\$range,-foreground=>black,-background=>white)->pack(-side=>left);
		$point75=$framewrange->Radiobutton(-text=>"0.75 ",-font=>"{calibri} 10 bold",-activebackground=>"sky blue",-value=>"0.75",-variable=>\$range,-foreground=>black,-background=>white)->pack(-side=>left);
		$pointone=$framewrange->Radiobutton(-text=>"1 ",-font=>"{calibri} 10 bold",-activebackground=>"sky blue",-value=>"1",-variable=>\$range,-foreground=>black,-background=>white)->pack(-side=>left);
$fontsizz=8.5;

	$searchcriterion=$m->Label(-text=>"Which Lipid(s) ?",-font=>"{fontty} 10 bold",-foreground=>$col4,-background=>$col1)->pack(-side=>top,-anchor=>center,-fill=>x);
	$upframesearch=$m->Frame(-background=>white)->pack(-side=>top,-anchor=>center);
	$entirelipidome=$upframesearch->Checkbutton(-text=>"All eight categories ",-activebackground=>"sky blue",-font=>"arial 11 bold",-foreground=>black,-background=>white,-command=>\&entirelipidomesearchdis)->pack(-side=>left,-anchor=>center);

	$aboutlipid=$upframesearch->Button(-text=>"About lipid categories",-font=>"arial $fontsizz bold",-foreground=>$col3,-background=>$col1,-command=>\&mlt)->pack(-side=>left,-anchor=>center);
	$framesearch=$m->Frame(-background=>white)->pack(-side=>top,-anchor=>center);

		$fasearch=$framesearch->Checkbutton(-text=>" FA ",-font=>"arial 10 bold",-activebackground=>"sky blue",-foreground=>black,-background=>"white",-command=>\&fasearchdis)->pack(-side=>left,-anchor=>center);
		$glsearch=$framesearch->Checkbutton(-text=>" GL ",-font=>"arial 10 bold",-activebackground=>"sky blue",-foreground=>black,-background=>"white",-command=>\&mainglycerodis)->pack(-side=>left,-anchor=>center);		
		$gpsearch=$framesearch->Checkbutton(-text=>" GP ",-font=>"arial 10 bold",-activebackground=>"sky blue",-foreground=>black,-background=>"white",-command=>\&gpsearchdis)->pack(-side=>left,-anchor=>center);
		$pksearch=$framesearch->Checkbutton(-text=>" PK ",-font=>"arial 10 bold",-foreground=>black,-activebackground=>"sky blue",-background=>"white",-command=>\&pksearchdis)->pack(-side=>left,-anchor=>center);
		$prsearch=$framesearch->Checkbutton(-text=>" PR ",-font=>"arial 10 bold",-foreground=>black,-activebackground=>"sky blue",-background=>"white",-command=>\&prsearchdis)->pack(-side=>left,-anchor=>center);
		$slsearch=$framesearch->Checkbutton(-text=>" SL ",-font=>"arial 10 bold",-foreground=>black,-activebackground=>"sky blue",-background=>"white",-command=>\&slsearchdis)->pack(-side=>left,-anchor=>center);
		$spsearch=$framesearch->Checkbutton(-text=>" SP ",-font=>"arial 10 bold",-foreground=>black,-activebackground=>"sky blue",-background=>"white",-command=>\&spsearchdis)->pack(-side=>left,-anchor=>center);
		$stsearch=$framesearch->Checkbutton(-text=>" ST ",-font=>"arial 10 bold",-foreground=>black,-activebackground=>"sky blue",-background=>"white",-command=>\&stsearchdis)->pack(-side=>left,-anchor=>center);
	$spacebphospho=$m->Label(-text=>"___________________________________________________________________________________________________________________________________________________",-background=>white,-foreground=>$col4)->pack(-side=>top);
	$framecombo1=$m->Frame(-background=>white)->pack(-side=>top,-anchor=>center,-fill=>x);
		$framephospho=$framecombo1->Frame(-background=>white)->pack(-side=>left,-anchor=>center);
			$mainphospho=$framephospho->Checkbutton(-text=>"All Phospholipids ",-activebackground=>"sky blue",-font=>"arial 11 bold",-foreground=>black,-background=>white,-command=>\&mainphosphodis)->pack(-side=>top,-anchor=>center,-ipadx=>150);
			$spacephospho=$framephospho->Label(-text=>"\t\t",-font=>"arial 10",-foreground=>black,-background=>white)->pack(-side=>left,-anchor=>center);
$spaceafterphospho=$framephospho->Label(-text=>"          ",-font=>"arial 12 ",-foreground=>black,-background=>white)->pack(-side=>left,-anchor=>center);
			$sphingophospho=$framephospho->Checkbutton(-text=>"Sphingo ",-activebackground=>"sky blue",-font=>"arial 10",-foreground=>black,-background=>white,-command=>\&sphingophosphodis)->pack(-side=>left,-anchor=>center);
			$otherphospho=$framephospho->Checkbutton(-text=>"Other Phosphorylated lipids ",-activebackground=>"sky blue",-font=>"arial 10 ",-foreground=>black,-background=>white,-command=>\&otherphosphodis)->pack(-side=>left,-anchor=>center);
			$spaceafterphospho=$framephospho->Label(-text=>"( Excluding ",-font=>"arial 10",-foreground=>black,-background=>white)->pack(-side=>left,-anchor=>center);
			$spaceafterphospho=$framephospho->Label(-text=>"GP",-font=>"arial 10 bold",-foreground=>black,-background=>white)->pack(-side=>left,-anchor=>center);
			$spaceafterphospho=$framephospho->Label(-text=>")",-font=>"arial 10 ",-foreground=>black,-background=>white)->pack(-side=>left,-anchor=>center);
			$framespacer=$framecombo1->Frame(-background=>white)->pack(-side=>left,-anchor=>center);
			$spacerglycerophospho=$framespacer->Label(-text=>"  |",-font=>"arial 30",-foreground=>$col4,-background=>white)->pack(-side=>left,-anchor=>center);
$framelabelspace=$framecombo1->Label(-text=>"",-background=>white)->pack(-side=>left);
			$frameglycero=$framecombo1->Frame(-background=>white)->pack(-side=>left);
			$mainglycero=$frameglycero->Label(-text=>"Glycerolipids [GL]",-font=>"arial 11 bold",-foreground=>black,-background=>white)->pack(-side=>top);
			$monoglycero=$frameglycero->Checkbutton(-text=>"Monoglycerides [MG]",-activebackground=>"sky blue",-font=>"arial 8",-foreground=>black,-background=>white,-command=>\&monoglycerodis)->pack(-side=>left);
			$diglycero=$frameglycero->Checkbutton(-text=>"Diglycerides [DG]",-activebackground=>"sky blue",-font=>"arial 8",-foreground=>black,-background=>white,-command=>\&diglycerodis)->pack(-side=>left);
			$triglycero=$frameglycero->Checkbutton(-text=>"Triglycerides [TG]",-activebackground=>"sky blue",-font=>"arial 8",-foreground=>black,-background=>white,-command=>\&triglycerodis)->pack(-side=>left);	
			$otherglycero=$frameglycero->Checkbutton(-text=>"Other Glycerolipids",-activebackground=>"sky blue",-font=>"arial 8",-foreground=>black,-background=>white,-command=>\&otherglycerodis)->pack(-side=>left);	

$spaceaphospho=$m->Label(-text=>"___________________________________________________________________________________________________________________________________________________",-background=>white,-foreground=>$col4)->pack(-side=>top);
		
		$framecombo2=$m->Frame(-background=>white)->pack(-side=>top,-fill=>x);
			
		$framelabelspace=$framecombo2->Label(-text=>"        ",-background=>white)->pack(-side=>left);
		$framehalo=$framecombo2->Frame(-background=>white)->pack(-side=>left,-anchor=>center);
			$mainhalo=$framehalo->Checkbutton(-text=>"Halogenated Lipids ",-activebackground=>"sky blue",-font=>"arial 11 bold",-foreground=>black,-background=>white,-command=>\&mainhalodis)->pack(-side=>left,-anchor=>center,-ipadx=>140);
			$framelabelspace=$framehalo->Label(-text=>"         ",-background=>white)->pack(-side=>left);
			
		
			$spacerglycero=$framehalo->Label(-text=>"|",-font=>"arial 30",-foreground=>$col4,-background=>white)->pack(-side=>left,-anchor=>center);
			$framelabelspace=$framehalo->Label(-text=>"                                         ",-background=>white)->pack(-side=>left);
			$framesulfo=$framecombo2->Frame(-background=>white)->pack(-side=>left,-anchor=>center);
	$sulfo=$framesulfo->Checkbutton(-text=>"Sulphur containing lipids",-activebackground=>"sky blue",-font=>"arial 11 bold",-foreground=>black,-background=>white,-command=>\&sulfodis)->pack(-side=>left,-anchor=>center);	
	$spacebcustom=$m->Label(-text=>"___________________________________________________________________________________________________________________________________________________",-background=>white,-foreground=>$col4)->pack(-side=>top);
	$framecustom=$m->Frame(-background=>white)->pack(-side=>top,-anchor=>center);
	$customcheck=$framecustom->Checkbutton(-text=>"Search within Main Class and/or Subclass",-activebackground=>"sky blue",-font=>"arial 10 bold",-foreground=>"black",-background=>white,-command=>\&customcheckdis)->pack(-side=>left,-anchor=>center);
	$customenter=$framecustom->Entry()->pack(-side=>left);
	$customhelp=$framecustom->Button(-text=>"Need Help ?",-font=>"{fontty} 8 bold",-background=>$col2,-foreground=>$col3,-command=>\&s10)->pack(-side=>left);
	
	$b=$m->Button(-text=>"SUBMIT",-font=>"{comic sans} 12 bold",-background =>$col4 ,-foreground =>$col,-relief => raised,-command=> \&searching)
			->pack(-side=>top,-anchor=>center,-fill=>x);

&checkbuttons;
};

sub s10
{system("$PDFCOMMAND $HOME/Help/S10_mtb.pdf");}

sub mlt { 	
$table=$m->Toplevel();
$imgshw =$table->Photo(-file=>"$HOME/data/mtb/M_L_T.PNG");
$table->title("Eight-category classification of Lipids \(Mycobacterium tuberculosis lipidome MS-LAMP\)");

$imgshow=$table->Label(-image=>$imgshw,-relief=>'raised',-borderwidth=>'5')->pack(-side=>top);

};

#**************************************subroutine to forget the rangemain*********************************************
sub entriesrangemain
{	$sfmn->packForget();
	$fc->packForget();
	$iontype->packForget();
	$frameiontype->packForget();
	$windowrange->packForget();
	$framewrange->packForget();
	$searchcriterion->packForget();
		$upframesearch->packForget();
	$framesearch->packForget();
	$spacebphospho->packForget();
	$framecombo1->packForget();
	$framecombo2->packForget();
	$spaceaphospho->packForget();
	$spacebcustom->packForget();
	$framecustom->packForget();

	$b->packForget();
	$frameglycero->packForget();

};

sub entirelipidomesearchdis
{
	$fasearch->configure(-state=>'disabled');
	$gpsearch->configure(-state=>'disabled');
	$glsearch->configure(-state=>'disabled');
	$stsearch->configure(-state=>'disabled');
	$slsearch->configure(-state=>'disabled');
	$spsearch->configure(-state=>'disabled');
	$prsearch->configure(-state=>'disabled');
	$pksearch->configure(-state=>'disabled');
	$mainphospho->configure(-state=>'disabled');
	$sphingophospho->configure(-state=>'disabled');

	$otherphospho->configure(-state=>'disabled');
	$monoglycero->configure(-state=>'disabled');
	$otherglycero->configure(-state=>'disabled');
	$diglycero->configure(-state=>'disabled');
	$triglycero->configure(-state=>'disabled');
	$mainhalo->configure(-state=>'disabled');
	$sulfo->configure(-state=>'disabled');
	$customcheck->configure(-state=>'disabled');
	$customhelp->configure(-state=>'disabled');
	$entirelipidome->configure(-command=>\&countertallyentire);
	$counterentirelipidome=1;
}

sub countertallyentire{$counterentirelipidome=0;&searchallact;$entirelipidome->configure(-command=>\&entirelipidomesearchdis);}


sub fasearchdis
{	
	$entirelipidome->configure(-state=>'disabled');
	$fasearch->configure(-command=>\&countertallyfa);
	$counterfasearch=1;
}

sub countertallyfa{$counterfasearch=0;&searchallact;$fasearch->configure(-command=>\&fasearchdis);}

sub gpsearchdis
{
	$entirelipidome->configure(-state=>'disabled');
	$mainphospho->configure(-state=>'disabled');
	$gpsearch->configure(-command=>\&countertallygp);
	$countergpsearch=1;
}

sub countertallygp{$countergpsearch=0;&searchallact;$gpsearch->configure(-command=>\&gpsearchdis);}

sub glsearchdis
{	$entirelipidome->configure(-state=>'disabled');
	$glsearch->configure(-command=>\&countertallygl);
	$countermainglycero=1;
}

sub countertallygl{$countermainglycero=0;&searchallact;$glsearch->configure(-command=>\&glsearchdis);}

sub stsearchdis
{	
	$entirelipidome->configure(-state=>'disabled');
	$stsearch->configure(-command=>\&countertallyst);
	$counterstsearch=1;
}

sub countertallyst{$counterstsearch=0;&searchallact;$stsearch->configure(-command=>\&stsearchdis);}

sub slsearchdis
{
	$entirelipidome->configure(-state=>'disabled');
	$slsearch->configure(-command=>\&countertallysl);
	$counterslsearch=1;
}

sub countertallysl{$counterslsearch=0;&searchallact;$slsearch->configure(-command=>\&slsearchdis);}

sub pksearchdis
{
	$entirelipidome->configure(-state=>'disabled');
	$pksearch->configure(-command=>\&countertallypk);
	$counterpksearch=1;
}

sub countertallypk{$counterpksearch=0;&searchallact;$pksearch->configure(-command=>\&pksearchdis);}

sub prsearchdis
{
	$entirelipidome->configure(-state=>'disabled');
	$prsearch->configure(-command=>\&countertallypr);
	$counterprsearch=1;
}

sub countertallypr{$counterprsearch=0;&searchallact;$prsearch->configure(-command=>\&prsearchdis);}

sub spsearchdis
{
	$entirelipidome->configure(-state=>'disabled');
	$spsearch->configure(-command=>\&countertallysp);
	$counterspsearch=1;
}

sub countertallysp{$counterspsearch=0;&searchallact;$spsearch->configure(-command=>\&spsearchdis);}

sub mainphosphodis
{
	$entirelipidome->configure(-state=>'disabled');
	$sphingophospho->configure(-state=>'disabled');
	$gpsearch->configure(-state=>'disabled');
	$otherphospho->configure(-state=>'disabled');
	$countermainphospho=1;
	
	$mainphospho->configure(-command=>\&countertallymainphospho);	
}

sub countertallymainphospho{$countermainphospho=0;&searchallact;$mainphospho->configure(-command=>\&mainphosphodis);}

sub sphingophosphodis
{
	$entirelipidome->configure(-state=>'disabled');
	$mainphospho->configure(-state=>'disabled');
	$countersphingophospho=1;
	$sphingophospho->configure(-command=>\&countertallysphingophospho);
}

sub countertallysphingophospho{$countersphingophospho=0;&searchallact;$sphingophospho->configure(-command=>\&sphingophosphodis);}

sub otherphosphodis
{
	$entirelipidome->configure(-state=>'disabled');
	$mainphospho->configure(-state=>'disabled');
	$counterotherphospho=1;
	$otherphospho->configure(-command=>\&countertallyotherphospho);
}

sub countertallyotherphospho{$counterotherphospho=0;&searchallact;$otherphospho->configure(-command=>\&otherphosphodis);}

sub mainglycerodis
{
	$entirelipidome->configure(-state=>'disabled');
	$otherglycero->configure(-state=>'disabled');
	$diglycero->configure(-state=>'disabled');
	$triglycero->configure(-state=>'disabled');
	$monoglycero->configure(-state=>'disabled');
	$countermainglycero=1;
	$glsearch->configure(-command=>\&countertallymainglycero);	
}

sub countertallymainglycero{$countermainglycero=0;&searchallact;$glsearch->configure(-command=>\&mainglycerodis);}

sub monoglycerodis
{
	$entirelipidome->configure(-state=>'disabled');
	$glsearch->configure(-state=>'disabled');
	$countermonoglycero=1;
	$monoglycero->configure(-command=>\&countertallymonoglycero);
}

sub countertallymonoglycero{$countermonoglycero=0;&searchallact;$monoglycero->configure(-command=>\&monoglycerodis);}

sub diglycerodis
{
	$entirelipidome->configure(-state=>'disabled');
	$glsearch->configure(-state=>'disabled');
	$counterdiglycero=1;
	$diglycero->configure(-command=>\&countertallydiglycero);
}

sub countertallydiglycero{$counterdiglycero=0;&searchallact;$diglycero->configure(-command=>\&diglycerodis);}

sub triglycerodis
{
	$entirelipidome->configure(-state=>'disabled');
	$glsearch->configure(-state=>'disabled');
	$countertriglycero=1;
	$triglycero->configure(-command=>\&countertallytriglycero);
}

sub countertallytriglycero{$countertriglycero=0;&searchallact;$triglycero->configure(-command=>\&triglycerodis);}

sub otherglycerodis
{
	$entirelipidome->configure(-state=>'disabled');
	$glsearch->configure(-state=>'disabled');
	$counterotherglycero=1;
	$otherglycero->configure(-command=>\&countertallyotherglycero);
}

sub countertallyotherglycero{$counterotherglycero=0;&searchallact;$otherglycero->configure(-command=>\&otherglycerodis);}

#*****************************halogenation subroutines********************************************

sub mainhalodis
{$entirelipidome->configure(-state=>'disabled');
$countermainhalo=1;
$mainhalo->configure(-command=>\&countertallymainhalo);

}

sub countertallymainhalo{$countermainhalo=0;&searchallact;$mainhalo->configure(-command=>\&mainhalodis);}



sub sulfodis
{
	$entirelipidome->configure(-state=>'disabled');
	$countersulfo=1;
	$sulfo->configure(-command=>\&countertallysulfo);
}

sub countertallysulfo{$countersulfo=0;&searchallact;$sulfo->configure(-command=>\&sulfodis);}




sub customcheckdis
{
	$entirelipidome->configure(-state=>'disabled');
	$countercustomcheck=1;
	$customcheck->configure(-command=>\&countercustomcheck);
	
}

sub countercustomcheck{$countercustomcheck=0;&searchallact;$customcheck->configure(-command=>\&customcheckdis);}

sub searchallact
{

#***************************************glycero checkbuttons*********************************************

if (($countermonoglycero eq 1) | ($counterdiglycero eq 1) | ($countertriglycero eq 1) | ($counterotherglycero eq 1))
	{
	$glsearch->configure(-state=>'disabled');
	}
elsif (($countermonoglycero eq 0) && ($counterdiglycero eq 0) && ($countertriglycero eq 0) && ($counterotherglycero eq 0))
	{
	$glsearch->configure(-state=>'active');
	}

if ($countermainglycero eq 0)
	{
	$monoglycero->configure(-state=>'active');
	$diglycero->configure(-state=>'active');
	$triglycero->configure(-state=>'active');
	$otherglycero->configure(-state=>'active');
	}
elsif ($countermainglycero eq 1)
	{
	$monoglycero->configure(-state=>'disabled');
	$diglycero->configure(-state=>'disabled');
	$triglycero->configure(-state=>'disabled');
	$otherglycero->configure(-state=>'disabled');
	}
#******************************************end of glycero checkbuttons**********************************


#*******************************phopho groups************************************************************
#*******************************disables when one of the phospho groups are active******************************

if ($countersphingophospho eq 1 | $countergpsearch eq 1 | $counterotherphospho eq 1)
	{
	$mainphospho->configure(-state=>'disabled');
	}
if (($countersphingophospho eq 0) && ($countergpsearch eq 0) && ($counterotherphospho eq 0))
	{
	$mainphospho->configure(-state=>'active');
	}
#*************************************main phospho checkbox clicked****************************************
if ($countermainphospho eq 0)
	{
	$sphingophospho->configure(-state=>'active');
	$gpsearch->configure(-state=>'active');
	$otherphospho->configure(-state=>'active');
	}
if ($countermainphospho eq 1)
	{
	$sphingophospho->configure(-state=>'disabled');
	$gpsearch->configure(-state=>'disabled');
	$otherphospho->configure(-state=>'disabled');
	}
#*************************************phospho checkboxes complete*****************************************
#*****************************enables all checkbuttons when M. tb Lipidome is pressed **************************
if (($countermainhalo eq 0) && ($countercustomcheck eq 0) && ($countersulfo eq 0) && ($countermonoglycero eq 0) && ($counterdiglycero eq 0) && ($countertriglycero eq 0) && ($counterotherglycero eq 0) && ($countermainphospho eq 0) && ($countersphingophospho eq 0) && ($counterotherphospho eq 0) && ($countermainphospho eq 0) && ($countersphingophospho eq 0) && ($countergpsearch eq 0) && ($counterotherphospho eq 0) && ($counterfasearch eq 0) && ($countergpsearch eq 0) && ($counterglsearch eq 0) && ($counterpksearch eq 0) && ($counterprsearch eq 0) && ($counterspsearch eq 0) && ($counterslsearch eq 0) && ($counterstsearch eq 0))
{$entirelipidome->configure(-state=>'active');}
if (($countermainhalo eq 1) | ($countercustomcheck eq 1) | ($countersulfo eq 1) | ($countermonoglycero eq 1) | ($counterdiglycero eq 1) | ($countertriglycero eq 1) | ($countermainphospho eq 1) |($counterotherglycero eq 1)| ($countermainphospho eq 1)| ($countersphingophospho eq 1) | ($countergpsearch eq 1) | ($counterotherphospho eq 1))
{$entirelipidome->configure(-state=>'disabled');}

#**************************disables M. tb Lipidome if any of other are active******************************************
if ($counterentirelipidome eq 0){$fasearch->configure(-state=>'active');
	$gpsearch->configure(-state=>'active');
	$stsearch->configure(-state=>'active');
	$slsearch->configure(-state=>'active');
	$spsearch->configure(-state=>'active');
	$prsearch->configure(-state=>'active');
	$pksearch->configure(-state=>'active');
	$sulfo->configure(-state=>'active');
	$customcheck->configure(-state=>'active');
	$mainhalo->configure(-state=>'active');}
if ($countermainphospho eq 1) 
{	$gpsearch->configure(-state=>'disabled');}


#**********************************M. tb Lipidome check complete******************************************
}

# *************************************** subroutine to make all the checkbuttons for choice of ions *******************************
sub checkbuttons
{
	$check="black";
	$frameiontype1=$frameiontype->Frame(-background=>"white",-foreground=>$check)->pack(-side=>top,-fill=>x);
	$frameiontype2=$frameiontype->Frame(-background=>"white",-foreground=>$check)->pack(-side=>top,-fill=>x);
	$choicemmass=$frameiontype1->Checkbutton(-text => "Molecular Mass",-activeforeground=>"black",-activebackground=>"white",-font=>"{comic sans ms} 10 bold",-command => \&mmassdis,-background=>white,-foreground=>$check,-state=>active)->pack(-side => 'left');
	$negativead=$frameiontype1->Label(-text => "     Negative ions    ",-font=>"{tahoma} 10 bold",-background=>"white",-foreground=>$check)->pack(-side => 'left');
	$choicemhneg=$frameiontype1->Checkbutton(-text => "[M-H]-",-activeforeground=>"black",-activebackground=>"white",-font=>"{tahoma} 9 ",-command => \&mhnegdis,-background=>white,-foreground=>$check,-state=>active)->pack(-side => 'left');
	$choiceclneg=$frameiontype1->Checkbutton(-text => "[M+Cl]-",-font=>"{tahoma} 9 ",-command => \&clnegdis,-background=>white,-activeforeground=>"black",-activebackground=>"white",-foreground=>$check,-activeforeground=>"black",-activebackground=>"white",-state=>active)->pack(-side => 'left');
	$choiceachneg=$frameiontype1->Checkbutton(-text => "[M+HOAc-H]-",-font=>"{tahoma} 9 ",-activeforeground=>"black",-activebackground=>"white",-command => \&achnegdis,-background=>white,-foreground=>$check,-state=>active)->pack(-side => 'left');
	$choiceli2hneg=$frameiontype1->Checkbutton(-text => "[M+Li-2H]-",-font=>"{tahoma} 9 ",-command => \&li2hnegdis,-background=>white,-foreground=>$check,-activeforeground=>"black",-activebackground=>"white",-state=>active)->pack(-side => 'left');
	$choicenahneg=$frameiontype1->Checkbutton(-text => "[M+Na-2H]-",-font=>"{tahoma} 9 ",-command => \&nahnegdis,-background=>white,-activeforeground=>"black",-activebackground=>"white",-foreground=>$check,-state=>active)->pack(-side => 'left');
	$choicek2hneg=$frameiontype1->Checkbutton(-text => "[M+K-2H]-",-font=>"{tahoma} 9 ",-command => \&k2hnegdis,-background=>white,-foreground=>$check,-activeforeground=>"black",-activebackground=>"white",-state=>active)->pack(-side => 'left');
	$space=$frameiontype2->Label(-text => "                           ",-font=>"{tahoma} 10 ",-background=>white,-foreground=>$check)->pack(-side => 'left');
	$positivead=$frameiontype2->Label(-text => "        Positive ions     ",-font=>"{tahoma} 10 bold",-background=>"white",-foreground=>$check)->pack(-side => 'left');
	$choicemhpos=$frameiontype2->Checkbutton(-text => "[M+H]+",-activeforeground=>"black",-activebackground=>"white",-font=>"{tahoma} 9 ",-command => \&mhposdis,-background=>white,-foreground=>$check,-state=>active)->pack(-side => 'left');
	$choicemampos=$frameiontype2->Checkbutton(-text => "[M+NH4]+",-activeforeground=>"black",-activebackground=>"white",-font=>"{tahoma} 9 ",-command => \&mamposdis,-background=>white,-foreground=>$check,-state=>active)->pack(-side => 'left');
	$choicelipos=$frameiontype2->Checkbutton(-text => "[M+Li]+",-activeforeground=>"black",-activebackground=>"white",-font=>"{tahoma} 9 ",-command => \&liposdis,-background=>white,-foreground=>$check,-state=>active)->pack(-side => 'left');
	$choicenapos=$frameiontype2->Checkbutton(-text => "[M+Na]+",-activeforeground=>"black",-activebackground=>"white",-font=>"{tahoma} 9 ",-command => \&naposdis,-background=>white,-foreground=>$check,-state=>active)->pack(-side => 'left');
	$choicekpos=$frameiontype2->Checkbutton(-text => "[M+K]+",-activeforeground=>"black",-activebackground=>"white",-font=>"{tahoma} 9 ",-command => \&kposdis,-background=>white,-foreground=>$check,-state=>active)->pack(-side => 'left');
	$choice2lihpos=$frameiontype2->Checkbutton(-text => "[M+2Li-H]+",-activeforeground=>"black",-activebackground=>"white",-font=>"{tahoma} 9 ",-command => \&twolihposdis,-background=>white,-foreground=>$check,-state=>active)->pack(-side => 'left');
	$choicenahpos=$frameiontype2->Checkbutton(-text => "[M+2Na-H]+",-activeforeground=>"black",-activebackground=>"white",-font=>"{tahoma} 9",-command => \&nahposdis,-background=>white,-foreground=>$check,-state=>active)->pack(-side => 'left');
	$choice2khpos=$frameiontype2->Checkbutton(-text => "[M+2K-H]+",-activeforeground=>"black",-activebackground=>"white",-font=>"{tahoma} 9 ",-command => \&twokhposdis,-background=>white,-foreground=>$check,-state=>active)->pack(-side => 'left');

	$counter2lihpos=0;$counterlipos=0;$counterli2hneg=0;$countermhpos=0;$countermampos=0;$counternapos=0;$counternahpos=0;$countermhneg=0;$counterachneg=0;$counternahneg=0;$countermmass=0;$counterclneg=0;
	$counterkpos=0;$counter2khpos=0;$counterk2hneg=0;
};
sub twokhposdis
{
	$choice2khpos->configure(-state=>'active');
	$choice2khpos->configure(-command=>\&twokhposact);
	$choicenapos->configure(-state=>'disabled');
	$choicenahpos->configure(-state=>'disabled');
	$choicemampos->configure(-state=>'disabled');
	$choicemhneg->configure(-state=>'disabled');
	$choiceachneg->configure(-state=>'disabled');
	$choicenahneg->configure(-state=>'disabled');
	$choicemhpos->configure(-state=>'disabled');
	$choicemmass->configure(-state=>'disabled');
	$choiceclneg->configure(-state=>'disabled');
	$choicelipos->configure(-state=>'disabled');
	$choiceli2hneg->configure(-state=>'disabled');
	$choice2lihpos->configure(-state=>'disabled');
	$choicekpos->configure(-state=>'disabled');
	$choicek2hneg->configure(-state=>'disabled');
	$counter2khpos=1;
	};
sub twokhposact
{
	&activeall;
	$choice2khpos->configure(-command=>\&twokhposdis);$counter2khpos=0;};
sub kposdis
{
	$choicekpos->configure(-state=>'active');
	$choicekpos->configure(-command=>\&kposact);
	$choicenapos->configure(-state=>'disabled');
	$choicenahpos->configure(-state=>'disabled');
	$choicemampos->configure(-state=>'disabled');
	$choicemhneg->configure(-state=>'disabled');
	$choiceachneg->configure(-state=>'disabled');
	$choicenahneg->configure(-state=>'disabled');
	$choicemhpos->configure(-state=>'disabled');
	$choicemmass->configure(-state=>'disabled');
	$choiceclneg->configure(-state=>'disabled');
	$choice2lihpos->configure(-state=>'disabled');
	$choiceli2hneg->configure(-state=>'disabled');	
	$choicelipos->configure(-state=>'disabled');
	$choice2khpos->configure(-state=>'disabled');
	$choicek2hneg->configure(-state=>'disabled');	
	$counterkpos=1;
	};
sub kposact
{
	&activeall;
	$choicekpos->configure(-command=>\&kposdis);$counterkpos=0;};
sub k2hnegdis
{
	$choicek2hneg->configure(-state=>'active');
	$choicek2hneg->configure(-command=>\&k2hnegact);
	$choicenapos->configure(-state=>'disabled');
	$choicenahpos->configure(-state=>'disabled');
	$choicemampos->configure(-state=>'disabled');
	$choicemhneg->configure(-state=>'disabled');
	$choiceachneg->configure(-state=>'disabled');
	$choicenahneg->configure(-state=>'disabled');
	$choicemhpos->configure(-state=>'disabled');
	$choicemmass->configure(-state=>'disabled');
	$choiceclneg->configure(-state=>'disabled');
	$choice2lihpos->configure(-state=>'disabled');
	$choicelipos->configure(-state=>'disabled');
	$choiceli2hneg->configure(-state=>'disabled');
	$choice2khpos->configure(-state=>'disabled');
	$choicekpos->configure(-state=>'disabled');
	$counterk2hneg=1;
	};
sub k2hnegact
{
	&activeall;
	$choicek2hneg->configure(-command=>\&k2hnegdis);$counterk2hneg=0;};

sub twolihposdis
{
	$choice2lihpos->configure(-state=>'active');
	$choice2lihpos->configure(-command=>\&twolihposact);
	$choicenapos->configure(-state=>'disabled');
	$choicenahpos->configure(-state=>'disabled');
	$choicemampos->configure(-state=>'disabled');
	$choicemhneg->configure(-state=>'disabled');
	$choiceachneg->configure(-state=>'disabled');
	$choicenahneg->configure(-state=>'disabled');
	$choicemhpos->configure(-state=>'disabled');
	$choicemmass->configure(-state=>'disabled');
	$choiceclneg->configure(-state=>'disabled');
	$choicelipos->configure(-state=>'disabled');
	$choiceli2hneg->configure(-state=>'disabled');
	$choice2khpos->configure(-state=>'disabled');
	$choicekpos->configure(-state=>'disabled');
	$choicek2hneg->configure(-state=>'disabled');
	$counter2lihpos=1;
	};
sub twolihposact
{
	&activeall;
	$choice2lihpos->configure(-command=>\&twolihposdis);$counter2lihpos=0;};
sub liposdis
{
	$choicelipos->configure(-state=>'active');
	$choicelipos->configure(-command=>\&liposact);
	$choicenapos->configure(-state=>'disabled');
	$choicenahpos->configure(-state=>'disabled');
	$choicemampos->configure(-state=>'disabled');
	$choicemhneg->configure(-state=>'disabled');
	$choiceachneg->configure(-state=>'disabled');
	$choicenahneg->configure(-state=>'disabled');
	$choicemhpos->configure(-state=>'disabled');
	$choicemmass->configure(-state=>'disabled');
	$choiceclneg->configure(-state=>'disabled');
	$choice2lihpos->configure(-state=>'disabled');
	$choiceli2hneg->configure(-state=>'disabled');	
	$choice2khpos->configure(-state=>'disabled');
	$choicekpos->configure(-state=>'disabled');
	$choicek2hneg->configure(-state=>'disabled');
	$counterlipos=1;
	};
sub liposact
{
	&activeall;
	$choicelipos->configure(-command=>\&liposdis);$counterlipos=0;};
sub li2hnegdis
{
	$choiceli2hneg->configure(-state=>'active');
	$choiceli2hneg->configure(-command=>\&li2hnegact);
	$choicenapos->configure(-state=>'disabled');
	$choicenahpos->configure(-state=>'disabled');
	$choicemampos->configure(-state=>'disabled');
	$choicemhneg->configure(-state=>'disabled');
	$choiceachneg->configure(-state=>'disabled');
	$choicenahneg->configure(-state=>'disabled');
	$choicemhpos->configure(-state=>'disabled');
	$choicemmass->configure(-state=>'disabled');
	$choiceclneg->configure(-state=>'disabled');
	$choice2lihpos->configure(-state=>'disabled');
	$choicelipos->configure(-state=>'disabled');
	$choice2khpos->configure(-state=>'disabled');
	$choicekpos->configure(-state=>'disabled');



	$choicek2hneg->configure(-state=>'disabled');
	$counterli2hneg=1;
	};
sub li2hnegact
{
	&activeall;
	$choiceli2hneg->configure(-command=>\&li2hnegdis);$counterli2hneg=0;};
sub clnegdis
{
	$choiceclneg->configure(-state=>'active');
	$choiceclneg->configure(-command=>\&clnegact);
	$choicenapos->configure(-state=>'disabled');
	$choicenahpos->configure(-state=>'disabled');
	$choicemampos->configure(-state=>'disabled');
	$choicemhneg->configure(-state=>'disabled');
	$choiceachneg->configure(-state=>'disabled');
	$choicenahneg->configure(-state=>'disabled');
	$choicemhpos->configure(-state=>'disabled');
	$choicemmass->configure(-state=>'disabled');
	$choiceli2hneg->configure(-state=>'disabled');
	$choicelipos->configure(-state=>'disabled');
	$choice2lihpos->configure(-state=>'disabled');
	$choice2khpos->configure(-state=>'disabled');
	$choicekpos->configure(-state=>'disabled');
	$choicek2hneg->configure(-state=>'disabled');
	$counterclneg=1;
	};
sub clnegact
{
	&activeall;
	$choiceclneg->configure(-command=>\&clnegdis);$counterclneg=0;};
sub mmassdis
{
	$choicemmass->configure(-state=>'active');
	$choicemmass->configure(-command=>\&mmassact);
	$choicenapos->configure(-state=>'disabled');
	$choicenahpos->configure(-state=>'disabled');
	$choicemampos->configure(-state=>'disabled');
	$choicemhneg->configure(-state=>'disabled');
	$choiceachneg->configure(-state=>'disabled');
	$choicenahneg->configure(-state=>'disabled');
	$choicemhpos->configure(-state=>'disabled');
	$choiceclneg->configure(-state=>'disabled');
	$choiceli2hneg->configure(-state=>'disabled');
	$choicelipos->configure(-state=>'disabled');
	$choice2lihpos->configure(-state=>'disabled');
	$choice2khpos->configure(-state=>'disabled');
	$choicekpos->configure(-state=>'disabled');
	$choicek2hneg->configure(-state=>'disabled');
	$countermmass=1;
	};

sub mmassact{&activeall;$choicemmass->configure(-command=>\&mmassdis);$countermmass=0;};

sub mhposdis
{$choicemhpos->configure(-state=>'active');
$choicemhpos->configure(-command=>\&mhposact);
$choicenapos->configure(-state=>'disabled');
$choicenahpos->configure(-state=>'disabled');
$choicemampos->configure(-state=>'disabled');
$choicemhneg->configure(-state=>'disabled');
$choiceachneg->configure(-state=>'disabled');
$choicenahneg->configure(-state=>'disabled');
$choicemmass->configure(-state=>'disabled');
$choiceclneg->configure(-state=>'disabled');
	$choiceli2hneg->configure(-state=>'disabled');
	$choicelipos->configure(-state=>'disabled');
	$choice2lihpos->configure(-state=>'disabled');
$choice2khpos->configure(-state=>'disabled');
	$choicekpos->configure(-state=>'disabled');
	$choicek2hneg->configure(-state=>'disabled');
$countermhpos=1;
};

sub mhposact{&activeall;$choicemhpos->configure(-command=>\&mhposdis);$countermhpos=0;};

sub naposdis
{$choicenapos->configure(-state=>'active');
$choicenapos->configure(-command=>\&naposact);
$choicemhpos->configure(-state=>'disabled');
$choicenahpos->configure(-state=>'disabled');
$choicemampos->configure(-state=>'disabled');
$choicemhneg->configure(-state=>'disabled');
$choiceachneg->configure(-state=>'disabled');
$choicenahneg->configure(-state=>'disabled');
$choicemmass->configure(-state=>'disabled');
$choiceclneg->configure(-state=>'disabled');
	$choiceli2hneg->configure(-state=>'disabled');
	$choicelipos->configure(-state=>'disabled');
	$choice2lihpos->configure(-state=>'disabled');
$choice2khpos->configure(-state=>'disabled');
	$choicekpos->configure(-state=>'disabled');
	$choicek2hneg->configure(-state=>'disabled');
$counternapos=1;

};

sub naposact{&activeall;$choicenapos->configure(-command=>\&naposdis);$counternapos=0;};

sub nahposdis
{$choicenahpos->configure(-state=>'active');
$choicenahpos->configure(-command=>\&nahposact);
$choicemhpos->configure(-state=>'disabled');
$choicenapos->configure(-state=>'disabled');
$choicemampos->configure(-state=>'disabled');
$choicemhneg->configure(-state=>'disabled');
$choiceachneg->configure(-state=>'disabled');
$choicenahneg->configure(-state=>'disabled');
$choicemmass->configure(-state=>'disabled');
$choiceclneg->configure(-state=>'disabled');
	$choiceli2hneg->configure(-state=>'disabled');
	$choicelipos->configure(-state=>'disabled');
	$choice2lihpos->configure(-state=>'disabled');
$choice2khpos->configure(-state=>'disabled');
	$choicekpos->configure(-state=>'disabled');
	$choicek2hneg->configure(-state=>'disabled');
$counternahpos=1;

};

sub nahposact{&activeall;$choicenahpos->configure(-command=>\&nahposdis);$counternahpos=0;};

sub mamposdis
{$choicemampos->configure(-state=>'active');
$choicemampos->configure(-command=>\&mamposact);
$choicemhpos->configure(-state=>'disabled');
$choicenapos->configure(-state=>'disabled');
$choicenahpos->configure(-state=>'disabled');
$choicemhneg->configure(-state=>'disabled');
$choiceachneg->configure(-state=>'disabled');
$choicenahneg->configure(-state=>'disabled');
$choicemmass->configure(-state=>'disabled');
$choiceclneg->configure(-state=>'disabled');
	$choiceli2hneg->configure(-state=>'disabled');
	$choicelipos->configure(-state=>'disabled');
	$choice2lihpos->configure(-state=>'disabled');
$choice2khpos->configure(-state=>'disabled');
	$choicekpos->configure(-state=>'disabled');
	$choicek2hneg->configure(-state=>'disabled');
$countermampos=1;

};

sub mamposact{&activeall;$choicemampos->configure(-command=>\&mamposdis);$countermampos=0;};

sub mhnegdis
{$choicemhneg->configure(-state=>'active');
$choicemhneg->configure(-command=>\&mhnegact);
$choicemhpos->configure(-state=>'disabled');
$choicenapos->configure(-state=>'disabled');
$choicenahpos->configure(-state=>'disabled');
$choicemampos->configure(-state=>'disabled');
$choiceachneg->configure(-state=>'disabled');
$choicenahneg->configure(-state=>'disabled');
$choicemmass->configure(-state=>'disabled');
$choiceclneg->configure(-state=>'disabled');
	$choiceli2hneg->configure(-state=>'disabled');
	$choicelipos->configure(-state=>'disabled');
	$choice2lihpos->configure(-state=>'disabled');
$choice2khpos->configure(-state=>'disabled');
	$choicekpos->configure(-state=>'disabled');
	$choicek2hneg->configure(-state=>'disabled');
$countermhneg=1;

};

sub mhnegact{&activeall;$choicemhneg->configure(-command=>\&mhnegdis);$countermhneg=0;};

sub achnegdis
{
$choiceachneg->configure(-state=>'active');
$choiceachneg->configure(-command=>\&achnegact);
$choicemhpos->configure(-state=>'disabled');
$choicenapos->configure(-state=>'disabled');
$choicenahpos->configure(-state=>'disabled');
$choicemampos->configure(-state=>'disabled');
$choicemhneg->configure(-state=>'disabled');
$choicenahneg->configure(-state=>'disabled');
$choicemmass->configure(-state=>'disabled');
$choiceclneg->configure(-state=>'disabled');
	$choiceli2hneg->configure(-state=>'disabled');
	$choicelipos->configure(-state=>'disabled');
	$choice2lihpos->configure(-state=>'disabled');
$choice2khpos->configure(-state=>'disabled');
	$choicekpos->configure(-state=>'disabled');
	$choicek2hneg->configure(-state=>'disabled');
$counterachneg=1;

};

sub achnegact{&activeall;$choiceachneg->configure(-command=>\&achnegdis);$counterachneg=0;};

sub nahnegdis
{
$choicenahneg->configure(-state=>'active');
$choicenahneg->configure(-command=>\&nahnegact);
$choicemhpos->configure(-state=>'disabled');
$choicenapos->configure(-state=>'disabled');
$choiceclneg->configure(-state=>'disabled');
$choicenahpos->configure(-state=>'disabled');
$choicemampos->configure(-state=>'disabled');
$choicemhneg->configure(-state=>'disabled');
$choiceachneg->configure(-state=>'disabled');
$choicemmass->configure(-state=>'disabled');
	$choiceli2hneg->configure(-state=>'disabled');
	$choicelipos->configure(-state=>'disabled');
	$choice2lihpos->configure(-state=>'disabled');
$choice2khpos->configure(-state=>'disabled');
	$choicekpos->configure(-state=>'disabled');
	$choicek2hneg->configure(-state=>'disabled');
$counternahneg=1;

};

sub nahnegact{&activeall;$choicenahneg->configure(-command=>\&nahnegdis);$counternahneg=0;};

sub activeall
{$choicemhpos->configure(-state=>'active');
$choicenapos->configure(-state=>'active');
$choicenahpos->configure(-state=>'active');
$choicemampos->configure(-state=>'active');
$choicemhneg->configure(-state=>'active');
$choiceachneg->configure(-state=>'active');
$choicenahneg->configure(-state=>'active');
$choicemmass->configure(-state=>'active');
$choiceclneg->configure(-state=>'active');
$choiceli2hneg->configure(-state=>'active');
$choicelipos->configure(-state=>'active');
$choice2lihpos->configure(-state=>'active');
$choice2khpos->configure(-state=>'active');
$choicekpos->configure(-state=>'active');
$choicek2hneg->configure(-state=>'active');
};

#********************************************End of subroutine for making and configuring checkbuttons********************************
##*******************************************Subroutine for the conversion of files being used into hashes******************************
#***************************mass to lampid conversion*************************************************************************
sub mono2l
	{
	open FILE,"$HOME/data/mtb/mass/mono2l" or die "cannot open the file";
while (<FILE>)
	{
	chomp;
   	my ($key, $val) = split /!/;
  	$m2l{$key} .= exists $m2l{$key} ? "$val\n" : $val;
	}
	return %m2l;
	
};
#***************************mass to category conversion*************************************************************************
sub mono2c
	{
	open FILE,"$HOME/data/mtb/mass/mono2c" or die "cannot open the file";
while (<FILE>)
	{
	chomp;
   	my ($key, $val) = split /!/;
  	$m2c{$key} .= exists $m2c{$key} ? "$val\n" : $val;
	}};


#***************************mass to formulae conversion*************************************************************************
sub mono2f
	{
	open FILE,"$HOME/data/mtb/mass/mono2f" or die "cannot open the file";
while (<FILE>)
	{
	chomp;
   	my ($key, $val) = split /!/;
  	$m2f{$key} .= exists $m2f{$key} ? "$val\n" : $val;
	}};

#***************************mass to main class conversion*************************************************************************
sub mono2mc
	{
	open FILE,"$HOME/data/mtb/mass/mono2mc" or die "cannot open the file";
while (<FILE>)
	{
	chomp;
   	my ($key, $val) = split /!/;
  	$m2mc{$key} .= exists $m2mc{$key} ? "$val\n" : $val;
	}};

#***************************mass to subclass conversion*************************************************************************
sub mono2sc
	{
	open FILE,"$HOME/data/mtb/mass/mono2sc" or die "cannot open the file";
while (<FILE>)
	{
	chomp;
   	my ($key, $val) = split /!/;
  	$m2sc{$key} .= exists $m2sc{$key} ? "$val\n" : $val;
	}};

#***************************mass to systematic name conversion*************************************************************************

sub mono2sn
	{
	open FILE,"$HOME/data/mtb/mass/mono2sn" or die "cannot open the file";
while (<FILE>)
	{
	chomp;
   	my ($key, $val) = split /!/;
  	$m2sn{$key} .= exists $m2sn{$key} ? "$val\n" : $val;
	}};

##**********************************End of subroutine for conversion*********************************************************
##*******************************************Subroutine for the conversion of files being used into hashes******************************
#***************************mass to lampid conversion*************************************************************************
sub l2f
	{
	open FILE,"$HOME/data/mtb/mass/l2f" or die "cannot open the file";
while (<FILE>)
	{
	chomp;
   	my ($key, $val) = split /!/;
  	$l2f{$key} .= exists $l2f{$key} ? "$val\n" : $val;
	}
	
};

#***************************mass to lampid conversion*************************************************************************
sub m2l
	{
	open FILE,"$HOME/data/mtb/mass/m2l" or die "cannot open the file";
while (<FILE>)
	{
	chomp;
   	my ($key, $val) = split /!/;
  	$m2l{$key} .= exists $m2l{$key} ? "$val\n" : $val;
	}
	return %m2l;
	
};
#***************************mass to category conversion*************************************************************************
sub m2c
	{
	open FILE,"$HOME/data/mtb/mass/m2c" or die "cannot open the file";
while (<FILE>)
	{
	chomp;
   	my ($key, $val) = split /!/;
  	$m2c{$key} .= exists $m2c{$key} ? "$val\n" : $val;
	}};


#***************************mass to formulae conversion*************************************************************************
sub m2f
	{
	open FILE,"$HOME/data/mtb/mass/m2f" or die "cannot open the file";
while (<FILE>)
	{
	chomp;
   	my ($key, $val) = split /!/;
  	$m2f{$key} .= exists $m2f{$key} ? "$val\n" : $val;
	}};

#***************************mass to main class conversion*************************************************************************
sub m2mc
	{
	open FILE,"$HOME/data/mtb/mass/m2mc" or die "cannot open the file";
while (<FILE>)
	{
	chomp;
   	my ($key, $val) = split /!/;
  	$m2mc{$key} .= exists $m2mc{$key} ? "$val\n" : $val;
	}};

#***************************mass to subclass conversion*************************************************************************
sub m2sc
	{
	open FILE,"$HOME/data/mtb/mass/m2sc" or die "cannot open the file";
while (<FILE>)
	{
	chomp;
   	my ($key, $val) = split /!/;
  	$m2sc{$key} .= exists $m2sc{$key} ? "$val\n" : $val;
	}};

#***************************mass to systematic name conversion*************************************************************************

sub m2sn
	{
	open FILE,"$HOME/data/mtb/mass/m2sn" or die "cannot open the file";
while (<FILE>)
	{
	chomp;
   	my ($key, $val) = split /!/;
  	$m2sn{$key} .= exists $m2sn{$key} ? "$val\n" : $val;
	}};

##**********************************End of subroutine for conversion*********************************************************
##**********************************Photo for searching *******************************************************************
sub searching
{
&entriesrangemain;
$searchingintro=$m->Label(-text=>"Click Below for Results",-font=>"{times new roman} 36 bold",-background=>"white",-foreground=>"navy blue",-borderwidth=>30)->pack(-side=>top,-fill=>x);
$searchingimg =$m->Photo(-file=>"$HOME/logo/searching.png");
$searchlabel=$m->Button(-image=>$searchingimg,-command=>\&check)->pack;
};

##*************************************Subroutine for forgetting subroutine searching*****************************************
sub entriessearching
{$searchingintro->packForget();
$searchlabel->packForget();
};

#********************************************End of the photo of searcing************************************************


#****************************************Choose File********************************************************************
sub choosefile
{
	$types = [ ['Text File', '.txt'],
              		['All Files',   '*'],];
	sub open_file {$open = $m->getOpenFile(-filetypes => $types,-defaultextension => '.txt');}
	&open_file;
if($activeoptionone eq 0 &&$activeoptiontwo eq 1){&opening2;};
if($activeoptionone eq 1 &&$activeoptiontwo eq 0){&opening1;}

}
sub opening1
{$checkfor1=0;
	open(IN, "$open") or die "cannot open ";
	$round=0;
	@mzval=();
while(defined($line=<IN>))
{
	{
	chomp ($line);
	@parts=split(/\t/,$line);
	$mzval[$round] = $parts[0];

	$round++;
	

	}	
}

close(IN); 	


 

}



sub opening2
{$checkfor2=0;
	open(IN, "$open") or die "cannot open ";
	$round=0;
	@mzval="";
	@intensity="";
	@relative="";
	@charge="";
while(defined($line=<IN>))
{
	{
	chomp ($line);
	@parts=split(/\t/,$line);
	if(($parts[2] >$relativeintensityvalue ) && ($parts[3] > 0) &&($parts[3]<2))
	{
	$mzval[$round] = $parts[0];
	$intensity[$round]=$parts[1];
	$relative[$round]=$parts[2];
	$charge[$round]=$parts[3];
	$round++;
	$checkfor2++;
	}	
	
}
}
close(IN); 	
		
print @mzval;
$loart = "123498765";
$loart=@relative;
$loaft=123456789;
$loaft=@mzval;

}


#********************************************subroutine to check whether the entry exists or not******************************
sub f2hall
{if ($masschoice eq 1)
{%data = &m2l;&m2c;&m2f;&m2mc;&m2sc;&m2sn;&l2f}
elsif ($masschoice eq 0)
{%data = &mono2l;&mono2c;&mono2f;&mono2mc;&mono2sc;&mono2sn;&l2f}
}

sub check
{
if ($masschoice eq 0) {$comment="Monoisotopic";}else{$comment="Average";}
for (keys %data)
    {
        delete $data{$_};
    }

for (keys %m2cn)
    {
        delete $m2cn{$_};
    }
for (keys %mono2cn)
    {
        delete $mono2cn{$_};
    }
for (keys %m2l)
    {
        delete $m2l{$_};
    }
for (keys %m2c)
    {
        delete $m2c{$_};
    }
for (keys %m2f)
    {
        delete $m2f{$_};
    }
for (keys %m2mc)
    {
        delete $m2mc{$_};
    }
for (keys %m2sc)
    {
        delete $m2sc{$_};
    }
for (keys %m2sn)
    {
        delete $m2sn{$_};
    }
for (keys %mono2l)
    {
        delete $mono2l{$_};
    }
for (keys %mono2c)
    {
        delete $mono2c{$_};
    }
for (keys %mono2f)
    {
        delete $mono2f{$_};
    }
for (keys %mono2mc)
    {
        delete $mono2mc{$_};
    }
for (keys %mono2sc)
    {
        delete $mono2sc{$_};
    }
for (keys %mono2sn)
    {
        delete $mono2sn{$_};
    }
for (keys %l2f)
    {
        delete $l2f{$_};
    }
&f2hall;

$changeinval =0;
$ionmhposvalmono=-1.007825;
$ionmamposvalmono=-18.034374;
$ionnaposvalmono=-22.989769;
$ionnahnegvalmono=-20.974119;
$ionmhnegvalmono=1.007825;
$ionachnegvalmono=-59.013305;
$ion2nahposvalmono=-44.971713;
$ionclnegvalmono=-34.968852;
$ionliposvalmono=-7.016004;
$ion2lihposvalmono=-13.024183;
$ionlihnegvalmono=-5.000354;
$ionkposvalmono=-38.963707;
$ion2khposvalmono=-76.919589;
$ionk2hnegvalmono=-36.948057;

$ionmhposvalavg=-1.00794;
$ionmamposvalavg=-18.03848;
$ionnaposvalavg=-22.98977;
$ionnahnegvalavg=-20.97389;
$ionmhnegvalavg=1.00794;
$ionachnegvalavg=-59.04424;
$ion2nahposvalavg=-44.97160;
$ionclnegvalavg=-35.45320;
$ionliposvalavg=-6.94120;
$ion2lihposvalavg=-12.87446;
$ionlihnegvalavg=-4.92532;
$ionkposvalavg=-39.09831;
$ion2khposvalavg=-77.18868;
$ionk2hnegvalavg=-37.08243;


if ($counter2khpos eq 1){if ($masschoice eq 0) {$changeinval=$ion2khposvalmono;} elsif ($masschoice eq 1) {$changeinval=$ion2khposvalavg;}}
if ($counterkpos eq 1){if ($masschoice eq 0) {$changeinval=$ionkposvalmono;} elsif ($masschoice eq 1) {$changeinval=$ionkposvalavg;}}
if ($counterk2hneg eq 1){if ($masschoice eq 0) {$changeinval=$ionk2hnegvalmono;} elsif ($masschoice eq 1) {$changeinval=$ionk2hnegvalavg;}}
if ($counter2lihpos eq 1){if ($masschoice eq 0) {$changeinval=$ion2lihposvalmono;} elsif ($masschoice eq 1) {$changeinval=$ion2lihposvalavg;}}
if ($counterlipos eq 1){if ($masschoice eq 0) {$changeinval=$ionliposvalmono;} elsif ($masschoice eq 1) {$changeinval=$ionliposvalavg;}}
if ($counterli2hneg eq 1){if ($masschoice eq 0) {$changeinval=$ionlihnegvalmono;} elsif ($masschoice eq 1) {$changeinval=$ionlihnegvalavg;}}
if ($counterclneg eq 1){if ($masschoice eq 0) {$changeinval=$ionclnegvalmono;} elsif ($masschoice eq 1) {$changeinval=$ionclnegvalavg;}}
if ($countermmass eq 1){$changeinval=0;}
if ($countermhpos eq 1){if ($masschoice eq 0) {$changeinval=$ionmhposvalmono;} elsif ($masschoice eq 1) {$changeinval=$ionmhposvalavg;}}
if ($counternapos eq 1){if ($masschoice eq 0) {$changeinval=$ionnaposvalmono;} elsif ($masschoice eq 1) {$changeinval=$ionnaposvalavg;}}
if ($counternahpos eq 1){if ($masschoice eq 0) {$changeinval=$ion2nahposvalmono;} elsif ($masschoice eq 1) {$changeinval=$ion2nahposvalavg;}}
if ($countermampos eq 1){if ($masschoice eq 0) {$changeinval=$ionmamposvalmono;} elsif ($masschoice eq 1) {$changeinval=$ionmamposvalavg;}}
if ($countermhneg eq 1){if ($masschoice eq 0) {$changeinval=$ionmhnegvalmono;} elsif ($masschoice eq 1) {$changeinval=$ionmhnegvalavg;}}
if ($counterachneg eq 1){if ($masschoice eq 0) {$changeinval=$ionachnegvalmono;} elsif ($masschoice eq 1) {$changeinval=$ionachnegvalavg;}}
if ($counternahneg eq 1){if ($masschoice eq 0) {$changeinval=$ionnahnegvalmono;} elsif ($masschoice eq 1) {$changeinval=$ionnahnegvalavg;}}


print " $masschoice";
	$lenarray=0;
	$lenarray=@mzval;
	@mz=();
for ($count=0;$count<$lenarray;$count++)
	{
	$mz[$count] = ($mzval[$count]+$changeinval);
	 }

$lenmz=0;
$lenmz=@mz;
@uppermz=();
@lowermz=();
$round=0;
for ($count=0;$count<$lenmz;$count++)
{	
	
	$uppermz[$count] = ($mz[$count]+$range);
	$lowermz[$count] = (($mz[$count])-($range));
}	

for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]))
			{
			$round++;
			}
	}
	}
if (($round >0)&&(($counterentirelipidome eq 1) | ($countermainglycero eq 1)|($countermainhalo eq 1)| ($countercustomcheck eq 1) | ($countersulfo eq 1) | ($countermonoglycero eq 1) | ($counterdiglycero eq 1)|($countertriglycero eq 1)|($counterotherglycero eq 1)|($countermainphospho eq 1) | ($countersphingophospho eq 1)|($counterotherphospho eq 1)| ($countermainphospho eq 1) | ($countersphingophospho eq 1) | ($countergpsearch eq 1) | ($counterotherphospho eq 1) | ($counterfasearch eq 1) | ($countergpsearch eq 1) | ($counterglsearch eq 1) | ($counterpksearch eq 1) | ($counterprsearch eq 1) | ($counterspsearch eq 1)| ($counterslsearch eq 1) | ($counterstsearch eq 1))&&(($counter2khpos eq 1)|($counterkpos eq 1)|($counterk2hneg eq 1)|($counter2lihpos eq 1)|($counterlipos eq 1)|($counterli2hneg eq 1)|($counterclneg eq 1)|($countermmass eq 1)|($countermhpos eq 1)|($counternapos eq 1)|($counternahpos eq 1)|($countermampos eq 1)|($countermhneg eq 1)|($counterachneg eq 1)|($counternahneg eq 1)))	
{&datafound;}
else{&nodata;};
};

#**************************************************end of subroutine for checking******************************************

#**************************************************Display for nodata found***********************************************
sub nodata
{&entriessearching;
$errortitle=$errormess=$errorbottom=$errortitle=  $optionalcomm="";
$counterrelative=$counterintensity=$countercharge=0;
	if ($countermhpos eq 1){$qurdion='[M+H]+'}		
	elsif($countermampos eq 1){$qurdion='[M+NH4]+'}		
	elsif($counternapos eq 1){$qurdion='[M+Na]+'}
	elsif($counternahpos eq 1){$qurdion='[M+2Na-H]+'}
	elsif($countermhneg eq 1){$qurdion='[M-H]-'}
	elsif($counterachneg eq 1){$qurdion='[M+HOAc-H]-'}
	elsif($counternahneg eq 1){$qurdion='[M+Na-2H]-'}
	elsif($counterclneg eq 1){$qurdion='[M+Cl]-'}
	elsif($counterlipos eq 1){$qurdion='[M+Li]+'}
	elsif($counter2lihpos eq 1){$qurdion='[M+2Li-H]+'}
	elsif($counterli2hneg eq 1){$qurdion='[M+Li-2H]-'}
	elsif($counterkpos eq 1){$qurdion='[M+K]+'}
	elsif($counter2khpos eq 1){$qurdion='[M+2K-H]+'}
	elsif($counterk2hneg eq 1){$qurdion='[M+K-2H]-'}
	elsif($countermmass eq 1){$qurdion='Molecular Mass'}
	else{$qurdion='No ion type/Molecular mass selected'}

if ($masschoice eq 0){$masstypeselect= "Monoisotopic";}
if ($masschoice eq 1){$masstypeselect= "Average";}	


if($activeoptionone eq 0 &&$activeoptiontwo eq 1) {   $optionalcomm = "Relative Intensity threshold : $relativeintensityvalue\t";}
else {  $optionalcomm ="";}
$opener=$open;
if($activeoptionone eq 0 &&$activeoptiontwo eq 1) {   $optionalcomm2 = "Uploaded File : $opener \n"; if ($open eq "") { $opener = " No File Uploaded. Upload .txt file of Molecular Masses or m/z values.";}}
else {  $optionalcomm2 ="";}


if (@intensity eq ""){$counterintensity =0;}else{$counterintensity =1;}
if (@relative eq ""){$counterrelative =0;}else{$counterrelative =1;}
if (@charge eq ""){$countercharge =0;}else{$countercharge =1;}

if ((($activeoptionone eq 1)|($activeoptiontwo eq 1))&&($round eq 0)&&(($counterentirelipidome eq 1) | ($countermainhalo eq 1) |($countermainglycero eq 1) | ($countercustomcheck eq 1)| ($countersulfo eq 1) | ($countermonoglycero eq 1) | ($counterdiglycero eq 1) | ($countertriglycero eq 1) | ($counterotherglycero eq 1) | ($countermainphospho eq 1) | ($countersphingophospho eq 1) | ($counterotherphospho eq 1) | ($countermainphospho eq 1) | ($countersphingophospho eq 1) | ($countergpsearch eq 1) | ($counterotherphospho eq 1) | ($counterfasearch eq 1) | ($countergpsearch eq 1) | ($counterglsearch eq 1) | ($counterpksearch eq 1) | ($counterprsearch eq 1) | ($counterspsearch eq 1) | ($counterslsearch eq 1)| ($counterstsearch eq 1))&&(($counter2lihpos eq 1)|($counterlipos eq 1)|($counterli2hneg eq 1) | ($countermhpos eq 1) | ($countermampos eq 1)|($counternapos eq 1) | ($counternahpos eq 1) | ($countermhneg eq 1)|($counterachneg eq 1) | ($counternahneg eq 1)|  ($countermmass eq 1) | ($counterclneg eq 1) |($counterkpos eq 1)| ($counter2khpos eq 1) |($counterk2hneg eq 1)))	
{$errortoptitle="Result of the query";
$errortitle="Oops ! There are no results matching to the query ";
if ($open eq ""){$errormess="\n\nUpload .txt file containing m/z &\n relative intensity values.\n"; }
else {$errormess="There are no results corresponding \n to the queried parameters \n in the current database \n i.e. M.tb Lipidome MS-LAMP\n"; }
$errorbottom="Back";
$m->title("MS - LAMP - M. tb Lipidome MS-LAMP :$errortoptitle");
$nodata=$m->Frame(-background=>$col)->pack(-side=>top,-fill=>x);
$noquery=$nodata->Label(-text=>"\n$errortitle\n",-font=>"{times new roman} 24 bold",-background=>$col1,-foreground=>$col5,-borderwidth=>4,-relief=>ridge)->pack(-side=>'top',-fill=>x);
if ($masstypeselect eq "") {$masstypeselect= "Mass type not selected";}
$queriedpara=$nodata->Label(-text=>"\nQueried parameters -   $optionalcomm2   $optionalcomm Mass : $masstypeselect\t Ion type : $qurdion \t  Window range :+/-  $range\t \n",-font=>"{times new roman} 12 bold",-background=>$col,-foreground=>$col5)->pack(-side=>'top',-fill=>x);
$label=$nodata->Label(-text=>"\n$errormess",-font=>"{times new roman} 36 ",-background=>$col,-foreground=>$col3)->pack(-side=>'top',-fill=>x);
$goback=$nodata->Button (-text=>"$errorbottom",-background=>$col4,-foreground=>$col,-font=>"{$fontty} 18",-command=>\&entriesnodata)->pack(-side=>bottom,-fill=>x);
}



if (($activeoptionone eq 0) && ($activeoptiontwo eq 0)&&($round eq 0)&&($counterentirelipidome eq 0) && ($countermainhalo eq 0) &&($countermainglycero eq 0) && ($countercustomcheck eq 0) && ($countersulfo eq 0) && ($countermonoglycero eq 0) && ($counterdiglycero eq 0) && ($countertriglycero eq 0) && ($counterotherglycero eq 0) && ($countermainphospho eq 0) && ($countersphingophospho eq 0) && ($counterotherphospho eq 0) && ($countermainphospho eq 0) && ($countersphingophospho eq 0) && ($countergpsearch eq 0) && ($counterotherphospho eq 0) && ($counterfasearch eq 0) && ($countergpsearch eq 0) && ($counterglsearch eq 0) && ($counterpksearch eq 0) && ($counterprsearch eq 0) && ($counterspsearch eq 0) && ($counterslsearch eq 0)&& ($counterstsearch eq 0)&&(($counter2lihpos eq 1)|($counterlipos eq 1)|($counterli2hneg eq 1) | ($countermhpos eq 1) | ($countermampos eq 1)|($counternapos eq 1) | ($counternahpos eq 1) | ($countermhneg eq 1)|($counterachneg eq 1) | ($counternahneg eq 1)|  ($countermmass eq 1) | ($counterclneg eq 1) |($counterkpos eq 1)| ($counter2khpos eq 1) |($counterk2hneg eq 1)))	
{$errortoptitle="Result of the query";
$errortitle="Oops ! There are no results matching to the query ";
$errormess="\nNo File Uploaded.\nUpload .txt file of Molecular Masses or m/z values.\nSelect one or more lipid category(ies). \n";  
$errorbottom="Back";
$m->title("MS - LAMP - M. tb Lipidome MS-LAMP :$errortoptitle");
$nodata=$m->Frame(-background=>$col)->pack(-side=>top,-fill=>x);
$noquery=$nodata->Label(-text=>"\n$errortitle\n",-font=>"{times new roman} 24 bold",-background=>$col1,-foreground=>$col5,-borderwidth=>4,-relief=>ridge)->pack(-side=>'top',-fill=>x);
if ($masstypeselect eq "") {$masstypeselect= "Mass type not selected";}
$queriedpara=$nodata->Label(-text=>"\nQueried parameters -   $optionalcomm2   $optionalcomm Mass : $masstypeselect\t Ion type : $qurdion \t  Window range :+/-  $range\t \n",-font=>"{times new roman} 12 bold",-background=>$col,-foreground=>$col5)->pack(-side=>'top',-fill=>x);
$label=$nodata->Label(-text=>"\n$errormess",-font=>"{times new roman} 36 ",-background=>$col,-foreground=>$col3)->pack(-side=>'top',-fill=>x);
$goback=$nodata->Button (-text=>"$errorbottom",-background=>$col4,-foreground=>$col,-font=>"{$fontty} 18",-command=>\&entriesnodata)->pack(-side=>bottom,-fill=>x);
}

if (($activeoptionone eq 0) && ($activeoptiontwo eq 0)&&($round eq 0)&& (($counterentirelipidome eq 1) |($countermainglycero eq 1)| ($countermainhalo eq 1)| ($countercustomcheck eq 1) | ($countersulfo eq 1) | ($countermonoglycero eq 1) | ($counterdiglycero eq 1)|($countertriglycero eq 1)|($counterotherglycero eq 1)|($countermainphospho eq 1) | ($countersphingophospho eq 1)|($counterotherphospho eq 1)| ($countermainphospho eq 1) | ($countersphingophospho eq 1) | ($countergpsearch eq 1) | ($counterotherphospho eq 1) | ($counterfasearch eq 1) | ($countergpsearch eq 1) | ($counterglsearch eq 1) | ($counterpksearch eq 1) | ($counterprsearch eq 1) | ($counterspsearch eq 1)| ($counterslsearch eq 1) | ($counterstsearch eq 1))&&(($counter2lihpos eq 0)&&($counterlipos eq 0)&&($counterli2hneg eq 0)&& ($countermhpos eq 0) && ($countermampos eq 0)&&($counternapos eq 0) && ($counternahpos eq 0) && ($countermhneg eq 0)&&($counterachneg eq 0) && ($counternahneg eq 0)&&  ($countermmass eq 0) && ($counterclneg eq 0) &&($counterkpos eq 0)&& ($counter2khpos eq 0) &&($counterk2hneg eq 0)) ) 
{$errortoptitle="Result of the query";
$errortitle="Oops ! There are no results matching to the query ";
$errormess="\nNo File Uploaded.\nUpload .txt file of Molecular Masses or m/z values.\nChoose Molecular Mass or a Type of Ion .\n";  
$errorbottom="Back";
if ($masstypeselect eq "") {$masstypeselect= "Mass type not selected";}
$m->title("MS - LAMP - M. tb Lipidome MS-LAMP :$errortoptitle");
$nodata=$m->Frame(-background=>$col)->pack(-side=>top,-fill=>x);
$noquery=$nodata->Label(-text=>"\n$errortitle\n",-font=>"{times new roman} 24 bold",-background=>$col1,-foreground=>$col5,-borderwidth=>4,-relief=>ridge)->pack(-side=>'top',-fill=>x);
$queriedpara=$nodata->Label(-text=>"\nQueried parameters -   $optionalcomm2   $optionalcomm Mass : $masstypeselect\t Ion type : $qurdion \t  Window range :+/-  $range\t \n",-font=>"{times new roman} 12 bold",-background=>$col,-foreground=>$col5)->pack(-side=>'top',-fill=>x);
$label=$nodata->Label(-text=>"\n$errormess",-font=>"{times new roman} 36 ",-background=>$col,-foreground=>$col3)->pack(-side=>'top',-fill=>x);
$goback=$nodata->Button (-text=>"$errorbottom",-background=>$col4,-foreground=>$col,-font=>"{$fontty} 18",-command=>\&entriesnodata)->pack(-side=>bottom,-fill=>x);
}

if (($activeoptionone eq 0) && ($activeoptiontwo eq 0)&&($round eq 0)&& (($counterentirelipidome eq 1) |($countermainglycero eq 1)| ($countermainhalo eq 1)| ($countercustomcheck eq 1) | ($countersulfo eq 1) | ($countermonoglycero eq 1) | ($counterdiglycero eq 1)|($countertriglycero eq 1)|($counterotherglycero eq 1)|($countermainphospho eq 1) | ($countersphingophospho eq 1)|($counterotherphospho eq 1)| ($countermainphospho eq 1) | ($countersphingophospho eq 1) | ($countergpsearch eq 1) | ($counterotherphospho eq 1) | ($counterfasearch eq 1) | ($countergpsearch eq 1) | ($counterglsearch eq 1) | ($counterpksearch eq 1) | ($counterprsearch eq 1) | ($counterspsearch eq 1)| ($counterslsearch eq 1) | ($counterstsearch eq 1)) && (($counter2lihpos eq 1)|($counterlipos eq 1)|($counterli2hneg eq 1) | ($countermhpos eq 1) | ($countermampos eq 1)|($counternapos eq 1) | ($counternahpos eq 1) | ($countermhneg eq 1)|($counterachneg eq 1) | ($counternahneg eq 1)|  ($countermmass eq 1) | ($counterclneg eq 1) |($counterkpos eq 1)| ($counter2khpos eq 1) |($counterk2hneg eq 1)) )	
{$errortoptitle="Result of the query";
if ($masstypeselect eq "") {$masstypeselect= "Mass type not selected";}
$errortitle="Oops ! There are no results matching to the query ";
$errormess="\nNo File Uploaded.\nUpload .txt file of Molecular Masses or m/z values. \n";  
$errorbottom="Back";
$m->title("MS - LAMP - M. tb Lipidome MS-LAMP :$errortoptitle");
$nodata=$m->Frame(-background=>$col)->pack(-side=>top,-fill=>x);
$noquery=$nodata->Label(-text=>"\n$errortitle\n",-font=>"{times new roman} 24 bold",-background=>$col1,-foreground=>$col5,-borderwidth=>4,-relief=>ridge)->pack(-side=>'top',-fill=>x);
$queriedpara=$nodata->Label(-text=>"\nQueried parameters -   $optionalcomm2   $optionalcomm Mass : $masstypeselect\t Ion type : $qurdion \t  Window range :+/-  $range\t \n",-font=>"{times new roman} 12 bold",-background=>$col,-foreground=>$col5)->pack(-side=>'top',-fill=>x);
$label=$nodata->Label(-text=>"\n$errormess",-font=>"{times new roman} 36 ",-background=>$col,-foreground=>$col3)->pack(-side=>'top',-fill=>x);
$goback=$nodata->Button (-text=>"$errorbottom",-background=>$col4,-foreground=>$col,-font=>"{$fontty} 18",-command=>\&entriesnodata)->pack(-side=>bottom,-fill=>x);
}

if (($activeoptionone eq 0) && ($activeoptiontwo eq 0)&&(($round eq 0)|($round > 0))&& ($counterentirelipidome eq 0) && ($countermainhalo eq 0) &&($countermainglycero eq 0) && ($countercustomcheck eq 0) && ($countersulfo eq 0) && ($countermonoglycero eq 0) && ($counterdiglycero eq 0) && ($countertriglycero eq 0) && ($counterotherglycero eq 0) && ($countermainphospho eq 0) && ($countersphingophospho eq 0) && ($counterotherphospho eq 0) && ($countermainphospho eq 0) && ($countersphingophospho eq 0) && ($countergpsearch eq 0) && ($counterotherphospho eq 0) && ($counterfasearch eq 0) && ($countergpsearch eq 0) && ($counterglsearch eq 0) && ($counterpksearch eq 0) && ($counterprsearch eq 0) && ($counterspsearch eq 0) && ($counterslsearch eq 0)&& ($counterstsearch eq 0)&&($counter2lihpos eq 0)&&($counterlipos eq 0)&&($counterli2hneg eq 0)&& ($countermhpos eq 0) && ($countermampos eq 0)&&($counternapos eq 0) && ($counternahpos eq 0) && ($countermhneg eq 0)&&($counterachneg eq 0) && ($counternahneg eq 0)&&  ($countermmass eq 0) && ($counterclneg eq 0) &&($counterkpos eq 0)&& ($counter2khpos eq 0) &&($counterk2hneg eq 0) ) 	
{$errortoptitle="Result of the query";
$errortitle="Oops ! There are no results matching to the query ";
$errormess="\nNo File Uploaded.\nUpload .txt file of Molecular Masses or m/z values .\nChoose Molecular Mass or a Type of Ion .\nSelect one or more lipid category(ies).";  
$errorbottom="Back";
if ($masstypeselect eq "") {$masstypeselect= "Mass type not selected";}
$m->title("MS - LAMP - M. tb Lipidome MS-LAMP :$errortoptitle");
$nodata=$m->Frame(-background=>$col)->pack(-side=>top,-fill=>x);
$noquery=$nodata->Label(-text=>"\n$errortitle\n",-font=>"{times new roman} 24 bold",-background=>$col1,-foreground=>$col5,-borderwidth=>4,-relief=>ridge)->pack(-side=>'top',-fill=>x);
$queriedpara=$nodata->Label(-text=>"\nQueried parameters -   $optionalcomm2   $optionalcomm Mass : $masstypeselect\t Ion type : $qurdion \t  Window range :+/-  $range\t \n",-font=>"{times new roman} 12 bold",-background=>$col,-foreground=>$col5)->pack(-side=>'top',-fill=>x);
$label=$nodata->Label(-text=>"\n$errormess",-font=>"{times new roman} 36 ",-background=>$col,-foreground=>$col3)->pack(-side=>'top',-fill=>x);
$goback=$nodata->Button (-text=>"$errorbottom",-background=>$col4,-foreground=>$col,-font=>"{$fontty} 18",-command=>\&entriesnodata)->pack(-side=>bottom,-fill=>x);
}

if ((($activeoptionone eq 1) | ($activeoptiontwo eq 1))&&(($round eq 0)|($round > 0))&& ($counterentirelipidome eq 0) && ($countermainhalo eq 0) &&($countermainglycero eq 0) && ($countercustomcheck eq 0) && ($countersulfo eq 0) && ($countermonoglycero eq 0) && ($counterdiglycero eq 0) && ($countertriglycero eq 0) && ($counterotherglycero eq 0) && ($countermainphospho eq 0) && ($countersphingophospho eq 0) && ($counterotherphospho eq 0) && ($countermainphospho eq 0) && ($countersphingophospho eq 0) && ($countergpsearch eq 0) && ($counterotherphospho eq 0) && ($counterfasearch eq 0) && ($countergpsearch eq 0) && ($counterglsearch eq 0) && ($counterpksearch eq 0) && ($counterprsearch eq 0) && ($counterspsearch eq 0) && ($counterslsearch eq 0)&& ($counterstsearch eq 0)&&($counter2lihpos eq 0)&&($counterlipos eq 0)&&($counterli2hneg eq 0)&& ($countermhpos eq 0) && ($countermampos eq 0)&&($counternapos eq 0) && ($counternahpos eq 0) && ($countermhneg eq 0)&&($counterachneg eq 0) && ($counternahneg eq 0)&&  ($countermmass eq 0) && ($counterclneg eq 0) &&($counterkpos eq 0)&& ($counter2khpos eq 0) &&($counterk2hneg eq 0) ) 	
{$errortoptitle="Result of the query";
$errortitle="Oops ! There are no results matching to the query ";
$errormess="\nChoose Molecular Mass or a Type of Ion .\nSelect one or more lipid category(ies).\n\n";  
$errorbottom="Back";
if ($masstypeselect eq "") {$masstypeselect= "Mass type not selected";}
$m->title("MS - LAMP - M. tb Lipidome MS-LAMP :$errortoptitle");
$nodata=$m->Frame(-background=>$col)->pack(-side=>top,-fill=>x);
$noquery=$nodata->Label(-text=>"\n$errortitle\n",-font=>"{times new roman} 24 bold",-background=>$col1,-foreground=>$col5,-borderwidth=>4,-relief=>ridge)->pack(-side=>'top',-fill=>x);
$queriedpara=$nodata->Label(-text=>"\nQueried parameters -   $optionalcomm2   $optionalcomm Mass : $masstypeselect\t Ion type : $qurdion \t  Window range :+/-  $range\t \n",-font=>"{times new roman} 12 bold",-background=>$col,-foreground=>$col5)->pack(-side=>'top',-fill=>x);
$label=$nodata->Label(-text=>"\n$errormess",-font=>"{times new roman} 36 ",-background=>$col,-foreground=>$col3)->pack(-side=>'top',-fill=>x);
$goback=$nodata->Button (-text=>"$errorbottom",-background=>$col4,-foreground=>$col,-font=>"{$fontty} 18",-command=>\&entriesnodata)->pack(-side=>bottom,-fill=>x);
}

if ((($activeoptionone eq 1) | ($activeoptiontwo eq 1))&&(($round eq 0)|($round > 0))&& (($counterentirelipidome eq 1) |($countermainglycero eq 1)| ($countermainhalo eq 1)| ($countercustomcheck eq 1) | ($countersulfo eq 1) | ($countermonoglycero eq 1) | ($counterdiglycero eq 1)|($countertriglycero eq 1)|($counterotherglycero eq 1)|($countermainphospho eq 1) | ($countersphingophospho eq 1)|($counterotherphospho eq 1)| ($countermainphospho eq 1) | ($countersphingophospho eq 1) | ($countergpsearch eq 1) | ($counterotherphospho eq 1) | ($counterfasearch eq 1) | ($countergpsearch eq 1) | ($counterglsearch eq 1) | ($counterpksearch eq 1) | ($counterprsearch eq 1) | ($counterspsearch eq 1)| ($counterslsearch eq 1) | ($counterstsearch eq 1))&&(($counter2lihpos eq 0)&&($counterlipos eq 0)&&($counterli2hneg eq 0)&& ($countermhpos eq 0) && ($countermampos eq 0)&&($counternapos eq 0) && ($counternahpos eq 0) && ($countermhneg eq 0)&&($counterachneg eq 0) && ($counternahneg eq 0)&&  ($countermmass eq 0) && ($counterclneg eq 0) &&($counterkpos eq 0)&& ($counter2khpos eq 0) &&($counterk2hneg eq 0)) )  	
{$errortoptitle="Result of the query";
$errortitle="Oops ! There are no results matching to the query ";
$errormess="\nChoose Molecular Mass or a Type of Ion .\n\n\n";  
$errorbottom="Back";
if ($masstypeselect eq "") {$masstypeselect= "Mass type not selected";}
$m->title("MS - LAMP - M. tb Lipidome MS-LAMP :$errortoptitle");
$nodata=$m->Frame(-background=>$col)->pack(-side=>top,-fill=>x);
$noquery=$nodata->Label(-text=>"\n$errortitle\n",-font=>"{times new roman} 24 bold",-background=>$col1,-foreground=>$col5,-borderwidth=>4,-relief=>ridge)->pack(-side=>'top',-fill=>x);
$queriedpara=$nodata->Label(-text=>"\nQueried parameters -   $optionalcomm2   $optionalcomm Mass : $masstypeselect\t Ion type : $qurdion \t  Window range :+/-  $range\t \n",-font=>"{times new roman} 12 bold",-background=>$col,-foreground=>$col5)->pack(-side=>'top',-fill=>x);
$label=$nodata->Label(-text=>"\n$errormess",-font=>"{times new roman} 36 ",-background=>$col,-foreground=>$col3)->pack(-side=>'top',-fill=>x);
$goback=$nodata->Button (-text=>"$errorbottom",-background=>$col4,-foreground=>$col,-font=>"{$fontty} 18",-command=>\&entriesnodata)->pack(-side=>bottom,-fill=>x);
}

if ((($activeoptionone eq 1) | ($activeoptiontwo eq 1))&&(($round eq 0)|($round > 0))&& ($counterentirelipidome eq 0) && ($countermainhalo eq 0) &&($countermainglycero eq 0) && ($countercustomcheck eq 0) && ($countersulfo eq 0) && ($countermonoglycero eq 0) && ($counterdiglycero eq 0) && ($countertriglycero eq 0) && ($counterotherglycero eq 0) && ($countermainphospho eq 0) && ($countersphingophospho eq 0) && ($counterotherphospho eq 0) && ($countermainphospho eq 0) && ($countersphingophospho eq 0) && ($countergpsearch eq 0) && ($counterotherphospho eq 0) && ($counterfasearch eq 0) && ($countergpsearch eq 0) && ($counterglsearch eq 0) && ($counterpksearch eq 0) && ($counterprsearch eq 0) && ($counterspsearch eq 0) && ($counterslsearch eq 0)&& ($counterstsearch eq 0)&&(($counter2lihpos eq 1)|($counterlipos eq 1)|($counterli2hneg eq 1) | ($countermhpos eq 1) | ($countermampos eq 1)|($counternapos eq 1) | ($counternahpos eq 1) | ($countermhneg eq 1)|($counterachneg eq 1) | ($counternahneg eq 1)|  ($countermmass eq 1) | ($counterclneg eq 1) |($counterkpos eq 1)| ($counter2khpos eq 1) |($counterk2hneg eq 1)) ) 	
{$errortoptitle="Result of the query";
$errortitle="Oops ! There are no results matching to the query ";
$errormess="\n\nSelect one or more lipid category(ies).\n\n";  
$errorbottom="Back";
if ($masstypeselect eq "") {$masstypeselect= "Mass type not selected";}
$m->title("MS - LAMP - M. tb Lipidome MS-LAMP :$errortoptitle");
$nodata=$m->Frame(-background=>$col)->pack(-side=>top,-fill=>x);
$noquery=$nodata->Label(-text=>"\n$errortitle\n",-font=>"{times new roman} 24 bold",-background=>$col1,-foreground=>$col5,-borderwidth=>4,-relief=>ridge)->pack(-side=>'top',-fill=>x);
$queriedpara=$nodata->Label(-text=>"\nQueried parameters -   $optionalcomm2   $optionalcomm Mass : $masstypeselect\t Ion type : $qurdion \t  Window range :+/-  $range\t \n",-font=>"{times new roman} 12 bold",-background=>$col,-foreground=>$col5)->pack(-side=>'top',-fill=>x);
$label=$nodata->Label(-text=>"\n$errormess",-font=>"{times new roman} 36 ",-background=>$col,-foreground=>$col3)->pack(-side=>'top',-fill=>x);
$goback=$nodata->Button (-text=>"$errorbottom",-background=>$col4,-foreground=>$col,-font=>"{$fontty} 18",-command=>\&entriesnodata)->pack(-side=>bottom,-fill=>x);
}

if (($activeoptionone eq 0) && ($activeoptiontwo eq 1)&&($loaft eq 1)&&($loart eq 1) &&($round eq 0)&& (($counterentirelipidome eq 1) |($countermainglycero eq 1)| ($countermainhalo eq 1)| ($countercustomcheck eq 1) | ($countersulfo eq 1) | ($countermonoglycero eq 1) | ($counterdiglycero eq 1)|($countertriglycero eq 1)|($counterotherglycero eq 1)|($countermainphospho eq 1) | ($countersphingophospho eq 1)|($counterotherphospho eq 1)| ($countermainphospho eq 1) | ($countersphingophospho eq 1) | ($countergpsearch eq 1) | ($counterotherphospho eq 1) | ($counterfasearch eq 1) | ($countergpsearch eq 1) | ($counterglsearch eq 1) | ($counterpksearch eq 1) | ($counterprsearch eq 1) | ($counterspsearch eq 1)| ($counterslsearch eq 1) | ($counterstsearch eq 1)) && (($counter2lihpos eq 1)|($counterlipos eq 1)|($counterli2hneg eq 1) | ($countermhpos eq 1) | ($countermampos eq 1)|($counternapos eq 1) | ($counternahpos eq 1) | ($countermhneg eq 1)|($counterachneg eq 1) | ($counternahneg eq 1)|  ($countermmass eq 1) | ($counterclneg eq 1) |($counterkpos eq 1)| ($counter2khpos eq 1) |($counterk2hneg eq 1)) )
{$errortoptitle="Result of the query";
$errortitle="Oops ! There are no results matching to the query ";
$errormess="\n\nUpload .txt file containing m/z &\n relative intensity values.\n";  
$errorbottom="Back";
if ($masstypeselect eq "") {$masstypeselect= "Mass type not selected";}
$m->title("MS - LAMP - M. tb Lipidome MS-LAMP :$errortoptitle");
$nodata=$m->Frame(-background=>$col)->pack(-side=>top,-fill=>x);
$noquery=$nodata->Label(-text=>"\n$errortitle\n",-font=>"{times new roman} 24 bold",-background=>$col1,-foreground=>$col5,-borderwidth=>4,-relief=>ridge)->pack(-side=>'top',-fill=>x);
$queriedpara=$nodata->Label(-text=>"\nQueried parameters -   $optionalcomm2   $optionalcomm Mass : $masstypeselect\t Ion type : $qurdion \t  Window range :+/-  $range\t \n",-font=>"{times new roman} 12 bold",-background=>$col,-foreground=>$col5)->pack(-side=>'top',-fill=>x);
$label=$nodata->Label(-text=>"\n$errormess",-font=>"{times new roman} 36 ",-background=>$col,-foreground=>$col3)->pack(-side=>'top',-fill=>x);
$goback=$nodata->Button (-text=>"$errorbottom",-background=>$col4,-foreground=>$col,-font=>"{$fontty} 18",-command=>\&entriesnodata)->pack(-side=>bottom,-fill=>x);
}




};



sub entriesnodata
{
$nodata->packForget();
&rangemain;
};
#***************************************************End of display for NO DATA**********************************************

#**************************************************Sub For data found****************************************************

sub datafound
{
	if ($countermhpos eq 1){$qurdion='[M+H]+'}		
	if($countermampos eq 1){$qurdion='[M+NH4]+'}		
	if($counternapos eq 1){$qurdion='[M+Na]+'}
	if($counternahpos eq 1){$qurdion='[M+2Na-H]+'}
	if($countermhneg eq 1){$qurdion='[M-H]-'}
	if($counterachneg eq 1){$qurdion='[M+HOAc-H]-'}
	if($counternahneg eq 1){$qurdion='[M+Na-2H]-'}
	if($counterclneg eq 1){$qurdion='[M+Cl]-'}
	if($counterlipos eq 1){$qurdion='[M+Li]+'}
	if($counter2lihpos eq 1){$qurdion='[M+2Li-H]+'}
	if($counterli2hneg eq 1){$qurdion='[M+Li-2H]-'}
	if($counterkpos eq 1){$qurdion='[M+K]+'}
	if($counter2khpos eq 1){$qurdion='[M+2K-H]+'}
	if($counterk2hneg eq 1){$qurdion='[M+K-2H]-'}
	if($countermmass eq 1){$qurdion='Molecular Mass'}
$acomment="";
$aaditionalcomment="";
if ($masschoice eq 0){$aaditionalcomment="$qurdion (Monoisotopic)";}
if ($masschoice eq 1){$aaditionalcomment="$qurdion (Average)";}

if (($activeoptionone eq 1)&&($countermmass eq 1))
{$acomment ="List of Molecular Masses";}
if (($activeoptionone eq 1)&&($countermmass != 1))
{$acomment="List of m/z and no intensity values";}
if (($activeoptiontwo eq 1)&&($countermmass != 1))
{$acomment="List of m/z  and relative intensity values";}


if (($activeoptiontwo eq 1)&&($activeoptionone eq 0))
	{$m->title("MS - LAMP - M. tb Lipidome MS-LAMP : Result of the query for queried parameters - Uploaded File : $open ($comment) \n Relative Intensity threshold : $relativeintensityvalue \t Ion type : $aaditionalcomment\t ,Window range :+/-  $range\t Number of m/z values queried : $lenmz");
	}
elsif (($activeoptiontwo eq 0)&&($activeoptionone eq 1))
	{$m->title("MS - LAMP - M. tb Lipidome MS-LAMP : Result of the query for queried parameters - Uploaded File : $open ($comment) \n Ion type : $aaditionalcomment\t ,Window range :+/-  $range\t Number of m/z values queried : $lenmz");}

&entriessearching;

$fa=0;$gp=0;$gl=0;$pk=0;$pr=0;$sl=0;$sp=0;$st=0;$cq=0;$sfl=0;$flor=0;$clor=0;$brom=0;$iod=0;$mak=0;$mac=0;$diac=0;$diak=0;$diacak=0;$diakac=0;$triac=0;$spl=0;$opl=0;
$customquery=$customenter->get();$ogll=0;@lstrfa=@lstrgp=@lstrgl=@lstrpk=@lstrpr=@lstrsl=@lstrsp=@lstrst=@lstrcq=@lstrsfl=@lstrclor=@lstrflor=@lstrbrom=@lstriod=@lstrmac=@lstrmak=@lstrmag=@lstrdiac=@lstrdiak=@lstrdiag=@lstrdiacak=@lstrdiakac=@lstrtriac=@lstrogll="";

$fa=0;$gp=0;$gl=0;$pk=0;$pr=0;$sl=0;$sp=0;$st=0;$cq=0;$sfl=0;$flor=0;$clor=0;$brom=0;$iod=0;$mak=0;$mac=0;$diac=0;$diak=0;$diacak=0;$diakac=0;$triac=0;$spl=0;$opl=0;
$customquery=$customenter->get();$ogll=0;@lstrfa=@lstrgp=@lstrgl=@lstrpk=@lstrpr=@lstrsl=@lstrsp=@lstrst=@lstrcq=@lstrsfl=@lstrclor=@lstrflor=@lstrbrom=@lstriod=@lstrmac=@lstrmak=@lstrmag=@lstrdiac=@lstrdiak=@lstrdiag=@lstrdiacak=@lstrdiakac=@lstrtriac=@lstrogll="";

chomp $customquery;
$customquery=uc($customquery);
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]))
			{
		if ( $data{$_} =~ /MMFA/){$lstrfa[$fa]=substr($data{$_},1,-2);$fa++;};
		if ( $data{$_} =~ /MMGP/){$lstrgp[$gp]=substr($data{$_},1,-2);$gp++};		
		if ( $data{$_} =~ /MMGL/){$lstrgl[$gl]=substr($data{$_},1,-2);$gl++};
		if ( $data{$_} =~ /MMPK/){$lstrpk[$pk]=substr($data{$_},1,-2);$pk++};
		if ( $data{$_} =~ /MMPR/){$lstrpr[$pr]=substr($data{$_},1,-2);$pr++};
		if ( $data{$_} =~ /MMSL/){$lstrsl[$sl]=substr($data{$_},1,-2);$sl++};
		if ( $data{$_} =~ /MMSP/){$lstrsp[$sp]=substr($data{$_},1,-2);$sp++};
		if ( $data{$_} =~ /MMST/){$lstrst[$st]=substr($data{$_},1,-2);$st++};
		if ( $m2sc{$_} =~ /$customquery/){$lstrcq[$cq]=substr($data{$_},1,-2);$cq++};
		if ( $m2f{$_} =~ /S/){$lstrsfl[$sfl]=substr($data{$_},1,-2);$sfl++};
		if ( $m2f{$_} =~ /F/){$lstrflor[$flor]=substr($data{$_},1,-2);$flor++};
		if ( $m2f{$_} =~ /Cl/){$lstrclor[$clor]=substr($data{$_},1,-2);$clor++};			
		if ( $m2f{$_} =~ /Br/){$lstrbrom[$brom]=substr($data{$_},1,-2);$brom++};
		if ( $m2f{$_} =~ /I/){$lstriod[$iod]=substr($data{$_},1,-2);$iod++};
		if ( $m2sc{$_} =~ /GL0101/){$lstrmac[$mac]=substr($data{$_},1,-2);$mac++};			
		if ( $m2sc{$_} =~ /GL0102/){$lstrmak[$mak]=substr($data{$_},1,-2);$mak++};
		if ( $m2sc{$_} =~ /GL01/){$lstrmag[$mag]=substr($data{$_},1,-2);$mag++};	
		if ( $m2sc{$_} =~ /GL0201/){$lstrdiac[$diac]=substr($data{$_},1,-2);$diac++};			
		if ( $m2sc{$_} =~ /GL0203/){$lstrdiak[$diak]=substr($data{$_},1,-2);$diak++};
		if ( $m2sc{$_} =~ /GL02/){$lstrdiag[$diag]=substr($data{$_},1,-2);$diag++};
		if ( $m2sc{$_} =~ /GL0207/){$lstrdiacak[$diacak]=substr($data{$_},1,-2);$diacak++};			
		if ( $m2sc{$_} =~ /GL0202/){$lstrdiakac[$diakac]=substr($data{$_},1,-2);$diakac++};
		if ( $m2mc{$_} =~ /GL03/){$lstrtriac[$triac]=substr($data{$_},1,-2);$triac++};
		if ( $m2mc{$_} =~ /GL00/){$lstrogll[$ogll]=substr($data{$_},1,-2);$ogll++};
		if ( $m2mc{$_} =~ /GL04/){$lstrogll[$ogll]=substr($data{$_},1,-2);$ogll++};
		if ( $m2mc{$_} =~ /GL05/){$lstrogll[$ogll]=substr($data{$_},1,-2);$ogll++};
		if ( ($m2f{$_} =~ /P/ ) && ( $data{$_} =~ /MMGP/)){$lstrglp[$all]=substr($data{$_},1,-2);$all++};
		if ( ($m2f{$_} =~ /P/ ) && ( $data{$_} =~ /MMSP/)){$lstrspl[$spl]=substr($data{$_},1,-2);$spl++};
		if ( ($m2f{$_} =~ /P/ ) && (( $data{$_} =~ /MMFA/) | ( $data{$_} =~ /MMGL/) | ( $data{$_} =~ /MMSL/) | ( $data{$_} =~ /MMST/) | ( $data{$_} =~ /MMPR/) | ( $data{$_} =~ /MMPK/)) ){$lstropl[$opl]=substr($data{$_},1,-2);$opl++};
}
	}
	}

$fontvalresult=11;
$fontforresult="calibri";

$m1=$m->Frame(-background=>white)->pack(-side=>top,-fill=>x);
$structureslabel=$m1->Frame(-background =>$col4,-foreground =>$col5,-relief => ridge,-borderwidth=>5)->pack(-side=> top , -fill => x);

$m2=$m1->Frame(-background=>white)->pack(-side=>top,-fill=>x);
$m3=$m->Frame(-background=>white)->pack(-side=>bottom,-fill=>x);

$ressps=$structureslabel->Label( -text=>"" ,-font=>"{Comic Sans Ms}4 bold",-background =>$col1 ,-foreground =>$col5)->pack(-side=>top,-fill=>x,-anchor=>center);
$reslabel=$structureslabel->Label( -text=>"Result of the Query" ,-font=>"{$fontty} 20 bold",-background =>$col1,-foreground =>$col5)->pack(-side=>top,-fill=>x,-anchor=>center);
$ressps=$structureslabel->Label( -text=>"" ,-font=>"{Comic Sans Ms}4 bold",-background =>$col1 ,-foreground =>$col5)->pack(-side=>top,-fill=>x,-anchor=>center);
if (($activeoptiontwo eq 1)&&($activeoptionone eq 0))
{$resvaria=$structureslabel->Label( -text=>"Queried Parameters- Uploaded File : $open ($acomment)\nRelative Intensity threshold : $relativeintensityvalue \t Ion type : $aaditionalcomment\t Window range : +/- $range\t Number of m/z values queried : $lenmz",-background =>white ,-foreground => black,-font=>"{Times new roman} 11 ")->pack(-side=>top,-fill=>x,-anchor=>center);}		
elsif (($activeoptiontwo eq 0)&&($activeoptionone eq 1))
{$resvaria=$structureslabel->Label( -text=>"Queried Parameters- Uploaded File : $open ($acomment) \n\t Ion type : $aaditionalcomment \t Window range : +/- $range\t Number of m/z values queried : $lenmz",-background =>white ,-foreground => black,-font=>"{Times new roman} 11 ")->pack(-side=>top,-fill=>x,-anchor=>center);}		
$ressps=$structureslabel->Label( -text=>"" ,-font=>"{Comic Sans Ms}4 bold",-background =>$col1 ,-foreground =>$col5)->pack(-side=>top,-fill=>x,-anchor=>center);
$ms=$m2->Frame(-background=>white)->pack(-side=>top,-fill=>x);
$fontvalresult=11;
if ($counterentirelipidome eq 1)
{

$faspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$fastructure=$ms->Button(-text=>"Fatty Acyls : $fa",-font=>"{$fontforresult} $fontvalresult bold",-background =>"white" ,-foreground => "blue",-relief => raised,-command=>\&strfal)
		->pack(-side=> top , -fill => x);
if($fa eq 0){$fastructure->configure(-state=>'disabled');};

$glspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$glstructure=$ms->Button(-text=>"Glycerolipids : $gl",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => orange,-relief => raised,-command=>\&strgll)
		->pack(-side=> top , -fill => x);
if($gl eq 0){$glstructure->configure(-state=>'disabled');};
$gpspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$gpstructure=$ms->Button(-text=>"Glycerophospholipids : $gp",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground =>"black",-relief => raised,-command=>\&strgpl)
		->pack(-side=> top , -fill => x);
if($gp eq 0){$gpstructure->configure(-state=>'disabled');};
$pkspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$pkstructure=$ms->Button(-text=>"Polyketides : $pk",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => red,-relief => raised,-command=>\&strpkl)
		->pack(-side=> top , -fill => x);
if($pk eq 0){$pkstructure->configure(-state=>'disabled');};
$prspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$prstructure=$ms->Button(-text=>"Prenol Lipids : $pr",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => purple,-relief => raised,-command=>\&strprl)
		->pack(-side=> top , -fill => x);
if($pr eq 0){$prstructure->configure(-state=>'disabled');};
$slspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$slstructure=$ms->Button(-text=>"Saccharolipids : $sl",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground =>"navy blue",-relief => raised,-command=>\&strsll)
		->pack(-side=> top , -fill => x);
if($sl eq 0){$slstructure->configure(-state=>'disabled');};
$spspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$spstructure=$ms->Button(-text=>"Sphingolipids : $sp",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "dark green",-relief => raised,-command=>\&strspl)
		->pack(-side=> top , -fill => x);
if($sp eq 0){$spstructure->configure(-state=>'disabled');}
$stspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$ststructure=$ms->Button(-text=>"Sterol Lipids : $st",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => brown,-relief => raised,-command=>\&strstl)
		->pack(-side=> top , -fill => x);
if($st eq 0){$ststructure->configure(-state=>'disabled');};
}
if (($counterfasearch eq 1) && ($counterentirelipidome eq 0))
{$faspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$fastructure=$ms->Button(-text=>"Fatty Acyls : $fa",-font=>"{$fontforresult} $fontvalresult bold",-background =>"white" ,-foreground => "blue",-relief => raised,-command=>\&strfal)
		->pack(-side=> top , -fill => x);
if($fa eq 0){$fastructure->configure(-state=>'disabled');};}

if (($counterglsearch eq 1) && ($counterentirelipidome eq 0))
{$glspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$glstructure=$ms->Button(-text=>"Glycerolipids : $gl",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => orange,-relief => raised,-command=>\&strgll)
		->pack(-side=> top , -fill => x);

if($gl eq 0){$glstructure->configure(-state=>'disabled');};}

if (($countergpsearch eq 1) && ($counterentirelipidome eq 0))
{$gpspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$gpstructure=$ms->Button(-text=>"Glycerophospholipids : $gp",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground =>"black",-relief => raised,-command=>\&strgpl)
		->pack(-side=> top , -fill => x);
if($gp eq 0){$gpstructure->configure(-state=>'disabled');};}



if (($counterpksearch eq 1) && ($counterentirelipidome eq 0))
{$pkspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$pkstructure=$ms->Button(-text=>"Polyketides : $pk",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => red,-relief => raised,-command=>\&strpkl)
		->pack(-side=> top , -fill => x);
if($pk eq 0){$pkstructure->configure(-state=>'disabled');};}

if (($counterprsearch eq 1) && ($counterentirelipidome eq 0))
{$prspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$prstructure=$ms->Button(-text=>"Prenol Lipids : $pr",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => purple,-relief => raised,-command=>\&strprl)
		->pack(-side=> top , -fill => x);
if($pr eq 0){$prstructure->configure(-state=>'disabled');};}

if (($counterslsearch eq 1) && ($counterentirelipidome eq 0))
{$slspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$slstructure=$ms->Button(-text=>"Saccharolipids : $sl",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground =>"navy blue",-relief => raised,-command=>\&strsll)
		->pack(-side=> top , -fill => x);
if($sl eq 0){$slstructure->configure(-state=>'disabled');};}


if (($counterspsearch eq 1) && ($counterentirelipidome eq 0))
{$spspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$spstructure=$ms->Button(-text=>"Sphingolipids : $sp",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "dark green",-relief => raised,-command=>\&strspl)
		->pack(-side=> top , -fill => x);
if($sp eq 0){$spstructure->configure(-state=>'disabled');};}

if (($counterstsearch eq 1) && ($counterentirelipidome eq 0))
{$stspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$ststructure=$ms->Button(-text=>"Sterol Lipids : $st",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => brown,-relief => raised,-command=>\&strstl)
		->pack(-side=> top , -fill => x);
if($st eq 0){$ststructure->configure(-state=>'disabled');};}


if (($countercustomcheck eq 1) && ($counterentirelipidome eq 0))
{$cqspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$cqstructure=$ms->Button(-text=>"$customquery : $cq",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "purple",-relief => raised,-command=>\&strcql)
		->pack(-side=> top , -fill => x);
if($cq eq 0){$cqstructure->configure(-state=>'disabled');};}

if ($countersulfo eq 1)
{$sflspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$sflstructure=$ms->Button(-text=>"Sulfolipids : $sfl",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "dark green",-relief => raised,-command=>\&strsfl)
		->pack(-side=> top , -fill => x);
if($sfl eq 0){$sflstructure->configure(-state=>'disabled');};}


if ($countermainhalo eq 1) 
{
$florspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$florstructure=$ms->Button(-text=>"Flourine containing Lipids : $flor",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "green",-relief => raised,-command=>\&strflor)
		->pack(-side=> top , -fill => x);
if($flor eq 0){$florstructure->configure(-state=>'disabled');};


$clorspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$clorstructure=$ms->Button(-text=>"Chlorine containing Lipids : $clor",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "Orange",-relief => raised,-command=>\&strclor)
		->pack(-side=> top , -fill => x);
if($clor eq 0){$clorstructure->configure(-state=>'disabled');};


$bromspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$bromstructure=$ms->Button(-text=>"Bromine containing Lipids : $brom",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "red",-relief => raised,-command=>\&strbrom)
		->pack(-side=> top , -fill => x);
if($brom eq 0){$bromstructure->configure(-state=>'disabled');};

$iodspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$iodstructure=$ms->Button(-text=>"Iodine containing Lipids : $iod",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "Black",-relief => raised,-command=>\&striod)
		->pack(-side=> top , -fill => x);
if($iod eq 0){$iodstructure->configure(-state=>'disabled');};
}

if ($countermainglycero eq 1) 
{
$mono=($mak+$mac);
$monospacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$monostructure=$ms->Button(-text=>"Monoglycerides : $mono",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "blue",-relief => raised,-command=>\&strmag)
		->pack(-side=> top , -fill => x);
if($mono eq 0){$monostructure->configure(-state=>'disabled');};

$di=($diac+$diak+$diacak+$diakac);
$dispacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$distructure=$ms->Button(-text=>"Diglycerides : $di",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "dark green",-relief => raised,-command=>\&strdiag)
		->pack(-side=> top , -fill => x);
if($di eq 0){$distructure->configure(-state=>'disabled');};


$trispacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$tristructure=$ms->Button(-text=>"Triglycerides : $triac",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "green",-relief => raised,-command=>\&strtriac)
		->pack(-side=> top , -fill => x);
if($triac eq 0){$tristructure->configure(-state=>'disabled');};

$otherspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$otherstructure=$ms->Button(-text=>"Other glycerolipids : $ogll",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "dark green",-relief => raised,-command=>\&strogll)
		->pack(-side=> top , -fill => x);
if($ogll eq 0){$otherstructure->configure(-state=>'disabled');};


}

if (($countermonoglycero eq 1) && ($countermainglycero eq 0))
{$mono=($mak+$mac);

$monospacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$monostructure=$ms->Button(-text=>"Monoglycerides : $mono",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "orange",-relief => raised,-command=>\&strmag)
		->pack(-side=> top , -fill => x);
if($mono eq 0){$monostructure->configure(-state=>'disabled');};}

if (($counterdiglycero eq 1) && ($countermainglycero eq 0))
{$di=($diac+$diak+$diacak+$diakac);
$dispacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$distructure=$ms->Button(-text=>"Diglycerides : $di",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "red",-relief => raised,-command=>\&strdiag)
		->pack(-side=> top , -fill => x);
if($di eq 0){$distructure->configure(-state=>'disabled');};}

if (($countertriglycero eq 1) && ($countermainglycero eq 0))
{
$trispacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$tristructure=$ms->Button(-text=>"Triglycerides : $triac",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "dark green",-relief => raised,-command=>\&strtriac)
		->pack(-side=> top , -fill => x);
if($triac eq 0){$tristructure->configure(-state=>'disabled');};}

if (($counterotherglycero eq 1) && ($countermainglycero eq 0))
{
$otherspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$otherstructure=$ms->Button(-text=>"Other glycerolipids : $ogll",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "black",-relief => raised,-command=>\&strogll)
		->pack(-side=> top , -fill => x);
if($ogll eq 0){$otherstructure->configure(-state=>'disabled');};}



if ($countermainphospho eq 1) 
{

$glpspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$glpstructure=$ms->Button(-text=>"Glycerophospholipids : $gp",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "dark green",-relief => raised,-command=>\&strgpl)
		->pack(-side=> top , -fill => x);
if($gp eq 0){$glpstructure->configure(-state=>'disabled');};


$splspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$splstructure=$ms->Button(-text=>"Sphingophospholipids : $spl",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "blue",-relief => raised,-command=>\&strspll)
		->pack(-side=> top , -fill => x);
if($spl eq 0){$splstructure->configure(-state=>'disabled');};


$oplspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$oplstructure=$ms->Button(-text=>"Other phospholipids : $opl",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "red",-relief => raised,-command=>\&stropl)
		->pack(-side=> top , -fill => x);
if($opl eq 0){$oplstructure->configure(-state=>'disabled');};

}



if (($countersphingophospho eq 1) && ($countermainphospho eq 0))
{
$splspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$splstructure=$ms->Button(-text=>"Sphingophospholipids : $spl",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "orange",-relief => raised,-command=>\&strspll)
		->pack(-side=> top , -fill => x);
if($spl eq 0){$splstructure->configure(-state=>'disabled');};}

if (($counterotherphospho eq 1) && ($countermainphospho eq 0))
{
$oplspacestructure=$ms->Label( -text=>"",-font=>"{times new roman} 1",-background =>white ,-foreground => white)
		->pack(-side=> top , -fill => x);
$oplstructure=$ms->Button(-text=>"Other phospholipids : $opl",-font=>"{$fontforresult} $fontvalresult bold",-background =>white ,-foreground => "dark green",-relief => raised,-command=>\&stropl)
		->pack(-side=> top , -fill => x);
if($opl eq 0){$oplstructure->configure(-state=>'disabled');};}


$me=$m3->Frame(-background=>'white')->pack(-side=>bottom,-fill=>x);
$goback=$me->Button (-text=>"Click Here to Start Search Again ",-background=>$col1,-foreground=>$col3,-font=>"{$fontty} 12 bold" ,-command=>\&entriesdatafound)->pack(-side=>bottom,-fill=>x);
$checkfor1=$me->Frame(-background=>white)->pack(-side=>bottom,-anchor=>center);
$checkfor2=$me->Frame(-background=>white)->pack(-side=>bottom,-anchor=>center,-fill=>x);
$csv=$checkfor1->Checkbutton(-text => ".csv",-command => \&csvoutput,-font=>"{calibri} 13" ,-background=>"light blue",-foreground=>black)->pack(-side => 'left');
$txt=$checkfor1->Checkbutton(-text => ".txt",-command => \&txtoutput,-font=>"{calibri} 13" ,-background=>"light yellow",-foreground=>black)->pack(-side => 'left');
#$xls=$checkfor1->Checkbutton(-text => ".xls",-command => \&xlsoutput,-font=>"{calibri} 13" ,-background=>"light pink",-foreground=>black)->pack(-side => 'left');
$choiceoutput=$checkfor2->Label( -text=>"To print the whole result , choose the output format (more than one allowed)",-font=>"{times new roman} 12 bold",-background =>$col2,-foreground =>$col4,-relief => raised)
		->pack(-side=> bottom , -fill => x);


};
#**********************************sub to return back and search again*****************************************************
sub entriesdatafound
{
$m1->packForget();
$m3->packForget();
&rangemain;
};

##***********************************sub for output*********************************************************



#******************************************sub for csv output*****************************************

sub csvoutput
{
$filetypes =[['Comma Saparated Values', '.csv'],
              ['All Files',   '*'],];
sub save_file {
$save = $m->getSaveFile(-filetypes => $filetypes, 
                             -initialfile => 'MS-LAMP',
                             -defaultextension => '.csv');};
&save_file;
open OUT,">$save" or die "cannot open the file";

if ($masschoice eq 0){$masschoiceforprintcsv ="M-Monoisotopic";}
if ($masschoice eq 1){$masschoiceforprintcsv ="M-Average";}

if ($counterentirelipidome eq 1)
{
	print OUT "\n\n<<<< M. tb Lipidome MS-LAMP >>>>\n\n";
	&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]))
		{&csvoutmain;}
}
}
}

if (($fa>0)&& (($counterfasearch eq 1)|($counterentirelipidome eq 1)))
{	print OUT "\n\n<<<< FATTY ACYLS >>>>\n\n";
	&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);
if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($data{$_} =~ /MMFA/))
		{&csvoutmain;}
	}
}
}
if (($gl>0)&& (($counterglsearch eq 1)|($counterentirelipidome eq 1)))
{	print OUT "\n\n<<<< GLYCEROLIPIDS >>>>\n\n";
	&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);
if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( $data{$_} =~ /MMGL/))
	{&csvoutmain;}
	}
}};

if (($gp>0)&& (($countergpsearch eq 1)|($counterentirelipidome eq 1)))
{print OUT "\n\n<<<< GLYCEROPHOSPHOLIPIDS >>>>\n\n";
	&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( $data{$_} =~ /MMGP/))
	{&csvoutmain;}
	}
}
}

if (($pk>0)&& (($counterpksearch eq 1)|($counterentirelipidome eq 1)))
{print OUT "\n\n<<<< POLYKETIDES  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( $data{$_} =~ /MMPK/))
	{&csvoutmain;}
	}
}
}
if (($pr>0)&& (($counterprsearch eq 1)|($counterentirelipidome eq 1)))
{print OUT "\n\n<<<< PRENOL LIPIDS  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	

	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( $data{$_} =~ /MMPR/))
	{&csvoutmain;}
	}
}
}
if (($sl>0)&& (($counterslsearch eq 1)|($counterentirelipidome eq 1)))
{print OUT "\n\n<<<< SACCHAROLIPIDS  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( $data{$_} =~ /MMSL/))
	{&csvoutmain;}
	}
}
}
if (($sp>0)&& (($counterspsearch eq 1)|($counterentirelipidome eq 1)))
{print OUT "\n\n<<<<SPHINGOLIPIDS >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( $data{$_} =~ /MMSP/))
	{&csvoutmain;}
	}
}
}

if (($st>0)&& (($counterstsearch eq 1)|($counterentirelipidome eq 1)))
{print OUT "\n\n<<<< STEROL LIPIDS  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( $data{$_} =~ /MMST/))
{&csvoutmain;		}
	}
}
}

if (($countercustomcheck eq 1)&&($cq>0))
{print OUT "\n\n<<<< Custom Search >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( $m2sc{$_} =~ /$customquery/))
{&csvoutmain;}}
}
}

if (($countersulfo eq 1)&&($sfl>0))
{print OUT "\n\n<<<< SULFOLIPIDS  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( $m2f{$_} =~ /S/))
{&csvoutmain;}}}
}

$allhalo=($flor+$clor+$brom+$iod);
if (($countermainhalo eq 1) && ($allhalo>1))
{print OUT "\n\n<<<< ALL HALOGENATED LIPIDS  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( ($m2f{$_} =~ /F/) |($m2f{$_} =~ /Cl/) |($m2f{$_} =~ /Br/) | ($m2f{$_} =~ /I/) ))
{&csvoutmain;}}}}

if (($countermainhalo eq 1)  && ($flor >0))
{print OUT "\n\n<<<< Flourine Containing lipids  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2f{$_} =~ /F/))
{&csvoutmain;}}}}


if (($countermainhalo eq 1)  && ($clor >0))
{print OUT "\n\n<<<< Chlorine containing lipids  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2f{$_} =~ /Cl/))
{&csvoutmain;}}}}


if (($countermainhalo eq 1)  && ($brom >0))
{print OUT "\n\n<<<< Bromine containing lipids  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2f{$_} =~ /Br/))
{&csvoutmain;}}}}


if (($countermainhalo eq 1)  && ($iod >0))
{print OUT "\n\n<<<< Iodine containing lipids  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2f{$_} =~ /I/))
{&csvoutmain;}}}}

$glyc=($mono+$di+$triac+$ogll);
if (($countermainglycero eq 1) && ($glyc >0))
{print OUT "\n\n<<<< Glycero Lipids  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2mc{$_} =~ /GL/))
{&csvoutmain;}}}}


if ((($countermainglycero eq 1) | ($countermonoglycero eq 1)) && ($mono >0))
{print OUT "\n\n<<<< Monoglycerides >>>>\n \n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2mc{$_} =~ /GL01/))
{&csvoutmain;}}}}


if ((($countermainglycero eq 1) | ($countermonoglycero eq 1)) && ($mac >0))
{print OUT "\n\n<<<<  Monoacyl glycerols  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2sc{$_} =~ /GL0101/))
{&csvoutmain;}}}}


if ((($countermainglycero eq 1) | ($countermonoglycero eq 1)) && ($mak >0))
{print OUT "\n\n<<<< Monoalkyl glycerols  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2sc{$_} =~ /GL0102/))
{&csvoutmain;}}}}


if ((($countermainglycero eq 1) | ($counterdiglycero eq 1)) && ($di >0))
{print OUT "\n\n<<<< Diglycerides  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2sc{$_} =~ /GL02/))
{&csvoutmain;}}}}


if ((($countermainglycero eq 1) | ($counterdiglycero eq 1)) && ($diak >0))
{print OUT "\n\n<<<< Dialkyl glycerols  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2sc{$_} =~ /GL0203/))
{&csvoutmain;}}}}


if ((($countermainglycero eq 1) | ($counterdiglycero eq 1)) && ($diac >0))
{print OUT "\n\n<<<< Diacyl glycerols  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2sc{$_} =~ /GL0201/))
{&csvoutmain;}}}}


if ((($countermainglycero eq 1) | ($counterdiglycero eq 1)) && ($diacak >0))
{print OUT "\n\n<<<< 1-acyl,2-alkyl glycerols  >>>>\n\n ";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2sc{$_} =~ /GL0207/))
{&csvoutmain;}}}}



if ((($countermainglycero eq 1) | ($counterdiglycero eq 1)) && ($diakac >0))
{print OUT "\n\n<<<< 1-alkyl,2-acyl glycerols  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2sc{$_} =~ /GL0202/))
{&csvoutmain;}}}}


if ((($countermainglycero eq 1) | ($countertriglycero eq 1)) && ($triac >0))
{print OUT "\n\n<<<<  TRIGLYCERIDES  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2mc{$_} =~ /GL03/))
{&csvoutmain;}}}}

if ((($countermainglycero eq 1) | ($counterotherglycero eq 1)) && ($ogll >0))
{print OUT "\n\n<<<<  OTHER GLYCEROLS  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && (($m2mc{$_} =~ /GL00/)|($m2mc{$_} =~ /GL04/)|($m2mc{$_} =~ /GL05/)))
{&csvoutmain;}}}}

$apl=($gp+$spl+$opl);
if (($countermainphospho eq 1) && ($apl >0))
{print OUT "\n\n<<<< All phospholipids  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2f{$_} =~ /P/))
{&csvoutmain;}}}}


if ((($countermainphospho eq 1) | ($countergpsearch eq 1)) && ($gp >0))
{print OUT "\n\n<<<< Glycerophospholipids  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && (($m2f{$_} =~ /P/) && ($data{$_} =~ /MMGP/)) )
{&csvoutmain;}}}}


if ((($countermainphospho eq 1) | ($countersphingophospho eq 1)) && ($spl >0))
{print OUT "\n\n<<<<  Sphingophospholipids  >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && (($m2f{$_} =~ /P/) && ($data{$_} =~ /MMSP/)) )
{&csvoutmain;}}}}


if ((($countermainphospho eq 1) | ($counterotherphospho eq 1)) && ($opl >0))
{print OUT "\n\n<<<<  Other phospholipids >>>>\n\n";
&csvouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && (($m2f{$_} =~ /P/ ) && (( $data{$_} =~ /MMFA/) | ( $data{$_} =~ /MMGL/) | ( $data{$_} =~ /MMSL/) | ( $data{$_} =~ /MMST/) | ( $data{$_} =~ /MMPR/) | ( $data{$_} =~ /MMPK/))) )
{&csvoutmain;}}}}





sub csvouthead{print OUT "\"$masschoiceforprintcsv (db)*\",\"Molecular Formulae\",\"Scientific Name\",\"Category\",\"Main Class\",\"Subclass\",\n";}

sub csvoutmain{	$code = substr($_,0,-2);
		chomp $data{$_};
		$formlu=substr($m2f{$_},1,-4);
		chomp $m2sn{$_};
		chomp $m2c{$_};
		chomp $m2mc{$_};
		chomp $m2sc{$_};
		print OUT "\"$code\",$data{$_},\"$formlu\",$m2sn{$_},$m2c{$_},$m2mc{$_},$m2sc{$_}\n";
		}

close OUT;
};

#******************************************sub for txt output*****************************************
sub txtoutput
{
$filetypes =[['Text File', '.txt'],
              ['All Files',   '*'],];
sub save_file {
$save = $m->getSaveFile(-filetypes => $filetypes, 
                             -initialfile => 'MS-LAMP',
                             -defaultextension => '.txt');};

&save_file;
open OUT,">$save" or die "cannot open the file";

if ($masschoice eq 0){$masschoiceforprinttxt ="M-Monoisotopic";$mcfp="$qurdion (Monoisotopic)";}
if ($masschoice eq 1){$masschoiceforprinttxt ="M-Average";$mcfp="$qurdion (Average)";}


	if ($countermhpos eq 1){$qurdion='[M+H]+'}		
	if($countermampos eq 1){$qurdion='[M+NH4]+'}		
	if($counternapos eq 1){$qurdion='[M+Na]+'}
	if($counternahpos eq 1){$qurdion='[M+2Na-H]+'}
	if($countermhneg eq 1){$qurdion='[M-H]-'}
	if($counterachneg eq 1){$qurdion='[M+HOAc-H]-'}
	if($counternahneg eq 1){$qurdion='[M+Na-2H]-'}
	if($counterclneg eq 1){$qurdion='[M+Cl]-'}
	if($counterlipos eq 1){$qurdion='[M+Li]+'}
	if($counter2lihpos eq 1){$qurdion='[M+2Li-H]+'}
	if($counterli2hneg eq 1){$qurdion='[M+Li-2H]-'}
	if($counterkpos eq 1){$qurdion='[M+K]+'}
	if($counter2khpos eq 1){$qurdion='[M+2K-H]+'}
	if($counterk2hneg eq 1){$qurdion='[M+K-2H]-'}
	if($countermmass eq 1){$qurdion='Molecular Mass'}
print OUT "\t\tM. tb Lipidome MS-LAMP\n\n";
print OUT "This workbook gives the result of the query as detailed below ";

if (($activeoptiontwo eq 1)&&($activeoptionone eq 0))
	{print OUT "\n Relative Intensity threshold : $relativeintensityvalue \t Queried Ion : $mcfp \t Window range : $range\nNumber of m/z values queried : $lenmz\n";}
elsif (($activeoptiontwo eq 0)&&($activeoptionone eq 1))
	{print OUT "\n Queried Ion : $mcfp \t Window range : $range\nNumber of m/z values queried : $lenmz\n";}
if (($counterentirelipidome eq 1) | ($counterfasearch eq 1 )){print OUT "Fatty Acyls : $fa \n";}
if (($counterentirelipidome eq 1) | ($counterglsearch eq 1 )){print OUT "Glycerolipids : $gl \n";}
if (($counterentirelipidome eq 1) | ($countergpsearch eq 1 )){print OUT "Glycerophospholipids : $gp \n";}
if (($counterentirelipidome eq 1) | ($counterpksearch eq 1 )){print OUT "Polyketides : $pk \n";}
if (($counterentirelipidome eq 1) | ($counterprsearch eq 1 )){print OUT "Prenol Lipids : $pr \n";}
if (($counterentirelipidome eq 1) | ($counterslsearch eq 1 ) ){print OUT "Saccharolipids : $sl \n";}
if (($counterentirelipidome eq 1) | ($counterspsearch eq 1 )){print OUT "Sphingolipids : $sp \n";}
if (($counterentirelipidome eq 1) | ($counterstsearch eq 1 ) ){print OUT "Sterol Lipids : $st \n";}
if ($countercustomcheck eq 1){print OUT "$customquery : $cq \n";}
if ($countersulfo eq 1){print OUT "Sulfolipids : $sfl \n";}
if ($countermainhalo eq 1){$allhalo=($flor+$clor+$brom+$iod);
print OUT "All Halogenated Lipids : $allhalo \n";
print OUT "Flourine Containing Lipids : $flor \n";
print OUT "Chlorine Containing Lipids : $clor \n";
print OUT "Bromine Containing Lipids : $brom \n";
print OUT "Iodine Containing Lipids : $iod \n";}
if ($countermainglycero eq 1){$glycero=($mac+$mak+$diak+$diac+$diacak+$diakac+$triac+$ogll);print OUT "Glycero Lipids : $glycero \n";}
if (($countermainglycero eq 1) | ($countermonoglycero eq 1)){print OUT "Monoglycerides : $mono \n";}
if (($countermainglycero eq 1) | ($counterdiglycero eq 1)){print OUT "Diglycerides : $di \n";}
if (($countermainglycero eq 1) | ($countertriglycero eq 1)){print OUT "Triglycerides : $triac \n";}
if (($countermainglycero eq 1) | ($counterotherglycero eq 1)){print OUT "Other glycerolipids : $ogll \n";}
if ($countermainphospho eq 1){$apl=($gp+$spl+$opl);print OUT "All phospholipids : $apl \n";}
if (($countermainphospho eq 1) | ($countergpsearch eq 1)){print OUT "Glycerophospholipids : $gp \n";}
if (($countermainphospho eq 1) | ($countersphingophospho eq 1)){print OUT "Sphingophospholipids : $spl \n";}
if (($countermainphospho eq 1) | ($counterotherphospho eq 1)){print OUT "Other phospholipids : $opl \n";}	
if ($countermainhalo eq 1){print OUT "Please Note : There are no Halogenated lipids belonging to GL, GP and SL categories in the current database (i.e. M. tb Lipidome MS-LAMP)";}

if ($counterentirelipidome eq 1)
{
	print OUT "\n\n<<<< M. tb Lipidome MS-LAMP >>>>\n\n";
	&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]))
		{&textoutmain;}
}
}
}

if (($fa>0)&& (($counterfasearch eq 1)|($counterentirelipidome eq 1)))
{	print OUT "\n\n<<<< FATTY ACYLS >>>>\n\n";
	&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( $data{$_} =~ /MMFA/))
		{&textoutmain;}
	}
}
}
if (($gl>0)&& (($counterglsearch eq 1)|($counterentirelipidome eq 1)))
{	print OUT "\n\n<<<< GLYCEROLIPIDS >>>>\n\n";
	&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( $data{$_} =~ /MMGL/))
	{&textoutmain;}
	}
}};

if (($gp>0)&& (($countergpsearch eq 1)|($counterentirelipidome eq 1)))
{print OUT "\n\n<<<< GLYCEROPHOSPHOLIPIDS >>>>\n\n";
	&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( $data{$_} =~ /MMGP/))
	{&textoutmain;}
	}
}
}

if (($pk>0)&& (($counterpksearch eq 1)|($counterentirelipidome eq 1)))
{print OUT "\n\n<<<< POLYKETIDES  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( $data{$_} =~ /MMPK/))
	{&textoutmain;}
	}
}
}
if (($pr>0)&& (($counterprsearch eq 1)|($counterentirelipidome eq 1)))
{print OUT "\n\n<<<< PRENOL LIPIDS  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{

	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( $data{$_} =~ /MMPR/))
	{&textoutmain;}
	}
}
}
if (($sl>0)&& (($counterslsearch eq 1)|($counterentirelipidome eq 1)))
{print OUT "\n\n<<<< SACCHAROLIPIDS  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( $data{$_} =~ /MMSL/))
	{&textoutmain;}
	}
}
}
if (($sp>0)&& (($counterspsearch eq 1)|($counterentirelipidome eq 1)))
{print OUT "\n\n<<<<SPHINGOLIPIDS >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( $data{$_} =~ /MMSP/))
	{&textoutmain;}
	}
}
}

if (($st>0)&& (($counterstsearch eq 1)|($counterentirelipidome eq 1)))
{print OUT "\n\n<<<< STEROL LIPIDS  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( $data{$_} =~ /MMST/))
{&textoutmain;		}
	}
}
}

if (($countercustomcheck eq 1)&&($cq>0))
{print OUT "\n\n<<<< Custom Search >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( $m2sc{$_} =~ /$customquery/))
{&textoutmain;}}
}
}

if (($countersulfo eq 1)&&($sfl>0))
{print OUT "\n\n<<<< SULFOLIPIDS  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( $m2f{$_} =~ /S/))
{&textoutmain;}}}
}

$allhalo=($flor+$clor+$brom+$iod);
if (($countermainhalo eq 1) && ($allhalo>1))
{print OUT "\n\n<<<< ALL HALOGENATED LIPIDS  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ( ($m2f{$_} =~ /F/) |($m2f{$_} =~ /Cl/) |($m2f{$_} =~ /Br/) | ($m2f{$_} =~ /I/) ))
{&textoutmain;}}}}

if (($countermainhalo eq 1)  && ($flor >0))
{print OUT "\n\n<<<< Flourine Containing lipids  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2f{$_} =~ /F/))
{&textoutmain;}}}}


if (($countermainhalo eq 1)  && ($clor >0))
{print OUT "\n\n<<<< Chlorine containing lipids  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2f{$_} =~ /Cl/))
{&textoutmain;}}}}


if (($countermainhalo eq 1)  && ($brom >0))
{print OUT "\n\n<<<< Bromine containing lipids  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2f{$_} =~ /Br/))
{&textoutmain;}}}}


if (($countermainhalo eq 1)  && ($iod >0))
{print OUT "\n\n<<<< Iodine containing lipids  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2f{$_} =~ /I/))
{&textoutmain;}}}}

$glyc=($mono+$di+$triac);
if (($countermainglycero eq 1) && ($glyc >0))
{print OUT "\n\n<<<< Glycero Lipids  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2mc{$_} =~ /GL/))
{&textoutmain;}}}}


if ((($countermainglycero eq 1) | ($countermonoglycero eq 1)) && ($mono >0))
{print OUT "\n\n<<<< Monoglycerides >>>>\n \n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2mc{$_} =~ /GL01/))
{&textoutmain;}}}}


if ((($countermainglycero eq 1) | ($countermonoglycero eq 1)) && ($mac >0))
{print OUT "\n\n<<<<  Monoacyl glycerols  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2sc{$_} =~ /GL0101/))
{&textoutmain;}}}}


if ((($countermainglycero eq 1) | ($countermonoglycero eq 1)) && ($mak >0))
{print OUT "\n\n<<<< Monoalkyl glycerols  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2sc{$_} =~ /GL0102/))
{&textoutmain;}}}}


if ((($countermainglycero eq 1) | ($counterdiglycero eq 1)) && ($di >0))
{print OUT "\n\n<<<< Diglycerides  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2sc{$_} =~ /GL02/))
{&textoutmain;}}}}


if ((($countermainglycero eq 1) | ($counterdiglycero eq 1)) && ($diak >0))
{print OUT "\n\n<<<< Dialkyl glycerols  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2sc{$_} =~ /GL0203/))
{&textoutmain;}}}}


if ((($countermainglycero eq 1) | ($counterdiglycero eq 1)) && ($diac >0))
{print OUT "\n\n<<<< Diacyl glycerols  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2sc{$_} =~ /GL0201/))
{&textoutmain;}}}}


if ((($countermainglycero eq 1) | ($counterdiglycero eq 1)) && ($diacak >0))
{print OUT "\n\n<<<< 1-acyl,2-alkyl glycerols  >>>>\n\n ";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2sc{$_} =~ /GL0207/))
{&textoutmain;}}}}



if ((($countermainglycero eq 1) | ($counterdiglycero eq 1)) && ($diakac >0))
{print OUT "\n\n<<<< 1-alkyl,2-acyl glycerols  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2sc{$_} =~ /GL0202/))
{&textoutmain;}}}}


if ((($countermainglycero eq 1) | ($countertriglycero eq 1)) && ($triac >0))
{print OUT "\n\n<<<<  TRIGLYCERIDES  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2mc{$_} =~ /GL03/))
{&textoutmain;}}}}

if ((($countermainglycero eq 1) | ($counterotherglycero eq 1)) && ($ogll >0))
{print OUT "\n\n<<<<  OTHERGLYCEROLS  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && (($m2mc{$_} =~ /GL00/)|($m2mc{$_} =~ /GL04/)|($m2mc{$_} =~ /GL05/)))
{&textoutmain;}}}}

$apl=($gp+$spl+$opl);
if (($countermainphospho eq 1) && ($apl >0))
{print OUT "\n\n<<<< All phospholipids  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && ($m2f{$_} =~ /P/))
{&textoutmain;}}}}


if ((($countermainphospho eq 1) | ($countergpsearch eq 1)) && ($gp >0))
{print OUT "\n\n<<<< Glycerophospholipids  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && (($m2f{$_} =~ /P/) && ($data{$_} =~ /MMGP/)) )
{&textoutmain;}}}}


if ((($countermainphospho eq 1) | ($countersphingophospho eq 1)) && ($spl >0))
{print OUT "\n\n<<<<  Sphingophospholipids  >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && (($m2f{$_} =~ /P/) && ($data{$_} =~ /MMSP/)) )
{&textoutmain;}}}}


if ((($countermainphospho eq 1) | ($counterotherphospho eq 1)) && ($opl >0))
{print OUT "\n\n<<<<  Other phospholipids >>>>\n\n";
&textouthead;
for ($count=0;$count < $lenmz;$count++)	
	{
	for(sort keys %data)
	{
	$massoforsort=substr($_,0,-3);

if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]) && (($m2f{$_} =~ /P/ ) && (( $data{$_} =~ /MMFA/) | ( $data{$_} =~ /MMGL/) | ( $data{$_} =~ /MMSL/) | ( $data{$_} =~ /MMST/) | ( $data{$_} =~ /MMPR/) | ( $data{$_} =~ /MMPK/))) )
{&textoutmain;}}}}



sub textouthead{if ($countermmass eq 1){print OUT "\n QUERIED Molecular Mass";}		
	if ($countermhpos eq 1){print OUT "\n QUERIED [M+H]+\t\t[M+H]+ (db)*";}		
	if($countermampos eq 1){print OUT "\n QUERIED [M+NH4]+\t\t[M+NH4]+ (db)*";}		
	if($counternapos eq 1){print OUT "\n QUERIED [M+Na]+\t\t[M+Na]+ (db)*";}
	if($counternahpos eq 1){print OUT "\n QUERIED [M+2Na-H]+\t\t[M+2Na-H]+ (db)*";}
	if($countermhneg eq 1){print OUT "\n QUERIED [M-H]-\t\t[M-H]- (db)*";}
	if($counterachneg eq 1){print OUT "\n QUERIED [M+HOAc-H]-\t\t[M+HOAc-H]- (db)*";}
	if($counternahneg eq 1){print OUT "\n QUERIED [M+Na-2H]-\t\t[M+Na-2H]- (db)*";}
	if($counterclneg eq 1){print OUT "\n QUERIED [M+Cl]-\t\t[M+Cl]- (db)*";}
	if($counterlipos eq 1){print OUT "\n QUERIED [M+Li]+\t\t[M+Li]+ (db)*";}
	if($counter2lihpos eq 1){print OUT "\n QUERIED [M+2Li-H]+\t\t[M+2Li-H]+ (db)*";}
	if($counterli2hneg eq 1){print OUT "\n QUERIED [M+Li-2H]-\t\t[M+Li-2H]- (db)*";}
	if($counterkpos eq 1){print OUT "\n QUERIED [M+K]+\t\t[M+K]+ (db)*";}
	if($counter2khpos eq 1){print OUT "\n QUERIED [M+2K-H]+\t\t[M+2K-H]+ (db)*";}
	if($counterk2hneg eq 1){print OUT "\n QUERIED [M+K-2H]-\t\t[M+K-2H]- (db)*";}
	print OUT "\t\t$masschoiceforprinttxt (db)*\tDelta\t\t\tMolecular Formulae\t\t\tSubclass\t\t\t\t\tScientific Name\n\n";};
		


sub textoutmain{$code = substr($_,0,-2);
if ($masschoice eq 0){$ionmhposvalchange=1.007825;
$ionmamposvalchange=18.034374;
$ionnaposvalchange=22.989769;
$ionnahnegvalchange=20.974119;
$ionmhnegvalchange=-1.007825;
$ionachnegvalchange=59.013305;
$ion2nahposvalchange=44.971713;
$ionclnegvalchange=34.968852;
$ionliposvalchange=7.016004;
$ion2lihposvalchange=13.024183;
$ionlihnegvalchange=5.000354;
$ionkposvalchange=38.963707;
$ion2khposvalchange=76.919589;
$ionk2hnegvalchange=36.948057;}
if ($masschoice eq 1){$ionmhposvalchange=1.00794;
$ionmamposvalchange=18.03848;
$ionnaposvalchange=22.98977;
$ionnahnegvalchange=20.97389;
$ionmhnegvalchange=-1.00794;
$ionachnegvalchange=59.04424;
$ion2nahposvalchange=44.97160;
$ionclnegvalchange=35.45320;
$ionliposvalchange=6.94120;
$ion2lihposvalchange=12.87446;
$ionlihnegvalchange=4.92532;
$ionkposvalchange=39.09831;
$ion2khposvalchange=77.18868;
$ionk2hnegvalchange=37.08243;
}


if ($countermmass eq 1){print OUT "$mzval[$count]\t\t$code";$delta=($code-($mzval[$count]));}		
if ($countermhpos eq 1){$ionmhpos=$code+$ionmhposvalchange;print OUT "$mzval[$count]\t\t$ionmhpos\t\t\t$code";$delta=($ionmhpos-($mzval[$count]));}		
if($countermampos eq 1){$ionmampos=$code+$ionmamposvalchange;print OUT "$mzval[$count]\t\t$ionmampos\t\t\t$code";$delta=($ionmampos-($mzval[$count]));}		
if($counternapos eq 1){$ionnapos=$code+$ionnaposvalchange;print OUT "$mzval[$count]\t\t$ionnapos\t\t\t$code";$delta=($ionnapos-($mzval[$count]));}		
if($counternahpos eq 1){$ionnahneg=$code+$ion2nahposvalchange;print OUT "$mzval[$count]\t\t$ionnahneg\t\t\t$code";$delta=($ionnahneg-($mzval[$count]));}		
if($countermhneg eq 1){$ionmhneg=$code+$ionmhnegvalchange;print OUT "$mzval[$count]\t\t$ionmhneg\t\t\t$code";$delta=($ionmhneg-($mzval[$count]));}		
if($counterachneg eq 1){$ionachneg=$code+$ionachnegvalchange;print OUT "$mzval[$count]\t\t$ionachneg\t\t\t$code";$delta=($ionachneg-($mzval[$count]));}		
if($counternahneg eq 1){$ionnahneg=$code+$ionnahnegvalchange;print OUT "$mzval[$count]\t\t$ionnahneg\t\t\t$code";$delta=($ionnahneg-($mzval[$count]));}		
if($counterclneg eq 1){$ionclneg=$code+$ionclnegvalchange;print OUT "$mzval[$count]\t\t$ionclneg\t\t\t$code";$delta=($ionclneg-($mzval[$count]));}		
if($counterlipos eq 1){$ionlipos=$code+$ionliposvalchange;print OUT "$mzval[$count]\t\t$ionlipos\t\t\t$code";$delta=($ionlipos-($mzval[$count]));}		
if($counter2lihpos eq 1){$ion2lihpos=$code+$ion2lihposvalchange;print OUT "$mzval[$count]\t\t$ion2lihpos\t\t\t$code";$delta=($ion2lihpos-($mzval[$count]));}		
if($counterli2hneg eq 1){$ionli2hpos=$code+$ionlihnegvalchange;print OUT "$mzval[$count]\t\t$ionli2hpos\t\t\t$code";$delta=($ionli2hpos-($mzval[$count]));}		
if($counterkpos eq 1){$ionkpos=$code+$ionkposvalchange;print OUT "$mzval[$count]\t\t$ionkpos\t\t\t$code";$delta=($ionkpos-($mzval[$count]));}		
if($counter2khpos eq 1){$ion2khpos=$code+$ion2khposvalchange;print OUT "$mzval[$count]\t\t$ion2khpos\t\t\t$code";$delta=($ion2khpos-($mzval[$count]));}		
if($counterk2hneg eq 1){$ionk2hpos=$code+$ionk2hnegvalchange;print OUT "$mzval[$count]\t\t$ionk2hpos\t\t\t$code";$delta=($ionk2hpos-($mzval[$count]));}		

		$delt=substr($delta,0,6);
		$mass = substr($_,0,-2);
		$datatxt=substr($data{$_},1,-2);
		$m2ctxt=substr($m2c{$_},1,-2);
		$m2cntxt=substr($m2cn{$_},1,-2);
		$m2ftxt=substr($m2f{$_},1,-4);
		$m2mctxt=substr($m2mc{$_},1,-2);
		$m2sctxt=substr($m2sc{$_},1,-2);
		$m2sntxt=substr($m2sn{$_},1,-2);
	
		print OUT "\t$delt\t\t$m2ftxt\t\t$m2sctxt\t\t\t$m2sntxt\n";
		};
	
	
print OUT "\n*Please Note : (db) refers to the values present in the databases of MS-LAMP. \n All the molecular masses and m/z values of all type of ions in the databases of MS-LAMP, are calculated using\n the monoisotopic mass values of elements as given by IUPAC and \n the molecular formulae taken from the databases of LIPID MAPS & Mycobacterium tuberculosis.\n";

close OUT;
};

#*****************************sub for xls output********************************************************
sub xlsoutput
{ 
# Create a new Excel workbook

$filetypes =[['Excel Files', '.xls'],
              ['All Files',   '*'],];
sub save_file {
$save = $m->getSaveFile(-filetypes => $filetypes, 
                             -initialfile => 'MS-LAMP',
                             -defaultextension => '.xls');}

&save_file;
 $workbook = Spreadsheet::WriteExcel->new("$save");

if ($masschoice eq 0){$masschoiceforprintxls ="M-Monoisotopic";$mcfp="$qurdion (Monoisotopic)";}
if ($masschoice eq 1){$masschoiceforprintxls ="M-Average";$mcfp="$qurdion (Average)";}


	$format = $workbook->add_format();
	$formatname = $workbook->add_format();  
	$formatnme = $workbook->add_format();  
	$formatnumber=$workbook->add_format(); 
	$formatheading=$workbook->add_format(); 
	$formatnum = $workbook->add_format(valign  => 'vcenter',align   => 'center',color=>'black',font=>'arial 14 bold',); 
	# Add a format
	$format->set_bold();
	$format->set_color('red');
	$format->set_align('center');
	$formatname->set_bold();
	$formatname->set_color('blue');
	$formatname->set_align('center');
	$formatnme->set_bold();
	$formatnme->set_color('green');
	$formatnme->set_align('center');
	$formatnumber->set_align('left');
	$formatheading->set_bold();
	$formatheading->set_color('blue');
	$formatheading->set_align('center');
	$formatheading->set_font('tahoma');
		$formatheading->set_size('20');
	if ($countermhpos eq 1){$qurdion='[M+H]+'}		
	if($countermampos eq 1){$qurdion='[M+NH4]+'}		
	if($counternapos eq 1){$qurdion='[M+Na]+'}
	if($counternahpos eq 1){$qurdion='[M+2Na-H]+'}
	if($countermhneg eq 1){$qurdion='[M-H]-'}
	if($counterachneg eq 1){$qurdion='[M+HOAc-H]-'}
	if($counternahneg eq 1){$qurdion='[M+Na-2H]-'}
	if($counterclneg eq 1){$qurdion='[M+Cl]-'}
	if($counterlipos eq 1){$qurdion='[M+Li]+'}
	if($counter2lihpos eq 1){$qurdion='[M+2Li-H]+'}
	if($counterli2hneg eq 1){$qurdion='[M+Li-2H]-'}
	if($counterkpos eq 1){$qurdion='[M+K]+'}
	if($counter2khpos eq 1){$qurdion='[M+2K-H]+'}
	if($counterk2hneg eq 1){$qurdion='[M+K-2H]-'}
	if($countermmass eq 1){$qurdion='Molecular Mass'}

	# Add a worksheet
	$rowsummary=0;$columnsummary=0;
	$summary=$workbook->add_worksheet('Summary');
	$summary->merge_range('A1:H1','M. tb Lipidome MS-LAMP',$formatheading);
	$summary->merge_range('A2:H2','This workbook gives the result of the query as detailed below',$formatnum);$rowsummary++;$rowsummary++;$columnsummary++;
if (($activeoptiontwo eq 1)&&($activeoptionone eq 0))
	{$summary->write($rowsummary,$columnsummary,'Relative Intensity threshold',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$relativeintensityvalue,$format);$columnsummary++;}
	$summary->write($rowsummary,$columnsummary,'Queried Ion',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$mcfp,$format);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,'Window range',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$range,$format);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,'Uploaded File',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$open,$format);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,'Number of m/z values queried',$formatname);$columnsummary++;	
	$summary->write($rowsummary,$columnsummary,$lenmz,$format);$columnsummary++;
	$summary->merge_range('A5:K5','*Please Note : (db) refers to the values present in the databases of MS-LAMP. All the molecular masses and m/z values',$formatnum);
	$summary->merge_range('A6:K6','of all type of ions in the databases of MS-LAMP, are calculated using the monoisotopic mass values of elements as ',$formatnum);
	$summary->merge_range('A7:K7','given by IUPAC and the molecular formulae taken from the databases of LIPID MAPS & Mycobacterium tuberculosis',$formatnum);$columnsummary++;
	$rowsummary=$rowsummary+8;

	$columnsummary=3;
	if (($counterentirelipidome eq 1) | (($counterfasearch eq 1 ) && ($fa>0)))
	{
	$summary->write($rowsummary,$columnsummary,'Fatty Acyls',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$fa,$formatnumber);$rowsummary++;$columnsummary--;}
	if (($counterentirelipidome eq 1) | (($counterglsearch eq 1 ) && ($gl >0)))
	{$summary->write($rowsummary,$columnsummary,'Glycerolipids',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$gl,$formatnumber);$rowsummary++;$columnsummary--;}
	if (($counterentirelipidome eq 1) | (($countergpsearch eq 1 ) && ($gp >0)))
	{$summary->write($rowsummary,$columnsummary,'Glycerophospholipids',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$gp,$formatnumber);$rowsummary++;$columnsummary--;}
	if (($counterentirelipidome eq 1) | (($counterpksearch eq 1 ) && ($pk >0)))
	{$summary->write($rowsummary,$columnsummary,'Polyketides',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$pk,$formatnumber);$rowsummary++;$columnsummary--;}
	if (($counterentirelipidome eq 1) | (($counterprsearch eq 1 ) && ($pr >0)))
	{$summary->write($rowsummary,$columnsummary,'Prenol Lipids',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$pr,$formatnumber);$rowsummary++;$columnsummary--;}
	if (($counterentirelipidome eq 1) | (($counterslsearch eq 1 ) && ($sl >0)))
	{$summary->write($rowsummary,$columnsummary,'Saccharolipids',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$sl,$formatnumber);$rowsummary++;$columnsummary--;}
	if (($counterentirelipidome eq 1) | (($counterspsearch eq 1 ) && ($sp >0)))
	{$summary->write($rowsummary,$columnsummary,'Sphingolipids',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$sp,$formatnumber);$rowsummary++;$columnsummary--;}
	if (($counterentirelipidome eq 1) | (($counterstsearch eq 1 ) && ($st >0)))
	{$summary->write($rowsummary,$columnsummary,'Sterol Lipids',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$st,$formatnumber);$rowsummary++;$columnsummary--;}
	if ($countercustomcheck eq 1)
	{$summary->write($rowsummary,$columnsummary,$customquery,$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$cq,$formatnumber);$rowsummary++;$columnsummary--;
	}
	if ($countersulfo eq 1)
	{$summary->write($rowsummary,$columnsummary,'Sulfolipids',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$sfl,$formatnumber);$rowsummary++;$columnsummary--;
	}
	if ($countermainhalo eq 1)
	{$allhalo=($flor+$clor+$brom+$iod);
	$formatnum = $workbook->add_format(valign  => 'vcenter',align   => 'left',);
	$summary->merge_range('A9:L9','Please Note : There are no Halogenated lipids belonging to GL, GP and SL categories in the current database (i.e. M. tb Lipidome MS-LAMP)',$formatnum);
	$summary->write($rowsummary,$columnsummary,'All Halogented Lipids',$formatnme);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$allhalo,$formatnumber);$rowsummary++;$columnsummary--;
	$summary->write($rowsummary,$columnsummary,'Flourine Containing Lipids',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$flor,$formatnumber);$rowsummary++;$columnsummary--;
	$summary->write($rowsummary,$columnsummary,'Chlorine Containing Lipids',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$clor,$formatnumber);$rowsummary++;$columnsummary--;
	$summary->write($rowsummary,$columnsummary,'Bromine Containing Lipids',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$brom,$formatnumber);$rowsummary++;$columnsummary--;
	$summary->write($rowsummary,$columnsummary,'Iodine Containing Lipids',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$iod,$formatnumber);$rowsummary++;$columnsummary--;
	

	}
	if ($countermainglycero eq 1)
	{$glycero=($mac+$mak+$diak+$diac+$diacak+$diakac+$triac+$ogll);
	$summary->write($rowsummary,$columnsummary,'Glycero Lipids',$formatnme);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$glycero,$formatnumber);$rowsummary++;$columnsummary--;
	}
	if (($countermainglycero eq 1) | ($countermonoglycero eq 1))
	{$summary->write($rowsummary,$columnsummary,'Monoglycerides',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$mono,$formatnumber);$rowsummary++;$columnsummary--;
	}
	if (($countermainglycero eq 1) | ($counterdiglycero eq 1))
	{$summary->write($rowsummary,$columnsummary,'Diglycerides',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$di,$formatnumber);$rowsummary++;$columnsummary--;
	}
	if (($countermainglycero eq 1) | ($countertriglycero eq 1))
	{$summary->write($rowsummary,$columnsummary,'Triglycerides',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$triac,$formatnumber);$rowsummary++;$columnsummary--;
	}
	if (($countermainglycero eq 1) | ($counterotherglycero eq 1))
	{$summary->write($rowsummary,$columnsummary,'Other glycerolipids',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$ogll,$formatnumber);$rowsummary++;$columnsummary--;
	}

	if ($countermainphospho eq 1)
	{$apl=($gp+$spl+$opl);
	$summary->write($rowsummary,$columnsummary,'All phospholipids',$formatnme);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$apl,$formatnumber);$rowsummary++;$columnsummary--;
	}
	if (($countermainphospho eq 1) | ($countergpsearch eq 1))
	{$summary->write($rowsummary,$columnsummary,'Glycerophospholipids',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$gp,$formatnumber);$rowsummary++;$columnsummary--;
	}
	if (($countermainphospho eq 1) | ($countersphingophospho eq 1))
	{$summary->write($rowsummary,$columnsummary,'Sphingophospholipids',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$spl,$formatnumber);$rowsummary++;$columnsummary--;
	}
	if (($countermainphospho eq 1) | ($counterotherphospho eq 1))
	{$summary->write($rowsummary,$columnsummary,'Other phospholipids',$formatname);$columnsummary++;
	$summary->write($rowsummary,$columnsummary,$opl,$formatnumber);$rowsummary++;$columnsummary--;
	}	


&chart;
sub chart {

if ($rowsummary>11)

{
$summarychart = $workbook->add_worksheet('GRAPH');
my $bold      = $workbook->add_format( bold => 1 );

$rowsummary=$columnsummary=0;
	$summarychart->write($rowsummary,$columnsummary,'Categories',$format);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,Occurance,$format);$rowsummary++;$columnsummary--;

	if (($counterentirelipidome eq 1) | (($counterfasearch eq 1 ) && ($fa>0)))
	{
	$summarychart->write($rowsummary,$columnsummary,'Fatty Acyls',$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$fa,$formatnumber);$rowsummary++;$columnsummary--;}
	if (($counterentirelipidome eq 1) | (($counterglsearch eq 1 ) && ($gl >0)))
	{$summarychart->write($rowsummary,$columnsummary,'Glycerolipids',$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$gl,$formatnumber);$rowsummary++;$columnsummary--;}
	if (($counterentirelipidome eq 1) | (($countergpsearch eq 1 ) && ($gp >0)))
	{$summarychart->write($rowsummary,$columnsummary,'Glycerophospholipids',$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$gp,$formatnumber);$rowsummary++;$columnsummary--;}
	if (($counterentirelipidome eq 1) | (($counterpksearch eq 1 ) && ($pk >0)))
	{$summarychart->write($rowsummary,$columnsummary,'Polyketides',$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$pk,$formatnumber);$rowsummary++;$columnsummary--;}
	if (($counterentirelipidome eq 1) | (($counterprsearch eq 1 ) && ($pr >0)))
	{$summarychart->write($rowsummary,$columnsummary,'Prenol Lipids',$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$pr,$formatnumber);$rowsummary++;$columnsummary--;}
	if (($counterentirelipidome eq 1) | (($counterslsearch eq 1 ) && ($sl >0)))
	{$summarychart->write($rowsummary,$columnsummary,'Saccharolipids',$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$sl,$formatnumber);$rowsummary++;$columnsummary--;}
	if (($counterentirelipidome eq 1) | (($counterspsearch eq 1 ) && ($sp >0)))
	{$summarychart->write($rowsummary,$columnsummary,'Sphingolipids',$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$sp,$formatnumber);$rowsummary++;$columnsummary--;}
	if (($counterentirelipidome eq 1) | (($counterstsearch eq 1 ) && ($st >0)))
	{$summarychart->write($rowsummary,$columnsummary,'Sterol Lipids',$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$st,$formatnumber);$rowsummary++;$columnsummary--;}
	if ($countercustomcheck eq 1)
	{$summarychart->write($rowsummary,$columnsummary,$customquery,$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$cq,$formatnumber);$rowsummary++;$columnsummary--;
	}
	if ($countersulfo eq 1)
	{$summarychart->write($rowsummary,$columnsummary,'Sulfolipids',$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$sfl,$formatnumber);$rowsummary++;$columnsummary--;
	}
	if ($countermainhalo eq 1)
	{$allhalo=($flor+$clor+$brom+$iod);
	$summarychart->write($rowsummary,$columnsummary,'All Halogented Lipids',$formatnme);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$allhalo,$formatnumber);$rowsummary++;$columnsummary--;
	$summarychart->write($rowsummary,$columnsummary,'Flourine Containing Lipids',$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$flor,$formatnumber);$rowsummary++;$columnsummary--;
	$summarychart->write($rowsummary,$columnsummary,'Chlorine Containing Lipids',$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$clor,$formatnumber);$rowsummary++;$columnsummary--;
	$summarychart->write($rowsummary,$columnsummary,'Bromine Containing Lipids',$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$brom,$formatnumber);$rowsummary++;$columnsummary--;
	$summarychart->write($rowsummary,$columnsummary,'Iodine Containing Lipids',$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$iod,$formatnumber);$rowsummary++;$columnsummary--;
	

	}
	if ($countermainglycero eq 1)
	{$glycero=($mac+$mak+$diak+$diac+$diacak+$diakac+$triac);
	$summarychart->write($rowsummary,$columnsummary,'Glycero Lipids',$formatnme);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$glycero,$formatnumber);$rowsummary++;$columnsummary--;
	}
	if (($countermainglycero eq 1) | ($countermonoglycero eq 1))
	{$summarychart->write($rowsummary,$columnsummary,'Monoglycerides',$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$mono,$formatnumber);$rowsummary++;$columnsummary--;
	}
	if (($countermainglycero eq 1) | ($counterdiglycero eq 1))
	{$summarychart->write($rowsummary,$columnsummary,'Diglycerides',$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$di,$formatnumber);$rowsummary++;$columnsummary--;
	}
	if (($countermainglycero eq 1) | ($countertriglycero eq 1))
	{$summarychart->write($rowsummary,$columnsummary,'Triglycerides',$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$triac,$formatnumber);$rowsummary++;$columnsummary--;
	}
if (($countermainglycero eq 1) | ($counterotherglycero eq 1))
	{$summarychart->write($rowsummary,$columnsummary,'Otherglycerolipids',$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$ogll,$formatnumber);$rowsummary++;$columnsummary--;
	}

	if ($countermainphospho eq 1)
	{$apl=($gp+$spl+$opl);
	$summarychart->write($rowsummary,$columnsummary,'All phospholipids',$formatnme);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$apl,$formatnumber);$rowsummary++;$columnsummary--;
	}
	if (($countermainphospho eq 1) | ($countergpsearch eq 1))
	{$summarychart->write($rowsummary,$columnsummary,'Glycerophospholipids',$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$gp,$formatnumber);$rowsummary++;$columnsummary--;
	}
	if (($countermainphospho eq 1) | ($countersphingophospho eq 1))
	{$summarychart->write($rowsummary,$columnsummary,'Sphingophospholipids',$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$spl,$formatnumber);$rowsummary++;$columnsummary--;
	}
	if (($countermainphospho eq 1) | ($counterotherphospho eq 1))
	{$summarychart->write($rowsummary,$columnsummary,'Other phospholipids',$formatname);$columnsummary++;
	$summarychart->write($rowsummary,$columnsummary,$opl,$formatnumber);$rowsummary++;
	}	

my $chart1 = $workbook->add_chart( type => 'column', embedded => 1 );

$summarypie = $workbook->add_worksheet('PIE CHART');

my $chart2 = $workbook->add_chart( type => 'pie', embedded => 1 );


if ($rowsummary eq 3)
{# Configure the series.
$chart1->add_series(
    categories => '=GRAPH!$A$2:$A$3',
    values     => '=GRAPH!$B$2:$B$3',
);
$chart2->add_series(
    categories => '=GRAPH!$A$2:$A$3',
    values     => '=GRAPH!$B$2:$B$3',
);
}

if ($rowsummary eq 4)
{# Configure the series.
$chart1->add_series(
    categories => '=GRAPH!$A$2:$A$12',
    values     => '=GRAPH!$B$2:$B$12',
);
$chart2->add_series(
    categories => '=GRAPH!$A$2:$A$12',
    values     => '=GRAPH!$B$2:$B$12',
);
}

if ($rowsummary eq 5)
{# Configure the series.
$chart1->add_series(
    categories => '=GRAPH!$A$2:$A$5',
    values     => '=GRAPH!$B$2:$B$5',
);
$chart2->add_series(
    categories => '=GRAPH!$A$2:$A$5',
    values     => '=GRAPH!$B$2:$B$5',
);
}

if ($rowsummary eq 6)
{# Configure the series.
$chart1->add_series(
    categories => '=GRAPH!$A$2:$A$6',
    values     => '=GRAPH!$B$2:$B$6',
);
$chart2->add_series(
    categories => '=GRAPH!$A$2:$A$6',
    values     => '=GRAPH!$B$2:$B$6',
);
}
if ($rowsummary eq 7)
{# Configure the series.
$chart1->add_series(
    categories => '=GRAPH!$A$2:$A$7',
    values     => '=GRAPH!$B$2:$B$7',
);
$chart2->add_series(
    categories => '=GRAPH!$A$2:$A$7',
    values     => '=GRAPH!$B$2:$B$7',
);
}

if ($rowsummary eq 8)
{# Configure the series.
$chart1->add_series(
    categories => '=GRAPH!$A$2:$A$8',
    values     => '=GRAPH!$B$2:$B$8',
);
$chart2->add_series(
    categories => '=GRAPH!$A$2:$A$8',
    values     => '=GRAPH!$B$2:$B$8',
);
}
if ($rowsummary eq 9)
{# Configure the series.
$chart1->add_series(
    categories => '=GRAPH!$A$2:$A$9',
    values     => '=GRAPH!$B$2:$B$9',
);
$chart2->add_series(
    categories => '=GRAPH!$A$2:$A$9',
    values     => '=GRAPH!$B$2:$B$9',
);
}

if ($rowsummary eq 10)
{# Configure the series.
$chart1->add_series(
    categories => '=GRAPH!$A$2:$A$10',
    values     => '=GRAPH!$B$2:$B$10',
);
$chart2->add_series(
    categories => '=GRAPH!$A$2:$A$10',
    values     => '=GRAPH!$B$2:$B$10',
);
}
if ($rowsummary eq 11)
{# Configure the series.
$chart1->add_series(
    categories => '=GRAPH!$A$2:$A$11',
    values     => '=GRAPH!$B$2:$B$11',
);
$chart2->add_series(
    categories => '=GRAPH!$A$2:$A$11',
    values     => '=GRAPH!$B$2:$B$11',
);
}

if ($rowsummary eq 12)
{# Configure the series.
$chart1->add_series(
    categories => '=GRAPH!$A$2:$A$12',
    values     => '=GRAPH!$B$2:$B$12',
);
$chart2->add_series(
    categories => '=GRAPH!$A$2:$A$12',
    values     => '=GRAPH!$B$2:$B$12',
);
}
if ($rowsummary eq 13)
{# Configure the series.
$chart1->add_series(
    categories => '=GRAPH!$A$2:$A$13',
    values     => '=GRAPH!$B$2:$B$13',
);
$chart2->add_series(
    categories => '=GRAPH!$A$2:$A$13',
    values     => '=GRAPH!$B$2:$B$13',
);
}

if ($rowsummary eq 14)
{# Configure the series.
$chart1->add_series(
    categories => '=GRAPH!$A$2:$A$14',
    values     => '=GRAPH!$B$2:$B$14',
);
$chart2->add_series(
    categories => '=GRAPH!$A$2:$A$14',
    values     => '=GRAPH!$B$2:$B$14',
);
}
if ($rowsummary eq 15)
{# Configure the series.
$chart1->add_series(
    categories => '=GRAPH!$A$2:$A$15',
    values     => '=GRAPH!$B$2:$B$15',
);
$chart2->add_series(
    categories => '=GRAPH!$A$2:$A$15',
    values     => '=GRAPH!$B$2:$B$15',
);
}

if ($rowsummary eq 16)
{# Configure the series.
$chart1->add_series(
    categories => '=GRAPH!$A$2:$A$16',
    values     => '=GRAPH!$B$2:$B$16',
);
$chart2->add_series(
    categories => '=GRAPH!$A$2:$A$16',
    values     => '=GRAPH!$B$2:$B$16',
);
}

if ($rowsummary eq 17)
{# Configure the series.
$chart1->add_series(
    categories => '=GRAPH!$A$2:$A$17',
    values     => '=GRAPH!$B$2:$B$17',
);
$chart2->add_series(
    categories => '=GRAPH!$A$2:$A$17',
    values     => '=GRAPH!$B$2:$B$17',
);
}

if ($rowsummary eq 18)
{# Configure the series.
$chart1->add_series(
    categories => '=GRAPH!$A$2:$A$18',
    values     => '=GRAPH!$B$2:$B$18',
);
$chart2->add_series(
    categories => '=GRAPH!$A$2:$A$18',
    values     => '=GRAPH!$B$2:$B$18',
);
}
if ($rowsummary eq 19)
{# Configure the series.
$chart1->add_series(
    categories => '=GRAPH!$A$2:$A$19',
    values     => '=GRAPH!$B$2:$B$19',
);
$chart2->add_series(
    categories => '=GRAPH!$A$2:$A$19',
    values     => '=GRAPH!$B$2:$B$19',
);
}

if ($rowsummary eq 20)
{# Configure the series.
$chart1->add_series(
    categories => '=GRAPH!$A$2:$A$20',
    values     => '=GRAPH!$B$2:$B$20',
);
$chart2->add_series(
    categories => '=GRAPH!$A$2:$A$20',
    values     => '=GRAPH!$B$2:$B$20',
);
}

if ($rowsummary eq 21)
{# Configure the series.
$chart1->add_series(
    categories => '=GRAPH!$A$2:$A$21',
    values     => '=GRAPH!$B$2:$B$21',
);
$chart2->add_series(
    categories => '=GRAPH!$A$2:$A$21',
    values     => '=GRAPH!$B$2:$B$21',
);
}

if ($rowsummary eq 22)
{# Configure the series.
$chart1->add_series(
    categories => '=GRAPH!$A$2:$A$22',
    values     => '=GRAPH!$B$2:$B$22',
);
$chart2->add_series(
    categories => '=GRAPH!$A$2:$A$22',
    values     => '=GRAPH!$B$2:$B$22',
);
}



# Add some labels.
$chart1->set_title( name => 'Results of the query' );

# Insert the chart into the main worksheet.
$summarychart->insert_chart( 'A1', $chart1 );



# Add some labels.
$chart2->set_title( name => 'Results of the query' );

# Insert the chart into the main worksheet.
$summarypie->insert_chart( 'A1', $chart2 );

}
}

	
sub heading{
$col = $row = 0;
	if ($countermmass eq 1){$all->write($row,$col,'QUERIED Molecular Mass',$format);$col++;}		
	if ($countermhpos eq 1){$all->write($row,$col,'QUERIED [M+H]+',$format);$col++;$all->write($row, $col,'[M+H]+ (db)',$format);$col++;}		
	if($countermampos eq 1){$all->write($row,$col,'QUERIED [M+NH4]+',$format);$col++;$all->write($row, $col,'[M+NH4]+ (db)',$format);$col++;}		
	if($counternapos eq 1){$all->write($row,$col,'QUERIED [M+Na]+',$format);$col++;$all->write($row, $col,'[M+Na]+ (db)',$format);$col++;}		
	if($counternahpos eq 1){$all->write($row,$col,'QUERIED [M+2Na-H]+',$format);$col++;$all->write($row, $col,'[M+2Na-H]+ (db)',$format);$col++;}		
	if($countermhneg eq 1){$all->write($row,$col,'QUERIED [M-H]-',$format);$col++;$all->write($row, $col,'[M-H]- (db)',$format);$col++;}		
	if($counterachneg eq 1){$all->write($row,$col,'QUERIED [M+HOAc-H]-',$format);$col++;$all->write($row, $col,'[M+HOAc-H]- (db)',$format);$col++;}		
	if($counternahneg eq 1){$all->write($row,$col,'QUERIED [M+Na-2H]-',$format);$col++;$all->write($row, $col,'[M+Na-2H]- (db)',$format);$col++;}		
	if($counterclneg eq 1){$all->write($row,$col,'QUERIED [M+Cl]-',$format);$col++;$all->write($row, $col,'[M+Cl]- (db)',$format);$col++;}		
	if($counterlipos eq 1){$all->write($row,$col,'QUERIED [M+Li]+',$format);$col++;$all->write($row, $col,'[M+Li]+ (db)',$format);$col++;}
	if($counter2lihpos eq 1){$all->write($row,$col,'QUERIED [M+2Li-H]+',$format);$col++;$all->write($row, $col,'[M+2Li-H]+ (db)',$format);$col++;}
	if($counterli2hneg eq 1){$all->write($row,$col,'QUERIED [M+Li-2H]-',$format);$col++;$all->write($row, $col,'[M+Li-2H]- (db)',$format);$col++;}
	if($counterkpos eq 1){$all->write($row,$col,'QUERIED [M+K]+',$format);$col++;$all->write($row, $col,'[M+K]+ (db)',$format);$col++;}
	if($counter2khpos eq 1){$all->write($row,$col,'QUERIED [M+2K-H]+',$format);$col++;$all->write($row, $col,'[M+2K-H]+ (db)',$format);$col++;}
	if($counterk2hneg eq 1){$all->write($row,$col,'QUERIED [M+K-2H]-',$format);$col++;$all->write($row, $col,'[M+K-2H]- (db)',$format);$col++;}
if ($masschoice eq 0){$all->write($row, $col, 'M-Monoisotopic (db)*', $format);$col++;}
if ($masschoice eq 1){$all->write($row, $col, 'M-Average (db)*', $format);$col++;}	
	$all->write($row,$col,'Delta',$format);$col++;
	$all->write($row, $col, 'SCIENTIFIC NAME', $format);$col++;
	$all->write($row, $col, 'MOLECULAR FORMULAE', $format);$col++;
	$all->write($row, $col, 'CATEGORY', $format);$col++;
	$all->write($row, $col, 'MAIN CLASS', $format);$col++;
	$all->write($row, $col, 'SUB CLASS', $format);$col++;
	if($countermhneg eq 0){$all->write($row, $col,'[M-H]- (db)',$format);$col++;}		
	if($counterclneg eq 0){$all->write($row, $col,'[M+Cl]- (db)',$format);$col++;}
	if($counterachneg eq 0){$all->write($row, $col,'[M+HOAc-H]- (db)',$format);$col++;}		
	if($counterli2hneg eq 0){$all->write($row, $col,'[M+Li-2H]- (db)',$format);$col++;}
	if($counternahneg eq 0){$all->write($row, $col,'[M+Na-2H]- (db)',$format);$col++;}		
	if($counterk2hneg eq 0){$all->write($row, $col,'[M+K-2H]- (db)',$format);$col++;}	

	if ($countermhpos eq 0){$all->write($row, $col,'[M+H]+ (db)',$format);$col++;}		
	if($countermampos eq 0){$all->write($row, $col,'[M+NH4]+ (db)',$format);$col++;}		
	if($counterlipos eq 0){$all->write($row, $col,'[M+Li]+ (db)',$format);$col++;}
	if($counternapos eq 0){$all->write($row, $col,'[M+Na]+ (db)',$format);$col++;}		
	if($counterkpos eq 0){$all->write($row, $col,'[M+K]+ (db)',$format);$col++;}
	if($counter2lihpos eq 0){$all->write($row, $col,'[M+2Li-H]+ (db)',$format);$col++;}
	if($counternahpos eq 0){$all->write($row, $col,'[M+2Na-H]+ (db)',$format);$col++;}		
	if($counter2khpos eq 0){$all->write($row, $col,'[M+2K-H]+ (db)',$format);$col++;}

	$row=1;
}

if ($masschoice eq 0){$ionmhposvalchange=1.007825;
$ionmamposvalchange=18.034374;
$ionnaposvalchange=22.989769;
$ionnahnegvalchange=20.974119;
$ionmhnegvalchange=-1.007825;
$ionachnegvalchange=59.013305;
$ion2nahposvalchange=44.971713;
$ionclnegvalchange=34.968852;
$ionliposvalchange=7.016004;
$ion2lihposvalchange=13.024183;
$ionlihnegvalchange=5.000354;
$ionkposvalchange=38.963707;
$ion2khposvalchange=76.919589;
$ionk2hnegvalchange=36.948057;}
if ($masschoice eq 1){$ionmhposvalchange=1.00794;
$ionmamposvalchange=18.03848;
$ionnaposvalchange=22.98977;
$ionnahnegvalchange=20.97389;
$ionmhnegvalchange=-1.00794;
$ionachnegvalchange=59.04424;
$ion2nahposvalchange=44.97160;
$ionclnegvalchange=35.45320;
$ionliposvalchange=6.94120;
$ion2lihposvalchange=12.87446;
$ionlihnegvalchange=4.92532;
$ionkposvalchange=39.09831;
$ion2khposvalchange=77.18868;
$ionk2hnegvalchange=37.08243;
}

sub res
{$code = substr($_,0,-2);
if ($countermmass eq 1){$all->write($row,$column,$mzval[$count]);$column++;$all->write($row, $column,$code);$column++;$delta=($code-($mzval[$count]));}		
if ($countermhpos eq 1){$all->write($row,$column,$mzval[$count]);$column++;$ionmhpos=$code+$ionmhposvalchange;$all->write($row, $column, $ionmhpos);$column++;$all->write($row, $column,$code);$column++;$delta=($ionmhpos-($mzval[$count]));}		
if($countermampos eq 1){$all->write($row,$column,$mzval[$count]);$column++;$ionmampos=$code+$ionmamposvalchange;$all->write($row, $column, $ionmampos);$column++;$all->write($row, $column,$code);$column++;$delta=($ionmampos-($mzval[$count]));}		
if($counternapos eq 1){$all->write($row,$column,$mzval[$count]);$column++;$ionnapos=$code+$ionnaposvalchange;$all->write($row, $column, $ionnapos);	$column++;$all->write($row, $column,$code);$column++;$delta=($ionnapos-($mzval[$count]));}		
if($counternahpos eq 1){$all->write($row,$column,$mzval[$count]);$column++;$ionnahneg=$code+$ion2nahposvalchange;$all->write($row, $column, $ionnahneg);$column++;$all->write($row, $column,$code);$column++;$delta=($ionnahneg-($mzval[$count]));}		
if($countermhneg eq 1){$all->write($row,$column,$mzval[$count]);$column++;$ionmhneg=$code+$ionmhnegvalchange;$all->write($row, $column, $ionmhneg);$column++;$all->write($row, $column,$code);$column++;$delta=($ionmhneg-($mzval[$count]));}		
if($counterachneg eq 1){$all->write($row,$column,$mzval[$count]);$column++;$ionachneg=$code+$ionachnegvalchange;$all->write($row, $column, $ionachneg);$column++;$all->write($row, $column,$code);$column++;$delta=($ionachneg-($mzval[$count]));}		
if($counternahneg eq 1){$all->write($row,$column,$mzval[$count]);$column++;$ionnahneg=$code+$ionnahnegvalchange;$all->write($row, $column, $ionnahneg);$column++;$all->write($row, $column,$code);$column++;$delta=($ionnahneg-($mzval[$count]));}		
if($counterclneg eq 1){$all->write($row,$column,$mzval[$count]);$column++;$ionclneg=$code+$ionclnegvalchange;$all->write($row, $column, $ionclneg);$column++;$all->write($row, $column,$code);$column++;$delta=($ionclneg-($mzval[$count]));}		
if($counterlipos eq 1){$all->write($row,$column,$mzval[$count]);$column++;$ionlipos=$code+$ionliposvalchange;$all->write($row, $column, $ionlipos);$column++;$all->write($row, $column,$code);$column++;$delta=($ionlipos-($mzval[$count]));}		
if($counter2lihpos eq 1){$all->write($row,$column,$mzval[$count]);$column++;$ion2lihpos=$code+$ion2lihposvalchange;$all->write($row, $column, $ion2lihpos);$column++;$all->write($row, $column,$code);$column++;$delta=($ion2lihpos-($mzval[$count]));}		
if($counterli2hneg eq 1){$all->write($row,$column,$mzval[$count]);$column++;$ionli2hpos=$code+$ionlihnegvalchange;$all->write($row, $column, $ionli2hpos);$column++;$all->write($row, $column,$code);$column++;$delta=($ionli2hpos-($mzval[$count]));}		
if($counterkpos eq 1){$all->write($row,$column,$mzval[$count]);$column++;$ionkpos=$code+$ionkposvalchange;$all->write($row, $column, $ionkpos);$column++;$all->write($row, $column,$code);$column++;$delta=($ionkpos-($mzval[$count]));}		
if($counter2khpos eq 1){$all->write($row,$column,$mzval[$count]);$column++;$ion2khpos=$code+$ion2khposvalchange;$all->write($row, $column, $ion2khpos);$column++;$all->write($row, $column,$code);$column++;$delta=($ion2khpos-($mzval[$count]));}		
if($counterk2hneg eq 1){$all->write($row,$column,$mzval[$count]);$column++;$ionk2hpos=$code+$ionk2hnegvalchange;$all->write($row, $column, $ionk2hpos);$column++;$all->write($row, $column,$code);$column++;$delta=($ionk2hpos-($mzval[$count]));}		
		$all->write($row, $column,$delta);$column++;
		$m2snfp=substr($m2sn{$_},1,-2);
		$m2ffp=substr($m2f{$_},1,-4);
		$m2cfp=substr($m2c{$_},1,-2);
		$m2mcfp=substr($m2mc{$_},1,-2);
		$m2scfp=substr($m2sc{$_},1,-2);
		$all->write($row, $column, $m2snfp);$column++;
		$all->write($row, $column, $m2ffp);$column++;
		$all->write($row, $column, $m2cfp);$column++;
		$all->write($row, $column, $m2mcfp);$column++;
		$all->write($row, $column, $m2scfp);	$column++;
if($countermhneg eq 0){$ionmhneg=$code+$ionmhnegvalchange;$all->write($row, $column, $ionmhneg);$column++;}		
if($counterclneg eq 0){$ionclneg=$code+$ionclnegvalchange;$all->write($row, $column, $ionclneg);$column++;}	
if($counterachneg eq 0){$ionachneg=$code+$ionachnegvalchange;$all->write($row, $column, $ionachneg);$column++;}		
if($counterli2hneg eq 0){$ionli2hpos=$code+$ionlihnegvalchange;$all->write($row, $column, $ionli2hpos);$column++;}		
if($counternahneg eq 0){$ionnahneg=$code+$ionnahnegvalchange;$all->write($row, $column, $ionnahneg);$column++;}		
if($counterk2hneg eq 0){$ionk2hpos=$code+$ionk2hnegvalchange;$all->write($row, $column, $ionk2hpos);$column++;}			

if ($countermhpos eq 0){$ionmhpos=$code+$ionmhposvalchange;$all->write($row, $column, $ionmhpos);$column++;}		
if($countermampos eq 0){$ionmampos=$code+$ionmamposvalchange;$all->write($row, $column, $ionmampos);$column++;}		
if($counterlipos eq 0){$ionlipos=$code+$ionliposvalchange;$all->write($row, $column, $ionlipos);$column++;}		
if($counternapos eq 0){$ionnapos=$code+$ionnaposvalchange;$all->write($row, $column, $ionnapos);$column++;}		
if($counterkpos eq 0){$ionkpos=$code+$ionkposvalchange;$all->write($row, $column, $ionkpos);$column++;}		
if($counter2lihpos eq 0){$ion2lihpos=$code+$ion2lihposvalchange;$all->write($row, $column, $ion2lihpos);$column++;}		
if($counternahpos eq 0){$ionnahneg=$code+$ion2nahposvalchange;$all->write($row, $column, $ionnahneg);$column++;}		
if($counter2khpos eq 0){$ion2khpos=$code+$ion2khposvalchange;$all->write($row, $column, $ion2khpos);$column++;}		

		$row++;

}



	if ($counterentirelipidome eq 1)
	{
	$all = $workbook->add_worksheet('ALL');
	#  Add and define a format
	# Write a formatted and unformatted string, row and column notation.
	&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{
	$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]))
		{&res;}
}
}

if ($fa>0)
{	$all = $workbook->add_worksheet('FATTY ACYLS');
	&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ( $data{$_} =~ /MMFA/))
		{&res;}
	}
}
}
if ($gl>0)
{	$all = $workbook->add_worksheet('GLYCEROLIPIDS');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ( $data{$_} =~ /MMGL/))
{&res;
		};
	};
};
}
if ($gp>0)
{	$all=$workbook->add_worksheet('GLYCEROPHOSPHOLIPIDS ');
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ( $data{$_} =~ /MMGP/))
{&res;		};
	};
};
};

if ($pk>0)
{	$all = $workbook->add_worksheet('POLYKETIDES ');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ( $data{$_} =~ /MMPK/))
{&res;
		};
	};
};
}
if ($pr>0)
{	$all = $workbook->add_worksheet('PRENOL LIPIDS');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ( $data{$_} =~ /MMPR/))
{&res;		};
	};
};
}
if ($sl>0)
{	$all = $workbook->add_worksheet('SACCHAROLIPIDS');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ( $data{$_} =~ /MMSL/))
{&res;		};
	};
};
}
if ($sp>0)
{	$all = $workbook->add_worksheet('SPHINGOLIPIDS');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ( $data{$_} =~ /MMSP/))
{&res;		};
	};
};

}
if ($st>0)
{	$all = $workbook->add_worksheet('STEROL LIPIDS');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ( $data{$_} =~ /MMST/))
{&res;		};
	};
};
}


}

if ($countercustomcheck eq 1)
{$all = $workbook->add_worksheet('Custom Search');
#  Add and define a format
# Write a formatted and unformatted string, row and column notation.
$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{
	$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count]))
		{
		if ( $m2sc{$_} =~ /$customquery/)
		{
		&res;
		}
	}
	
	}
}
}


if (($fa>0)&& ($counterfasearch eq 1))
{
$all = $workbook->add_worksheet('FATTY ACYLS');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ( $data{$_} =~ /MMFA/))
		{
	&res;
		}
	}
}

}
if (($gl>0)&& ($counterglsearch eq 1))
{		$all = $workbook->add_worksheet('GLYCEROLIPIDS');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ( $data{$_} =~ /MMGL/))
{&res;
		};
	};
};
}
if (($gp>0)&& ($countergpsearch eq 1))
{	$all=$workbook->add_worksheet('GLYCEROPHOSPHOLIPIDS ');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ( $data{$_} =~ /MMGP/))
{&res;
		};
	};
};
};

if (($pk>0)&& ($counterpksearch eq 1))
{	$all = $workbook->add_worksheet('POLYKETIDES ');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ( $data{$_} =~ /MMPK/))
{&res;
		};
	};
};
}
if (($pr>0)&& ($counterprsearch eq 1))
{	$all = $workbook->add_worksheet('PRENOL LIPIDS');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ( $data{$_} =~ /MMPR/))
{&res;		};
	};
};
}
if (($sl>0)&& ($counterslsearch eq 1))
{		$all = $workbook->add_worksheet('SACCHAROLIPIDS');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ( $data{$_} =~ /MMSL/))
{&res;		};
	};
};
}
if (($sp>0) && ($counterspsearch eq 1))
{	$all = $workbook->add_worksheet('SPHINGOLIPIDS');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ( $data{$_} =~ /MMSP/))
{&res;		};
	};
};

}
if (($st>0)&& ($counterstsearch eq 1))
{	$all = $workbook->add_worksheet('STEROL LIPIDS');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ( $data{$_} =~ /MMST/))
{&res;		};
	};
};
}


if (($countersulfo eq 1)&&($sfl>0))
{	$all = $workbook->add_worksheet('SULFOLIPIDS');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ( $m2f{$_} =~ /S/))
{&res;		};
	};
};

}

$allhalo=($flor+$clor+$brom+$iod);
if (($countermainhalo eq 1)&&($allhalo>0))
{	$all = $workbook->add_worksheet('ALL HALOGENATED LIPIDS');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ( ($m2f{$_} =~ /F/) |($m2f{$_} =~ /Cl/) |($m2f{$_} =~ /Br/) | ($m2f{$_} =~ /I/) ))
{&res;		};
	};
};

}
if (($countermainhalo eq 1)  && ($flor >0))
{	$all = $workbook->add_worksheet('FLOURINE');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ($m2f{$_} =~ /F/))
{&res;
		};
	};
};

}
if (($countermainhalo eq 1)  && ($clor >0))
{	$all = $workbook->add_worksheet('CHLORINE');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ($m2f{$_} =~ /Cl/))
{&res;
		};
	};
};

}
if (($countermainhalo eq 1)  && ($brom >0))
{	$all = $workbook->add_worksheet('BROMINE');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ($m2f{$_} =~ /Br/))
{&res;
		};
	};
};

}
if (($countermainhalo eq 1)  && ($iod >0))
{	$all = $workbook->add_worksheet('IODINE');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ($m2f{$_} =~ /I/))
{&res;
		};
	};
};

}


$glyc=($mono+$di+$triac);
if (($countermainglycero eq 1) && ($glyc >0))
{	$all = $workbook->add_worksheet('Glycero Lipids');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	

	{
	for (sort keys %data)

	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ($m2mc{$_} =~ /GL/))
{&res;		};
	};
};

}


if ((($countermainglycero eq 1) | ($countermonoglycero eq 1)) && ($mono >0))
{	$all = $workbook->add_worksheet('Monoglycerols');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ($m2mc{$_} =~ /GL01/))
{&res;		};
	};
};

}

if ((($countermainglycero eq 1) | ($countermonoglycero eq 1)) && ($mac >0))
{	$all = $workbook->add_worksheet('Monoacyl glycerols');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ($m2sc{$_} =~ /GL0101/))
{&res;		};
	};
};

}
if ((($countermainglycero eq 1) | ($countermonoglycero eq 1)) && ($mak >0))
{	$all = $workbook->add_worksheet('Monoalkyl glycerols');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ($m2sc{$_} =~ /GL0102/))
{&res;		};
	};
};

}



if ((($countermainglycero eq 1) | ($counterdiglycero eq 1)) && ($di >0))
{	$all = $workbook->add_worksheet('Diglycerols');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ($m2sc{$_} =~ /GL02/))
{&res;
		};
	};
};

}

if ((($countermainglycero eq 1) | ($counterdiglycero eq 1)) && ($diak >0))
{	$all = $workbook->add_worksheet('Dialkyl glycerols');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ($m2sc{$_} =~ /GL0203/))
{&res;		};
	};
};

}
if ((($countermainglycero eq 1) | ($counterdiglycero eq 1)) && ($diac >0))
{	$all = $workbook->add_worksheet('Diacyl glycerols');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ($m2sc{$_} =~ /GL0201/))
{&res;
		};
	};
};

}

if ((($countermainglycero eq 1) | ($counterdiglycero eq 1)) && ($diacak >0))
{	$all = $workbook->add_worksheet('1-acyl,2-alkyl glycerols');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ($m2sc{$_} =~ /GL0207/))
{&res;
		};
	};
};

}

if ((($countermainglycero eq 1) | ($counterdiglycero eq 1)) && ($diakac >0))
{	$all = $workbook->add_worksheet('1-alkyl,2-acyl glycerols');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ($m2sc{$_} =~ /GL0202/))
{&res;
		};
	};
};

}

if ((($countermainglycero eq 1) | ($countertriglycero eq 1)) && ($triac >0))

{	$all = $workbook->add_worksheet('TRI GLYCEROLS');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ($m2mc{$_} =~ /GL03/))
{&res;
		};
	};
};

}


if ((($countermainglycero eq 1) | ($counterotherglycero eq 1)) && ($ogll >0))

{	$all = $workbook->add_worksheet('OTHER GLYCEROLS');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& (($m2mc{$_} =~ /GL00/)|($m2mc{$_} =~ /GL04/)|($m2mc{$_} =~ /GL05/)))
{&res;
		};
	};
};

}




$apl=($all+$spl+$opl);
if (($countermainphospho eq 1) && ($apl >0))
{	$all = $workbook->add_worksheet('All phospholipids');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& ($m2f{$_} =~ /P/))
{&res;		};
	};
};

}


if ((($countermainphospho eq 1) | ($counterglycerophospho eq 1)) && ($all >0))
{	$all = $workbook->add_worksheet('Glycerophospholipids');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& (($m2f{$_} =~ /P/) && ($data{$_} =~ /MMGP/)) )
{&res;
		};
	};
};

}

if ((($countermainphospho eq 1) | ($countersphingophospho eq 1)) && ($spl >0))
{	$all = $workbook->add_worksheet('Sphingophospholipids');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& (($m2f{$_} =~ /P/) && ($data{$_} =~ /MMSP/)) )
{&res;
		};
	};
};

}
if ((($countermainphospho eq 1) | ($counterotherphospho eq 1)) && ($opl >0))
{	$all = $workbook->add_worksheet('Other phospholipids');
	$col = $row = 0;
&heading;
for ($count=0;$count < $lenmz;$count++)	
	{
	for (sort keys %data)
	{$column=0;
	$massoforsort=substr($_,0,-3);
	if (($massoforsort>$lowermz[$count]) && ($massoforsort<$uppermz[$count])&& (($m2f{$_} =~ /P/ ) && (( $data{$_} =~ /MMFA/) | ( $data{$_} =~ /MMGL/) | ( $data{$_} =~ /MMSL/) | ( $data{$_} =~ /MMST/) | ( $data{$_} =~ /MMPR/) | ( $data{$_} =~ /MMPK/))) )
{&res;		};
	};
};

}


$workbook->close();
};

#**********************************************end of output printing subroutines*****************************************




#*****************************************subroutines for showing structures********************************************


#*****************************************subroutines for showing structures********************************************

#*****************************************subroutines for showing structures********************************************


sub strfal
{
$struc=$m->Toplevel();
$struc->title("Structure(s) corresponding to FATTY ACYLS");
$struc->configure(-background=>"white");
$name=$struc->Label(-text=>"Click on Molecular Formula button to view molecular structure saved as .jpeg file",-font=>"{times new roman} 12 bold",-background =>blue ,-foreground => white,-relief => raised)
		->grid(-row=>0,-column=>0,-columnspan=>40);
$rows=1;$columns=1;
for ($count=0;$count < $fa;$count++)
	{$name=substr($l2f{$lstrfa[$count]},1,-4);
	$lid= $lstrfa[$count];
	$lid=substr($lid,0,-1);
	$name=substr($name,0,-1);

	$name=$struc->Button(-text=>"$name",-font=>"{times new roman} 12 bold",-background =>black ,-foreground => white,-relief => raised,-command=>\&$lid)
		->grid(-row=>$rows,-column=>$columns);
	$columns++;
	if ($columns eq 9) {$columns=1;$rows++;};

	};
};

sub strgll
{
$struc=$m->Toplevel();
$struc->title("Structure(s) corresponding to GLYCEROLIPIDS");
$struc->configure(-background=>"white");
$name=$struc->Label(-text=>"Click on Molecular Formula button to view molecular structure saved as .jpeg file",-font=>"{times new roman} 12 bold",-background =>blue ,-foreground => white,-relief => raised)
		->grid(-row=>0,-column=>0,-columnspan=>40);
$rows=1;$columns=1;
for ($count=0;$count<$gl;$count++)
	{$name = substr($l2f{$lstrgl[$count]},1,-4);
	$lid = $lstrgl[$count];
	$lid=substr($lid,0,-1);
	$name=substr($name,0,-1);
	$name=$struc->Button(-text=>"$name",-font=>"{times new roman} 12 bold",-background =>black ,-foreground => white,-relief => raised,-command=>\&$lid)
		->grid(-row=>$rows,-column=>$columns);
	$columns++;
	if ($columns eq 9) {$columns=1;$rows++;};

	};
};



sub strgpl
{
$struc=$m->Toplevel();
$struc->title("Structure(s) corresponding to GLYCEROPHOSPHOLIPIDS");
$struc->configure(-background=>"white");
$name=$struc->Label(-text=>"Click on Molecular Formula button to view molecular structure saved as .jpeg file",-font=>"{times new roman} 12 bold",-background =>blue ,-foreground => white,-relief => raised)
		->grid(-row=>0,-column=>0,-columnspan=>40);
$rows=1;$columns=1;
for ($count=0;$count<$gp;$count++)
	{$name = substr($l2f{$lstrgp[$count]},1,-4);
	$lid = $lstrgp[$count];
	$lid=substr($lid,0,-1);
	$name=substr($name,0,-1);
	$name=$struc->Button(-text=>"$name",-font=>"{times new roman} 12 bold",-background =>black ,-foreground => white,-relief => raised,-command=>\&$lid)
		->grid(-row=>$rows,-column=>$columns);
	$columns++;
	if ($columns eq 9) {$columns=1;$rows++;};

	};
};

sub strpkl
{
$struc=$m->Toplevel();
$struc->title("Structure(s) corresponding to POLYKETIDES");
$struc->configure(-background=>"white");
$name=$struc->Label(-text=>"Click on Molecular Formula button to view molecular structure saved as .jpeg file",-font=>"{times new roman} 12 bold",-background =>blue ,-foreground => white,-relief => raised)
		->grid(-row=>0,-column=>0,-columnspan=>40);
$rows=1;$columns=1;
for ($count=0;$count<$pk;$count++)
	{$name = substr($l2f{$lstrpk[$count]},1,-4);
	$lid = $lstrpk[$count];
	$lid=substr($lid,0,-1);
	$name=substr($name,0,-1);
	$name=$struc->Button(-text=>"$name",-font=>"{times new roman} 12 bold",-background =>black ,-foreground => white,-relief => raised,-command=>\&$lid)
		->grid(-row=>$rows,-column=>$columns);
	$columns++;
	if ($columns eq 9) {$columns=1;$rows++;};

	};
};

sub strprl
{
$struc=$m->Toplevel();
$struc->title("Structure(s) corresponding to PRENOL LIPIDS");
$struc->configure(-background=>"white");
$name=$struc->Label(-text=>"Click on Molecular Formula button to view molecular structure saved as .jpeg file",-font=>"{times new roman} 12 bold",-background =>blue ,-foreground => white,-relief => raised)
		->grid(-row=>0,-column=>0,-columnspan=>40);
$rows=1;$columns=1;
for ($count=0;$count<$pr;$count++)
	{$name = substr($l2f{$lstrpr[$count]},1,-4);
	$lid = $lstrpr[$count];
	$lid=substr($lid,0,-1);
	$name=substr($name,0,-1);
	$name=$struc->Button(-text=>"$name",-font=>"{times new roman} 12 bold",-background =>black ,-foreground => white,-relief => raised,-command=>\&$lid)
		->grid(-row=>$rows,-column=>$columns);
	$columns++;
	if ($columns eq 9) {$columns=1;$rows++;};

	};
};

sub strstl
{
$struc=$m->Toplevel();
$struc->title("Structure(s) corresponding to STEROL LIPIDS");
$struc->configure(-background=>"white");
$name=$struc->Label(-text=>"Click on Molecular Formula button to view molecular structure saved as .jpeg file",-font=>"{times new roman} 12 bold",-background =>blue ,-foreground => white,-relief => raised)
		->grid(-row=>0,-column=>0,-columnspan=>40);
$rows=1;$columns=1;
for ($count=0;$count<$st;$count++)
	{$name = substr($l2f{$lstrst[$count]},1,-4);
	$lid = $lstrst[$count];
	$lid=substr($lid,0,-1);
	$name=substr($name,0,-1);
	$name=$struc->Button(-text=>"$name",-font=>"{times new roman} 12 bold",-background =>black ,-foreground => white,-relief => raised,-command=>\&$lid)
		->grid(-row=>$rows,-column=>$columns);
	$columns++;
	if ($columns eq 9) {$columns=1;$rows++;};

	};
};

sub strspl
{
$struc=$m->Toplevel();
$struc->title("Structure(s) corresponding to SPHINGOLIPIDS");
$struc->configure(-background=>"white");
$name=$struc->Label(-text=>"Click on Molecular Formula button to view molecular structure saved as .jpeg file",-font=>"{times new roman} 12 bold",-background =>blue ,-foreground => white,-relief => raised)
		->grid(-row=>0,-column=>0,-columnspan=>40);
$rows=1;$columns=1;
for ($count=0;$count<$sp;$count++)
	{$name = substr($l2f{$lstrsp[$count]},1,-4);
	$lid = $lstrsp[$count];
	$lid=substr($lid,0,-1);
	$name=substr($name,0,-1);
	$name=$struc->Button(-text=>"$name",-font=>"{times new roman} 12 bold",-background =>black ,-foreground => white,-relief => raised,-command=>\&$lid)
		->grid(-row=>$rows,-column=>$columns);
	$columns++;
	if ($columns eq 9) {$columns=1;$rows++;};

	};
};


sub strsll
{
$struc=$m->Toplevel();
$struc->title("Structure(s) corresponding to SACCAHROLIPIDS");
$struc->configure(-background=>"white");
$name=$struc->Label(-text=>"Click on Molecular Formula button to view molecular structure saved as .jpeg file",-font=>"{times new roman} 12 bold",-background =>blue ,-foreground => white,-relief => raised)
		->grid(-row=>0,-column=>0,-columnspan=>40);
$rows=1;$columns=1;
for ($count=0;$count<$sl;$count++)
	{$name = substr($l2f{$lstrsl[$count]},1,-4);
	$lid = $lstrsl[$count];
	$lid=substr($lid,0,-1);
	$name=substr($name,0,-1);
	$name=$struc->Button(-text=>"$name",-font=>"{times new roman} 12 bold",-background =>black ,-foreground => white,-relief => raised,-command=>\&$lid)
		->grid(-row=>$rows,-column=>$columns);
	$columns++;
	if ($columns eq 9) {$columns=1;$rows++;};

	};
};


sub strcql
{
$struc=$m->Toplevel();
$customquery=$customenter->get();
$struc->title("Structure(s) corresponding to CUSTOM QUERY : $customquery");
$struc->configure(-background=>"white");
$name=$struc->Label(-text=>"Click on Molecular Formula button to view molecular structure saved as .jpeg file",-font=>"{times new roman} 12 bold",-background =>blue ,-foreground => white,-relief => raised)
		->grid(-row=>0,-column=>0,-columnspan=>40);
$rows=1;$columns=1;
for ($count=0;$count<$cq;$count++)
	{$name = substr($l2f{$lstrcq[$count]},1,-4);
	$lid = $lstrcq[$count];
	$lid=substr($lid,0,-1);
	$name=substr($name,0,-1);
	$name=$struc->Button(-text=>"$name",-font=>"{times new roman} 12 bold",-background =>black ,-foreground => white,-relief => raised,-command=>\&$lid)
		->grid(-row=>$rows,-column=>$columns);
	$columns++;
	if ($columns eq 9) {$columns=1;$rows++;};

	};
};



sub strsfl
{
$struc=$m->Toplevel();
$customquery=$customenter->get();
$struc->title("Structure(s) corresponding to SULFUR CONTAINING LIPIDS");
$struc->configure(-background=>"white");
$name=$struc->Label(-text=>"Click on Molecular Formula button to view molecular structure saved as .jpeg file",-font=>"{times new roman} 12 bold",-background =>blue ,-foreground => white,-relief => raised)
		->grid(-row=>0,-column=>0,-columnspan=>40);
$rows=1;$columns=1;
for ($count=0;$count<$sfl;$count++)
	{$name = substr($l2f{$lstrsfl[$count]},1,-4);
	$lid = $lstrsfl[$count];
	$lid=substr($lid,0,-1);
	$name=substr($name,0,-1);
	$name=$struc->Button(-text=>"$name",-font=>"{times new roman} 12 bold",-background =>black ,-foreground => white,-relief => raised,-command=>\&$lid)
		->grid(-row=>$rows,-column=>$columns);
	$columns++;
	if ($columns eq 9) {$columns=1;$rows++;};

	};
};


sub strflor
{
$struc=$m->Toplevel();
$customquery=$customenter->get();
$struc->title("Structure(s) corresponding to FLOURINE CONTAINING LIPIDS");
$struc->configure(-background=>"white");
$name=$struc->Label(-text=>"Click on Molecular Formula button to view molecular structure saved as .jpeg file",-font=>"{times new roman} 12 bold",-background =>blue ,-foreground => white,-relief => raised)
		->grid(-row=>0,-column=>0,-columnspan=>40);
$rows=1;$columns=1;
for ($count=0;$count<$flor;$count++)
	{$name = substr($l2f{$lstrflor[$count]},1,-4);
	$lid = $lstrflor[$count];
	$lid=substr($lid,0,-1);
	$name=substr($name,0,-1);
	$name=$struc->Button(-text=>"$name",-font=>"{times new roman} 12 bold",-background =>black ,-foreground => white,-relief => raised,-command=>\&$lid)
		->grid(-row=>$rows,-column=>$columns);
	$columns++;
	if ($columns eq 9) {$columns=1;$rows++;};

	};
};

sub strclor
{
$struc=$m->Toplevel();
$customquery=$customenter->get();
$struc->title("Structure(s) corresponding to CHLORINE CONTAINING LIPIDS");
$struc->configure(-background=>"white");
$name=$struc->Label(-text=>"Click on Molecular Formula button to view molecular structure saved as .jpeg file",-font=>"{times new roman} 12 bold",-background =>blue ,-foreground => white,-relief => raised)
		->grid(-row=>0,-column=>0,-columnspan=>40);
$rows=1;$columns=1;
for ($count=0;$count<$clor;$count++)
	{$name = substr($l2f{$lstrclor[$count]},1,-4);
	$lid = $lstrclor[$count];
	$lid=substr($lid,0,-1);
	$name=substr($name,0,-1);
	$name=$struc->Button(-text=>"$name",-font=>"{times new roman} 12 bold",-background =>black ,-foreground => white,-relief => raised,-command=>\&$lid)
		->grid(-row=>$rows,-column=>$columns);
	$columns++;
	if ($columns eq 9) {$columns=1;$rows++;};

	};
};

sub strbrom
{
$struc=$m->Toplevel();
$customquery=$customenter->get();
$struc->title("Structure(s) corresponding to BROMINE CONTAINING LIPIDS");
$struc->configure(-background=>"white");
$name=$struc->Label(-text=>"Click on Molecular Formula button to view molecular structure saved as .jpeg file",-font=>"{times new roman} 12 bold",-background =>blue ,-foreground => white,-relief => raised)
		->grid(-row=>0,-column=>0,-columnspan=>40);
$rows=1;$columns=1;
for ($count=0;$count<$brom;$count++)
	{$name = substr($l2f{$lstrbrom[$count]},1,-4);
	$lid = $lstrbrom[$count];
	$lid=substr($lid,0,-1);
	$name=substr($name,0,-1);
	$name=$struc->Button(-text=>"$name",-font=>"{times new roman} 12 bold",-background =>black ,-foreground => white,-relief => raised,-command=>\&$lid)
		->grid(-row=>$rows,-column=>$columns);
	$columns++;
	if ($columns eq 9) {$columns=1;$rows++;};

	};
};

sub striod
{
$struc=$m->Toplevel();
$customquery=$customenter->get();
$struc->title("Structure(s) corresponding to IODINE CONTAINING LIPIDS");
$struc->configure(-background=>"white");
$name=$struc->Label(-text=>"Click on Molecular Formula button to view molecular structure saved as .jpeg file",-font=>"{times new roman} 12 bold",-background =>blue ,-foreground => white,-relief => raised)
		->grid(-row=>0,-column=>0,-columnspan=>40);
$rows=1;$columns=1;
for ($count=0;$count<$iod;$count++)
	{$name = substr($l2f{$lstriod[$count]},1,-4);
	$lid = $lstriod[$count];
	$lid=substr($lid,0,-1);
	$name=substr($name,0,-1);
	$name=$struc->Button(-text=>"$name",-font=>"{times new roman} 12 bold",-background =>black ,-foreground => white,-relief => raised,-command=>\&$lid)
		->grid(-row=>$rows,-column=>$columns);
	$columns++;
	if ($columns eq 9) {$columns=1;$rows++;};

	};
};

sub strmag
{
$struc=$m->Toplevel();
$customquery=$customenter->get();
$struc->title("Structure(s) corresponding to MONOGLYCERIDES");
$struc->configure(-background=>"white");
$name=$struc->Label(-text=>"Click on Molecular Formula button to view molecular structure saved as .jpeg file",-font=>"{times new roman} 12 bold",-background =>blue ,-foreground => white,-relief => raised)
		->grid(-row=>0,-column=>0,-columnspan=>40);
$rows=1;$columns=1;
for ($count=0;$count<$mag;$count++)
	{$name = substr($l2f{$lstrmag[$count]},1,-4);
	$lid = $lstrmag[$count];
	$lid=substr($lid,0,-1);
	$name=substr($name,0,-1);
	$name=$struc->Button(-text=>"$name",-font=>"{times new roman} 12 bold",-background =>black ,-foreground => white,-relief => raised,-command=>\&$lid)
		->grid(-row=>$rows,-column=>$columns);
	$columns++;
	if ($columns eq 9) {$columns=1;$rows++;};

	};
};

sub strdiag
{
$struc=$m->Toplevel();
$customquery=$customenter->get();
$struc->title("Structure(s) corresponding to DIGLYCERIDES");
$struc->configure(-background=>"white");
$name=$struc->Label(-text=>"Click on Molecular Formula button to view molecular structure saved as .jpeg file",-font=>"{times new roman} 12 bold",-background =>blue ,-foreground => white,-relief => raised)
		->grid(-row=>0,-column=>0,-columnspan=>40);
$rows=1;$columns=1;
for ($count=0;$count<$diag;$count++)
	{$name = substr($l2f{$lstrdiag[$count]},1,-4);
	$lid = $lstrdiag[$count];
	$lid=substr($lid,0,-1);
	$name=substr($name,0,-1);
	$name=$struc->Button(-text=>"$name",-font=>"{times new roman} 12 bold",-background =>black ,-foreground => white,-relief => raised,-command=>\&$lid)
		->grid(-row=>$rows,-column=>$columns);
	$columns++;
	if ($columns eq 9) {$columns=1;$rows++;};

	};
};

sub strtriac
{
$struc=$m->Toplevel();
$customquery=$customenter->get();
$struc->title("Structure(s) corresponding to TRIGLYCERIDES");
$struc->configure(-background=>"white");
$name=$struc->Label(-text=>"Click on Molecular Formula button to view molecular structure saved as .jpeg file",-font=>"{times new roman} 12 bold",-background =>blue ,-foreground => white,-relief => raised)
		->grid(-row=>0,-column=>0,-columnspan=>40);
$rows=1;$columns=1;
for ($count=0;$count<$triac;$count++)
	{$name = substr($l2f{$lstrtriac[$count]},1,-4);
	$lid = $lstrtriac[$count];
	$lid=substr($lid,0,-1);
	$name=substr($name,0,-1);
	$name=$struc->Button(-text=>"$name",-font=>"{times new roman} 12 bold",-background =>black ,-foreground => white,-relief => raised,-command=>\&$lid)
		->grid(-row=>$rows,-column=>$columns);
	$columns++;
	if ($columns eq 9) {$columns=1;$rows++;};

	};
};

sub strogll
{
$struc=$m->Toplevel();
$customquery=$customenter->get();
$struc->title("Structure(s) corresponding to OTHERGLYCEROLIPIDS");
$struc->configure(-background=>"white");
$name=$struc->Label(-text=>"Click on Molecular Formula button to view molecular structure saved as .jpeg file",-font=>"{times new roman} 12 bold",-background =>blue ,-foreground => white,-relief => raised)
		->grid(-row=>0,-column=>0,-columnspan=>40);
$rows=1;$columns=1;
for ($count=0;$count<$ogll;$count++)
	{$name = substr($l2f{$lstrogll[$count]},1,-4);
	$lid = $lstrogll[$count];
	$lid=substr($lid,0,-1);
	$name=substr($name,0,-1);
	$name=$struc->Button(-text=>"$name",-font=>"{times new roman} 12 bold",-background =>black ,-foreground => white,-relief => raised,-command=>\&$lid)
		->grid(-row=>$rows,-column=>$columns);
	$columns++;
	if ($columns eq 9) {$columns=1;$rows++;};

	};
};
sub strspll
{
$struc=$m->Toplevel();
$customquery=$customenter->get();
$struc->title("Structure(s) corresponding to Sphingophospholipids");
$struc->configure(-background=>"white");
$name=$struc->Label(-text=>"Click on Molecular Formula button to view molecular structure saved as .jpeg file",-font=>"{times new roman} 12 bold",-background =>blue ,-foreground => white,-relief => raised)
		->grid(-row=>0,-column=>0,-columnspan=>40);
$rows=1;$columns=1;
for ($count=0;$count<$spl;$count++)
	{$name = substr($l2f{$lstrspl[$count]},1,-4);
	$lid = $lstrspl[$count];
	$lid=substr($lid,0,-1);
	$name=substr($name,0,-1);
	$name=$struc->Button(-text=>"$name",-font=>"{times new roman} 12 bold",-background =>black ,-foreground => white,-relief => raised,-command=>\&$lid)
		->grid(-row=>$rows,-column=>$columns);
	$columns++;
	if ($columns eq 9) {$columns=1;$rows++;};

	};
};

sub stropl
{
$struc=$m->Toplevel();
$customquery=$customenter->get();
$struc->title("Structure(s) corresponding to OTHER PHOSPHOLIPIDS");
$struc->configure(-background=>"white");
$name=$struc->Label(-text=>"Click on Molecular Formula button to view molecular structure saved as .jpeg file",-font=>"{times new roman} 12 bold",-background =>blue ,-foreground => white,-relief => raised)
		->grid(-row=>0,-column=>0,-columnspan=>40);
$rows=1;$columns=1;
for ($count=0;$count<$opl;$count++)
	{$name = substr($l2f{$lstropl[$count]},1,-4);
	$lid = $lstropl[$count];
	$lid=substr($lid,0,-1);
	$name=substr($name,0,-1);
	$name=$struc->Button(-text=>"$name",-font=>"{times new roman} 12 bold",-background =>black ,-foreground => white,-relief => raised,-command=>\&$lid)
		->grid(-row=>$rows,-column=>$columns);
	$columns++;
	if ($columns eq 9) {$columns=1;$rows++;};

	};
};


##**************************END OF STRUCTURE SHOW *************************************************************
sub MMFA01020320{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020320.jpg")};
sub MMFA01020321{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020321.jpg")};
sub MMFA01020322{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020322.jpg")};
sub MMFA01020323{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020323.jpg")};
sub MMFA01020324{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020324.jpg")};
sub MMFA01020325{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020325.jpg")};
sub MMFA01020326{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020326.jpg")};
sub MMFA01020327{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020327.jpg")};
sub MMFA01020328{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020328.jpg")};
sub MMFA01020329{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020329.jpg")};
sub MMFA01020330{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020330.jpg")};
sub MMFA01020331{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020331.jpg")};
sub MMFA01020332{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020332.jpg")};
sub MMFA01020333{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020333.jpg")};
sub MMFA01020334{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020334.jpg")};
sub MMFA01020335{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020335.jpg")};
sub MMFA01020336{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020336.jpg")};
sub MMFA01020337{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020337.jpg")};
sub MMFA01020338{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020338.jpg")};
sub MMFA01020339{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020339.jpg")};
sub MMFA01020293{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020293.jpg")};
sub MMFA01020308{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020308.jpg")};
sub MMFA01020294{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020294.jpg")};
sub MMFA01020309{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020309.jpg")};
sub MMFA01020295{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020295.jpg")};
sub MMFA01020310{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020310.jpg")};
sub MMFA01020311{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020311.jpg")};
sub MMFA01020312{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020312.jpg")};
sub MMFA01020313{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020313.jpg")};
sub MMFA01020314{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020314.jpg")};
sub MMFA01020315{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020315.jpg")};
sub MMFA01020296{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020296.jpg")};
sub MMFA01020316{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020316.jpg")};
sub MMFA01020317{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020317.jpg")};
sub MMFA01020297{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020297.jpg")};
sub MMFA01020318{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020318.jpg")};
sub MMFA01020298{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020298.jpg")};
sub MMFA01020319{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020319.jpg")};
sub MMFA01020299{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020299.jpg")};
sub MMFA01020300{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020300.jpg")};
sub MMFA01020301{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020301.jpg")};
sub MMFA01020302{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020302.jpg")};
sub MMFA01020303{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020303.jpg")};
sub MMFA01020304{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020304.jpg")};
sub MMFA01020305{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020305.jpg")};
sub MMFA01020306{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020306.jpg")};
sub MMFA01020307{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMFA01020307.jpg")};
sub MMFAAMA001{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAAMA002{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAAMA003{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAAMA004{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAAMA005{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAAMA006{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAAMA007{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAAMA008{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAAMA009{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAAMA010{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAAMA011{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAAMA012{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAAMA013{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAAMA014{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAAMA015{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAAMA016{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAAMA017{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAAMA018{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAAMA019{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAAMA020{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAAMA021{system("$STRUCTURECOMMAND $HOME/structure/mtb/AMA.jpg")};
sub MMFAMMA001{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAMMA002{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAMMA003{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAMMA004{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAMMA005{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAMMA006{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAMMA007{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAMMA008{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAMMA009{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAMMA010{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAMMA011{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAMMA012{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAMMA013{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAMMA014{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAMMA015{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAMMA016{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAMMA017{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAMMA018{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAMMA019{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAMMA020{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAMMA021{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMA.jpg")};
sub MMFAKMA001{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAKMA002{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAKMA003{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAKMA004{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAKMA005{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAKMA006{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAKMA007{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAKMA008{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAKMA009{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAKMA010{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAKMA011{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAKMA012{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAKMA013{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAKMA014{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAKMA015{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAKMA016{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAKMA017{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAKMA018{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAKMA019{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAKMA020{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAKMA021{system("$STRUCTURECOMMAND $HOME/structure/mtb/KMA.jpg")};
sub MMFAGMM001{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM002{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM003{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM004{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM005{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM006{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM007{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM008{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM009{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM010{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM011{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM012{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM013{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM014{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM015{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM016{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM017{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM018{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM019{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM020{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM021{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM022{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM023{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM024{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM025{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM026{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM027{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM028{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM029{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM030{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM031{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM032{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM033{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM034{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM035{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM036{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM037{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM038{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM039{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM040{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM041{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM042{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM043{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM044{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM045{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM046{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM047{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM048{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM049{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM050{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM051{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM052{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM053{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM054{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM055{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM056{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM057{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM058{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM059{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM060{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM061{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM062{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM063{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM064{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM065{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM066{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM067{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM068{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM069{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM070{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM071{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM072{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM073{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM074{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM075{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM076{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM077{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM078{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM079{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM080{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM081{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM082{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM083{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFAGMM084{system("$STRUCTURECOMMAND $HOME/structure/mtb/GMM.jpg")};
sub MMFATMM001{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM002{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM003{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM004{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM005{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM006{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM007{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM008{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM009{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM010{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM011{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM012{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM013{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM014{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM015{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM016{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM017{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM018{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM019{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM020{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM021{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM022{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM023{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM024{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM025{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM026{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM027{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM028{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM029{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM030{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM031{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM032{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM033{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM034{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM035{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM036{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM037{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM038{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM039{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM040{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM041{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM042{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM043{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM044{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM045{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM046{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM047{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM048{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM049{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM050{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM051{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM052{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM053{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM054{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM055{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM056{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM057{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM058{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM059{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM060{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM061{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM062{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM063{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM064{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM065{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM066{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM067{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM068{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM069{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM070{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM071{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM072{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM073{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM074{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM075{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM076{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM077{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM078{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM079{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM080{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM081{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM082{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM083{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATMM084{system("$STRUCTURECOMMAND $HOME/structure/mtb/TMM.jpg")};
sub MMFATDM001{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM002{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM003{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM004{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM005{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM006{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM007{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM008{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM009{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM010{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM011{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM012{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM013{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM014{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM015{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM016{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM017{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM018{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM019{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM020{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM021{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM022{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM023{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM024{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM025{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM026{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM027{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM028{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM029{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM030{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM031{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM032{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM033{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM034{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM035{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM036{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM037{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM038{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM039{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM040{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM041{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM042{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM043{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM044{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM045{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM046{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM047{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM048{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM049{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM050{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM051{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM052{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM053{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM054{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM055{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM056{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM057{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM058{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM059{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM060{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM061{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM062{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM063{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM064{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM065{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM066{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM067{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM068{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM069{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM070{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM071{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM072{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM073{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM074{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM075{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM076{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM077{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM078{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM079{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM080{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM081{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM082{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM083{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM084{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM085{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM086{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM087{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM088{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM089{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM090{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM091{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM092{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM093{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM094{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM095{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM096{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM097{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM098{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM099{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM100{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM101{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM102{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM103{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM104{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM105{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM106{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM107{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM108{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM109{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM110{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM111{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM112{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM113{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM114{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM115{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM116{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM117{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM118{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM119{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM120{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM121{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM122{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM123{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM124{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM125{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM126{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM127{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM128{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM129{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM130{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM131{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM132{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM133{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM134{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM135{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM136{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM137{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM138{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM139{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM140{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM141{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM142{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM143{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM144{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM145{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM146{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM147{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM148{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM149{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM150{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM151{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM152{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM153{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM154{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM155{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM156{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM157{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM158{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM159{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM160{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM161{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM162{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM163{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM164{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM165{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM166{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM167{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM168{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM169{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM170{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM171{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM172{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM173{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM174{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM175{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM176{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM177{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM178{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM179{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM180{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM181{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM182{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM183{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM184{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM185{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM186{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM187{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM188{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM189{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM190{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM191{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM192{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM193{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM194{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM195{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM196{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM197{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM198{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM199{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM200{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM201{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM202{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM203{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM204{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM205{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM206{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM207{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM208{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM209{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM210{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM211{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM212{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM213{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM214{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM215{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM216{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM217{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM218{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM219{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM220{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM221{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM222{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM223{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM224{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM225{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM226{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM227{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM228{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM229{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM230{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM231{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM232{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM233{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM234{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM235{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM236{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM237{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM238{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM239{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM240{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM241{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM242{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM243{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM244{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM245{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM246{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM247{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM248{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM249{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM250{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM251{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM252{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM253{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM254{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM255{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM256{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM257{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM258{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM259{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM260{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM261{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM262{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM263{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM264{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM265{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM266{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM267{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM268{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM269{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM270{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM271{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM272{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM273{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM274{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM275{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM276{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM277{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM278{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM279{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM280{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM281{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM282{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM283{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM284{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM285{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM286{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM287{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM288{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM289{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM290{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM291{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM292{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM293{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM294{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM295{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM296{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM297{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM298{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM299{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM300{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM301{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM302{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM303{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM304{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM305{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM306{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM307{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM308{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM309{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM310{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM311{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM312{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM313{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM314{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM315{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM316{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM317{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM318{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM319{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM320{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM321{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM322{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM323{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM324{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM325{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM326{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM327{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM328{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM329{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM330{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM331{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM332{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM333{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM334{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM335{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM336{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM337{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM338{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM339{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM340{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM341{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM342{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM343{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM344{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM345{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM346{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM347{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM348{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM349{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM350{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM351{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM352{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM353{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM354{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM355{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM356{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM357{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM358{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM359{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM360{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM361{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM362{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM363{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM364{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM365{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM366{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM367{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM368{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFATDM369{system("$STRUCTURECOMMAND $HOME/structure/mtb/TDM.jpg")};
sub MMFADIMA01{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA02{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA03{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA04{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA05{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA06{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA07{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA08{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA09{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA10{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA11{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA12{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA13{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA14{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA15{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA16{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA17{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA18{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA19{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA20{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA21{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA22{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA23{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA24{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA25{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMA26{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMA.jpg")};
sub MMFADIMB01{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB02{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB03{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB04{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB05{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB06{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB07{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB08{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB09{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB10{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB11{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB12{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB13{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB14{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB15{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB16{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB17{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB18{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB19{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB20{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB21{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB22{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB23{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB24{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB25{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFADIMB26{system("$STRUCTURECOMMAND $HOME/structure/mtb/DIMB.jpg")};
sub MMFAPGLT01{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT02{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT03{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT04{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT05{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT06{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT07{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT08{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT09{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT10{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT11{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT12{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT13{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT14{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT15{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT16{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT17{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT18{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT19{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT20{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT21{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT22{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT23{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT24{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT25{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAPGLT26{system("$STRUCTURECOMMAND $HOME/structure/mtb/PGLTB.jpg")};
sub MMFAGPD001{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD002{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD003{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD004{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD005{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD006{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD007{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD008{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD009{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD010{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD011{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD012{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD013{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD014{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD015{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD016{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD017{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD018{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD019{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD020{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD021{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD022{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD023{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD024{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD025{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMFAGPD026{system("$STRUCTURECOMMAND $HOME/structure/mtb/GPD.jpg")};
sub MMGPPE0001{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0002{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0003{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0004{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0005{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0006{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0007{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0008{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0009{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0010{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0011{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0012{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0013{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0014{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0015{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0016{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0017{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0018{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0019{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0020{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0021{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0022{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0023{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0024{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0025{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0026{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPPE0027{system("$STRUCTURECOMMAND $HOME/structure/mtb/PE.jpg")};
sub MMGPLPE001{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPE.jpg")};
sub MMGPLPE002{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPE.jpg")};
sub MMGPLPE003{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPE.jpg")};
sub MMGPLPE004{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPE.jpg")};
sub MMGPLPE005{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPE.jpg")};
sub MMGPLPE006{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPE.jpg")};
sub MMGPLPE007{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPE.jpg")};
sub MMGPLPE008{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPE.jpg")};
sub MMGPLPE009{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPE.jpg")};
sub MMGPPG0001{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0002{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0003{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0004{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0005{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0006{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0007{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0008{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0009{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0010{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0011{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0012{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0013{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0014{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0015{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0016{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0017{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0018{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0019{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0020{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0021{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0022{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0023{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0024{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0025{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0026{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0027{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0028{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0029{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0030{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0031{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0032{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0033{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0034{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0035{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0036{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0037{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0038{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0039{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPPG0040{system("$STRUCTURECOMMAND $HOME/structure/mtb/PG.jpg")};
sub MMGPLPG001{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPG.jpg")};
sub MMGPLPG002{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPG.jpg")};
sub MMGPLPG003{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPG.jpg")};
sub MMGPLPG004{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPG.jpg")};
sub MMGPLPG005{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPG.jpg")};
sub MMGPLPG006{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPG.jpg")};
sub MMGPLPG007{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPG.jpg")};
sub MMGPLPG008{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPG.jpg")};
sub MMGPLPG009{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPG.jpg")};
sub MMGPLPG010{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPG.jpg")};
sub MMGPPI0001{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0002{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0003{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0004{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0005{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0006{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0007{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0008{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0009{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0010{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0011{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0012{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0013{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0014{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0015{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0016{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0017{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0018{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0019{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0020{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0021{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0022{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0023{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0024{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0025{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPPI0026{system("$STRUCTURECOMMAND $HOME/structure/mtb/PI.jpg")};
sub MMGPLPI001{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPI.jpg")};
sub MMGPLPI002{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPI.jpg")};
sub MMGPLPI003{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPI.jpg")};
sub MMGPLPI004{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPI.jpg")};
sub MMGPLPI005{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPI.jpg")};
sub MMGPLPI006{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPI.jpg")};
sub MMGPLPI007{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPI.jpg")};
sub MMGPLPI008{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPI.jpg")};
sub MMGPCL0001{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0002{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0003{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0004{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0005{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0006{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0007{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0008{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0009{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0010{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0011{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0012{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0013{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0014{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0015{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0016{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0017{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0018{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0019{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0020{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0021{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0022{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0023{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0024{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0025{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0026{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0027{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0028{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0029{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0030{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0031{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0032{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0033{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0034{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0035{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0036{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0037{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0038{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0039{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0040{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0041{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0042{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0043{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0044{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0045{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0046{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0047{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0048{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0049{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0050{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0051{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0052{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0053{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0054{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0055{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0056{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0057{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0058{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0059{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0060{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0061{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0062{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0063{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0064{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0065{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0066{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0067{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0068{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0069{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0070{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0071{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0072{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0073{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0074{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0075{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0076{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0077{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0078{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0079{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0080{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0081{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0082{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0083{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0084{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0085{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0086{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0087{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0088{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0089{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0090{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0091{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0092{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0093{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0094{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0095{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0096{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0097{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0098{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0099{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0100{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0101{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0102{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0103{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0104{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0105{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0106{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0107{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0108{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0109{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0110{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0111{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0112{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0113{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0114{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0115{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0116{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0117{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0118{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0119{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0120{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0121{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0122{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0123{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0124{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0125{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0126{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0127{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0128{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0129{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0130{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0131{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0132{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0133{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0134{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0135{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0136{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0137{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPCL0138{system("$STRUCTURECOMMAND $HOME/structure/mtb/CL.jpg")};
sub MMGPLPIM11{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM1.jpg")};
sub MMGPLPIM12{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM1.jpg")};
sub MMGPLPIM13{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM1.jpg")};
sub MMGPLPIM14{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM1.jpg")};
sub MMGPLPIM15{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM1.jpg")};
sub MMGPLPIM16{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM1.jpg")};
sub MMGPLPIM17{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM1.jpg")};
sub MMGPLPIM18{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM1.jpg")};
sub MMGPPIM101{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM102{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM103{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM104{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM105{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM106{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM107{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM108{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM109{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM110{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM111{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM112{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM113{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM114{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM115{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM116{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM117{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM118{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM119{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM120{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM121{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM122{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM123{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM124{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM125{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPPIM126{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM1.jpg")};
sub MMGPAC1PIM101{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM102{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM103{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM104{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM105{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM106{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM107{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM108{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM109{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM110{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM111{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM112{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM113{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM114{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM115{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM116{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM117{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM118{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM119{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM120{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM121{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM122{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM123{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM124{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM125{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM126{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM127{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM128{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM129{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM130{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM131{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM132{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM133{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM134{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM135{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM136{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM137{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM138{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM139{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM140{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM141{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM142{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM143{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM144{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM145{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM146{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM147{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM148{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM149{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM150{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM151{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM152{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM153{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM154{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM155{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM156{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM157{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM158{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM159{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM160{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM161{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM162{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPAC1PIM163{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM1.jpg")};
sub MMGPLPIM201{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM2.jpg")};
sub MMGPLPIM202{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM2.jpg")};
sub MMGPLPIM203{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM2.jpg")};
sub MMGPLPIM204{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM2.jpg")};
sub MMGPLPIM205{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM2.jpg")};
sub MMGPLPIM206{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM2.jpg")};
sub MMGPLPIM207{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM2.jpg")};
sub MMGPLPIM208{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM2.jpg")};
sub MMGPPIM201{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM202{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM203{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM204{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM205{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM206{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM207{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM208{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM209{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM210{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM211{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM212{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM213{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM214{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM215{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM216{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM217{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM218{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM219{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM220{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM221{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM222{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM223{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM224{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM225{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPPIM226{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM2.jpg")};
sub MMGPAC1PIM2001{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2002{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2003{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2004{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2005{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2006{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2007{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2008{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2009{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2010{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2011{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2012{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2013{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2014{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2015{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2016{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2017{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2018{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2019{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2020{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2021{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2022{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2023{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2024{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2025{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2026{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2027{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2028{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2029{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2030{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2031{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2032{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2033{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2034{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2035{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2036{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2037{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2038{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2039{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2040{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2041{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2042{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2043{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2044{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2045{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2046{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2047{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2048{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2049{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2050{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2051{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2052{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2053{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2054{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2055{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2056{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2057{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2058{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2059{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2060{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2061{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2062{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC1PIM2063{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM2.jpg")};
sub MMGPAC2PIM2001{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2002{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2003{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2004{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2005{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2006{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2007{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2008{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2009{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2010{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2011{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2012{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2013{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2014{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2015{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2016{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2017{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2018{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2019{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2020{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2021{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2022{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2023{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2024{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2025{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2026{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2027{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2028{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2029{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2030{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2031{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2032{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2033{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2034{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2035{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2036{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2037{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2038{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2039{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2040{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2041{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2042{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2043{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2044{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2045{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2046{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2047{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2048{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2049{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2050{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2051{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2052{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2053{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2054{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2055{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2056{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2057{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2058{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2059{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2060{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2061{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2062{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2063{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2064{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2065{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2066{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2067{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2068{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2069{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2070{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2071{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2072{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2073{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2074{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2075{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2076{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2077{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2078{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2079{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2080{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2081{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2082{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2083{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2084{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2085{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2086{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2087{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2088{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2089{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2090{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPAC2PIM2091{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM2.jpg")};
sub MMGPLPIM3001{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM3.jpg")};
sub MMGPLPIM3002{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM3.jpg")};
sub MMGPLPIM3003{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM3.jpg")};
sub MMGPLPIM3004{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM3.jpg")};
sub MMGPLPIM3005{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM3.jpg")};
sub MMGPLPIM3006{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM3.jpg")};
sub MMGPLPIM3007{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM3.jpg")};
sub MMGPLPIM3008{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM3.jpg")};
sub MMGPPIM3001{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3002{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3003{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3004{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3005{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3006{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3007{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3008{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3009{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3010{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3011{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3012{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3013{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3014{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3015{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3016{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3017{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3018{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3019{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3020{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3021{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3022{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3023{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3024{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3025{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPPIM3026{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM3.jpg")};
sub MMGPAC1PIM3001{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3002{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3003{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3004{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3005{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3006{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3007{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3008{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3009{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3010{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3011{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3012{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3013{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3014{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3015{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3016{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3017{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3018{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3019{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3020{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3021{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3022{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3023{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3024{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3025{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3026{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3027{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3028{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3029{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3030{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3031{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3032{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3033{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3034{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3035{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3036{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3037{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3038{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3039{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3040{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3041{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3042{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3043{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3044{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3045{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3046{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3047{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3048{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3049{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3050{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3051{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3052{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3053{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3054{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3055{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3056{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3057{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3058{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3059{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3060{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3061{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3062{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC1PIM3063{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM3.jpg")};
sub MMGPAC2PIM3001{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3002{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3003{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3004{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3005{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3006{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3007{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3008{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3009{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3010{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3011{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3012{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3013{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3014{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3015{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3016{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3017{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3018{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3019{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3020{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3021{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3022{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3023{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3024{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3025{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3026{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3027{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3028{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3029{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3030{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3031{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3032{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3033{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3034{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3035{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3036{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3037{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3038{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3039{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3040{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3041{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3042{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3043{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3044{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3045{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3046{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3047{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3048{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3049{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3050{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3051{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3052{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3053{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3054{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3055{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3056{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3057{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3058{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3059{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3060{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3061{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3062{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3063{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3064{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3065{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3066{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3067{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3068{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3069{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3070{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3071{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3072{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3073{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3074{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3075{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3076{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3077{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3078{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3079{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3080{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3081{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3082{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3083{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3084{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3085{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3086{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3087{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3088{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3089{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3090{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPAC2PIM3091{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM3.jpg")};
sub MMGPLPIM4001{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM4.jpg")};
sub MMGPLPIM4002{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM4.jpg")};
sub MMGPLPIM4003{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM4.jpg")};
sub MMGPLPIM4004{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM4.jpg")};
sub MMGPLPIM4005{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM4.jpg")};
sub MMGPLPIM4006{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM4.jpg")};
sub MMGPLPIM4007{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM4.jpg")};
sub MMGPLPIM4008{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM4.jpg")};
sub MMGPPIM4001{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4002{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4003{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4004{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4005{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4006{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4007{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4008{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4009{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4010{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4011{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4012{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4013{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4014{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4015{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4016{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4017{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4018{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4019{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4020{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4021{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4022{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4023{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4024{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4025{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPPIM4026{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM4.jpg")};
sub MMGPAC1PIM4001{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4002{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4003{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4004{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4005{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4006{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4007{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4008{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4009{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4010{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4011{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4012{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4013{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4014{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4015{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4016{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4017{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4018{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4019{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4020{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4021{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4022{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4023{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4024{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4025{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4026{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4027{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4028{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4029{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4030{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4031{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4032{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4033{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4034{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4035{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4036{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4037{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4038{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4039{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4040{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4041{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4042{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4043{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4044{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4045{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4046{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4047{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4048{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4049{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4050{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4051{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4052{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4053{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4054{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4055{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4056{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4057{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4058{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4059{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4060{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4061{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4062{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC1PIM4063{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM4.jpg")};
sub MMGPAC2PIM4001{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4002{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4003{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4004{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4005{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4006{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4007{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4008{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4009{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4010{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4011{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4012{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4013{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4014{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4015{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4016{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4017{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4018{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4019{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4020{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4021{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4022{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4023{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4024{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4025{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4026{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4027{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4028{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4029{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4030{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4031{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4032{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4033{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4034{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4035{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4036{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4037{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4038{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4039{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4040{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4041{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4042{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4043{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4044{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4045{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4046{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4047{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4048{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4049{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4050{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4051{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4052{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4053{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4054{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4055{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4056{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4057{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4058{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4059{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4060{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4061{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4062{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4063{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4064{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4065{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4066{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4067{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4068{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4069{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4070{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4071{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4072{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4073{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4074{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4075{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4076{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4077{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4078{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4079{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4080{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4081{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4082{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4083{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4084{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4085{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4086{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4087{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4088{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4089{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4090{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPAC2PIM4091{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM4.jpg")};
sub MMGPLPIM5001{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM5.jpg")};
sub MMGPLPIM5002{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM5.jpg")};
sub MMGPLPIM5003{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM5.jpg")};
sub MMGPLPIM5004{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM5.jpg")};
sub MMGPLPIM5005{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM5.jpg")};
sub MMGPLPIM5006{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM5.jpg")};
sub MMGPLPIM5007{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM5.jpg")};
sub MMGPLPIM5008{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM5.jpg")};
sub MMGPPIM5001{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5002{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5003{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5004{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5005{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5006{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5007{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5008{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5009{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5010{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5011{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5012{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5013{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5014{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5015{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5016{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5017{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5018{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5019{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5020{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5021{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5022{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5023{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5024{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5025{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPPIM5026{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM5.jpg")};
sub MMGPAC1PIM5001{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5002{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5003{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5004{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5005{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5006{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5007{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5008{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5009{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5010{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5011{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5012{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5013{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5014{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5015{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5016{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5017{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5018{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5019{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5020{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5021{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5022{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5023{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5024{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5025{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5026{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5027{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5028{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5029{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5030{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5031{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5032{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5033{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5034{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5035{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5036{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5037{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5038{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5039{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5040{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5041{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5042{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5043{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5044{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5045{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5046{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5047{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5048{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5049{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5050{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5051{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5052{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5053{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5054{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5055{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5056{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5057{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5058{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5059{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5060{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5061{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5062{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC1PIM5063{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM5.jpg")};
sub MMGPAC2PIM5001{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5002{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5003{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5004{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5005{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5006{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5007{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5008{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5009{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5010{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5011{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5012{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5013{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5014{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5015{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5016{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5017{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5018{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5019{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5020{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5021{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5022{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5023{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5024{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5025{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5026{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5027{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5028{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5029{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5030{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5031{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5032{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5033{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5034{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5035{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5036{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5037{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5038{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5039{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5040{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5041{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5042{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5043{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5044{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5045{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5046{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5047{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5048{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5049{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5050{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5051{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5052{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5053{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5054{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5055{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5056{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5057{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5058{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5059{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5060{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5061{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5062{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5063{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5064{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5065{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5066{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5067{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5068{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5069{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5070{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5071{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5072{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5073{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5074{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5075{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5076{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5077{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5078{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5079{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5080{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5081{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5082{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5083{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5084{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5085{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5086{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5087{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5088{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5089{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5090{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPAC2PIM5091{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM5.jpg")};
sub MMGPLPIM6001{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM6.jpg")};
sub MMGPLPIM6002{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM6.jpg")};
sub MMGPLPIM6003{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM6.jpg")};
sub MMGPLPIM6004{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM6.jpg")};
sub MMGPLPIM6005{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM6.jpg")};
sub MMGPLPIM6006{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM6.jpg")};
sub MMGPLPIM6007{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM6.jpg")};
sub MMGPLPIM6008{system("$STRUCTURECOMMAND $HOME/structure/mtb/LPIM6.jpg")};
sub MMGPPIM6001{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6002{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6003{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6004{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6005{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6006{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6007{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6008{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6009{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6010{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6011{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6012{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6013{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6014{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6015{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6016{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6017{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6018{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6019{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6020{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6021{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6022{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6023{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6024{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6025{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPPIM6026{system("$STRUCTURECOMMAND $HOME/structure/mtb/PIM6.jpg")};
sub MMGPAC1PIM6001{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6002{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6003{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6004{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6005{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6006{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6007{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6008{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6009{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6010{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6011{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6012{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6013{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6014{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6015{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6016{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6017{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6018{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6019{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6020{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6021{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6022{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6023{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6024{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6025{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6026{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6027{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6028{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6029{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6030{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6031{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6032{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6033{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6034{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6035{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6036{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6037{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6038{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6039{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6040{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6041{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6042{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6043{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6044{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6045{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6046{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6047{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6048{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6049{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6050{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6051{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6052{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6053{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6054{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6055{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6056{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6057{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6058{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6059{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6060{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6061{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6062{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC1PIM6063{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC1PIM6.jpg")};
sub MMGPAC2PIM6001{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6002{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6003{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6004{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6005{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6006{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6007{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6008{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6009{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6010{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6011{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6012{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6013{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6014{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6015{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6016{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6017{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6018{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6019{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6020{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6021{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6022{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6023{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6024{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6025{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6026{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6027{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6028{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6029{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6030{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6031{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6032{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6033{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6034{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6035{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6036{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6037{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6038{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6039{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6040{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6041{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6042{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6043{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6044{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6045{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6046{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6047{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6048{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6049{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6050{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6051{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6052{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6053{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6054{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6055{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6056{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6057{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6058{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6059{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6060{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6061{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6062{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6063{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6064{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6065{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6066{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6067{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6068{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6069{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6070{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6071{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6072{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6073{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6074{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6075{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6076{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6077{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6078{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6079{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6080{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6081{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6082{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6083{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6084{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6085{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6086{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6087{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6088{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6089{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6090{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGPAC2PIM6091{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2PIM6.jpg")};
sub MMGLMG001{system("$STRUCTURECOMMAND $HOME/structure/mtb/MG.jpg")};
sub MMGLMG002{system("$STRUCTURECOMMAND $HOME/structure/mtb/MG.jpg")};
sub MMGLMG003{system("$STRUCTURECOMMAND $HOME/structure/mtb/MG.jpg")};
sub MMGLMG004 {system("$STRUCTURECOMMAND $HOME/structure/mtb/MG.jpg")};
sub MMGLMG005{system("$STRUCTURECOMMAND $HOME/structure/mtb/MG.jpg")};
sub MMGLMG006{system("$STRUCTURECOMMAND $HOME/structure/mtb/MG.jpg")};
sub MMGLMG007{system("$STRUCTURECOMMAND $HOME/structure/mtb/MG.jpg")};
sub MMGLMG008{system("$STRUCTURECOMMAND $HOME/structure/mtb/MG.jpg")};
sub MMGLMG009{system("$STRUCTURECOMMAND $HOME/structure/mtb/MG.jpg")};
sub MMGLMG010{system("$STRUCTURECOMMAND $HOME/structure/mtb/MG.jpg")};
sub MMGLMG011{system("$STRUCTURECOMMAND $HOME/structure/mtb/MG.jpg")};
sub MMGLMG012{system("$STRUCTURECOMMAND $HOME/structure/mtb/MG.jpg")};
sub MMGLMG013{system("$STRUCTURECOMMAND $HOME/structure/mtb/MG.jpg")};
sub MMGLMG014{system("$STRUCTURECOMMAND $HOME/structure/mtb/MG.jpg")};
sub MMGLMG015{system("$STRUCTURECOMMAND $HOME/structure/mtb/MG.jpg")};
sub MMGLMG016{system("$STRUCTURECOMMAND $HOME/structure/mtb/MG.jpg")};
sub MMGLMG017{system("$STRUCTURECOMMAND $HOME/structure/mtb/MG.jpg")};
sub MMGLMG018{system("$STRUCTURECOMMAND $HOME/structure/mtb/MG.jpg")};
sub MMGLDG001{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG002{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG003{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG004{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG005{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG006{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG007{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG008{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG009{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG010{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG011{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG012{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG013{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG014{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG015{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG016{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG017{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG018{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG019{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG020{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG021{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG022{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG023{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG024{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG025{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG026{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG027{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG028{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG029{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG030{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG031{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG032{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG033{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG034{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG035{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG036{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG037{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG038{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG039{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG040{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG041{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG042{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG043{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG044{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG045{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG046{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG047{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG048{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG049{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG050{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG051{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG052{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG053{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG054{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG055{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG056{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG057{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG058{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG059{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG060{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLDG061{system("$STRUCTURECOMMAND $HOME/structure/mtb/DG.jpg")};
sub MMGLTG001{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG002{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG003{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG004{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG005{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG006{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG007{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG008{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG009{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG010{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG011{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG012{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG013{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG014{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG015{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG016{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG017{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG018{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG019{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG020{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG021{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG022{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG023{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG024{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG025{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG026{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG027{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG028{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG029{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG030{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG031{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG032{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG033{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG034{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG035{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG036{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG037{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG038{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG039{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG040{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG041{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG042{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG043{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG044{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG045{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG046{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG047{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG048{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG049{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG050{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG051{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG052{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG053{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG054{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG055{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG056{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG057{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG058{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG059{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG060{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG061{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG062{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG063{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG064{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG065{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG066{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG067{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG068{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG069{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG070{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG071{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG072{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG073{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG074{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG075{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG076{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG077{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG078{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG079{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG080{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG081{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG082{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG083{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG084{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG085{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG086{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG087{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG088{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG089{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG090{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG091{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG092{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG093{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG094{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG095{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG096{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG097{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG098{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG099{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG100{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG101{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG102{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG103{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG104{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG105{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG106{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG107{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG108{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG109{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG110{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG111{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG112{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG113{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG114{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG115{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG116{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG117{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG118{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG119{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG120{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG121{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG122{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG123{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG124{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG125{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG126{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG127{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG128{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG129{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG130{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG131{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG132{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG133{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG134{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG135{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG136{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG137{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG138{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMGLTG139{system("$STRUCTURECOMMAND $HOME/structure/mtb/TG.jpg")};
sub MMPR02010041{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMPR02010041.jpg")};
sub MMPR02010040{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMPR02010040.jpg")};
sub MMPR02010039{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMPR02010039.jpg")};
sub MMPR02010038{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMPR02010038.jpg")};
sub MMPRDP001{system("$STRUCTURECOMMAND $HOME/structure/mtb/DP.jpg")};
sub MMPR03020008{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMPR03020008.jpg")};
sub MMPRDP002{system("$STRUCTURECOMMAND $HOME/structure/mtb/DPPP.jpg")};
sub MMSLDAT1001{system("$STRUCTURECOMMAND $HOME/structure/mtb/DAT1.jpg")};
sub MMSLDAT1002{system("$STRUCTURECOMMAND $HOME/structure/mtb/DAT1.jpg")};
sub MMSLDAT1003{system("$STRUCTURECOMMAND $HOME/structure/mtb/DAT1.jpg")};
sub MMSLDAT1004{system("$STRUCTURECOMMAND $HOME/structure/mtb/DAT1.jpg")};
sub MMSLDAT1005{system("$STRUCTURECOMMAND $HOME/structure/mtb/DAT1.jpg")};
sub MMSLDAT1006{system("$STRUCTURECOMMAND $HOME/structure/mtb/DAT1.jpg")};
sub MMSLDAT2001{system("$STRUCTURECOMMAND $HOME/structure/mtb/DAT2.jpg")};
sub MMSLDAT2002{system("$STRUCTURECOMMAND $HOME/structure/mtb/DAT2.jpg")};
sub MMSLDAT2003{system("$STRUCTURECOMMAND $HOME/structure/mtb/DAT2.jpg")};
sub MMSLDAT2004{system("$STRUCTURECOMMAND $HOME/structure/mtb/DAT2.jpg")};
sub MMSLDAT2005{system("$STRUCTURECOMMAND $HOME/structure/mtb/DAT2.jpg")};
sub MMSLDAT2006{system("$STRUCTURECOMMAND $HOME/structure/mtb/DAT2.jpg")};
sub MMSLDAT2007{system("$STRUCTURECOMMAND $HOME/structure/mtb/DAT2.jpg")};
sub MMSLPAT001{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT002{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT003{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT004{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT005{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT006{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT007{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT008{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT009{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT010{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT011{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT012{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT013{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT014{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT015{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT016{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT017{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT018{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT019{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT020{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT021{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT022{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT023{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT024{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT025{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT026{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT027{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT028{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT029{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT030{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT031{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT032{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT033{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT034{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT035{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT036{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT037{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT038{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT039{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT040{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT041{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT042{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT043{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT044{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT045{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT046{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT047{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT048{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT049{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLPAT050{system("$STRUCTURECOMMAND $HOME/structure/mtb/PAT.jpg")};
sub MMSLSL1001{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1002{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1003{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1004{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1005{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1006{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1007{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1008{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1009{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1010{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1011{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1012{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1013{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1014{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1015{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1016{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1017{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1018{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1019{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1020{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1021{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1022{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1023{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1024{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1025{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1026{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1027{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1028{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1029{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1030{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1031{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1032{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1033{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1034{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1035{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1036{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1037{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1038{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1039{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1040{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1041{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1042{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1043{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1044{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1045{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1046{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1047{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1048{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1049{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1050{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1051{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL1052{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL1.jpg")};
sub MMSLSL2001{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2002{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2003{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2004{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2005{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2006{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2007{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2008{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2009{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2010{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2011{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2012{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2013{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2014{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2015{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2016{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2017{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2018{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2019{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2020{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2021{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2022{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2023{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2024{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2025{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2026{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2027{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2028{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2029{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2030{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2031{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2032{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2033{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2034{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2035{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2036{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2037{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2038{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2039{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2040{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2041{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2042{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2043{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2044{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2045{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2046{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2047{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2048{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2049{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2050{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2051{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL2052{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL2.jpg")};
sub MMSLSL3001{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3002{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3003{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3004{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3005{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3006{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3007{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3008{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3009{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3010{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3011{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3012{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3013{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3014{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3015{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3016{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3017{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3018{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3019{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3020{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3021{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3022{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3023{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3024{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3025{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3026{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3027{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3028{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3029{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3030{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3031{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3032{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3033{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3034{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLSL3035{system("$STRUCTURECOMMAND $HOME/structure/mtb/SL3.jpg")};
sub MMSLAC2SGL001{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL002{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL003{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL004{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL005{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL006{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL007{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL008{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL009{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL010{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL011{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL012{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL013{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL014{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL015{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL016{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL017{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL018{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL019{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL020{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL021{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL022{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL023{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMSLAC2SGL024{system("$STRUCTURECOMMAND $HOME/structure/mtb/AC2SGL.jpg")};
sub MMPK01000058{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMPK01000058.jpg")};
sub MMPK01000059{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMPK01000059.jpg")};
sub MMPK01000057{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMPK01000057.jpg")};
sub MMPK01000060{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMPK01000060.jpg")};
sub MMPK01000061{system("$STRUCTURECOMMAND $HOME/structure/mtb/MMPK01000061.jpg")};
sub MMPKMBTFE1001{system("$STRUCTURECOMMAND $HOME/structure/mtb/MBTFE1.jpg")};
sub MMPKMBTFE1002{system("$STRUCTURECOMMAND $HOME/structure/mtb/MBTFE1.jpg")};
sub MMPKMBTFE1003{system("$STRUCTURECOMMAND $HOME/structure/mtb/MBTFE1.jpg")};
sub MMPKMBTFE1004{system("$STRUCTURECOMMAND $HOME/structure/mtb/MBTFE1.jpg")};
sub MMPKMBTFE1005{system("$STRUCTURECOMMAND $HOME/structure/mtb/MBTFE1.jpg")};
sub MMPKMBTFE1006{system("$STRUCTURECOMMAND $HOME/structure/mtb/MBTFE1.jpg")};
sub MMPKMBTFE1007{system("$STRUCTURECOMMAND $HOME/structure/mtb/MBTFE1.jpg")};
sub MMPKMBTFE1008{system("$STRUCTURECOMMAND $HOME/structure/mtb/MBTFE1.jpg")};
sub MMPKMBTFE2001{system("$STRUCTURECOMMAND $HOME/structure/mtb/MBTFE2.jpg")};
sub MMPKMBTFE2002{system("$STRUCTURECOMMAND $HOME/structure/mtb/MBTFE2.jpg")};
sub MMPKMBTFE2003{system("$STRUCTURECOMMAND $HOME/structure/mtb/MBTFE2.jpg")};
sub MMPKMBTFE2004{system("$STRUCTURECOMMAND $HOME/structure/mtb/MBTFE2.jpg")};
sub MMPKMBTFE2005{system("$STRUCTURECOMMAND $HOME/structure/mtb/MBTFE2.jpg")};
sub MMPKMBTFE2006{system("$STRUCTURECOMMAND $HOME/structure/mtb/MBTFE2.jpg")};
sub MMPKMBTFE2007{system("$STRUCTURECOMMAND $HOME/structure/mtb/MBTFE2.jpg")};
sub MMPKMBTFE2008{system("$STRUCTURECOMMAND $HOME/structure/mtb/MBTFE2.jpg")};
