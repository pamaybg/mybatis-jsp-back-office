<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div id='addBlackMbrDetailForm'>

	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="회원명"/></label>
	        <div class="col-xs-10 control_content">
				<div class="input-group">
				<ifvm:input type="text" disabled="true" id="custNm" dto="custNm" required="true"/>
				<span class="input-group-addon" id="mbrPopBtn">
						<a><i class="fa fa-search"></i></a>
					</span>
				</div>		        
				</div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-2 control-label"><spring:message code="상태"/></label>
	        <div class="col-xs-10 control_content">
	            <ifvm:inputNew type="select" dto="blStatCd" required="true" names="blStatCd" id="blStatCd" />
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="설명"/></label>
	        <div class="col-xs-10 control_content">
					<ifvm:inputNew type="textarea" maxLength="150" id="blContetns" dto="blContetns" labelClass="2" conClass="15" rows="3"/>
	        </div>
	        
	    </div>

	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="saveBlackMbrBtn" objCode="addBlackMbrPop_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L01780"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="blackMbrCancelBtn" objCode="cancelBlackMbrPop_OBJ">
		<spring:message code="L01781"/>
		
	</button>
</div>

<div id="mbrPop" class="popup_container"></div>

<script type="text/javascript">
	var addBlackMbr_isNew;
	var mbrRid;

	function addBlackRulDetailInit() {
		if (typeof blackMbrRid === 'undefined' || blackMbrRid == null) {
			addBlackMbr_isNew = true;
			$.fn.ifvmSetSelectOptionCommCode("blStatCd", "LOY_BL_MEM_STAT_CD", "DIR_SUSP");
			$("#blStatCd").attr("disabled",true);
		} else {
			addBlackMbr_isNew = false;
			$.fn.ifvmSetSelectOptionCommCode("blStatCd", "LOY_BL_MEM_STAT_CD", null,null,true);
			$("#blStatCd").attr("disabled",false);
			getBlackMbrDetail();
		}
	}
	
	function getBlackMbrDetail() {
		$.ifvSyncPostJSON('<ifvm:action name="getBlackMbrDetail"/>', {
			rid : blackMbrRid
		}, function(result) {
			 $("#custNm").val(result.custNm);
			 $("#blContetns").val(result.contents);
			 $("#blStatCd").val(result.statCd);
			 mbrRid = result.mbrRid;
		});
	}

	function saveBlackMbr() {

		var validation = $("#addBlackMbrDetailForm").ifvValidation();
		//유효성 체크
		if (validation.confirm()) {
			var url = addBlackMbr_isNew ? '<ifvm:action name="saveBlackMbr"/>'
					: '<ifvm:action name="modifyBlackMbr"/>';
			var varData = null;
			varData = {
				rid 		 : blackMbrRid,
				blackMbrRid : blackMbrRid,
				blackTxnRid   : blackRuleDetail_rid,
				blackMstRid   : blackRuleDetail_rid,
				mbrRid      : mbrRid,
				contents    : $("#blContetns").val(),
				statCd    : $("#blStatCd").val()
			};
			$.ifvSyncPostJSON(url, varData, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					alert("<spring:message code="C00094" />");
					addBlackMbrClosePopup();
					addBlackMbr_isNew = false;
					blackMbrList._doAjax();
				}
			}, function(result) {
				if (result.message != null)
					alert(result.message);
				else
					alert("<spring:message code="M02248" />");
			});
		}
	}
	
	function mbrPopup() {
		$("#mbrPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="mbrListPop"/>',
	        contentType: "ajax",
	        title: '회원 조회',
	        width: 900,
	        close : 'mbrClosePop'
		});
	}
	function mbrClosePop() {
		mbrPop._destroy();
	}

	$(document).ready(function() {
		addBlackRulDetailInit();

		$("#saveBlackMbrBtn").click(function() {
			saveBlackMbr();
		});

		$("#blackMbrCancelBtn").click(function() {
			addBlackMbrClosePopup();
		});
		
		$("#mbrPopBtn").click(function() {
			mbrPopup();
		});

	});
</script>