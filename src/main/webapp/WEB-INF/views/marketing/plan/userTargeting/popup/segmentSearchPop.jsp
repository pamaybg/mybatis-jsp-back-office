<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var segmentPopGrid; 

function segmentPopGrid(){
	var jqGridOption = {
		/* ondblClickRow : function (data) {	
			if(typeof(quickFlag) != "undefined" && quickFlag != null){
				
				//캠페인 연결 여부 조회
				   	$.ifvPostJSON('<ifvm:action name="targetLoadCheck"/>',{segId : data.segId}
					,function(result) {
						
				   		if(result.message != null && result.message.length > 0){
				   			
				   			targetLevelId = data.targetLevelId;
							confilterid = data.segId;
							
				   			//세그먼트 명 조회 팝업
				   			$("#segmentPopupCon").ejDialog({
				   				enableModal : true,
				   		        enableResize: false,
				   		        contentUrl: '<ifvm:url name="segmentNewNamePop"/>',
				   		        contentType: "ajax",
				   		        title: '<spring:message code="M00666"/>',
				   		        width: 400,
				   		        close : 'segmentPopupClose'
				   		    });
				   			
				   			segmentPopupCon = $("#segmentPopupCon").data("ejDialog");
				   			
				   			userMainPopClose();
				   			
				   		}
				   		else{
				   			
				   			//세그먼트 이동
				   			var obj = $.ifvCachedHtml('<ifvm:url name="userTargetingLoad"/>');
							$('#segmentContent').html(obj.responseText);
							loadUiSetting();
							targetLevelId = data.targetLevelId;
							confilterid = data.segId;
							userMainPopClose();
							init();
				   		}
				   		
					}); 
				
			}
			else{//fatigueSearchResult.getRowData()[data-1].id
				//qtjs.href('<ifvm:url name="userTargeting"/>?id='+ data.segId + "&targetLevelId=" + data.targetLevelId);
				qtjs.href('<ifvm:url name="userTargeting"/>?id='+ segmentPopGrid.getRowData()[data-1].segId);
						+ "&targetLevelId=" +segmentPopGrid.getRowData()[data-1].targetLevelId;
			}
			
		}, */
		serializeGridData : function( data ){
			
		},			
		loadComplete : function(obj){
			new ifvm.PopupHeight({
				popupDivId : 'userMainPop',	//팝업 부르는 div id (부모 jsp)
				contentsId : 'segmentSearchPop'	//popup을 전체 감싸는 id (popup jsp)
			});
			
			new ifvm.PopupCenter({
                popupDivId : 'userMainPop'
            });
		},
		
	    url:'<ifvm:action name="getSegmentList2"/>',
	    colNames:['<spring:message code="M01226"/>',
	              '<spring:message code="M01227"/>',
	              '<spring:message code="M01228"/>',
	              'segId',
	              'targetLevelId'],
	    colModel:[
	        {name:'segNm',index:'seg_nm', resizable : false},
	        {name:'empName',index:'em.name', resizable : false},
	        {name:'createDate',index:'ms.create_date', resizable : false, align: "center"
	        	, formatter: "date", formatoptions: { newformat: "Y-m-d H:i:s" }
	        },
	        {name:'segId',index:'ms.id', hidden : true ,resizable : false},
	        {name:'targetLevelId',index:'ms.target_level_id', hidden : true ,resizable : false}
	    ],
	    radio:true,
	    sortname: 'ms.create_date',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete'
	};
	segmentPopGrid = $("#segmentPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function(){
	segmentPopGrid();
	
	//세그먼트 선택 버튼
	$("#segmentSelectBtn").on("click",function(){
		var dataArr = segmentPopGrid.getCheckedList();
		var getSegId = dataArr[0].segId;
		var getTargetLevelId = dataArr[0].targetLevelId;
		
		if(segmentPopGrid.getCheckedList() == ''){
			alert('<spring:message code="M00285"/>');
		}
		else{	
			if(typeof(quickFlag) != "undefined" && quickFlag != null){
				
				//캠페인 연결 여부 조회
				   	$.ifvPostJSON('<ifvm:action name="targetLoadCheck"/>',{segId : getSegId}
					,function(result) {
						
				   		if(result.message != null && result.message.length > 0){
				   			
				   			targetLevelId = getTargetLevelId;
							confilterid = getSegId;
							
							//팝업 분기
							newSegFlag = true;
							
				   			//세그먼트 명 조회 팝업
				   			$("#segmentPopupCon").ejDialog({
				   				enableModal : true,
				   		        enableResize: false,
				   		        contentUrl: '<ifvm:url name="segmentNewNamePop"/>',
				   		        contentType: "ajax",
				   		        title: '<spring:message code="M00666"/>',
				   		        width: 400,
				   		        close : 'segmentPopupClose'
				   		    });
				   			
				   			segmentPopupCon = $("#segmentPopupCon").data("ejDialog");
				   			
				   			userMainPopClose();
				   			
				   		}
				   		else{
				   			
				   			//세그먼트 이동
				   			var obj = $.ifvCachedHtml('<ifvm:url name="userTargetingLoad"/>');
							$('#segmentContent').html(obj.responseText);
							loadUiSetting();
							targetLevelId = getTargetLevelId;
							confilterid = getSegId;
							userMainPopClose();
							init();
				   		}
				   		
					}); 
				
			}
			else{
				
				
				
				
				//2016-01-22 장용 추가 - 캠페인이 연결되있을 경우 새로운 세그먼트를 복사해서 들어가도록 변경
				//캠페인 연결 여부 조회
			   	$.ifvPostJSON('<ifvm:action name="targetLoadCheck"/>',{segId : getSegId}
				,function(result) {
					
			   		if(result.message != null && result.message.length > 0){
			   			
			   			targetLevelId = getTargetLevelId;
						confilterid = getSegId;
						
						//팝업 분기
						newSegFlag = true;
						
			   			//세그먼트 명 조회 팝업
			   			$("#segmentPopupCon").ejDialog({
			   				enableModal : true,
			   		        enableResize: false,
			   		        contentUrl: '<ifvm:url name="segmentNewNamePop"/>',
			   		        contentType: "ajax",
			   		        title: '<spring:message code="M00666"/>',
			   		        width: 400,
			   		        close : 'segmentPopupClose'
			   		    });
			   			
			   			segmentPopupCon = $("#segmentPopupCon").data("ejDialog");
			   			
			   			userMainPopClose();
			   			
			   		}
			   		else{
			   			
			   			qtjs.href('<ifvm:url name="userTargeting"/>?id='+ getSegId + "&targetLevelId=" +getTargetLevelId);
			   		}
			   		
				}); 
				
				
				
				
				
				
				
			}	
	}
		
	}); 
	$("#segmentCancelBtn").on("click", function(){
		userMainPopClose();
	});
	
});
</script>


<div id="segmentSearchPop">
	<div class="pop_inner_wrap">
		<div id="segmentPopGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="segmentSelectBtn">  
			<i class="glyphicon glyphicon-check"></i>       
			<spring:message code="M00282"/>
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="segmentCancelBtn">         
			<spring:message code="M00284"/>
		</button>
	</div> 
</div>