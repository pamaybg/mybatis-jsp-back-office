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
<div class="page-title">
	<h1>
		<spring:message code="법인 단체고객" />
		&gt; <spring:message code="L00079" />
	</h1>
</div>

<div>
<div class="page_btn_area" id="headForm">
	<div class="col-xs-2">
		<span><spring:message code="법인단체고객  상세정보"/></span>
	</div>
	<div class="col-xs-10 searchbtn_r">
		<ifvm:inputNew type="button" id="" btnFunc="corpCustListPopup" text="법인고객조회" />
		<ifvm:inputNew type="button" id="btnList" btnFunc="" text="목록" />
	</div>
</div>
<div class="form-horizontal underline top_well" id="mbrForm">
	<div class="row">
		<div class="half_wrap top_well">
			<div class="half_content half_left qt_border">
				<div class="page_btn_area">
					<div class="col-xs-2">
						<span><spring:message code="기본정보" /></span>
						<!-- 회원정보 -->
					</div>
				</div>
				<div class="form-horizontal top_well underline" id="reachInfo">
					<div class="row">
					<!-- 고객명-->
						<ifvm:inputNew type="text" id="custNm" dto="custNm"
							label="고객명" labelClass="2" conClass="4" disabled="true" />
							<ifvm:inputNew type="text" id="cmpnyNm" dto="cmpnyNm"
							label="상호명" labelClass="2" conClass="4" disabled="true" />
					</div>
					<div class="row">
						<!-- 고객번호-->
						<ifvm:inputNew type="text" id="custNo" dto="custNo"
							label="고객/카드번호" title="고객번호" labelClass="2" conClass="2" disabled="true" />
						<ifvm:inputNew type="text" id="mcardNo" dto="mcardNo"
							title="카드번호" conClass="2" disabled="true" />
						<!-- 고객유형-->
						<ifvm:inputNew type="text" id="custTypeCdNm" dto="custTypeCdNm" disabled="true"
							label="고객유형" labelClass="2" conClass="4" />
					</div>
					<div class="row">
						<!-- 고객명-->
						<ifvm:inputNew type="text" id="bizrNo" dto="bizrNo"
							label="사업자번호" labelClass="2" conClass="4" disabled="true" />
						<!-- 회원명-->
						<ifvm:inputNew type="text" id="jurirNo" dto="jurirNo" disabled="true"
							label="법인번호" labelClass="2" conClass="4" />
						<!-- 회원번호 -->
					</div>
					<div class="row">
						<ifvm:inputNew type="text" id="ceo" dto="ceo"
							label="대표자명" labelClass="2" conClass="4" disabled="true" />
						<!-- 회원명-->
						<ifvm:inputNew type="text" id="charger" dto="charger" disabled="true"
							label="담당자명" labelClass="2" conClass="4" />
					</div>
					<div class="row">
					<ifvm:inputNew type="text" id="fondDt" dto="fondDt" disabled="true"
							label="설립일자" labelClass="2" conClass="4" />
					<ifvm:inputNew type="text" id="capl" dto="capl" disabled="true" className="text-right"
							label="자본금" labelClass="2" conClass="4" />
					</div>
					<div class="row">
					<ifvm:inputNew type="text" id="induty" dto="induty" disabled="true"
							label="업종" labelClass="2" conClass="4" />
					<ifvm:inputNew type="text" id="bizcnd" dto="bizcnd" disabled="true"
							label="업태" labelClass="2" conClass="4" />
					</div>
				</div>
			</div>
			<div class="half_content half_right">
				<div class="page_btn_area">
					<div class="col-xs-2">
						<span><spring:message code="인증정보" /></span>
						<!-- 추가정보 -->
					</div>
					<div class="col-xs-10 searchbtn_r"></div>
				</div>
				<div class="form-horizontal top_well underline" id="mktAgree">
					<div class="row">
						<ifvm:inputNew type="text" id="custCertTypeCdNm" dto="custCertTypeCdNm" disabled="true"
							label="인증유형" labelClass="2" conClass="4" />
						<ifvm:inputNew type="text" id="certSubTypeCdNm" dto="certSubTypeCdNm" disabled="true"
							label="인증서브유형" labelClass="2" conClass="4" />
					</div>
					<div class="row">
						<ifvm:inputNew type="text" id="certDate" dto="certDate" disabled="true"
							label="인증일시" labelClass="2" conClass="4" />
						<ifvm:inputNew type="text" id="certVal" dto="certVal" disabled="true"
							label="식별값" labelClass="2" conClass="4" />
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="half_wrap top_well">
			<div class="half_content half_left qt_border">
				<div class="page_btn_area">
					<div class="col-xs-2">
						<span><spring:message code="연락처정보" /></span>
						<!-- 회원정보 -->
					</div>
					<div class="col-xs-10 searchbtn_r"></div>

				</div>
				<div class="form-horizontal top_well underline" id="reachInfo">
					<div class="row">
						<ifvm:inputNew type="text" id="hhp" dto="hhp" disabled="true"
							label="휴대폰" labelClass="2" conClass="4" />
						<!-- 회원명-->
						<ifvm:inputNew type="text" id="email" dto="email" disabled="true"
							label="이메일" labelClass="2" conClass="4" />
						<!-- 회원번호 -->
					</div>
					
					<div class="row">
						<ifvm:inputNew type="text" id="telNo" dto="telNo" disabled="true"
							label="법인연락처" labelClass="2" conClass="4" />
						<!-- 회원명-->
						<ifvm:inputNew type="text" id="fax" dto="fax" disabled="true"
							label="FAX" labelClass="2" conClass="4" />
						<!-- 회원명-->
					</div>
					
					<div class="row">
						<ifvm:inputNew type="search" id="addr1Zip|addr1ZipSearch" disabled="true"
							names="addr1Zip" hidId="zip" hidDto="zip"
							dto="zip" btnFunc="addrSearchHelpBtn" searchBlurEvent="addrSearchHelpBlur"
							searchEnterEvent="addrSearchHelpEnter" label="자택주소"
							labelClass="2" conClass="4" />
							<ifvm:inputNew type="text" id="adres" dto="adres" disabled="true"
							conClass="6"/>
					</div>
					<div class="row">
						<ifvm:inputNew type="text" id="bunji" dto="bunji" disabled="true" label="상세주소" labelClass="2" conClass="10"	className="blockTarget" />
					</div>
				</div>
			</div>
			<div class="half_content half_right">
				<div class="page_btn_area">
					<div class="col-xs-2">
						<span><spring:message code="추가정보" /></span>
						<!-- 추가정보 -->
					</div>
					<div class="col-xs-10 searchbtn_r"></div>
				</div>
				<div class="form-horizontal top_well underline" id="mktAgree">
					<div class="row">
						<ifvm:inputNew type="text" id="sbscPathCdNm" dto="sbscPathCdNm" disabled="true"
							label="가입경로" labelClass="2" conClass="4" />
						<ifvm:inputNew type="text" id="sbscDate" dto="sbscDate" disabled="true"
							label="가입일" labelClass="2" conClass="4" />
						<!-- 회원명-->
						<!-- 추천인코드 -->
					</div>
					<div class="row">
						<ifvm:inputNew type="text" id="chnlNm" dto="chnlNm" disabled="true"
							label="가입채널" labelClass="2" conClass="4" />
						<!-- 회원번호 -->
					</div>
					<div class="row">
					<ifvm:inputNew type="text" id="rcmmdNo" dto="rcmmdNo"
							label="추천인코드" labelClass="2" conClass="4" disabled="true" />
					<ifvm:inputNew type="text" id="drmmcyChngUnit" dto="drmmcyChngUnit" disabled="true"
							label="휴면전환" labelClass="2" className="text-right" conClass="2" values="1"/>
							<label class="control-label" style="margin-left:0px">년 후
					</div>
					<div class="row">
						<ifvm:inputNew type="text" id="svrDt" dto="svrDt" disabled="true"
							label="최근이용일" labelClass="2" conClass="4" />
						<ifvm:inputNew type="text" id="lastChnlNm" dto="lastChnlNm" disabled="true"
							label="최근이용매장" labelClass="2" conClass="4" />
						<!-- 회원명-->
						<%-- <ifvm:inputNew type="text" id="custNm2" dto="custNm2"
							disabled="true" label="최근구매일자" labelClass="2" conClass="4" /> --%>
						<!-- 회원번호 -->
					</div>
					<div class="row">
					<ifvm:inputNew type="text" id="webId" dto="webId" disabled="true"
							label="WEB ID" labelClass="2" conClass="4" />
						<ifvm:inputNew type="button" btnFunc="webLoginInfPopup" text="로그인 정보 조회" />
					</div>
					<div class="col-xs-12"></div>
				</div>
			</div>
		</div>
	</div>
	
	</div>
	</div>

