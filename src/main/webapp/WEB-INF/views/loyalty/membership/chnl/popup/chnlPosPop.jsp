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
var chnlPos_rid = '<%= cleanXss(request.getParameter("chnlPos_rid")) %>';
var chnl_rid = '<%= cleanXss(request.getParameter("chnl_rid")) %>';
var isNew = true;  //신규 여부. 신규: true, 수정 : false 

var validation;


function dataLoad(chnlPos_rid) {
	isNew = false;	// 해당 함수는 수정모드일 경우에만 호출되므로, 신규 여부 플래그 값을 false로 세팅함.

	
	$.ifvSyncPostJSON('<ifvm:action name="getChnlPosDetail"/>', {
		rid: chnlPos_rid
	}, function(result) {
		if($.fn.ifvmIsNotEmpty(result)) {

			$("#posNo").val(result.posNo); //단말기 번호
			$.fn.ifvmSetChekBoxValue("activeYn", result.activeYn); //활성
			$("#desctxt").val(result.desctxt); //설명
			
		}
	});
}



//저장
function saveSubmit(){	
	$.ifvSyncPostJSON(isNew ? '<ifvm:action name="addChnlPos"/>' : '<ifvm:action name="editChnlPos"/>', getObjForSubmit(), function(result) {
		alert('<spring:message code="L00127"/>');
		chnlPosPopClose(true);
	},
	function(result) {
		alert(result.message);
	}
	);
}


/*
submit을 위한 form 데이ChnlPos세팅
*/
function getObjForSubmit(){
	var v_obj = {};
		
	//활성
	var v_activeYn = $.fn.ifvmIsNotEmpty($("#activeYn").attr("checked")) ?  "Y" : "N";
	
	if(isNew) { //신규
		v_obj = {
				   ridChnl 		   :  chnl_rid
				 , posNo           :  $("#posNo").val()
				 , activeYn        :  v_activeYn			 
				 , desctxt         :  $("#desctxt").val()
				 
		};
		
	}else {  //수정
		v_obj = {				 
				    rid 			:  chnlPos_rid
				  , ridChnl 		:  chnl_rid
				  , posNo           :  $("#posNo").val()
				  , activeYn        :  v_activeYn			 
				  , desctxt         :  $("#desctxt").val()
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
	$('.attr_val').hide();
	if(val == "D")
		$('#attrValDateWrap').show();
	else if(val == "S")
		$('#attrValStrWrap').show();
}

$(document).ready(function(){
	$('#attrValDateWrap').hide();
	dateSetting();
	
	$("#btnChnlPosSave").click(function(){
		actionSave();
    });
	
	$("#btnChnlPosClosePop").click(function(){
	  parent.objChnlPosPop._destroy();
    });
	
	validation = $("#validationArea").ifvValidation();
		
	$('#attrTypeCd').on('change', function() {
		changeDOMShowHide($(this).val());
	});
	

});

</script>



<div class="well undChnlPosform-horizontal" id="validationArea" >			
	<div class="row">
		<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="L00322"/></label>
		<div class="col-xs-8 control_content attr_val" id="attrValStrWrap">
			<div class="input-group">
				<ifvm:input type="text" required="true" id="posNo" dto="posNo"  />
			</div>
		</div>
		
	</div>

	
	<div class="row">
		<label class="col-xs-3 control-label"><spring:message code="L00430"/></label>
		<div class="col-xs-8 control_content attr_val" id="attrValStrWrap">
			<label class="checkbox-inline">
		       	<ifvm:input type="checkbox" id="activeYn"/>
		   	</label>
		</div>
		
	</div>
	
	<div class="row">
		<label class="col-xs-3 control-label"><spring:message code="L00340"/></label>
		<div class="col-xs-8 control_content attr_val" id="attrValStrWrap">
			<div class="input-group">
				<ifvm:input type="textarea" id="desctxt" dto="desctxt" rows="3" />
			</div>
		</div>
		
	</div>

</div>

<div class="pop_btn_area">
	<button id="btnChnlPosSave" class="btn btn-sm btn_gray">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00170" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnChnlPosClosePop"><spring:message code="M00441" /></button>
</div>

<script>

$(function(){
	if($.fn.ifvmIsNotEmpty(chnlPos_rid) && chnlPos_rid != "null"){
		$("#posNo").attr("disabled", true);
		dataLoad(chnlPos_rid); //수정 시		
	}
	
});

</script>