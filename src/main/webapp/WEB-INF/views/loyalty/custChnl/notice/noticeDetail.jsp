<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 이미지 업로드 -->
<%@ include file="/WEB-INF/views/layouts/default/sessionScript.jsp" %>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/common/imgUpload.js'></script>
<style>
#NoticeTab{z-index : 1}
</style>
<div class="page-title">
    <h1>
        <span> <spring:message code="D00002" /></span>
    </h1>
</div>
<div>
	<div class="page_btn_area">
	    <div class="col-xs-5">
	        <span>공지사항<%-- <spring:message code="D00004" /> --%></span>
	    </div>
	    <div class="col-xs-7 searchbtn_r">
			<ifvm:inputNew type="button" id="btnMasterSave"  btnFunc="btnMasterSaveClick" btnType="save" text="L00074" objCode="btnMasterSave_OBJ" />
			<ifvm:inputNew type="button" id="btnList" btnFunc="btnListClick" text="D00024" objCode="btnList_OBJ"/>
	    </div>
	</div>
	
	<div class="well form-horizontal" id="noticeMasterForm">
		<div class="row qt_border">
			<ifvm:inputNew type="radio" id="noticeStatus" names="noticeStatus" dto="noticeStatus" required="true" label="L00090" labelClass="2" conClass="9" text="D00005|D00006" values="true|false" checkIndex="2"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="noticeMasterTitle" names="noticeMasterTitle" dto="noticeMasterTitle" required="true" label="D00086" labelClass="2" conClass="9" maxLength="200"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="date" id="noticeShowDate" names="noticeShowDate" dto="noticeShowDate" label="D00008" labelClass="2" conClass="3" />
		</div>
		<div class="row qt_border" id="imageSetting">
			<!-- 이미지 업로드 -->
			<label class="col-xs-2 control-label"><spring:message code="D00010"/></label>
			<div class="col-xs-9 control_content" style="font-size:0; line-height:0;">
				<div class="picture_area" id="backImage">
				</div>
				<ifvm:inputNew type="button" id="copyUrlBtn" btnFunc="btnCopyUrl" text="D10257" objCode="copyUrlBtn_OBJ"/><%-- url복사 --%>
			</div>
		</div>
	</div>
</div>
<div id="noticeDetailTabArea">
	<!-- 탭 컨텐츠 -->
	<div>
		<div id="tabContent" class="white_bg grid_bd0"></div>
	</div>
</div>

