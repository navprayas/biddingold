<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<spring:url value="/static/" var="static_url" />
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/report/observerSummary2" var="report_summary2_url" />
<spring:url value="/report/observerSummary1" var="report_summary1_url" />
<spring:url value="/report/observerBidderWise" var="report_bidderwise_url" />
<spring:url value="/report/observerSummary2/find/excel" var="excelURL"/>
<spring:url value="/report/observerSummary1/LotsStatus/List" var="lots_url" />

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script language="JavaScript"> 
	function onSubmit(){			
		document.dateForm.action="${form_url}";
		return validate();
	}
	
	function onSubmitExcel(){
		document.dateForm.action="${excelURL}";
		document.dateForm.submit();
		
		//return validate();
	}
	function validate(){
		var status = true;	
		var fromDate = document.getElementById("dateFrom").value;
		var toDate = document.getElementById("dateTo").value;
		
		if(fromDate == null || fromDate == ''){
			alert("From Date cannot be empty");		
			return false;
		}else if(toDate == null || toDate == ''){
			alert("To Date cannot be empty");		
			return false;
		}else{
			//DATE COMPARISON		
		    var mon1  = parseInt(fromDate.substring(0,2),10);
		    var dt1 = parseInt(fromDate.substring(3,5),10);
		    var yr1  = parseInt(fromDate.substring(6,10),10);
		    
		    var mon2  = parseInt(toDate.substring(0,2),10);
		    var dt2 = parseInt(toDate.substring(3,5),10);
		    var yr2  = parseInt(toDate.substring(6,10),10);

		    var date1=new Date(dt1,mon1-1,yr1);
		    var date2=new Date(dt2,mon2-1,yr2);

		   // var date1 = new Date(yr1, mon1-1, dt1);	    
		   // var date2 = new Date(yr2, mon2-1, dt2);	  
		    if(date2 < date1)
		    {
		    	alert("From Date cannot be greater than To Date");			
				return false;
		    }
		} 	
		return status;
	}
	function getResultForCategory(categoryId)
	{		
		document.dateForm.categoryId.value = categoryId;
		document.dateForm.action="${categoryUrl}";
		document.dateForm.submit();
	}	


	function getResultForLotStatus(lotsStat)
	{
		
		document.dateForm.lotsStatus.value = lotsStat;
		var index = document.getElementById("category").selectedIndex;
		
		var itemName = document.getElementById("category").options[index].value;
		
		document.dateForm.categoryId.value = itemName;
		
		document.dateForm.action="${lots_url}";
		 document.dateForm.submit();
		/* if(validate()){
			 alert("After Validation");
			 document.dateForm.submit();
		 }*/
		
		return false;
	}	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL Auction</title>
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<link type="text/css" href="${css_url}/jquery-ui-1.8.11.custom.css" rel="stylesheet" />	
<link type="text/css" rel="stylesheet" href="${css_url}/dhtmlgoodies_calendar.css?random=20051112" media="screen"/>
<script type="text/javascript" src="${js_url}/dhtmlgoodies_calendar.js?random=20060118"></script>
<script type="text/javascript" src="${js_url}/tooltip.js"></script>
<script type="text/javascript" src="${js_url}/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${js_url}/jquery-ui-1.8.11.custom.min.js"></script>
<script type="text/javascript">
			$(function(){
				// Dialog			
				
			
				$('.partici').dialog({
					autoOpen: false,
					width:'auto',
				});
				
				
				
				$('.change').dialog({
					autoOpen: false,
					width:'auto',
					height:110,
				});
				
				
				
				
				$('.partcipents').click(function(){
				
					$('.partici').dialog('open');
					return false;
				});
				$('.changepass').click(function(){
				
					$('.change').dialog('open');
					return false;
				});
				
				
			
				
			});
		</script>
		<script type="text/javascript">
	
	$(function() {
		
		
		
		$(".partici").dialog({
			bgiframe: false,
			modal: true,
			
		});
		$(".change").dialog({
			bgiframe: false,
			modal: true,
			
		});
			

	});
	
	

	</script>

</head>

<body>
<script type="text/javascript">
pathToImages = "${static_url}" + pathToImages;
</script>
<%@ include file="/WEB-INF/jsp/observer/observer_report_top.jsp" %>
<div class="Mian">
<div id="dhtmltooltip"></div>
<script type="text/javascript">

/***********************************************
* Cool DHTML tooltip script- © Dynamic Drive DHTML code library (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit Dynamic Drive at http://www.dynamicdrive.com/ for full source code
***********************************************/

var offsetxpoint=0 //Customize x offset of tooltip
var offsetypoint=20 //Customize y offset of tooltip
var ie=document.all
var ns6=document.getElementById && !document.all
var enabletip=false
if (ie||ns6)
var tipobj=document.all? document.all["dhtmltooltip"] : document.getElementById? document.getElementById("dhtmltooltip") : ""

