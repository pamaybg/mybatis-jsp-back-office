<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var DASHBOARD_PROMPT_DETAIL_CONFIG = {};

	var setDashboardPromptDetail = function(promptObject) {
		DASHBOARD_PROMPT_DETAIL_CONFIG.COLUMN_ID = promptObject.columnId;
		DASHBOARD_PROMPT_DETAIL_CONFIG.PROMPT_OBJECT = promptObject;
		var promptTypeCode = promptObject.promptTypeCode;
		if ($.fn.ifvmIsNotEmpty(promptTypeCode)) {
			$("#promptTypeCode").val(promptTypeCode);
 			if (promptTypeCode === "LIST_BOX") {
				$("#promptTypeDiv1").hide();
				$("#promptTypeDiv2").hide();
				$("#promptTypeDiv3").hide();
				$("#promptTypeDivDefalut").show();			
				
				$("#promptValue1").val("");
				$("#promptValue1Text").val("");
				$("#promptValue2").val("");
				$("#promptValue2Text").val("");
				$("#promptValue3").val("");
				$("#promptValue3Text").val("");
 				
				$("#promptValue1Text").attr("required", false);
				$("#promptValue2Text").attr("required", false);
				$("#promptValue3Text").attr("required", false);
				$("#promptValueDefaultText").attr("required", false);
				
				$("#promptValue1Text").attr("readonly", true);
				$("#promptValue2Text").attr("readonly", true);
				$("#promptValue3Text").attr("readonly", true);
				$("#promptValueDefaultText").attr("readonly", true);
			}
 			if (promptTypeCode === "DATE") {
				$("#promptTypeDiv1").hide();
				$("#promptTypeDiv2").hide();
				$("#promptTypeDiv3").show();
				$("#promptTypeDivDefalut").hide();
				
				$("#promptValue1").val("");
				$("#promptValue1Text").val("");
				$("#promptValue2").val("");
				$("#promptValue2Text").val("");
				$("#promptValue3Text").val(promptObject.promptValue3MarkName);
				$("#promptValue3Text").data("promptValue", promptObject.promptValue3CodeName);
 				
				$("#promptValue1Text").attr("required", false);
				$("#promptValue2Text").attr("required", false);
				$("#promptValue3Text").attr("required", true);
				$("#promptValueDefaultText").attr("required", false);

				
				$("#promptValue1Text").attr("readonly", true);
				$("#promptValue2Text").attr("readonly", true);
				$("#promptValue3Text").attr("readonly", false);
				$("#promptValueDefaultText").attr("readonly", false);
			}

			if (promptTypeCode === "DATE_BETWEEN") {
				$("#promptTypeDiv1").show();
				$("#promptTypeDiv2").show();
				$("#promptTypeDiv3").hide();
				$("#promptTypeDivDefalut").hide();
				
				$("#promptValue1Text").val(promptObject.promptValue1MarkName);
				$("#promptValue1Text").data("promptValue", promptObject.promptValue1CodeName);
				$("#promptValue2Text").val(promptObject.promptValue2MarkName);
				$("#promptValue2Text").data("promptValue", promptObject.promptValue2CodeName);
				$("#promptValue3").val("");
				$("#promptValue3Text").val("");
				
				$("#promptValue1Text").attr("required", true);
				$("#promptValue2Text").attr("required", true);
				$("#promptValue3Text").attr("required", false);
				$("#promptValueDefaultText").attr("required", false);

				
				$("#promptValue1Text").attr("readonly", false);
				$("#promptValue2Text").attr("readonly", false);
				$("#promptValue3Text").attr("readonly", false);
				$("#promptValueDefaultText").attr("readonly", false);
				
			} 
		}
	};

	var showDashboardPromptValueListPop = function(prevTagId) {
		var _prevTag = $("#" + prevTagId);
		var tagId = "dashboardPromptValueListPop";
		var tempObject = $("#" + tagId);

		if ($.fn.ifvmIsEmpty(tempObject)) {
			tempObject = $("<div class='popup_container' />");
			tempObject.attr("id", tagId);
		}
		
		tempObject.data("columnId", DASHBOARD_PROMPT_DETAIL_CONFIG.COLUMN_ID);
		tempObject.ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : "<ifv:url name='dashboardPromptValuePop'/>",
			contentType : "ajax",
			title : "<spring:message code='M01639' />",
			width : "600px",
			ajaxSuccess : function(args) {
				setDashboardPromptValueList(tagId, false);
			},
			beforeClose : function(args) {
				var dataFlag = tempObject.data("dataFlag");
				if($.fn.ifvmIsNotEmpty(dataFlag) && dataFlag) {
					var promptValue = tempObject.data("promptValue");
					_prevTag.val(promptValue.markName);
					_prevTag.data("promptValue", promptValue.codeName);
				}
			}
		});
	};

	var setDashboardPromptDetailData = function(_this) {
		var valid = $("#dashboardPromptValid").ifvValidation();
		
		if (valid.confirm()) {
			
			var popupObject = $(_this).closest(".popup_container");
			popupObject.data("dataFlag", true);

			var promptTypeCode = $("#promptTypeCode").val();
			var promptObject = DASHBOARD_PROMPT_DETAIL_CONFIG.PROMPT_OBJECT;
			promptObject.promptTypeCode = promptTypeCode;
			
			var promptValue1CodeName = $("#promptValue1Text").data("promptValue");
			var promptValue2CodeName = $("#promptValue2Text").data("promptValue");
			var promptValue3CodeName = $("#promptValue3Text").data("promptValue");


			if (promptTypeCode === "DATE_BETWEEN") {
				if(promptValue1CodeName === promptValue2CodeName){
					
					alert('<spring:message code="M01850" />');
					
				}else{
				promptObject.promptValue1MarkName = $("#promptValue1").val();
				promptObject.promptValue1CodeName = promptValue1CodeName;

				promptObject.promptValue2MarkName = $("#promptValue2").val();
				promptObject.promptValue2CodeName = promptValue2CodeName;
				
				promptObject.promptValue3MarkName = null;
				promptObject.promptValue3CodeName = null;
				
				popupObject.data("promptObject", promptObject);
				popupObject.data("ejDialog").close();	
				}
			}
			
			if (promptTypeCode === "DATE") {
				
				promptObject.promptValue1MarkName = null;
				promptObject.promptValue1CodeName = null;

				promptObject.promptValue2MarkName = null;
				promptObject.promptValue2CodeName = null;
				
				promptObject.promptValue3MarkName = $("#promptValue3").val();
				promptObject.promptValue3CodeName = promptValue3CodeName;
				popupObject.data("promptObject", promptObject);
				popupObject.data("ejDialog").close();	
			} 
			
			if (promptTypeCode === "LIST_BOX") {
				
				promptObject.promptValue1MarkName = null;
				promptObject.promptValue1CodeName = null;

				promptObject.promptValue2MarkName = null;
				promptObject.promptValue2CodeName = null;
				
				promptObject.promptValue3MarkName = null;
				promptObject.promptValue3CodeName = null;
				
				popupObject.data("promptObject", promptObject);
				popupObject.data("ejDialog").close();	
			}
		}
	};

	$(document).ready(function() {
		$("#promptTypeDivDefalut").attr("readonly", true);
		$("#promptTypeDiv1").hide();
		$("#promptTypeDiv2").hide();
		$("#promptTypeDiv3").hide();


		$.fn.ifvmSetSelectOptionCommCode("promptTypeCode", "ANL_PRMT_TYPE_CD", null, null, true);
		$("#promptTypeCode").change(function(evt) {
			var promptTypeCode = $(this).val();
			$("#promptValue1").val("");
			$("#promptValue1Text").val("");
			$("#promptValue2").val("");
			$("#promptValue2Text").val("");
			$("#promptValue3").val("");
			$("#promptValue3Text").val("");
			$("#promptValueDefault").val("");
			$("#promptValueDefaultText").val("");
			
			$("#promptValue1").data("promptValue", null);
			$("#promptValue1Text").data("promptValue", null);
			$("#promptValue2").data("promptValue", null);
			$("#promptValue2Text").data("promptValue", null);
			$("#promptValue3").data("promptValue", null);
			$("#promptValue3Text").data("promptValue", null);
			$("#promptValueDefault").data("promptValue", null);
			$("#promptValueDefaultText").data("promptValue", null);

			if (promptTypeCode === "LIST_BOX") {
				$("#promptTypeDiv1").hide();
				$("#promptTypeDiv2").hide();
				$("#promptTypeDiv3").hide();
				$("#promptTypeDivDefalut").show();
				
				$("#promptValue1Text").attr("required", false);
				$("#promptValue2Text").attr("required", false);
				$("#promptValue3Text").attr("required", false);
				$("#promptValueDefaultText").attr("required", false);

				
				$("#promptValue1Text").attr("readonly", true);
				$("#promptValue2Text").attr("readonly", true);
				$("#promptValue3Text").attr("readonly", true);
				$("#promptValueDefaultText").attr("readonly", true);


			} else {
				$("#promptTypeDiv1").hide();
				$("#promptTypeDiv2").hide();
				$("#promptTypeDiv3").show();
				$("#promptTypeDivDefalut").hide();
				
				$("#promptValue1Text").attr("required", false);
				$("#promptValue2Text").attr("required", false);
				$("#promptValue3Text").attr("required", true);
				$("#promptValueDefaultText").attr("required", false);

				
				$("#promptValue1Text").attr("readonly", true);
				$("#promptValue2Text").attr("readonly", true);
				$("#promptValue3Text").attr("readonly", false);
				$("#promptValueDefaultText").attr("readonly", true);

			}

			if (promptTypeCode === "DATE_BETWEEN") {
				$("#promptTypeDiv1").show();
				$("#promptTypeDiv2").show();
				$("#promptTypeDiv3").hide();
				$("#promptTypeDivDefalut").hide();
				
				$("#promptValue1Text").attr("required", true);
				$("#promptValue2Text").attr("required", true);
				$("#promptValue3Text").attr("required", false);
				$("#promptValueDefaultText").attr("required", false);

				
				$("#promptValue1Text").attr("readonly", false);
				$("#promptValue2Text").attr("readonly", false);
				$("#promptValue3Text").attr("readonly", true);
				$("#promptValueDefaultText").attr("readonly", true);

			}

		});

		$(".searchDateFuncBtn").click(function(evt) {
			var prevTag = $(this).prev();
			var prevTagId = prevTag.attr("id");
			var readOnlyFlag = prevTag.attr("readonly");

			if (!Boolean(readOnlyFlag)) {
				showDashboardPromptValueListPop(prevTagId);
			}
		});

		$(".promptValue").change(function(evt) {
			$(this).data("promptValue", null);
		});

		$("#dashboardPromptDetailSaveBtn").click(function(evt) {
			setDashboardPromptDetailData(this);
		});

		$("#dashboardPromptDetailCancelBtn").click(function(evt) {
			var popupObject = $(this).closest(".popup_container");
			popupObject.data("dataFlag", false);

			popupObject.data("ejDialog").close();
		});
	});
