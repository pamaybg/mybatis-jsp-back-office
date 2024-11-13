<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script>
var custAddInfo_rid = '<%= cleanXss(request.getParameter("addInfo_rid")) %>';
var cus_rid = '<%= cleanXss(request.getParameter("cust_rid")) %>';
var isNew = true;  //신규 여부. 신규: true, 수정 : false

var validation;


function dataLoad(custAddInfo_rid) {

	isNew = false;	// 해당 함수는 수정모드일 경우에만 호출되므로, 신규 여부 플래그 값을 false로 세팅함.

	$.ifvSyncPostJSON('<ifvm:action name="getCustAddInfoDetail"/>', {
		rid: custAddInfo_rid
	}, function(result) {
		if($.fn.ifvmIsNotEmpty(result)) {

			$("#addInfoTypeCd").val(result.addInfoTypeCd); //유형
			$("#attrTypeCd").val(result.attrTypeCd); //값 유형

			if(result.attrTypeCd == "S") $("#attrValStr").val(result.attrVal); //값
		    else if(result.attrTypeCd == "D") $("#attrValDate").val(result.attrVal); //값

		    changeDOMShowHide(result.attrTypeCd);

		}
	});
}



//저장
function saveSubmit(){
	$.ifvSyncPostJSON(isNew ? '<ifvm:action name="addCustAddInfo"/>' : '<ifvm:action name="editCustAddInfo"/>', getObjForSubmit()
	, function(result) {
		alert('<spring:message code="L00127"/>');
		custAddInfoPopClose(true);

	});
}


/*
submit을 위한 form 데이터 파라미터 세팅
*/
function getObjForSubmit(){
	var v_obj = {};

	var v_attrVal = $("#attrTypeCd").val() == "S" ? $("#attrValStr").val() : $("#attrValDate").val();


	if(isNew) { //신규
		v_obj = {
				   ridCust 		   :  cust_rid
				 , addInfoTypeCd   :  $("#addInfoTypeCd").val()
				 , attrTypeCd      :  $("#attrTypeCd").val()
				 , attrVal         :  v_attrVal

		};

	}else {  //수정
		v_obj = {
				    rid 			:  custAddInfo_rid
				  , ridCust 		:  cust_rid
				  , addInfoTypeCd 	:  $("#addInfoTypeCd").val()
				  , attrTypeCd      :  $("#attrTypeCd").val()
				  , attrVal         :  v_attrVal
		};
	}

	return v_obj;

}

//저장 버튼클릭 시 동작
function actionSave() {


	if(validation.confirm())  saveSubmit();
}



function dateSetting() {
	var date = $('#attrValDate');
	date.val($.ifvGetTodayDate());
	date.ifvDateChecker({});
}

function changeDOMShowHide(val){
	//

	$('.attr_val').hide();
	if(val == "D")
		$('#attrValDateWrap').show();
	else if(val == "S")
		$('#attrValStrWrap').show();
}

$(document).ready(function(){
	$('#attrValDateWrap').hide();
	dateSetting();

	$("#btnAddInfoSave").click(function(){
		actionSave();
    });

	$("#btnAddInfoClosePop").click(function(){
	//	custAddInfoPopClose(true);
	  parent.objCustAddInfoPop._destroy();
    });

	validation = $("#validationArea").ifvValidation();

	$('#attrTypeCd').on('change', function() {
		//alert($(this).val());
		changeDOMShowHide($(this).val());
	});


});

</script>

<!-- 값 -->
<script id="addInfoTypeCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<!--값유형  -->
<script id="attrTypeCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div class="well underline form-horizontal" id="validationArea" >
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00389"/></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="select" required="true" id="addInfoTypeCd" names ="addInfoTypeCd" dto="addInfoTypeCd"  />
			</div>
		</div>
		<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="L00314"/></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="select" required="true" id="attrTypeCd" names ="attrTypeCd" dto="attrTypeCd" />
			</div>
		</div>
	</div>


	<div class="row">
		<label class="col-xs-2 control-label"><spring:message code="M01881"/></label>
		<div class="col-xs-4 control_content attr_val" id="attrValStrWrap">
			<div class="input-group">
				<ifvm:input type="text" id="attrValStr" dto="attrVal"  />
			</div>
		</div>
		<div class="col-xs-4 control_content attr_val" id="attrValDateWrap">
			<div class="input-group">
				<ifvm:input type="date" id="attrValDate" />
			</div>
		</div>
	</div>

</div>

<div class="pop_btn_area">
	<button id="btnAddInfoSave" class="btn btn-sm btn_gray">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00170" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnAddInfoClosePop"><spring:message code="M00441" /></button>
</div>

<script>

$(function(){
	//유형
	$.fn.ifvmSetSelectOptionCommCode("addInfoTypeCd", "LOY_CUST_ADD_INFO_CD", null, null, false);
	//값유형
	$.fn.ifvmSetSelectOptionCommCode("attrTypeCd", "LOY_DATA_TYPE_CD", null, null, false);
	/* //유형
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'LOY_CUST_ADD_INFO_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#addInfoTypeCdTemp").tmpl(result.rows);
		$("#addInfoTypeCd").append(temp);
	});

	//값유형
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'LOY_DATA_TYPE_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#attrTypeCdTemp").tmpl(result.rows);
		$("#attrTypeCd").append(temp);
	}); */



	if($.fn.ifvmIsNotEmpty(custAddInfo_rid) && custAddInfo_rid != "null") dataLoad(custAddInfo_rid); //수정 시

});

</script>