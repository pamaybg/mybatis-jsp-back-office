<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page_btn_area">
    <div class="col-xs-5">
        <span><spring:message code="D00034" /></span>
    </div>
</div>
<div id="eventPartiGrid"></div>

<script>
var eventPartiGrid;

function eventParti_init(params) {
	makeEventPartiGrid();	
}

function makeEventPartiGrid() {
	var jqGridOption = {
			serializeGridData : function( data ){
				data.eventId = eventId
			},
			onSelectCell : function (data) {
			},
			loadComplete : function(obj){
				
				for(var i=0; i<obj.rows.length; i++){
					if(obj.rows[i].prizewinnerFlag == "Y"){
						$('tr#'+(i+1)).css('background-color', '#F3F781');
					}	
				}
			},
		    url: '<ifvm:action name="getEventParti"/>', 
		    colNames:['참여일',
		              '참여아이디', 
		              '참여회원명', 
		              '이벤트 참여이력', 
		              '<spring:message code="L00180" />',
		              '이벤트 당첨이력',
		              '당첨여부',
		              'rid'
		              ],
		              
		    colModel:[
		        {name:'partiDate',index:'partiDate', resizable : false, formatter:'date', formatoptions:{srcformat:"Y-m-d",newformat:"Y-m-d"}},
		        {name:'partiId',index:'partiId', resizable : false},
		        {name:'partiName',index:'partiName', resizable : false},
		        {name:'partiHistory',index:'partiHistory', resizable : false},
		        {name:'memberGrade',index:'memberGrade', resizable : false},
		        {name:'prizewinnerHistory',index:'prizewinnerHistory', resizable : false},
		        {name:'prizewinnerFlag',index:'prizewinnerFlag', align : 'center', resizable : false, 
		        	formatter:function(cellvalue, options, rowObject) {
						var iconLink = '';
						switch ( cellvalue ) {
							case 'Y' :
								iconLink = '<input type="checkbox" id="chk_info" name="'+rowObject.rid+'" value="1" checked="checked" onclick = updateWinnerFlag("'+rowObject.rid+'") >';
								break;
							case 'N' :
								iconLink = '<input type="checkbox" id="chk_info" name="'+rowObject.rid+'" value="1" onclick = updateWinnerFlag("'+rowObject.rid+'")>';
								break;
						}
						
						return iconLink;
					// 값 리턴시
					}, unformat: function(cellvalue, options, cell) {
						return $(cell).text();
					}
		        },
		        {name:'rid',index:'rid', resizable : false, hidden : true, searchable : false},
		    ],
		    autowidth:true,
		    sortname: 'partiDate',
			sortorder: "desc",
			tempId : 'ifvGridOriginTemplete'
	};
	eventPartiGrid = $('#eventPartiGrid').ifvGrid({jqGridOption : jqGridOption});
}

function updateWinnerFlag(rid){
	
	if($('[name ="'+rid+'"]:checked').val() == null){
		var check_yn = "N"
	}
	else{
		var check_yn = "Y"
	}
	$.ifvSyncPostJSON( '<ifvm:action name="updateWinnerFlag"/>',
			{
			 	eventId : eventId,
			 	event_mbr_id : rid,
			 	check_yn : check_yn
			},
			function(result) {
				 if(result.success == true){
					alert('<spring:message code="M00005"/>');
					makeEventPartiGrid();
					}
				else{
					alert('<spring:message code="M00029"/>');
					}
			}
		);	
}

$(document).ready(function(){
	makeEventPartiGrid();
});

</script>	