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

var mbr_rid = '<%= cleanXss(request.getParameter("rid")) %>';
var isNew = true;  //신규 여부. 신규: true, 수정 : false
var isMask = true;
var maskYN = '<%= cleanXss(request.getParameter("maskYN")) %>'; // 마스킹 된 상태
if(maskYN != null && maskYN == "N") isMask = false;

var validation;
var popSelectlId;
var rid;

var curResultObj;
var vocPointAcrlRdmPopObj;

/* 팝업 닫기 */
function popupClose(){
	$('#popupContainer').ejDialog('destroy');
}

//상세 팝업 화면 호출
function pointDtlPopShow(){
	if ($.fn.ifvmIsNotEmpty(tabContent.getCheckedList())) {

		var selPnt = tabContent.getCheckedList()[0];
		rid = selPnt.txnUniqNo;


		$("#pointDialog").ifvsfPopup({
			enableModal : true,
	    	enableResize: false,
	    	contentUrl: '<ifvm:url name="pointDtlPopList"/>',
	    	contentType: "ajax",
			title: '<spring:message code="L00477"/>', //포인트 상세,
			width: '1000px',
			close : 'pointDtlPopShowClose'
	  	});
	}else{
 		$.ifvErrorPop('<spring:message code="L00066"/>');
	}
}

//팝업 닫기
function pointDtlPopClose() {
	$('#pointDialog').ejDialog('destroy');
}




//VOC 요청 팝업 화면 호출
var vocPopupContainer;
function showVocPointPop(){

	if(maskYN == "Y"){
		alert("");
		return;
	}

	vocPointAcrlRdmPopObj = new Object();

	vocPointAcrlRdmPopObj.ridChnl = curResultObj.ridChnlJoin;
	vocPointAcrlRdmPopObj.chnlNo = curResultObj.chnlNo; // 없음
	vocPointAcrlRdmPopObj.rid = curResultObj.rid;
	vocPointAcrlRdmPopObj.mbrNo = curResultObj.mbrNo;
	vocPointAcrlRdmPopObj.identiType = curResultObj.identiTypeCd;
	vocPointAcrlRdmPopObj.identiVal = curResultObj.identiVal;
	vocPointAcrlRdmPopObj.mbrStatCd = curResultObj.mbrStatCd;

	$("#vocPopupContainer").ifvsfPopup({
		enableModal : true
        ,enableResize: false
        ,allowKeyboardNavigation : false
        ,contentUrl: '<ifvm:url name="vocPointAcrlRdmPop"/>'
        ,contentType: "ajax"
        ,title: '<spring:message code="L00504" />'
        ,width: '700px'
        ,close : 'popCancelClose'
    });
	vocPopupContainer = $("#vocPopupContainer").data("ejDialog");
}

function popCancelClose() {
	vocPopupContainer._destroy();
}

//팝업 종료
function popClose() {
	$('#vocPopupContainer').ejDialog('destroy');
	changeContent('mbrPtnTxnHistList', '');
}



