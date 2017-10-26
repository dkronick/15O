

	******************************************************************
	**
	**
	**		NAME:		DOROTHY KRONICK
	**					and FRANCISCO RODRIGUEZ
	**		DATE: 		October 26, 2017
	**		PROJECT: 	15O
	**
	**		DETAILS: 	This calculates the number of votes
	**					going to candidates who lost in
	**					the primaries but whose names
	**					were kept on the ballot.
	**
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
* sum up no-sustituidos votes by state 
*-------------------------------------------------------------------------------



* read in master data
*--------------------

use "15OMstr.dta", clear



* calculate national total and share
*-----------------------------------

qui su no_sustituidos_sum

local no_sust = `r(sum)'

di `no_sust'

qui su validos 

local validos = `r(sum)'

di `no_sust' / `validos'




* calculate national total and share
*-----------------------------------

collapse (sum) no_sustituidos_sum votos* votantesx validos, by(estado)

gen GPP_advantage = votosGPP - votosMUD

gen GPP_advantage_c = GPP_advantage - no_sustituidos


		 





	



			**	**	**	**	**	**	**	**	**	**	**	**	**
			**	**	**	**	**	**	**	**	**	**	**	**	**
			**	**	**	**	**	**	**	**	**	**	**	**	**
	
						** end of do file **		

