<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 이미지 업로드 -->
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/common/imgUpload.js'></script>

<div class="page_btn_area">
    <div class="col-xs-5">
        <span><spring:message code="D00060" /></span>
    </div>
    <div class="col-xs-7 searchbtn_r">
		<ifvm:inputNew type="button" id="btnSave" btnFunc="btnSaveClick" btnType="save" text="L00074" objCode="appPop_LangSave_OBJ" />
    </div>
</div>

<div class="well form-horizontal" id="appPopForm">
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="appPopTitle" names="appPopTitle" dto="appPopTitle" required="true" label="D00007" labelClass="2" conClass="9" maxLength="200"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="textarea" id="appPopDesc" names="appPopDesc" dto="appPopDesc" label="D00023" labelClass="2" conClass="9" rows="5" maxLength="3000" />
	</div>
	<div class="row qt_border">
		<!-- 이미지 업로드 -->
		<div class="row" id="appPopUploadImgSetting">
			<label class="col-xs-2 control-label"><spring:message code="D00010"/></label>
			<div class="col-sm-9" style="font-size:0; line-height:0;">
				<div class="picture_area" id="appPopUploadImg">
				</div>
			</div> 
		</div>
	</div>
	<div class="row qt_border" id="divAppPopUrl">
		<ifvm:inputNew type="text" id="appPopUrl" names="appPopUrl" dto="appPopUrl" label="D00067" labelClass="2" conClass="9" valiItem="url" maxLength="200" />
	</div>
	<div class="row qt_border" id="divAppPopNoticeUrl">
		<ifvm:inputNew type="select" id="appPopNoticeUrl" names="appPopNoticeUrl" dto="appPopNoticeUrl" label="D00067" labelClass="2" conClass="9"/>
	</div>
</div>

<script id="logoImageTemplatePop" type="text/x-jquery-tmpl">
<div id='logoImgContainerPop${'${'}index}' class="image_box" seq='${'${'}index}' isBind='false' RotateAngle='0' >
	<form id='logoUploadFormPop${'${'}index}' method="POST" enctype="multipart/form-data" style="float: left;">
		<input id="logoUploadPop${'${'}index}" type="file" name="file" data-url="<ifvm:action name="tempUpload"/>" onclick="javascript:appMainBannerImg.clickEditImage(this);" title='수정'>
	</form>
	<div class="btns" id="logoPostPopPicBtns${'${'}index}">
		<a id="logoImgRotation${'${'}index}" href="javascript:;" onclick="javascript:appMainBannerImg.rotationImage(this);" title='이미지 회전'><img src='${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_rotation.png' class="btn_delete" /></a>
		<a id="logoImgDelPop${'${'}index}" href="javascript:;" onclick="javascript:appMainBannerImg.delImage(this);" title='이미지 삭제'><img src='${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_x.png' class="btn_delete" /></a>
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
var appPopLang = '<%= cleanXss(request.getParameter("appPopLang")) %>';
var appPopSubId = "";
var subUpdateFlag = false;
//이미지 업로드
var appPopUploadImg = null;

$(document).ready(function() {
	$.ifvmLnbSetting('appPopList');
	
	//이미지 업로드
	appPopUploadImg = backImageSetting(appPopId, "appPopUploadImg"); 
	
	$('#divAppPopUrl').css('display', '');
	$('#divAppPopNoticeUrl').css('display', 'none');
	
	page_init();
	
	var textObj = [
	           	{text : '<spring:message code="D00025"/>', color: 'blue'}
	           	,{text : '<spring:message code="D00026"/>', color: 'gray'}
	           	,{text : '<spring:message code="D00027"/>', color: 'gray'}
	           	];

	if(updateFlag){
		detailAppPopSub();
	}
	else{
		$("#appPopTitle").focus(function(){
			alert('팝업 정보 등록 후 저장 가능합니다.');
			$("#appPopMasterTitle").focus();
		})
		$("#appPopDesc").focus(function(){
			alert('팝업 정보 등록 후 저장 가능합니다.');
			$("#appPopMasterTitle").focus();
		})
	}
});

function btnSaveClick() {
	validation = $('#appPopForm').ifvValidation();
	if(appPopId != null){
		if(validation.confirm() === false) {
			return;
		} else {
			//이미지 업로드
			var appPopUploadImgArr = appPopUploadImg.getImageList();
			var popupObject;
		
			if($('#appPopType').val() == 'NOTICE') {
				popupObject = $('#appPopNoticeUrl').val();
			} else {
				popupObject = $('#appPopUrl').val();
			}
			
			if(confirm('<spring:message code="M01633"/>') === false){
				return;
			} else {
				$.ifvSyncPostJSON( '<ifvm:action name="insertAppPopSub"/>',
					{
						appPopName : $("#appPopTitle").val(),
						appPopContent : $('#appPopDesc').val(),
						eventDesc : $('#eventDesc').val(),
						updateFlag : subUpdateFlag,
						appPopSubId : appPopSubId,
						appPopId : appPopId,
						appPopLang : appPopLang,
						popupObject : popupObject,
						subImages : appPopUploadImgArr
					},
					function(result) {
						if(result.success == true){
							alert('<spring:message code="M00005"/>');
							location.href = '<ifvm:url name="appPopDetailUrl"/>' + '?rid=' + appPopId;
						} else {
							alert('<spring:message code="M00029"/>');
						}
					}
				);	
			}
				
	}	}
else{
	alert('팝업 정보 등록 후 저장 가능합니다.')
}
	
}

function getNoticeList() {
	
	$("select[name='appPopNoticeUrl'] option").remove();
	$.ifvSyncPostJSON('<ifvm:action name="getNoticeSelectList"/>', {
		appPopLang : appPopLang,
	}, function(result) {
		
		for(var i=0;i<result.length;i++){
			$('#appPopNoticeUrl').append($('<option/>').text(result[i].noticeTitle).val(result[i].noticeId));	 
	 	}
	});
}

function page_init(){
	$('#appPopType').on("change",function(){
		
		if($('#appPopType').val() == 'NOTICE'){
			$('#divAppPopUrl').css('display', 'none');
			$('#divAppPopNoticeUrl').css('display', '');
			getNoticeList();
		}
		else{
			$('#divAppPopUrl').css('display', '');
			$('#divAppPopNoticeUrl').css('display', 'none');
		}
	})
	if($('#appPopType').val() == 'NOTICE'){
		$('#divAppPopUrl').css('display', 'none');
		$('#divAppPopNoticeUrl').css('display', '');
		getNoticeList();
	}
}


function detailAppPopSub(){
	$.ifvSyncPostJSON('<ifvm:action name="getAppPopSubDetail"/>', {
		appPopId : appPopId,
		appPopLang : appPopLang
	}, function(result) {
		
		if(result.appPopSubId != null){
			$('#appPopTitle').val(result.appPopName);
			$('#appPopDesc').val(result.appPopContent);
			
			subUpdateFlag = true;
			appPopSubId = result.appPopSubId;
			if($('#appPopType').val() == 'NOTICE'){
				$("#appPopNoticeUrl").val(result.popupObject).attr("selected", "selected");	
			} else {
				$('#appPopUrl').val(result.popupObject);
			}
			
			//이미지 업로드
			if(result.imageUrl != ''){
				appPopUploadImg.setImgArrList(result.images);
			}
		} else {
			subUpdateFlag = false;
		}
	
		})
}

</script> 