function dataLoad(mbr_rid) {
	isNew = false;	// 해당 함수는 수정모드일 경우에만 호출되므로, 신규 여부 플래그 값을 false로 세팅함.
	var action = isMask ? '<ifvm:action name="getVocMemberDetail"/>' : '<ifvm:action name="clearMaskMbr"/>';

	$.ifvSyncPostJSON(action, {
		rid: mbr_rid
	}, function(result) {
		if($.fn.ifvmIsNotEmpty(result)) {

		//	$("#ridCust").val(result.ridCust); //고객명

			$("#ridCust"      ).text(result.ridCust);            /*고객 rid */
			$("#ridCust"      ).val(result.mbrNm);			     /*고객명 */
			$("#custTypeCd"   ).val(result.custTypeCd);          /*고객 유형 코드  */
			$("#identiTypeCd" ).val(result.identiTypeCd);        /*식별값유형       */
			$("#identiVal"    ).val(result.identiVal);           /*식별값           */


			$("#mbrNo"        ).val(result.mbrNo);                 /* 회원 번호 */
			$("#mbrStatCd"     ).val(result.mbrStatCd     );        /* 회원 상태 코드 */
			$("#mbrTypeCd"     ).val(result.mbrTypeCd     );        /* 회원 유형 코드 */
			$("#joinDate"      ).val(result.joinDate      );        /* 가입 일자 */
			$("#ridTierCur"    ).text(result.ridTierCur   );        /* RID_등급 현재 */
			$("#ridTierCur"    ).val(result.tierNm        );        /* 등급명 */
			$("#curTierSelDate").val(result.curTierSelDate);        /* 현재 등급 선정 일자 */
			$("#ridChnlJoin"   ).text(result.ridChnlJoin  );        /* RID_채널_가입 */
			$("#ridChnlJoin"   ).val(result.chnlJoinNm    );        /* 가입채널명*/
			$("#ridPgm"        ).text(result.ridPgm       );        /* RID_PGM */
			$("#ridPgm"        ).val(result.pgmNm         );        /* 프로그램명 */

			$("#hhpNo"           ).val(result.hhpNo           );
			$("#homeTelNo"       ).val(result.homeTelNo       );
			$("#emailAddr"       ).val(result.emailAddr       );
			$("#grpCustEmpName"  ).val(result.grpCustEmpName  );
			$("#addr1Zip"        ).val(result.addr1Zip        );
			$("#addr1Dflt"       ).val(result.addr1Dflt       );
			$("#addr1Dtl"        ).val(result.addr1Dtl        );

			$.fn.ifvmSetChekBoxValue("#mktAgrePrvInfo"   , result.mktAgrePrvInfo);
			$.fn.ifvmSetChekBoxValue("#mktAgreUse"       , result.mktAgreUse);
			$.fn.ifvmSetChekBoxValue("#mktAgreThirdSnd"  , result.mktAgreThirdSnd);
			$.fn.ifvmSetChekBoxValue("#chnlAgreSms"      , result.chnlAgreSms);
			$.fn.ifvmSetChekBoxValue("#chnlAgreEmail"    , result.chnlAgreEmail);
			$.fn.ifvmSetChekBoxValue("#chnlAgreTel"      , result.chnlAgreTel);
			$.fn.ifvmSetChekBoxValue("#chnlAgreDm"       , result.chnlAgreDm);
			$.fn.ifvmSetChekBoxValue("#chnlAgrePush"     , result.chnlAgrePush);
			$.fn.ifvmSetChekBoxValue("#mbrTermsAgre"      , result.mbrTermsAgre);
			$.fn.ifvmSetChekBoxValue("#mktAgreLbsBiz"       , result.mktAgreLbsBiz);
			$.fn.ifvmSetChekBoxValue("#mktAgreLbsSvc"     , result.mktAgreLbsSvc);

			curResultObj = result;
		}
	});
}


$(function(){

	//고객유형코드
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'LOY_CUST_TYPE_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#custTypeCdTemp").tmpl(result.rows);
		$("#custTypeCd").append(temp);
	});

	//고객식별유형
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'LOY_IDENTI_TYPE_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#identiTypeCdTemp").tmpl(result.rows);
		$("#identiTypeCd").append(temp);
	});


	//회원상태
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'LOY_MEM_STAT_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#mbrStatCdTemp").tmpl(result.rows);
		$("#mbrStatCd").append(temp);
	});



	//회원유형
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'LOY_MEM_TYPE_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#mbrTypeCdTemp").tmpl(result.rows);
		$("#mbrTypeCd").append(temp);
	});


	if($.fn.ifvmIsNotEmpty(mbr_rid) && mbr_rid != "null") dataLoad(mbr_rid); //수정 시

});




//페이지 구하기
function getGridPage() {
    var rtnVal = 1;
    var page = tabContent.opt.data.page;
    var total = tabContent.opt.data.records;
    if (total % page > 0) {
        rtnVal = page;
    }

    return rtnVal;
}

