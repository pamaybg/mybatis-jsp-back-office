<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>



var fatigueSearchResult;
var parId = null;
var requestitem = [];

//조회결과 그리드
function fatigueSearchResultList(){
	
	var jqGridOption = {
		serializeGridData : function( data ){
	 		if(requestitem != null && requestitem.length > 0){
				data.item = requestitem;
			}
			return data; 
		},
		ondblClickRow : function (data) {
			//location.href = '<ifvm:url name="fatigueDetail"/>?id='+fatigueSearchResult.getRowData()[data-1].id;
			qtjs.href('<ifvm:url name="fatigueDetail"/>?id='+fatigueSearchResult.getRowData()[data-1].id);
		},
		loadComplete : function(obj){
			
		},
	    url: '<ifvm:action name="getFatigueList"/>', 
	    colNames:['<spring:message code="M01031"/>',
	              //'<spring:message code="M01032"/>', 
	              '<spring:message code="M01390"/>', 
	              '<spring:message code="M01034"/>', 
	              '<spring:message code="M01035"/>',
	              '<spring:message code="M01036"/>',
	              '<spring:message code="M01041"/>',
	              'id'
	              ], 
	    colModel:[
	        {name:'chnlTypeCdName',index:'c1.mark_name', resizable : false ,searchable : true},
	        //{name:'customerGrade',index:'mfm.cust_grade', resizable : false,searchable : false,align :'center'},
	        {name:'periodDivName',index:'mfm.fati_restriction_day', resizable : false,searchable : true,align :'center'},
	        {name:'maxRstrtnTmscnt',index:'mfm.max_rstrtn_tmscnt', resizable : false,searchable : true, align :'center'},
	        {name:'startDate',index:'mfm.start_dd', resizable : false,searchable : true,align :'center'},
	        {name:'endDate',index:'mfm.end_dd', resizable : false,searchable : true,align :'center'},
	        {name:'fatigueDesc',index:'mfm.fatigue_desc', resizable : false,searchable : true},
	        {name:'id', index:'mfm.id', resizable : false,  hidden : true,  searchable : false}		
	    ],
	    radio:true,
	    sortname: 'mfm.create_date',
		sortorder: "desc",
	};
	fatigueSearchResult = $("#fatigueSearchResult").ifvGrid({ jqGridOption : jqGridOption });
}


//공통 조회 조건 목록 설정
function searchCondInit() {
    $.fn.ifvmSetCommonCondList("commSearchList","MNGFTG001");
}

//공통 조회 호출
function fatigueSerach() {
    $.fn.ifvmSubmitSearchCondition("commSearchList", fatigueSearchResultList);
}

$(document).ready(function(){

    //공통 조회 조건 목록 설정
    searchCondInit();
    
    //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit();
    });
    
	$.ifvmLnbSetting('fatigueList');
	var LeftMenuId = $(".leftMenu").find(".active").attr('prognum');
	fatigueSearchResultList();

	//조회
	$("#authGroupSearchBtn").on('click', function(){
	//조회 호출
    	fatigueSerach();
	});

	//초기화
	$('#init').on('click', function(){
		searchCondInit()

	});	
//	searchCondInit()


	//조건 조회 분류 선태겡 따른 조건절 변경
	$(".searchTextVal").change(function(){
		fatigueChangeSelect($(this).parent().parent().children().children("#searchCon"));
	});
	
	//필수항목 플러스 버튼
	$('.itemPlusBtn').live('click', function(){
		if($('.fatigueSearchCondition').length < 5){
			for(var i=0; i<$('.fatigueSearchCondition').length; i++){
				var showId = $('.fatigueSearchCondition')[i].id;
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
		fatigueChangeSelect(this);
	});
	
	//신규
	$('#fatigueNewBtn').on('click', function(){
		//location.href = '<ifvm:url name="fatigueDetail"/>';
		qtjs.href('<ifvm:url name="fatigueDetail"/>');
	});
	//삭제
 	$('#fatigueDelBtn').on('click', function() {
		   if($(fatigueSearchResult.getCheckedGridData()).length==0){
			   alert('<spring:message code="M01051"/>');
		   }else{
				if(confirm('<spring:message code="M01053"/>')){

					var sendId = null;
					//console.log(programGrid.getCheckedGridData());
			        $(fatigueSearchResult.getCheckedGridData()).each(function(index, item){
			        	sendId = item.id; 
			        });		 
				 	 $.ifvSyncPostJSON('<ifvm:action name="deleteFatigue"/>',{
				 		     id : sendId}, 
							 function(result){
								alert('<spring:message code="M01049"/>');
							       
								fatigueSearchResultList();
							       
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
		<spring:message code="M01030"/> &gt;  <spring:message code="M00273"/>
	</h1>
</div>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L01838"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id='authGroupSearchBtn'><i class="fa fa-search"></i>
			<spring:message code="M00273"/>
		</button> 
		<button class="btn btn-sm" id='init'>
			<spring:message code="M01038"/>
		</button> 
	</div>
</div>
     <div class="well form-horizontal well_bt5" id="commSearchList" >
    </div>


<div class="well form-horizontal" id="fatigueRequiredList" >
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M01039"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="fatigueNewBtn">         
				<i class="fa fa-plus"></i>    
				<spring:message code="M00274"/>
			</button> 
			<button class="btn btn-sm" id="fatigueDelBtn">     
				<i class="fa fa-minus"></i>
				<spring:message code="M00275"/>
			</button>
		</div>
	</div>
	<div id="fatigueSearchResult" class="grid_bd0"></div>
</div>
