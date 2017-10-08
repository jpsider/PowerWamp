Function Disconnect-MySQL
{
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
        [Parameter(Mandatory = $true)]
        $Connection
    )
    try
    {
        # Disconnect from MySQL Database
        $Connection.Close()
    }
    Catch
    {
        $ErrorMessage = $_.Exception.Message
        $FailedItem = $_.Exception.ItemName		
        Write-Error "Query Error: $ErrorMessage $FailedItem"
        BREAK			
    }
}