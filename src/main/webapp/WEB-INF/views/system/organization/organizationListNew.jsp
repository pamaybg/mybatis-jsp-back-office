<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var organizationSearchResult;

function authGroupSearchInit(gridId){
    $.fn.ifvmSetCommonCondList("organizationSearchResult",'',gridId);
}

//조회결과 그리드
function organizationSearchResultList(){
	
	var ejGridOption = {
		serializeGridData : function( data ){
			//공통조회를 위한 영역
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
		},
		recordDoubleClick : function (args) {
			qtjs.href('<ifvm:url name="organizationDetail"/>?rid='+args.data.rid);
		},
	    dataUrl: '<ifvm:action name="getOrganizationList"/>', 
	    columns:[
	    	  {
        		  field : 'divTypeCd', headerText : '<spring:message code="L00478"/>', textAlign : 'center',
        	  },{
          		  field : 'divNo', headerText : '<spring:message code="M00336"/>', textAlign : 'center', customAttributes : {searchable : true, index : 'cd1.div_no'}
          	  },{
          		  field : 'divNm', headerText : '<spring:message code="M00555"/>', textAlign : 'center', customAttributes : {searchable : true, index : 'cd1.div_nm'}
          	  },{
          		  field : 'divLvl', headerText : '<spring:message code="L00479"/>', textAlign : 'center', customAttributes : {searchable : true, index:'cd1.div_lvl'}
          	  },{
          		  field : 'ridParDiv', headerText : '<spring:message code="L00480"/>', textAlign : 'center',
          	  },{
          		  field : 'divStatus', headerText : '<spring:message code="L00481"/>', textAlign : 'center',
          	  },{
          		  field : 'modifyBy', headerText : '<spring:message code="L00044"/>', textAlign : 'center',
          	  },{
          		  field : 'modifyDate', headerText : '<spring:message code="L02703"/>', textAlign : 'center',
          	  },{
          		  field : 'rid', headerText : 'rid', visible :false ,
          	  }
	    ],
	    requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'modifyDate',
      	  sord : 'desc',
      	  _search : false
        },
	    radio:false,
		tempId : 'ifvGridOriginTemplete'
	};
	organizationSearchResult = $("#organizationSearchResult").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function(){
    authGroupSearchInit();
	var LeftMenuId = $(".leftMenu").find(".active").attr('prognum');
	organizationSearchResultList();

	//조회
	$("#authGroupSearchBtn").on('click', function(){
	//조회 호출
    	$.fn.ifvmSubmitSearchCondition("organizationRequiredList", organizationSearchResultList);
	});

	//초기화
	$('#init').on('click', function(){
		$.fn.ifvmSetCommonCondList("organizationRequiredList",LeftMenuId);
	});	
	
	$.fn.ifvmSetCommonCondList("organizationRequiredList",LeftMenuId);

	//조건 조회 분류 선택에 따른 조건절 변경
	$(".searchTextVal").change(function(){
		organizationChangeSelect($(this).parent().parent().children().children("#searchCon"));
	});
	
	//필수항목 플러스 버튼
	$('.itemPlusBtn').live('click', function(){
		if($('.organizationSearchCondition').length < 5){
			for(var i=0; i<$('.organizationSearchCondition').length; i++){
				var showId = $('.organizationSearchCondition')[i].id;
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
		organizationChangeSelect(this);
	});
	
	//신규
	$('#organizationNewBtn').on('click', function(){
		qtjs.href('<ifvm:url name="organizationDetail"/>');
	});
	
});

</script>

<style>
.well{padding-bottom:5px;}
</style>

<div class="page-title">
	<h1>
		<span><spring:message code="O00201"/> &gt; <spring:message code="L00030"/></span>
	</h1>
</div>
<%-- <div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M01043"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id='authGroupSearchBtn' objCode="organizationListNewSearch_OBJ"><i class="fa fa-search"></i>
				<spring:message code="M00273"/>
			</button> 
			<button class="btn btn-sm" id='init' objCode="organizationListNewInit_OBJ">
				<spring:message code="M01038"/>
			</button> 
		</div>
	</div>
	
	<div class="well form-horizontal" id="organizationRequiredList" ></div>
</div> --%>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M01039"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm btn_gray" id="organizationNewBtn" objCode="organizationNewBtn_OBJ">         
				<i class="fa fa-plus"></i>    
				<spring:message code="M00274"/>
			</button> 
		</div>
	</div>
	<div id="organizationSearchResult" class="grid_bd0"></div>
</div>
