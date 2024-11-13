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
<div class="page-title">
    <h1>
		포인트몰 기획/실행
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

<div class="form-horizontal underline top_well" id="pointMallMasterForm">
	<div class="row qt_border">
		<%-- 상품명 --%>
		<label class="col-xs-1 control-label"><span class="asterisk">*</span>상품명</label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="text" id="prodNm" names="prodNm" required="true" maxLength="30"/>
		</div>
		<%-- 상품번호 --%>
		<label class="col-xs-2 control-label">상품번호</label>
		<div class="col-xs-2 control_content">
			<ifvm:input type="text" id="prodNo" names="prodNo" disabled="true"/>
		</div> 
	</div>

	<div class="row qt_border">
		<!-- 상품설명 -->
		<label class="col-xs-1 control-label"><spring:message code="L02484"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="textarea" id="prodDesc" names="prodDesc" rows="3" maxLength="900"/>
		</div>
		<%-- 카테고리 --%>
		<label class="col-xs-2 control-label"><span class="asterisk">*</span>카테고리</label>
		<div class="col-xs-2 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="categoryNm" names="categoryNm" disabled="disabled" required="required"/>
				<span class="input-group-addon" id="categoryListPop">
					<a><i class="fa fa-search"></i></a>
				</span>
			</div>
		</div>
	</div>
	
	<div class="row qt_border">
		<%-- 상품코드 --%>
		<label class="col-xs-1 control-label"><span class="asterisk" id="storeAstrick">*</span>상품코드</label>
		<div class="col-xs-2 control_content">
			<ifvm:input type="text" id="prodCode" names="prodCode" required="true" maxLength="50"/>
		</div>
		<div class="col-xs-2 control_content"> 
			<a><i class="helpBtn" style="vertical-align: middle;">
				<div class="helptxt" style="display:none;">
					출고 및 배송시 확인할 수 있는 상품 고유번호입니다.
				</div>
			</i></a>
		</div>
		<%-- 브랜드 --%> <!-- 브랜드 삭제함 -->
