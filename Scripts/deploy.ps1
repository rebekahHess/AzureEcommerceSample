Param(
    [Parameter(Mandatory=$True)]
    [string]
    $ResourceGroupName,
    # The location that the resources will be deployed.
    # Example: West US
    [Parameter(Mandatory=$True)]
    [string]
    $Location,
    [Parameter(Mandatory=$True)]
    [string]
    $SqlServerName,
    [Parameter(Mandatory=$True)]
    [string]
    $SqlServerUserName,
    [Parameter(Mandatory=$True)]
    [string]
    $SqlServerPassword
)

Login-AzureRmAccount
Get-AzureRmSubscription
Write-Host "Enter a SubscriptionId:" -ForegroundColor "Yellow"  -NoNewline
$id = [System.Console]::ReadLine()
Select-AzureRmSubscription -SubscriptionId $id

$ResourceGroup = New-AzureRmResourceGroup -Name $ResourceGroupName -Location $Location
# make the sql server
Write-Host -ForegroundColor Yellow "Creating new sql server. Please wait..."
$SqlServer = New-AzureRmSqlServer -ResourceGroupName $ResourceGroupName -Location $Location -ServerName $SqlServerName
# Make all of the sql databases
$ClickDataRaw = New-AzureRmSqlDatabase -ResourceGroupName $ResourceGroupName -ServerName $SqlServerName -DatabaseName "ClickDataRaw"
$ProductContext = New-AzureRmSqlDatabase -ResourceGroupName $ResourceGroupName -ServerName $SqlServerName -DatabaseName "ProductContext"
$Recommendations = New-AzureRmSqlDatabase -ResourceGroupName $ResourceGroupName -ServerName $SqlServerName -DatabaseName "Recommendations"
$RecTest = New-AzureRmSqlDatabase -ResourceGroupName $ResourceGroupName -ServerName $SqlServerName -DatabaseName "RecTest"
$wingtiptoys = New-AzureRmSqlDatabase -ResourceGroupName $ResourceGroupName -ServerName $SqlServerName -DatabaseName "wingtiptoys"
# TODO: Can we make some schemas?
# Make the storaage accounts
$recommendationscache = New-AzureRmStorageAccount -ResourceGroupName $ResourceGroupName -Location "Central US" -Kind BlobStorage -SkuName Standard_RAGRS -AccessTier Hot -Name "recommendationscache$([System.Guid]::NewGuid())".Substring(0,24).Replace("-","e")
$ehreceiver = New-AzureRmStorageAccount -ResourceGroupName $ResourceGroupName -Location "Central US" -Kind BlobStorage -SkuName Standard_RAGRS -AccessTier Hot -Name "ehreceiver$([System.Guid]::NewGuid())".Substring(0,24).Replace("-","e")

### Create config files

## .\ConfigData\StreamAnalyticsInput_EventInput.json
# This is the event hub input. Currently, that is not created by this script.
#Out-File -FilePath .\ConfigData\StreamAnalyticsInput_EventInput.json -InputObject 

## .\ConfigData\StreamAnalyticsOutput_ClickOutput.json
Out-File -FilePath .\ConfigData\StreamAnalyticsOutput_ClickOutput.json -InputObject @"
{
  "Name": "ClickOutput",
  "Properties": {
    "DataSource": {
      "Properties": {
        "Database": "$($ClickDataRaw.DatabaseName)",
        "Server": "$($SqlServer.ServerName)",
        "Table": "ClickData",
        "User": "$($SqlServerUserName)",
        "Password": "$SqlServerPassword"
      },
      "Type": "Microsoft.Sql/Server/Database"
    },
    "Diagnostics": {
      "Conditions": []
    },
    "Etag": "a85cc30c-909d-4fb4-9203-8ce8a8d7d805",
    "Serialization": null
  }
}
"@

## .\ConfigData\StreamAnalyticsOutput_OrdersOutput.json
Out-File -FilePath .\ConfigData\StreamAnalyticsOutput_OrdersOutput.json -InputObject @"
{
  "Name": "OrdersOutput",
  "Properties": {
    "DataSource": {
      "Properties": {
        "Database": "$($ClickDataRaw.DatabaseName)",
        "Server": "$($SqlServer.ServerName)",
        "Table": "PurchaseDataRaw",
        "User": "$($SqlServerUserName)",
        "Password": "$SqlServerPassword"
      },
      "Type": "Microsoft.Sql/Server/Database"
    },
    "Diagnostics": {
      "Conditions": []
    },
    "Etag": "a85cc30c-909d-4fb4-9203-8ce8a8d7d805",
    "Serialization": null
  }
}
"@

## .\ConfigData\StreamAnalyticsOutput_OrdersOutputCache.json
Out-File -FilePath .\ConfigData\StreamAnalyticsOutput_OrdersOutputCache.json -InputObject @"
{
  "Name": "OrdersOutputCache",
  "Properties": {
    "DataSource": {
      "Properties": {
        "Database": "$($Recommendations.DatabaseName)",
        "Server": "$($SqlServer.ServerName)",
        "Table": "PurchaseDataCache",
        "User": "$($SqlServerUserName)",
        "Password": "$SqlServerPassword"
      },
      "Type": "Microsoft.Sql/Server/Database"
    },
    "Diagnostics": {
      "Conditions": []
    },
    "Etag": "a85cc30c-909d-4fb4-9203-8ce8a8d7d805",
    "Serialization": null
  }
}
"@

### Done creating config files

# Make the Stream Analytics job
$SAJobName = "EventProcessing"
New-AzureRmStreamAnalyticsJob -ResourceGroupName $resourceGroupName -Name $SAJobName -File .\ConfigData\StreamAnalyticsJob.json
#New-AzureRmStreamAnalyticsTransformation -ResourceGroupName $resourceGroupName -JobName $SAJobName -File .\ConfigData\StreamAnalyticsTransformation.json
#New-AzureRmStreamAnalyticsInput -ResourceGroupName $resourceGroupName -JobName $SAJobName  -Name EventInput        -File .\ConfigData\StreamAnalyticsInput_EventInput.json
New-AzureRmStreamAnalyticsOutput -ResourceGroupName $resourceGroupName -JobName $SAJobName -Name ClickOutput       -File .\ConfigData\StreamAnalyticsOutput_ClickOutput.json
New-AzureRmStreamAnalyticsOutput -ResourceGroupName $resourceGroupName -JobName $SAJobName -Name OrdersOutput      -File .\ConfigData\StreamAnalyticsOutput_OrdersOutput.json
New-AzureRmStreamAnalyticsOutput -ResourceGroupName $resourceGroupName -JobName $SAJobName -Name OrdersOutputCache -File .\ConfigData\StreamAnalyticsOutput_OrdersOutputCache.json

# Done with config files, deleting
Write-Host -ForegroundColor Red "Deleting temporary config files"
#rm .\ConfigData\StreamAnalyticsInput_EventInput.json
Remove-Item .\ConfigData\StreamAnalyticsOutput_ClickOutput.json
Remove-Item .\ConfigData\StreamAnalyticsOutput_OrdersOutput.json
Remove-Item .\ConfigData\StreamAnalyticsOutput_OrdersOutputCache.json

# TODO: Deploy the Event Hub
