<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 이미지 업로드 -->
<%@ include file="/WEB-INF/views/layouts/default/sessionScript.jsp" %>
<style>
.icheckbox {padding-left: 20px;}
</style>


<div class="page_btn_area">
    <div class="col-xs-5">
        <span>이벤트 상세 정보<%-- <spring:message code="D00033" /> --%></span>
    </div>
    <div class="col-xs-7 searchbtn_r">
      <ifvm:inputNew type="button" id="btnPreView" className="btn_gray" btnFunc="btnPreViewClick" btnType="search" nuc="true" text="미리보기" objCode="info_LangPreView_OBJ" />
      <ifvm:inputNew type="button" id="btnNew" className="btn_gray" btnFunc="btnSubSaveClick" btnType="save" text="L00074" objCode="info_LangSave_OBJ" />
    </div>
</div>
<%--==================================================메인 베너 --%>
<%--==================================================메인 베너 --%>

<div class="well form-horizontal" id="InfoForm">
   <div class="row qt_border">
      <ifvm:inputNew type="textarea" id="eventName" names="eventName" dto="eventName" required="true" label="D00036" labelClass="2" conClass="6" rows="2"/>
   </div>
   <div class="row qt_border">
      <ifvm:inputNew type="text" id="eventLandingPage" names="eventLandingPage" dto="eventLandingPage" label="D00039" labelClass="2" conClass="6" valiItem="url" placeholder="D10273"/>
   </div>
   <div class="row qt_border">
      <!-- 이미지 업로드 -->
      <div class="row" id="appMainBannerImgSetting">
         <label class="col-xs-2 control-label"><spring:message code="D00040"/></label>
         <div class="col-sm-9" style="font-size:0; line-height:0;">
            <div class="picture_area" id="appMainBannerImg">
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
         <label class="col-xs-2 control-label">이벤트 페이지 이미지</label>
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
      <ifvm:inputNew type="text" id="eventDetailPage" names="eventDetailPage" dto="eventDetailPage" label="D10222" labelClass="2" conClass="6" valiItem="url" placeholder="D10273"/>
   </div>
   <div class="row qt_border">
      <ifvm:inputNew type="textarea" id="eventDesc" names="eventDesc" dto="eventDesc" label="D00009" labelClass="2" conClass="9" rows="15"/>
   </div>
</div>

