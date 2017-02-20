#=======================================================================================
#  ____                      __        __                    
# |  _ \ _____      _____ _ _\ \      / /_ _ _ __ ___  _ __  
# | |_) / _ \ \ /\ / / _ \ '__\ \ /\ / / _` | '_ ` _ \| '_ \ 
# |  __/ (_) \ V  V /  __/ |   \ V  V / (_| | | | | | | |_) |
# |_|   \___/ \_/\_/ \___|_|    \_/\_/ \__,_|_| |_| |_| .__/ 
#                                                     |_|
#=======================================================================================
Function Connect-MySQL() {
	<#
		.SYNOPSIS
			A powershell function to connect to a MySQL Database.
		.DESCRIPTION
			Executes the Query.
		.PARAMETER ConnectionString
			A valid MySQL string is required.
		.EXAMPLE
			$MySQLconn = (Connect-MySQL $ConnectionString)
		.NOTES
			No additional notes.
	#>
	param(
		[Parameter(Mandatory=$true)]
			[string]$ConnectionString			
	)
	try {
		# Load MySQL .NET Connector Objects
		[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
		$Connection = New-Object MySql.Data.MySqlClient.MySqlConnection
		$Connection.ConnectionString = $ConnectionString
		# Open Connection
		$Connection.Open()
		return $Connection
	}
	Catch {
	    $ErrorMessage = $_.Exception.Message
    	$FailedItem = $_.Exception.ItemName		
		write-host "Connection Error:" $ErrorMessage $FailedItem
		BREAK
	}
}
                                                    
#=======================================================================================
Function Invoke-MySQLQuery() {
	<#
		.SYNOPSIS
			A powershell function to run MySQL Queries.
		.DESCRIPTION
			Executes the Query.
		.PARAMETER query
			A valid SQL query is required.
		.PARAMETER MySQLUsername
			A valid MySQL username is required.
		.PARAMETER MySQLPassword
			A valid MySQL password is required.			
		.PARAMETER MySQLDatabase
			A valid MySQL Database is required.
		.PARAMETER MySQLServer
			A valid MySQL Server is required.	
		.EXAMPLE
			Query the DB for rows of information and setting that as an Object.
			$query = "select Testcase_name,Testcase_Status from test_cases"	
			$Data = @(-Query $query -MySQLUsername root -MySQLPassword "" -MySQLDatabase summitrts -MySQLServer localhost)
		.EXAMPLE	
			Updating database row(s) 	
			$query = "update test_cases set Testcase_name = '$somevalue' where testcase_id = 1"	
			Invoke-MySQLQuery -Query $query -MySQLUsername root -MySQLPassword "" -MySQLDatabase summitrts -MySQLServer localhost
		.NOTES
			No additional notes.
	#>
	param(
		[Parameter(Mandatory=$true)]
			[string]$Query,
		[Parameter(Mandatory=$true)]
			[string]$MySQLUsername,
			[string]$MySQLPassword,
			[string]$MySQLDatabase,
			[string]$MySQLServer			
	)
	try {
		$ConnectionString = "server=" + $MySQLServer + ";port=3306;uid=" + $MySQLUserName + ";pwd=" + $MySQLPassword + ";database="+$MySQLDatabase
		$Connection = (Connect-MySQL $ConnectionString)

		# Create command object
		$Command = New-Object MySql.Data.MySqlClient.MySqlCommand($Query, $Connection)
		$DataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($Command)
		$DataSet = New-Object System.Data.DataSet
		$RecordCount = $dataAdapter.Fill($dataSet, "data")
		#return the data
		return $DataSet.Tables[0]
	}
	Catch {
	    $ErrorMessage = $_.Exception.Message
    	$FailedItem = $_.Exception.ItemName		
		write-host "Query Error:" $ErrorMessage $FailedItem
		BREAK		
	}
	Finally{
		#Disconnect from MySQL
		Disconnect-MySQL $Connection
	}
}

#=======================================================================================
Function Invoke-MySQLInsert() {
	<#
		.SYNOPSIS
			A powershell function to insert data into MySQL and return the ID of the last inserted item.
		.DESCRIPTION
			Executes the MySQL insert.
		.PARAMETER query
			A valid SQL query is required.
		.PARAMETER MySQLUsername
			A valid MySQL username is required.
		.PARAMETER MySQLPassword
			A valid MySQL password is required.			
		.PARAMETER MySQLDatabase
			A valid MySQL Database is required.
		.PARAMETER MySQLServer
			A valid MySQL Server is required.			
		.EXAMPLE	
			Inserting row(s) 	
			$query = "insert into rts_properties (name,val) VALUES ('SAMPLE_DATA_NAME','SAMPLE_VALUE')"	
			$LastItemID = @(Invoke-MySQLInsert -Query $query -MySQLUsername root -MySQLPassword "" -MySQLDatabase summitrts -MySQLServer localhost)[1]
		.NOTES
			no additional notes.
	#>
	param(
		[Parameter(Mandatory=$true)]
			[string]$Query,
		[Parameter(Mandatory=$true)]
			[string]$MySQLUsername,
			[string]$MySQLPassword,
			[string]$MySQLDatabase,
			[string]$MySQLServer			
	)
	try {
		$ConnectionString = "server=" + $MySQLServer + ";port=3306;uid=" + $MySQLUserName + ";pwd=" + $MySQLPassword + ";database="+$MySQLDatabase
		$Connection = (Connect-MySQL $ConnectionString)
	
		# Create command object
		$Command = New-Object MySql.Data.MySqlClient.MySqlCommand($Query, $Connection)
		$Command.ExecuteNonQuery()
		#return the LastInsertedId
		return $Command.LastInsertedId
	}
	Catch {
	    $ErrorMessage = $_.Exception.Message
    	$FailedItem = $_.Exception.ItemName		
		write-host "Query Error:" $ErrorMessage $FailedItem
		BREAK		
	}
	Finally{
		#Disconnect from MySQL
		Disconnect-MySQL $Connection
	}
}

#=======================================================================================
Function Disconnect-MySQL(){
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
		No additional notes.
	#>
	param(
		[Parameter(Mandatory=$true)]
			$Connection
	)
	try {
		# Disconnect from MySQL Database
		$Connection.Close()
	}
	Catch {
	    $ErrorMessage = $_.Exception.Message
    	$FailedItem = $_.Exception.ItemName		
		write-host "Query Error:" $ErrorMessage $FailedItem
		BREAK			
	}
}

#=======================================================================================
Function Invoke-Wamp() {
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
		Invoke-Wamp -action Stop -Service apache
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

	try {
		#Determine Service Status
		$Status = (Get-Service $wampService).status
		#perform Action
		if($action -eq 'start'){
			if ($Status -eq 'Running') {
				write-host "The Service: '$wampService' is running, taking no action."
				BREAK
			} elseif ($Status -eq 'Stopped') {
				write-host "Starting Service: '$wampService'."
				Start-Service $wampService -confirm:$false
				BREAK
			} else {
				write-host "Unable to determine Service Status:'$status'"
				BREAK
			}
		} elseif ($action -eq 'stop') {
			if ($Status -eq 'Running') {
				write-host "Stopping Service: '$wampService'."
				Stop-Service $wampService -confirm:$false
				BREAK
			} elseif ($Status -eq 'Stopped') {
				write-host "The Service: '$wampService' is Stopped, taking no action."
				BREAK
			} else {
				write-host "Unable to determine Service Status:'$status'"
				BREAK
			}
		} elseif ($action -eq 'restart') {
			if ($Status -eq 'Running') {
				write-host "Restarting Service: '$wampService'."
				Restart-Service $wampService -confirm:$false
				BREAK
			} elseif ($Status -eq 'Stopped') {
				write-host "The Service: '$wampService' is Stopped, taking no action."
				BREAK
			} else {
				write-host "Unable to determine Service Status:'$status'"
				BREAK
			}
		} 
	}
	Catch {
	    $ErrorMessage = $_.Exception.Message
    	$FailedItem = $_.Exception.ItemName		
		write-host "Error:" $ErrorMessage $FailedItem
		BREAK		
	}
}
#=============================================================================================
#  ___                 _                _         _                        _   _              
# |_ _|_ ____   _____ | | _____        / \  _   _| |_ ___  _ __ ___   __ _| |_(_) ___  _ __   
#  | || '_ \ \ / / _ \| |/ / _ \_____ / _ \| | | | __/ _ \| '_ ` _ \ / _` | __| |/ _ \| '_ \  
#  | || | | \ V / (_) |   <  __/_____/ ___ \ |_| | || (_) | | | | | | (_| | |_| | (_) | | | | 
# |___|_| |_|\_/ \___/|_|\_\___|    /_/   \_\__,_|\__\___/|_| |_| |_|\__,_|\__|_|\___/|_| |_| 
#============================================================================================= 