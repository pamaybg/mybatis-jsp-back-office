<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var tierChnlList;
var tierChnlRid;
var ridChnls = [];
var subInclYns = [];
var popSelectlId = "chnlNm";

//팝업 닫기
function popupClose() {
	popdialog._destroy();
	if($.fn.ifvmIsNotEmpty($("#chnlNm").text())) setTierChnl();
}

//채널 저장
function setTierChnl(){
	var obj = {};
	obj.ridTierGroup = ridTierGroup;
	obj.ridChnl = $("#chnlNm").text();
	$.ifvSyncPostJSON('<ifvm:action name="setTierChnl"/>',obj
	,function(result) {
		alert('<spring:message code="M00623"/>');
		tierChnlListInit();
	});
} 

//채널 저장
function editTierChnl(){
	var selectData = tierChnlList.opt.gridControl.getSelectedRecords();
	
	if( selectData.length == 0 ){
		alert('<spring:message code="M00004" />');
	}else{
		for(var i=0; i<selectData.length; i++){
			ridChnls = [];
			subInclYns = [];
			ridChnls.push(selectData[i].rid);
			subInclYns.push(selectData[i].subInclYn);
			
			$.ifvSyncPostJSON('<ifvm:action name="editTierChnl"/>',{
				rid	: ridChnls, subInclYn: subInclYns
			},function(result) {
			});
		}
		alert('<spring:message code="M00267" />.');
		tierChnlListInit();
	}
	
}

//타겟 레벨 삭제
function removeTierChnl(){
	var selectData = tierChnlList.opt.gridControl.getSelectedRecords();
	ridChnls = [];
	
	if( selectData.length == 0 ){
		alert('<spring:message code="M00004" />');
	}else{
		if(confirm('<spring:message code="M00296"/>')){
			for(var i=0; i<selectData.length; i++){
				ridChnls.push(selectData[i].rid);
			}
			$.ifvSyncPostJSON('<ifvm:action name="removeTierChnl"/>',{
				rid	: ridChnls
			},function(result) {
				alert('<spring:message code="M00622"/>');
				tierChnlListInit();
			});
		}
	}
}

// 채널 목록 조회
function tierChnlListInit(){
	var ejGridOption = {
		serializeGridData : function(data){
			data.ridTierGroup = ridTierGroup;
		},		
		dataUrl: '<ifvm:action name="getTierChnlList"/>',
		columns:[
	    	  { type:"checkbox", width: 50},
	    	  {
	      		  field : 'chnlNo', headerText : '<spring:message code="L00128"/>', headerTextAlign : 'center', width:'80px',
	      	  },{
	      		  field : 'chnlNm', headerText : '<spring:message code="L00129"/>', headerTextAlign : 'center', width:'80px',
	      	  },{
	      		  field : 'chnlTypeNm', headerText : '<spring:message code="L00132"/>', headerTextAlign : 'center', width:'80px',
	      		  customAttributes : {
	      			  index : 'chnlTypeCd' }
	      	  },{
	      		  field : 'parChnlNm', headerText : '<spring:message code="L00130"/>', headerTextAlign : 'center', width:'80px',
	      	  },{
	      		  field : 'parTopChnlNm', headerText : '<spring:message code="L00131"/>', headerTextAlign : 'center', width:'80px',
	      	  },{
	      		  field : 'parTopYn', headerText : '<spring:message code="L00409"/>', headerTextAlign : 'center', width:'80px', editType : ej.Grid.EditingType.Boolean,
	      	  },{
	      		  field : 'subInclYn', headerText : '<spring:message code="M01971"/>', headerTextAlign : 'center', width:'80px',
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false,
	      	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'chnlNo',
      	  sord : 'asc',
      	  _search : false
        },
        rowList : [10,25,50,100],
	    tempId : 'ifvGridOriginTemplete'
	};
	tierChnlList = $("#tierChnlList").ifvsfGrid({ ejGridOption : ejGridOption });
}

//팝업
function tierChnlPopInit(){
	$("#popdialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="chnlPop"/>',
        contentType: "ajax",
        title: '<spring:message code="L00172"/>',
        width: '650px',
        close : 'popupClose',
    });
}

$(document).ready(function(){
	// 채널목록조회
	tierChnlListInit();
	
	//채널추가
	$("#addChnlBtn").on("click", function(){
	 	tierChnlRid = null;
		tierChnlPopInit(); 
	});
	
	// 채널저장
	$("#saveChnlBtn").on("click", function(){
		editTierChnl();
	});
	
	//채널삭제
	$("#delChnlBtn").on("click", function(){
		removeTierChnl();
	});
	
	
	// 신규/수정 경우 버튼 disabled
	if(ridTierGroup == null){
		$("#addChnlBtn").attr("disabled",true);
		$("#saveChnlBtn").attr("disabled",true);
		$("#delChnlBtn").attr("disabled",true);
	}else{
		$("#addChnlBtn").attr("disabled",false);
		$("#saveChnlBtn").attr("disabled",false);
		$("#delChnlBtn").attr("disabled",false);
	}
	
	$("#chnlNm").hide();
});

</script>
	
<div class="page_btn_area">
	<div class="col-xs-7">
		 <span><spring:message code="L00241"/></span> 
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="addChnlBtn" objCode="tierChnlNewaddChnlBtn_OBJ">
			<i class="fa fa-plus"></i>
			<spring:message code="M00132"/>
		</button> 
		<button class="btn btn-sm" id="saveChnlBtn" objCode="tierChnlNewsaveChnlBtn_OBJ">
			<spring:message code="M00137"/>
		</button> 
		<button class="btn btn-sm" id="delChnlBtn" objCode="tierChnldelChnlBtn_OBJ">
			<i class="fa fa-minus"></i>
			<spring:message code="M00165"/>
		</button> 
		<ifvm:input type="text" id="chnlNm"/>
	</div>
</div>
<div id="tierChnlList" class="grid_bd0"></div>
