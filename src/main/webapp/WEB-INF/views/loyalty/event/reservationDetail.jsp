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
		예약서비스 기획/실행
		<span>&gt; 신규</span>
	</h1> 
</div>

<div class="page_btn_area">
	<div class="col-xs-5">
		<sapn>일반 정보</sapn>
	</div>
	<div class="col-xs-7 searchbtn_r">
		<ifvm:inputNew type="button" id="btnMasterSave" btnFunc="btnMasterSaveClick" btnType="save" text="L00074" />
		<ifvm:inputNew type="button" id="btnList" btnFunc="btnListClick" text="D00024" />
	</div>
</div>

<div class="form-horizontal underline top_well" id="bannerMasterForm">
	<div class="row qt_border">
		<%-- 예약명 --%>
		<label class="col-xs-1 control-label"><span class="asterisk">*</span>예약명</label>
		<div class="col-xs-9 control_content">
			<ifvm:input type="text" id="placeNm" names="placeNm" required="true" maxLength="100"/>
		</div>
	</div>
	<div class="row qt_border">
		<%-- 상세 --%>
		<label class="col-xs-1 control-label"><span class="asterisk" id="reservAstrick">*</span>상세</label>
		<div class="col-xs-9 control_content">
			<ifvm:input type="textarea" id="placeDesc" names="placeDesc" required="true" maxLength="1000" rows="3"/>
		</div>
	</div>
	<div class="row qt_border">
		<%-- 주소 --%>
		<label class="col-xs-1 control-label"><span class="asterisk">*</span>주소</label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="text" id="addr" required="true"/>
		</div>
		<div class="col-xs-1 control_content">
			<ifvm:inputNew type="button" id="callKakoApi" nuc="true" text="위경도찾기" conClass="1" />		
		</div>
			<%-- 위도 --%>
			<ifvm:inputNew type="text" id="latitude" dto="latitude" label="위도" nuc="true" labelClass="1" conClass="1" disabled="true"/>		
			<%-- 경도 --%>
			<ifvm:inputNew type="text" id="longitude" dto="longitude" label="경도" nuc="true" labelClass="1" conClass="1" disabled="true"/>	
	</div>
	<div class="row qt_border">
		<%-- 전화번호 --%>
		<label class="col-xs-1 control-label"><span class="asterisk">*</span>전화번호</label>
		<div class="col-xs-2 control_content">
			<ifvm:input type="text" id="placeSeq" names="placeSeq" required="true" rows="5"/>
		</div> 
		<%-- 영업시간 --%>        
		<label class="col-xs-1 control-label"><span class="asterisk">*</span>영업시간</label>                                                                                               
			<ifvm:input type="test" id="openTime" names="openTime" required="true"/>
		</div>
	<div class="row qt_border">
		<%-- 디스플레이 순서 --%>
		<label class="col-xs-1 control-label"><span class="asterisk">*</span>디스플레이순서</label>
		<div class="col-xs-1 control_content">
			<ifvm:input type="number" id="dpSeq" dto="dpSeq" names="dpSeq" required="true"/>
		</div>
	</div>		
	<div class="page_btn_area">
		<div class="col-xs-12">
			<span>이미지</span>
		</div>
	</div>
	<div class="well form-horizontal underline" id="monthlyArea">                                                   
		<div class="row qt_border" style="padding-top: 10px;">                                                      
			<div class="row qt_border">                                                                             
				<label class="col-xs-1 control-label detailImageOne">썸네일 이미지 1</label>                                  
				<div class="col-xs-1 detailImageOne" style="font-size:0; line-height:0;">                           
					<div class="picture_area" id="detailImageOne"></div>                                            
					<label class="col-xs-9 red" style="text-align:center; font-size: 11px;">(528*396)</label>       
				</div>                                                                                              
				<label class="col-xs-1 control-label detailImageTwo">썸네일 이미지 2</label>                                  
				<div class="col-xs-1 detailImageTwo" style="font-size:0; line-height:0;">                           
					<div class="picture_area" id="detailImageTwo"></div>                                            
					<label class="col-xs-9 red" style="text-align:center; font-size: 11px;">(528*396)</label>       
				</div>                                                                                              
				<label class="col-xs-1 control-label detailImageThree">썸네일 이미지 3</label>                                    
				<div class="col-xs-1 detailImageThree" style="font-size:0; line-height:0;">                                
					<div class="picture_area" id="detailImageThree"></div>                                                 
					<label class="col-xs-9 red" style="text-align:center; font-size: 11px;">(528*396)</label>
				</div>                                                                                                                                                                                                                                                                                        
			</div>        
		</div>                                                                                          
	</div>
	<div class="well form-horizontal underline" id="monthlyArea">                                                   
		<div class="row qt_border" style="padding-top: 10px;">                                                      
			<div class="row qt_border">                                                                             
				<label class="col-xs-1 control-label detailImageFour">더보기 이미지1</label>                                    
				<div class="col-xs-1 detailImageFour" style="font-size:0; line-height:0;">                                
					<div class="picture_area" id="detailImageFour"></div>                                                 
					<label class="col-xs-9 red" style="text-align:center; font-size: 11px;">(1000*748)</label>
				</div>                                                                                              
				<label class="col-xs-1 control-label detailImageFive">더보기 이미지2</label>                                    
				<div class="col-xs-1 detailImageFive" style="font-size:0; line-height:0;">                                
					<div class="picture_area" id="detailImageFive"></div>                                                 
					<label class="col-xs-9 red" style="text-align:center; font-size: 11px;">(1000*748)</label>
				</div>
				<label class="col-xs-1 control-label detailImageSix">더보기 이미지3</label>                                    
				<div class="col-xs-1 detailImageSix" style="font-size:0; line-height:0;">                                
					<div class="picture_area" id="detailImageSix"></div>                                                 
					<label class="col-xs-9 red" style="text-align:center; font-size: 11px;">(1000*748)</label>
				</div>                                                                                                                                                                                                                                                                                         
			</div>        
		</div>                                                                                          
	</div>		
