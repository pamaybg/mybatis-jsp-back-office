<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
var condProdInfoPopValidation;
var prodOpenType = '<%= cleanXss(request.getParameter("prodOpenType")) %>';

	function initCondProdInfoPop() {
		$.fn.ifvmSetSelectOptionCommCode("type", "RULESET_TYPE", null, null,
				true);
		$("select[name='type'] option[value='EX']").remove();
		$.fn.ifvmSetSelectOptionCommCode("targetType", "RULESET_TARGET_TYPE",
				null, null, true);
		//채널유형
		condProdInfoPopValidation = $("#condProdInfoPopDiv").ifvValidation();
	}

	function condProdSearchBtnInit() {
		if ($("#condProdInfoPopDiv #targetType").val() == 'ALL') {
			$("#prodSearchBtn").addClass("hidden");
			$("#condProdInfoPopDiv #prodId").val("");
			$("#condProdInfoPopDiv #prodNm").val("");
			$("#condProdInfoPopDiv #prodrid").val("");
		} else {
			$("#prodSearchBtn").removeClass("hidden");
		}
	}

	function condProdListPopupSave() {
		if ($.fn.ifvmIsNotEmpty(condProdPopGrid.getCheckedList())) {
			var data = condProdPopGrid.getCheckedList()[0];

			$("#condProdInfoPopDiv #prodId").val(data.prodId);
			$("#condProdInfoPopDiv #prodNm").val(data.prodNm);
			$("#condProdInfoPopDiv #prodRid").val(data.rid);

		}
		condProdListPopup._destroy();
	}
	function condProdListPopClose() {
		condProdListPopup._destroy();
	}

	function initCondProdInfoPopData(data) {
		$("#condProdInfoPopDiv #type").val(data.type);
		$("#condProdInfoPopDiv #targetType").val(data.targetType);
		$("#condProdInfoPopDiv #prodRid").val(data.prodRid);
		$("#condProdInfoPopDiv #prodId").val(data.prodCd);
		$("#condProdInfoPopDiv #prodNm").val(data.prodNm);

		condProdSearchBtnInit();

	}

	$(document).ready(function() {
		initCondProdInfoPop();
		condProdSearchBtnInit();

		//저장 클릭시
		$('#condProdInfoPopSaveBtn').on('click', function() {
			condProdInfoPopupSave();
		});

		//닫기 클릭시
		$('#condProdInfoPopCancelBtn').on('click', function() {
			condProdInfoPopupClose();
		});

		$('#prodSearchBtn').on('click', function() {
			$("#condProdListPopup").ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : '<ifvm:url name="condProdListPop"/>',
				contentType : "ajax",
				title : '상품 정보',
				width : '700px',
				close : 'condProdListPopClose'
			});
		});

		$("#condProdInfoPopDiv #targetType").on('change', function() {
			condProdSearchBtnInit();
		})

		if (prodOpenType == 'E') {
			initCondProdInfoPopData(selCondProdData);
		}

	});
</script>

<div class="pop_inner_wrap form-horizontal" id="condProdInfoPopDiv">

	<div class="row qt_border">
		<label class="col-xs-3 control-label"><span class="asterisk">*</span>제한유형</label>
		<div class="col-xs-9 control_content">
			<div class="input-group">
				<ifvm:input type="select" required="true" id="type" names="type" />
			</div>
		</div>
	</div>

	<div class="row qt_border">
		<label class="col-xs-3 control-label"><span class="asterisk">*</span>대상</label>
		<div class="col-xs-9 control_content">
			<div class="input-group">
				<ifvm:input type="select" required="true" id="targetType"
					names="targetType" />
			</div>
		</div>
	</div>

	<div class="row qt_border">
		<label class="col-xs-3 control-label"><spring:message
				code="L00231" /></label>
		<div class="col-xs-9 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="prodId" readonly="true" />
				<span class="input-group-addon" id="prodSearchBtn"> <a><i
						class="fa fa-search"></i></a>
				</span>
				<ifvm:inputNew type="hidden" id="prodRid" maxLength="50"
					dto="prodRid" labelClass="0" conClass="2" />
			</div>
		</div>
	</div>

	<div class="row qt_border">
		<label class="col-xs-3 control-label"><spring:message
				code="L00232" /></label>
		<div class="col-xs-9 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="prodNm" readonly="true" />
			</div>
		</div>
	</div>



</div>
<div class="pop_btn_area">
	<button class="btn btn-sm" id="condProdInfoPopSaveBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code='M01855' />
	</button>
	<button class="btn btn-sm" id="condProdInfoPopCancelBtn">
		<spring:message code="M00441" />
	</button>
</div>

<div id="condProdListPopup" class="popup_container"></div>

