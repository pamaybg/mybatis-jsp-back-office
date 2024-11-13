<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
#btnPreView {margin-right:3px;}
.preview-wrap {margin-top: 20px;}
.preview-area {width: 375px;height: 667px;border: 1px solid #ddd;overflow-x: hidden;overflow-y: auto;padding: 25px 15px;word-break: break-word;}
.preview-area img {width:100%;height:auto;margin:30px auto 15px;display:block;}
.preview-area img:first-child{margin-top:0px;}
</style>

<!-- 이미지 업로드 -->
<%@ include file="/WEB-INF/views/layouts/default/sessionScript.jsp" %>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/common/imgUpload.js'></script>

<div class="page_btn_area">
    <div class="col-xs-5">
        <span><spring:message code="D00004" /></span>
    </div>
    <div class="col-xs-7 searchbtn_r">
    	<ifvm:inputNew type="button" id="btnPreView" className="btn_gray" btnFunc="btnPreViewClick" btnType="search" nuc="true" text="미리보기" objCode="partnerInfoPreView_OBJ"/>
		<ifvm:inputNew type="button" id="btnSave" btnFunc="btnSaveClick" className="btn_right" btnType="save" text="L00074" objCode="partnerInfoSave_OBJ"/>
    </div>
</div>

<div class="well form-horizontal" id="ptnrForm">
	<div class="row qt_border">
		<ifvm:inputNew type="textarea" id="ptnrName" names="ptnrName" dto="ptnrName" required="true" label="D00007" labelClass="2" conClass="4" maxLength="200" rows="2"/>
		<span style="color:#f30909;">* 줄바꿈 태그 : &lt;br/&gt;<br/>ex) QUINTET &lt;br/&gt;제휴업체</span>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="pageUrl" names="pageUrl" dto="pageUrl" nuc="true" label="LinkUrl" labelClass="2" conClass="9" maxLength="200" valiItem="url" />
	</div>
	<div class="row qt_border">
		<!-- 이미지 업로드 -->
		<div class="row" id="imageSetting">
			<label class="col-xs-2 control-label"><spring:message code="D00010"/></label>
			<div class="col-sm-9" style="font-size:0; line-height:0;">
				<div class="picture_area" id="backImage">
				</div>
				<div>
            	<span style="margin: 10px 0;display: inline-block; color:#f30909;">이미지 사이즈 제한 (Size:400*400)</span>
            </div>
			</div>
		</div>
	</div>
	   <div class="row qt_border">
      <!-- 이미지 업로드 -->
      <div class="row" id="eventBannerSubImagesSetting">
         <label class="col-xs-2 control-label">상세 이미지</label>
         <div class="col-sm-9" style="font-size:0; line-height:0;">
            <div class="picture_area" id="appEventPageImg">
            </div>
            <div>
               <span style="margin: 10px 0;display: inline-block; color:#f30909;">이미지 사이즈 제한 (Size:750*840)</span>
            </div>
         </div>
      </div>
   </div>
	<div class="row qt_border">
		<ifvm:inputNew type="textarea" id="ptnrDesc" names="ptnrDesc" dto="ptnrDesc" required="true" label="D00009" labelClass="2" conClass="9" rows="9"/>
	</div>
</div>

<div id="preViewWrap" class="preview-wrap" style="display:none;">
   <div class="row qt_border">
      <ifvm:inputNew type="text" id="pvWidth" nuc="true" label="너비" labelClass="1" conClass="2" />
   </div>
   <div class="row qt_border">
      <ifvm:inputNew type="text" id="pvHeight" nuc="true" label="높이" labelClass="1" conClass="2" />
      <ifvm:inputNew type="button" id="btnPreViewResize" className="btn_gray" btnFunc="btnPreViewResizeClick" btnType="search" nuc="true" text="확인" objCode="partnerInfoPreViewResize_OBJ"/>
   </div>
   <div>
       <span style="margin-bottom: 5px;display: inline-block; color:#f30909;">* 미리보기 사이즈 제한 (Size:1260*1000)</span>
    </div>

   <div id="PreViewArea" class="preview-area"></div>
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

