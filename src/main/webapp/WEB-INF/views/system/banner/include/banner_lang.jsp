<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 이미지 업로드 -->
<%@ include file="/WEB-INF/views/layouts/default/sessionScript.jsp" %>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/common/imgUpload.js'></script>

<div class="page_btn_area">
    <div class="col-xs-5">
        <span>베너사항 상세</span>
    </div>
    <div class="col-xs-7 searchbtn_r">
		<ifvm:inputNew type="button" id="btnSave" btnFunc="btnSaveClick" className="btn_right" btnType="save" text="L00074" objCode="banner_LangSave_OBJ" />
    </div>
</div>

<div class="well form-horizontal" id="bannerForm">
	<div class="row qt_border">
		<!-- 이미지 업로드 -->
		<div class="row" id="imageSetting">
			<label class="col-xs-2 control-label"><spring:message code="D00010"/></label>
			<div class="col-sm-9" style="font-size:0; line-height:0;">
				<div class="picture_area" id="backImage">
				</div>
			</div>
		</div>
	</div>
</div>

<script id="logoImageTemplatePop" type="text/x-jquery-tmpl">
<div id='logoImgContainerPop${'${'}index}' class="image_box" seq='${'${'}index}' isBind='false' RotateAngle='0' >
	<form id='logoUploadFormPop${'${'}index}' method="POST" enctype="multipart/form-data" style="float: left;">
		<input id="logoUploadPop${'${'}index}" type="file" name="file" data-url="<ifvm:action name="tempUploadS3"/>" onclick="javascript:backImage.clickEditImage(this);" title='수정'>
	</form>
	<div class="btns" id="logoPostPopPicBtns${'${'}index}">
		<a id="logoImgRotation${'${'}index}" href="javascript:;" onclick="javascript:backImage.rotationImage(this);" title='이미지 회전'><img src='${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_rotation.png' class="btn_delete" /></a>
		<a id="logoImgDelPop${'${'}index}" href="javascript:;" onclick="javascript:imageRemove2(this);" title='이미지 삭제'><img src='${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_x.png' class="btn_delete" /></a>
	</div>
	<img id='logoImgPop${'${'}index}' width="96px" height="96px" src='${pageContext.request.contextPath}/resources/images/beacon/store/ico_bg_camera.gif' class="handle" />
	<div class="upload_progress_container" id="progress2${'${'}index}"></div>
</div>
</script>

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
var validation;

var subUpdateFlag = false;
var bannerLang = '<%= cleanXss(request.getParameter("bannerLang")) %>';
var bannerSubId = null;
var subUpdateFlag = false;
var backImage = null;

$(document).ready(function() {
	$.ifvmLnbSetting('bannerList');

	//이미지 업로드
	backImage = backImageSetting(bannerId, "backImage");

	var textObj = [
	           	{text : '<spring:message code="D00025"/>', color: 'blue'}
	           	,{text : '<spring:message code="D00026"/>', color: 'gray'}
	           	,{text : '<spring:message code="D00011"/>', color: 'gray'}
	           	];

	if(updateFlag){
		detailBannerSub();
	}
	else{
		$("#bannerTitle").focus(function(){
			alert('배너관리 정보를 먼저 저장하세요.');
			$("#bannerMasterTitle").focus();
		})
		$("#bannerDesc").focus(function(){
			alert('배너관리 정보를 먼저 저장하세요.');
			$("#bannerMasterTitle").focus();
		})
	}


});

function detailBannerSub(){
	$.ifvSyncPostJSON('<ifvm:action name="getBannerDetail"/>', {
		bannerId : bannerId,
		bannerLang : bannerLang
	}, function(result) {
		if(result.bannerSubId != null){
			$('#bannerTitle').val(result.bannerTitle);
			$('#bannerDesc').val(result.bannerDesc);

			subUpdateFlag = true;
			bannerSubId = result.bannerSubId;
		}
		else{
			subUpdateFlag = false;
		}

		//이미지 업로드
		if(result.imageUrl != ''){
			backImage.setImgArrList(result.images);
		}
	})
}

function btnSaveClick() {
	validation = $('#bannerForm').ifvValidation();
	if(bannerId != null){
		if(validation.confirm() === false) return;
		else{
			var url;
			//이미지 업로드
			var backImageArr = backImage.getImageList();

		  	if( bannerId == null ){ //신규
				url = '<ifvm:action name="insertBanner"/>';
				if(confirm('<spring:message code="M01633"/>') === false) return;
			} else {				//수정
				url = '<ifvm:action name="insertBanner"/>';
				if(confirm('<spring:message code="M01633"/>') === false) return;
			}

			$.ifvSyncPostJSON( url,
				{
			 	bannerLang : bannerLang,
				bannerName : $("#bannerTitle").val(),
				bannerDesc : $("#bannerDesc").val(),
				bannerMasterId : bannerId,
				updateFlag : subUpdateFlag,
				bannerSubId : bannerSubId,
				subImages  : backImageArr
				},
				function(result) {

				 if(result.success == true){
					alert('<spring:message code="M00005"/>');
					location.href = '<ifvm:url name="bannerDetailUrl"/>' + '?rid=' + bannerId;
				}
				else{
					alert('<spring:message code="M00029"/>');
				}
				}
			);

	}}
	else{
		alert('배너관리 정보를 먼저 저장하세요.')
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
		rotationBtnId : 'logoImgRotation',
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
function imageRemove2(_this) {
	var idx = _this.id.substr(_this.id.length - 1, 1);
	var obj = backImage.getImgArr()[idx];
	backImage.delImage(_this);
}
</script>