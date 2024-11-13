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
<script type="text/javascript">
var callContactRid = '<%= cleanXss(request.getParameter("callContactRid")) %>';

var voiceMailBoxGrid;
var ridMbr = null;
var ridCust = null;
var rowData = [];
var rowData2 = [];
var listUrl;
var regYnFlag = false;


function getVoiceMailBoxList(){
	var ejGridOption = {
		recordDoubleClick : function(data){
		},
		rowSelected : function (args) {
	    	rowData2 = [];
	    	rowData2 = args.data;
	    	ridCust = null;

	    	selectRowAction(args.data);
		},
		serializeGridData : function( data ){
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
			if(regYnFlag){
				data.regYnFlag = "1";
			}

            return data;
		},
		loadComplete : function(data) {
			if(data.getCurrentViewData().length == 1){
				voiceMailBoxGrid.setSelection("1");
				selectRowAction(data.getCurrentViewData()[0]);
			}
			parent.setParentIframeHeight();
		},
		dataUrl: '<ifvm:action name="getVoiceMailBoxList"/>',
		columns:[
			  {
	      		  field : 'telLdinDt', headerText : '<spring:message code="V00105"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.tel_ldin_dt' }/*전화인입일시 */
	      	  },{
	      		  field : 'cardNo', headerText : '<spring:message code="V00106"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.card_no' }/*카드번호 */
	      	  },{
	      		  field : 'telNo', headerText : '<spring:message code="V00107"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.tel_no' }/*전화번호 */
	      	  },{
	      		  field : 'regYn', headerText : '<spring:message code="V00108"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.reg_yn' }/*등록여부 */
	      	  },{
	      		  field : 'regDt', headerText : '<spring:message code="V00109"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.reg_dt' }/*등록일시 */
	      	  },{
	      		  field : 'errYn', headerText : '<spring:message code="V00110"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.err_yn' }/*오류여부 */
	      	  },{
	      		  field : 'errCd', headerText : '<spring:message code="V00111"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.ERR_CD' }/*오류구분 */
	      	  },{
	      		  field : 'errDt', headerText : '<spring:message code="V00112"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.err_dt' }/*오류일시 */
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false,
	      		  customAttributes : {
	      			  index : 'a.rid' }/*rid */
	      	  },{
	      		  field : 'callId', headerText : 'callId', visible : false,
	      		  customAttributes : {
	      			  index : 'a.call_id' }/*callId */
	      	  },{
	      		  field : 'cardPwd', headerText : 'cardPwd', visible : false,
	      		  customAttributes : {
	      			  index : 'a.card_pwd' }/*cardPwd */
	      	  },{
	      		  field : 'ridCust', headerText : 'ridCust', visible : false,
	      		  customAttributes : {
	      			  index : 'a.rid_cust' }/*ridCust */
	      	  },
		],
		requestGridData : {
	    	  nd   : new Date().getTime(),
	    	  rows : 10,
	    	  sidx : 'a.tel_ldin_dt',
	    	  sord : 'desc',
	    	  _search : false
	      },
	      rowList : [10,25,50,100],
		  radio:true
// 		tempId : 'ifvGridExcelTemplete'
	};
	voiceMailBoxGrid = $("#voiceMailBoxListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function init(){
	clickInitializeVoiceMailBoxListBtn();
	getVoiceMailBoxListOnlyRegYnIsN();

	$("#cardRegScreen").show();
	$("#consultRegScreen").hide();
}

