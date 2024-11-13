<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
.e-tab .e-active-content {padding: 0;}
</style>

<script>
//탭 관련 URL
var tierDtlUrl 			= '${pageContext.request.contextPath}/loyalty/membership/tiers/include/tierDtlNew';	    	//등급상세
var tierchnlUrl 		= '${pageContext.request.contextPath}/loyalty/membership/tiers/include/tierChnlNew';		//등급실적채널
var tierupMatrixUrl 	= '${pageContext.request.contextPath}/loyalty/membership/tiers/include/tiersCond?type=UP';			//승급룰
var tierdownMatrixUrl 	= '${pageContext.request.contextPath}/loyalty/membership/tiers/include/tiersCond?type=DOWN';			//하향

var rid = null;
var ridTierDflt = null;
var tierGrpNmchk = false;
var ridTierGroup = null;
var title = null;
var status;
var tierDataArr;
var ruleBasType;
var cnt = 0;

var validation;

// 팝업 닫기
function tierPopupClose() {
	dialog._destroy();

	if($.fn.ifvmIsNotEmpty(tierDataArr)){
		$("#tierNm").val(tierDataArr[0].tierNm);
		$("#tierNm").text(tierDataArr[0].rid);
	}
}

// 등급상세 조회
function getTierGrpDtl(){
	$.ifvSyncPostJSON('<ifv:action name="getTierGrpDtl"/>',{rid : rid}
	,function(result) {
 		$("#tierGrpNm").val(result.tierGrpNm);
		$("#tierNm").val(result.tierNm);
		$("#tierNotice").val(result.tierNotice);
		$("#tierNm").text(result.ridTierDflt);
		$("#tierupCyclMmVal").val(result.tierupCyclMmVal);
		$("#validPeriodMmVal").val(result.validPeriodMmVal);
		$("#createBy").val(result.createBy);
		$("#createDate").val(result.createDate);
		$("#tierupRuleBasType").val(result.tierupRuleBasType);
		$("#purCntMinAmt").val(result.purCntMinAmt);
		$("#tierupTxnTermsMm").val(result.tierupTxnTermsMm);
		tierupAplyMmSetting(result.tierupAplyMm);
		ruleBasType = result.tierupRuleBasType;
		ridTierGroup = result.rid;

	});
}

// 등급 수정
function modifyTierGrpList(){
	var obj = {};
	
 	if(validation.confirm()){
		rid = ridTierGroup;
		obj.rid = ridTierGroup;
		obj.tierGrpNm = $("#tierGrpNm").val();
		obj.tierNotice = $("#tierNotice").val();
		obj.tierupCyclMmVal = $("#tierupCyclMmVal").val();
		obj.validPeriodMmVal = $("#validPeriodMmVal").val();
		obj.ridTierDflt = $("#tierNm").text();
		obj.tierupRuleBasType = $("#tierupRuleBasType").val();
		obj.purCntMinAmt = $("#purCntMinAmt").val();
		obj.tierupTxnTermsMm = $("#tierupTxnTermsMm").val();
		obj.tierupAplyMm = tierupAply1mynChk() + tierupAply2mynChk() + tierupAply3mynChk() + tierupAply4mynChk() + tierupAply5mynChk() + tierupAply6mynChk()
						  +tierupAply7mynChk() + tierupAply8mynChk() + tierupAply9mynChk() +tierupAply10mynChk() + tierupAply11mynChk() + tierupAply12mynChk()

		$.ifvSyncPostJSON('<ifv:action name="editTierGrp"/>',obj
		,function(result) {
			alert('<spring:message code="M00624"/>');
			getTierGrpDtl();
		});
	} 
}

