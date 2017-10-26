

	******************************************************************
	**
	**
	**		NAME:		DOROTHY KRONICK
	**					and FRANCISCO RODRIGUEZ
	**		DATE: 		October 26, 2017
	**		PROJECT: 	15O
	**
	**		DETAILS: 	This file creates Figure 12
	**					in the article, plotting change in
	**					absention against 2013 MUD vote share.
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



* set more off
*-------------

set more off



* directory
*----------

cd "/Users/djkronick/Dropbox/Venezuela/Quico/Regionales2017/Replication"
 
	

* master data
*------------	

use "15OMstr.dta", clear


	
	
	

		

			**	**	**	**	**	**	**	**	**	**	**	**	**
			**	**	**	**	**	**	**	**	**	**	**	**	**
			**	**	**	**	**	**	**	**	**	**	**	**	**
	


*-------------------------------------------------------------------------------
* graph in article
*-------------------------------------------------------------------------------
  
  

* create bins
*------------

egen MUDshare2013_bins = cut(MUDshare2013), at(0(.01).99)



* binned means
*-------------

gen change_abstention = abstention2017 - abstencion2015

foreach var of varlist change_abstention abstention2017 abstencion2015 {

	egen bins_`var' = mean(`var'), by(MUDshare2013_bins)
		
	}
	
foreach var of varlist votantesx votantes2015 {

	egen bins_`var' = sum(`var'), by(MUDshare2013_bins)
		
	}


* weighted means
*---------------

egen bins_wt_asbtencion2017 = wtmean(abstention2017), by(MUDshare2013_bins) weight(votantesx)

egen bins_wt_asbtencion2015 = wtmean(abstencion2015), by(MUDshare2013_bins) weight(votantes2015)

egen bins_wt_changeabstention = wtmean(change_abstention), by(MUDshare2013_bins) weight(votantesx)


	   
* change in abstencion graph
*---------------------------

replace bins_wt_changeabstention = bins_wt_changeabstention * 100

replace change_abstention = change_abstention * 100

# delimit;
	
twoway (scatter bins_wt_changeabstention MUDshare2013_bins, 
        msize(vsmall) mcolor(gs12))

	   (lpolyci change_abstention MUDshare2013 [aw = votantesx], 
        lcolor(gs12) lwidth(thin) ciplot(rline) lpattern(dash)) 

	   (lpoly change_abstention MUDshare2013 [aw = votantesx], lcolor(black)),   
	      
graphregion(fcolor(white) lcolor(white) margin(zero))

plotregion(fcolor(white) lstyle(none) lcolor(white) ilstyle(none))

xsize(7) ysize(5)

title("Fig. 2: Abstention increases more in opposition strongholds", 
	  color(black) placement(west) justification(left) size(medlarge)) 

subtitle("Each point plots the weighted mean of abstention rates across precincts in" 
		 "one-ppbins of 2013 opposition vote share; the line is a local linear fit to the raw" "precinct-level data (with 95% confidence interval).", 
	    color(black) placement(west) justification(left) size(medsmall)) 

ytitle("Percentge-point change in abstention", size(medlarge))

yscale(lcolor(none))

ylabel(3(2)23, labsize(medlarge) glcolor(white) angle(horizontal)) 

xtitle("Opposition vote share in 2013", size(medlarge)) 

xscale(lcolor(none))

xlabel(, labsize(medlarge)) 

legend(off);
	
graph export "ChangeAbstention.png", replace;	
	 
		 





	



			**	**	**	**	**	**	**	**	**	**	**	**	**
			**	**	**	**	**	**	**	**	**	**	**	**	**
			**	**	**	**	**	**	**	**	**	**	**	**	**
	
						** end of do file **		

   
	   
