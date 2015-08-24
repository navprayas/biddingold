<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<spring:url value="/static/" var="static_url" />
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />


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
	var DateDiff = {
			 
		    inDays: function(d1, d2) {
		        var t2 = d2.getTime();
		        var t1 = d1.getTime();
		 
		        return parseInt((t2-t1)/(24*3600*1000));
		    },
		 
		    inWeeks: function(d1, d2) {
		        var t2 = d2.getTime();
		        var t1 = d1.getTime();
		 
		        return parseInt((t2-t1)/(24*3600*1000*7));
		    },
		 
		    inMonths: function(d1, d2) {
		        var d1Y = d1.getFullYear();
		        var d2Y = d2.getFullYear();
		        var d1M = d1.getMonth();
		        var d2M = d2.getMonth();
		 
		        return (d2M+12*d2Y)-(d1M+12*d1Y);
		    },
		 
		    inYears: function(d1, d2) {
		        return d2.getFullYear()-d1.getFullYear();
		    }
		};
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
		    var dt1  = parseInt(fromDate.substring(0,2),10);
		    var mon1 = parseInt(fromDate.substring(3,5),10);
		    var yr1  = parseInt(fromDate.substring(6,10),10);
		    
		    var dt2  = parseInt(toDate.substring(0,2),10);
		    var mon2 = parseInt(toDate.substring(3,5),10);
		    var yr2  = parseInt(toDate.substring(6,10),10);

		    var date1 = new Date(yr1, mon1-1, dt1);	    
		    var date2 = new Date(yr2, mon2-1, dt2);
		    
		    if(date2 < date1) 
		    {
		    	alert("From Date cannot be greater than To Date");			
				return false;
		    }
		    if(DateDiff.inDays(date1, date2) > 30) {
		    	alert("The date range can not be more than 30 days.");			
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
<title>MSL Auction-Bidder Summary</title>
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<link type="text/css" rel="stylesheet" href="${css_url}/dhtmlgoodies_calendar.css?random=20051112" media="screen"></link>
<script type="text/javascript" src="${js_url}/dhtmlgoodies_calendar.js?random=20060118"></script>
<link type="text/css" href="${css_url}/jquery-ui-1.8.11.custom.css" rel="stylesheet" />	
<script type="text/javascript" src="${js_url}/tooltip.js"></script>
<script type="text/javascript" src="${js_url}/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${js_url}/jquery-ui-1.8.11.custom.min.js"></script>
<script type="text/javascript">
			$(function(){
				// Dialog			
				
				$('.desc').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.partici').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.bidhistory').dialog({
					autoOpen: false,
					width:'auto',
					height:310,
				});
				$('.biddetail').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.textension').dialog({
					autoOpen: false,
					width:'auto',
					height:310,
				});
				$('.change').dialog({
					autoOpen: false,
					width:'auto',
					height:110,
				});
				
				
				$('.description').click(function(){
				
					//$('.desc').dialog('open');
					$('#dialog_'+$(this).attr('id')).dialog('open');
					return false;
				});
				
				
				
				$('.partcipents').click(function(){
				
					$('.partici').dialog('open');
					return false;
				});
				$('.history').click(function(){
				
					$('.bidhistory').dialog('open');
					return false;
				});
				$('.detail').click(function(){
				
					$('.biddetail').dialog('open');
					return false;
				});
				$('.time').click(function(){
				
					$('.textension').dialog('open');
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
		$(".desc").dialog({
			bgiframe: false,
			modal: true,
			
		});
		
		
		$(".partici").dialog({
			bgiframe: false,
			modal: true,
			
		});
			$(".bidhistory").dialog({
			bgiframe: false,
			modal: true,
			
		});


		$(".biddetail").dialog({
			bgiframe: false,
			modal: true,
			
		});
		$(".textension").dialog({
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
<%-- <%@ include file="/WEB-INF/jsp/observer/observer_report_top.jsp" %> --%>
<div class="Mian"><div id="dhtmltooltip"></div>
<script type="text/javascript">
pathToImages = "${static_url}" + pathToImages;
</script>
<!--observer_top.html--><!--observer_top.html Ends-->	
<form action="${form_url}" method="post" modelAttribute="reportVO" name="dateForm">
<div class="summeryDiv">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr style="font:bold 14px Arial, Helvetica, sans-serif; color:#fff;">
        <td width="9%" height="29" align="center" bgcolor="#9CBA5A"><a href="${report_summary1_url}" class="SummeryLink" onmouseover="ddrivetip('Summary 1','', 'auto')"; onmouseout="hideddrivetip()">Summary 1</a></td>
        <td width="9%" align="center" bgcolor="#4A82BD" style="border-left:1px solid #fff; border-right:1px solid #fff;" ><a href="#" onmouseover="ddrivetip('Coming Soon','', 'auto')"; onmouseout="hideddrivetip()" class="SummeryLink">Summary 2</a></td>
        <td width="9%" align="center" bgcolor="#4A82BD"><a href="#" class="SummeryLink" onmouseover="ddrivetip('Coming Soon','', 'auto')"; onmouseout="hideddrivetip()">Bidder wise</a></td>
        <td width="58%">&nbsp;</td>
        <td width="15%"><a href="#"  class="ui-state-default ui-corner-all" onclick="javascript:onSubmitExcel();">Export to Excel</a>
              <a href="#"  class="ui-state-default ui-corner-all">Print</a></td>
      </tr>
    </table>
  </div>
    <div class="CheckBoxMenu">
      <form style="margin:0px;">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="8%" height="29" align="left" valign="middle">Select Date From  </td>
            <td width="12%" align="left" valign="middle"><input type="text" id="dateFrom" value="<c:out value='${dateFromStr}' />" readonly name="paramDateFrom" onclick="displayCalendar(document.dateForm.dateFrom,'dd/mm/yyyy',this)"></td>
            <td width="2%" align="left" valign="middle">to</td>
            <td width="78%" align="left" valign="middle"><input type="text"  id="dateTo" value="<c:out value='${dateToStr}' />" readonly name="paramDateTo" onclick="displayCalendar(document.dateForm.dateTo,'dd/mm/yyyy',this)">
              <input type="hidden" name="categoryId" value=""/>
                <input type="hidden" name="lotsStatus" value=""/>
               <input type="submit" name="Submit" value="Go" onclick= "return onSubmit();" /></td>
          </tr>
        </table></form>
      
  </div>
  <div class="DetailDiv">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="3%" height="40" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Sr. no','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Sr. No.</a></td>
        <td width="4%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Lot No.','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Lot. No</a></td>
        <td width="6%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Description','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Description</a></td>
        <td width="10%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">
         <select name="category" id="category" onChange="getResultForCategory(this.value)">
	          <option value="0">All</option>
	         <c:forEach var="bidderCategory" items="${bidderCategoryList}">	
	         	<c:if test="${bidderCategory.bidderCategoryId.category.categoryId==categoryName}">           		
	               <option value="${bidderCategory.bidderCategoryId.category.categoryId}"  selected="selected">
	                 <c:out value="${bidderCategory.bidderCategoryId.category.categoryName}" />
	               </option>
	             </c:if>
	             <c:if test="${bidderCategory.bidderCategoryId.category.categoryId!=categoryName}">           		
	               <option value="${bidderCategory.bidderCategoryId.category.categoryId}" >
	                 <c:out value="${bidderCategory.bidderCategoryId.category.categoryName}" />
	               </option>
	             </c:if>
            </c:forEach>
        </select></td>
        <td width="9%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Material Name','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Material Name</a></td>
        <td width="4%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Remark','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Remark</a></td>
        <td width="6%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Length Range','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Length Range</a></td>
        <td width="8%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Actual Length (Approx)','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Actual Length<br /> 
        (Approx)</a></td>
        <td width="4%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Quantity','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Quantity</a></td>
        <td width="3%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Zone','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Zone</a></td>
        <td colspan="2" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('H1','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">H1</a></td>
        <td colspan="2" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('H2','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">H2</a></td>
        <td colspan="2" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('H3','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">H3</a></td>
        <td width="7%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Lots Status','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Lot's Status</a></td>
        <td width="5%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Sales Price','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Sales Price</a></td>
        <td width="5%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorLastTitle"> <a href="#" onmouseover="ddrivetip('Total Sales (Qty X Sales Price)','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Total Sales (Qty X  SalesPrice)</a></td>
      </tr>
       
      <tr>
        <td width="3%" height="40" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td width="4%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td width="6%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td width="10%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td width="9%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td width="4%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td width="6%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td width="8%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td width="4%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td width="3%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td width="5%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle" style="border-top:1px solid #fff;">Company Name</td>
        <td width="4%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle" style="border-top:1px solid #fff;">Bid Price</td>
        <td width="5%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle" style="border-top:1px solid #fff;">Company Name</td>
        <td width="4%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle" style="border-top:1px solid #fff;">Bid Price</td>
        <td width="5%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle" style="border-top:1px solid #fff;">Company Name</td>
        <td width="3%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle" style="border-top:1px solid #fff;">Bid Price</td>
        <td width="7%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">
          <select name="bidsStatus" id="bidsStatus" onchange="getResultForLotStatus(this.value)">
            <option value="0">All</option>
	          <c:forEach var="bidsStatus" items="${bidsStatusSet}">	
	         	<c:if test="${bidsStatus==bidsStat}">           		
	               <option value="${bidsStatus}"  selected="selected">
	                 <c:out value="${bidsStatus}" />
	               </option>
	             </c:if>
	             <c:if test="${bidsStatus!=bidsStat}">           		
	               <option value="${bidsStatus}" >
	                 <c:out value="${bidsStatus}" />
	               </option>
	             </c:if>
	         </c:forEach>
          </select>
         
		</td>
        <td width="5%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td width="5%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorLastTitle">&nbsp;</td>
      </tr>
        <c:forEach items="${BidsList}" var="bids" varStatus="status">
      <tr class="table">
        <td height="40" align="center" valign="middle" class="DetailBorRight">${bids.bidItem.serialNo}.</td>
         <c:forEach items="${bids.bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
		     <c:if test="${status2.index+1 == 1}">
        	  <td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lotNo}</td>
        	  </c:if>
          </c:forEach>
       
        <td align="center" valign="middle" class="DetailBorRight">
        <div id="dialog_desc${status.index+1}"  class="desc" title="Item Description" style="display:none;">

		<table width="700" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="left" valign="top" ><form name="form1" method="post" action="" style="margin:0px;">
      <table width="700" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="49" height="30" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Sr. No.</td>
          <td width="92" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Category</td>
          <td width="56" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Lot No. </td>
          <td width="131" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Material Name</td>
          <td width="64" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Remark</td>
          <td width="96" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Length Range</td>
          <td width="125" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Actual Length <br>
            (Approx)</td>
          <td width="87" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Qty</td>
          <td width="87" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Zone</td>
        </tr>
        <tr>
          <td width="49" height="30" align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${bids.bidItem.serialNo}.</td>
          <td width="92" align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${bids.bidItem.category.categoryName}</td>
          <c:forEach items="${bids.bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
		     <c:if test="${status2.index+1 == 1}">
        	  <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${itemLotUnique.lotNo}</td>
        	  </c:if>
          </c:forEach>
          
          <td width="131" align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${bids.bidItem.name}</td>
            <c:if test="${fn:length(bids.bidItem.itemLots) == 1}">
	          	<c:forEach items="${bids.bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
	          	 <td width="64" align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${itemLotUnique.remark}</td>
         		 <td width="96" align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${itemLotUnique.lengthRange}</td>
         		 <td width="125" align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${itemLotUnique.actualLengh}</td>
	          	</c:forEach>
	         </c:if>
           <c:if test="${fn:length(bids.bidItem.itemLots) > 1}">
           <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">&nbsp;</td>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">&nbsp;</td>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">&nbsp;</td>
          </c:if>
         
        <td width="87" align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${bids.bidItem.totalQuantity} ${bids.bidItem.unit}</td>
            <c:if test="${fn:length(bids.bidItem.itemLots) == 1}">
	          	<c:forEach items="${bids.bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
	          	  <td width="87" align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${bids.bidItem.zone}</td>
	          	</c:forEach>
	          	</c:if>
	           <c:if test="${fn:length(bids.bidItem.itemLots) > 1}">
                 <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">&nbsp;</td>
           </c:if>	
        </tr>
        
        <c:if test="${fn:length(bids.bidItem.itemLots) > 1}">
	   		<c:forEach items="${bids.bidItem.itemLots}" var="itemLot" varStatus="status1">
        <tr>
          <td height="30" align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${status1.index+1}. </td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${bids.bidItem.category.categoryName}</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${itemLot.lotNo}</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${itemLot.name}</td>
          
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${itemLot.remark}</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${itemLot.lengthRange}</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${itemLot.actualLengh}</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${itemLot.quantity} ${itemLot.unit}</td>
           <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${itemLot.zone}</td>
        </tr>
        </c:forEach>
        </c:if>
        
      </table>
        </form>    </td>
  </tr>
</table>
	</div>
        
        <input type="submit" name="button7" id="desc${status.index+1}" value="Desc" class="description ui-state-default ui-corner-all" /></td>
        <td align="center" valign="middle" class="DetailBorRight">${bids.bidItem.category.categoryName}</td>
        <td align="center" valign="middle" class="DetailBorRight"><a href="#" class="LinkSelected">${bids.bidItem.name}</a></td>
        <c:if test="${fn:length(bids.bidItem.itemLots) == 1}">
	     <c:forEach items="${bids.bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
	 
        <td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.remark}</td>
        <td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lengthRange}</td>
        <td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.actualLengh}</td>
        </c:forEach>
        </c:if>
        
        <c:if test="${fn:length(bids.bidItem.itemLots) > 1}"> 	 
	        <td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>
	        <td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>
	        <td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>       
        </c:if>
     
        
        <td align="center" valign="middle" class="DetailBorRight">${bids.bidItem.totalQuantity} ${bids.bidItem.unit}</td>
         <c:if test="${fn:length(bids.bidItem.itemLots) == 1}">
	      <c:forEach items="${bids.bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
	        <td align="center" valign="middle" class="DetailBorRight">${bids.bidItem.zone}</td>
          </c:forEach>
        </c:if>
          <c:if test="${fn:length(bids.bidItem.itemLots) > 1}"> 	 
	        <td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>
	        </c:if>
        <td align="center" valign="middle" class="DetailBorRight">${bids.bidderName}</td>
        <td align="center" valign="middle" class="DetailBorRight">${bids.bidAmount}</td>
        <td align="center" valign="middle" class="DetailBorRight">${bids.bidderName2}</td>
        <td align="center" valign="middle" class="DetailBorRight">${bids.bidAmount2}</td>
        <td align="center" valign="middle" class="DetailBorRight">${bids.bidderName3}</td>
        <td align="center" valign="middle" class="DetailBorRight">${bids.bidAmount3}</td>
        <td align="center" valign="middle" class="DetailBorRight">${bids.bidItem.isProcessed}</td>
        <td align="center" valign="middle" class="DetailBorRight"> 
        	<c:if test="${not empty bids.salesPrice}">  
        		${bids.bidItem.currency} ${bids.salesPrice} 
        	</c:if></td>
        <td align="center" class="DetailBorLast">
        <span class="DetailBorLast">
        	<c:if test="${not empty bids.totalSalesPrice}"> 
        		${bids.bidItem.currency} ${bids.totalSalesPrice}
        	</c:if></span></td>
      </tr>
   
    </c:forEach>
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td height="40" align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight"><strong>Total</strong></td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">${reportsTotal.totalQuantity} ${bids.bidItem.unit}</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">INR ${reportsTotal.totalBidAmount1}</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">INR ${reportsTotal.totalBidAmount2}</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">INR ${reportsTotal.totalBidAmount3}</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" bgcolor="#9CBA5A" class="DetailBorLast">INR ${reportsTotal.finalTotalSalesPrice}</td>
      </tr>
      
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td height="40" align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight"><strong>&nbsp;</strong></td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td align="center" bgcolor="#9CBA5A" class="DetailBorLast">&nbsp;</td>
      </tr>
    
    </table>
  </div>
  </form>
  <br/><br/>
  <div class="Spacer"></div>
  
 
  
  <!--observer_footer.html-->
  <!--observer_footer.html-->
<div class="Footer">&copy; Copyright 2011 Navprayas</div>
  <div class="clr"></div>
  
</div>
</body>
</html>