<%-- 		<label class="col-xs-1 control-label">브랜드</label>
		<div class="col-xs-2 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="brandNm" names="brandNm" disabled="true"/>
				<span class="input-group-addon" id="brandNmListPop">
					<a><i class="fa fa-search"></i></a>
				</span>
			</div>
		</div> --%>
		
		<%-- 디스플레이 순서 --%>
		<label class="col-xs-2 control-label"><span class="asterisk">*</span>디스플레이 순서</label>
		<div class="col-xs-2 control_content">
			<ifvm:input type="number" id="displaySeq" names="displaySeq" required="true"/>
		</div>
		<div class="col-xs-2 control_content"> 
			<a><i class="helpBtn" style="vertical-align: middle;">
				<div class="helptxt" style="display:none;">
					디스플레이순서가 겹치면 등록일시가 늦은순으로 표시됩니다.
				</div>
			</i></a>
		</div>
	</div>
	
	<div class="row qt_border">
		<%-- 판매금액 --%>
		<label class="col-xs-1 control-label">판매금액</label>
		<div class="col-xs-2 control_content">
			<ifvm:input type="number" id="salePrice" names="salePrice"/>
		</div>
		<%-- 포인트 금액--%>
		<label class="col-xs-4 control-label"><span class="asterisk">*</span>포인트 금액</label>
		<div class="col-xs-2 control_content">
			<ifvm:input type="number" id="pointAmt" required="true"/>
		</div>
	</div>
	
	<div class="row qt_border">
		<%-- 수량 --%>
		<label class="col-xs-1 control-label"><span class="asterisk">*</span>수량</label>
		<div class="col-xs-2 control_content">
			<ifvm:input type="number" id="amount" names="amount" required="true"/>
		</div>
		<div class="col-xs-2 control_content"> 
			<a><i class="helpBtn" style="vertical-align: middle;">
				<div class="helptxt" style="display:none;">
					포인트로 교환 가능한 판매 수량입니다.
				</div>
			</i></a>
		</div>
		<%-- 품절임박수량 --%>
		<label class="col-xs-2 control-label">품절임박수량</label>
		<div class="col-xs-2 control_content">
			<ifvm:input type="number" id="soldOutCnt"/>
		</div>
		<div class="col-xs-3 control_content"> 
			<a><i class="helpBtn" style="vertical-align: middle;">
				<div class="helptxt" style="display:none;">
					남은수량으로 FO에서 품절임박 상품으로 표시됩니다.
				</div>
			</i></a>
		</div>
	</div>
	<br>
	<div class="row qt_border">
		<%-- 기기등록 여부 --%>
		<label class="col-xs-1 control-label"><span class="asterisk">*</span>기기등록 여부</label>
		<div class="col-xs-2 control_content">
			<ifvm:input type="checkbox" id="devRegYn" names="devRegYn"/>
		</div>
		<%-- 등급제한 여부 --%>
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L02618"/></label>
		<div class="col-xs-2 control_content">
			<ifvm:input type="checkbox" id="tierLimitYn" names="tierLimitYn"/>
			<a><i class="helpBtn" style="vertical-align: middle;">
				<div class="helptxt" style="display:none;">
					<spring:message code="L02619"/><!-- 저장 시, 등급제한 탭이  활성화 됩니다. -->
				</div>
			</i></a>
		</div>
	</div>
	
	<div class="row qt_border">
	</div>
	
	<div class="half_wrap top_well">
		<div class = "half_content half_left">
			<div class="page_btn_area">
				<div class="col-xs-10">
					<span>썸네일 이미지</span>
				</div>
			</div>
			<div class="well form-horizontal underline" id="monthlyArea">
				<div class="row qt_border" style="padding-top: 10px;">
					<div class="row qt_border">
						<label class="col-xs-2 control-label detailImageOne">이미지 1</label>
						<div class="col-xs-1 detailImageOne" style="font-size:0; line-height:0;">
							<div class="picture_area" id="detailImageOne"></div>
							<label class="col-xs-9 red" style="text-align:center; font-size: 11px;">(600*600)</label>
						</div>
						<label class="col-xs-2 control-label detailImageTwo">이미지 2</label>
						<div class="col-xs-1 detailImageTwo" style="font-size:0; line-height:0;">
							<div class="picture_area" id="detailImageTwo"></div>
							<label class="col-xs-9 red" style="text-align:center; font-size: 11px;">(600*600)</label>
						</div>
						<label class="col-xs-2 control-label detailImageThree"> 이미지 3</label>
						<div class="col-xs-1 detailImageThree" style="font-size:0; line-height:0;">
							<div class="picture_area" id="detailImageThree"></div>
							<label class="col-xs-9 red" style="text-align:center;font-size: 11px;">(600*600)</label>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class = "half_content half_right">
			<div class="page_btn_area">
				<div class="col-xs-10">
					<span>상세 이미지</span>
				</div>
			</div>
			
			<div class="well form-horizontal underline" id="monthlyArea">
				<div class="row qt_border" style="padding-top: 10px;">
					<div class="row qt_border">
						<label class="col-xs-2 control-label tumbImageOne">이미지 1</label>
						<div class="col-xs-1 tumbImageOne" style="font-size:0; line-height:0;">
							<div class="picture_area" id="tumbImageOne"></div>
							<label class="col-xs-9 red" style="text-align:center; font-size: 11px;">(1200*500)</label>
						</div>
						<label class="col-xs-2 control-label tumbImageTwo">이미지 2</label>
						<div class="col-xs-1 tumbImageTwo" style="font-size:0; line-height:0;">
							<div class="picture_area" id="tumbImageTwo"></div>
							<label class="col-xs-9 red" style="text-align:center; font-size: 11px;">(1200*500)</label>
						</div>
						<label class="col-xs-2 control-label tumbImageThree"> 이미지 3</label>
						<div class="col-xs-1 tumbImageThree" style="font-size:0; line-height:0;">
							<div class="picture_area" id="tumbImageThree"></div>
							<label class="col-xs-9 red" style="text-align:center;font-size: 11px;">(1200*500)</label>
						</div>
					</div>
				</div>
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
var pointMallRid =  '<%= cleanXss(request.getParameter("rid")) %>';
if(pointMallRid == "null") pointMallRid = null;
var thumImage = null;
var mainImage = null;
var detailImageOne = null;
var detailImageTwo = null;
var detailImageThree = null;
var tumbImageOne = null;
var tumbImageTwo = null;
var tumbImageThree = null;
var brdRid = null;
var categoryRid = null;
var evtStatusCd = null;