//탭 컨텐츠 생성
function tabContent(){
	$('#tabContent').DrawTab({
		item: [
			{label: '<spring:message code="V00113"/>', href: '<ifvm:url name="cardReg"/>'},
			{label: '<spring:message code="V00114"/>', href: '<ifvm:url name="consultReg"/>'},
		]
	})

	//카드등록 탭 클릭
	$("a[href='/voc/voiceMailBox/include/cardReg']").click(function(){
		$("#consultRegScreen").hide();
		$("#cardRegScreen").show();
	});

	//상담등록 탭 클릭
	$("a[href='/voc/voiceMailBox/include/consultReg']").click(function(){
		$("#cardRegScreen").hide();
		$("#consultRegScreen").show();
	});
	
	//상담등록 안내 tooltip
	var contents = '<spring:message code="V00218"/>'; //상담등록은 카드등록을 완료한 회원일 경우에만 가능합니다.
	
	$(".tab-list li:nth-child(2)").mouseover(function(e){
		$('<p class="tooltip"></p>')
		.html(contents)
		.appendTo('body')
		.fadeIn('slow');
	}).mousemove(function(e) {
        var mousex = e.pageX + 20; //Get X coordinates
        var mousey = e.pageY + 10; //Get Y coordinates
        $('.tooltip')
        .css({ top: mousey, left: mousex })
    }).mouseout(function(){
		$('.tooltip').remove();
	});
}


function clickMemDetailBtn(){
	mbrDetailInfo ={
			id : "mbrDetailInfoPop",
			url : '<ifvm:url name="viewDetailInfoPop"/>',
			pop : function(obj){
				this.url = '<ifvm:url name="viewDetailInfoPop"/>'+'?ridMbr='+ridMbr
				$("#"+this.id).ifvsfPopup({
		            enableModal : true,
		            enableResize : false,
		            contentUrl : this.url,
		            contentType : "ajax",
		            title : '<spring:message code="L00833"/>', // 멤버십 회원 상세 정보,
		            width : '1200px',
		            close : this.close
		        });
			},
			beforeClose : function(obj){

			},
			close: function(obj){
				if(obj){
					mbrDetailInfo.beforeClose(obj)
				}
				var _popObj = eval(this.id);
				mbrDetailInfoPop._destroy();

			}
	}
	mbrDetailInfo.pop();
}


//상담목록 탭 > 회원상세 팝업 버튼
/* function clickMemDetailBtn(){
	$("#mbrDetailInfoPop").ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : '<ifvm:url name="viewDetailInfoPop"/>?ridMbr='+ridMbr,
        contentType : "ajax",
        title : '<spring:message code="L00833"/>', // 멤버십 회원 상세 정보,
        width : '1800px',
        close : 'mbrDetailInfoPopClose'
    });
}

//상담목록 탭 > 회원상세 팝업 닫기
function mbrDetailInfoPopClose(){
	mbrDetailInfoPop._destroy();
}
 */
//공통 조회 호출
function clickSearchVoiceMailBoxListBtn() {
    $.fn.ifvmSubmitSearchCondition("voiceMailBoxSearchList", getVoiceMailBoxList);
}

//공통 조회 조건 목록 설정
function clickInitializeVoiceMailBoxListBtn() {
    $.fn.ifvmSetCommonCondList("voiceMailBoxSearchList","PGM_V_005");
}

//등록여부 formatter
// function regIsYn(cellvalue, options, rowObjec){
// 	var isYn="";
// 	var regCnt=null;
// 	regCnt = rowObjec.regYn;

// 	if(regCnt == 1 || regCnt == "Y"){
// 		isYn="Y"
// 	}else{
// 		isYn="N";

// 	}
// 	return isYn;
// }

//오류여부 formatter
// function errIsYn(cellvalue, options, rowObjec){
// 	var isYn = "";
// 	var errCnt=null;
// 	errCnt = rowObjec.errYn;

// 	if(errCnt == 1 || errCnt == "Y"){
// 		isYn="Y"
// 	}else{
// 		isYn="N";

// 	}
// 	return isYn;
// }

//등록여부가 N인 음성사서함목록만 조회
function getVoiceMailBoxListOnlyRegYnIsN(){
// 	regYnFlag = true;
// 	getVoiceMailBoxList();
// 	regYnFlag = false;
	$("#voiceMailBoxSearchList .searchTextVal option:selected").filter(function(){
		if($(this).attr('joinsrcclm') == 'REG_YN'){
			$(this).parents('.SearchCondition').find('.changeTypeAreaCode select').val('N');
		}
	});
	clickSearchVoiceMailBoxListBtn();
}