<script id="logoImageTemplatePop" type="text/x-jquery-tmpl">
<div id='logoImgContainerPop${'${'}index}' class="image_box" seq='${'${'}index}' isBind='false' RotateAngle='0' >
	<form id='logoUploadFormPop${'${'}index}' method="POST" enctype="multipart/form-data" style="float: left;">
		<input id="logoUploadPop${'${'}index}" type="file" name="file" data-url="<ifvm:action name="tempUploadS3"/>" onclick="javascript:backImage.clickEditImage(this);" title='수정'>
	</form>
	<div class="btns" id="logoPostPopPicBtns${'${'}index}">
		<a id="logoImgDelPop${'${'}index}" href="javascript:;" onclick="javascript:imageRemove2(this);" title='이미지 삭제'><img src='${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_x.png' class="btn_delete" /></a>
	</div>
	<img id='logoImgPop${'${'}index}' width="96px" height="96px" src='${pageContext.request.contextPath}/resources/images/beacon/store/ico_bg_camera.gif' class="handle" />
	<div class="upload_progress_container" id="progress2${'${'}index}"></div>
</div>
</script>
<script>

var noticeDetailTab = $('#noticeDetailTabArea').DrawTab({
	item : items
	/* [
	{ 	label : '<spring:message code="D00083"/>', href : '<ifvm:url name="notice_lang"/>?noticeLang='+'ko' }
	] */
});

var validation;

var updateFlag;
var noticeId = $.ifvGetParam('rid');
var backImage = null;

//이미지 업로드
//var imageInfo = new Array();

if(noticeId == undefined ){
	updateFlag = false;
}
else{

	updateFlag = true;
}

function setDatePicker() {
	var date = $('#noticeShowDate');
	date.val($.ifvGetTodayDate());
	date.ifvDateChecker({});
}

$(document).ready(function() {
	$.ifvmLnbSetting('noticeList');
	setDatePicker();
	$.fn.ifvmSetSelectOptionCommCode("type", "LOY_NOTICE_TYPE", null, null, true);
	backImage = backImageSetting(noticeId, "backImage");
	if(updateFlag){
		detailNotice(noticeId);
	}
});

function detailNotice(id){
	$.ifvSyncPostJSON('<ifvm:action name="getNoticeMasterDetail"/>', {
		noticeId : id
	}, function(result) {

		if(result.noticeStatus == "Y"){
			$("input:radio[name='noticeStatus']:radio[value='true']").attr("checked",true);
		}
		else{
			$("input:radio[name='noticeStatus']:radio[value='false']").attr("checked",true);
		}
		var date = $('#noticeShowDate');
		date.val(result.openDate);
		date.ifvDateChecker({});

		$('#noticeMasterTitle').val(result.noticeTitle);
		$('#type').val(result.type);
		$("#logoImgPop0").attr('src',result.imgUrl1);
		})
}

function btnMasterSaveClick() {
	validation = $('#noticeMasterForm').ifvValidation();

	if(validation.confirm() === false) return;
	else{
		var url;
		var showDate = $("#noticeShowDate").val().split('-')
		showDate = showDate[0] + showDate[1] + showDate[2];

		var type = $("#type").val();
		var uploadImage = backImage.getImageList();

		if(uploadImage.length == 0){
			var snsImg = $("#logoImgPop0").attr('src');
		}else{
			var snsImg = uploadImage[0].filePath;
		}

	  if( noticeId == null ){ //신규
			url = '<ifvm:action name="insertNoticeMaster"/>';
			if(confirm('<spring:message code="M01633"/>') === false) return;
		} else{					//수정
			url = '<ifvm:action name="insertNoticeMaster"/>';
			if(confirm('<spring:message code="M01633"/>') === false) return;
		}

	 $.ifvSyncPostJSON( url,
			{
		 	noticeStatus : $(':radio[name="noticeStatus"]:checked').val(),
			noticeName : $("#noticeMasterTitle").val(),
			openDate : showDate,
			noticeId : noticeId,
			updateFlag : updateFlag,
			type : type,
			imgUrl1 : snsImg
			},
			function(result) {

			 if(result.success == true){
				alert('<spring:message code="M00005"/>');
				location.href = '<ifvm:url name="noticeDetailUrl"/>' + '?rid=' + result.message;
			}
			else{
				alert('<spring:message code="M00029"/>');
			}
			}

		);
	}
}

function backImageSetting(_imgParentId, _containerId){

	var _this = this;
	var tmpArr = new Array();
	for(var i=0; i<10; i++){
		tmpArr.push({ index : i });
	}

	backImage = null;
	$("#"+_containerId).html("");

	var template = $('#logoImageTemplatePop').tmpl(tmpArr);
	$("#"+_containerId).append(template);

	backImage = new ifvMultiUpLoader({
		container : $("#"+_containerId),
		uploadBtn : $('#logoUploadPop'),
		tempUpLoadFormId : 'logoUploadFormPop',
		tempUploadBtnId : 'logoUploadPop',
		imgId : 'logoImgPop',
		btnConId : 'logoPostPopPicBtns',
		imgContainerId : 'logoImgContainerPop',
		deleteBtnId : 'logoImgDelPop',
		progressId : 'progress2',
		tempImgUrl : '${pageContext.request.contextPath}/resources/images/beacon/store/ico_bg_camera.gif',
		tempUploadIE : '<ifvm:action name="tempUploadIE"/>',
		imgParentId : _imgParentId,
		'maxNumber' : 1,
		'tempImgWidth' : 96,
		'tempImgHeight' : 96,
		width:96,
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

	return backImage;
};


//url 복사
function btnCopyUrl() {
	var imgUrl1 = $("#logoImgPop0").attr('src');
	if($.fn.ifvmIsNotEmpty(imgUrl1)) {
		copyToClipboard(imgUrl1);
		alert('url이 복사되었습니다');
	} else {
		alert('url이 존재 하지 않습니다.');
	}
}

function imageRemove2(_this) {
	var idx = _this.id.substr(_this.id.length - 1, 1);
	var obj = backImage.getImgArr()[idx];
	backImage.delImage(_this);
}

function copyToClipboard(val) {
	  var t = document.createElement("textarea");
	  document.body.appendChild(t);
	  t.value = val;
	  if (navigator.userAgent.match(/ipad|ipod|iphone/i)) {
		  // save current contentEditable/readOnly status
		  var editable = t.contentEditable;
		  var readOnly = t.readOnly;

		  // convert to editable with readonly to stop iOS keyboard opening
		  t.contentEditable = true;
		  t.readOnly = true;

		  // create a selectable range
		  var range = document.createRange();
		  range.selectNodeContents(t);

		  // select the range
		  var selection = window.getSelection();
		  selection.removeAllRanges();
		  selection.addRange(range);
		  t.setSelectionRange(0, 999999);

		  // restore contentEditable/readOnly to original state
		  t.contentEditable = editable;
		  t.readOnly = readOnly;
	  } else {
		  t.select();
	  }
	  document.execCommand('copy');
	  document.body.removeChild(t);
}

function btnListClick() {
	qtjs.href('<ifvm:url name="noticeListUrl"/>');
}
</script>