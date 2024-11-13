<%@ page trimDirectiveWhitespaces="true" %>
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

var clubTypeRid = '<%= cleanXss(request.getParameter("rid")) %>';
var isNew = false;
var validation;
var clubTab;

$(document).ready(function() {
	 $.ifvmLnbSetting('clubTypeList');

	initTab();
	validation = $("#clubForm").ifvValidation();
	setValidCalendar();

	if(clubTypeRid == "null") isNew = true;
	getClubDtlCommCode();
	getEvent();
	clubTypeDtlinit(clubTypeRid);
});

function setEndData(){
	var date = new Date();
	var year = date.getFullYear();
	var month = new String(date.getMonth()+1);
	var day = new String(date.getDate());

	// 한자리수일 경우 0을 채워준다.
	if(month.length == 1){
	  month = "0" + month;
	}
	if(day.length == 1){
	  day = "0" + day;
	}

	date = year + 10 + '-' + month + '-' + day;

	var startDate = $("#validStartDate");
	var endDate = $("#validEndDate");
	endDate.val(date);

	endDate.ifvDateChecker({
		minDate : startDate
	});
}

function setValidCalendar() {
    var startDate = $("#validStartDate");
    var endDate = $("#validEndDate");

   	startDate.val($.ifvGetTodayDate());
  	endDate.val('2999-12-31');
   	endDate.ifvDateChecker({});


	startDate.ifvDateChecker({
		maxDate : endDate
	});

	endDate.ifvDateChecker({
		minDate : startDate
	});
}

function basicTierSelectSetting(){
	//기본등급
	$("select[name='ridBasicTier'] option").remove();
  	$.ifvSyncPostJSON('<ifvm:action name="getClubTierTabList"/>' , {ridClub : clubTypeRid , type :'select'}
	, function(result) {
		$("#ridBasicTier").append("<option value=''></option>");
			result.rows.forEach(function( thisObj, idx ) {

				$("#ridBasicTier").append("<option value="+thisObj.rid+">"+thisObj.tierNm+"</option>");
			});
		});
}

function getClubDtlCommCode(){
	//사용여부
	$.fn.ifvmSetSelectOptionCommCode("useYn", "YES_NO_FLAG", null, null, true);
	$.fn.ifvmSetSelectOptionCommCode("tierCalcType", "TIER_CALC_TYPE", null, null, false);
	$.fn.ifvmSetSelectOptionCommCode("tierCalcCd", "TIER_CALC_CD", null, null, false);
	$.fn.ifvmSetSelectOptionCommCode("tierCalcPer", "TIER_CALC_PER", null, null, false);


	//카드 구분
	$.ifvSyncPostJSON('<ifvm:action name="getClubCardKindList"/>' , ""
	, function(result) {
			result.forEach(function( thisObj, idx ) {
				$("#cardDivi").append("<option value="+thisObj.cardKindNo+">"+thisObj.cardKndNm+"</option>");
			});
		});
	basicTierSelectSetting();


}

function getEvent(){
	// 저장버튼
	$("#btnSave").click(function () {
		actionSave();
	});

	//취소버튼
	$("#returnPrevPage").click(function(){
		qtjs.href('<ifvm:url name="clubTypeList"/>');
	});

	//
	$("#btnChnlPop").click(function(){
		openChnlPop();
	});
}

function clubTypeDtlinit(clubTypeRid){
	if(!isNew){				//상세 페이지
		getClubTypeDtl(clubTypeRid);
		fnSetDisplayed();
		$("#clubNm").attr('disabled', true);
	}else{
		$("#useYn").val('Y');
		$("#useYn").attr("disabled",true);
		$("#clubNm").attr("disabled", false);
		/* setEndData(); */
	}
}

function openChnlPop(){
	$("#clubChnlSearchPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="clubChnlPop"/>',
        contentType: "ajax",
        title: '채널 정보',
        width: '700px',
        close : 'clubChnlPopupClose'
    });
}