//음성사서함 목록 row 선택 시
function selectRowAction(data){
	//가원장 추가정보 disabled 처리
	$("#mbrName, #cardNo, #transmitNo, #errYn, #validateCardChkBtn, #regAddCardBtn, #regNewMemCardBtn").attr("disabled",false);
	$("#errCd, #errContent").attr("disabled",true);

	if(data.callId != null){
		callList();
	}

	$("a[href='/voc/voiceMailBox/include/consultReg']").attr("class","makeTabDisable");
	//실 고객 정보 매핑
	if(data.regYn == 'Y' && data.ridCust != "" && data.ridCust != null){
		ridCust = data.ridCust;
		$("a[href='/voc/voiceMailBox/include/consultReg']").attr("class",null);
	}

	getRealCustDetail(data);
	getCustAddInfoDetail(data);

	//마스킹해제 버튼 disabled 처리
	$("#unmaskBtn, #unmaskBtn2").attr("disabled",null);
	$("#callTransmitNo, #msgTransmitNo, #callContactableNo, #msgContactableNo, #callHomePhoneNo, #msgHomePhoneNo, #callMobilePhoneNo, #msgMobilePhoneNo").attr("disabled",true);
}

//공통 조회 조건 목록 설정
function searchCondInit() {
    $.fn.ifvmSetCommonCondList("commSearchList","PGM_V_005");
}

$(document).ready(function(){
    //공통 조회 조건 목록 설정
    searchCondInit();
    
    //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit();
    });
    
	init();

	tabContent();

	$.ifvEnterSetting(["#voiceMailBoxSearchList"], function(){
		clickSearchVoiceMailBoxListBtn();
		data=[];
		selectRowAction(data);
		resetCallList();
	});

	$("#searchVoiceMailBoxListBtn").click(function(){
		data=[];
		selectRowAction(data);
		resetCallList();
	});
	
	$("a[href='/voc/voiceMailBox/include/consultReg']").attr("class","makeTabDisable");
	
});

$(window).load(function(){
// 	if(callContactRid != "" && callContactRid != null){
// 		voiceMailBoxGrid.setSelection("1");
// 	}
});

</script>

<style>
	.makeTabDisable{
		pointer-events: none;
	}
	.tooltip {
		display:none;
		position:absolute;
		border:1px solid #d8b422;
		background-color:#fffdd7;
		padding:10px;
		color:#676767;
		font-size:11px;
		opacity: 100;
		filter: alpha(opacity=100);
		box-sizing: border-box;
		-webkit-box-sizing: border-box;
		-moz-box-sizing: border-box;
	}
</style>

<div class="page-title">
    <h1>
    <spring:message code="V00104" />
    </h1>
</div>

<!-- 카드등록 -->
<div id="cardRegScreen">

	<div>
	    <div class="page_btn_area">
	        <div class="col-xs-3">
	            <span><spring:message code="L01838" /></span>
	        </div>
	        <div class="col-xs-9 searchbtn_r">
	            <ifvm:inputNew type="button" id="searchVoiceMailBoxListBtn"  text="L00030" btnType="search" btnFunc="clickSearchVoiceMailBoxListBtn"/>
	            <ifvm:inputNew type="button" id="initializeVoiceMailBoxListBtn"  text="L00031" btnType="" btnFunc="clickInitializeVoiceMailBoxListBtn"/>
	        </div>
	    </div>
	    <div class="well form-horizontal well_bt5" id="voiceMailBoxSearchList" >
	    </div>
	</div>

	<div>
	    <div class="page_btn_area" >
	        <div class="col-xs-7">
	            <span><spring:message code="M00277" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	        	<ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload('voiceMailBoxListGrid')" objCode="COM_EXC_001"/>
	        </div>
	    </div>
	    <div id="voiceMailBoxListGrid" class="white_bg grid_bd0"></div>
	</div>

