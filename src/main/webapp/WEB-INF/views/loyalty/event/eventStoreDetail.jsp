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
<style>
	.red{ color : #ff0000;}
</style>
<div class="page-title">
    <h1>
		GLO SHOP 조회 및 등록
        <span>&gt; 신규</span>
    </h1>
</div>

<div class="page_btn_area">
    <div class="col-xs-5">
        <span>일반 정보</span>
    </div>
    <div class="col-xs-7 searchbtn_r">
		<ifvm:inputNew type="button" id="btnMasterSave" btnFunc="btnMasterSaveClick" btnType="save" text="L00074" />
		<ifvm:inputNew type="button" id="btnList" btnFunc="btnListClick" text="D00024" />
    </div>
</div>

<div class="form-horizontal underline top_well" id="bannerMasterForm">
	<div class="row qt_border">
		<%-- 스토어명 --%>
		<label class="col-xs-1 control-label"><span class="asterisk">*</span>스토어명</label>
		<div class="col-xs-8 control_content">
			<ifvm:input type="text" id="storeNm" names="storeNm" required="true" maxLength="20"/>
		</div>
	</div>
	<div class="row qt_border">
		<%-- 스토어상세 --%>
		<label class="col-xs-1 control-label"><span class="asterisk" id="storeAstrick">*</span>스토어 상세</label>
		<div class="col-xs-8 control_content">
			<ifvm:input type="textarea" id="storeDesc" names="storeDesc" required="true" maxLength="1000" rows="3"/>
		</div>
	</div>
	
	<div class="row qt_border">
		<%-- 관련 채널 명 --%>
		<label class="col-xs-1 control-label"><span class="asterisk">*</span>관련 채널명</label>
		<div class="col-xs-2 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="relationChnlNm" names="relationChnlNm" required="true" disabled="true"/>
				<span class="input-group-addon" id="relationChnlListPop">
					<a><i class="fa fa-search"></i></a>
				</span>
			</div>
		</div>
		
		<%-- 스토어 유형 --%>
		<label class="col-xs-4 control-label"><span class="asterisk">*</span>스토어 유형</label>
		<div class="col-xs-2 control_content">
			<ifvm:input type="select" id="storeType" names="storeType" required="true" disabled="true"/>
		</div>
	</div>
	
	<div class="row qt_border">
		<%-- 영업시간 --%>
		<label class="col-xs-1 control-label">영업시간</label>
			<ifvm:inputNew type="time" id="chnlOpenTime" disabled="true" conClass="1"/>
			<div class="swung_dash col-xs-1 "> ~ </div>
			<ifvm:inputNew type="time" id="chnlCloseTime" disabled="true" conClass="1"/>
		<%-- 스토어 코드 --%>
		<label class="col-xs-4 control-label">스토어 코드</label>
		<div class="col-xs-2 control_content">
			<ifvm:input type="text" id="storeCode" disabled="true"/>
		</div>
	</div>
	<div class="row qt_border">
		<%-- 스토어 위치 --%>
		<label class="col-xs-1 control-label">스토어 위치</label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="text" id="jibunAddr" disabled="true"/>
		</div>
	</div>
	<div class="row qt_border">
		<%-- 활성기간 --%>
		<label class="col-xs-1 control-label"><span class="asterisk">*</span>활성기간</label>
		<div class="col-xs-1 control_content">
			<ifvm:input type="date" id="startDate" names="startDate" required="true"/>
		</div>
		<div class="col-xs-1 swung_dash">~</div>
		<div class="col-xs-1 control_content">
			<ifvm:input type="date" id="endDate" names="endDate" required="true"/>		
		</div>
		<%-- 스토어 순서 --%>
		<label class="col-xs-4 control-label"><span class="asterisk">*</span>스토어 순서</label>
		<div class="col-xs-1 control_content">
			<ifvm:input type="number" id="storeSeq" names="storeSeq" required="true"/>
		</div>
		<div class="col-xs-3 control_content"> 
			<a><i class="helpBtn" style="vertical-align: middle;">
				<div class="helptxt" style="display:none;">
					스토어 순서가 겹친다면 스토어순서 & 활성 종료일이 늦은순으로 표시 합니다.
				</div>
			</i></a>
		</div>
	</div>
	<div class="half_wrap top_well">
		<div class="page_btn_area">
			<div class="col-xs-10">
				<span>포인트 적립/사용 조건</span>
			</div>
		</div>
		<div class="row qt_border">
			<%-- 포인트 사용 제한 횟수 --%>
			<label class="col-xs-1 control-label"><span class="asterisk" id="useLimitAstr">*</span>사용 제한 횟수</label>
			<div class="col-xs-2 control_content">
				<ifvm:input type="number" id="usePointLimitCnt" names="usePointLimitCnt"/>
			</div>
			<%-- 포인트 사용 금액 --%>
			<label class="col-xs-4 control-label"><span class="asterisk" id="usePointAstr">*</span>포인트 사용 금액</label>
			<div class="col-xs-2 control_content">
				<div class="input-group">
					<ifvm:input type="text" id="usePointPrice" names="usePointPrice" disabled="true"/>
					<span class="input-group-addon" id="usePointPricePop">
						<a><i class="fa fa-search"></i></a>
					</span>
				</div>
			</div>
		</div>
		<div class="row qt_border">
			<%-- 포인트 적립 제한 횟수 --%>
			<label class="col-xs-1 control-label"><span class="asterisk" id="acrlLimitAstr">*</span>적립 1일 제한 횟수</label>
			<div class="col-xs-2 control_content">
				<ifvm:input type="number" id="acrlPointLimitCnt" names="acrlPointLimitCnt"/>
			</div>
			<div class="col-xs-3 control_content"> 
			<a><i class="helpBtn" style="vertical-align: middle;">
				<div class="helptxt" style="display:none;">
					혜택(하단탭)에 등록된 혜택 당 1일 적립 횟수를 제한합니다.
				</div>
			</i></a>
		</div>
		</div>
	</div>
	<div class="page_btn_area">
		<div class="col-xs-10">
			<span>스토어 상세</span>
		</div>
	</div>
	
	<div class="well form-horizontal underline" id="monthlyArea">
		<div class="row qt_border" style="padding-top: 10px;">
			<div class="row qt_border">
				<label class="col-xs-1 control-label detailImageOne">이미지 1</label>
				<div class="col-xs-1 detailImageOne" style="font-size:0; line-height:0;">
					<div class="picture_area" id="detailImageOne"></div>
					<label class="col-xs-9 red" style="text-align:center; font-size: 11px;">(528*396)</label>
				</div>
				<label class="col-xs-1 control-label detailImageTwo">이미지 2</label>
				<div class="col-xs-1 detailImageTwo" style="font-size:0; line-height:0;">
					<div class="picture_area" id="detailImageTwo"></div>
					<label class="col-xs-9 red" style="text-align:center; font-size: 11px;">(528*396)</label>
				</div>
				<label class="col-xs-1 control-label mainImage">더보기 이미지 </label>
				<div class="col-xs-1 mainImage" style="font-size:0; line-height:0;">
					<div class="picture_area" id="mainImage"></div>
					<label class="col-xs-9 red" id="mainImageSize" style="text-align:left;font-size: 11px;"></label>
				</div>
			</div>
		</div>
		<div class="row qt_border">
			<%-- 유의사항 --%>
			<label class="col-xs-1 control-label">유의사항</label>
			<div class="col-xs-8 control_content"> 
				<ifvm:input type="textarea" id="storeNotice" names="storeNotice" maxLength="2000" rows="5"/>
			</div>
		</div>
	</div>
</div>
<div id="eventTabDiv" style="margin-top:20px"></div>
<div id="popupContainer" class="popup_container"></div><!-- 팝업 -->
<div id="eventImageViewPop" class="popup_container"></div><!-- 팝업 -->

<style>
	.helpBtn {
		background-image: url("/resources/images/icons/btn_help.png");
		background-repeat:no-repeat;
    	background-position:center center;
    	padding-left: 30px;
    	vertical-align: middle;
    	width: 17px;
    	height: 17px;
    	line-height: 17px;
	}
</style>

<!-- AWS S3용 이미지 템플릿 -->
<script id="imageUploadTemplateAwsS3" type="text/x-jquery-tmpl">
<div id='${'${'}imgId}ContainerPop${'${'}index}' class="image_box" seq='${'${'}index}' isBind='false' RotateAngle='0' style="width: 70px;" >
   <form id='${'${'}imgId}TempUploadForm${'${'}index}' method="POST" enctype="multipart/form-data" style="float: left;">
      <input id="${'${'}imgId}TempUploadBtn${'${'}index}" type="file" name="file" data-url="<ifvm:action name="tempUploadS3"/>" onclick="javascript:${'${'}imgId}.clickEditImage(this);" title='수정'>
   </form>
   <div class="btns" id="${'${'}imgId}PostPopPicBtns${'${'}index}">
      <a id="${'${'}imgId}RotateBtn${'${'}index}" href="javascript:;" onclick="javascript:${'${'}imgId}.rotationImage(this);" title='이미지 회전'><img src='${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_rotation.png' class="btn_delete" style='display: none;' /></a>
      <a id="${'${'}imgId}DeleteBtn${'${'}index}" href="javascript:;" onclick="javascript:${'${'}imgId}.imageRemove(this);" title='이미지 삭제'><img src='${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_x.png' class="btn_delete" /></a>
   </div>
   <img id='${'${'}imgId}LogoImg${'${'}index}' width="70px" height="70px" src='${'${'}defaultImg}' onclick="javascript:imageViewPopup(this);" style='background-color:white' class="handle"/>
   <div class="upload_progress_container" id="${'${'}imgId}Progress${'${'}index}"></div>
</div>
</script>

<script>
var storeRid =  '<%= cleanXss(request.getParameter("rid")) %>';
if(storeRid == "null") storeRid = null;
var thumImage = null;
var mainImage = null;
var detailImageOne = null;
var detailImageTwo = null;
var detailImageThree = null;
var uploadFile = null;
var chnlRid = null;
var storeStatusCd = null;

$(document).ready(function() {
	var attrib01 = '${pageContext.request.contextPath}/resources/images/beacon/store/ico_bg_camera.gif';
	
	//날짜설정
	setChannelCalendar();
	
	//탭설정
	initTab();
	
	$.fn.ifvmSetSelectOptionCommCode("storeType", "EVT_STORE_TYPE", null, null, false);
	
	//이미지 설정
	thumImage = settingImageObject(storeRid, "thumImage", 1, 1, attrib01);
	mainImage = settingImageObject(storeRid, "mainImage", 1, 1, attrib01);
	detailImageOne = settingImageObject(storeRid, "detailImageOne", 1, 1, attrib01);
	detailImageTwo = settingImageObject(storeRid, "detailImageTwo", 1, 1, attrib01);
	detailImageThree = settingImageObject(storeRid, "detailImageThree", 1, 1, attrib01);
	
	//상세 or valid 셋팅
	if(storeRid != null){
		eventStoreDetail(storeRid);		
	}else{
		//valid 초기셋팅
		storeTypeCheck();
	}
	
	//포인트 사용 금액 팝업
	$("#usePointPricePop").on("click",function(){
		if($("#storeType").val() == 'P3'){
			usePointPopUp();
		}else {
			return;
		}
	});
	
	//관련 채널명 팝업
	$("#relationChnlListPop").on("click",function(){
		relationChnlPopUp();
	});
	
	//tool tip
    $('.helpBtn').setupHelpMessage();
	
   //관련 채널명 변경이벤트
	$("#storeType").change(function(){
		benefitTabValidation();
	});
});

//스토어 유형별 validcheck
function storeTypeCheck(){
	var storeType = $('#storeType').val();
	
	// P3 제휴스토어 , P4 플레그쉽 , 처음셋팅
	if(storeType == 'P3'){
		//disabled
		$('#acrlPointLimitCnt').prop('disabled',true);
		$('#usePointLimitCnt').prop('disabled',false);
				
		//required
		$('#usePointLimitCnt').prop('required',true);
		$('#usePointPrice').prop('required',true);
		$('#acrlPointLimitCnt').prop('required',false);
		$('#storeDesc').prop('required',true);
		
		//astrick 
		$("#acrlLimitAstr").hide();
		$("#useLimitAstr").show();
		$("#usePointAstr").show();
		$("#storeAstrick").show();
		
		//val
		$("#acrlPointLimitCnt").val("");
		
		//TAB
		$("#benefitNewBtn").prop("disabled",true);
		$("#benefitDelBtn").prop("disabled",true);
		
		if(storeRid == null){
			eventTab.disabledTab([1]);
			eventTab.disabledTab([2]);
		}else{
			eventTab.abledTab([1]);
			eventTab.abledTab([2]);
		}
		
		$('#pointCancel').prop('disabled',false);
	}else if (storeType == 'P4'){
		//disabled
		$("#acrlPointLimitCnt").prop('disabled',false);
		$("#usePointLimitCnt").prop('disabled',true);
		
		//required
		$('#usePointLimitCnt').prop('required',false);
		$('#usePointPrice').prop('required',false);
		$('#acrlPointLimitCnt').prop('required',true);
		$('#storeDesc').prop('required',false);
		
		//astrick 
		$("#acrlLimitAstr").show();
		$("#useLimitAstr").hide();
		$("#usePointAstr").hide();
		$("#storeAstrick").hide();
		
		//val
		$("#usePointLimitCnt").val("");
		$("#usePointPrice").val("");
		
		//TAB
		if(storeRid == null){
			eventTab.disabledTab([0]);
			eventTab.disabledTab([1]);
			eventTab.disabledTab([2]);
			$("#benefitNewBtn").prop("disabled",true);
			$("#benefitDelBtn").prop("disabled",true);
		}else{
			eventTab.abledTab([0]);
			eventTab.abledTab([1]);
			eventTab.abledTab([2]);
			$("#benefitNewBtn").prop("disabled",false);
			$("#benefitDelBtn").prop("disabled",false);
		}
		$('#pointCancel').prop('disabled',true);
	}else{
		//disabled
		$("#acrlPointLimitCnt").prop('disabled',true);
		$("#usePointLimitCnt").prop('disabled',true);
		
		//required
		$('#usePointLimitCnt').prop('required',false);
		$('#usePointPrice').prop('required',false);
		$('#acrlPointLimitCnt').prop('required',false);
		$('#storeDesc').prop('required',true);
		
		//astrick 
		$("#acrlLimitAstr").hide();
		$("#useLimitAstr").hide();
		$("#usePointAstr").hide();
		$("#storeAstrick").show();
		
		//val
		$("#acrlPointLimitCnt").val("");
		$("#usePointLimitCnt").val("");
		$("#usePointPrice").val("");
		
		//TAB
		eventTab.disabledTab([0]);
		eventTab.disabledTab([1]);
		eventTab.disabledTab([2]);
		$("#benefitNewBtn").prop("disabled",true);
		$("#benefitDelBtn").prop("disabled",true);
		$('#pointCancel').prop('disabled',true);
	}
}

/******************************** 팝업 관련 START ********************************/
 
//이미지 팝업
function imageViewPopup(args) {
	var id = args.id.replace("LogoImg0", "");
	
	var list = eval(id).getImageList();
	
	if (list.length > 0) {
		var obj = list[0];
		var path = obj.filePath;
		
	    $("#eventImageViewPop").ifvsfPopup({
	        enableModal : true,
	          enableResize: false,
	          contentUrl: '<ifvm:url name="eventImageViewPop"/>?path=' + path,
	          contentType: "ajax",
	          title: '', 
	          width: '900px',
	          close : 'eventImageViewPopupClose'
	      });
	}
}

function eventImageViewPopupClose() {
	eventImageViewPop._destroy();
}

//관련 채널 팝업
function relationChnlPopUp() {
    $("#popupContainer").ifvsfPopup({
      enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="relationChnlListPop"/>',
        contentType: "ajax",
        title: '채널 목록',
        width: '1000px',
        close : 'relationChnlPopClose'
    });
}

//관련 채널 팝업 닫기
function relationChnlPopClose() {
	popupContainer._destroy();
}

//포인트 사용 금액 팝업
function usePointPopUp() {
    $("#popupContainer").ifvsfPopup({
      enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="usePointPop"/>',
        contentType: "ajax",
        title: '포인트 사용 금액',
        width: '400px',
        close : 'usePointPopUpClose'
    });
}

//포인트 사용금액 팝업닫기
function usePointPopUpClose() {
	popupContainer._destroy();
}
/****************************** END *************************************/



/************************************************************************
 **                         저장/수정                                          				   **
 ************************************************************************/
function btnMasterSaveClick(){
	var url;
	validation = $("#bannerMasterForm").ifvValidation();
	if(validation.confirm() === false) return;
		
	else{
		var usePointPriceArry = $('#usePointPrice').val().split(',');
		
		//업로드 파일 셋팅
		var uploadImgThum = thumImage.getImageList();
		var uploadImgMain = mainImage.getImageList();
		var uploadImgOne = detailImageOne.getImageList();
		var uploadImgTwo = detailImageTwo.getImageList();
		var uploadImgThree = detailImageThree.getImageList();
		var uploadImgNm = null;
		
		var upImgThum, upImgMain, upImgOne, upImgTwo, upImgThree
		
		if(uploadImgThum.length != 0){
			upImgThum = uploadImgThum[0].filePath;
		}
		
		if(uploadImgMain.length != 0){
			upImgMain = uploadImgMain[0].filePath;
		}
		
		if(uploadImgOne.length != 0){
			upImgOne = uploadImgOne[0].filePath;
		}
		
		if(uploadImgTwo.length != 0){
			upImgTwo = uploadImgTwo[0].filePath;
		}
		
		if(uploadImgThree.length != 0){
			upImgThree = uploadImgThree[0].filePath;
		}
		
		//신규 수정 여부 
		if(storeRid == null){
			url = '<ifvm:action name="saveEventStore"/>'
			if(confirm('<spring:message code="M01633"/>') === false) return;
		} else{
			url = '<ifvm:action name="updateEventStore"/>'
			if(confirm('<spring:message code="M01633"/>') === false) return;
		}
		
		$.ifvSyncPostJSON(url,{
			rid : storeRid,
			storeNm : $("#storeNm").val(),
			relationChnlNm : $("#relationChnlNm").val(),
			chnlRid : chnlRid,
			storeType : $("#storeType").val(),
			startDate : $("#startDate").val(),
			endDate : $("#endDate").val(),
			storeCode : $("#storeCode").val(),
			storeSeq : $("#storeSeq").val(),
			acrlPointLimitCnt : $("#acrlPointLimitCnt").val(),
			usePointLimitCnt : $("#usePointLimitCnt").val(),
			usePointPriceOne : usePointPriceArry[0],
			usePointPriceTwo : usePointPriceArry[1],
			usePointPriceThr : usePointPriceArry[2],
			thumImg : upImgThum,
			mainImg : upImgMain,
			detailImg1 : upImgOne,
			detailImg2 : upImgTwo,
			detailImg3 : upImgThree,
			notice : $("#storeNotice").val(),
			storeDesc : $("#storeDesc").val()
		},function(result){
			alert('<spring:message code="M00005"/>');
			var rid = result.message;
			qtjs.href('<ifvm:url name="eventStoreDetail"/>' + '?rid=' + rid);
		},function(result){
			alert('<spring:message code="M00029"/>');
		});
		
	}
	
}

//상세화면
function eventStoreDetail(args){
	$.ifvSyncPostJSON('<ifvm:action name="eventStoreDetail"/>',{
		rid : args
	},function(result){
		$("#storeNm").val(result.storeEvtNm); 		//스토어명
		chnlRid = result.rid; 	   					//관련 채널 RID
		$("#storeType").val(result.storeType);  	//스토어 유형
		storeTypeCheck();
		$("#relationChnlNm").val(result.chnlNm);	//관련채널명
		$("#startDate").val(result.actStartDt); 	//활성기간
		$("#endDate").val(result.actEndDt);     	//활성기간
		$("#storeCode").val(result.storeCd);		//스토어코드
		$("#storeSeq").val(result.storeSeq);   		//스토어순서
		$("#acrlPointLimitCnt").val(result.pntAcrlLimit); //포인트 적립 제한 횟수
		$("#usePointLimitCnt").val(result.pntUseLimit);   //포인트 사용 제한 횟수
		$("#usePointPrice").val(result.pointUseAmt);  	  //포인트 사용 금액
		$("#storeNotice").val(result.noteTxt);   	 	  //유의사항
		$("#storeDesc").val(result.storeDesc);		//스토어상세
		$("#chnlOpenTime").val(result.chnlOpenTime);
		$("#chnlCloseTime").val(result.chnlCloseTime);
		$("#jibunAddr").val(result.jibunAddr);
		storeStatusCd = result.storeStatusCd;
		
		if($.fn.ifvmIsNotEmpty(result.thumNailImg)){
			var imgobj = [{imgOrgUrl: result.thumNailImg}];
			thumImage.setImgArr(imgobj);
			
		}
		if($.fn.ifvmIsNotEmpty(result.mainImg)){
			var imgobj = [{imgOrgUrl: result.mainImg}];
			mainImage.setImgArr(imgobj);
		}
		if($.fn.ifvmIsNotEmpty(result.detailImg1)){
			var imgobj = [{imgOrgUrl: result.detailImg1}];
			detailImageOne.setImgArr(imgobj);
		}
		if($.fn.ifvmIsNotEmpty(result.detailImg2)){
			var imgobj = [{imgOrgUrl: result.detailImg2}];
			detailImageTwo.setImgArr(imgobj);
			
		}
		if($.fn.ifvmIsNotEmpty(result.detailImg3)){
			var imgobj = [{imgOrgUrl: result.detailImg3}];
			detailImageThree.setImgArr(imgobj);
		}
	});
}
/**************************** 저장/수정 END **********************************/


//달력셋팅
function setChannelCalendar() {
	var startDate = $('#startDate');
	var endDate = $('#endDate');

	//오늘날짜
	startDate.val($.ifvGetTodayDate());
	
	//오늘부터 한달 뒤
	endDate.val($.ifvGetNewDate('m', +1).newDateS);
	
	startDate.ifvDateChecker({
	 maxDate : endDate
	});
	
	endDate.ifvDateChecker({
	 minDate : startDate
	});
}



//이미지 셋팅
function settingImageObject(_imgParentId, _imgId, _size, _maxNumber, _defaultImg){
	var _this = this;
	var tmpArr = new Array();
	for(var i=0; i<_size; i++){
		tmpArr.push({ index : i, imgId : _imgId, defaultImg : _defaultImg });
	}
	
	$("#"+_imgId).html("");
	
	var template = $('#imageUploadTemplateAwsS3').tmpl(tmpArr);
	$("#"+_imgId).append(template);

	var imgObj = null;
	imgObj = new ifvMultiUpLoader({
		container : $("#"+_imgId),
		uploadBtn : $('#' + _imgId + 'TempUploadBtn'),
		tempUpLoadFormId : _imgId + 'TempUploadForm',
		tempUploadBtnId : _imgId + 'TempUploadBtn',
		imgId : _imgId + 'LogoImg',
		btnConId : _imgId + 'PostPopPicBtns',
		imgContainerId : _imgId + 'ContainerPop',
		rotationBtnId : _imgId + 'RotateBtn',
		deleteBtnId : _imgId + 'DeleteBtn',
		progressId : _imgId + 'Progress',
		tempImgUrl : _defaultImg,
		tempUploadIE : '<ifvm:action name="tempUploadIE"/>',
		imgParentId : _imgParentId,
		'maxNumber' : _maxNumber,
		'tempImgWidth' : 70,
		'tempImgHeight' : 70,
		width:96,
		dropZone:null,
		errFunc : function(type){
			var str = null;
			if( type == "maxNumber" ){
				str = '<spring:message code="M02143"/>';
			}else{
				str = '<spring:message code="M02144"/>';
			}
			new ifvConfirm({
				btnTxt1 : '확인',
				btnTxt2 : false,
				isSuccess : false,
				text : str
			});
		}
	});
	
	imgObj.imageRemove = function(args) {
	   var idx = args.id.substr(args.id.length - 1, 1);
	   var obj = imgObj.getImgArr()[idx];
	   imgObj.delImage(args);
	}

	return imgObj;
};

//이미지 삭제
function imageRemove(_this) {
	var idx = _this.id.substr(_this.id.length - 1, 1);
	var obj = backImage.getImgArr()[idx];
	backImage.delImage(_this);
}

/* 탭설정 */
function initTab() {
    eventTab = $('#eventTabDiv').DrawTab({
        item: [
            {label: '혜택', href: '/loyalty/event/include/promotionBenefitTab'},
            {label: '거래내역', href: '/loyalty/event/include/transactionHistTab'},
            {label: '관련회원', href: '/loyalty/event/include/relationMbrTab'}
        ]
    });
}

//목록 버튼
function btnListClick() {
	qtjs.href('<ifvm:url name="eventStoreListNew"/>');
}

</script>