function clubChnlPopupClose(obj){
	if(typeof obj !="undefined" && obj.type !="close"){
		$("#clubForm #chnlNo").val(obj.chnlNo);
		$("#clubForm #ridChnl").val(obj.rid);
		$("#clubForm #chnlNm").val(obj.chnlNm);
	}
	clubChnlSearchPop._destroy();
}

function getClubTypeDtl(clubTypeRid){
	$.ifvSyncPostJSON('<ifvm:action name="getClubTypeDetail"/>',{rid : clubTypeRid}
	,function(result) {
		fnSetVal(result);
	});
}
function fnSetVal(result){
	$("#clubForm").dataSetting(result);
}

//저장 버튼클릭 시 동작
function actionSave() {

	//if(!isValidation()) return false;

	if(validation.confirm()){
 		saveSubmit();
	}
}


function isValidation(){

	var clubNm = $("#clubNm").val();
	var chnlNo = $("#chnlNo").val();
	var clubDescTxt = $("#clubDescTxt").val();

	if(!$.fn.ifvmIsNotEmpty(clubNm) && clubNm=='' ){
		alert("클럽명을 기입해 주십시오.");
		return false;
	}
	if(!$.fn.ifvmIsNotEmpty(chnlNo) && chnlNo==''){
		alert("기본채널을 기입해 주십시오.");
		return false;
	}
	if(!$.fn.ifvmIsNotEmpty(clubDescTxt) && clubDescTxt == ''){
		alert("클럽설명을 기입해 주십시오.");
		return false;
	}

	return true;
}


function saveSubmit(){

	var obj = getObjForSubmit();

	$.ifvSyncPostJSON(isNew ? '<ifvm:action name="addClub"/>' : '<ifvm:action name="editClub"/>', obj
	, function(result) {
		if(isNew){
			alert('저장 되었습니다.');
			isNew = false;
			clubTypeRid = result.message;
			location.replace('<ifvm:url name="clubTypeDtl"/>' + '?rid=' + clubTypeRid );
		}else{
			alert('수정 되었습니다.');

			clubTypeDtlinit(clubTypeRid);
		}
	},function(result) {
		alert('저장 실패 하였습니다. 관리자에게 문의 부탁드립니다');
	});
}

//submit을 위한 form 데이터 파라미터 세팅
function getObjForSubmit(){

	var v_obj = {};

	if(isNew) {
		v_obj = {
				   clubNm			: $("#clubNm").val()
				 , clubDescTxt 	: $("#clubDescTxt").val()
				 , validStartDate  : $("#validStartDate").val()
				 , validEndDate    : $("#validEndDate").val()
				 , ridBasicChnl		: $("#ridChnl").val()
				 , useYn				: $("#useYn").val()
				 , folupProg			: $("#folupProg").val()
				 , cardDivi			: $("#cardDivi").val()
				 ,tierCalcType      : $("#tierCalcType").val()
				 ,tierCalcCd      : $("#tierCalcCd").val()
				 ,tierCalcPer      : $("#tierCalcPer").val()
				 ,ridBasicTier      : $("#ridBasicTier").val()
		};
	}else {
		v_obj = {
				   clubDescTxt 	: $("#clubDescTxt").val()
				 , validStartDate  : $("#validStartDate").val()
				 , validEndDate    : $("#validEndDate").val()
				 , useYn				: $("#useYn").val()
				 , folupProg			: $("#folupProg").val()
				 , rid					: clubTypeRid
				 , cardDivi			: $("#cardDivi").val()
	 			 ,tierCalcType      : $("#tierCalcType").val()
				 ,tierCalcCd      : $("#tierCalcCd").val()
				 ,tierCalcPer      : $("#tierCalcPer").val()
				 ,ridBasicTier      : $("#ridBasicTier").val()
		};
	}
	return v_obj;
}

function fnSetDisplayed(){
	$("#btnChnlPop").attr("disabled",true);
	/* $("#btnChnlPop").addClass("hidden") */

}

