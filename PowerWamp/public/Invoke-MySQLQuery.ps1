Function Invoke-MySQLQuery
{
    <#
		.SYNOPSIS
			A powershell function to run MySQL Queries.
		.DESCRIPTION
			Executes the Query.
		.PARAMETER query
			A valid SQL query is required.
		.PARAMETER ConnectionString
			A valid MySQL connection String is required.
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
			$MyConnectionString = "server=localhost;port=3306;uid=root;pwd=;database=summitrts" 
			$Data = @(Invoke-MySQLQuery -Query $query -ConnectionString $MyConnectionString)
		.EXAMPLE	
			Updating database row(s) 	
			$query = "update test_cases set Testcase_name = '$somevalue' where testcase_id = 1"	
			$MyConnectionString = "server=localhost;port=3306;uid=root;pwd=;database=summitrts"
			Invoke-MySQLQuery -Query $query -ConnectionString $MyConnectionString	
		.EXAMPLE
			Query the DB for rows of information and setting that as an Object.
			$query = "select Testcase_name,Testcase_Status from test_cases"	
			$Data = @(Invoke-MySQLQuery -Query $query -MySQLUsername root -MySQLPassword "" -MySQLDatabase summitrts -MySQLServer localhost)
		.EXAMPLE	
			Updating database row(s) 	
			$query = "update test_cases set Testcase_name = '$somevalue' where testcase_id = 1"	
			Invoke-MySQLQuery -Query $query -MySQLUsername root -MySQLPassword "" -MySQLDatabase summitrts -MySQLServer localhost
		.NOTES
			No additional notes.
	#>
    [CmdletBinding(DefaultParameterSetName = 'ByConnectionString')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'ByConnectionString')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ByItems')]
        [string]$Query,
        [Parameter(Mandatory = $true, ParameterSetName = 'ByConnectionString')]
        [string]$ConnectionString,
        [Parameter(Mandatory = $true, ParameterSetName = 'ByItems')]
        [string]$MySQLUsername,
        [Parameter(Mandatory = $true, ParameterSetName = 'ByItems')]
        [System.Security.SecureString]$MySQLPassword,
        [Parameter(Mandatory = $true, ParameterSetName = 'ByItems')]
        [string]$MySQLDatabase,
        [Parameter(Mandatory = $true, ParameterSetName = 'ByItems')]			
        [string]$MySQLServer			
    )
    try
    {
        if ($ConnectionString -eq "")
        {
            $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($MySQLPassword)
            $UnsecurePassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
            $ConnectionString = "server=" + $MySQLServer + ";port=3306;uid=" + $MySQLUserName + ";pwd=" + $UnsecurePassword + ";database=" + $MySQLDatabase
        }
        $Connection = (Connect-MySQL $ConnectionString)

        # Create command object
        $Command = New-Object MySql.Data.MySqlClient.MySqlCommand($Query, $Connection)
        $DataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($Command)
        $DataSet = New-Object System.Data.DataSet
        $dataAdapter.Fill($dataSet, "data") > $null
        #return the data
        return $DataSet.Tables[0]
    }
    Catch
    {
        $ErrorMessage = $_.Exception.Message
        $FailedItem = $_.Exception.ItemName		
        Write-Error "Query Error: $ErrorMessage $FailedItem"
        BREAK		
    }
    Finally
    {
        #Disconnect from MySQL
        Disconnect-MySQL $Connection
    }
}