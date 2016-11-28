# PowerWamp
![Alt text](https://github.com/jpsider/PowerWamp/blob/master/z_Images/PowerWamp_NoBg.png "PowerWamp Icon")  
## Overview  
This powershell module includes command to Start/Stop/Restart Wamp Services.  
The module also contains functions to Connect/disconnect to MySql databases.  
Finally the Run-MySQLQuery function allows you to peform queries against a MySQL database.  

## Requirements  
Powershell version 5.0 (It may work with older versions, but its not tested)  
MySQL connector 6.9.X https://dev.mysql.com/downloads/connector/net/6.9.html  

## Installation  
Import-Module \<path>\PowerWamp.psm1  

## Available Functions  
Connect-MySQL - Create a MySQL Connection  
Disconnect-MySQL - Disconnect from MySQL  
Run-MySQLQuery - Perform a Query  
Nudge-Wamp - Start/Stop/Restart Wamp services  

## Examples:  
### Connect to MySQL  
      $MySQLconn = Connect-MySQL -MySQLUsername root -MySQLPassword "" -MySQLDatabase Device -MySQLServer 127.0.0.1  
### Query the DB for rows of information and setting that as an Object:  
      $query = "select Testcase_name,Testcase_Status from test_cases"  
      $Data = @(Run-SQLCommand $Query $MySQLconn)  
### Updating database row(s):    
      $query = "update test_cases set Testcase_name = '$somevalue' where testcase_id = 1"   
      Run-SQLCommand $Query $MySQLconn  
### Disconnect:  
      Disconnect-MySQL $MySQLconn
### Stop Apache Service:  
      Nudge-Wamp -action Stop -Service apache
