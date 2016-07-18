<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestPage.aspx.cs" Inherits="WingtipToys.SamplePages.TestPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <script src="/Scripts/EventHub.js/EventHub.js" type="text/javascript" defer="defer"></script>
</head>
<body>
    <!--Event hub data-->
    <button class="btn btn-default" id="b" onclick="SAS.updateThenOnLoadEnd(function() { document.getElementById('my_sas').innerHTML = SAS.sas; });">Update SAS</button>
    <!--Update SAS-->
    <button class="btn btn-default" onclick="document.getElementById('my_sas').innerHTML = SAS.get();">Get SAS</button>
    <p id="my_sas"></p>
    <!--User Data to Event Hub-->
    <button class="btn btn-default" onclick="eventHub.sendObject(document.getElementById('message').value);">Send data</button>
    <input id="message" type="text" name="textToSend" value="text">
    <p id="event_hub"></p>
    <!--ClickEvent on a Link-->
    <br><a onclick="sendClick(this);" href="#b">Click Event</a>
    <p id="clickEvent"></p>
    <!--The purchase form.-->
    <form id="purchaseForm" onsubmit="sendPurchase(this);">
        Email:
        <input type="email" name="Email"><br>
        <!--Purchase Event Stuff-->
        ProductId:
        <input type="number" name="ProductId"><br>
        Price:
        <input type="number" name="Price"><br>
        Quantity:
        <input type="number" name="Quantity"><br>
        Time:
        <input type="datetime" name="Time"><br>
        <button class="btn btn-default" type="button" name="purchase">Purchase Event</button>
        <input class="btn btn-default" type="submit">
    </form>
    <p id="purchaseEvent"></p>
    <!--PurchaseEvent from a form.-->
    <h2 id="links">More links that generate events.</h2>
    <a href="#links1">Link1</a>
    <a href="#links2">Link2</a>
    <a href="#links3">Link3</a>
    <a href="#links4">Link4</a>
</body>

</html>
