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
	.stampTable {width:100%;}
	.stampTable th {text-align:center;background-color: #eee;border:1px solid #ddd;}
	.stampTable td {text-align:center;border:1px solid #ddd;padding:10px 0;}
	.stampTable td div {width:100%;margin:0 auto;}
	.stampTable td div form div {left:50%;transform: translate(-50%);}
	.stampTable td div form input {width:auto;}
</style>

<!-- AWS S3용 이미지 템플릿 -->
<script id="imageUploadTemplateAwsS3" type="text/x-jquery-tmpl">
<div id='${'${'}imgId}ContainerPop${'${'}index}' class="image_box" seq='${'${'}index}' isBind='false' RotateAngle='0' >
   <form id='${'${'}imgId}TempUploadForm${'${'}index}' method="POST" enctype="multipart/form-data" style="float: left;">
      <input id="${'${'}imgId}TempUploadBtn${'${'}index}" type="file" name="file" data-url="<ifvm:action name="tempUploadS3"/>" onclick="javascript:${'${'}imgId}.clickEditImage(this);" title='수정'>
   </form>
   <div class="btns" id="${'${'}imgId}PostPopPicBtns${'${'}index}">
      <a id="${'${'}imgId}RotateBtn${'${'}index}" href="javascript:;" onclick="javascript:${'${'}imgId}.rotationImage(this);" title='이미지 회전'><img src='${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_rotation.png' class="btn_delete" /></a>
      <a id="${'${'}imgId}DeleteBtn${'${'}index}" href="javascript:;" onclick="javascript:${'${'}imgId}.imageRemove(this);" title='이미지 삭제'><img src='${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_x.png' class="btn_delete" /></a>
   </div>
{{if isCircleImage == true}}
   <img id='${'${'}imgId}LogoImg${'${'}index}' width="70px" height="70px" src='${'${'}defaultImg}' class="handle" style="border-radius:50%"/>
{{/if}}
{{if isCircleImage == false}}
   <img id='${'${'}imgId}LogoImg${'${'}index}' width="70px" height="70px" src='${'${'}defaultImg}' class="handle"/>
{{/if}}
   <div class="upload_progress_container" id="${'${'}imgId}Progress${'${'}index}"></div>
</div>
</script>

<script type="text/javascript">

var ridStmp = '<%= cleanXss(request.getParameter("rid")) %>';
ridStmp = ridStmp === 'null' ? null : ridStmp;

//이미지 업로드
var bgImg = null;
var boardImg = null;
var stmpImg1 = null;
var stmpImg2 = null;
var stmpImg3 = null;
var stmpImg4 = null;
var stmpImg1Sect = null;
var stmpImg2Sect = null;
var stmpImg3Sect = null;
var stmpImg4Sect = null;

var stmpTab = null;

//스탬프 상세화면 초기 세팅
function initStmpDetail() {

	$.fn.ifvmSetSelectOptionCommCode("stmpStatus", "LOY_STMP_SATUS_CD", null, null, true);
	$.fn.ifvmSetSelectOptionCommCode("applyChnlCd", "LOY_STMP_APPLY_CHNL_CD", null, null, true);
	$.fn.ifvmSetSelectOptionCommCode("calcTypeCd", "LOY_STMP_CALC_TYPE_CD", null, null, true);
	$.fn.ifvmSetSelectOptionCommCodeSync("calcTypeSubCd", "LOY_STMP_CALC_TYPE_SUB_CD", null, 'calcTypeCd', true);
	$.fn.ifvmSetSelectOptionCommCode("stmpAreaCode", "LOY_AREA_CD", null, null, false);

	$("#mbrTgtYn").append("<option value='N'>N</option>");
	$("#mbrTgtYn").append("<option value='Y'>Y</option>");

	$("#mbrNonTgtYn").append("<option value='N'>N</option>");
	$("#mbrNonTgtYn").append("<option value='Y'>Y</option>");



	//스탬프 상태 기본 작업중
	$('#stmpStatus').val('W');
	//구매
	$('#purCntMinAmt').val(0);

	//행사기간 세팅
	var startDate = $('#stmpStartDt');
	var endDate = $('#stmpEndDt');
	//오늘날짜
	startDate.val($.ifvGetTodayDate());
	//오늘부터 한달 뒤
	endDate.val($.ifvGetNewDate('m', +1).newDateS);

	//설정
	startDate.ifvDateChecker({
	 maxDate : endDate
	});

	endDate.ifvDateChecker({
	 minDate : startDate
	});

	//이미지 업로더 세팅
	//기본이미지 조회
	$.ifvPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'LOY_STMP_DEFAULT_IMG'
	},function(result){
		$.each(result.rows, function(i,e) {
			var codeName = e.codeName;
			var attrib01 = '<%=com.icignal.common.util.CommonUtil.getInstance().getImageServerUrl()%>' + '/' + e.attrib01;
			switch (codeName) {
		    case 'STMP_BG':
				bgImg = settingImageObject(ridStmp, 'bgImg', 1, 1, false, attrib01);
		    	break;
		    case 'STMP_BOARD':
				boardImg = settingImageObject(ridStmp, 'boardImg', 1, 1, false, attrib01);
		    	break;
		    case 'STMP_IMG_1':
				stmpImg1 = settingImageObject(ridStmp, 'stmpImg1', 1, 1, true, attrib01);
		    	break;
		    case 'STMP_IMG_2':
				stmpImg2 = settingImageObject(ridStmp, 'stmpImg2', 1, 1, true, attrib01);
		    	break;
		    case 'STMP_IMG_3':
				stmpImg3 = settingImageObject(ridStmp, 'stmpImg3', 1, 1, true, attrib01);
		    	break;
		    case 'STMP_IMG_4':
				stmpImg4 = settingImageObject(ridStmp, 'stmpImg4', 1, 1, true, attrib01);
		    	break;
		    case 'STMP_IMG_1_SECT':
				stmpImg1Sect = settingImageObject(ridStmp, 'stmpImg1Sect', 1, 1, true, attrib01);
		    	break;
		    case 'STMP_IMG_2_SECT':
				stmpImg2Sect = settingImageObject(ridStmp, 'stmpImg2Sect', 1, 1, true, attrib01);
		    	break;
		    case 'STMP_IMG_3_SECT':
				stmpImg3Sect = settingImageObject(ridStmp, 'stmpImg3Sect', 1, 1, true, attrib01);
		    	break;
		    case 'STMP_IMG_4_SECT':
				stmpImg4Sect = settingImageObject(ridStmp, 'stmpImg4Sect', 1, 1, true, attrib01);
		    	break;
		    default:
		    	break;
			}
		});
	});
}

//스탬프 상세 조회
function getStmpDetail() {
	if($.fn.ifvmIsNotEmpty(ridStmp)) {
		$.ifvPostJSON('<ifvm:action name="getLoyStmpDetail"/>', {
			rid : ridStmp
		}, function(result) {
			$("#stmpDetailForm").dataSetting(result);

			//현재 멀티업로더 파일목록 초기화 후 재적재
			bgImg.uploadform.filelist = [];
			boardImg.uploadform.filelist = [];
			stmpImg1.uploadform.filelist = [];
			stmpImg2.uploadform.filelist = [];
			stmpImg3.uploadform.filelist = [];
			stmpImg4.uploadform.filelist = [];
			stmpImg1Sect.uploadform.filelist = [];
			stmpImg2Sect.uploadform.filelist = [];
			stmpImg3Sect.uploadform.filelist = [];
			stmpImg4Sect.uploadform.filelist = [];

			if(result.imageUrl != '' && $.fn.ifvmIsNotEmpty(result.bgImg)) {
				bgImg.setImgArrList(result.bgImg);
			}
			if(result.imageUrl != '' && $.fn.ifvmIsNotEmpty(result.boardImg)) {
				boardImg.setImgArrList(result.boardImg);
			}
			if(result.imageUrl != '' && $.fn.ifvmIsNotEmpty(result.stmpImg1)) {
				stmpImg1.setImgArrList(result.stmpImg1);
			}
			if(result.imageUrl != '' && $.fn.ifvmIsNotEmpty(result.stmpImg2)) {
				stmpImg2.setImgArrList(result.stmpImg2);
			}
			if(result.imageUrl != '' && $.fn.ifvmIsNotEmpty(result.stmpImg3)) {
				stmpImg3.setImgArrList(result.stmpImg3);
			}
			if(result.imageUrl != '' && $.fn.ifvmIsNotEmpty(result.stmpImg4)) {
				stmpImg4.setImgArrList(result.stmpImg4);
			}
			if(result.imageUrl != '' && $.fn.ifvmIsNotEmpty(result.stmpImg1Sect)) {
				stmpImg1Sect.setImgArrList(result.stmpImg1Sect);
			}
			if(result.imageUrl != '' && $.fn.ifvmIsNotEmpty(result.stmpImg2Sect)) {
				stmpImg2Sect.setImgArrList(result.stmpImg2Sect);
			}
			if(result.imageUrl != '' && $.fn.ifvmIsNotEmpty(result.stmpImg3Sect)) {
				stmpImg3Sect.setImgArrList(result.stmpImg3Sect);
			}
			if(result.imageUrl != '' && $.fn.ifvmIsNotEmpty(result.stmpImg4Sect)) {
				stmpImg4Sect.setImgArrList(result.stmpImg4Sect);
			}

			$('#calcTypeCd').change();
			$('#stmpCalcTypeSubCd').val(result.calcTypeSubCd);

			if($("#applyChnlCd").val()=="01"){
				$("#stmpAreaCode").attr("disabled",true);
			}else{
				$("#stmpAreaCode").removeAttr("disabled");
			}
		});

	}
}

//스탬프 저장
function saveStmp() {
	var validation = $("#stmpDetailForm").ifvValidation();
	if(validation.confirm()){

		$.ifvProgressControl(true);

		var bgImgArr = bgImg.getImageList();
		var boardImgArr = boardImg.getImageList();
		var stmpImg1Arr = stmpImg1.getImageList();
		var stmpImg2Arr = stmpImg2.getImageList();
		var stmpImg3Arr = stmpImg3.getImageList();
		var stmpImg4Arr = stmpImg4.getImageList();
		var stmpImg1SectArr = stmpImg1Sect.getImageList();
		var stmpImg2SectArr = stmpImg2Sect.getImageList();
		var stmpImg3SectArr = stmpImg3Sect.getImageList();
		var stmpImg4SectArr = stmpImg4Sect.getImageList();

		//이미지 등록 여부 체크
// 		if($.fn.ifvmIsEmpty(bgImgArr)) {
// 			$.ifvCallValidationBox($("#bgImgLogoImg0"),"<spring:message code='C00024'/>");
// 			return false;
// 		}
// 		if($.fn.ifvmIsEmpty(boardImgArr)) {
// 			$.ifvCallValidationBox($("#boardImgLogoImg0"),"<spring:message code='C00024'/>");
// 			return false;
// 		}
// 		if($.fn.ifvmIsEmpty(stmpImg1Arr)) {
// 			$.ifvCallValidationBox($("#stmpImg1LogoImg0"),"<spring:message code='C00024'/>");
// 			return false;
// 		}
// 		if($.fn.ifvmIsEmpty(stmpImg2Arr)) {
// 			$.ifvCallValidationBox($("#stmpImg2LogoImg0"),"<spring:message code='C00024'/>");
// 			return false;
// 		}
// 		if($.fn.ifvmIsEmpty(stmpImg3Arr)) {
// 			$.ifvCallValidationBox($("#stmpImg3LogoImg0"),"<spring:message code='C00024'/>");
// 			return false;
// 		}
// 		if($.fn.ifvmIsEmpty(stmpImg4Arr)) {
// 			$.ifvCallValidationBox($("#stmpImg4LogoImg0"),"<spring:message code='C00024'/>");
// 			return false;
// 		}

		var submitData = $("#stmpDetailForm").getSubmitData();
		submitData.purCntMinAmt = $('#purCntMinAmt').val().replaceAll(',','');
		submitData.bgImg = bgImgArr;
		submitData.boardImg = boardImgArr;
		submitData.stmpImg1 = stmpImg1Arr;
		submitData.stmpImg2 = stmpImg2Arr;
		submitData.stmpImg3 = stmpImg3Arr;
		submitData.stmpImg4 = stmpImg4Arr;
		submitData.stmpImg1Sect = stmpImg1SectArr;
		submitData.stmpImg2Sect = stmpImg2SectArr;
		submitData.stmpImg3Sect = stmpImg3SectArr;
		submitData.stmpImg4Sect = stmpImg4SectArr;
		submitData.rid = ridStmp;

		if($.fn.ifvmIsEmpty(ridStmp)) {
			//신규
			$.ifvSyncPostJSON('<ifvm:action name="setLoyStmp"/>'
			, submitData
			, function(result) {
				ridStmp = result.message;
				getStmpDetail();
				alert('<spring:message code="L00076"/>');
				$.ifvProgressControl(false);

				//현재 탭 reload
				stmpTab.reloadCurrentTab();
			}, function(result) {
				$.ifvProgressControl(false);

				if(result.message === '1') {
					alert('이미지를 모두 등록해주세요.');
				} else {
					alert('저장할 수 없습니다. 관리자에게 문의해주세요.');
				}
			});
		} else {
			//수정
			$.ifvSyncPostJSON('<ifvm:action name="editLoyStmp"/>'
			, submitData
			, function(result) {
				getStmpDetail();
				alert('<spring:message code="M00106"/>');
				$.ifvProgressControl(false);

				//현재 탭 reload
				stmpTab.reloadCurrentTab();
			});
		}

	}
}

//스탬프 목록 이동
function moveStmpList() {
	qtjs.href('<ifvm:url name="stmpList"/>');
}

//스탬프 상세 탭 초기화
function initStmpTab() {
	stmpTab = $('#stmpTabArea').DrawTab({
		item : [
		{	label : '구간별 스탬프', 	href : '<ifvm:url name="stmpItemList"/>'	},
		{	label : '적용 채널', 		href : '<ifvm:url name="stmpStoreList"/>'	},
		{   label : '특정 회원', 		href : '<ifvm:url name="stmpMbrTgtList"/>'	},
		{   label : '제외 회원', 		href : '<ifvm:url name="stmpMbrNonTgtList"/>'	},
		{   label : '참여 회원', 		href : '<ifvm:url name="stmpMbrList"/>'		},
		]
		, afterContentLoad : setEnableInputAtDetail
	});
}

/**
 * (공통) 이미지 영역 및 객체 세팅
 * @param : _imgParentId > picture_area 클래스를 가진 요소아이디
 *          _imgId > picture_area 클래스를 가진 요소아이디
 *          _size > 실제 이미지 등록 영역 개수
 *          _maxNumber > 등록할 수 있는 이미지 최대 개수
 *          _isCircleImage > 둥근이미지 여부. true 일 경우 border-radius 처리하여 둥근이미지로 표시된다.
 			_defaultImg > 기본이미지
 */
function settingImageObject(_imgParentId, _imgId, _size, _maxNumber, _isCircleImage, _defaultImg){
	var _this = this;
	var tmpArr = new Array();
	for(var i=0; i<_size; i++){
		tmpArr.push({ index : i, imgId : _imgId, isCircleImage : _isCircleImage, defaultImg : _defaultImg });
	}

	var imgObj = null;
	$("#"+_imgId).html("");

	var template = $('#imageUploadTemplateAwsS3').tmpl(tmpArr);
	$("#"+_imgId).append(template);

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
<%-- 		'category' : "<%= CommonUtil.IMAGE_UPLOAD_TYPE.Site %>", --%>
		imgParentId : _imgParentId,
		'maxNumber' : _maxNumber,
		'tempImgWidth' : 70,
		'tempImgHeight' : 70,
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

	imgObj.imageRemove = function(args) {
	   var idx = args.id.substr(args.id.length - 1, 1);
	   var obj = imgObj.getImgArr()[idx];
	   imgObj.delImage(args);
	}

	return imgObj;
};

function getNumber(obj){
    var num01;
    var num02;
    num01 = obj.value;
    num02 = num01.replace(/\D/g,""); //숫자가 아닌것을 제거,
                                     //즉 [0-9]를 제외한 문자 제거; /[^0-9]/g 와 같은 표현
    num01 = setComma(num02); //콤마 찍기
    obj.value =  num01;
}

function setComma(n) {
    var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
    n += '';                          // 숫자를 문자열로 변환
    while (reg.test(n)) {
       n = n.replace(reg, '$1' + ',' + '$2');
    }
    return n;
}

//천단위 구분자 설정
function setThousandSeparator() {
	//천단위 구분자 넣을 요소 아이디 배열
	var targets = ['stmpCnt','purCntMinAmt'];

	$.each(targets, function(i,e) {
		$('#'+e).on('change', function() {
			getNumber(this);
		});
		$('#'+e).on('keyup', function() {
			getNumber(this);
		});
		$('#'+e).on('focus', function() {
			getNumber(this);
		});
	});
}

//인풋영역 활성 or 비활성 설정
function setEnableInputAtDetail() {
	if($.fn.ifvmIsNotEmpty(ridStmp)) {
		var stmpStatus = $('#stmpStatus').val();

		//스탬프 활성상태인 경우
		if(stmpStatus === 'A' || stmpStatus === 'I') {
			$.each($('#content input,select,textarea,button,file').not('disabled')
					.not('#stmpListBtn,#stmpStoreListDownBtn,#stmpMbrListDownBtn,#stmpStoreTmplDownBtn,#stmpMbrTgtListDownBtn,#stmpMbrTgtTmplDownBtn,#stmpMbrNonTgtTmplDownBtn,#stmpMbrNonTgtListDownBtn')
			, function(i,e) {
				$(e).attr('disabled',true);
			});
			$.each($('#content .image_box'), function(i,e) {
				$(e).off();
			});
		}
		//비활성상태인 경우
		if(stmpStatus === 'I') {
			//스탬프명.행사기간.적립조건.혜택안내.유의사항만 수정가능
			var targets = ['stmpNm','stmpEndDt','comment1','comment2','comment3','saveStmpBtn'];
			$.each(targets, function(i,e) {
				$('#'+e).removeAttr('disabled');
			});
		}

		var stmpCalcTypeSubCd = $('#stmpCalcTypeSubCd').val();
		if($.fn.ifvmIsNotEmpty(stmpCalcTypeSubCd)) {
			$('#calcTypeSubCd').val(stmpCalcTypeSubCd);
		}

		$.each($('.filter_area input'), function(i,e) {
			$(e).removeAttr('disabled');
		});
	}
}

function stmpTgtBtnFn(){
	$("#mbrTgtYn").change(function (){
		if( $(this).val()=='Y')
			$("#mbrNonTgtYn").val("N")
		/* else if ($(this).val()=='N')
			$("#mbrNonTgtYn").val("Y"); */
	})

	$("#mbrNonTgtYn").change(function (){
		if( $(this).val()=='Y')
			$("#mbrTgtYn").val("N")
		/* else if ($(this).val()=='N')
			$("#mbrTgtYn").val("Y"); */
	})
}

function applyChnlCdChangeFn(){

	$("#applyChnlCd").change(function(){
		if($(this).val()=="01"){
			$("#stmpAreaCode").attr("disabled",true);
		}else{
			$("#stmpAreaCode").removeAttr("disabled");
		}
	})
}
$(document).ready(function() {

	$.ifvmLnbSetting('stmpList');

	initStmpDetail();
	setThousandSeparator();
	getStmpDetail();
	setEnableInputAtDetail();
	initStmpTab();

	stmpTgtBtnFn();
	applyChnlCdChangeFn();
})

</script>

<div class="page-title">
	<h1>
		스탬프 기획 &gt; <spring:message code="L00079" />
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-2">
			<span>일반 정보</span>
		</div>
		<div class="col-xs-10 searchbtn_r">
			<ifvm:inputNew type="button" btnType="save" btnFunc="saveStmp" id="saveStmpBtn" text="L00074" />
			<ifvm:inputNew type="button" id="stmpListBtn" btnFunc="moveStmpList" text="L00824" />
		</div>
	</div>
	
	<div class="form-horizontal underline top_well" id="stmpDetailForm">
		<div class="row qt_border">
			<!-- 스탬프명 -->
			<ifvm:inputNew type="text" id="stmpNm" dto="stmpNm" label="스탬프명" nuc="true" labelClass="1" conClass="2" required="true"/>
			<!-- 스탬프번호 -->
			<ifvm:inputNew type="text" id="stmpNo" dto="stmpNo" label="스탬프번호" nuc="true" labelClass="2" conClass="2" disabled="true"/>
			<!-- 상태 -->
			<ifvm:inputNew type="select" id="stmpStatus" names="stmpStatus" dto="stmpStatus" label="상태" nuc="true" labelClass="2" conClass="2" disabled="true"/>
		</div>
		<div class="row qt_border">
			<!-- 행사기간 -->
			<ifvm:inputNew type="dateTerm" startDto="stmpStartDt" endDto="stmpEndDt" startId="stmpStartDt" endId="stmpEndDt" required="true" label="행사기간" labelClass="1" conClass="2" nuc="true" />
			<!-- 개수 -->
			<ifvm:inputNew type="text" id="stmpCnt" dto="stmpCnt" label="개수" nuc="true" labelClass="2" conClass="1" required="true"/>
			<!-- 적용채널 -->
			<ifvm:inputNew type="select" id="applyChnlCd" names="applyChnlCd" dto="applyChnlCd" label="적용채널" nuc="true" labelClass="1" conClass="1" required="true"/>
			<!-- 지역 -->
			<ifvm:inputNew type="select" id="stmpAreaCode" names="stmpAreaCode" dto="stmpAreaCode" label="지역" nuc="true" labelClass="1" conClass="2" disabled="true"/>
		</div>
		<div class="row qt_border">
			<!-- 기준유형 -->
			<ifvm:inputNew type="select" id="calcTypeCd" names="calcTypeCd" dto="calcTypeCd" label="계산유형" nuc="true" labelClass="1" conClass="1" required="true"/>
			<!-- 기준유형 -->
			<ifvm:inputNew type="select" id="mbrTgtYn" names="mbrTgtYn" dto="mbrTgtYn" label="특정회원여부" nuc="true" labelClass="1" conClass="1" required="true"/>
	
			<ifvm:inputNew type="select" id="mbrNonTgtYn" names="mbrNonTgtYn" dto="mbrNonTgtYn" label="제외회원여부" nuc="true" labelClass="1" conClass="1" required="true"/>
			<!-- 기준유형 상세 -->
			<ifvm:inputNew type="select" id="calcTypeSubCd" names="calcTypeSubCd" dto="calcTypeSubCd" label="계산유형 상세" nuc="true" labelClass="1" conClass="1" required="true"/>
			<!-- 구매횟수 최소금액 -->
			<ifvm:inputNew type="text" id="purCntMinAmt" dto="purCntMinAmt" label="구매횟수 최소금액" nuc="true" labelClass="1" conClass="2" required="true"/>
		</div>
		<div class="row qt_border">
			<!-- 적립조건 -->
			<ifvm:inputNew type="textarea" id="comment1" dto="comment1" label="적립조건" nuc="true" labelClass="1" conClass="10" rows="3" required="true"/>
		</div>
		<div class="row qt_border">
			<!-- 혜택안내 -->
			<ifvm:inputNew type="textarea" id="comment2" dto="comment2" label="혜택안내" nuc="true" labelClass="1" conClass="10" rows="3" required="true"/>
		</div>
		<div class="row qt_border">
			<!-- 유의사항 -->
			<ifvm:inputNew type="textarea" id="comment3" dto="comment3" label="유의사항" nuc="true" labelClass="1" conClass="10" rows="3" required="true"/>
		</div>
		<div class="row qt_border">
			<label class="control-label col-xs-1">이미지</label>
			<div class="control_content col-xs-10">
				<table class="stampTable">
					<caption>스탬프 배경이미지 지정 테이블</caption>
					<colgroup>
						<col style="width:20%"/>
						<col style="width:40%"/>
						<col style="width:40%"/>
					</colgroup>
					<tbody>
						<tr>
							<th></th>
							<th>백그라운드</th>
							<th>스탬프보드</th>
						</tr>
						<tr>
							<th>배경</th>
							<td class="picture_area" id="bgImg"></td>
							<td class="picture_area" id="boardImg"></td>
						</tr>
					</tbody>
				</table>
				<table class="stampTable">
					<caption>스탬프 도장이미지 지정 테이블</caption>
					<colgroup>
						<col style="width:20%"/>
						<col style="width:20%"/>
						<col style="width:20%"/>
						<col style="width:20%"/>
						<col style="width:20%"/>
					</colgroup>
					<tbody>
						<tr>
							<th></th>
							<th>미적립</th>
							<th>적립</th>
							<th>미적립(혜택)</th>
							<th>적립(혜택)</th>
						</tr>
						<tr>
							<th>기본</th>
							<td class="picture_area" id="stmpImg1"></td>
							<td class="picture_area" id="stmpImg2"></td>
							<td class="picture_area" id="stmpImg3"></td>
							<td class="picture_area" id="stmpImg4"></td>
						</tr>
						<tr>
							<th>Check</th>
							<td class="picture_area" id="stmpImg1Sect"></td>
							<td class="picture_area" id="stmpImg2Sect"></td>
							<td class="picture_area" id="stmpImg3Sect"></td>
							<td class="picture_area" id="stmpImg4Sect"></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<hidden id="stmpCalcTypeSubCd"/>

<div id="stmpTabArea">
	<div>
		<div id="tabContent" class="white_bg grid_bd0"></div>
	</div>
</div>
