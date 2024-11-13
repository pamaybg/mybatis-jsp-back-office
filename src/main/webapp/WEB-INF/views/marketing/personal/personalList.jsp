<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

$.ifvmLnbSetting('personalList');

var personalSearchResult;
var parId = null;
var requestitem = [];


//조회결과 그리드
function personalSearchResultList(){
	
	var jqGridOption = {
		serializeGridData : function( data ){
	 		if(requestitem != null && requestitem.length > 0){
				data.item = requestitem;
			}
			return data; 
		},
		ondblClickRow : function (data) {
			qtjs.href('<ifvm:url name="personalDetail"/>?id='+personalSearchResult.getRowData()[data-1].id);
		},
		loadComplete : function(obj){
			
		},
	    url: '<ifvm:action name="getPersonalList"/>', 
	    colNames:['<spring:message code="M00997"/>',
	              '<spring:message code="M00999"/>', 
	              '<spring:message code="M01000"/>', 
	              '<spring:message code="M01001"/>', 
	              '<spring:message code="M01008"/>',
	              '<spring:message code="M01009"/>',
	              '<spring:message code="M01011"/>',
	              'id'
	              ], 
	    colModel:[
	        {name:'perTypeCodeName',index:'cc.mark_name', resizable : false ,searchable : true},
	        {name:'dbSchema',index:'mpm.DB_SCHEMA', resizable : false,searchable : true},
	        {name:'tableName',index:'mpm.TB_NAME', resizable : false,searchable : true},
	        {name:'columnName',index:'mpm.TB_COLUMN', resizable : false,searchable : true},
	        {name:'perDesc',index:'mpm.PERSONAL_DESC', resizable : false,searchable : true},
	        {name:'createBy',index:'emp.name', resizable : false,searchable : true},
	        {name:'createDate',index:'mpm.modify_date', resizable : false,searchable : true},
	        {name:'id', index:'mpm.id', resizable : false,  hidden : true,  searchable : false}		
	    ],
	    radio:true,
	    sortname: 'mpm.create_date',
		sortorder: "desc",
		tempId : 'ifvGridOriginTemplete'
	};
	personalSearchResult = $("#personalSearchResult").ifvGrid({ jqGridOption : jqGridOption });
}


$(document).ready(function(){
	var LeftMenuId = $(".leftMenu").find(".active").attr('prognum');
	personalSearchResultList();

	//조회
	$("#authGroupSearchBtn").on('click', function(){
	//조회 호출
    	$.fn.ifvmSubmitSearchCondition("personalRequiredList", personalSearchResultList);
	});

	//초기화
	$('#init').on('click', function(){
		$.fn.ifvmSetCommonCondList("personalRequiredList",LeftMenuId);
	});	
	
	$.fn.ifvmSetCommonCondList("personalRequiredList",LeftMenuId);

	//조건 조회 분류 선태겡 따른 조건절 변경
	$(".searchTextVal").change(function(){
		personalChangeSelect($(this).parent().parent().children().children("#searchCon"));
	});
	
	//필수항목 플러스 버튼
	$('.itemPlusBtn').live('click', function(){
		if($('.personalSearchCondition').length < 5){
			for(var i=0; i<$('.personalSearchCondition').length; i++){
				var showId = $('.personalSearchCondition')[i].id;
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
		personalChangeSelect(this);
	});
	
	//신규
	$('#personalNewBtn').on('click', function(){
		qtjs.href('<ifvm:url name="personalDetail"/>');
	});
	//삭제
 	$('#personalDelBtn').on('click', function() {
		   if($(personalSearchResult.getCheckedGridData()).length==0){
			   alert('<spring:message code="M01018"/>');
		   }else{
				if(confirm('<spring:message code="M01020"/>')){

					var sendId = null;
					//console.log(programGrid.getCheckedGridData());
			        $(personalSearchResult.getCheckedGridData()).each(function(index, item){
			        	sendId = item.id; 
			        });		 
				 	 $.ifvSyncPostJSON('<ifvm:action name="deletePersonal"/>',{
				 		     id : sendId}, 
							 function(result){
								alert('<spring:message code="M01016"/>');
							       
								personalSearchResultList();
							       
				             });
				}	   
			}
		});	 
});


</script>


<script id="personalListTextTemp" type="text/x-jquery-tmpl">
<div class="col-xs-2">
	<ifvm:input type="text" />				
</div>
</script>

<script id="personalListSelectTemp" type="text/x-jquery-tmpl">
<div class="col-xs-2">
	<ifvm:input type="select" id="SelectListValue"/>			
</div>
</script>

<style>
.well{padding-bottom:5px;}
</style>

<div class="page-title">
	<h1>
		<spring:message code="M00998"/> &gt;  <spring:message code="M00273"/>
	</h1>
</div>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M01010"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id='authGroupSearchBtn'><i class="fa fa-search"></i>
			<spring:message code="M00273"/>
		</button> 
		<button class="btn btn-sm" id='init'>
			<spring:message code="M01005"/>
		</button> 
	</div>
</div>


<div class="well form-horizontal" id="personalRequiredList" >

</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M01006"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm btn_gray" id="personalNewBtn">         
				<i class="fa fa-plus"></i>    
				<spring:message code="M00274"/>
			</button> 
			<button class="btn btn-sm btn_gray" id="personalDelBtn">     
				<i class="fa fa-minus"></i>
				<spring:message code="M00275"/>
			</button>
		</div>
	</div>
	<div id="personalSearchResult" class="grid_bd0"></div>
</div>