function btnActive() {
	if(isNew) { //신규일 경우
		$('#btnMasking').prop('disabled', true); //마스킹해제 버튼 disable
		$('#btnDropMbr').prop('disabled', true); //탈회 버튼 disable

	}else { // 수정모드 일경우
		if(isMask) $('#btnSave').prop('disabled', true); //마스킹 된 상태일때는 저장버턴 비활성화
		else $('#btnMasking').prop('disabled', true); //마스킹해제 버튼 disable

		///input disabled
		$("#ridCust").attr("disabled", true); //고객명 비활성화
		$('#btnFundRidCustPop').hide();  //고객버튼 숨기기

		$("#custTypeCd").attr("disabled", true);  //고객유형 비활성화
		$("#identiTypeCd").attr("disabled", true);  // 식별값 유형 비활성화
		$("#identiVal").attr("disabled", true);  // 식별값 비활성화

		$("#mbrNo").attr("disabled", true);  //회원번호 비활성화
		$("#mbrStatCd").attr("disabled", true);  // 회원상태 비활성화
		$("#mbrTypeCd").attr("disabled", true);  // 회원유형 비활성화

		$("#joinDate").attr("disabled", true);  // 가입일자 비활성화
		$("#ridTierCur").attr("disabled", true);  // 현재등급 비활성화
		$("#curTierSelDate").attr("disabled", true);  // 등급선정일자 비활성화
		$("#ridChnlJoin").attr("disabled", true);  //가입채널 비활성화
		$("#btnFundRidChnlJoinPop").hide();  //가입채널 비활성화

		$("#ridPgm").attr("disabled", true);  //프로그램 비활성화
		$("#btnFundRidPgmPop").hide();  //프로그램버튼 숨기기



	}

}
function checkButtnAuth(){
	var isAuth = false;
	var authArr = $.ifvmGetAuthInfo().authList;
	for(var i = 0 ; i < authArr.length ; i++){
		var authObj = authArr[i];
		var authName = authObj.authName;
		if(authName == 'E10010') isAuth = true;
	}
	if(!isAuth){
		$("#btnMasking").remove();
	}
}
$(document).ready(function(){
	//마스킹해제 권한 체크
	//checkButtnAuth();

	btnActive();
	$("input").each(function(i, _this){ $(_this).prop("disabled", "disabled") });
	$("select").each(function(i, _this){ $(_this).prop("disabled", "disabled") });

	$.ifvmLnbSetting('vocMemberList');  //Left Menue 세팅

	$("#btnSave").click(function(){

		actionSave();
    });

	$("#btnMasking").click(function(){
		qtjs.href('<ifvm:url name="vocMemberDetail"/>' + '?maskYN=N&rid=' + mbr_rid );
    });

	$("#btnList").click(function(){
		qtjs.href('<ifvm:url name="vocMemberList"/>');
    });

	validation = $("#mbrForm").ifvValidation();

});


</script>

<!-- 고객유형 -->
<script id="custTypeCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<!--식별 유형 코드  -->
<script id="identiTypeCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<!-- 회원유형 -->
<script id="mbrTypeCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<!-- 회원상태  -->
<script id="mbrStatCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>


<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
</style>

<div class="page-title">
	<h1>
		<spring:message code="L00431"/> &gt; <spring:message code="L00079"/>
	</h1>
</div>

<div class="page_btn_area" id="headForm">
	<div class="col-xs-7">
		<span>고객 정보</span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="btnMasking"><spring:message code="L00326"/></button>
		<button class="btn btn-sm" id="btnList"><spring:message code="M00002"/></button>
	</div>
</div>


<div class="form-horizontal underline top_well" id="mbrForm" >
	<div class="row  qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00320"/></label>
		<div class="col-xs-4 control_content">
			<div class="input-group">
			<ifvm:input type="text" disabled="true" required="true" id="ridCust"/>
			<span class="input-group-addon" id="btnFundRidCustPop">
					<a><i class="fa fa-search"></i></a>
			</span>
		   </div>
		</div>

		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00318"/></label>
		<div class="col-xs-3 control_content">
			<ifvm:input type="select" disabled="true" required="true" id="custTypeCd"/>
		</div>

	</div>
	<div class="row  qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00343"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="select" disabled="true" required="true" id="identiTypeCd" />
		</div>
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00342"/></label>
		<div class="col-xs-3 control_content">
			<ifvm:input type="text" disabled="true" required="true"  id="identiVal"/>
		</div>
	</div>

<div class="page_btn_area" id="headForm">
	<div class="col-xs-7">
		<span><spring:message code="L00321"/></span>
	</div>
