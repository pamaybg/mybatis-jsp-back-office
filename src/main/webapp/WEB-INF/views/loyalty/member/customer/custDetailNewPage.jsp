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
		<spring:message code="고객" />
		&gt; <spring:message code="개인고객" />
	</h1>
</div>
<div>
<div class="page_btn_area" id="headForm">
	<div class="col-xs-2">
		<span><spring:message code="고객 상세"/></span>
	</div>
	<div class="col-xs-10 searchbtn_r">
		<ifvm:inputNew type="button" btnFunc="custPopup" text="고객 360° 뷰" />
		<ifvm:inputNew type="button" btnFunc="custListPopup" text="고객조회" />
		<ifvm:inputNew type="button" btnFunc="webLoginInfPopup" text="로그인 정보 조회" />
		<ifvm:inputNew type="button" btnFunc="btnList" text="목록" />
	</div>
</div>

<div class="form-horizontal underline top_well" id="custForm">
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
					<%-- <div class="row">
						<ifvm:inputNew type="text" id="custNm" dto="custNm" label="고객명" labelClass="2" conClass="5" disabled="true" />
					</div> --%>
					<div class="row">
						<ifvm:inputNew type="text" id="custNo" dto="custNo" label="고객번호" title="고객번호" labelClass="2" conClass="4" disabled="true" />
						<ifvm:inputNew type="text" id="mcardNo" dto="mcardNo" label="카드번호" title="카드번호" labelClass="2" conClass="4" disabled="true" />
					</div>
					<div class="row">
						<ifvm:inputNew type="text" id="custTypeCdNm" dto="custTypeCdNm" title="고객유형" disabled="true" label="고객유형"  labelClass="2" conClass="4" />
						<ifvm:inputNew type="text" id="rcmmdNo" dto="rcmmdNo" label="추천인코드" labelClass="2" conClass="4" disabled="true" title="추천인코드" />
					</div>
					<%-- <div class="row">
						<ifvm:inputNew type="text" id="genCdNm" dto="genCdNm" disabled="true"
							label="성별" labelClass="2" conClass="4" />
						<ifvm:inputNew type="text" id="birthDt" dto="birthDt" disabled="true"
							label="생년월일" labelClass="2" conClass="2" />
						<ifvm:inputNew type="text" id="age" dto="age" disabled="true"
							conClass="2" className="text-right"/>
					</div>
					<div class="row">
						<ifvm:inputNew type="text" id="nltyNm" dto="nltyNm" disabled="true"
							label="국적" labelClass="2" conClass="4" />
						<ifvm:inputNew type="text" id="wrcNm" dto="wrcNm" disabled="true"
							label="직장명" labelClass="2" conClass="4" />
					</div>
					<div class="row">
						<ifvm:inputNew type="text" id="annvrsryCdNm" dto="annvrsryCdNm" disabled="true"
							label="기념일유형" labelClass="2" conClass="4" />
						<ifvm:inputNew type="text" id="annvrsry" dto="annvrsry" disabled="true"
							label="기념일" labelClass="2" conClass="4" />
					</div>
					<div class="row">
						<ifvm:inputNew type="text" id="pstnNm" dto="pstnNm" disabled="true"
							label="직위" labelClass="2" conClass="4" />
							<ifvm:inputNew type="singleCheckbox" id="mrrgYn" dto="mrrgYn" disabled="true" label="결혼여부" nuc="true" labelClass="2" conClass="1" values="mrrgYn"/>
						<ifvm:inputNew type="singleCheckbox" id="nativeYn" dto="nativeYn" disabled="true" label="내국인여부" nuc="true" labelClass="2" conClass="1" values="nativeYn"/>
					</div> --%>
				</div>
			</div>
			<div class="half_content half_right">
				<div class="page_btn_area">
					<div class="col-xs-2">
						<span><spring:message code="가입정보" /></span>
					</div>
					<div class="col-xs-10 searchbtn_r"></div>
				</div>
				<div class="form-horizontal top_well underline" id="mktAgree">
						<%-- <div class="row">
							<ifvm:inputNew type="text" id="sbscDate" dto="sbscDate" label="가입일자" labelClass="2" conClass="2" title="가입일" disabled="true" />
							<ifvm:inputNew type="text" id="sbscChnlNm" dto="sbscChnlNm" disabled="true" conClass="2" title="가입채널" />
						
							<ifvm:inputNew type="text" id="sbscPathCdNm" dto="sbscPathCdNm" label="가입경로" labelClass="2" conClass="2" title="가입경로" disabled="true" />
							<ifvm:inputNew type="text" id="sbscDeviceCdNm" dto="sbscDeviceCdNm" conClass="2" disabled="true" title="가입디바이스" />
						</div> --%>
						<div class="row">
							<ifvm:inputNew type="text" id="certTypeCd" names="certTypeCd" dto="custCertTypeCdNm" title="인증유형"  label="인증유형" labelClass="2" conClass="2" disabled="true" />
							<ifvm:inputNew type="text" id="certDate" names="certDate" dto="certDate" conClass="2" title="인증일" disabled="true"/>
							
							<ifvm:inputNew type="text" id="joinMembership" names="joinMembership" dto="joinMembership" label="가입멤버십" title="가입멤버십" labelClass="2" conClass="4" disabled="true"/>
						</div>
				</div>
					<%-- <div class="row">
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
					</div> --%>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="half_wrap top_well">
			<div class="half_content half_left qt_border">
				<div class="page_btn_area">
					<div class="col-xs-2">
						<span><spring:message code="고객정보" /></span>
					</div>
					<div class="col-xs-10 searchbtn_r"></div>
				</div>
				<div class="form-horizontal top_well underline" id="custDetailForm">
						<div class="row">
							<ifvm:inputNew type="text" id="cust_nm" dto="cust_nm" className="font-bold" disabled="true" label="이름(한글)" title="이름" labelClass="2" conClass="4" />
							<ifvm:inputNew type="text" id="cust_nm_add" dto="cust_nm_add" disabled="true" label="이름(영문)" title="이름(추가)" labelClass="2" conClass="4" />
						</div>
						<div class="row">
							<ifvm:inputNew type="text" id="hhp" dto="hhp" label="휴대폰" className="font-bold" labelClass="2" conClass="4" title="휴대폰" disabled="true" />
							<ifvm:inputNew type="text" id="email" dto="email" disabled="true" label="이메일" labelClass="2" title="이메일" conClass="4" />
						</div>
						<div class="row">
							<ifvm:inputNew type="text" id="birthdt" names="birthdt" dto="birthdt" label="생년월일" labelClass="2" title="생년월일" conClass="2" disabled="true"/>
							<ifvm:inputNew type="text" id="gen_cd" names="gen_cd" dto="gen_cd" conClass="2" title="양음력" disabled="true" />
							
							<ifvm:inputNew type="text" id="user_id" dto="user_id" label="웹아이디" title="웹아이디" className="font-bold" labelClass="2" conClass="4" disabled="true" />
						</div>
						<div class="row">
							<ifvm:inputNew type="text" id="zip" names="zip" dto="zip"  label="우편번호" className="" labelClass="2" title="우편번호" conClass="1" disabled="true"/>
							<ifvm:inputNew type="text" id="adres" dto="adres" disabled="true" title="주소" conClass="4"/>
								
							<ifvm:inputNew type="text" id="bunji" dto="bunji" disabled="true" conClass="5" title="번지" className="blockTarget" />
						</div>
					</div>
				<%-- <div class="form-horizontal top_well underline" id="reachInfo">
					<div class="row">
						<ifvm:inputNew type="text" id="hhp" dto="hhp" disabled="true"
							label="휴대폰" labelClass="2" conClass="4" />
						<!-- 회원명-->
						<ifvm:inputNew type="text" id="email" dto="email" disabled="true"
							label="이메일" labelClass="2" conClass="4" />
						<!-- 회원번호 -->
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
				</div> --%>
			</div>
			<div class="half_content half_right">
				<div class="page_btn_area">
					<div class="col-xs-2">
						<span><spring:message code="부가정보" /></span>
					</div>
					<div class="col-xs-10 searchbtn_r"></div>
				</div>
				<div class="form-horizontal top_well underline" id="custDetailAddForm">
						<div class="row">
							<ifvm:inputNew type="text" id="nlty" names="nlty" dto="nlty" label="국적" title="국적" className="text-center" labelClass="2" conClass="2" disabled="true"/>
							<ifvm:inputNew type="text" id="native_yn" names="native_yn" dto="native_yn" title="내국인여부" className="text-center" conClass="2" disabled="true" />
							
						</div>
						<div class="row">
							<ifvm:inputNew type="text" id="annvrsry_type_cd" names="annvrsry_type_cd" dto="annvrsry_type_cd" className="text-center" label="기념일" title="기념일유형" labelClass="2" conClass="2" disabled="true"/>
							<ifvm:inputNew type="text" id="annvrsry" names="annvrsry" dto="annvrsry" className="text-center" conClass="2"  maxLength="4" disabled="true" title="기념일"/>
							
							<ifvm:inputNew type="text" id="mrrg_yn" names="mrrg_yn" dto="mrrg_yn" label="결혼유무" title="결혼유무" labelClass="2" conClass="4" disabled="true"/>
						</div>
						<div class="row">
							<ifvm:inputNew type="text" id="wrc_nm" names="wrc_nm" dto="wrc_nm" label="직장명" title="직장명" labelClass="2" conClass="4" disabled="true"/>
							<ifvm:inputNew type="text" id="pstn" names="pstn" dto="pstn" label="직위" title="직위" labelClass="2" conClass="4" disabled="true"/>
						</div>
						<div class="row">
							<ifvm:inputNew type="text" id="zip_add" names="zip_add" dto="zip_add"  label="직장주소" title="우편번호(추가)" labelClass="2" conClass="1" disabled="true"/>
							<ifvm:inputNew type="text" id="adres_add" dto="adres_add" title="주소(추가)" disabled="true" conClass="4"/>
								
							<ifvm:inputNew type="text" id="bunji_add" dto="bunji_add" title="번지(추가)" disabled="true" conClass="5"	 />
						</div>
					</div>
				<%-- <div class="form-horizontal top_well underline" id="mktAgree">
					<div class="row">
						<ifvm:inputNew type="text" id="sbscPathCdNm" dto="sbscPathCdNm" disabled="true"
							label="가입경로" labelClass="2" conClass="4" />
						<ifvm:inputNew type="text" id="sbscDate" dto="sbscDate" disabled="true"
							label="가입일" labelClass="2" conClass="4" />
					</div>
					<div class="row">
						<ifvm:inputNew type="text" id="chnlNm" dto="chnlNm" disabled="true"
							label="가입채널" labelClass="2" conClass="4" />
					</div>
					<div class="row">
					
					<ifvm:inputNew type="text" id="drmmcyChngUnit" dto="drmmcyChngUnit" disabled="true"
							label="휴면전환" labelClass="2" className="text-right" conClass="4" values="1"/>
							<label class="control-label" style="margin-left:0px">
					</div>
					<div class="row">
						<ifvm:inputNew type="text" id="svrDt" dto="svrDt" disabled="true"
							label="최근이용일" labelClass="2" conClass="4" />
						<ifvm:inputNew type="text" id="lastChnlNm" dto="lastChnlNm" disabled="true"
							label="최근이용매장" labelClass="2" conClass="4" />
						<!-- 회원명-->
						<ifvm:inputNew type="text" id="custNm2" dto="custNm2"
							disabled="true" label="최근구매일자" labelClass="2" conClass="4" />
					</div>
					<div class="row">
					<ifvm:inputNew type="text" id="webId" dto="webId" disabled="true"
							label="WEB ID" labelClass="2" conClass="4" />
						<ifvm:inputNew type="button" btnFunc="webLoginInfPopup" text="로그인 정보 조회" />
					</div>
					<div class="col-xs-12"></div>
				</div> --%>
			</div>
			<div class="row">
			<div class="half_wrap top_well">
				<div class="half_content half_left qt_border">
					<div class="page_btn_area">
						<div class="col-xs-2">
							<span><spring:message code="활동정보" /></span>
						</div>
						<div class="col-xs-10 searchbtn_r"></div>
					</div>
					<div class="form-horizontal top_well underline" id="reachInfo">
						<div class="row">
							<ifvm:inputNew type="text" id="lastChnlNm" dto="lastConChnlNm" label="최근접속" title="최근접속채널" labelClass="2" conClass="2" disabled="true" />
							<ifvm:inputNew type="text" id="conSvrDt" dto="conSvrDt" disabled="true" title="최근접속일" conClass="2"/>
							
							<ifvm:inputNew type="text" id="lastChnlNm" dto="lastPurChnlNm" label="최근구매" title="최근구매채널" labelClass="2" conClass="2" disabled="true" />
							<ifvm:inputNew type="text" id="purSvrDt" dto="purSvrDt" disabled="true" title="최근구매일" conClass="2"/>
						</div>
						<div class="row">
							<ifvm:inputNew type="text" id="evtNm" dto="evtNm" label="이벤트참여" labelClass="2" title="이벤트명" conClass="2" disabled="true" />
							<ifvm:inputNew type="text" id="evtDt" dto="evtDt" conClass="2" disabled="true" title="참여일" />
						
							<ifvm:inputNew type="text" id="drmncy_chng_unit" names="drmncy_chng_unit" dto="drmncy_chng_unit"  label="휴면전환" title="휴면전환단위" labelClass="2" conClass="2" disabled="true"/>
							<ifvm:inputNew type="text" id="drmncy_chng_unitDt" names="drmncy_chng_unitDt" conClass="2" disabled="true" title="휴면전환일" />
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
	</div>