</div>
<div id="reservImageViewPop" class="popup_container"></div><!-- 팝업 -->

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
var reservRid = '<%= cleanXss(request.getParameter("rid")) %>';
if(reservRid == "null") reservRid = null;
var thumImage = null;
var mainImage = null;
var detailImageOne = null;
var detailImageTwo = null;
var detailImageThree = null;
var detailImageFour= null;
var detailImageFive = null;
var detailImageSix = null;
var statusCd = null;

$(document).ready(function() {
	var attrib01 = '${pageContext.request.contextPath}/resources/images/beacon/store/ico_bg_camera.gif';
	
	//이미지 설정
	thumImage = settingImageObject(reservRid, "thumImage", 1, 1, attrib01);
	mainImage = settingImageObject(reservRid, "mainImage", 1, 1, attrib01);
	detailImageOne = settingImageObject(reservRid, "detailImageOne", 1, 1, attrib01);
	detailImageTwo = settingImageObject(reservRid, "detailImageTwo", 1, 1, attrib01);
	detailImageThree = settingImageObject(reservRid, "detailImageThree", 1, 1, attrib01);
	detailImageFour = settingImageObject(reservRid, "detailImageFour", 1, 1, attrib01);
	detailImageFive = settingImageObject(reservRid, "detailImageFive", 1, 1, attrib01);
	detailImageSix = settingImageObject(reservRid, "detailImageSix", 1, 1, attrib01);
	
	//위경도찾기 버튼
	$('#callKakoApi').click(function() {
		callKakoApi();
	});
	
	if(reservRid != null){
		reservDetail(reservRid);		
	}
	
	$("#dpseq").keyup(function(event){

	    var inputVal = $("#dpseq").val();

	    $("#dpseq").val(inputVal.replace(/[^0-9]/gi,''));

	});
});

//위,경도 찾기
function callKakoApi(){
	var addr = $("#addr").val();
	
	if($.fn.ifvmIsNotEmpty(addr)){
		$.ifvSyncPostJSON('<ifvm:action name="callKakaoApi"/>',{
			adrDtl : addr
		}, function(result){
			if($.fn.ifvmIsNotEmpty(result)) {
				if(result.success){
					$('#latitude').val(result.latitude);
					$('#longitude').val(result.longitude);
				}
			}
		}, function(result) {
		alert('KAKO MAP API [잘못된주소]');
	});
	}else{
		alert('주소가 입력되지 않았습니다.');
	}
}

//이미지 팝업
function imageViewPopup(args) {
	var id = args.id.replace("LogoImg0", "");
	
	var list = eval(id).getImageList();
	
	if(list.length > 0) {
		var obj = list[0];
		var path = obj.filePath;
		
		$("#reservImageViewPop").ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl: '<ifvm:url name="reservImageViewPop"/>?path=' + path,
			contentType : "ajax",
			title: '',
			width: '900px',
			close : 'reservImageViewPopupClose'
		});
	}
}