</div>
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><spring:message code="L00433"/></label>
		<div class="col-xs-4 control_content">
				<ifvm:input type="text" disabled="true" id="mbrNo"/>
		</div>
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00090"/></label>
		<div class="col-xs-3 control_content">
			<ifvm:input type="select" disabled="true" required="true" id="mbrStatCd" />
		</div>
	</div>

	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00434"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="select" required="true" id="mbrTypeCd"/>
		</div>
		<label class="col-xs-2 control-label"><spring:message code="L00311"/></label>
		<div class="col-xs-3 control_content">
			<ifvm:input type="text" disabled="true" id="joinDate" />
		</div>
	</div>

	<div class="row qt_border">
		<label class="col-xs-2 control-label"><spring:message code="L00429"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="text" disabled="true" id="ridTierCur"/>
		</div>
		<label class="col-xs-2 control-label">등급선정일자</label>
		<div class="col-xs-3 control_content">
			<ifvm:input type="text" id="curTierSelDate" disabled="true" />
		</div>
	</div>

	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00312"/></label>
		<div class="col-xs-4 control_content">
			<div class="input-group">
			<ifvm:input type="text"  id="ridChnlJoin" required="true" disabled="true" />
			<span class="input-group-addon" id="btnFundRidChnlJoinPop">
					<a><i class="fa fa-search"></i></a>
			</span>
		   </div>
		</div>
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00119"/></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
			<ifvm:input type="text"  id="ridPgm" required="true" disabled="true" />
			<span class="input-group-addon" id="btnFundRidPgmPop">
					<a><i class="fa fa-search"></i></a>
			</span>
		   </div>
		</div>
	</div>

   <div class="half_wrap top_well">
	<div class="half_content half_left">
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L00380"/></span>
			</div>
		</div>
		<div class="form-horizontal top_well underline" id="reachInfo" >
			<div class="row  qt_border">
				<label class="col-xs-2 control-label"><spring:message code="L00436"/></label>
				<div class="col-xs-4 control_content">
					<ifvm:input type="text" id="hhpNo" disabled="true" />
				</div>
				<label class="col-xs-2 control-label"><spring:message code="L00404"/></label>
				<div class="col-xs-4 control_content">
					<ifvm:input type="text" id="homeTelNo" disabled="true" />
				</div>
			</div>

			<div class="row qt_border">
				<label class="col-xs-2 control-label"><spring:message code="L00395"/></label>
				<div class="col-xs-4 control_content">
					<ifvm:input type="text" id="emailAddr" disabled="true" />
				</div>
				<label class="col-xs-2 control-label"><spring:message code="L00323"/></label>
				<div class="col-xs-4 control_content">
					<ifvm:input type="text" id="grpCustEmpName" disabled="true" />
				</div>
			</div>

			<div class="row qt_border">
				<label class="col-xs-2 control-label"><spring:message code="L00405"/></label>
				<div class="col-xs-3 control_content">
					<div class="input-group">
						<ifvm:input type="text" id="addr1Zip" disabled="true" />
					</div>
				</div>
				<div class="col-xs-7 control_content">
					<ifvm:input type="text" disabled="true" id="addr1Dflt" />
				</div>

		   </div>

			<div class="row">
				<label class="col-xs-2 control-label"> </label>
				<div class="col-xs-10 control_content">
					<ifvm:input type="text" id="addr1Dtl" disabled="true" />
				</div>
		   </div>
		</div>
	</div>
	<div class="half_content half_right">
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L00327"/></span>
			</div>
		</div>
		<div class="form-horizontal top_well underline" id="mktAgree" >
			<div class="row  qt_border">
				<label class="col-xs-3 control-label"><spring:message code="L00315"/></label>
				<div class="col-xs-1 control_content">
					<label class="checkbox-inline">
					<ifvm:input type="checkbox" id="mktAgrePrvInfo"  disabled="true"/>
					</label>
				</div>
				<label class="col-xs-3 control-label"><spring:message code="L00328"/></label>
				<div class="col-xs-1 control_content">
					<label class="checkbox-inline">
					<ifvm:input type="checkbox" id="mktAgreUse"  disabled="true"/>
					</label>
				</div>
				<label class="col-xs-3 control-label"><spring:message code="L00401"/></label>
				<div class="col-xs-1 control_content">
				<label class="checkbox-inline">
			        <ifvm:input type="checkbox" id="mktAgreThirdSnd"  disabled="true"/>
     			</label>
				</div>
			</div>
			<div class="row  qt_border">
				<label class="col-xs-3 control-label"><spring:message code="L00517"/></label>
				<div class="col-xs-1 control_content">
					<label class="checkbox-inline">
					<ifvm:input type="checkbox" id="chnlAgreSms"  disabled="true"/>
					</label>
				</div>
				<label class="col-xs-3 control-label"><spring:message code="L00307"/></label>
				<div class="col-xs-1 control_content">
					<label class="checkbox-inline">
					<ifvm:input type="checkbox" id="chnlAgreEmail" disabled="true" />
					</label>
				</div>
				<label class="col-xs-3 control-label"><spring:message code="L00308"/></label>
				<div class="col-xs-1 control_content">
					<label class="checkbox-inline">
					<ifvm:input type="checkbox" id="chnlAgreTel" disabled="true" />
					</label>
				</div>
			</div>
			<div class="row  qt_border">
				<label class="col-xs-3 control-label"><spring:message code="L00306"/></label>
				<div class="col-xs-1 control_content">
					<label class="checkbox-inline">
					<ifvm:input type="checkbox" id="chnlAgreDm" />
					</label>
				</div>
				<label class="col-xs-3 control-label"><spring:message code="L00346"/></label>
				<div class="col-xs-1 control_content">
					<label class="checkbox-inline">
					<ifvm:input type="checkbox" id="chnlAgrePush" />
					</label>
				</div>
				<label class="col-xs-3 control-label"><spring:message code="L00518"/></label>
				<div class="col-xs-1 control_content">
					<label class="checkbox-inline">
					<ifvm:input type="checkbox" id="mbrTermsAgre" />
					</label>
				</div>
			</div>
			<div class="row  qt_border">
				<label class="col-xs-3 control-label"><spring:message code="L00519"/></label>
				<div class="col-xs-1 control_content">
					<label class="checkbox-inline">
					<ifvm:input type="checkbox" id="mktAgreLbsBiz" />
					</label>
				</div>
				<label class="col-xs-3 control-label"><spring:message code="L00520"/></label>
				<div class="col-xs-1 control_content">
					<label class="checkbox-inline">
					<ifvm:input type="checkbox" id="mktAgreLbsSvc" />
					</label>
				</div>
			</div>
		</div>
	</div>
  </div>