$(document).ready(function() {
	var attrib01 = '${pageContext.request.contextPath}/resources/images/beacon/store/ico_bg_camera.gif';
	
	//날짜설정
	setChannelCalendar();
	
	//탭설정
	initTab();
	
	$.fn.ifvmSetSelectOptionCommCode("storeType", "EVT_STORE_TYPE", null, null, false);
	
	//이미지 설정
	tumbImageOne = settingImageObject(pointMallRid, "tumbImageOne", 1, 1, attrib01);
	tumbImageTwo = settingImageObject(pointMallRid, "tumbImageTwo", 1, 1, attrib01);
	tumbImageThree = settingImageObject(pointMallRid, "tumbImageThree", 1, 1, attrib01);
	
	detailImageOne = settingImageObject(pointMallRid, "detailImageOne", 1, 1, attrib01);
	detailImageTwo = settingImageObject(pointMallRid, "detailImageTwo", 1, 1, attrib01);
	detailImageThree = settingImageObject(pointMallRid, "detailImageThree", 1, 1, attrib01);
	
	//상세 or valid 셋팅
	if(pointMallRid != null){
		pointMallDetail(pointMallRid);
	}else{
		eventTab.disabledTab([1]);//등급제한
	}
	
// 브랜드 삭제함
/* 	//브랜드팝업
	$("#brandNmListPop").on("click",function(){
		brandNmListPop();
	});
*/
	//카테고리팝업
	$("#categoryListPop").on("click",function(){
		categoryListPop();
	}); 
	
	
	
	//tool tip
    $('.helpBtn').setupHelpMessage();
});


/******************************** 팝업 관련  ********************************/
// 브랜드 삭제함
/* //브랜드 팝업
function brandNmListPop() {
    $("#popupContainer").ifvsfPopup({
      enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="brandNmListPop"/>',
        contentType: "ajax",
        title: '브랜드 목록',
        width: '600px',
        close : 'brandNmListPopClose'
    });
}

//브랜드 팝업 닫기
function brandNmListPopClose() {
	popupContainer._destroy();
} */

//카테고리 팝업
function categoryListPop() {
    $("#popupContainer").ifvsfPopup({
      enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="categoryListPop"/>',
        contentType: "ajax",
        title: '카테고리',
        width: '600px',
        close : 'categoryListPopClose'
    });
}

//카테고리 팝업닫기
function categoryListPopClose() {
	popupContainer._destroy();
}
/****************************** END 팝업 *************************************/



/************************************************************************
 **                         저장/수정                                          				   **
 ************************************************************************/
function btnMasterSaveClick(){
	var url;
	validation = $("#pointMallMasterForm").ifvValidation();
	if(validation.confirm() === false) return;
		
	else{
		//업로드 파일 셋팅
		var uploadImgOne = detailImageOne.getImageList();
		var uploadImgTwo = detailImageTwo.getImageList();
		var uploadImgThree = detailImageThree.getImageList();
		var uploadTumbImageOne = tumbImageOne.getImageList();
		var uploadTumbImageTwo = tumbImageTwo.getImageList();
		var uploadTumbImageThree = tumbImageThree.getImageList();
		var uploadImgNm = null;
		
		var upImgOne, upImgTwo, upImgThree , upThumbImgOne, upThumbImgTwo, upThumbImgThree;
		
		if(uploadImgOne.length != 0){
			upImgOne = uploadImgOne[0].filePath;
		}
		
		if(uploadImgTwo.length != 0){
			upImgTwo = uploadImgTwo[0].filePath;
		}
		
		if(uploadImgThree.length != 0){
			upImgThree = uploadImgThree[0].filePath;
		}	
		
		if(uploadTumbImageOne.length != 0){
			upThumbImgOne = uploadTumbImageOne[0].filePath;
		}
		
		if(uploadTumbImageTwo.length != 0){
			upThumbImgTwo = uploadTumbImageTwo[0].filePath;
		}
		
		if(uploadTumbImageThree.length != 0){
			upThumbImgThree = uploadTumbImageThree[0].filePath;
		}
		
		if($('input:checkbox[id="devRegYn"]').is(":checked") == true){
			devRegYn = 'Y'
		}else{
			devRegYn = 'N'
		}
		
		if($('input:checkbox[id="tierLimitYn"]').is(":checked") == true){
			tierLimitYn = 'Y'
		}else{
			tierLimitYn = 'N'
		}
		
		//신규 수정 여부 
		if(pointMallRid == null){
			url = '<ifvm:action name="savePointMall"/>'
			if(confirm('<spring:message code="M01633"/>') === false) return;
		} else{
			url = '<ifvm:action name="updatePointMall"/>'
			if(confirm('<spring:message code="M01633"/>') === false) return;
		} 	
		
		if(parseInt($('#amount').val()) > parseInt($("#soldOutCnt").val())){
			$.ifvSyncPostJSON(url,{
				rid : pointMallRid,
				prodNm : $("#prodNm").val(),
				prodNo : $("#prodNo").val(),
				prodCode : $("#prodCode").val(),
				prodDesc : $('#prodDesc').val(),
				displaySeq : $("#displaySeq").val(),
				salePrice : $("#salePrice").val(),
				pointAmt : $("#pointAmt").val(),
				amount : $("#amount").val(),
				soldOutCnt : $("#soldOutCnt").val(),
				detailImg1 : upImgOne,
				detailImg2 : upImgTwo,
				detailImg3 : upImgThree,
				upThumbImg1 : upThumbImgOne,
				upThumbImg2 : upThumbImgTwo,
				upThumbImg3 : upThumbImgThree,
				//brdRid : brdRid, <!-- 브랜드 삭제함 -->
				categoryRid : categoryRid,
				devRegYn : devRegYn,
				tierLimitYn : tierLimitYn,
			},function(result){
				alert('<spring:message code="M00005"/>');
				var rid = result.message;
				qtjs.href('<ifvm:url name="pointMallDetail"/>' + '?rid=' + rid)
			},function(result){
				alert('<spring:message code="M00029"/>');
			});
		} else{
			alert('<spring:message code="L02626"/>');
			return pointMallDetail(pointMallRid);;
		}
	
	}
	
}

