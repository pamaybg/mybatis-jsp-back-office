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
	var selectData = tierChnlList.getCheckedGridData();

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
	var selectData = tierChnlList.getCheckedGridData();
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
	var jqGridOption = {
        onSelectRow : function (data) {
		},
		serializeGridData : function(data){
			data.ridTierGroup = ridTierGroup;
		},
		loadComplete : function(obj){
		},
		url: '<ifvm:action name="getTierChnlList"/>',
	    colNames:[
	              '<spring:message code="L00128"/>'
	              ,'<spring:message code="L00129"/>'
	              ,'<spring:message code="L00132"/>'
	              ,'<spring:message code="L00130"/>'
	              ,'<spring:message code="L00131"/>'
	              ,'<spring:message code="L00409"/>'
	              ,'<spring:message code="M01971"/>'
	              ,'rid'
	              ],
	    colModel:[{name:'chnlNo', index:'lc1.CHNL_NO', resizable : false, align:'center'},
	              {name:'chnlNm', index:'lc1.CHNL_NM', resizable : false},
	              {name:'chnlTypeNm', index:'c.mark_name', resizable : false},
	              {name:'parChnlNm', index:'lc2.CHNL_NM', resizable : false},
	              {name:'parTopChnlNm', index:'lc3.CHNL_NM', resizable : false},
	              {name:'parTopYn', index:'lc3.chnl_nm', align:'center', resizable : false, editable:true, edittype:'checkbox', editoptions: { value:"Y:N"}, formatter: "checkbox" , formatoptions: {disabled : true}},
	              {name:'subInclYn', index:'ltgc.sub_incl_yn', resizable : false, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"Y:N"}, formatter: "checkbox", formatoptions: {disabled : false}},
	              {name:'rid', index:'ltgc.rid', hidden : true}
			      ],
		multiselect:true,
	    sortname: 'lc1.CHNL_NO',
		sortorder: "asc",
	    tempId : 'ifvGridOriginTemplete'
	};
	tierChnlList = $("#tierChnlList").ifvGrid({ jqGridOption : jqGridOption });
}

//팝업
function tierChnlPopInit(){
	$("#popdialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="chnlPop"/>',
        contentType: "ajax",
        title: '<spring:message code="L00172"/>',
        width: 650,
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
		<button class="btn btn-sm" id="addChnlBtn">
			<i class="fa fa-plus"></i>
			<spring:message code="M00132"/>
		</button>
		<button class="btn btn-sm" id="saveChnlBtn">
			<spring:message code="M00137"/>
		</button>
		<button class="btn btn-sm" id="delChnlBtn">
			<i class="fa fa-minus"></i>
			<spring:message code="M00165"/>
		</button>
		<ifvm:input type="text" id="chnlNm"/>
	</div>
</div>
<div id="tierChnlList" class="grid_bd0"></div>