<script id="imagePageTemplatePop" type="text/x-jquery-tmpl">
<div id='imgEventContainerPop${'${'}index}' class="image_box" seq='${'${'}index}' isBind='false' RotateAngle='0' >
   <form id='uploadEventFormPop${'${'}index}' method="POST" enctype="multipart/form-data" style="float: left;">
      <input id="uploadEventPop${'${'}index}" type="file" name="file" data-url="<ifvm:action name="tempUploadS3"/>" onclick="javascript:appEventPageImg.clickEditImage(this);" title='수정'>
   </form>
   <div class="btns" id="postPopEventPicBtns${'${'}index}">
      <a id="imgEventRotation${'${'}index}" href="javascript:;" onclick="javascript:appEventPageImg.rotationImage(this);" title='이미지 회전'><img src='${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_rotation.png' class="btn_delete" /></a>
      <a id="imgEventDelPop${'${'}index}" href="javascript:;" onclick="javascript:imageRemove(this);" title='이미지 삭제'><img src='${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_x.png' class="btn_delete" /></a>
   </div>
   <img id='logoImgEventPop${'${'}index}' width="96px" height="96px" src='${pageContext.request.contextPath}/resources/images/beacon/store/ico_bg_camera.gif' class="handle" />
   <div class="upload_progress_container" id="progress2${'${'}index}"></div>
</div>
</script>

<script>
var validation;

var subUpdateFlag = false;
var ptnrLang = 'ko'
var ptnrSubId = null;
var subUpdateFlag = false;
var backImage = null;
var appEventPageImg =null;

$(document).ready(function() {
	$.ifvmLnbSetting('partnerList');

	//이미지 업로드
	backImage = backImageSetting(ptnrId, "backImage");
	appEventPageImg = backEventImageSetting(ptnrId, "appEventPageImg");
	
	var textObj = [
	           	{text : '<spring:message code="D00025"/>', color: 'blue'}
	           	,{text : '<spring:message code="D00026"/>', color: 'gray'}
	           	,{text : '<spring:message code="D00011"/>', color: 'gray'}
	           	];

	if(updateFlag){
		detailptnrSub();
	}
	else{
		$("#ptnrName").focus(function(){
			alert('제휴 관리 정보를 먼저 저장하세요.');
			$("#dispSeq").focus();
		})
		$("#pageUrl").focus(function(){
			alert('제휴 관리  정보를 먼저 저장하세요.');
			$("#dispSeq").focus();
		})
			$("#ptnrDesc").focus(function(){
			alert('제휴 관리  정보를 먼저 저장하세요.');
			$("#dispSeq").focus();
		})
	}


});

function detailptnrSub(){
	$.ifvSyncPostJSON('<ifvm:action name="getPartnerDetail"/>', {
		ptnrId : ptnrId,
		ptnrLang:ptnrLang
	}, function(result) {
		if(result.ptnrSubId != null){
			$('#ptnrName').val(result.ptnrTitle);
			$('#ptnrDesc').val(result.ptnrDesc);
			$('#pageUrl').val(result.pageUrl);

			subUpdateFlag = true;
			ptnrSubId = result.ptnrId;
		}
		else{
			subUpdateFlag = false;
		}

		//이미지 업로드
		if(result.imageUrl != ''){
			backImage.setImgArrList(result.images);
			appEventPageImg.setImgArrList(result.imagesDetail);
// 			numOfImages = result.images.length;
// 			for(var i=0;i<numOfImages;i++){
// 				imageInfo[i] = result.images[i].imgOrgUrl;
// 			}
		}
	})
}

function btnSaveClick() {
// 	if($("#ptnrName").val().length>11){
// 		alert('제휴명은 최대 11자리 까지 입력 가능합니다.');
// 		return;
// 	}
	validation = $('#ptnrForm').ifvValidation();
	if(ptnrId != null){
		if(validation.confirm() === false) return;
		else{
			var url;
			//이미지 업로드
			var backImageArr = backImage.getImageList();
			var detailImagesArr = appEventPageImg.getImageList();

		  	if( ptnrId == null ){ //신규
				url = '<ifvm:action name="insertPartner"/>';
				if(confirm('<spring:message code="M01633"/>') === false) return;
			} else{					//수정
				url = '<ifvm:action name="insertPartner"/>';
				if(confirm('<spring:message code="M01633"/>') === false) return;
			}

			$.ifvSyncPostJSON( url,
				{
				ptnrLang:ptnrLang,
				ptnrName : $("#ptnrName").val(),
				ptnrDesc : $("#ptnrDesc").val(),
				pageUrl  : $("#pageUrl").val(),
				ptnrId : ptnrId,
				updateFlag : subUpdateFlag,
				ptnrSubId : ptnrId,
				subImages  : backImageArr,
				detailImages : detailImagesArr
				
				},
				function(result) {

				 if(result.success == true){
					alert('<spring:message code="M00005"/>');
					location.href = '<ifvm:url name="partnerDetailUrl"/>' + '?rid=' + ptnrId;
				}
				else{
					alert('<spring:message code="M00029"/>');
				}
				}
			);

	}}
	else{
		alert('제휴관리 정보를 먼저 저장하세요.')
	}

}
function backEventImageSetting(_imgParentId, _containerId){
	   var _this = this;
	   var tmpArr = new Array();
	   for(var i=0; i<10; i++){
	      tmpArr.push({ index : i });
	   }

	   backImageEvent = null;
	   $("#"+_containerId).html("");

	   var template = $('#imagePageTemplatePop').tmpl(tmpArr);
	   $("#"+_containerId).append(template);

	   backImageEvent = new ifvMultiUpLoader({
	      container : $("#"+_containerId),
	      uploadBtn : $('#uploadEventPop'),
	      tempUpLoadFormId : 'uploadEventFormPop',
	      tempUploadBtnId : 'uploadEventPop',
	      imgId : 'logoImgEventPop',
	      btnConId : 'postPopEventPicBtns',
	      imgContainerId : 'imgEventContainerPop',
	      rotationBtnId : 'imgEventRotation',
	      deleteBtnId : 'imgEventDelPop',
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

	   return backImageEvent;
};

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

function imageRemove(_this) {
	   var idx = _this.id.substr(_this.id.length - 1, 1);
	   var obj = backImageEvent.getImgArr()[idx];
	   backImageEvent.delImage(_this);
}

function btnPreViewClick() {
   var desc = $('#ptnrDesc').val();

   $('#PreViewArea').html(desc);
   $('#PreViewArea').prepend('<div class="img-wrap"></div>');
   $('#pvWidth').val($('#PreViewArea').outerWidth());
   $('#pvHeight').val($('#PreViewArea').outerHeight());
   
   var len = $('#eventBannerSubImagesSetting').find('.image_box').length
   var imgSrc = [];

   for(var i=0; i<len; i++) {
      if($($('#eventBannerSubImagesSetting').find('.image_box')[i]).attr('isbind') == "true") {
         var src = $($('#eventBannerSubImagesSetting').find('.image_box')[i]).find('#logoImgEventPop'+i).attr('src');
         imgSrc = '<img id="test" src="'+src+'">';
         $('#PreViewArea .img-wrap').append(imgSrc);
      }
   }

   $('#pvWidth').val()>813 ? $('.preview-area img').css('width', 'auto') : $('.preview-area img').css('width', '100%');

   $('#preViewWrap').show();
}

function btnPreViewResizeClick() {
   var w = $('#pvWidth').val();
   var h = $('#pvHeight').val();

   if(w>1260) {
      alert('미리보기 가능한 너비값을 넘기셨습니다.');
      return
   } else if(h>1000) {
      alert('미리보기 가능한 높이값을 넘기셨습니다.');
      return
   }

   w>813 ? $('.preview-area img').css('width', 'auto') : $('.preview-area img').css('width', '100%');

   $('#pvWidth').val(w);
   $('#pvHeight').val(h);

   $('#PreViewArea').css({
      width: w,
      height: h
   });
}
</script>