<div id="mbrDetailTabArea"></div>
<div id="corpWebLoginInfPop" class="popup_container"></div>
<div id="corpCustListPop" class="popup_container"></div>

<script type="text/javascript">
var cust_rid = '<%= cleanXss(request.getParameter("rid")) %>';
var isNew = true;  //신규 여부. 신규: true, 수정 : false
var pointFieldId = new Array(); //배열선언
corpPointFieldId = [ 'capl' ];

var mbrDetailTab = $('#mbrDetailTabArea').DrawTab({
        item : [
            {	label : '<spring:message code="L02841"/>', href : '<ifvm:url name="corpMbrRelList"/>'}, //소속회원
            {	label : '<spring:message code="L02842"/>', href : '<ifvm:url name="corpContractDetail"/>'}, //계약
            {	label : '<spring:message code="L02843"/>', href : '<ifvm:url name="corpBranchList"/>'}, //브랜치
            {	label : '<spring:message code="L00431"/>', href : '<ifvm:url name="corpDetailMbrList"/>'},
            {	label : '동의', href : '<ifvm:url name="corpAgreListNew"/>'},	//동의
            {   label : '이용내역', href : '<ifvm:url name="corpUseHistListNew"/>'}, //이용내역
           /*  {	label : '변경이력', href : '<ifvm:url name="corpChangeHistListNew"/>'}, //변경이력 */
        ]
	});


