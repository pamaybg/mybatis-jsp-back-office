<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>


var commCodeMode = ""; //수정모드(edit), 신규모드(add) 구분
var paramData = new Object;
var validation;
var originData = null;

function getCommCode() {
	//appService type code
	/* $.ifvSyncPostJSON('<ifvm:action name="getSystem"/>', {
	}, function(result) {
		var temp = $("#appServiceTypeTemplate").tmpl(result.rows);
		$("#appServiceType").append(temp);
	}); */

	//country list code
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeCountry"/>', {
	}, function(result) {
		var temp = $("#countryTemplate").tmpl(result.rows);
		$("#country").append(temp);
	});
	
	//language code
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'LANG_TYPE'
		,schemas : 'com'//com스키마에만 있기 때문이다.
		, enableNA : false
	}, function(result) {
		for (var i=0; i<result.rows.length; i++) {
			result.rows[i].codeName = result.rows[i].codeName.toLowerCase();
		}
		var temp = $("#languageTemplate").tmpl(result.rows);
		$("#lang").append(temp);
	});
}

function init() {
	$.ifvmLnbSetting("commCodeList");

	validation = $("#validationArea").ifvValidation();
	
	paramData.id = $.ifvGetParam('id'); //파라미터로 넘어온 id 저장
	paramData.schema = $.ifvGetParam('schema'); //파라미터로 넘어온 schema 저장
	paramData.langType = $.ifvGetParam('lang'); //파라미터로 넘어온 lang 저장
	
	if(paramData.id != undefined && paramData.id != '' && paramData.id.length > 0) commCodeMode = 'edit';
	else commCodeMode = 'add';
	
	//수정모드인 경우 셋팅 및 데이터 불러오기
	if (commCodeMode == "edit") {
		$("#schema").attr("disabled", "disabled");
 		$("#lang").attr("disabled", "disabled");
	/* 	$("#markCode").attr("disabled", "disabled"); */
		
		$("#subTitle").text('<spring:message code="M00259" />');
		$.ifvSyncPostJSON('<ifvm:action name="getCommCodeDetail"/>', paramData
			, function(result) {
			originData = result;
			//$("#appServiceType").val(result.appServiceType);
			$("#schema").val(paramData.schema);
			$("#id").val(result.id);
			$("#groupCode").val(result.groupCode);
			$("#groupName").val(result.groupName);
			$("#markCode").val(result.markCode);
			$("#markName").val(result.markName);
			$("#codeName").val(result.codeName);
			$("#status").val(result.status);
			$("#country").val(result.country);
			$("#seq").val(result.seq);
			$("#parentCodeId").val(result.parentCodeId);
			$("#attrib01").val(result.attrib01);
			$("#attrib02").val(result.attrib02);
			$("#attrib03").val(result.attrib03);
			$("#attrib04").val(result.attrib04);
			$("#attrib05").val(result.attrib05);
			$("#createBy").val(result.createBy);
			$("#createDate").val($.ifvFormatDate( 'yyyy-mm-dd', result.createDate ));
			$("#modifyBy").val(result.modifyBy);
			$("#modifyDate").val($.ifvFormatDate( 'yyyy-mm-dd', result.modifyDate ));
			
		 	var optionList = $("#lang option");
			for (var i=0; i<optionList.size(); i++) {
				if (optionList[i].value.toLowerCase() == result.lang.toLowerCase()) {
					$("#lang").val(optionList[i].value);
				}
			} 
		});
	} else {
	   	$('#createBy').val($.ifvmGetUserInfo().empName);
	   	$('#createDate').val($.ifvFormatDate( 'yyyy-mm-dd', new Date()));
		//$("#appServiceType").val(result.appServiceType);
		//$("#schema").val(paramData.schema);
		//$("#id").val(result.id);
		/* $("#groupCode").val("test_groupCode");
		$("#groupName").val("test_groupName");
		$("#markCode").val("test_markCode");
		$("#markName").val("test_markName");
		$("#codeName").val("test_codeName");
		$("#status").val("5"); */
		//$("#country").val(result.country);
		/* $("#seq").val("1"); */
	}
}