function ietruebody(){
return (document.compatMode && document.compatMode!="BackCompat")? document.documentElement : document.body
}

function ddrivetip(thetext, thecolor, thewidth){
if (ns6||ie){
if (typeof thewidth!="undefined") tipobj.style.width=thewidth+"px"
if (typeof thecolor!="undefined" && thecolor!="") tipobj.style.backgroundColor=thecolor
tipobj.innerHTML=thetext
enabletip=true
return false
}
}

function positiontip(e){
if (enabletip){
var curX=(ns6)?e.pageX : event.clientX+ietruebody().scrollLeft;
var curY=(ns6)?e.pageY : event.clientY+ietruebody().scrollTop;
//Find out how close the mouse is to the corner of the window
var rightedge=ie&&!window.opera? ietruebody().clientWidth-event.clientX-offsetxpoint : window.innerWidth-e.clientX-offsetxpoint-20
var bottomedge=ie&&!window.opera? ietruebody().clientHeight-event.clientY-offsetypoint : window.innerHeight-e.clientY-offsetypoint-20

var leftedge=(offsetxpoint<0)? offsetxpoint*(-1) : -1000

//if the horizontal distance isn't enough to accomodate the width of the context menu
if (rightedge<tipobj.offsetWidth)
//move the horizontal position of the menu to the left by it's width
tipobj.style.left=ie? ietruebody().scrollLeft+event.clientX-tipobj.offsetWidth+"px" : window.pageXOffset+e.clientX-tipobj.offsetWidth+"px"
else if (curX<leftedge)
tipobj.style.left="5px"
else
//position the horizontal position of the menu where the mouse is positioned
tipobj.style.left=curX+offsetxpoint+"px"

//same concept with the vertical position
if (bottomedge<tipobj.offsetHeight)
tipobj.style.top=ie? ietruebody().scrollTop+event.clientY-tipobj.offsetHeight-offsetypoint+"px" : window.pageYOffset+e.clientY-tipobj.offsetHeight-offsetypoint+"px"
else
tipobj.style.top=curY+offsetypoint+"px"
tipobj.style.visibility="visible"
}
}

function hideddrivetip(){
if (ns6||ie){
enabletip=false
tipobj.style.visibility="hidden"
tipobj.style.left="-1000px"
tipobj.style.backgroundColor=''
tipobj.style.width=''
}
}

document.onmousemove=positiontip

</script>

<!--observer_top.html--><!--observer_top.html Ends-->	

