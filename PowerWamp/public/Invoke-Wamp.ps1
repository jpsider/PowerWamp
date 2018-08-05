Function Invoke-Wamp
{
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
        [Parameter(Mandatory = $true)]
        [validateset('stop', 'start', 'restart', IgnoreCase = $true)]
        [string]$action,
        [validateset('apache', 'mysql', IgnoreCase = $true)]
        [string]$Service
    )
    #Determine Service
    if ($service -eq 'apache')
    {
        $wampService = 'wampapache*'
    }
    elseif ($service -eq 'mysql')
    {
        $wampService = 'wampmysql*'
    }

    try
    {
        #Determine Service Status
        $Status = (Get-Service $wampService).status
        #perform Action
        if ($action -eq 'start')
        {
            if ($Status -eq 'Running')
            {
                Write-Output "The Service: '$wampService' is running, taking no action."
                BREAK
            }
            elseif ($Status -eq 'Stopped')
            {
                Write-Output "Starting Service: '$wampService'."
                Start-Service $wampService -confirm:$false
                BREAK
            }
            else
            {
                Write-Output "Unable to determine Service Status:'$status'"
                BREAK
            }
        }
        elseif ($action -eq 'stop')
        {
            if ($Status -eq 'Running')
            {
                Write-Output "Stopping Service: '$wampService'."
                Stop-Service $wampService -confirm:$false
                BREAK
            }
            elseif ($Status -eq 'Stopped')
            {
                Write-Output "The Service: '$wampService' is Stopped, taking no action."
                BREAK
            }
            else
            {
                Write-Output "Unable to determine Service Status:'$status'"
                BREAK
            }
        }
        elseif ($action -eq 'restart')
        {
            if ($Status -eq 'Running')
            {
                Write-Output "Restarting Service: '$wampService'."
                Restart-Service $wampService -confirm:$false
                BREAK
            }
            elseif ($Status -eq 'Stopped')
            {
                Write-Output "The Service: '$wampService' is Stopped, taking no action."
                BREAK
            }
            else
            {
                Write-Output "Unable to determine Service Status:'$status'"
                BREAK
            }
        }
    }
    Catch
    {
        $ErrorMessage = $_.Exception.Message
        $FailedItem = $_.Exception.ItemName
        Write-Error "Error: $ErrorMessage $FailedItem"
        BREAK
    }
}