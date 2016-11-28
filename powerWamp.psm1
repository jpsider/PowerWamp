#  ____                      __        __                    
# |  _ \ _____      _____ _ _\ \      / /_ _ _ __ ___  _ __  
# | |_) / _ \ \ /\ / / _ \ '__\ \ /\ / / _` | '_ ` _ \| '_ \ 
# |  __/ (_) \ V  V /  __/ |   \ V  V / (_| | | | | | | |_) |
# |_|   \___/ \_/\_/ \___|_|    \_/\_/ \__,_|_| |_| |_| .__/ 
#                                                     |_|
#=======================================================================================
function Connect-MySQL(){
	<#
		.SYNOPSIS
			A powershell function to connect to MySQL server.
		.DESCRIPTION
			Creates a MySQL server connection.
		.PARAMETER MySQLUsername MySQLPassword MySQLDatabase MySQLServer
			A valid SQL query is required.
		.EXAMPLE
			$MySQLconn = Connect-MySQL -MySQLUsername root -MySQLPassword "" -MySQLDatabase Device -MySQLServer 127.0.0.1
		.NOTES
			Additional information about the function or script.
	#>
	param(
		[Parameter(Mandatory=$true)]
			[string]$MySQLUsername,
			[string]$MySQLPassword,
			[string]$MySQLDatabase,
			[string]$MySQLServer
	)
	# Create the connection string
	$ConnectionString = "server=" + $MySQLServer + ";port=3306;uid=" + $MySQLUserName + ";pwd=" + $MySQLPassword + ";database="+$MySQLDatabase
	# Load MySQL .NET Connector Objects
	[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
	$Connection = New-Object MySql.Data.MySqlClient.MySqlConnection
	$Connection.ConnectionString = $ConnectionString
	# Open Connection
	$Connection.Open()
	return $Connection
}

#=======================================================================================
function Run-MySQLQuery(){
	<#
		.SYNOPSIS
			A powershell function to run MySQL Queries.
		.DESCRIPTION
			Executes the Query.
		.PARAMETER query
			A valid SQL query is required.
		.EXAMPLE
			Query the DB for rows of information and setting that as an Object.
			$query = "select Testcase_name,Testcase_Status from test_cases"	
			$Data = @(Run-SQLCommand $Query $MySQLconn)
		.EXAMPLE	
			Updating database row(s) 	
			$query = "update test_cases set Testcase_name = '$somevalue' where testcase_id = 1"	
			Run-SQLCommand $Query $MySQLconn
		.NOTES
			Additional information about the function or script.
	#>
	param(
		[Parameter(Mandatory=$true)]
			[string]$Query,
			[string]$Connection
	)
	# Create command object
	$Command = New-Object MySql.Data.MySqlClient.MySqlCommand($Query, $Connection)
	$DataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($Command)
	$DataSet = New-Object System.Data.DataSet
	$RecordCount = $dataAdapter.Fill($dataSet, "data")
	#return the data
	return $DataSet.Tables[0]
}

#=======================================================================================
function Disconnect-MySQL(){
	<#
	.SYNOPSIS
		A quick function to drop a MySQL connection.
	.DESCRIPTION
		disconnects a specified MySQL connection.
	.PARAMETER  connection
		Please Specify a valid connection.
	.EXAMPLE
		Disconnect-MySQL $MySQLconn
	.NOTES
		Additional information about the function or script.
	#>
	param(
		[Parameter(Mandatory=$true)]
			[string]$Connection
	)
	# Disconnect from MySQL Database
	$Connection.Close()
}

#=======================================================================================
function Nudge-Wamp(){
	<#
	.SYNOPSIS
		A quick function to to Start/Stop/Restart Wamp Components.
	.DESCRIPTION
		Start/Stop/Restart Wamp Components
	.PARAMETER action
		Please Specify a valid connection.
	.PARAMETER Service
		Please specify a valid Service
	.EXAMPLE
		Nudge-Wamp -action Stop -Service apache
	.NOTES
		Additional information about the function or script.
	#>
	param(
		[cmdletbinding()]
		[Parameter(Mandatory=$true)]
			[validateset('stop','start','restart',IgnoreCase=$true)]
			[string]$action,
			[validateset('apache','mysql',IgnoreCase=$true)]
			[string]$Service
	)
	#Determine Service
	if ($service -eq 'apache') {
		$wampService = 'wampapache*'
	} elseif ($service -eq 'mysql') {
		$wampService = 'wampmysql*'
	} 

	#Determine Service Status
	$Status = (Get-Service $wampService).status
	#perform Action
	if($action -eq 'start'){
		if ($Status -eq 'Running') {
			write-host "The Service: '$wampService' is running, taking no action."
			break
		} elseif ($Status -eq 'Stopped') {
			write-host "Starting Service: '$wampService'."
			Start-Service $wampService -confirm:$false
			Break
		} else {
			write-host "Unable to determine Service Status:'$status'"
			break
		}
	} elseif ($action -eq 'stop') {
		if ($Status -eq 'Running') {
			write-host "Stopping Service: '$wampService'."
			Stop-Service $wampService -confirm:$false
			break
		} elseif ($Status -eq 'Stopped') {
			write-host "The Service: '$wampService' is Stopped, taking no action."
			Break
		} else {
			write-host "Unable to determine Service Status:'$status'"
			break
		}
	} elseif ($action -eq 'restart') {
		if ($Status -eq 'Running') {
			write-host "Restarting Service: '$wampService'."
			Restart-Service $wampService -confirm:$false
			break
		} elseif ($Status -eq 'Stopped') {
			write-host "The Service: '$wampService' is Stopped, taking no action."
			Break
		} else {
			write-host "Unable to determine Service Status:'$status'"
			break
		}
	} 
}
#=======================================================================================
#    _  _  _____                    ____       _             
#  _| || ||_   _|__  __ _ _ __ ___ | __ )  ___| | __ _ _   _ 
# |_  ..  _|| |/ _ \/ _` | '_ ` _ \|  _ \ / _ \ |/ _` | | | |
# |_      _|| |  __/ (_| | | | | | | |_) |  __/ | (_| | |_| |
#   |_||_|  |_|\___|\__,_|_| |_| |_|____/ \___|_|\__,_|\__, |
#                                                      |___/ 