<div class="summeryDiv">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr style="font:bold 14px Arial, Helvetica, sans-serif; color:#fff;">
        <td width="9%" height="29" align="center" bgcolor="#4A82BD"><a href="${report_summary1_url}" class="SummeryLink" onmouseover="ddrivetip('Summary 1','', 'auto')"; onmouseout="hideddrivetip()">Summary 1</a></td>
        <td width="9%" align="center" bgcolor="#9CBA5A" style="border-left:1px solid #fff; border-right:1px solid #fff;" ><a href="${report_summary2_url}" onmouseover="ddrivetip('Summary 2','', 'auto')"; onmouseout="hideddrivetip()" class="SummeryLink">Summary 2</a></td>
        <td width="9%" align="center" bgcolor="#4A82BD"><a href="${report_bidderwise_url}" onmouseover="ddrivetip('Bidder wise','', 'auto')"; onmouseout="hideddrivetip()" class="SummeryLink">Bidder wise</a></td>
        <td width="58%">&nbsp;</td>
        <td width="15%"><a href="#"  class="ui-state-default ui-corner-all" onclick="javascript:onSubmitExcel();">Export to Excel</a>
              <a href="#"  class="ui-state-default ui-corner-all">Print</a></td>
      </tr>
    </table>
  </div>
   <form action="${form_url}" method="post" modelAttribute="reportVO" name="dateForm">
  <div class="CheckBoxMenu">
   
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="8%" height="29" align="left" valign="middle">Select Date From </td>
          <td width="12%" align="left" valign="middle"><input type="text" id="dateFrom" value="<c:out value='${dateFromStr}'/>" readonly="readonly" name="paramDateFrom" onclick="displayCalendar(document.dateForm.dateFrom,'dd/mm/yyyy',this)" /></td>
          <td width="2%" align="left" valign="middle">to</td>
          <td width="78%" align="left" valign="middle"><input type="text"   id="dateTo" value="<c:out value='${dateToStr}' />" readonly="readonly" name="paramDateTo" onclick="displayCalendar(document.dateForm.dateTo,'dd/mm/yyyy',this)" />
              <input type="submit" name="Submit" value="Go" onclick= "return onSubmit();" /></td>
        </tr>
      </table>
    
  </div>
  </form>
  <div class="DetailDiv">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="4%" height="40" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td width="4%" colspan="2" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Total for Sales','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Total for Sales</a></td>
        <td width="4%" colspan="3" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Actual Sold','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Actual Sold</a></td>
        <td width="10%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Average Amt','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Average Amt per ton </a></td>
        <td width="8%" colspan="2" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Unsold (Bidded)','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Unsold (Bidded)</a></td>
        <td colspan="2" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Unsold (Non-bidded)','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Unsold (Non- Bidded)</a></td>
      </tr>
      <tr>
        <td width="4%" height="40" align="center" valign="middle" bgcolor="#4f81bc" class="SecDivBorder">&nbsp;</td>
        <td width="4%" align="center" valign="middle" bgcolor="#4f81bc" class="SecDivBorder"><a href="#" onmouseover="ddrivetip('Lots No','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Lots (No)</a></td>
        <td width="2%" align="center" valign="middle" bgcolor="#4f81bc" class="SecDivBorder"><a href="#" onmouseover="ddrivetip('Qty','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Qty</a></td>
        <td width="4%" align="center" valign="middle" bgcolor="#4f81bc" class="SecDivBorder"><a href="#" onmouseover="ddrivetip('Lots No','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Lots (No)</a></td>
        <td width="1%" align="center" valign="middle" bgcolor="#4f81bc" class="SecDivBorder"><a href="#" onmouseover="ddrivetip('Qty','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Qty</a></td>
        <td width="1%" align="center" valign="middle" bgcolor="#4f81bc" class="SecDivBorder"><a href="#" onmouseover="ddrivetip('Amount','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Amoun</a>t</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="SecDivBorder"><a href="#" onmouseover="ddrivetip('Average Amt','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">(Actual Sold Amt/ Actual Sold Qty)</a></td>
        <td width="8%" align="center" valign="middle" bgcolor="#4f81bc" class="SecDivBorder"><a href="#" onmouseover="ddrivetip('Lots No','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Lots (No)</a></td>
        <td width="4%" align="center" valign="middle" bgcolor="#4f81bc" class="SecDivBorder"><a href="#" onmouseover="ddrivetip('Qty','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Qty</a></td>
        <td width="5%" align="center" valign="middle" bgcolor="#4f81bc" class="SecDivBorder"><a href="#" onmouseover="ddrivetip('Lots No','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Lots (No)</a></td>
        <td width="1%" align="center" valign="middle" bgcolor="#4f81bc" class="SecDivBorder"><a href="#" onmouseover="ddrivetip('Qty','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Qty</a></td>
      </tr>
      <c:forEach items="${reportSummary2List}" var="reportSummary2" varStatus="status">
      <tr  class="table">
	    <td height="40" align="center" valign="middle" bgcolor="#4A82BD" class="WhiteBorder">${reportSummary2.categoryName}</td>
        <td height="40" align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">${reportSummary2.totalLotsForSale}</td>
        <td height="40" align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">${reportSummary2.totalLotsquantityForSale}</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">${reportSummary2.totalActualSoldLots}</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">${reportSummary2.totalActualSoldQunatity}</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">${reportSummary2.totalActualSoldAmount}</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">${reportSummary2.avergeAmount}</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">${reportSummary2.totalUnsoldBiddedLots}</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">${reportSummary2.totalUnsoldBiddedQuantity}</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">${reportSummary2.totalUnsoldUnBiddedLots}</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">${reportSummary2.totalUnsoldUnBiddedQuantity}</td>
      </tr>
      </c:forEach>
     
       <tr class="table">
        <td height="40" align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight"><strong>TOTAL</strong></td>
        <td height="40" align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight"><strong>${totalReportSummary2.grandTotalLotsForSale}</strong></td>
        <td height="40" align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight"><strong>${totalReportSummary2.grandTotalLotsquantityForSale}</strong></td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight"><strong>${totalReportSummary2.grandTotalActualSoldLots}</strong></td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight"><strong>${totalReportSummary2.grandTotalActualSoldQunatity}</strong></td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight"><strong>${totalReportSummary2.grandTotalActualSoldAmount}</strong></td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight"><strong>${totalReportSummary2.avergeTotalAmount}</strong></td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight"><strong>${totalReportSummary2.grandTUnsoldUnBiddedLots}</strong></td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight"><strong>${totalReportSummary2.grandTotalUnsoldUnBiddedQuantity}</strong></td>
      </tr>
     
    </table>
  </div>
<%@ include file="/WEB-INF/jsp/observer/observer_footer.jsp" %>
    <div class="clr"></div>
</div>
</body>
</html>
