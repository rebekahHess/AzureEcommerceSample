Param(
    [Parameter(Mandatory=$True)]
    [string]
    $resourceGroupName,
    # The location that the resources will be deployed.
    # Example: West US
    [Parameter(Mandatory=$True)]
    [string]
    $location
)
Login-AzureRmAccount
Get-AzureRmSubscription
Write-Host "Pick a subscription:" -ForegroundColor "Yellow" 
$id = [System.Console]::ReadLine()
Select-AzureRmSubscription -SubscriptionId $id

New-AzureRmResourceGroup -Name $resourceGroupName -Location $location
# make the sql server
New-AzureSqlDatabaseServer -Location $location
# Make all of the sql databases
    # Make the schema for each one
# Make the storaage accounts
# Make the Stream Analytics job
# Make the app service
    # Deploy web app to the site.

# TODO: Deploy the Event Hub
# TODO: Deploy the Stream analytics
# TODO: Connect services?