</div>
</div>


<div id="custDetailNewTabArea"></div>

<div id="custListPop" class="popup_container"></div>
<div id="webLoginInfPop" class="popup_container"></div>
<div id="custPop" class="popup_container"></div>

<script type="text/javascript">
var cust_rid = '<%= cleanXss(request.getParameter("rid")) %>';
var cust_no = '<%= cleanXss(request.getParameter("custNo"))%>';
var isNew = true;  //신규 여부. 신규: true, 수정 : false
var custItemValCheck;
var inputeRowField = [];

var custDetailNewTabArea = $('#custDetailNewTabArea').DrawTab({
	item : [
		/* {	label : '접속이력', href : '<ifvm:url name="custLoginHistoryListNew"/>'}, //접속이력 */
		{	label : '<spring:message code="L00431"/>', href : '<ifvm:url name="custDetailMbrList"/>'},	
		{	label : '동의', href : '<ifvm:url name="custAgreListNew"/>'},	//동의
		{   label : '서비스 이용내역', href : '<ifvm:url name="custUseHistListNew"/>'}, //이용내역
		{	label : 'App이력', href : '<ifvm:url name="custAppHistListNew"/>'}, //App이력
		
		{	label : '세분화이력', href : '<ifvm:url name="custSegmentRuleHist"/>'}, //세분화이력
		/* {	label : '보유 혜택', href : '<ifvm:url name="mbrLoginHistListNew"/>'}, //보유혜택 */
	]
}); 

