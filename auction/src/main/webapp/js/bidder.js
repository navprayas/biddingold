

	function onSubmit(pageNo) {
		document.paginationForm.category.value = document.forms["categoryform"].category.value;
		document.paginationForm.page.value=pageNo;
		document.paginationForm.submit();
	}
		
	function setPreferenceDisplay(bidId)
	{
		blah(document.getElementById("itemRow"+bidId));
	}

  	function display( notifier, str ) {
    	document.getElementById(notifier).innerHTML = str;
  	}
	
  	function toHourAndMinuteAndSecond( x ) {
    	return Math.floor(x/3600) + ":" + Math.floor((x%3600)/60) + ":" + x%60;
  	}
	
	var timeSpans = new Array();
  	var bidItemIds = new Array();
  	
  	function setTimeLefts( remain, bidItemId) {
		timeSpans.push(remain);
		bidItemIds.push(bidItemId);
  	}

  	function displayTimes()	{
  		var extendTime = document.getElementById("extn").value;
 		var count = document.getElementById("lLCount").value;
  		if(count > 5) { return false; }
   		for(i = 0; i < bidItemIds.length; i++) {
  			ts = timeSpans[i];
  			ex = parseInt(extendTime);
  			diff = 0;
  			if(i == 0 && ex > 0) {
  				diff = ex - ts;
  				if(diff < 0) diff = 0;
   				timeSpans[0] = ex;
  			}
  			else {
  				timeSpans[i] += diff;
  			}
  			
  			if(timeSpans[i] <= 0) {
  				refreshPage();
  			}
  			else {
  				document.getElementById("countdown"+bidItemIds[i]).innerHTML = toHourAndMinuteAndSecond(timeSpans[i]);
  	  			timeSpans[i] -= 1;
  			}
  		}
  		document.getElementById("extn").value = 0;
  		setTimeout("displayTimes()",1000);
  	}

  	function refreshPage() {
  		var count = document.getElementById("lLCount").value;
  		var timee = document.getElementById("lLTime").value;
  		var currentTime = new Date();
  		diff = currentTime.getTime() - parseInt(timee);
  		if(diff < 15000) {
  			document.getElementById("lLCount").value = parseInt(count) + 1;
  			document.getElementById("lLTime").value = currentTime.getTime();
  			return false;
  		}
  		document.getElementById("lLTime").value = currentTime.getTime();
  		window.location.reload(true); 
  	}
  
  	function getResultForCategory()
  	{
  		document.forms["categoryform"].submit();
  	}
  	function getPageForMarketType(marketType)
  	{
  		var location1 = ""
  		if(marketType == "1")
  			location1 = "${bidder_home_url}/marketlist";
  		else if(marketType == "2")
  			location1 = "${bidder_home_url}/active";
  		else if(marketType == "3")
  			location1 = "${bidder_home_url}/closed";		
  		window.location.href=location1
  	}
  	
  	window.onload = function() {
  		
  	}
  	
  	function blah( oCB )
  	{    for( oElem = oCB; oElem.tagName!= "TR"; oElem = oElem.parentNode );
  	    oElem.className = oCB.checked? "selected": "table";
  	}

//Active Specific
  	
  	function changeStyleSelectedHover()
  	{
  		if(document.getElementById("ranktd"))
  		{
  			document.getElementById("ranktd").style.background = "#d2e4b0";
  		}
  		if(document.getElementById("currentpricetd"))
  		{
  		document.getElementById("currentpricetd").style.background = "#d2e4b0";
  		}
  	}
  	
  	function changeStyleSelectedOut()
  	{
  		if(document.getElementById("ranktd"))
  		{
  			document.getElementById("ranktd").style.background = "#eaedf4";
  		}
  		if(document.getElementById("currentpricetd"))
  		{
  		document.getElementById("currentpricetd").style.background = "#eaedf4";
  		}
  	}
  	
  	function setNextBidDisabled(nextBidButton)
  	{
  		if(document.getElementById(nextBidButton))
  			{
  			document.getElementById(nextBidButton).disabled = true;
  			document.getElementById(nextBidButton).style.color = "#C0BFBF";
  			}
  	}
  	
  	
  	
  	
  	
  	
  	