</div>

<!-- 상담등록 -->
<div id="consultRegScreen">

	<div class="page_btn_area" id="headForm">
		<div class="col-xs-2">
			<span><spring:message code="L00833"/></span>
		</div>
		<div class="col-xs-10 searchbtn_r">
			<ifvm:inputNew type="button" id="memDetailBtn"  text="L00820" btnType="" btnFunc="clickMemDetailBtn"/>
		</div>
		</div>
     		<div class="well form-horizontal well_bt5" id="commSearchList" >
    	</div>
	</div>
	<div class="form-horizontal underline top_well" id="mbrForm" >
		<div class="row">
			<div class="half_wrap top_well">
				<div class="half_content half_left qt_border">
					<div class="page_btn_area">
						<div class="col-xs-2">
							<span><spring:message code="L00834"/></span><!-- 회원정보 -->
						</div>
						<div class="col-xs-10 searchbtn_r">
<%-- 							<ifvm:inputNew type="button" btnFunc="gMbrDetail.mbrDetailInfo.pop" text="L00820" /><!-- 회원상세 --> --%>
<%-- 							<ifvm:inputNew type="button" btnFunc="gMbrDetail.viewAvlPoint.pop" text="L00826" />< !-- 가용포인트 --> --%>
							<%-- <ifvm:inputNew type="button" id="searchCondBtn" text="L00830" disabled="true" /> --%><!-- 비밀번호 변경 -->
<%-- 							<ifvm:inputNew type="button" btnFunc="gMbrDetail.checkPwCngDate.pop" text="L00831" /><!-- 비밀번호 수정일시 --> --%>
						</div>

					</div>
					<div class="form-horizontal top_well underline" id="reachInfo" >
						<div class="row">
							<ifvm:inputNew type="text" id="custNm"   dto="custNm"	disabled="true"
								label="L00835" labelClass="2" conClass="4" /><!-- 회원명-->
							<ifvm:inputNew type="text" id="mbrNo"   dto="mbrNo"    disabled="true"
								label="L00836" labelClass="2" conClass="4" /><!-- 회원번호 -->
						</div>
						<div class="row">
							<ifvm:inputNew type="select" id="memDiv"   dto="memDiv"	disabled="true"
								label="L00837" labelClass="2" conClass="4" /><!-- 회원구분-->
							<ifvm:inputNew type="select" id="tierCd"   dto="tierCd"    disabled="true"
								label="L00838" labelClass="2" conClass="4" /><!-- 회원등급 -->
						</div>
						<div class="row">
							<ifvm:inputNew type="text" id="homeTelNo"   dto="homeTelNo"	icon="phone"
								label="L00839" labelClass="2" conClass="4" disabled="true"/><!-- 자택전화번호-->
<!-- 							<div class="col-xs-1 middle"> -->
<%-- 								<ifvm:inputNew type="button" id="callConNo" nuc="" btnType="phone" btnFunc="makeCallForContactInfo" className="btn-imgonly"	disabled="true"/> --%>
<!-- 							</div> -->
							<ifvm:inputNew type="text" id="hhpNo"   dto="hhpNo" icon="phone"	disabled="true"
								label="L00840" labelClass="2" conClass="4" /><!-- 핸드폰번호 -->
<!-- 							<div class="col-xs-1 middle"> -->
<%-- 								<ifvm:inputNew type="button" id="callHpNo" nuc="" btnType="phone" btnFunc="makeCallForHhpNo" className="btn-imgonly"	disabled="true"/> --%>
<!-- 							</div> -->
							<script>
							//소프트폰 전화걸기 함수
							function makeCallForContactInfo(){
								var contactInfo = $("#homeTelNo").val();

								parent.localSoftMakeCall(contactInfo,null);
							}
							function makeCallForHhpNo(){
								var phoneNo = $("#callHpNo").val();

								parent.localSoftMakeCall(phoneNo,null);
							}
							</script>
					   </div>
						<div class="row">
							<ifvm:inputNew type="select" id="lunarGbnCd"   dto="lunarGbnCd"    disabled="true"
								label="L00841" labelClass="2" conClass="4" /><!-- 본인생일구분-->
							<ifvm:inputNew type="text" id="birthDt"   dto="birthDt"    disabled="true"
								label="L00842" labelClass="2" conClass="4" /><!-- 본인생년월일 -->
					   </div>
					   <div class="row">
