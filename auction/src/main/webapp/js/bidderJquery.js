
			$(function(){
				// Dialog			
				
				$('.desc').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.bids').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.removediv').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.change').dialog({
					autoOpen: false,
					width:'auto',
					height:110,
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
			
				
				// Dialog Link
				
				$('.description').click(function(){
				
				//	$('.desc').dialog('open');
					$('#dialog_'+$(this).attr('id')).dialog('open');
					return false;
				});
				$('.autobid').click(function(){

					$('#dialog_'+$(this).attr('id')).dialog('open');
					//$('.bids').dialog('open');
					return false;
				});
				$('.remove').click(function(){
				
					//$('.removediv').dialog('open');
					$('#dialog_'+$(this).attr('id')).dialog('open');
					return false;
				});
				$('.changepass').click(function(){
				
					$('.change').dialog('open');
					return false;
				});
				$('.history').click(function(){
				
					$('.bidhistory').dialog('open');
					return false;
				});
				$('.detail').click(function(){
					if(document.getElementById("bidItemIdVal")){
						var bidItemId = document.getElementById("bidItemIdVal").value;
						if(bidItemId=="" || bidItemId.length < 1) {
							alert("Please first select the Material name for getting detail for that");
							return false;
						}							
					}
					$('.biddetail').dialog('open');
					return false;
				});
			
				
			});
			$(function() {
				$(".desc").dialog({
					bgiframe: false,
					modal: true,
					
				});
			
			
				$(".bids").dialog({
					bgiframe: false,
					modal: true,
					
				});
			
			
				$(".removediv").dialog({
					bgiframe: false,
					modal: true,
					});
				$(".change").dialog({
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
			});



