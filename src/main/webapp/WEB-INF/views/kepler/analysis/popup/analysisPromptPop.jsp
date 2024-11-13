<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var PROMPT_CONFIG = {};
	PROMPT_CONFIG.PROMPT_ID = null;
	PROMPT_CONFIG.ATRIB_GROUP_COLUMN_ID = null;

	PROMPT_CONFIG.ANL_PRMT_TYPE_CD = "ANL_PRMT_TYPE_CD";
	PROMPT_CONFIG.MKT_DT_DEFAULT = "MKT_DT_DEFAULT";

	PROMPT_CONFIG.PROMPT_TYPE_CD = {};
	PROMPT_CONFIG.PROMPT_TYPE_CD.LIST_BOX = "LIST_BOX";
	PROMPT_CONFIG.PROMPT_TYPE_CD.DATE = "DATE";
	PROMPT_CONFIG.PROMPT_TYPE_CD.DATE_BETWEEN = "DATE_BETWEEN";

	var getAnalysisPromptDetail = function(promptId) {
		PROMPT_CONFIG.PROMPT_ID = promptId;

		$.ifvSyncPostJSON("<ifv:action name='getAnalysisPromptDetail' />", {
			analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
			promptId : promptId,
			promptTypeCodeGroup : PROMPT_CONFIG.MKT_DT_DEFAULT,
			analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG
		}, function(rst) {
			
			PROMPT_CONFIG.ATRIB_GROUP_COLUMN_ID = rst.atribGroupColumnId;
			
			var promptTypeCode = rst.promptTypeCode;
			$("#promptTypeCode").val(promptTypeCode);
			
			if (promptTypeCode === PROMPT_CONFIG.PROMPT_TYPE_CD.LIST_BOX) {
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
			if(promptTypeCode === PROMPT_CONFIG.PROMPT_TYPE_CD.DATE) {
				$("#promptTypeDiv1").hide();
				$("#promptTypeDiv2").hide();
				$("#promptTypeDiv3").show();
				$("#promptTypeDivDefalut").hide();
				
				$("#promptValue1").val("");
				$("#promptValue1Text").val("");
				$("#promptValue2").val("");
				$("#promptValue2Text").val("");
				$("#promptValue3").val(rst.promptValue3);
				$("#promptValue3Text").val(rst.promptValue3Text);
 				
				$("#promptValue1Text").attr("required", false);
				$("#promptValue2Text").attr("required", false);
				$("#promptValue3Text").attr("required", true);
				$("#promptValueDefaultText").attr("required", false);

				
				$("#promptValue1Text").attr("readonly", true);
				$("#promptValue2Text").attr("readonly", true);
				$("#promptValue3Text").attr("readonly", false);
				$("#promptValueDefaultText").attr("readonly", false);

			}

			if (promptTypeCode === PROMPT_CONFIG.PROMPT_TYPE_CD.DATE_BETWEEN) {
				$("#promptTypeDiv1").show();
				$("#promptTypeDiv2").show();
				$("#promptTypeDiv3").hide();
				$("#promptTypeDivDefalut").hide();			
				
				$("#promptValue1").val(rst.promptValue1);
				$("#promptValue1Text").val(rst.promptValue1Text);
				$("#promptValue2").val(rst.promptValue2);
				$("#promptValue2Text").val(rst.promptValue2Text);
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
			
		});
	};

	var setAnalysisPromptSave = function() {
		var valid = $("#analysisPromptValid").ifvValidation();

		if (valid.confirm()) {
			var promptTypeCode = $("#promptTypeCode").val();
			var promptValue1 = $("#promptValue1").val();
			var promptValue2 = $("#promptValue2").val();
			var promptValue3 = $("#promptValue3").val();

			var promptValue1Text = $("#promptValue1Text").val();
			var promptValue2Text = $("#promptValue2Text").val();
			var promptValue3Text = $("#promptValue3Text").val();


			if (promptTypeCode === PROMPT_CONFIG.PROMPT_TYPE_CD.DATE) {
				var saveFlag = confirm("<spring:message code='M01635' />");
				if (saveFlag === true) {

					$.ifvPostJSON("<ifv:action name='editAnalysisPromptDetail' />", {
						analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
						promptId : PROMPT_CONFIG.PROMPT_ID,
						promptTypeCode : promptTypeCode,
						promptValue1 : promptValue1,
						promptValue2 : promptValue2,
						promptValue3 : promptValue3,

						promptValue1Text : promptValue1Text,
						promptValue2Text : promptValue2Text,
						promptValue3Text : promptValue3Text,
						promptTypeCodeGroup : PROMPT_CONFIG.MKT_DT_DEFAULT,
						analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG
					}, function(rst) {
						alert("<spring:message code='C00094' />");
	
						$("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_PROMPT_POP).data("ejDialog").close();
					});
				}
			} 
				
			if(promptTypeCode === PROMPT_CONFIG.PROMPT_TYPE_CD.LIST_BOX){
			    var saveFlag = confirm("<spring:message code='M01635' />");
			    if (saveFlag === true) {
					$.ifvPostJSON("<ifv:action name='editAnalysisPromptDetail' />", {
						analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
						promptId : PROMPT_CONFIG.PROMPT_ID,
						promptTypeCode : promptTypeCode,
						promptValue1 : promptValue1,
						promptValue2 : promptValue2,
						promptValue3 : promptValue3,

						promptValue1Text : promptValue1Text,
						promptValue2Text : promptValue2Text,
						promptValue3Text : promptValue3Text,

						promptTypeCodeGroup : PROMPT_CONFIG.MKT_DT_DEFAULT,
						analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG
					}, function(rst) {
						alert("<spring:message code='C00094' />");

						$("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_PROMPT_POP).data("ejDialog").close();
					});
			  	}
			}
			
			if(promptTypeCode === PROMPT_CONFIG.PROMPT_TYPE_CD.DATE_BETWEEN){
					if(promptValue1 === promptValue2){
						alert('<spring:message code="M01850" />');
					}else{
					    var saveFlag = confirm("<spring:message code='M01635' />");
					    if (saveFlag === true) {
							$.ifvPostJSON("<ifv:action name='editAnalysisPromptDetail' />", {
								analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
								promptId : PROMPT_CONFIG.PROMPT_ID,
								promptTypeCode : promptTypeCode,
								promptValue1 : promptValue1,
								promptValue2 : promptValue2,
								promptValue3 : promptValue3,
		
								promptValue1Text : promptValue1Text,
								promptValue2Text : promptValue2Text,
								promptValue3Text : promptValue3Text,
		
								promptTypeCodeGroup : PROMPT_CONFIG.MKT_DT_DEFAULT,
								analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG
							}, function(rst) {
								alert("<spring:message code='C00094' />");
		
								$("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_PROMPT_POP).data("ejDialog").close();
							});
					  	}
				}
			}
		}	
	};

	var setAnalysisPromptDateFuncSave = function(targetId, codeName, markName) {
		$("#" + targetId).val(codeName);
		$("#" + targetId + "Text").val(markName);

		$("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_PROMPT_DATE_FUNC_POP).data("ejDialog").close();
	};

	$(document).ready(function() {
		$("#promptTypeDivDefalut").attr("readonly", true);
		$("#promptTypeDiv1").hide();
		$("#promptTypeDiv2").hide();
		$("#promptTypeDiv3").hide();


		$.ifvSyncPostJSON("<ifv:action name='getCommCodeList'/>", {
			groupCode : PROMPT_CONFIG.ANL_PRMT_TYPE_CD,
			enableNA : false
		}, function(rst) {
			var tmpl = $("#analysisOptionTypeCodeTemplate").tmpl(rst.rows);
			$("#promptTypeCode").append(tmpl);
		});

		$("#promptTypeCode").change(function(evt) {
			var promptTypeCode = $(this).val();

			if (promptTypeCode === PROMPT_CONFIG.PROMPT_TYPE_CD.LIST_BOX) {
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


			} else {
				$("#promptTypeDiv1").hide();
				$("#promptTypeDiv2").hide();
				$("#promptTypeDiv3").show();
				$("#promptTypeDivDefalut").hide();

				$("#promptValue1").val("");
				$("#promptValue1Text").val("");
				$("#promptValue2").val("");
				$("#promptValue2Text").val("");
				$("#promptValue3").val("");
				$("#promptValue3Text").val("");
				
				$("#promptValue1Text").attr("required", false);
				$("#promptValue2Text").attr("required", false);
				$("#promptValue3Text").attr("required", true);
				$("#promptValueDefaultText").attr("required", false);

				
				$("#promptValue1Text").attr("readonly", true);
				$("#promptValue2Text").attr("readonly", true);
				$("#promptValue3Text").attr("readonly", false);
				$("#promptValueDefaultText").attr("readonly", true);

			}

			if (promptTypeCode === PROMPT_CONFIG.PROMPT_TYPE_CD.DATE_BETWEEN) {
				$("#promptTypeDiv1").show();
				$("#promptTypeDiv2").show();
				$("#promptTypeDiv3").hide();
				$("#promptTypeDivDefalut").hide();

				$("#promptValue1").val("");
				$("#promptValue1Text").val("");
				$("#promptValue2").val("");
				$("#promptValue2Text").val("");
				$("#promptValue3").val("");
				$("#promptValue3Text").val("");
				
				$("#promptValue1Text").attr("required", true);
				$("#promptValue2Text").attr("required", true);
				$("#promptValue3Text").attr("required", false);
				$("#promptValueDefaultText").attr("required", false);

				
				$("#promptValue1Text").attr("readonly", false);
				$("#promptValue2Text").attr("readonly", false);
				$("#promptValue3Text").attr("readonly", true);
				$("#promptValueDefaultText").attr("readonly", true);

			}

			$("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_PROMPT_POP).data("ejDialog").refresh();
		});

		$(".searchDateFuncBtn").click(function(evt) {
			var prevTag = $(this).prev();
			var readOnlyFlag = prevTag.attr("readonly");

			if (!$.fn.ifvmIsNotEmpty(readOnlyFlag)) {
				var firstTag = prevTag.prev();
				var analysisPromptDateFuncPop = $("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_PROMPT_DATE_FUNC_POP);
				var tempPopObj = null;

				if (!$.fn.ifvmIsNotEmpty(analysisPromptDateFuncPop)) {
					tempPopObj = $("<div class='popup_container' />");
					tempPopObj.attr("id", ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_PROMPT_DATE_FUNC_POP);
				} else {
					tempPopObj = analysisPromptDateFuncPop;
				}

				tempPopObj.ifvsfPopup({
					enableModal : true,
					enableResize : false,
					contentUrl : "<ifv:url name='analysisPromptDateFuncPop'/>",
					contentType : "ajax",
					title : "<spring:message code='M01639' />",
					width : "600px",
					ajaxSuccess : function(args) {
						PROMPT_DATE_CONFIG.TARGET_ID = firstTag.attr("id");
						setPromptDateFuncList();
					}
				});
			}
		});

		$(".promptValue").change(function(evt) {
			$(this).prev().val("");
		});

		$("#analysisPromptSaveBtn").click(function(evt) {
			setAnalysisPromptSave();
		});

		$("#analysisPromptCancelBtn").click(function(evt) {
			$("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_PROMPT_POP).data("ejDialog").close();
		});
	});
</script>

<div class="pop_inner_wrap" id="analysisPromptValid">
	<div class="analysis_setup_prompt form-horizontal">
		<div class="row qt_border">
			<label class="col-xs-4 control-label text-right"> <spring:message code="M01640" />
			</label>
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
	<button class="btn btn-sm btn_gray" id="analysisPromptSaveBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00039" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="analysisPromptCancelBtn">
		<spring:message code="C00040" />
	</button>
</div>