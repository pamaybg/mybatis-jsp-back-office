<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<div class="form-horizontal underline top_well" id="chnlImgNewDetail">
	<div class="row qt_border">
		<div class="col-xs-12">
	       <ifvm:inputNew type="text" id="descChnlImg" conClass="10" label="이미지 제목" labelClass="2" required="true"/>
		</div>
	</div>
	<br>
 	<div class="row qt_border">
		<label class="col-xs-2 control-label mainImage" id="mainImageLbl"><span class="asterisk">*</span>이미지 등록</label>
			<div class="col-xs-1 mainImage" style="font-size:0; line-height:0;">
				<div class="picture_area" id="mainImage"></div>
			</div>					
	</div> 
 	<br>
	<div class="row qt_border">
	<div class="col-xs-12">
	       <ifvm:inputNew type="text" id="seqNo" conClass="5" label="이미지 순번" labelClass="2" maxLength="8" required="true"/>
	 	 <a>
				<i class="helpBtn" style="vertical-align: middle;">
					<div class="helptxt" style="display:none;"><spring:message code="온라인몰 매장정보 화면에서 표시 되는 순서입니다."/></div>
				</i>
		     </a>
	</div>
	</div>
	<div class="row qt_border">
	<div class="col-xs-12">
	       <ifvm:inputNew type="textarea" id="imgPathId" conClass="10" label="이미지 경로" labelClass="2" rows="3" required="true" disabled="true"/>
	</div>
	</div>
	</div>
<br>
<div class="pop_btn_area">
<button class="btn btn-sm btn_lightGray2" id="btnSave" objCode="addChnlLoyImgDetailSave_OBJ">
		 저장
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnCancel" objCode="addChnlLoyImgDetailCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>


<!-- AWS S3용 이미지 템플릿 -->
<script id="imageUploadTemplateAwsS3" type="text/x-jquery-tmpl">
<div id='${'${'}imgId}ContainerPop${'${'}index}' class="image_box" seq='${'${'}index}' isBind='false' RotateAngle='0' style="width: 70px;" >
   <form id='${'${'}imgId}TempUploadForm${'${'}index}' method="POST" enctype="multipart/form-data" style="float: left;">
	  <input id="${'${'}imgId}Evt${'${'}index}" type="text" name="event" style="display:none;">
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
   
   #mainImagePostPopPicBtns0{
   	display : inline !important;
   }
</style>

<script type="text/javascript">
var chnlRid =  '<%= cleanXss(request.getParameter("rid")) %>';

var imageUrl =null;
var attrib01 = '${pageContext.request.contextPath}/resources/images/beacon/store/ico_bg_camera.gif';
var mainImage=null;

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
	imgObj.customValidFunc = function(files, data) {
		var rObj = {originData : data};
		rObj.valid = true;	   

		return rObj;
	}
	
	imgObj.PathSetfunc = function(files, data) {
		var rObj = {originData : data};
		rObj.valid = true;	   
		return rObj;
	}

	imgObj.imageRemove = function(args) {
		
	   var idx = args.id.substr(args.id.length - 1, 1);
	   var obj = imgObj.getImgArr()[idx];
	   var mainInitImg = '${pageContext.request.contextPath}/resources/images/beacon/store/ico_bg_camera.gif';

	   if(!confirm('<spring:message code="C00079" />')) return;
	   
	   //이미지가 있는 경우
	   if(eval(args.id.replace("DeleteBtn"+idx,"")).getImageList().length!=0){
		   //URL 수동등록이 아닌경우
		   
		   if(!eval(args.id.replace('DeleteBtn'+idx,"")).getImageList()[0].filePath.match("www.youtube.com")){
			   var fileName = imgObj.getImageList()[idx].fileName;//파일명
			   s3Delete(fileName, imgObj);//S3이미지 삭제			   
		   }else{
				

			   updateImg(imgObj);
		   }
	   }
	   
	   imgObj.delImage(args);
	   mainImage = settingImageObject(chnlRid, "mainImage", 1, 1, mainInitImg);
	   $("#imgPathId").val("");
	}
	return imgObj;
};

//S3 이미지 삭제
function s3Delete(fileName, imgObj){
	$.ifvSyncPostJSON('<ifvm:action name="tempUploadS3Delete"/>',{
       	FileName : fileName
    },function(result){
    	//updateImg(imgObj);
    	
	});
};



function getChnlLoyImgDesc() {
		$.ifvSyncPostJSON('<ifvm:action name="getLoyImgDesc"/>', {
			rid : chnlLoyImgListGrid.opt.gridControl.getSelectedRecords()[0].rid
		}, function(result) {
			$("#descChnlImg").val(result.rows[0].comments);
			imageUrl= result.rows[0].imgPath;
			$("#imgPathId").val(imageUrl);
			$("#seqNo").val(result.rows[0].seqNo);
					
		});
	}
	
function saveImgDetail(){
	
	$.ifvSyncPostJSON('<ifvm:action name="saveImgDetail"/>', {
			rid : chnlLoyImgListGrid.opt.gridControl.getSelectedRecords()[0].rid
			, descChnlImg : $("#descChnlImg").val()
			, seqNo 			 : $("#seqNo").val()
			, imgPathId 	 : $("#imgPathId").val()
			, chnlRid 		 : channelDetail_rid
	}, function(result) {
		if(result.message=="dupSeqNo"){
			alert("이미 존재하는 순번입니다.");
		}else{
			alert(result.message);
		    addChnlImgPopupClose();
		 chnlLoyImgListGrid._doAjax();
		}		
	});
}


$(document).ready(function() {
	
	$("#seqNo").onlyNumber();
	
    if(imgUrl !=null){
    	attrib01=imgUrl;
    }
	
    mainImage = settingImageObject(chnlRid, "mainImage", 1, 1, attrib01);
		
	getChnlLoyImgDesc();
	
	$("#btnCancel").click(function() {
		addChnlImgPopupClose();
	});

	$("#btnSave").click(function() {
	   var validation = $("#chnlImgNewDetail").ifvValidation();
	   //유효성 체크
		if(validation.confirm()){
			saveImgDetail();
		}
 	});

	$('.helpBtn').setupHelpMessage();
});
</script>