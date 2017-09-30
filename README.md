# PowerWamp

Module to Control WampServer

## GitPitch PitchMe presentation

* [gitpitch.com/jpsider/PowerWamp](https://gitpitch.com/jpsider/PowerWamp)

## Getting Started

Install from the PSGallery and Import the module

    Install-Module PowerWamp
    Import-Module PowerWamp


## More Information

For more information

* [PowerWamp.readthedocs.io](http://PowerWamp.readthedocs.io)
* [github.com/jpsider/PowerWamp](https://github.com/jpsider/PowerWamp)
* [jpsider.github.io](https://jpsider.github.io)


This project was generated using [Kevin Marquette](http://kevinmarquette.github.io)'s [Full Module Plaster Template](https://github.com/KevinMarquette/PlasterTemplates/tree/master/FullModuleTemplate).

# PowerWamp
![Alt text](https://github.com/jpsider/PowerWamp/blob/master/z_Images/PowerWamp_NoBg.png "PowerWamp Icon")  
## Overview  
This powershell module includes command to Start/Stop/Restart Wamp Services.  
The module also contains functions to execute Queries/Inserts for MySql databases. 

![Build status](https://ci.appveyor.com/api/projects/status/github/webhook?id=vulgh26eak4n97kj/branch/master?svg=true)   

## Requirements  
Powershell version 5.0 (It may work with older versions, but its not tested.)  
MySQL connector 6.9.X https://dev.mysql.com/downloads/connector/net/6.9.html  

## Installation  
### Download the file and run the following line:  
Import-Module \<path>\PowerWamp.psm1  

### Copy and paste these lines. c:\temp needs to exist.  
      $webclient = New-Object System.Net.WebClient  
      $filepath = "C:\temp\powerwamp.psm1"  
      $url = "https://raw.github.com/jpsider/PowerWamp/master/powerWamp.psm1"  
      $webclient.DownloadFile($url,$filepath)  
      Import-module $filepath  

## Available Functions 
Connect-MySQL - Creates a MySQL connection   
Disconnect-MySQL - Disconnect from MySQL  
Invoke-MySQLQuery - Perform a Query  
Invoke-MySQLInsert - Perform an insert and retrieve the last inserted ID  
Invoke-Wamp - Start/Stop/Restart Wamp services  

## Executing query Connection Detail options  
### With Connection String  
	  $query = "update test_cases set Testcase_name = '$somevalue' where testcase_id = 1"  
	  $MyConnectionString = "server=localhost;port=3306;uid=root;pwd=;database=summitrts"  
	  Invoke-MySQLQuery -Query $query -ConnectionString $MyConnectionString  
### With individual Items  
	  $query = "update test_cases set Testcase_name = '$somevalue' where testcase_id = 1"  	
	  Invoke-MySQLQuery -Query $query -MySQLUsername root -MySQLPassword " " -MySQLDatabase summitrts -MySQLServer localhost  

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
	  $LastItemID = @(Invoke-MySQLInsert -Query $query -MySQLUsername root -MySQLPassword " " -MySQLDatabase summitrts -MySQLServer localhost)[1]	  
### Stop Apache Service:  
      Invoke-Wamp -action Stop -Service apache
