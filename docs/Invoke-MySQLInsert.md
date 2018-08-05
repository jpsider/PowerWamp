---
external help file: PowerWamp-help.xml
Module Name: powerwamp
online version:
schema: 2.0.0
---

# Invoke-MySQLInsert

## SYNOPSIS
A powershell function to insert data into MySQL and return the ID of the last inserted item.

## SYNTAX

### ByConnectionString (Default)
```
Invoke-MySQLInsert -Query <String> -ConnectionString <String> [<CommonParameters>]
```

### ByItems
```
Invoke-MySQLInsert -Query <String> -MySQLUsername <String> -MySQLPassword <SecureString>
 -MySQLDatabase <String> -MySQLServer <String> [<CommonParameters>]
```

## DESCRIPTION
Executes the MySQL insert.

## EXAMPLES

### EXAMPLE 1
```
Inserting row(s)
```

$query = "insert into rts_properties (name,val) VALUES ('SAMPLE_DATA_NAME','SAMPLE_VALUE')"	
$MyConnectionString = "server=localhost;port=3306;uid=root;pwd=;database=summitrts"
$LastItemID = @(Invoke-MySQLInsert -Query $query -ConnectionString $MyConnectionString)\[1\]

### EXAMPLE 2
```
Inserting row(s)
```

$query = "insert into rts_properties (name,val) VALUES ('SAMPLE_DATA_NAME','SAMPLE_VALUE')"	
$LastItemID = @(Invoke-MySQLInsert -Query $query -MySQLUsername root -MySQLPassword " " -MySQLDatabase summitrts -MySQLServer localhost)\[1\]

## PARAMETERS

### -Query
A valid SQL query is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConnectionString
A valid connection string is required.

```yaml
Type: String
Parameter Sets: ByConnectionString
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MySQLUsername
A valid MySQL username is required.

```yaml
Type: String
Parameter Sets: ByItems
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MySQLPassword
A valid MySQL password is required.

```yaml
Type: SecureString
Parameter Sets: ByItems
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MySQLDatabase
A valid MySQL Database is required.

```yaml
Type: String
Parameter Sets: ByItems
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MySQLServer
A valid MySQL Server is required.

```yaml
Type: String
Parameter Sets: ByItems
Aliases:

Required: True
Position: Named
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
no additional notes.

## RELATED LINKS
