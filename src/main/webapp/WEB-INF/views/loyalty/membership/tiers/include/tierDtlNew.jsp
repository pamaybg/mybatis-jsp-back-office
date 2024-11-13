<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var tiersList;

var tiersRid = null;
var tierBnftRid = null;
var tierNm = null;

//팝업 닫기
function tiersDtlPopClose() {
	popdialog._destroy();
}

// 등급목록 조회
function tiersListInit(){
	var ejGridOption = {
		recordDoubleClick : function(args){
   			var data = args.data;
			tiersRid = data.rid;
			tiersPopInit();
		},
        rowSelected : function (args) {
			tiersRid = args.data.rid; 
			tierNm   = args.data.tierNm;
			btnDisabled();
		},
		serializeGridData : function(data){
			data.ridTierGroup = ridTierGroup;
		},		
		dataUrl: '<ifvm:action name="getTierDtlList"/>',
		columns:[
	    	{
	      		  field : 'seqNo', headerText : '<spring:message code="M01972"/>', headerTextAlign : 'center', width:'80px',
	      	  },{
	      		  field : 'tierCd', headerText : '<spring:message code="L00235"/>', headerTextAlign : 'center', width:'80px',
	      	  },{
	      		  field : 'tierNm', headerText : '<spring:message code="L00236"/>', headerTextAlign : 'center', width:'80px',
	      	  },{
	      		  field : 'validStartDate', headerText : '<spring:message code="L00391"/>', headerTextAlign : 'center', width:'80px',
	      	  },{
	      		  field : 'validEndDate', headerText : '<spring:message code="L00393"/>', headerTextAlign : 'center', width:'80px',
	      	  },{
	      		  field : 'tierCdStatNm', headerText : '<spring:message code="M01973"/>', headerTextAlign : 'center', width:'80px',
	      		  customAttributes : {
	      			  index : 'tierCdStatCd' }
	      	  },{
	      		  field : 'createBy', headerText : '<spring:message code="L00237"/>', headerTextAlign : 'center', width:'80px',
	      	  },{
	      		  field : 'createDate', headerText : '<spring:message code="L00238"/>', headerTextAlign : 'center', width:'80px',
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible: false,
	      	  }      
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'seqNo',
      	  sord : 'asc',
      	  _search : false
        },
        rowList : [10,25,50,100],
	};
	tiersList = $("#tiersList").ifvsfGrid({ ejGridOption : ejGridOption });
}

//등급목록 팝업
function tiersPopInit(){
	$("#popdialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tierDtlPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01978" />',
        width: '650px',
        close : 'tiersDtlPopClose',
    });
}

//등급별혜택 팝업
function tierBnftPopInit(){
	$("#popdialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tierBnftPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01979" />',
        width: '650px',
        close : 'tiersDtlPopClose',
    });
	
}

function btnDisabled(){
	if(tiersRid != null){
		$("#addTierBnftBtn").attr("disabled",false);
	}else{
		$("#addTierBnftBtn").attr("disabled",true);
	}
}

$(document).ready(function(){
	// 등급목록 조회
	tiersListInit();
	
	//타겟 레벨 추가
	$("#addTiersBtn").on("click", function(){
		tiersRid = null;
		tiersPopInit();
	});
	
	//타겟 레벨 추가
	$("#addTierBnftBtn").on("click", function(){
		tierBnftRid = null;
		tierBnftPopInit();
	});
	
	// 신규/수정 경우 버튼 disabled
	if(ridTierGroup == null){
		$("#addTiersBtn").attr("disabled",true);
	}else{
		$("#addTiersBtn").attr("disabled",false);
	}
	btnDisabled();
});

</script>
<div class="page_btn_area">
	<div class="col-xs-7">
		<spring:message code="M01980" />
	</div>
	<div class="col-xs-5 searchbtn_r">
	 
		<button class="btn btn-sm" id="addTiersBtn" objCode="tierDtlNewaddTiersBtn_OBJ">
			<i class="fa fa-plus"></i>
			<spring:message code="M01852"/>
		</button> 
	</div>
</div>
<div id="tiersList" class="grid_bd0"></div>

