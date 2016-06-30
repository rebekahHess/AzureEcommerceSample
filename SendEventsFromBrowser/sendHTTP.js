var my_sas = getSAS();

// Event Hubs parameters
var namespace = 'ServiceBusIntern2016';
var hubname ='sellersite';
var devicename = 'device-01';

// Payload to send
var payload = '{\"PrevUrl\":\"/products/6\",\"Nexturl\":\"/products/3\",...}';

function updateSAS() {
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.onreadystatechange = function() {
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
            document.getElementById("status").innerHTML = "Status 200 - OK";
            my_sas = xmlHttp.responseText;
            document.getElementById("my_sas").innerHTML = my_sas;
        }
    }
    
    xmlHttp.open("GET", "http://sasserver123456789.azurewebsites.net/SAS/", true); // true for asynchronous 

    // Set headers
    xmlHttp.setRequestHeader("Pragma", "no-cache");
    
    xmlHttp.send(null);
}

function getSAS() {
    var sasRequest = new XMLHttpRequest();
    sasRequest.open("GET", "http://sasserver123456789.azurewebsites.net/SAS/", false); 

    // Make sure we get a new SAS key.
    sasRequest.setRequestHeader("Pragma", "no-cache");

    sasRequest.send(null);

    return sasRequest.responseText;
}

function sendToEventHubExample() {
    sendToEventHub(document.getElementsByName("txtJob")[0].value);    
}

function sendToEventHub(data) {
    // Send a post
    var eh = new XMLHttpRequest();
    eh.onreadystatechange = function() {
        document.getElementById("event_hub").innerHTML = eh.responseText;
        if (eh.status == 201) {
            console.log("Status 201 - Success");
        } else {
            console.log("Status " + eh.status);
        }
    }
    var eventHubUrl = 'https://' + namespace + '.servicebus.windows.net:443/'
        + hubname + '/publishers/' + devicename + '/messages';
    eh.open("POST", eventHubUrl, true);
    eh.setRequestHeader("Authorization", my_sas);
    eh.setRequestHeader("Content-Length", payload.length);
    eh.setRequestHeader("Content-Type", "application/atom+xml;type=entry;charset=utf-8");
    eh.send(JSON.stringify(data));    
}

var entryTime = Date.now();
function clickEvent(nextUrl) {
    var click = {
        PrevUrl: window.location.href,
        NextUrl: nextUrl,
        EntryTime: entryTime,
        ExitTime: Date.now(),
        
        // User
        Email: "jon@example.com",
        // Session Id
        SessionId: "1",
    }

    return click;
}

function purchaseEvent() {
    var purchase = {
        ProductId: 1,
        Price: 250,
        Quantity: 1,
        Time: Date.now(),
        
        // User
        Email: "jon@example.com",
        // Session Id
        SessionId: "1",
    }

    return purchase;
}

window.onload = function() {
    document.getElementById("messageToSend").setAttribute("value", payload);
}


function updateId(id, value) {
    document.getElementById(id).innerHTML = value;
}
