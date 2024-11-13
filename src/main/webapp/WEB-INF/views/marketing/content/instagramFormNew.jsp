<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/lib/MultiUploader.js'></script>
<%@ include file="/WEB-INF/views/layouts/default/sessionScript.jsp" %>


<script>

var openType = '<%= cleanXss(request.getParameter("openType")) == null ? "" : cleanXss(request.getParameter("openType")) %>';

//오늘 날짜 구하기
var today = new Date();

var conid = '<%= cleanXss(request.getParameter("id")) %>';
var chnlCode = '<%= cleanXss(request.getParameter("chnl")) %>';

//iCIGNAL 이미지 세팅
var backImage;
var previewChk = false;
var detail = false;  //수정 페이지 체크 ture일 시 수정, false일 시 신규 생성 페이지
var oldFileDelCheck = false;
var numOfImages = "";
var imageInfo = new Array();
var imageInfoId = new Array();

//instagram 반응정보 수집 정보
var postId = "";

//동영상 업로드
var video;
var saveCheck = false;         //실제 파일을 지우기 위한 체크
var filecheck = false;         //실제 파일을 올렸는지의 체크 여부
//파일 타입 검사
var FiletypeString = [];           
var sizeStore = []; 
var FileData;
var oriFileName = "";
var fileSize = "";
var filePath = "";
var fileName = "";

function initinstagramFormNew() {
	$.ifvmLnbSetting('contentListNew');
	
	//instagram 페이지 정보 조회
	getInstagramInfo();
	
	//instagram 첨부파일 종류 조회
	getAttachmentType();
	
	//상세여부 확인 및 데이터 조회	
	idCheck();
	
	emialvalidation = $("#selectForm").ifvValidation();
}

//instagram 페이지 정보 조회
function getInstagramInfo() {
	//콘텐츠 페이스북 유형 값 코드
	$.ifvSyncPostJSON('<ifvm:action name="getInstagramInfo"/>',{
		
	},function(result) {
		var temp = $("#snsInfotemp").tmpl(result.rows);
		$("#snsInfo").append(temp);
	});
}

