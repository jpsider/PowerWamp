---
external help file: PowerWamp-help.xml
Module Name: powerwamp
online version:
schema: 2.0.0
---

# Invoke-Wamp

## SYNOPSIS
A quick function to to Start/Stop/Restart Wamp Components.

## SYNTAX

```
Invoke-Wamp [-action] <String> [[-Service] <String>] [<CommonParameters>]
```

## DESCRIPTION
Start/Stop/Restart Wamp Components

## EXAMPLES

### EXAMPLE 1
```
Invoke-Wamp -action Stop -Service apache
```

## PARAMETERS

### -action
Please Specify a valid connection.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Service
Please specify a valid Service

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Additional information about the function or script.

## RELATED LINKS