function eventSetting() {
	
	//그룹코드, 코드명 변경시 이벤트
	$("#groupCode, #codeName").change(function(e){
		$('#markCode').val($('#groupCode').val() + "_" + $('#codeName').val());
		if (e.target.id == "codeName" && $('#codeName').val().toLowerCase() == "na") {
			$('#seq').val("99");
		}
	});
	
	//마크명 변경시 이벤트
	$("#markName").change(function(e){
		if ($("#markName").val() == '<spring:message code="M00172"/>') {
			$('#codeName').val("NA");
			$('#markCode').val($('#groupCode').val() + "_" + $('#codeName').val());
			$('#seq').val("99");
		}
	});

	$("#btnSave").on("click", function() {
		//유효성 검사
		if( validation.confirm() == false ) return;	//함수 호출시 체크
		
		if (commCodeMode == "add") { //신규등록작업
			var requestData = $('#validationArea').getSubmitData();
			requestData.commCodeMode = commCodeMode;
			
			$.ifvSyncPostJSON('<ifvm:action name="addCommCode"/>', requestData
				, function(result) {
					alert('<spring:message code="M00267"/>');
					qtjs.href('<ifvm:url name="employee"/>');
				}
				, function(result) {
					if (result.message == "duplication") {
						alert('<spring:message code="M00258"/>');
					} else {
						alert('<spring:message code="M00266"/>');
					}
				}
			);
		} else { //업데이트작업
			
			$('#groupCode').val($('#groupCode').val().toUpperCase());
			$('#codeName').val($('#codeName').val().toUpperCase());
			
			$('#markCode').val($('#groupCode').val() + "_" + $('#codeName').val());
			if ($('#codeName').val() == "NA") {
				$('#seq').val("99");
			}
			
			if ($('#markCode').val() != originData.markCode) {
				alert('<spring:message code="M00268"/>');
			}

			var requestData = $('#validationArea').getSubmitData();	
			
			//업데이트 시작
			$.ifvSyncPostJSON('<ifvm:action name="editCommCode"/>'
				, requestData
				, function(result) {
					alert('<spring:message code="M00269"/>');
					qtjs.reload();	
				}
				, function(result) {
					alert('<spring:message code="M00270"/>'	);
				}
			)
		}
	});
}


$(document).ready(function(){
	getCommCode();
	init();
	eventSetting();
});


</script>


<script id="appServiceTypeTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}id}">${'${'}and_app_name}</option>
</script>

<script id="countryTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}country}">${'${'}country}</option>
</script>

<script id="languageTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div class="page-title">
	<h1>
		<spring:message code="M00156" />
		&gt; <spring:message code="M00234" />
		&gt; <label id="subTitle"><spring:message code="M00163" /></label>
	</h1>
</div>

<%-- 		<spring:message code="M00216"/>
		<span>&gt;  <spring:message code="M00188"/></span>
		<span>&gt; <spring:message code="M00223"/></span> --%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M00234" /></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<button id="btnSave" class="btn btn-sm"> <!-- onClick="saveBtnClick()" -->
			<i class="glyphicon glyphicon-check"></i>
			<spring:message code="M00170" />
		</button> 
	</div>
</div>

<div class="well underline form-horizontal" id="validationArea" >
	<div class="row qt_border">
		<%-- <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00235" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="select" id="appServiceType" dto="appServiceType"/>
			</div>
		</div> --%>
		
	</div>
			
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span>ID</label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="id" dto="id" disabled="true" />
			</div>
		</div>
		<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00236" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="select" id="schema" dto="schema" text="M00252" values="com" checkIndex="1" disabled="true"/>
			</div>
		</div>
	</div>

	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00241" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="groupCode" dto="groupCode" maxLength="50" required="true" />
			</div>
		</div>
		<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00238" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="groupName" dto="groupName" maxLength="50" required="true" />
			</div>
		</div>
	</div>

	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00242" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="markCode" dto="markCode" maxLength="100" required="true" />
			</div>
		</div>
		<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00243" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="markName" dto="markName" maxLength="50" required="true" />
			</div>
		</div>
	</div>

	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00244" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="codeName" dto="codeName" maxLength="50" required="true" />
			</div>
		</div>
		<label class="col-xs-3 control-label"><spring:message code="M00245" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="select" id="status" dto="status" text="M00253|M00165" values="1|0" checkIndex="1"  />
			</div>
		</div>
	</div>

	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00246" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="select" id="country" dto="countryType" />
			</div>
		</div>
		<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00237" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="select" id="lang" dto="langType" />
			</div>
		</div>
	</div>

	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00240" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="seq" dto="seq" maxLength="11" required="true" valiItem="number" />
			</div>
		</div>
		<label class="col-xs-3 control-label"><spring:message code="M00260" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="parentCodeId" dto="parentCodeId" />
			</div>
		</div>
	</div>
	
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><spring:message code="M00261" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="attrib01" dto="attrib01" maxLength="100"/>
			</div>
		</div>
		<label class="col-xs-3 control-label"><spring:message code="M00262" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="attrib02" dto="attrib02" maxLength="100"/>
			</div>
		</div>
	</div>
	
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><spring:message code="M00263" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="attrib03" dto="attrib03" maxLength="100" />
			</div>
		</div>
		<label class="col-xs-3 control-label"><spring:message code="M00264" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="attrib04" dto="attrib04" maxLength="100" />
			</div>
		</div>
	</div>
	
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><spring:message code="M00265" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="attrib05" dto="attrib05" maxLength="100"/>
			</div>
		</div>
	</div>
	
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><spring:message code="M00248" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="createBy" disabled="true" />
			</div>
		</div>	
		<label class="col-xs-3 control-label"><spring:message code="M00249" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="createDate" disabled="true" />
			</div>
		</div>
	</div>

	<div class="row">
		<label class="col-xs-2 control-label"><spring:message code="M00250" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="modifyBy" disabled="true" />
			</div>
		</div>
		<label class="col-xs-3 control-label"><spring:message code="M00251" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="modifyDate" disabled="true" />
			</div>
		</div>
	</div>
</div>