//iCIGNAL 이미지 세팅
function backImageSetting(){
	var _this = this;
	var tmpArr = new Array();
	for(var i=0; i<15; i++){
		tmpArr.push({ index : i });
	}
	
	backImage = null;
	$("#backImage").html("");
	
	var template = $('#logoImageTemplatePop').tmpl(tmpArr);
	$("#backImage").append(template);
	
	backImage = new ifvMultiUpLoader({
		container : $("#backImage"),
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
		'category' : "<%=com.icignal.common.util.CommonUtil.IMAGE_UPLOAD_TYPE.Site%>",
		'maxNumber' : 15,
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
};

//상세페이지 체크
function idCheck(){
	if(conid != "null"){
		//수정일 경우
		$.ifvSyncPostJSON('<ifvm:action name="getInstagramDtlList"/>', {
		   id : conid
		}, function(result) {
			$("#contentsName").val(result.contentsName);
			$("#snsInfo").val(result.snsInfo);
			$('#htmlContentsArea').val(result.contents);
			$('#postId').val(result.postId);
			$("#attachmentType").val(result.attType);
			
			//다중 이미지 설정
			if(result.imageUrl != ''){
				backImage.setImgArrList(result.images);
				numOfImages = result.images.length;
				for(var i=0;i<numOfImages;i++){
					imageInfo[i] = result.images[i].imgOrgUrl;
				}
				//local에서 다중 이미지 업로드 테스트를 하기 위한 것
				/* 
				imageInfo = [
				    "http://devmkt2.icignal.com/resources/UploadImages/USERCONTS/2017/5/19/35761563-0402-4153-96fe-3dbeb48b3ae2.jpg"
					, "http://devmkt2.icignal.com/resources/UploadImages/USERCONTS/2017/5/19/faf4edac-7a04-49ba-92cd-146a73d05e71.jpg"
					, "http://devmkt2.icignal.com/resources/UploadImages/USERCONTS/2017/5/19/ba9d065c-e174-4cc7-8992-314ae995cf39.png"
					, "http://devmkt2.icignal.com/resources/UploadImages/USERCONTS/2017/5/19/79a7b296-78be-4a33-9d41-831708cab628.jpg"
				];
				 */
				}
			
			//동영상 설정
			if(result.fileName != null){
				detailFIleSetting(result.oriFileName)
				fileSize = result.fileSize;
				oriFileName = result.oriFileName;
				fileName = result.fileName;
				filePath = result.filePath;
				saveCheck = true;
				$("#fileRemoveBtn").show();
			}else{
			    $("#fileNameText").text("");
			    $("#fileNameText").hide();
			    $("#fileRemoveBtn").hide();
			    $("#fileAddBtn").show();
			}
		});
		detail = true; 
	}else{
		//신규일 경우
		var now = new Date();
		$("#attachmentType").val("NONE");
		//동영상 첨부파일 초기화
		$("#fileNameText").text("");
		$("#fileNameText").hide();
		$("#fileRemoveBtn").hide();
	}
}

//저장 버튼클릭 시 동작
function actionContent() {
	isValid = emialvalidation.confirm();
	var url = '';
	var obj = {};
	var backImageArr = backImage.getImageList();
	obj.subImages = backImageArr;
	
	if(isValid){
		//상세 페이지일 시 수정 작업 동작
		if((typeof(camId) != "undefined" && (camId == null || camId == 'null'))){
			alert('<spring:message code="M00710"/>');
		}else if((typeof(quickFlag) != "undefined" && quickFlag != null && $("#benefitSelect option:selected").attr('value') == 'direct' && $("#benefitDirectInput").val().length == 0)){
			alert('<spring:message code="M00711"/>');
		}else{
		//상세 페이지일 시 수정 작업 동작
		if(detail){
			//페이스북 콘텐츠 수정
			$.ifvSyncPostJSON('<ifvm:action name="editResponseContent"/>', {
				contentsName       : $("#contentsName").val()
				, snsInfo 		   : $("#snsInfo").val()
				, contents         : $('#htmlContentsArea').val()
				, id               : conid
				, subImages 	   : backImageArr
				, contentsType	   : "INSTAGRAM"
				, attType 		   : $("#attachmentType").val()
			}, function(result) {
				if(previewChk == false){
					alert('<spring:message code="M00429"/>');
				}
				if(typeof(camId) != "undefined" && typeof(quickFlag) != "undefined" && quickFlag != null){
					quickSaveMessage(conid);
				}
			});		 
		}
		//상세 페이지가 아닐 시 insert 동작
		else{
			var camFlag = 0;
			var campaignWorkflowFlag = $("#campaignWorkflowFlag").val();
	        //퀵캠페인 또는 캠페인 워크플로우인지 확인한다.
	        if((typeof(quickFlag) != "undefined" && quickFlag != null) || $.fn.ifvmIsNotEmpty(campaignWorkflowFlag)){
	            camFlag = '1';
	        }
			
			$.ifvSyncPostJSON('<ifvm:action name="setContent"/>', {
				contentsName       : $("#contentsName").val()
				, contentsType     : chnlCode
				, title            : $("#title").val()
				, snsInfo 		   : $("#snsInfo").val()
				, contents         : $('#htmlContentsArea').val()
				, camFlag		   : camFlag
				, subImages 	   : backImageArr
				, contentsType	   : "INSTAGRAM"
				, attType 		   : $("#attachmentType").val()
			}, function(result) {
				if(previewChk == false){
					alert('<spring:message code="M00430"/>');
				}
				conid = result.message;
				detail = true;
				
				if(typeof(camId) != "undefined" && quickFlag != null){
					quickSaveMessage(conid);
				}
				
				if(typeof(directFlag) != "undefined" && directFlag != null){
					directSaveMessage(conid);
				}
			});
		}
		
		}
		if(typeof(directFlag) != "undefined" && directFlag != null){
			directSaveMessage(conid);
		}	
	}
	previewChk = false;
	backImageSetting();
}

//이미지 삭제
function imageRemove(_this) {
	var idx = _this.id.substr(_this.id.length - 1, 1);
	var obj = backImage.getImgArr()[idx];
	backImage.delImage(_this);
} 

//페이스북 해당 포스팅 반응정보 가져오기
function getinstagramResponse() {
	$('#instagramResponseBtn').on('click',function(){
		if($('#postId').val() != null && $('#postId').val() != ""){
			//postId값이 있으면 반응정보를 가져온다.
			postId = $('#postId').val();
			//1. 종류별 좋아요
			$.ifvSyncPostJSON('<ifvm:action name="setReactionsRspnsInfo"/>', {
				postId : $("#postId").val(),
				accessToken : acesToken,
				camId : conid
			}, function(result) {
			});
			//2. 공유 정보
			$.ifvSyncPostJSON('<ifvm:action name="setSharedpostsRspnsInfo"/>', {
				postId : $("#postId").val(),
				accessToken : acesToken,
				camId : conid
			}, function(result){
			});
			//3. 댓글 정보
			$.ifvSyncPostJSON('<ifvm:action name="setCommentsRspnsInfo"/>', {
				postId : $("#postId").val(),
				accessToken : acesToken,
				camId : conid
			}, function(result) {
			});

		}else{
			alert('<spring:message code="M02173"/>');
		}
	});
}

//동영상 업로드
function fileCHeck(){
	$.ifvProgressControl(true);
	
	getFileUpType();
	
	var size = FiletypeString.length;
	var typeCheck;
	var count =0;
	var fileType;
	
	//파일 갯수 한 개로 제한하는 프로세스 만들기
	for(var i=0;i<size;i++){
		var SubSize = $("#fileAdd")[0].files[0].name.split('.');
		
		if($("#fileAdd")[0].files[0].name.split('.')[SubSize.length-1] == FiletypeString[i].toLowerCase()){
			fileType = FiletypeString[i].toLowerCase()
			count++;
		}
	}
	
	if(count > 0) typeCheck = true;
	else typeCheck = false;
	
	var size = sizeStore.length
	var sizeCheck = true;
	
	//채널에 설정된 각 이미지 버전에 맞는 용량 비교(512MB 이하)
	for(var i=0;i<size;i++){
		if($("#fileAdd")[0].files[0].size > 536850000 ){
			sizeCheck = false;
		}
	}
	
	if(typeCheck){
		if(sizeCheck){
			var fileData = $.fn.ifvmFileUpload("fileAdd");
			
			if ($.fn.ifvmIsNotEmpty(fileData)) {
				changeFile();
			 	$("#fileNameText").text(fileData.oriFileName);
		     	FileData=fileData;
			 	$("#fileAdd").removeAttr("value");
			}
			
			filecheck = true;
			$("#fileAddBtn").hide();
		    $("#fileRemoveBtn").show();	
		    $("#fileNameText").show();
		}else{
			alert('<spring:message code="M00384"/>');
		}
	}else{
		alert('<spring:message code="M00458"/>');
		fileRemove();
		filecheck = false;
		$("#fileAdd").removeAttr("value");
	}	
	
	if($("#fileAdd")[0].files[0].name.split('.')[0].length > 50){
		fileRemove();
		filecheck = false;
		$("#fileAdd").removeAttr("value");
		alert('<spring:message code="M00457"/>') 
	}
	
	$.ifvProgressControl(false);
}

//트리거 세팅
function searchFile(){
	$("#fileAdd").trigger("click");
}

//파일첨부 추가하기
function fileAdd(_this){
	if(_this.value){
		fileCHeck()
	}
}

//파일첨부 삭제
function fileRemove(){
	$("#fileNameText").text("");
	$("#fileNameText").hide();
	$("#fileAddBtn").show();
	$("#fileRemoveBtn").hide();
	$("#fileAdd").val("");
	
	filePath = "";
	filename = "";
	fileSize = "";
	FileData = "";
	oriFileName = "";
	
	oldFileDelCheck = true;
	filecheck = false;
	saveCheck = false;
}

//현재 세팅되어 있는 파일 형식 가져오기 
function getFileUpType(){
		FiletypeString = [
		                  "3g2", "3gp", "3gpp", "asf", "avi", "dat", "divx", "dv", "f4v", 
		                  "flv", "gif", "m2ts", "m4v", "mkv", "mod", "mov", "mp4", "mpe", 
		                  "mpeg", "mpeg4", "mpg", "mts", "nsv", "ogm", "ogv", "qt", "tod", 
		                  "ts", "vob", "wmv"
		                 ];
		             //"1,073,700,000" (1GB)
		             //"536,850,000" (512MB)
		sizeStore = [
		             "536850000"
		             ];
}

//파일 클릭 후 파일  이름을 넣어주기
function changeFile(){
	var value = $("#fileAdd").val();
	var array = value.split("\\");
	var name = array[array.length-1];
	
	$("#fileNameText").text(name);
	$("#fileNameText").show();
}

//동영상 첨부파일 설정
function detailFIleSetting(fileName){
	$("#fileNameText").show();
	$("#fileNameText").text(fileName);
	$("#fileAddBtn").hide();
}

function deleteFile(){
	//기존 파일 삭제
    $.ifvSyncPostJSON('<ifvm:action name="deleteVideoFile"/>',{
    	conid : conid
    },function( result ){
    });
}

//동영상 파일을 실제 서버에 업로드 
function fileServerUpload(){
	//기존 파일 삭제
	deleteFile();
    
    //초기화
    oldFileDelCheck = false;
    
	if(filecheck){
		//동영상 첨부파일을 변경하고 저장할 때
		var uploadObject = new Object;
		uploadObject.fileSize = FileData.fileSize;
		uploadObject.parentId = conid;
		uploadObject.filePath = FileData.filePath;	
		uploadObject.fileName = FileData.fileName.split('.')[0];
		uploadObject.oriFileName = FileData.oriFileName.split('.')[0];
		uploadObject.fileType = FileData.fileType;
		
		$.ifvSyncPostJSON('<ifvm:action name="addVideoFile"/>',
		 uploadObject,
	     function( result ){
		     $('#closeBtn').trigger('click');			 
			 saveCheck = true;
		});	
	}else{
		//캠페인 기획 시, 콘텐츠 템플릿 불러오고 처음 저장할 때
		var uploadObject = new Object;
		uploadObject.fileSize = fileSize;
		uploadObject.parentId = conid;
		uploadObject.filePath = filePath;	
		uploadObject.fileName = fileName.split('.')[0];
		uploadObject.oriFileName = oriFileName.split('.')[0];
		uploadObject.fileType = oriFileName.split('.')[1];
		
		$.ifvSyncPostJSON('<ifvm:action name="addVideoFile"/>',
		 uploadObject,
	     function( result ){
		     $('#closeBtn').trigger('click');			 
			 saveCheck = true;
		});
	}
}

//첨부파일 종류 설정
/* function setAttachmentType(){
	
	var attType = "";
	attType = $("#attachmentType").val();
		
	if(attType == "image"){
		$("#imageSetting *").children().attr('disabled',false);
		$("#videoSetting *").children().attr('disabled',true);
	}else if(attType == "video"){
		$("#videoSetting *").children().attr('disabled',false);
		$("#imageSetting *").children().attr('disabled',true);
	}
}*/

//instagram 첨부파일 유형 조회
function getAttachmentType() {
	$.ifvSyncPostJSON('<ifvm:action name="getAttachmentType"/>',{
	},function(result) {
		var temp = $("#attachmentTypeTemp").tmpl(result.rows);
		$("#attachmentType").append(temp);
	});
}

$(document).ready(function() {
	//iCIGNAL 이미지 세팅
	backImageSetting();

	//초기 설정
	initinstagramFormNew();

	//포스팅 전, 페이스북 페이지 정보 받아오기
	//getInstagramInfoById();

	//저장 버튼 클릭
	$("#saveBtn").on('click', function() {
		//인스타그램 이미지 갯수 제한
		var imageLength = backImage.getImageList().length;
		if($("#attachmentType").val() == "NONE"){
			alert('<spring:message code="M02227"/>');
		}else if(imageLength > 1){
			alert('<spring:message code="M02230"/>');
		}else{
			$.ifvProgressControl(true);
			actionContent();
			if((FileData != "" && FileData != null && FileData != "undefined") || (fileSize != "" && fileSize != null)){
				fileServerUpload();
			}else{
				deleteFile();
			}
			idCheck();
			$.ifvProgressControl(false);
		}
	});

	//포스팅 버튼 클릭
	/* $("#instagramPostingBtn").on('click', function() {
		instagramPosting();
	}); */

	//인스타그램 반응정보
	$("#instagramResponseBtn").on('click', function(){
		//getinstagramResponse();
	});
	
	//이하 동영상 업로드
	$("#hideFile").change(function(){
		fileCHeck();
	});	
	
	$("#fileNameText").change(function(){
		searchFile();
	});
	
	//파일 추가 클릭시
	$('#fileAddBtn').on('click', function() {
	    searchFile();
	});
	
	//파일 첨부 추가
	$("#fileAdd").on("change", function(){
		fileAdd(this);
	});
	
	//파일 첨부 삭제
	$("#fileRemoveBtn").on("click", function(){
		fileRemove();
	});
	
	//첨부파일 종류 change 설정
	/* setAttachmentType();
	$("#attachmentType").change(function(){
		setAttachmentType();
	}); */
})
</script>

<script id="snsInfotemp" type="text/x-jquery-tmpl">
<option value="${'${'}id}">${'${'}snsPageDesc}</option>
</script>

<script id="attachmentTypeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="logoImageTemplatePop" type="text/x-jquery-tmpl">
<div id='logoImgContainerPop${'${'}index}' class="image_box" seq='${'${'}index}' isBind='false' RotateAngle='0' >
	<form id='logoUploadFormPop${'${'}index}' method="POST" enctype="multipart/form-data" style="float: left;">
		<input id="logoUploadPop${'${'}index}" type="file" name="file" data-url="<ifvm:action name="tempUpload"/>" onclick="javascript:backImage.clickEditImage(this);" title='수정'>
	</form>
	<div class="btns" id="logoPostPopPicBtns${'${'}index}">
		<a id="logoImgRotation${'${'}index}" href="javascript:;" onclick="javascript:backImage.rotationImage(this);" title='이미지 회전'><img src='${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_rotation.png' class="btn_delete" /></a>
		<a id="logoImgDelPop${'${'}index}" href="javascript:;" onclick="javascript:backImage.delImage(this);" title='이미지 삭제'><img src='${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_x.png' class="btn_delete" /></a>
	</div>
	<img id='logoImgPop${'${'}index}' width="96px" height="96px" src='${pageContext.request.contextPath}/resources/images/beacon/store/ico_bg_camera.gif' class="handle" />
	<div class="upload_progress_container" id="progress2${'${'}index}"></div>
</div>
</script>

<style type="text/css">
#hideFile{display:none;}
.hideFile{display:none;}
</style>

<div class="page-title">
	<h1>
		<spring:message code="M00372"/> &gt;  <spring:message code="M00274"/>
	</h1>
</div>

<div id="selectForm">
	<div>
		<div class="page_btn_area">
			<div class="col-xs-8">
				<span><spring:message code="M02220"/></span>
			</div>
			<div class="col-xs-4 searchbtn_r">
				<%-- <button class="btn btn-sm" id='instagramPostingBtn'>
					<i class="glyphicon glyphicon-check"></i>
					<spring:message code="M02145"/>
				</button>  --%>
				<button class="btn btn-sm" id='saveBtn'>
					<i class="glyphicon glyphicon-check"></i>
					<spring:message code="M00280"/>
				</button> 
			</div>
		</div>
		<div class="well form-horizontal well_sum">
			<div class="row qt_border">
				<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="M00376"/></label>
				<div class="col-xs-6 control_content">
					<ifvm:input type="text" required="true" id="contentsName" maxLength="30"/>				
				</div>
				<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M02221"/></label>
				<div class="col-xs-3 control_content">
					<ifvm:input type="select" required="true" id="snsInfo"/>				
				</div>
			</div>
		</div>
	</div>
	<div>
		<div class="page_btn_area">
			<div class="col-xs-7">
				<span><spring:message code="M02222"/></span>
			</div>
			<div class="col-xs-5 searchbtn_r">
				<%-- <button class="btn btn-sm btn_gray" id="instagramResponseBtn">         
					<spring:message code="M02150"/>
				</button> --%> 
			</div>
		</div>
		<div class="well form-horizontal">
			<div class="row">
				<div class="col-xs-12">
					<div class="row qt_border">
						<!-- editor -->
						<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="M01739"/></label>
						<div class="col-xs-11 control_content">
							<textarea id="htmlContentsArea" rows="8" required="required"></textarea>
							<ifvm:input type="hidden" id="postId"/>				
						</div>
						<!-- editor end -->
					</div>
					<div class="row qt_border">
						<label class="col-xs-1 control-label"><spring:message code="M02201"/></label>
						<div class="col-xs-2 control_content">
							<%-- <ifvm:input type="select" id="attachmentType" text="M02202|M02203" values="image|video"/> --%>
							<ifvm:input type="select" id="attachmentType"/>
						</div>
					</div>	
					<!-- iCIGNAL 이미지 세팅 -->
					<div class="file_box row" id="imageSetting">
						<label class="col-xs-1 control-label"><spring:message code="M02146"/></label>
						<div class="col-sm-10" style="font-size:0; line-height:0;">
							<div class="picture_area" id="backImage">
							</div>
						</div> 
					</div>
					<br>
					<!-- 동영상 업로드 -->
					<div class="file_box row" id="videoSetting">
						<label class="col-xs-1 control-label"><spring:message code="M02200"/></label>
						<ifvm:input type="file" id="hideFile" /> <!-- 파일 경로  -->
						<p class="file_link"><span class="file_btn" id="fileNameText"></span></p>
						<div class="file_btn" id="fileAddBtn">
							<img alt="" src="<ifvm:image name='btn_plus'/>">
							<spring:message code="M00421"/>
						</div>
                        <div class="hideFile">
                            <ifvm:input type="file" id="fileAdd" names="fileAdd"/>          
                        </div>
						<div class="file_btn delete" id="fileRemoveBtn">
							<img alt="" src="<ifvm:image name='btn_delete'/>">
							<spring:message code="M00275"/>	
						</div>
					</div>
				</div>
	 		</div>
		</div>
	</div>
</div>
