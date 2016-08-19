# Login to azure and select the subscription to use.
Login-AzureRmAccount
Get-AzureRmSubscription
# Select the id from the list you want
Write-Output "Enter the SubscriptionId you would like to use: "
$id = [System.Console]::ReadLine()
Select-AzureRmSubscription -SubscriptionId $id