//상세화면
function pointMallDetail(args){
	$.ifvSyncPostJSON('<ifvm:action name="getPointMallDetail"/>',{
		rid : args
	},function(result){
		$('#prodNm').val(result.prodNm);
		$('#prodNo').val(result.prodNo);
		$('#prodCode').val(result.prodCd);
		$('#categoryNm').val(result.catNm);
		$('#prodDesc').val(result.prodDesc);
		$('#brandNm').val(result.brdNm);
		$('#displaySeq').val(result.dpSeq);
		$('#salePrice').val(result.prodAmt);
		$('#pointAmt ').val(result.pntAmt);
		$('#amount').val(result.prodQty);
		$('#soldOutCnt').val(result.soldOutQty);
		brdRid = result.ridProdBrd;
		categoryRid = result.ridProdCat;
		evtStatusCd = result.status;
		
		if($.fn.ifvmIsNotEmpty(result.devRegYn)){
			if(result.devRegYn == 'Y'){
				$("#devRegYn").prop('checked',true);
			}else{
				$("#devRegYn").prop('checked',false);
			}
		}else{
			$("#devRegYn").prop('checked',false);
		}
		
		if($.fn.ifvmIsNotEmpty(result.tierLimitYn)){
			if(result.tierLimitYn == 'Y'){
				$("#tierLimitYn").prop('checked',true);
				eventTab.abledTab([1]);//등급제한
			}else{
				$("#tierLimitYn").prop('checked',false);
				eventTab.disabledTab([1]);//등급제한
			}
		}else{
			$("#tierLimitYn").prop('checked',false);
			eventTab.disabledTab([1]);//등급제한
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
		
		if($.fn.ifvmIsNotEmpty(result.upThumbImg1)){
			var imgobj = [{imgOrgUrl: result.upThumbImg1}];
			tumbImageOne.setImgArr(imgobj);
		}
		if($.fn.ifvmIsNotEmpty(result.upThumbImg2)){
			var imgobj = [{imgOrgUrl: result.upThumbImg2}];
			tumbImageTwo.setImgArr(imgobj);
			
		}
		if($.fn.ifvmIsNotEmpty(result.upThumbImg3)){
			var imgobj = [{imgOrgUrl: result.upThumbImg3}];
			tumbImageThree.setImgArr(imgobj);
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
            {label: '주문내역', href: '/loyalty/event/include/prodOrderList'},
            {label: '<spring:message code="L02616"/>', href: '/loyalty/event/include/tierLimitList'}//등급제한
        ]
    });
}

//목록 버튼
function btnListClick() {
	qtjs.href('<ifvm:url name="pointMallListNew"/>');
}

</script>