</div>

<div id="tabArea">
	<div class="btn-group btn-group-justified" id="tabType">
		<a href="javascript:;" class="btn btn-default btn-tab active" id="mbrPtnBalList"><spring:message code="L00464"/></a>
		<a href="javascript:;" class="btn btn-default btn-tab" id="mbrPtnTxnHistList"><spring:message code="L00423"/></a>
		<a href="javascript:;" class="btn btn-default btn-tab" id="mbrCardList"><spring:message code="L00412"/></a>
		<a href="javascript:;" class="btn btn-default btn-tab" id="mbrTierHistList"><spring:message code="L00366"/></a>
		<a href="javascript:;" class="btn btn-default btn-tab" id="mbrPurHistList"><spring:message code="L00360"/></a>
		<a href="javascript:;" class="btn btn-default btn-tab" id="mbrChnlRelList"><spring:message code="L00407"/></a>
		<a href="javascript:;" class="btn btn-default btn-tab" id="mbrCampHistList"><spring:message code="L00420"/></a>
	</div>
	<!-- 탭 컨텐츠 -->
 <div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span id="tabName"></span>
        </div>

    </div>
    <div id="tabContent" class="white_bg grid_bd0"></div>
</div>

</div>

<script>

$('#tabArea .btn.btn-default.btn-tab').on('click', function() {
	changeContent($(this).attr('id'), 'tabContent');
});

function changeContent(type, tab) {
	var cUrl;

	switch( type ){

	case 'mbrCardList' :
		cUrl = '<ifvm:url name="mbrCardList"/>';
		$('#tabName').text('<spring:message code="L00412"/>');
		break;

	case 'mbrPtnTxnHistList' :
		cUrl = '<ifvm:url name="mbrPtnTxnHistList"/>';
		$('#tabName').text('<spring:message code="L00423"/>');
		break;

	case 'mbrTierHistList' :
		cUrl = '<ifvm:url name="mbrTierHistList"/>';
		$('#tabName').text('<spring:message code="L00366"/>');
		break;

	case 'mbrPurHistList' :
		cUrl = '<ifvm:url name="mbrPurHistList"/>';
		$('#tabName').text('<spring:message code="L00360"/>');
		break;

	case 'mbrChnlRelList' :
		cUrl = '<ifvm:url name="mbrChnlRelList"/>';
		$('#tabName').text('<spring:message code="L00407"/>');
		break;

	case 'mbrCampHistList' :
		cUrl = '<ifvm:url name="mbrCampHistList"/>';
		$('#tabName').text('<spring:message code="L00420"/>');
		break;

	case 'mbrPtnBalList' :
		cUrl = '<ifvm:url name="mbrPtnBalList"/>';
		$('#tabName').text('<spring:message code="L00464"/>');
		break;

	default :
		break;
	}


$.ifvCachedHtml( cUrl ).done( function(script, textStatus){
		var cTab = $("#" + tab);

		$('#tabContent').empty();
		$('#tabArea .btn.btn-default.btn-tab').removeClass('active');
		$('#' + type).addClass('active');

		cTab.empty();
		cTab.html('');
		cTab.append( script );

		var fileName = cUrl.split('/').pop();


		if( window[fileName + '_init'] != null ) window[fileName + '_init']();

	});
}

</script>

<script>
$(function() {
	changeContent('mbrPtnBalList', 'tabContent');
});


</script>
<div id="popupContainer" class="popup_container"></div><!-- 팝업 -->
<div id="popupContainer1" class="popup_container"></div><!-- 팝업 1-->
<div id="vocPopupContainer" class="popup_container"></div><!-- 팝업 1-->
<div id="pointDialog" class="popup_container"></div>
<div id="offerPopupContainer" class="popup_container"></div><!-- 팝업 1-->