<style>
.preview-wrap {margin-top: 20px;}
.preview-area {width: 375px;height: 667px;border: 1px solid #ddd;overflow-x: hidden;overflow-y: auto;padding: 20px;word-break: break-word;text-align:center;}
.preview-area img {width:100%;height:auto;margin:30px auto 0;display:block;}
.preview-area img:first-child{margin-top:0px;}
</style>

<div id="preViewWrap" class="preview-wrap" style="display:none;">
   <div class="row qt_border">
      <ifvm:inputNew type="text" id="pvWidth" nuc="true" label="너비" labelClass="1" conClass="2" />
   </div>
   <div class="row qt_border">
      <ifvm:inputNew type="text" id="pvHeight" nuc="true" label="높이" labelClass="1" conClass="2" />
      <ifvm:inputNew type="button" id="btnPreViewResize" className="btn_gray" btnFunc="btnPreViewResizeClick" btnType="search" nuc="true" text="확인" objCode="info_LangPreViewResize_OBJ"/>
   </div>
   <div>
       <span style="margin-bottom: 5px;display: inline-block; color:#f30909;">* 미리보기 사이즈 제한 (Size:1260*1000)</span>
    </div>

   <div id="PreViewArea" class="preview-area"></div>
</div>

<script id="imagePageTemplatePop_backup" type="text/x-jquery-tmpl">
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

<script id="imageTemplatePop_backup" type="text/x-jquery-tmpl">
<div id='imgContainerPop${'${'}index}' class="image_box" seq='${'${'}index}' isBind='false' RotateAngle='0' >
   <form id='uploadFormPop${'${'}index}' method="POST" enctype="multipart/form-data" style="float: left;">
      <input id="uploadPop${'${'}index}" type="file" name="file" data-url="<ifvm:action name="tempUploadS3"/>" onclick="javascript:appMainBannerImg.clickEditImage(this);" title='수정'>
   </form>
   <div class="btns" id="postPopPicBtns${'${'}index}">
      <a id="imgRotation${'${'}index}" href="javascript:;" onclick="javascript:appMainBannerImg.rotationImage(this);" title='이미지 회전'><img src='${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_rotation.png' class="btn_delete" /></a>
      <a id="imgDelPop${'${'}index}" href="javascript:;" onclick="javascript:imageRemove(this);" title='이미지 삭제'><img src='${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_x.png' class="btn_delete" /></a>
   </div>
   <img id='logoImgPop${'${'}index}' width="96px" height="96px" src='${pageContext.request.contextPath}/resources/images/beacon/store/ico_bg_camera.gif' class="handle" />
   <div class="upload_progress_container" id="progress1${'${'}index}"></div>
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

<script id="imageTemplatePop" type="text/x-jquery-tmpl">
<div id='imgContainerPop${'${'}index}' class="image_box" seq='${'${'}index}' isBind='false' RotateAngle='0' >
   <form id='uploadFormPop${'${'}index}' method="POST" enctype="multipart/form-data" style="float: left;">
      <input id="uploadPop${'${'}index}" type="file" name="file" data-url="<ifvm:action name="tempUploadS3"/>" onclick="javascript:appMainBannerImg.clickEditImage(this);" title='수정'>
   </form>
   <div class="btns" id="postPopPicBtns${'${'}index}">
      <a id="imgRotation${'${'}index}" href="javascript:;" onclick="javascript:appMainBannerImg.rotationImage(this);" title='이미지 회전'><img src='${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_rotation.png' class="btn_delete" /></a>
      <a id="imgDelPop${'${'}index}" href="javascript:;" onclick="javascript:imageRemove2(this);" title='이미지 삭제'><img src='${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_x.png' class="btn_delete" /></a>
   </div>
   <img id='logoImgPop${'${'}index}' width="96px" height="96px" src='${pageContext.request.contextPath}/resources/images/beacon/store/ico_bg_camera.gif' class="handle" />
   <div class="upload_progress_container" id="progress1${'${'}index}"></div>
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

var eventLang = '<%= cleanXss(request.getParameter("eventLang")) %>';
var eventSubId = "";
var eventUpdateFlag = false;
//이미지 업로드
var appMainBannerImg = null;
var appEventPageImg =null;

function Info_init(params) {
   var textObj = [
                 {text : '<spring:message code="D00025"/>', color: 'blue'}
                 ,{text : '<spring:message code="D00026"/>', color: 'gray'}
                 ,{text : '<spring:message code="D00027"/>', color: 'gray'}
                 ];

   if(eventId != null){
      InfoDetail(eventId)
   }
}

function btnSubSaveClick() {
   if(eventId !=null){
      validation = $('#InfoForm').ifvValidation();
      if(validation.confirm() === false) {
         return;
      } else {
         //이미지 업로드
         var appMainBannerImgArr = appMainBannerImg.getImageList();
         var MainEventBannerImgArr = appEventPageImg.getImageList();

         for(var i=0; i<MainEventBannerImgArr.length; i++) {
            var el = $('img[src="'+MainEventBannerImgArr[i].filePath+'"');
            var w = el.get(0).naturalWidth;
            var y = el.get(0).naturalHeight;

            if(w>750) {
               alert('width:750 넘어갔습니다.(측정값:'+w+')');
               imageRemove(document.getElementById('imgEventDelPop'+i));
               return false
            }
            if(y>840) {
               alert('height:840 넘어갔습니다.(측정값:'+y+')');
               imageRemove(document.getElementById('imgEventDelPop'+i));
               return false
            }
         }
         for(var i=0; i<appMainBannerImgArr.length; i++) {
             var el = $('img[src="'+appMainBannerImgArr[i].filePath+'"');
             var w = el.get(0).naturalWidth;
             var y = el.get(0).naturalHeight;

             if(w>400) {
                alert('width:400 넘어갔습니다.(측정값:'+w+')');
                imageRemove2(document.getElementById('imgDelPop'+i));
                return false
             }
             if(y>400) {
                 alert('height:400 넘어갔습니다.(측정값:'+y+')');
                 imageRemove2(document.getElementById('imgDelPop'+i));
                 return false
              }
          }

         if(confirm('<spring:message code="M01633"/>') === false) return;
         else{
            $.ifvSyncPostJSON( '<ifvm:action name="insertEventSubInfo"/>',
                  {
                     eventName : $("#eventName").val(),
                     eventLandingPage : $('#eventLandingPage').val(),
                     eventDetailPage : $('#eventDetailPage').val(),
                     eventDesc : $('#eventDesc').val(),
                     updateFlag : eventUpdateFlag,
                     eventSubId : eventSubId,
                     eventId : eventId,
                     eventLang : eventLang,
                     appMainBannerSubImages : appMainBannerImgArr,
                     eventBannerSubImages : MainEventBannerImgArr
                  },
                  function(result) {
                      if(result.success == true){
                        alert('<spring:message code="M00005"/>');
                        location.href = '<ifvm:url name="eventListUrl"/>';
                        }
                     else{
                        alert('<spring:message code="M00029"/>');
                        }
                  }
               );

         }}
   }
   else{
      alert('이벤트 정보 등록 후 저장 가능합니다.')
   }
}

function btnPreViewClick() {
   var desc = $('#eventDesc').val();

   $('#PreViewArea').html(desc);
   $('#PreViewArea').prepend('<div class="img-wrap"></div>');
   $('#pvWidth').val($('#PreViewArea').outerWidth());
   $('#pvHeight').val($('#PreViewArea').outerHeight());

   var len = $('#appEventPageImg').find('.image_box').length
   var imgSrc = [];

   for(var i=0; i<len; i++) {
      if($($('#appEventPageImg').find('.image_box')[i]).attr('isbind') == "true") {
         var src = $($('#appEventPageImg').find('.image_box')[i]).find('#logoImgEventPop'+i).attr('src');
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

function InfoDetail(id){
   $.ifvSyncPostJSON('<ifvm:action name="getEventSubInfoDetail"/>', {
      eventId : id,
      eventLang : eventLang
   }, function(result) {

      if(result.eventSubId != null ){
         eventUpdateFlag = true;
         $('#eventName').val(result.eventName);
         $('#eventLandingPage').val(result.eventLandingPage);
         $('#eventDetailPage').val(result.eventDetailPage);
         eventSubId = result.eventSubId;

         $('#eventDesc').val(result.eventDesc);

         //이미지 업로드
         if(result.imageUrl != ''){
            appMainBannerImg.setImgArrList(result.images);
            appEventPageImg.setImgArrList(result.imagesEvent);
         }
      }
      else{
         eventUpdateFlag = false;
      }
   })
}
////////////////////////////////////////////// 메인 베너
//////////////////////////////////////////////메인 베너
//이미지 업로드
function backImageSetting(_imgParentId, _containerId){
   var _this = this;
   var tmpArr = new Array();
   for(var i=0; i<10; i++){
      tmpArr.push({ index : i });
   }

   backImage = null;
   $("#"+_containerId).html("");

   var template = $('#imageTemplatePop').tmpl(tmpArr);
   $("#"+_containerId).append(template);

   backImage = new ifvMultiUpLoader({
      container : $("#"+_containerId),
      uploadBtn : $('#uploadPop'),
      tempUpLoadFormId : 'uploadFormPop',
      tempUploadBtnId : 'uploadPop',
      imgId : 'logoImgPop',
      btnConId : 'postPopPicBtns',
      imgContainerId : 'imgContainerPop',
      rotationBtnId : 'imgRotation',
      deleteBtnId : 'imgDelPop',
      progressId : 'progress1',
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
      'maxNumber' : 10,
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
//메인배너 이미지 삭제
function imageRemove2(_this) {
   var idx = _this.id.substr(_this.id.length - 1, 1);
   var obj = backImage.getImgArr()[idx];
   backImage.delImage(_this);
}
//이벤트페이지 이미지 삭제
function imageRemove(_this) {
   var idx = _this.id.substr(_this.id.length - 1, 1);
   var obj = backImageEvent.getImgArr()[idx];
   backImageEvent.delImage(_this);
}

$(document).ready(function(){
   //이미지 업로드
   appMainBannerImg = backImageSetting(eventId, "appMainBannerImg");
   appEventPageImg = backEventImageSetting(eventId, "appEventPageImg");
   InfoDetail(eventId);
});

</script>