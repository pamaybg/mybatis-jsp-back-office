<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="form-horizontal underline top_well" id="chnlLoyPgmDetail">
<br>
	<div class="row qt_border">
				<ifvm:inputNew type="text" id="pgmNo" names="pgmNo" label="프로그램번호" labelClass="3" conClass="5" required="true" disabled="true"/>
	</div>`
	<div class="row qt_border">
				<ifvm:inputNew type="text" id="pgmNm" names="pgmNm" label="프로그램명" labelClass="3" conClass="5" required="true" disabled="true"/>	
				<span class="input-group-addon" style="padding: 6px;"
					id="loyPgmListBtn"> <a><i class="fa fa-search"></i></a>
				</span>
	</div>
	
	<!-- 분사분담율 --> 
	<div class="row qt_border">
		<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="사용여부"/></label>
		<div class="col-xs-3 control_content">
			<ifvm:inputNew type="select" required="true" id="useYn" dto="useYn" names="useYn" maxLength="5"/>
		</div>
	</div>
	<!-- 채널분담율 -->
	<div class="row qt_border">
		<label class="col-xs-3 control-label"><span class="asterisk">*</span>포인트적립</label>
		<div class="col-xs-3 control_content">
			<ifvm:inputNew type="select" id="pntAcrlYn" names="pntAcrlYn" dto="pntAcrlYn" required="true"/>
		</div>
	</div>
	<!-- 정산율시작일 -->
	<div class="row qt_border">
		<label class="col-xs-3 control-label"><span class="asterisk">*</span>포인트사용</label>
		<div class="col-xs-3 control_content">
			<ifvm:inputNew type="select" id="pntRdmYn" dto="pntRdmYn" names="pntRdmYn" required="true"/>
		</div>
	</div>
	<div class="row qt_border">
		<label class="col-xs-3 control-label"><span class="asterisk">*</span>이벤트참여</label>
		<div class="col-xs-3 control_content">
			<ifvm:inputNew type="select" id="evtYn" names="evtYn" dto="evtYn" required="true"/>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnSave" objCode="addChnlLoyPgmSave_OBJ">
		<spring:message code="C00164" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnCancel" objCode="addChnlLoyPgmCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>
<div id="loyPgmListPopup" class="popup_container"></div>

<script type="text/javascript">
	var isNew;

	function getChnlLoyPgm() {
		$.ifvSyncPostJSON('<ifvm:action name="getLoyPgmDetailNew"/>', {
			rid : chnlPgmRid
		}, function(result) {
			$("#pgmNo").val(result.pgmNo);
			$("#pgmNm").val(result.pgmNm);
			$("#useYn").val(result.useYn);
			$("#pntAcrlYn").val(result.pntAcrlYn);
			$("#pntRdmYn").val(result.pntRdmYn);
			$("#evtYn").val(result.evtYn);
		});
	}

	function chnlLoyPgmInit() {
		$.fn.ifvmSetSelectOptionCommCode("useYn", "COM_STAT_TYPE_3_CD", null, null, true);
		$.fn.ifvmSetSelectOptionCommCode("pntAcrlYn", "COM_STAT_TYPE_3_CD", null, null, true);
		$.fn.ifvmSetSelectOptionCommCode("pntRdmYn", "COM_STAT_TYPE_3_CD", null, null, true);
		$.fn.ifvmSetSelectOptionCommCode("evtYn", "COM_STAT_TYPE_3_CD", null, null, true);
		
		if (typeof chnlPgmRid === 'undefined' || chnlPgmRid == null) {
			isNew = true;
			$("#pgmNo").val("");
			$("#pgmNm").val("");
		} else {
			isNew = false;
			getChnlLoyPgm();
		}
	}

	function saveChnlLoyPgm() {
		var validation = $("#chnlLoyPgmDetail").ifvValidation();

		//유효성 체크
		if (validation.confirm()) {
			var url = isNew ? '<ifvm:action name="saveChnlLoyPgm"/>'
					: '<ifvm:action name="modifyChnlLoyPgm"/>';
			var varData = null;
			varData = {
				rid : rid,
				chnlRid : channelDetail_rid,
				pgmRid : pgmRid,
				useYn : $("#useYn").val(),
				pntAcrlYn : $("#pntAcrlYn").val(),
				pntRdmYn : $("#pntRdmYn").val(),
				evtYn : $("#evtYn").val()
			};
			$.ifvSyncPostJSON(url, varData, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					alert("<spring:message code="C00094" />");
				}
			}, function(result) {
				if (result.message)
					alert(result.message);
				else
					alert("<spring:message code="M02248" />");
			});
			addChnlLoyPgmClosePop();
			getChnlLoyPgmList();
			isNew = false;
		}
	}

	function loyPgmListPop() {
		$("#loyPgmListPopup").ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : '<ifvm:url name="loyPgmListPopup"/>',
			contentType : "ajax",
			title : '로열티 프로그램 등록',
			width : 700,
			close : 'loyPgmListClosePop'
		});
	}

	function loyPgmListClosePop() {
		loyPgmListPopup._destroy();
	}

	$(document).ready(function() {
		chnlLoyPgmInit();

		$("#btnSave").click(function() {
			saveChnlLoyPgm();
		});

		$("#btnCancel").click(function() {
			addChnlLoyPgmClosePop();
		});

		$("#loyPgmListBtn").click(function() {
			loyPgmListPop();
		});
	});
</script>