// 등급 저장
function setTierGrpList(){
	var obj = {};
	if(tierupAplyCheck() == $("input:checkbox").length){
		alert('<spring:message code="M02003" />');
		return;
	}
	if(validation.confirm()){
		obj.tierGrpNm = $("#tierGrpNm").val();
		obj.tierNotice = $("#tierNotice").val();
		obj.tierupCyclMmVal = $("#tierupCyclMmVal").val();
		obj.validPeriodMmVal = $("#validPeriodMmVal").val();
		obj.ridTierDflt = $("#tierNm").text();
		obj.tierupRuleBasType = $("#tierupRuleBasType").val();
		obj.purCntMinAmt = $("#purCntMinAmt").val();
		obj.tierupTxnTermsMm = $("#tierupTxnTermsMm").val();

		obj.tierupAplyMm = tierupAply1mynChk() + tierupAply2mynChk() + tierupAply3mynChk() + tierupAply4mynChk() + tierupAply5mynChk() + tierupAply6mynChk()
						  +tierupAply7mynChk() + tierupAply8mynChk() + tierupAply9mynChk() +tierupAply10mynChk() + tierupAply11mynChk() + tierupAply12mynChk()

		if(confirm('<spring:message code="M02004" />')){
			$.ifvSyncPostJSON('<ifv:action name="setTierGrp"/>',obj
			,function(result) {
				rid = result.message;
				if(rid != null){
					alert('<spring:message code="M00623"/>');
					qtjs.href('<ifv:url name="tierGroupDtl"/>?rid='+rid+"&status=U");
				}
			});
		}
	}
}

function tierupAply1mynChk(){
	if($("#tierupAply1myn").is(":checked")) return "1";
	else return "0";
}
function tierupAply2mynChk(){
	if($("#tierupAply2myn").is(":checked")) return "1";
	else return "0";
}
function tierupAply3mynChk(){
	if($("#tierupAply3myn").is(":checked")) return "1";
	else return "0";
}
function tierupAply4mynChk(){
	if($("#tierupAply4myn").is(":checked")) return "1";
	else return "0";
}
function tierupAply5mynChk(){
	if($("#tierupAply5myn").is(":checked")) return "1";
	else return "0";
}
function tierupAply6mynChk(){
	if($("#tierupAply6myn").is(":checked")) return "1";
	else return "0";
}
function tierupAply7mynChk(){
	if($("#tierupAply7myn").is(":checked")) return "1";
	else return "0";
}
function tierupAply8mynChk(){
	if($("#tierupAply8myn").is(":checked")) return "1";
	else return "0";
}
function tierupAply9mynChk(){
	if($("#tierupAply9myn").is(":checked")) return "1";
	else return "0";
}
function tierupAply10mynChk(){
	if($("#tierupAply10myn").is(":checked")) return "1";
	else return "0";
}
function tierupAply11mynChk(){
	if($("#tierupAply11myn").is(":checked")) return "1";
	else return "0";
}
function tierupAply12mynChk(){
	if($("#tierupAply12myn").is(":checked")) return "1";
	else return "0";
}

function tierupAplyCheck(){
	cnt = 0;
	for(var i=0; i<$("input:checkbox").length; i++){
		var chk = $("input:checkbox")[i].checked;
		if(!chk){
			cnt++;
		}
	}
	return cnt;
}

var getParameter = function (param) {
    var returnValue;
    var url = location.href;
    var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&');
    for (var i = 0; i < parameters.length; i++) {
        var varName = parameters[i].split('=')[0];
        if (varName.toUpperCase() == param.toUpperCase()) {
            returnValue = parameters[i].split('=')[1];
            return decodeURIComponent(returnValue);
        }
    }
};

$(function(){
	//승급률 기준
	$.ifvSyncPostJSON('<ifv:action name="getCommCodeList"/>',{
		groupCode : 'LOY_TIERUP_BASE_PAR_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#tierupRuleBasTypeTemp").tmpl(result.rows);
		$("#tierupRuleBasType").append(temp);
	});
});

