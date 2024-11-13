<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="form-horizontal underline top_well" id="tierGrpDsForm">
<br>
	<div class="row">
		<div class="form-horizontal top_well underline" id="reachInfo">
			<div class="row">
				<!-- 고객번호-->
				<ifvm:inputNew type="text" id="dsNm" dto="dsNm" label="데이터셋" labelClass="2" conClass="5" disabled="true" />
					<ifvm:inputNew type="search" id="objNm" dto="objNm" conClass="5" disabled="true" btnFunc="tierGrpDsdataSetPopup"/>
					<%--<span class="input-group-addon" style="padding: 6px;" id="tierGrpDsdataSetPopupBtn">
						<a><i class="fa fa-search"></i></a>
					</span>--%>
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="dataSetItemfieldNm" dto="dataSetItemfieldNm" label="조회기준" labelClass="2" conClass="5" disabled="true" />
					<ifvm:inputNew type="search" id="dataSetItemfieldDesc" dto="dataSetItemfieldDesc" conClass="5" disabled="true" btnFunc="tierFieldItemPopup" />
					<%--<span class="input-group-addon" style="padding: 6px;" id="tierFieldItemBtn">
						<a><i class="fa fa-search"></i></a>
					</span>--%>
			</div>
			<div class="row">
				<ifvm:inputNew type="number" className="text-right" id="extRange" dto="extRange" label="조회기간" labelClass="2" conClass="2" />
				<label class="control-label" style="margin-left:0px">전일기준 N개월
			</div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<!-- 등록 -->
	<button class="btn btn-sm btn_gray" id="saveTierGrpDsBtn" objCode="addTierGrpDsSave_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L01780"/>
	</button>
	<!-- 닫기 -->
	<button class="btn btn-sm btn_gray btn_lightGray2" id="tierGrpDsClose" objCode="addTierGrpDsClose_OBJ">
		<spring:message code="L01781"/>
	</button>
</div>

<div id="tierGrpDsDataSetPop" class="popup_container"></div>
<div id="tierGrpDsDataSetItemPop" class="popup_container"></div>


<script>
var tierGrpDs_isNew;
var dataSetRid;
var tierGrpDsYn;

function tierGrpDsInit(){
	if(typeof tierGrpDsRid === 'undefined' || tierGrpDsRid == null){
		tierGrpDs_isNew = true;
	}
	else {
		tierGrpDs_isNew = false;
		getTierGrpDs();
	}
}

function getTierGrpDs() {
	$.ifvSyncPostJSON('<ifvm:action name="getTierGrpDsDetail"/>',{
		rid  : tierGrpDsRid
	},function(result) {
		dataSetRid = result.dsRid;
		$("#dsNm").val(result.dsNm);
		$("#objNm").val(result.objNm);
		$("#dataSetItemfieldNm").val(result.fieldNm);
		$("#dataSetItemfieldDesc").val(result.fieldDesc);
		$("#extRange").val(result.extRange);
	});
}

function tierGrpDsdataSetPopup() {
	$("#dataSetItemfieldNm").val('');
	$("#dataSetItemfieldDesc").val('');
	$("#tierGrpDsDataSetPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tierGrpDsDataSetPop"/>',
        contentType: "ajax",
        title: '데이터셋 조회',
        width: 680,
        close : 'tierGrpDsDataSetListClosePop'
	});
}

function tierGrpDsDataSetListClosePop() {
	tierGrpDsDataSetPop._destroy();
}

function tierFieldItemPopup() {
	$("#tierGrpDsDataSetItemPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tierGrpDsDataSetItemPop"/>',
        contentType: "ajax",
        title: '데이터셋 아이템 조회',
        width: 650,
        close : 'tierGrpDsDataSetItemClosePop'
	});
}

function tierGrpDsDataSetItemClosePop() {
	tierGrpDsDataSetItemPop._destroy();
}

function saveTierGrpDs(){
	/* if(tierGrpStatCd == 'A' || tierGrpStatCd=='S') {
		alert("작성중일때만 수정할수 있습니다.");
		return;
	} */
	var validation = $("#tierGrpDsForm").ifvValidation();
	//유효성 체크
	if(validation.confirm()){
 		var url = tierGrpDs_isNew? '<ifvm:action name="saveTierGrpDs"/>' : '<ifvm:action name="modifyTierGrpDs"/>';
		var varData = null;
		varData = {
				rid		       			: tierGrpDsRid,
				tierGrpJobRid			: tierGrpJobRid,
				dsRid					: dataSetRid,
				dsItemRid			    : tiersDataSetItemRid,
				extRange   				: $("#extRange").val()
		};
		$.ifvSyncPostJSON(url, varData
			, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					alert("<spring:message code="C00094" />");
				}
			}, function(result) {
				if(result.message) alert(result.message);
				else alert("<spring:message code="M02248" />");
		});
		addTierGrpDsClosePopup();
		tierGrpDs_isNew = false;
		tierGrpDsGridList._doAjax();
	}
}

$(document).ready(function(){
	tierGrpDsInit();
	
	//닫기
	$("#tierGrpDsClose").on("click",function(){
		addTierGrpDsClosePopup();
	});
	
	// $("#tierGrpDsdataSetPopupBtn").click(function(){
	// 	$("#dataSetItemfieldNm").val('');
	// 	$("#dataSetItemfieldDesc").val('');
	// 	tierGrpDsdataSetPopup();
	// });
	
	$("#saveTierGrpDsBtn").click(function(){
		saveTierGrpDs();
	});
	
	// $("#tierFieldItemBtn").click(function(){
	// 	tierFieldItemPopup();
	// });
	
});

</script>