<%-- 					   	 <ifvm:inputNew type="search" id="addr1Zip|addr1ZipSearch" names="addr1Zip" hidId="addr1ZipTemp" hidDto="addr1ZipTemp" dto="addr1Zip" disabled="true" --%>
<%-- 						   btnFunc="addrSearchHelpBtn" searchBlurEvent="addrSearchHelpBlur" searchEnterEvent="addrSearchHelpEnter" label="L00843"  labelClass="2" conClass="4" /> --%>
					   	 <ifvm:inputNew type="text" id="addr1Zip|addr1ZipSearch" names="addr1Zip" hidId="addr1ZipTemp" hidDto="addr1ZipTemp" dto="addr1Zip" disabled="true"
						    label="L00843"  labelClass="2" conClass="4" />
	 						<!-- 자택우편번호-->

							<ifvm:inputNew type="text" id="ownhomeAdrChgDt"   dto="ownhomeAdrChgDt"    disabled="true"
								label="L00844" labelClass="2" conClass="4" /><!-- 주소변경일시 -->
					   </div>
					   <div class="row">
							<ifvm:inputNew type="text" id="addr1Dflt"   dto="addr1Dflt"
								label="L00845" labelClass="2" conClass="10"  disabled ="true"  /><!-- [도로명]주소 -->
					   </div>
					   <div class="row">
							<ifvm:inputNew type="text" id="addr1Dtl"   dto="addr1Dtl"
								label="L00846" labelClass="2" conClass="10" disabled ="true" /><!-- [도로명]주소상세 -->
					   </div>
					</div>
				</div>
				<div class="half_content half_right">
					<div class="page_btn_area">
						<div class="col-xs-2">
							<span><spring:message code="L00847"/></span><!-- 추가정보 -->
						</div>
						<div class="col-xs-10 searchbtn_r">

