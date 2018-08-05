---
external help file: PowerWamp-help.xml
Module Name: powerwamp
online version:
schema: 2.0.0
---

# Invoke-MySQLQuery

## SYNOPSIS
A powershell function to run MySQL Queries.

## SYNTAX

### ByConnectionString (Default)
```
Invoke-MySQLQuery -Query <String> -ConnectionString <String> [<CommonParameters>]
```

### ByItems
```
Invoke-MySQLQuery -Query <String> -MySQLUsername <String> -MySQLPassword <SecureString> -MySQLDatabase <String>
 -MySQLServer <String> [<CommonParameters>]
```

## DESCRIPTION
Executes the Query.

## EXAMPLES

### EXAMPLE 1
```
Query the DB for rows of information and setting that as an Object.
```

$query = "select Testcase_name,Testcase_Status from test_cases"	
$MyConnectionString = "server=localhost;port=3306;uid=root;pwd=;database=summitrts" 
$Data = @(Invoke-MySQLQuery -Query $query -ConnectionString $MyConnectionString)

### EXAMPLE 2
```
Updating database row(s)
```

$query = "update test_cases set Testcase_name = '$somevalue' where testcase_id = 1"	
$MyConnectionString = "server=localhost;port=3306;uid=root;pwd=;database=summitrts"
Invoke-MySQLQuery -Query $query -ConnectionString $MyConnectionString

### EXAMPLE 3
```
Query the DB for rows of information and setting that as an Object.
```

$query = "select Testcase_name,Testcase_Status from test_cases"	
$Data = @(Invoke-MySQLQuery -Query $query -MySQLUsername root -MySQLPassword "" -MySQLDatabase summitrts -MySQLServer localhost)

### EXAMPLE 4
```
Updating database row(s)
```

$query = "update test_cases set Testcase_name = '$somevalue' where testcase_id = 1"	
Invoke-MySQLQuery -Query $query -MySQLUsername root -MySQLPassword "" -MySQLDatabase summitrts -MySQLServer localhost

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
A valid MySQL connection String is required.

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
No additional notes.

## RELATED LINKS