function reservImageViewPopupClose() {
	reservImageViewPop._destroy();
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
	var idx = _this.id.substr(_this.id.length -1, 1);
	var obj = backImage.getImgArr()[idx];
	backImage.delImage(_this);
}

/************************************************************************
 **                         저장/수정                                          				   **
 ************************************************************************/
 function btnMasterSaveClick(){
	var url;
	validation = $("#bannerMasterForm").ifvValidation();
	if(validation.confirm() === false) return;
	
	else{
		
		//업로드 파일 셋팅
		var uploadImgThum = thumImage.getImageList();
		var uploadImgMain = mainImage.getImageList();
		var uploadImgOne = detailImageOne.getImageList();
		var uploadImgTwo = detailImageTwo.getImageList();
		var uploadImgThree = detailImageThree.getImageList();
		var uploadImgFour = detailImageFour.getImageList();
		var uploadImgFive = detailImageFive.getImageList();
		var uploadImgSix = detailImageSix.getImageList();
		var uploadImgNm = null;
		
		var upImgThum, upImgMain, upImgOne, upImgTwo, upImgThree, upImgFour, upImgFive, upImgSix
		
		if(uploadImgThum.length != 0){
			upImgThum = uploadImgThum[0].filePath;
		}
		
		if(uploadImgMain.length != 0){
			upImgThum = uploadIImgMain[0].filePath;
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
		
		if(uploadImgFour.length != 0){
			upImgFour = uploadImgFour[0].filePath;
		}
		
		if(uploadImgFive.length != 0){
			upImgFive = uploadImgFive[0].filePath;
		}
		
		if(uploadImgSix.length != 0){
			upImgSix = uploadImgSix[0].filePath;
		}
		
		//신규 수정 여부
		if(reservRid == null){
			url = '<ifvm:action name="saveReservation"/>';
			if(confirm('<spring:message code="M01633"/>') === false) return;
		} else{
			url = '<ifvm:action name="updateReservation"/>';
			if(confirm('<spring:message code="M01633"/>') === false) return;
		}
		
		$.ifvSyncPostJSON(url,{
			rid : reservRid,
			placeNm : $("#placeNm").val(),
			placeDesc : $('#placeDesc').val(),
			telNo : $('#placeSeq').val(),
			addr : $("#addr").val(),
			latitude : $("#latitude").val(),
			longitude : $("#longitude").val(),
			openTime : $('#openTime').val(),
			closeTime : $("#closeTime").val(),
			thumImg : upImgThum,
			mainImg : upImgMain,
			detailImg1 : upImgOne,
			detailImg2 : upImgTwo,
			detailImg3 : upImgThree,
			detailImg4 : upImgFour,
			detailImg5 : upImgFive,
			detailImg6 : upImgSix,
			dpSeq : $("#dpSeq").val()
		},function(result){
			alert('<spring:message code="M00005"/>');
			var rid = result.message;
			qtjs.href('<ifvm:url name="reservationDetail"/>' + '?rid=' + rid);
		},function(result){
			alert('<spring:message code="M00029"/>');
		});
		
	}
}

//상세화면
 function reservDetail(args){
 	$.ifvSyncPostJSON('<ifvm:action name="reservationDetail"/>',{
 		rid : args
 	},function(result){
 		$('#placeNm').val(result.placeNm);
 		$('#placeDesc').val(result.placeDesc);
 		$('#placeSeq').val(result.telNo);
 		$('#addr').val(result.addr);
 		$('#openTime').val(result.openTime);
 		$('#longitude').val(result.longitude);
 		$('#latitude').val(result.latitude);
 		$('#dpSeq').val(result.dpSeq);
 		statusCd = result.statusCd;
 		
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
		
		if($.fn.ifvmIsNotEmpty(result.detailImg4)){
			var imgobj = [{imgOrgUrl: result.detailImg4}];
			detailImageFour.setImgArr(imgobj);
		}
		
		if($.fn.ifvmIsNotEmpty(result.detailImg5)){
			var imgobj = [{imgOrgUrl: result.detailImg5}];
			detailImageFive.setImgArr(imgobj);
		}
		
		if($.fn.ifvmIsNotEmpty(result.detailImg6)){
			var imgobj = [{imgOrgUrl: result.detailImg6}];
			detailImageSix.setImgArr(imgobj);
		}
		
		//종료된 이벤트 수정 X
		if(statusCd == 'E'){
			$("#btnMasterSave").prop('disabled',true);
		}
 	});
 }
 
 /**************************** 저장/수정 END **********************************/

function btnListClick() {
	qtjs.href('<ifvm:url name="reservationListNew"/>');
}
</script>