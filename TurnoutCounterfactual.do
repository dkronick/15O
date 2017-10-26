

	******************************************************************
	**
	**
	**		NAME:		DOROTHY KRONICK
	**					and FRANCISCO RODRIGUEZ
	**		DATE: 		October 26, 2017
	**		PROJECT: 	15O
	**
	**		DETAILS: 	This calculates a back-of-the-envelope
	**    				counterfactual for how many votes
	**					MUD and GPP would have received
	**					on 15O if turnout had looked
	**					more like it did in 2015.
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
* preliminaries
*-------------------------------------------------------------------------------
  


* percent (not percentage-point) change in turnout
*-------------------------------------------------

gen pchange_turnout = (turnout2017 - turnout2015) / turnout2015 ///
                       if turnout2015 ~= 0

					   

* predicted change in turnout
*----------------------------

	/* Here, we assume that MUD turnout everywhere 
	   declined by the same percent as overall turnout
	   in MUD strongholds. We make an analogous
	   assumption about the GPP. 
	   
	   */

su MUDshare2013, d

local floor = `r(p90)'

local ceil = `r(p10)'

su pchange_turnout  if MUDshare2013 > `floor'

local pchange_oppo = `r(mean)'

su pchange_turnout  if MUDshare2013 < `ceil'

local pchange_gov = `r(mean)'



* counterfactual vote totals
*---------------------------

	/* The _cc suffix stands for counterfactual.
	
	   */

gen MUD_cc = (1 / (1 + `pchange_oppo')) * votosMUD

gen GPP_cc = (1 / (1 + `pchange_gov')) * votosGPP

gen validos_cc = (validos - votosMUD + MUD_cc - votosGPP + GPP_cc)



* capture sum of actual and counterfactual votes
*-----------------------------------------------

qui su MUD_cc

local mud_cc = `r(sum)'

qui su GPP_cc

local gpp_cc = `r(sum)'

qui su votosMUD

local mud = `r(sum)'

qui su votosGPP

local gpp = `r(sum)'



* display figures quoted in article
*----------------------------------

di "Actual GPP votes:" `gpp' / 1000000 " Counterfactual GPP votes:" `gpp_cc' / 1000000

di "Difference = " (`gpp_cc' - `gpp') / 1000000

di "Actual MUD votes:" `mud' / 1000000 " Counterfactual MUD votes:" `mud_cc' / 1000000

di "Difference = " (`mud_cc' - `mud') / 1000000




	



			**	**	**	**	**	**	**	**	**	**	**	**	**
			**	**	**	**	**	**	**	**	**	**	**	**	**
			**	**	**	**	**	**	**	**	**	**	**	**	**
	
						** end of do file **		

   
	   
