<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
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
    	<ifvm:inputNew type="button" id="btnPreView" className="btn_gray" btnFunc="btnPreViewClick" btnType="search" nuc="true" text="미리보기" objCode="btnPreView_OBJ"/>
		<ifvm:inputNew type="button" id="btnSave" btnFunc="btnSaveClick" className="btn_right" btnType="save" text="L00074" objCode="btnSave_OBJ"/>
    </div>
</div>

<div class="well form-horizontal" id="noticeForm">
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="noticeTitle" names="noticeTitle" dto="noticeTitle" required="true" label="D00007" labelClass="2" conClass="9" maxLength="200" />
	</div>
	<%-- <div class="row qt_border">
		<!-- 이미지 업로드 -->
		<div class="row" id="imageSetting">
			<label class="col-xs-2 control-label"><spring:message code="D00010"/></label>
			<div class="col-sm-9" style="font-size:0; line-height:0;">
				<div class="picture_area" id="backImage">
				</div>
				<div>
            	<span style="margin: 10px 0;display: inline-block; color:#f30909;">이미지 사이즈 제한 (Size:750*370)</span>
            </div>
			</div>
		</div>
	</div> --%>
	<div class="row qt_border">
		<ifvm:inputNew type="textarea" id="noticeDesc" names="noticeDesc" dto="noticeDesc" required="true" label="D00009" labelClass="2" conClass="9" rows="9"/>
	</div>
</div>

<div id="preViewWrap" class="preview-wrap" style="display:none;">
   <div class="row qt_border">
      <ifvm:inputNew type="text" id="pvWidth" nuc="true" label="너비" labelClass="1" conClass="2" />
   </div>
   <div class="row qt_border">
      <ifvm:inputNew type="text" id="pvHeight" nuc="true" label="높이" labelClass="1" conClass="2" />
      <ifvm:inputNew type="button" id="btnPreViewResize" className="btn_gray" btnFunc="btnPreViewResizeClick" btnType="search" nuc="true" text="확인" objCode="noticelangbtnPreViewResize"/>
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

<script>
var validation;
var subUpdateFlag = false;
var noticeLang = '<%= cleanXss(request.getParameter("noticeLang")) %>';
var noticeSubId = null;
var subUpdateFlag = false;
//var backImage = null;

$(document).ready(function() {
	$.ifvmLnbSetting('noticeList');

	//이미지 업로드
	/* backImage = backImageSetting(noticeId, "backImage"); */

	var textObj = [
	           	{text : '<spring:message code="D00025"/>', color: 'blue'}
	           	,{text : '<spring:message code="D00026"/>', color: 'gray'}
	           	,{text : '<spring:message code="D00011"/>', color: 'gray'}
	           	];

	if(updateFlag){
		detailNoticeSub();
	}
	else{
		$("#noticeTitle").focus(function(){
			alert('공지사항 정보를 먼저 저장하세요.');
			$("#noticeMasterTitle").focus();
		})
		$("#noticeDesc").focus(function(){
			alert('공지사항 정보를 먼저 저장하세요.');
			$("#noticeMasterTitle").focus();
		})
	}


});

function detailNoticeSub(){
	$.ifvSyncPostJSON('<ifvm:action name="getNoticeDetail"/>', {
		noticeId : noticeId,
		noticeLang : noticeLang
	}, function(result) {
		if(result.noticeSubId != null){
			$('#noticeTitle').val(result.noticeTitle);
			$('#noticeDesc').val(result.noticeDesc);

			subUpdateFlag = true;
			noticeSubId = result.noticeSubId;
		}
		else{
			subUpdateFlag = false;
		}

		//이미지 업로드
		if(result.imageUrl != ''){
			/* backImage.setImgArrList(result.images); */
// 			numOfImages = result.images.length;
// 			for(var i=0;i<numOfImages;i++){
// 				imageInfo[i] = result.images[i].imgOrgUrl;
// 			}
		}
	})
}

function btnSaveClick() {
	validation = $('#noticeForm').ifvValidation();
	if(noticeId != null){
		if(validation.confirm() === false) return;
		else{
			var url;
			//이미지 업로드
			/* var backImageArr = backImage.getImageList(); */

		  	if( noticeId == null ){ //신규
				url = '<ifvm:action name="insertNotice"/>';
				if(confirm('<spring:message code="M01633"/>') === false) return;
			} else{					//수정
				url = '<ifvm:action name="insertNotice"/>';
				if(confirm('<spring:message code="M01633"/>') === false) return;
			}

			$.ifvSyncPostJSON( url,
				{
			 	noticeLang : noticeLang,
				noticeName : $("#noticeTitle").val(),
				noticeDesc : $("#noticeDesc").val(),
				noticeMasterId : noticeId,
				updateFlag : subUpdateFlag,
				noticeSubId : noticeSubId
				/* subImages  : backImageArr */
				},
				function(result) {

				 if(result.success == true){
					alert('<spring:message code="M00005"/>');
					location.href = '<ifvm:url name="noticeDetailUrl"/>' + '?rid=' + noticeId;
				}
				else{
					alert('<spring:message code="M00029"/>');
				}
				}
			);

	}}
	else{
		alert('공지사항 정보를 먼저 저장하세요.')
	}

}


function btnPreViewClick() {
   var desc = $("#noticeDesc").val().replace(/(\n|\r\n)/g, '</br>');

   $('#PreViewArea').html(desc);
   $('#PreViewArea').prepend('<div class="img-wrap"></div>');
   $('#pvWidth').val($('#PreViewArea').outerWidth());
   $('#pvHeight').val($('#PreViewArea').outerHeight());
   
   var len = $('#imageSetting').find('.image_box').length
   var imgSrc = [];

   for(var i=0; i<len; i++) {
      if($($('#imageSetting').find('.image_box')[i]).attr('isbind') == "true") {
         var src = $($('#imageSetting').find('.image_box')[i]).find('#logoImgPop'+i).attr('src');
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