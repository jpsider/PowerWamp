# PowerWamp
![Alt text](https://github.com/jpsider/PowerWamp/blob/master/z_Images/PowerWamp_NoBg.png "PowerWamp Icon")  
## Overview  
This powershell module includes command to Start/Stop/Restart Wamp Services.  
The module also contains functions to execute Queries/Inserts for MySql databases.    

## Requirements  
Powershell version 5.0 (It may work with older versions, but its not tested.)  
MySQL connector 6.9.X https://dev.mysql.com/downloads/connector/net/6.9.html  

## Installation  
Import-Module \<path>\PowerWamp.psm1  

## Available Functions 
Connect-MySQL - Creates a MySQL connection   
Disconnect-MySQL - Disconnect from MySQL  
Invoke-MySQLQuery - Perform a Query  
Invoke-MySQLInsert - Perform an insert and retrieve the last inserted ID  
Invoke-Wamp - Start/Stop/Restart Wamp services  

## Examples:  
### Connect to MySQL:
	  $MySQLconn = (Connect-MySQL $ConnectionString)  
### Disconnect:  
      Disconnect-MySQL $connection
### Query the DB for rows of information and setting that as an Object:  
      $query = "select Testcase_name,Testcase_Status from test_cases"  
      $Data = @(Invoke-MySQLQuery -Query $query -MySQLUsername root -MySQLPassword "" -MySQLDatabase summitrts -MySQLServer localhost)  
### Updating database row(s):    
      $query = "update test_cases set Testcase_name = '$somevalue' where testcase_id = 1"   
      Invoke-MySQLQuery -Query $query -MySQLUsername root -MySQLPassword "" -MySQLDatabase summitrts -MySQLServer localhost  
### Inserting row(s) 	
	  $query = "insert into rts_properties (name,val) VALUES ('SAMPLE_DATA_NAME','SAMPLE_VALUE')"	
	  $LastItemID = @(Invoke-MySQLInsert -Query $query -MySQLUsername root -MySQLPassword "" -MySQLDatabase summitrts -MySQLServer localhost)[1]	  
### Stop Apache Service:  
      Invoke-Wamp -action Stop -Service apache