$(document).ready(function() {

    $.ifvmLnbSetting('tierGroupList');

    validation = $("#tiersFormArea").ifvValidation();
	if($.fn.ifvmIsNotEmpty(getParameter('rid'))){
		rid = getParameter('rid');
	}else{
		rid = null;
	}
	ridTierGroup = rid;

	if(rid != null) getTierGrpDtl();

	// 저장버튼
	$("#btnSave").click(function () {
		if(rid != null) modifyTierGrpList();
		else setTierGrpList();
	});

	// 목록버튼
	$("#btnList").click(function () {
		history.pushState(null, null, location.href );
		qtjs.href('<ifv:url name="tierGroupListNew"/>');
	});

	// 신규/수정 상태 설정
	status = getParameter('status');
	if(status == "I"){
		title = '<spring:message code="L00324"/> <spring:message code="M00136"/>';
	}else if(status == "U"){
		title = '<spring:message code="L00324"/> <spring:message code="M00169"/>';
	}
	document.getElementById("innerHTMLtxt").textContent = title;

	// 탭페이지 설정
	// 등급목록
	$("a[href='#tierDtlTab']").click(function(){
 		$.ifvCachedHtml( tierDtlUrl ).done( function(script){
			$("#tierDtlTab").empty();
			$("#tierChnlTab").empty();
			$("#tierupMatrixTab").empty();
			$("#tierDtlTab").html( script );
		});
	});
	// 채널
	$("a[href='#tierChnlTab']").click(function(){
		$.ifvCachedHtml( tierchnlUrl ).done( function(script){
			$("#tierDtlTab").empty();
			$("#tierChnlTab").empty();
			$("#tierupMatrixTab").empty();
			$("#tierChnlTab").html( script );
		});
	});
	// 승급룰
	$("a[href='#tierupMatrixTab']").click(function(){
		$.ifvCachedHtml( tierupMatrixUrl ).done( function(script){
			$("#tierDtlTab").empty();
			$("#tierChnlTab").empty();
			$("#tierupMatrixTab").empty();
			$("#tierupMatrixTab").html( script );
		});
	});
	//기본등급 팝업
	$('#tierBtn').on('click', function(){
		$("#dialog").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifv:url name="tierGrpDtlListPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M01996" />',
	        width: 700,
	        close : 'tierPopupClose'
	    });
	});

	//승급주기(월) 숫자만 입력가능
	$("input[id=tierupCyclMmVal]").keyup(function(event){
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi,''));
		}
	});
	//유효기간(월) 숫자만 입력가능
	$("input[id=validPeriodMmVal]").keyup(function(event){
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi,''));
		}
	});
	$("input[type=radio][name=tierupRuleBasType]").change(function(event){
		ruleBasType = $(':radio[name="tierupRuleBasType"]:checked').val();
	});

	$("#tierupRuleBasType").change(function(event){
		ruleBasType = $("#tierupRuleBasType").val();
	});

});

function tierupAplyMmSetting(tierupAplyMm){
	for(var i = 0; i < tierupAplyMm.length; i++){
		 var index = i+1;
		if(tierupAplyMm[i] == "1"){
			$("input:checkbox[id='tierupAply"+index+"myn']").attr("checked", true);
		}else{
			$("input:checkbox[id='tierupAply"+index+"myn']").attr("checked", false);
		}
	}
}

</script>

<!--승급률 기준  -->
<script id="tierupRuleBasTypeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div class="page-title">
	<h1 id="innerHTMLtxt">
	</h1>
</div>
<div class="page_btn_area">
	<div class="col-xs-7">
	<spring:message code="M02005" />
	</div>
	<div class="col-xs-5 searchbtn_r">
        <button id="btnSave" class="btn btn-sm" objCode="tierGroupbtnSave_OBJ">
        	<i class="glyphicon glyphicon-check"></i>
			<spring:message code="M00137" />
        </button>
        <button id="btnList" class="btn btn-sm" objCode="tierGroupbtnList_OBJ">
			<spring:message code="L00824" />
        </button>
    </div>