</script>

<div id="dashboardPromptValid" class="pop_inner_wrap">
	<div class="analysis_setup_prompt form_horizontal">
		<div class="row qt_border">
			<div class="col-xs-4">
				<label class="control-label text-right">
					<spring:message code="M01640" />
				</label>
			</div>
			<div class="col-xs-8">
				<ifv:input type="select" id="promptTypeCode" names="promptTypeCode" />
			</div>
		</div>
	</div>
	
	<div class="analysis_setup_prompt form-horizontal">
	
		<div class="row qt_border" id="promptTypeDiv1">
			<label class="col-xs-4 control-label text-right"> <span class="asterisk">*</span> <spring:message code="M02972" />
			</label>
			<div class="col-sm-8">
				<div class="input-group">
						<ifv:input type="hidden" id="promptValue1" />
						<input type="text" class="form-control" id="promptValue1Text"><span style="cursor: pointer" class="input-group-addon searchDateFuncBtn" ><i class="fa fa-search"></i>
						</span>
				</div>
			</div>
		</div>
		<div class="row qt_border" id="promptTypeDiv3">
			<label class="col-xs-4 control-label text-right"> <span class="asterisk">*</span> <spring:message code="D10031" />
			</label>
			<div class="col-sm-8">
				<div class="input-group">
						<ifv:input type="hidden" id="promptValue3" />
						<input type="text" class="form-control" id="promptValue3Text"> <span style="cursor: pointer" class="input-group-addon searchDateFuncBtn" ><i class="fa fa-search"></i>
						</span>
				</div>
			</div>
		</div>
		<div class="row qt_border" id="promptTypeDivDefalut">
			<label class="col-xs-4 control-label text-right"> <span class="asterisk">*</span> <spring:message code="M02974" />
			</label>
			<div class="col-sm-8">
				<div class="input-group">
						<ifv:input type="hidden" id="promptValueDefault" />
						<input type="text" class="form-control" id="promptValueDefaultText"> <span style="cursor: pointer" class="input-group-addon searchDateFuncBtn" ><i class="fa fa-search"></i>
						</span>
				</div>
			</div>
		</div>
	</div>
	
	<div class="analysis_setup_prompt form-horizontal">
		<div class="row qt_border" id="promptTypeDiv2">
			<label class="col-xs-4 control-label text-right"> <span class="asterisk">*</span> <spring:message code="M02973" />
			</label>
			<div class="col-sm-8">
				<div class="input-group">
					<ifv:input type="hidden" id="promptValue2" />
					<input type="text" class="form-control" id="promptValue2Text"> <span style="cursor: pointer" class="input-group-addon searchDateFuncBtn"> <i class="fa fa-search"></i>
					</span>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="dashboardPromptDetailSaveBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00039" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="dashboardPromptDetailCancelBtn">
		<spring:message code="C00040" />
	</button>
</div>