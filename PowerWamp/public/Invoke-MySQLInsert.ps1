Function Invoke-MySQLInsert
{
    <#
		.SYNOPSIS
			A powershell function to insert data into MySQL and return the ID of the last inserted item.
		.DESCRIPTION
			Executes the MySQL insert.
		.PARAMETER query
			A valid SQL query is required.
		.PARAMETER ConnectionString
			A valid connection string is required.
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
			$MyConnectionString = "server=localhost;port=3306;uid=root;pwd=;database=summitrts"
			$LastItemID = @(Invoke-MySQLInsert -Query $query -ConnectionString $MyConnectionString)[1]
		.EXAMPLE	
			Inserting row(s) 	
			$query = "insert into rts_properties (name,val) VALUES ('SAMPLE_DATA_NAME','SAMPLE_VALUE')"	
			$LastItemID = @(Invoke-MySQLInsert -Query $query -MySQLUsername root -MySQLPassword " " -MySQLDatabase summitrts -MySQLServer localhost)[1]
		.NOTES
			no additional notes.
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
        $Command.ExecuteNonQuery()
        #return the LastInsertedId
        return $Command.LastInsertedId
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