function initTab() {

	clubTab = $('#clubTabArea').DrawTab({
        item: [
            /* {label: '제외 채널 리스트', href: '/loyalty/membership/club/include/tabChnlList'}, */
            {label: '클럽회원리스트', href: '/loyalty/membership/club/include/tabClubMbrList'},
            {label: '가입조건', href: '/loyalty/membership/club/include/tabClubJoinCondList'},
            {label: '혜택', href: '/loyalty/membership/club/include/tabClubBenfList'},
            {label: '클럽등급', href: '/loyalty/membership/club/include/tabClubTierList'},
            {label: '제휴사', href: '/loyalty/membership/club/include/tabClubPartenariat'}
        ]
    });
}
</script>


<script id="cardDiviTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div class="page-title">
    <h1>
    클럽관리 &gt; 상세
    </h1>
</div>
<div id="clubForm">
	 <div class="page_btn_area" >

        <div class="col-xs-7">
      		클럽 상세 정보
        </div>
        <div class="col-xs-5 searchbtn_r">
       	    <button class="btn btn-sm" id="btnSave">
	        	<i class="glyphicon glyphicon-check"></i>
	        	<spring:message code='M01855'/>
	    </button>
	    <button class="btn btn-sm" id="returnPrevPage">
	        <spring:message code="M00002"/>
	    </button>
        </div>
 	</div>


	<div class="form-horizontal underline top_well">
			<div class="row">
				<ifvm:inputNew type="text" id="clubNm" dto="clubNm" required="true" label="클럽명" nuc="true" labelClass="1" conClass="4"  maxLength="50" />
				<ifvm:inputNew type="select" id="tierCalcType" dto="tierCalcType" names="tierCalcType"  label="등급산정유형" nuc="true" labelClass="2" conClass="4"  maxLength="50" />

				<%-- <ifvm:inputNew type="search" id="chnlNo|btnChnlPop" required="true"
						names="chnlNo" hidId="ridChnl" hidDto="ridChnl" dto="chnlNo"
						disabled="false" btnFunc="openChnlPop" label="기본채널"  nuc ="true"
						labelClass="2" conClass="2" />

				<ifvm:inputNew type="hidden" id="ridChnl" dto="ridChnl" />
				<ifvm:inputNew type="text" id="chnlNm" dto="chnlNm" disabled="true" nuc="true" conClass="2" /> --%>
			</div>

			<div class="row">
				<ifvm:inputNew type="select" id="cardDivi" dto="cardDivi" label="클럽카드" nuc="true" labelClass="1" conClass="4"/>
				<ifvm:inputNew type="select" id="tierCalcCd" dto="tierCalcCd" names="tierCalcCd" label="등급산정방식" nuc="true" labelClass="2" conClass="4"/>
			</div>

			<div class="row">
				<ifvm:inputNew type="select" id="useYn" names="useYn" dto="useYn"  label="클럽활성" nuc="true" labelClass="1" conClass="4"/>
				<ifvm:inputNew type="select" id="tierCalcPer" names="tierCalcPer" dto="tierCalcPer"  label="등급산정주기" nuc="true" labelClass="2" conClass="4"/>
			</div>



			<div class="row">
				<ifvm:inputNew type="dateTerm" startDto="validStartDate"
							endDto="validEndDate" startId="validStartDate"
							endId="validEndDate" label="효력시작/종료일" nuc="true" labelClass="1"
							conClass="4" />
				<ifvm:inputNew type="select" id="ridBasicTier" names="ridBasicTier" dto="ridBasicTier"  label="기본등급" nuc="true" labelClass="2" conClass="4"/>
			</div>

			<div class="row">
				<ifvm:inputNew type="textarea" id="clubDescTxt" dto="clubDescTxt" rows="6" required="true" label="클럽설명" nuc="true" labelClass="1" conClass="10" maxLength="200"  />
			</div>
	</div>




</div>


<div id="clubChnlSearchPop" class ="popup_container"></div>

<div id="clubTabArea" style="margin-top: 20px"></div>
