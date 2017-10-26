

	******************************************************************
	**
	**
	**		NAME:		DOROTHY KRONICK
	**					and FRANCISCO RODRIGUEZ
	**		DATE: 		October 26, 2017
	**		PROJECT: 	15O
	**
	**		DETAILS: 	This file predicts 2017 turnout
	**					on 2015 turnout, 2013 MUD vote 
	**					share, and Maria Corina Machado's
	**					vote share in the 2012 primaries.
	**					These results underlie the statement
	**					in the article that turnout was
	**					lower than expected in places that
	**					supported MCM.
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
* simple regressions underlying statement in paper about MCM and abstention
*-------------------------------------------------------------------------------
 
 

* no controls
*------------
	
reg turnout2017 turnout2015 MCMshare2012

reg turnout2017 turnout2015 MCMshare2012 MUDshare2013



* adding 2013 MUD share and state fixed effects
*----------------------------------------------

areg turnout2017 turnout2015 MCMshare2012 MUDshare2013, a(estado)

			 





	



			**	**	**	**	**	**	**	**	**	**	**	**	**
			**	**	**	**	**	**	**	**	**	**	**	**	**
			**	**	**	**	**	**	**	**	**	**	**	**	**
	
						** end of do file **		

   
	   

	
