<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

$.ifvmLnbSetting('responseInfoListNew');

var responseInfoSearchResult;
var parId = null;
var requestitem = [];

//조회결과 그리드
function responseInfoSearchResultList(){
	var jqGridOption = {
		serializeGridData : function( data ){
	 		if(requestitem != null && requestitem.length > 0){
				data.item = requestitem;
			}
			return data; 
		},
		ondblClickRow : function (data) {
			qtjs.href('<ifvm:url name="responseInfoDetail"/>?id='+responseInfoSearchResult.getRowData()[data-1].id);
		},
		loadComplete : function(obj){
			
		},
	    url: '<ifvm:action name="getResponseInfoList"/>', 
	    colNames:['<spring:message code="M01259"/>',
	              '<spring:message code="M01260"/>', 
	              '<spring:message code="M01261"/>', 
	              '<spring:message code="M01262"/>', 
	              '<spring:message code="M01263"/>',
	              '<spring:message code="M01264"/>',
	              'id'
	              ], 
	    colModel:[
	        {name:'camRspnsCd',index:'mrim.cam_rspns_cd', resizable : false ,searchable : true},
	        {name:'camRspnsNm',index:'mrim.cam_rspns_nm', resizable : false,searchable : true},
	        {name:'spcfChnlRspnsCd',index:'c1.mark_name', resizable : false,searchable : true},
	        {name:'dpSeq',index:'mrim.dp_seq', resizable : false,searchable : true},
	        {name:'parRspnsCd',index:'tmrim.cam_rspns_nm', resizable : false,searchable : true},
	        {name:'camRspnsDesc',index:'mrim.cam_rspns_desc', resizable : false,searchable : true},
	        {name:'id', index:'mrim.id', resizable : false,  hidden : true,  searchable : false}		
	    ],
	    radio:true,
	    sortname: 'mrim.cam_rspns_cd',
		sortorder: "asc",
		tempId : 'ifvGridOriginTemplete'
	};
	responseInfoSearchResult = $("#responseInfoSearchResult").ifvGrid({ jqGridOption : jqGridOption });
}

function searchInit(gridId){
	 $.fn.ifvmSetCommonCondList("responseRequiredList","MKTRSP001",gridId);
}


$(document).ready(function(){
	
	responseInfoSearchResultList();
	
	searchInit();

	//조회
	$("#authGroupSearchBtn").on('click', function(){
	//조회 호출
    	$.fn.ifvmSubmitSearchCondition("responseRequiredList", responseInfoSearchResultList);
	});

	//초기화
	$('#init').on('click', function(){
		searchInit('responseInfoSearchResult');
	});	

	//조건 조회 분류 선택에 따른 조건절 변경
	$(".searchTextVal").change(function(){
		responseInfoChangeSelect($(this).parent().parent().children().children("#searchCon"));
	});
	
	//필수항목 플러스 버튼
	$('.itemPlusBtn').live('click', function(){
		if($('.responseInfoSearchCondition').length < 5){
			for(var i=0; i<$('.responseInfoSearchCondition').length; i++){
				var showId = $('.responseInfoSearchCondition')[i].id;
				var defCon = $("#" + showId).attr('defcon');
				
				if(defCon != 1){
					$("#" + showId).show();
					$("#" + showId).attr('defcon', 1);
					break;
				}
			}
			
			flexMinusBtn();
		}
	});
	
	//필수항목 마이너스 버튼
	$('.itemMinusBtn').live('click', function(){
		
		if($(this).parent().parent().attr('seq') != 0){
			
			$(this).parent().parent().hide();
			
			$(this).parent().parent().attr('defcon', 0);
		}
	});
	
	//필수항목 type별 컨트롤 제어
	$(".searchCondition").live('change', function(){
		responseInfoChangeSelect(this);
	});
	
	//신규
	$('#responseNewBtn').on('click', function(){
		qtjs.href('<ifvm:url name="responseInfoDetail"/>');
	});
	//삭제
 	$('#responseInfoDelBtn').on('click', function() {
		   if($(responseInfoSearchResult.getCheckedGridData()).length==0){
			   alert('<spring:message code="M00285"/>');
		   }else{
				if(confirm('<spring:message code="M00296"/>')){

					var sendId = null;
					//console.log(programGrid.getCheckedGridData());
			        $(responseInfoSearchResult.getCheckedGridData()).each(function(index, item){
			        	sendId = item.id; 
			        });		 
				 	 $.ifvSyncPostJSON('<ifvm:action name="deleteResponseInfo"/>',{
				 		     id : sendId}, 
							 function(result){
								alert('<spring:message code="M01266"/>');
							       
								responseInfoSearchResultList();
							       
				             });
				}	   
			}
		});	 
});


</script>

<style>
.well{padding-bottom:5px;}
</style>

<div class="page-title">
	<h1>
		<spring:message code="M01258"/> &gt;  <spring:message code="M00273"/>
	</h1>
</div>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M01267"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id='authGroupSearchBtn'><i class="fa fa-search"></i>
			<spring:message code="M00273"/>
		</button> 
		<button class="btn btn-sm" id='init'>
			<spring:message code="M00278"/>
		</button> 
	</div>
</div>


<div class="well form-horizontal" id="responseRequiredList" >

</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00277"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm btn_gray" id="responseNewBtn">         
				<i class="fa fa-plus"></i>    
				<spring:message code="M00274"/>
			</button> 
			<button class="btn btn-sm btn_gray" id="responseInfoDelBtn">     
				<i class="fa fa-minus"></i>
				<spring:message code="M00275"/>
			</button>
		</div>
	</div>
	<div id="responseInfoSearchResult" class="grid_bd0"></div>
</div>



