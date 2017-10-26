

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
	**					on 15O if precincts had not been
	**					relocated at the last minute.s
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
* (1) baseline counterfactual: NOT taking into account 2013 MUD share
*-------------------------------------------------------------------------------

	/* Note: In this version, we predict turnout in 2017
	         in relocated precincts using *only* turnout 
			 in 2015 and no other covariates. The 
			 figures reported in the paper come from 
			 Section (2) below (see note in that section).
			 
			 Note that the _c suffix stands for counterfactual.
			 
			 */

			 
			 
* load master data
*-----------------

use "15OMstr.dta", clear



* predict turnout excluding reubicados
*-------------------------------------

reg turnout2017 turnout2015 if reubicado_g == 0

predict turnout2017_c if reubicado_g == 1



* counterfactual vote totals
*---------------------------

	/* 	The above code gives us counterfactual turnout.
	    We add these additional votes either to MUD's or
		to GPP's vote total in proportion to each party's
		vote share in 2015. 
		
		Note that, in cases where the counterfactual 
		turnout is lower than the actual turnout, we do not
		subtract votes from either side.
		
		*/

gen votosMUD_c = votosMUD

gen votosGPP_c = votosGPP

replace votosMUD_c = votosMUD_c + MUDshare2015 * (turnout2017_c - turnout2017) * votantesx ///
        if reubicado_g == 1 & turnout2017_c > turnout2017

replace votosGPP_c = votosGPP_c + (1 - MUDshare2015) * (turnout2017_c - turnout2017) * votantesx ///
        if reubicado_g == 1 & turnout2017_c > turnout2017


		
* collapse to state level
*------------------------		
		
collapse (sum) votos* votantesx validos, by(estado)



* create counterfactual vote totals and differences
*--------------------------------------------------

gen validos_c = votosGPP_c + votosMUD_c + votosOTHER

gen MUD_bonus =  votosMUD_c - votosMUD2017

gen GPP_bonus = votosGPP_c - votosGPP2017



* capture national totals
*------------------------

qui su MUD_bonus

local MUD_bonus = `r(sum)' 

qui su GPP_bonus

local GPP_bonus = `r(sum)' 

qui su votosMUD_c

local mud_c = `r(sum)'

qui su votosGPP_c

local gpp_c = `r(sum)'

qui su votosMUD2017

local mud = `r(sum)'

qui su votosGPP2017

local gpp = `r(sum)'

qui su validos2017

local total = `r(sum)'

qui su validos_c 

local total_c = `r(sum)'



* display totals
*---------------

di "Actual MUD share:" `mud' / `total'

di "Counterfactual MUD share:" `mud_c' / `total_c'

di "Actual MUD votes:" `mud' / 1000000

di "Counterfactual MUD votes:" `mud_c' / 1000000

di "MUD bonus:" `MUD_bonus' / 1000

di "Actual GPP votes:" `gpp' / 1000000

di "Counterfactual GPP votes:" `gpp_c' / 1000000

di "GPP bonus:" `GPP_bonus' / 1000










			**	**	**	**	**	**	**	**	**	**	**	**	**
			**	**	**	**	**	**	**	**	**	**	**	**	**
			**	**	**	**	**	**	**	**	**	**	**	**	**
	


*-------------------------------------------------------------------------------
* (2) better counterfactual: taking into account 2013 MUD share
*-------------------------------------------------------------------------------

	/* Note: In this version, we include 2013 vote share
			 as a covariate in the prediction. The motivation
			 for this is that, even conditional on 2015 turnout,
			 2013 MUD share strongly negatively predicts
			 turnout in 2017. Since relocations were concentrated
			 in opposition precincts, not taking this into account
			 inflates the apparent consequences of the relocations.
			 
			 Note that the _c suffix stands for counterfactual.
			 
			 */


use "15OMstr.dta", clear



* make predictions excluding reubicados
*--------------------------------------

reg turnout2017 turnout2015 MUDshare2013 if reubicado_g == 0

predict turnout2017_c if reubicado_g == 1



* counterfactual vote totals
*---------------------------

	/* 	The above code gives us counterfactual turnout.
	    We add these additional votes either to MUD's or
		to GPP's vote total in proportion to each party's
		vote share in 2015. 
		
		Note that, in cases where the counterfactual 
		turnout is lower than the actual turnout, we do not
		subtract votes from either side.
		
		*/

gen votosMUD_c = votosMUD

gen votosGPP_c = votosGPP
	
replace votosMUD_c = votosMUD_c + MUDshare2015 * (turnout2017_c - turnout2017) * votantesx ///
        if reubicado_g == 1 & turnout2017_c > turnout2017

replace votosGPP_c = votosGPP_c + (1 - MUDshare2015) * (turnout2017_c - turnout2017) * votantesx ///
        if reubicado_g == 1 & turnout2017_c > turnout2017


		
* collapse to state level
*------------------------		
		
collapse (sum) votos* votantesx validos, by(estado)



* create counterfactual vote totals and differences
*--------------------------------------------------

gen validos_c = votosGPP_c + votosMUD_c + votosOTHER

gen MUD_bonus =  votosMUD_c - votosMUD2017

gen GPP_bonus = votosGPP_c - votosGPP2017



* capture national totals
*------------------------

qui su MUD_bonus

local MUD_bonus = `r(sum)' 

qui su GPP_bonus

local GPP_bonus = `r(sum)' 

qui su votosMUD_c

local mud_c = `r(sum)'

qui su votosGPP_c

local gpp_c = `r(sum)'

qui su votosMUD2017

local mud = `r(sum)'

qui su votosGPP2017

local gpp = `r(sum)'

qui su validos2017

local total = `r(sum)'

qui su validos_c 

local total_c = `r(sum)'



* display totals quoted in article
*---------------------------------

di "Actual MUD share:" `mud' / `total'

di "Counterfactual MUD share:" `mud_c' / `total_c'

di "Actual MUD votes:" `mud' / 1000000

di "Counterfactual MUD votes:" `mud_c' / 1000000

di "MUD bonus:" `MUD_bonus' / 1000

di "Actual GPP votes:" `gpp' / 1000000

di "Counterfactual GPP votes:" `gpp_c' / 1000000

di "GPP bonus:" `GPP_bonus' / 1000
	 
		 





	



			**	**	**	**	**	**	**	**	**	**	**	**	**
			**	**	**	**	**	**	**	**	**	**	**	**	**
			**	**	**	**	**	**	**	**	**	**	**	**	**
	
						** end of do file **		