function webLoginInfPopup() {
	$("#webLoginInfPop").ifvsfPopup({
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
	webLoginInfPop._destroy();
}

function custDetail(){
	
	if( cust_rid != null ){
		$.ifvSyncPostJSON('/loyalty/member/customer/getCustDetailNewPage.do',{
			rid : cust_rid,
		},
		function(result) {
			
			//개인정보 조회 로그남기기
			var backPage = backPage === 'null' ? null : $.fn.ifvmPersonalCondLogPageId("", false);
			if(backPage != null) $.fn.ifvmComCondLogging( backPage , cust_rid);
			
			$("#custForm").dataSetting(result);
			var hhp = result.hhp.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
			$("#hhp").val(hhp);
			
			//우편번호
			if(result.zip != null) $("#zip").val(result.zip);
			//우편번호(추가)
			if(result.zip_add != null) $("#zip_add").val(result.zip_add);
			//휴면전환단위
			if(result.drmncy_chng_unit != null && result.drmncy_chng_unit != "") {
				if(result.drmmcyChngUnitCd == '99'){
					$("#drmncy_chng_unit").val(result.drmncy_chng_unit);
				}else{
					$("#drmncy_chng_unit").val(result.drmncy_chng_unit);
					$("#drmncy_chng_unitDt").val(getTodayDate(result.drmncy_chng_unit));
				}
				
			}
			//기념일
			if(result.annvrsry != null) $("#annvrsry").val(result.annvrsry.substr(0,2)+"월"+result.annvrsry.substr(2,2)+"일");

			//생일
			if(result.birthdt != null){
				var birthday = result.birthdt;
				if(result.lunar_cdNm != null && result.lunar_cdNm != "" ){
					//$("#birthdt").val(birthday.substr(0,4)+"-"+birthday.substr(4,2)+"-"+birthday.substr(6)+"  ("+result.lunar_cdNm+")");
					$("#birthdt").val( birthday.substr(0,10) ) ;
				}
				else 
					//$("#birthdt").val(birthday.substr(0,4)+"-"+birthday.substr(4,2)+"-"+birthday.substr(6));
					$("#birthdt").val( birthday.substr(0,10) ) ;
			}
			
			//결혼여부
			if(result.mrrg_yn != null){
				if(result.mrrg_yn == 'Y') $("#mrrg_yn").val("기혼");
				else $("#mrrg_yn").val("미혼");
			}
			
			//내국인여부
			if(result.native_yn != null){
				if(result.native_yn == 'Y') $("#native_yn").val("내국인");
				else $("#native_yn").val("외국인");
			}
			
			//글자스타일 굵게
			$(".font-bold").attr('style', 'font-weight: bold;');
			//고객수집항목에대한 이름설정
			labelCheck();
			/* if(result.age!=null) {
				$("#age").val(result.age+"세");
			} */

			
		});
	}

};

//고객정보, 부가정보 id 체크
function getFieldId(){
	var inputSize = 0;
	for(var i=0;i < $("#custDetailForm input").length; i++){inputeRowField[i] = $("#custDetailForm input")[i].id;}
	inputSize = inputeRowField.length;
	for(var j=0; j < $("#custDetailAddForm input").length; j++){inputeRowField[ j+inputSize] = $("#custDetailAddForm input")[j].id;}
}

//custDetailForm  custDetailAddForm 고객수집정보에 저장이 되있는 항목은 그항목 이름에 맞게 바꾸어준다.
function labelCheck(){
	getFieldId();
	
	$.ifvSyncPostJSON('<ifvm:action name="custItemConfVal"/>',{repYn : 'Y'}, function(result){
		custItemValCheck = result.rows;
		
		var newList = custItemValCheck.filter(function(item){
		      return inputeRowField.includes(item.fieldNm.toLowerCase());
		})
		
		for(var i=0;i <newList.length; i++) {
			var fieldId = newList[i].fieldNm.toLowerCase();
			var fieldNm = newList[i].fieldDesc
			$("#"+fieldId).attr("title", fieldNm);
			if( fieldId != "bunji" && fieldId != "bunji_add" && fieldId != "lunar_cd" && fieldId != "native_yn" && fieldId != "annvrsry" && fieldId != "zip" && fieldId != "zip_add" && fieldId != "gen_cd"){ 
				if(fieldId != "adres" && fieldId != "adres_add" ){
					$("#"+fieldId).closest("div").prev()[0].innerHTML = fieldNm;
				}else{
					$("#"+fieldId).closest("div").prev().prev()[0].innerHTML = fieldNm;
				}
			} 
		}
	});
}

//오늘날짜 계산
function getTodayDate(dt){ 
	if(dt == null || dt == undefined) dt = 0;
	var date = new Date();
	
	var year = date.getFullYear();
	year = parseInt (year) + parseInt (dt);
	var month = date.getMonth()+1;
	if(month<10) month = "0"+month;
	var day = date.getDate();
	if(day<10) day = "0"+day;
	
	return year +"-"+month+"-"+day;
}

function custListPopup() {	
	$("#custListPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="custListNewPagePop"/>',
        contentType: "ajax",
        title: '고객조회',
        width: 1000,
        close : 'custClosePop'
    });
};
function custPopup() {
	$("#custPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="custViewPop"/>',
        contentType: "ajax",
        title: '고객 360° VIEW',
        width: 1000,
        close : 'custViewClosePop'
    });
};
function custViewClosePop() {
	custPop._destroy();
}

function custClosePop() {
	custListPop._destroy();
}

function btnList() {
	qtjs.href('<ifvm:url name="custListNewPage"/>');
}



$(document).ready(function() {
	
	custDetail();
	
	//$.ifvGetCommCodeList('select', 'mbrStatCd', '<ifvm:action name="getCommCodeList2"/>', 'LOY_MEM_STAT_CD', 'loy', false, false, true);

	
});
</script>
