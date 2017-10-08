Function Connect-MySQL
{
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
        [Parameter(Mandatory = $true)]
        [string]$ConnectionString			
    )
    try
    {
        # Load MySQL .NET Connector Objects
        [void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
        $Connection = New-Object MySql.Data.MySqlClient.MySqlConnection
        $Connection.ConnectionString = $ConnectionString
        # Open Connection
        $Connection.Open()
        return $Connection
    }
    Catch
    {
        $ErrorMessage = $_.Exception.Message
        $FailedItem = $_.Exception.ItemName		
        Write-Error "Connection Error: $ErrorMessage $FailedItem"
        BREAK
    }
}