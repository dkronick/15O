

	******************************************************************
	**
	**
	**		NAME:		DOROTHY KRONICK
	**					and FRANCISCO RODRIGUEZ
	**		DATE: 		October 26, 2017
	**		PROJECT: 	15O
	**
	**		DETAILS: 	This file creates Figure 1 
	**					in the article, plotting 2017
	**					turnout against 2015 turnout,
	**					for relocated precincts separately.
	**
	**				
	**		Version: 	Stata MP 14
	**
	******************************************************************
	
	
	
	

		

			**	**	**	**	**	**	**	**	**	**	**	**	**
			**	**	**	**	**	**	**	**	**	**	**	**	**
			**	**	**	**	**	**	**	**	**	**	**	**	**
	


*-------------------------------------------------------------------------------
* preliminaries 
*-------------------------------------------------------------------------------



* clear
*------

clear



* directory
*----------

cd "/Users/djkronick/Dropbox/Venezuela/Quico/Regionales2017/Replication"

	
	
	

		

			**	**	**	**	**	**	**	**	**	**	**	**	**
			**	**	**	**	**	**	**	**	**	**	**	**	**
			**	**	**	**	**	**	**	**	**	**	**	**	**
	


*-------------------------------------------------------------------------------
* graph in article 
*-------------------------------------------------------------------------------



* load master data
*-----------------

use "15OMstr.dta", clear




* graph
*------

	/* Note: the "if turnout2015 ~= 0" 
	         exludes ONE precinct.
			 
			 */

#delimit;

twoway (scatter turnout2017 turnout2015 if turnout2015 ~= 0, 
        mcolor(gs12) msymbol(Oh) msize(vsmall)) 

	   (lfit turnout2017 turnout2015 if turnout2015 ~= 0,
        lcolor(gs5) lpattern(dash))		

       (scatter turnout2017 turnout2015 if reubicado_g == 1,
	    mcolor("222 45 38") msize(vsmall))

	   (lfit turnout2017 turnout2015 if reubicado_g == 1,
        lcolor("222 45 38") lpattern(dash) lwidth(medthick)),

graphregion(fcolor(white) lcolor(white) margin(zero))

plotregion(fcolor(white) lstyle(none) lcolor(white) ilstyle(none))

xsize(11.25) ysize(8)

title("Fig. 1: Turnout in relocated centers, compared to others", 
	  color(black) placement(west) justification(left) size(medlarge)) 

ytitle("Turnout 2017", size(med))

yscale(lcolor(none))

ylabel(, labsize(med) glcolor(white) angle(horizontal)) 

xtitle("Turnout 2015") 

xscale(lcolor(none))

xlabel(, labsize(med) noticks) 

legend(off);
	
graph export "Turnout_Reubicacion.png", replace;	
	 
		 





	



			**	**	**	**	**	**	**	**	**	**	**	**	**
			**	**	**	**	**	**	**	**	**	**	**	**	**
			**	**	**	**	**	**	**	**	**	**	**	**	**
	
						** end of do file **		