function corCustDetail(){
	if( cust_rid != null ){
		$.ifvSyncPostJSON('/loyalty/member/customer/getCorpCustDetailNewPage.do',{
			rid : cust_rid,
		},
		function(result) {
			//정보 이력 남기기
			var backPage = backPage === 'null' ? null : $.fn.ifvmPersonalCondLogPageId("", false);
			if(backPage != null) $.fn.ifvmComCondLogging( backPage , cust_rid);
			
			$("#mbrForm").dataSetting(result);
			
			if(result.hhp != null){
				var hhp = result.hhp.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
				$("#hhp").val(hhp);
			}
			if(result.telNo != null){
				var telNo = result.telNo.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
				$("#telNo").val(telNo);
			}
			if(result.fax != null){
				var fax = result.fax.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
				$("#fax").val(fax);
			}
			pointComma();
		});
	}

};

function pointComma() {

	for (var pi = 0; pi < corpPointFieldId.length; pi++) {
		var _pval = $("#" + corpPointFieldId[pi]).val();
		var _aval = "";
		if (_pval) {
			_aval = (_pval.split(".")[0]).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		$("#" + corpPointFieldId[pi]).val(_aval);
	}
}

function webLoginInfPopup() {
	$("#corpWebLoginInfPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="webLoginInfPop"/>',
        contentType: "ajax",
        title: '로그인 정보 조회',
        width: 800,
        close : 'webLoginInfClosePopup'
    });
}

function webLoginInfClosePopup() {
	corpWebLoginInfPop._destroy();
}

function corpCustListPopup(){	
	$("#corpCustListPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="corpCustListNewPagePop"/>',
	        contentType: "ajax",
	        title: '법인고객조회',
	        width: 1000,
	        close : 'corpCustClosePop'
	    });
};

function corpCustClosePop() {
	corpCustListPop._destroy();
}


$(document).ready(function() {
	corCustDetail();
	
	$("#btnList").click(function() {
		qtjs.href('<ifvm:url name="corpcustListNew"/>');
	});
});
</script>