<%-- 							<ifvm:inputNew type="button" id="changeTaxiBtn" btnFunc="gMbrDetail.changeTaxi"	text="L00821" /><!-- 개인택시 전환 --> --%>
<%-- 							<ifvm:inputNew type="button" id="changeNmbrBtn" btnFunc="gMbrDetail.changeNmbr"	text="L01857" /><!-- 일반회원 전환 --> --%>
<%-- 							<ifvm:inputNew type="button" btnFunc="gMbrDetail.changeCorpTaxiYn" text="L00822" /><!-- 법인택시 설정/해제 --> --%>
<%-- 							<ifvm:inputNew type="button" id="webJoinErrorBtn" btnFunc="gMbrDetail.webJoinError.pop" text="L00823" /><!-- 웹가입 에러처리 --> --%>

						</div>
					</div>
					<div class="form-horizontal top_well underline" id="mktAgree" >
						<div class="row">
							<ifvm:inputNew type="text" id="avlPoint"   dto="avlPoint"    disabled="true"	className="text-right"
								label="L00848" labelClass="2" conClass="4" /><!-- 가용포인트-->
							<ifvm:inputNew type="text" id="totChangePoint"   dto="totChangePoint"    disabled="true"	className="text-right"
								label="L00849" labelClass="2" conClass="4" /><!-- 총충전포인트 -->
						</div>
						<div class="row">
							<ifvm:inputNew type="text" id="giftAvlPoint"   dto="giftAvlPoint"    disabled="true"	className="text-right"
								label="L00851" labelClass="2" conClass="4" /><!-- 선물가능포인트 -->
							<ifvm:inputNew type="text" id="giftPoint"   dto="giftPoint"    disabled="true"	className="text-right"
								label="L00850" labelClass="2" conClass="4" /><!-- 선물받은포인트-->
						</div>
						<div class="row">
							<ifvm:inputNew type="text" id="extncPamMonth"   dto="extncPamMonth"    disabled="true"
								label="L00852" labelClass="2" conClass="4" /><!-- 소멸예정월-->
							<ifvm:inputNew type="text" id="extncPamPoint"   dto="extncPamPoint"    disabled="true"	className="text-right"
								label="L00853" labelClass="2" conClass="4" /><!-- 소멸예정포인트 -->
						</div>
						<div class="row">
							<ifvm:inputNew type="text" id="wbMemId"   dto="wbMemId"    disabled="true"
								label="L00854" labelClass="2" conClass="4" /><!-- 웹회원ID-->
							<ifvm:inputNew type="select" id="sbscChnlCd"   dto="sbscChnlCd"    disabled="true"
								label="L00859" labelClass="2" conClass="4" /><!-- 가입채널-->
						</div>
						<div class="row">
							<ifvm:inputNew type="text" id="semiVipStartDt"   dto="semiVipStartDt"    disabled="true"
								label="L02006" labelClass="2" conClass="4" /><!-- 맛보기 시작일-->
							<ifvm:inputNew type="select" id="sbscChnlDtlCd"   dto="sbscChnlDtlCd"    disabled="true"
								label="L00860" labelClass="2" conClass="4" /><!-- 가입채널상세-->

						</div>
						<div class="row">
							<ifvm:inputNew type="text" id="semiVipEndDt"   dto="semiVipEndDt"    disabled="true"
								label="L02007" labelClass="2" conClass="4" /><!-- 맛보기 종료일-->
							<ifvm:inputNew type="singleCheckbox" id="wbMemYn" label="L00855" values="wbMemYn" disabled="true"
								labelClass="2" conClass="1" />
<%-- 							<ifvm:inputNew type="singleCheckbox" id="e1MemYn" label="L00856" values="e1MemYn" disabled="true" --%>
<%-- 								labelClass="2" conClass="1" /> --%>
						</div>

						<div class="row">
							<ifvm:inputNew type="singleCheckbox" id="mktAgrePrvInfoOpt" label="L02099" values="mktAgrePrvInfoOpt" 	disabled="true"
								dto="mktAgrePrvInfoOpt" 	labelClass="3" conClass="1" /><!-- 개인정보 수집 및 이용 동의-->
<%-- 							<ifvm:inputNew type="singleCheckbox" id="corpTaxiYn"  label="L00857" values="corpTaxiYn" disabled="true" --%>
<%-- 								labelClass="4" conClass="1" /> --%>
							<%--<ifvm:inputNew type="singleCheckbox" id="eventTgtYn"  label="L00858" values="eventTgtYn" disabled="true"
								labelClass="2" conClass="1" /> --%>
						</div>
						<div class="col-xs-12">

						</div>
						<ifvm:inputNew type="hidden" id="hCity"   dto="hCity"  />
						<ifvm:inputNew type="hidden" id="hGu"  dto="hGu"   />
						<ifvm:inputNew type="hidden" id="addr1JiDflt"  dto="addr1JiDflt"   />
						<ifvm:inputNew type="hidden" id="addr1JiDtl"  dto="addr1JiDtl"  />
						<ifvm:inputNew type="hidden" id="addr1JiZip"  dto="addr1JiZip"  />

					</div>
				</div>
			  </div>
		</div>

	</div>

</div>

<!-- 탭 컨텐츠 -->
<div id="tabArea">
	<div class="btn-group btn-group-justified" id="tabType">
	       <div id="tabContent" ></div>
	</div>
</div>

<!-- 상담목록 탭 > 회원상세 팝업 버튼 -->
<div id="mbrDetailInfoPop"></div>

<!-- 녹취파일 듣기 팝업 -->
<div id="playRecordFilePop"></div>