</div>
<div id='tiersFormArea'>
	<div class="well form-horizontal">
		<div class="row qt_border">
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M02006" /></label>
			<div class="col-xs-4 control_content">
				<div class="input-group">
					<ifv:input id="tierGrpNm" type="text" required="true"/>
				</div>
			</div>
			<label class="col-xs-2 control-label"><spring:message code="M02007" /></label>
			<div class="col-xs-4 control_content">
				<div class="input-group">
					<ifv:input id="tierNm"  type="text"  readonly="true"/>
					<span class="input-group-addon" id="tierBtn">
					<a><i class="fa fa-search"></i></a>
				</span>
				</div>
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="M02008" /></label>
			<div class="col-sm-10 control_content">
				<div id="tierupAply" class="input-group" >
				<label class="radio-inline"><spring:message code="M01063"/>
				<ifv:input type="checkbox"  id="tierupAply1myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01064"/>
				<ifv:input type="checkbox"  id="tierupAply2myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01065"/>
				<ifv:input type="checkbox"  id="tierupAply3myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01066"/>
				<ifv:input type="checkbox"  id="tierupAply4myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01067"/>
				<ifv:input type="checkbox"  id="tierupAply5myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01068"/>
				<ifv:input type="checkbox"  id="tierupAply6myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01069"/>
				<ifv:input type="checkbox"  id="tierupAply7myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01070"/>
				<ifv:input type="checkbox"  id="tierupAply8myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01071"/>
				<ifv:input type="checkbox"  id="tierupAply9myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01072"/>
				<ifv:input type="checkbox"  id="tierupAply10myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01073"/>
				<ifv:input type="checkbox"  id="tierupAply11myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01074"/>
				<ifv:input type="checkbox"  id="tierupAply12myn"/>
				</label>
				</div>
			</div>

		</div>
		<div class="row qt_border">
			<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="M02012" /></label>
			<div class="col-sm-10 control_content">
				<div class="col-xs-4 control_content">
					<ifv:input type="select" required="true" id="tierupRuleBasType"/>
				</div>

				<label class="radio-inline">
					<span class="asterisk"><spring:message code="M02009" /></span>
				</label>
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-sm-2 control-label"><span class="asterisk">*</span>등급최소유지기간(개월)</label>
			<div class="col-sm-4 control_content">
				<div class="input-group" >
				<ifv:input type="text"  id="validPeriodMmVal" required="true" maxLength="2" />
				</div>
				<span class="detail_txt">등급심사 후 OO월간 하위레벌 등급으로 Down되지 않음</span>
			</div>
			<label class="col-sm-2 control-label"><span class="asterisk">*</span>실적집계범위(개월)</label>
			<div class="col-sm-4 control_content">
				<div class="input-group" >
				<ifv:input type="text" id="tierupTxnTermsMm" required="true" maxLength="2" />
				</div>
				<span class="detail_txt">직전 OO개월 누적실적</span>
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-sm-2 control-label"><span class="asterisk">*</span>최소구매금액(구매횟수)</label>
			<div class="col-sm-4 control_content">
				<div class="input-group" >
				<ifv:input type="text"  id="purCntMinAmt" required="true" />
				</div>
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-sm-2 control-label"><span class="asterisk">*</span>등급 안내문구</label>
			<div class="col-sm-10 control_content">
				<div class="input-group" >
				<ifv:input type="textarea"  id="tierNotice" required="true" rows="5"/>
				</div>
			</div>
		</div>
		<div class="row">
			<label class="col-sm-2 control-label"><spring:message code="M01131"/></label>
			<div class="col-sm-4 control_content">
				<div class="input-group">
				<ifv:input type="text"  id="createBy" disabled="true" />
				</div>
			</div>
			<label class="col-sm-2 control-label"><spring:message code="M01132"/></label>
			<div class="col-sm-4 control_content">
				<div class="input-group" >
				<ifv:input type="text"  id="createDate" disabled="true" />
				</div>
			</div>
		</div>
	</div>
</div>

<div id="tiersTab"></div>
<div id="dialog" class="popup_container"></div>
<div id="popdialog" class="popup_container"></div>

<script type="text/javascript">
var testTab = $('#tiersTab').DrawTab({
	item: [
		{label: '<spring:message code="M01980"/>', href: tierDtlUrl }
		,{label: '<spring:message code="M00506"/>', href: tierchnlUrl }
		,{label: '<spring:message code="M01986"/>', href: tierupMatrixUrl }
		,{label: '하향 룰', href: tierdownMatrixUrl }
	]
});
</script>
