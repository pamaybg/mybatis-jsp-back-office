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
		응모/참여형
        <span>&gt; 상세</span>
    </h1>
</div>
<div>
<div class="page_btn_area">
    <div class="col-xs-5">
        <span>일반 정보</span>
    </div>
    <div class="col-xs-7 searchbtn_r">
		<ifvm:inputNew type="button" id="btnMasterSave" btnFunc="btnMasterSaveClick" btnType="save" text="L00074" objCode="eventPlanExcutionDetailSave_OBJ"/>
		<ifvm:inputNew type="button" id="btnList" btnFunc="btnListClick" text="D00024" objCode="eventPlanExcutionDetailList_OBJ"/>
    </div>
</div>

<div class="form-horizontal underline top_well" id="bannerMasterForm">
	<div class="row qt_border">
	
		<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="이벤트명"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:input type="text" disabled="true" id="eventNo" dto="eventNo"/>
			</div>
			<div class="col-xs-9 control_content">
				<ifvm:input type="text"  required="true" id="eventNm" dto="eventNm"/>
			</div>
		<%-- 이벤트명 --%>
		<%-- <label class="col-xs-1 control-label"><span class="asterisk">*</span>이벤트명</label>
		<div class="col-xs-8 control_content">
			<ifvm:input type="textarea" id="eventNm" names="eventNm" required="true" maxLength="1000" rows="3"/>
		</div> --%>
	</div>
	
	<div class="row qt_border">
		<label class="col-xs-1 control-label"></label>
			<div class="col-xs-11 control_content"> 
				<ifvm:input type="textarea" id="noteText" names="noteText" maxLength="2000" rows="3"/>
			</div>
	</div>
	
	<div class="row qt_border">
	
		<%-- 이벤트 유형 --%>
		<label class="col-xs-1 control-label"><span class="asterisk">*</span>유형</label>
		<div class="col-xs-2 control_content">
			<ifvm:input type="select" id="eventType" names="eventType" required="true"/> 
		</div>
		
		<label class="col-xs-1 control-label">상세유형</label>
		<div class="col-xs-2 control_content">
			<ifvm:input type="select" id="eventCategory" names="eventCategory"/> 
		</div>
		
		<%-- 이벤트 유형 --%>
		<label class="col-xs-2 control-label"><span class="asterisk">*</span>상태</label>
		<div class="col-xs-2 control_content">
			<ifvm:input type="select" id="evtStatusCd" names="evtStatusCd" disabled="true" required="true"/> 
		</div>
		
	</div>
	
	<div class="row qt_border">
		<%-- 이벤트 기간 --%>
		<label class="col-xs-1 control-label"><span class="asterisk">*</span>기간</label>
		<div class="col-xs-2 control_content">
			<ifvm:input type="date" id="voteStartDate" names="voteStartDate" required="true"/>
		</div>
		<div class="col-xs-1 swung_dash">~</div>
		<div class="col-xs-2 control_content">
			<ifvm:input type="date" id="voteEndDate" names="voteEndDate" required="true"/>		
		</div>
		
		<%-- 당첨완료일시 --%>
		<label class="col-xs-2 control-label onair">당첨완료일시</label>
		<div class="col-xs-2 control_content onair">
			<ifvm:input type="text" id="winCmpltDt" names="winCmpltDt" disabled="true"/>
		</div>
	</div>
	
	<div class="row qt_border">
		<%-- 이벤트 순서 --%>
		<%-- <label class="col-xs-1 control-label">표시순서</label>
		<div class="col-xs-1 control_content">
			<ifvm:input type="number" id="eventSeq" names="eventSeq"/>
		</div> --%>
		<!-- <div class="col-xs-3 control_content"> 
			<a><i class="helpBtn" style="vertical-align: middle;">
				<div class="helptxt" style="display:none;">
					이벤트 순서가 겹친다면 이벤트순서 & 응모 종료일이 늦은순으로 표시 합니다.
				</div>
			</i></a>
		</div> -->
	</div>

	<div class="half_wrap top_well">
		<%-- <div class="half_content half_left">
			<div class="page_btn_area">
				<div class="col-xs-10">
					<span>참여조건</span>
				</div>
			</div>
			<div class="form-horizontal top_well underline">
				<div class="row qt_border">
					1회 응모 티켓수
					<label class="col-xs-2 control-label onair"><span class="asterisk" id="oneEventVoteCntAstr">*</span>선착순</label>
					<div class="col-xs-4 control_content onair">
						<ifvm:input type="number" className="text-right" id="maxApplyCnt" names="maxApplyCnt" required="true"/>
					</div>
					최대 응모수
					<label class="col-xs-2 control-label"><span class="asterisk">*</span>최대 응모수</label>
					<div class="col-xs-2 control_content">
						<ifvm:input type="number" id="maxVoteCnt" names="maxVoteCnt" required="true"/>
					</div>
					<!-- <div class="col-xs-1">
						<a><i class="helpBtn" style="vertical-align: middle;">
							<div class="helptxt" style="display:none;">
								최대 응모수가 0일 경우 무제한으로 응모가 가능합니다.
								<br/>UGC 이벤트는 스탬프 개수를 의미하며, 값이 1인 경우 단일 적립을 의미합니다.
								<br/>(FO화면에서 스탬프 이미지가 표시되지 않음)
							</div>
						</i></a>
					</div> -->
				</div>
				<div class="row qt_border">
					일 제한 횟수
					<label class="col-xs-2 control-label"><span class="asterisk" id="oneMaxCntAstr">*</span>1일 최대</label>
					<div class="col-xs-4 control_content">
						<ifvm:input type="number" className="text-right" id="dayLimitCnt" names="dayLimitCnt" required="true"/>
					</div>
					<div class="col-xs-1 swung_dash"> 회</div>
					<%-- 기기 등록여부
					<div class="col-xs-2 control-label onair"><span class="asterisk" id="devRegYnAstr">*</span><spring:message code="L02572"/></div>
					<div class="col-xs-2 control_content onair">
						<ifvm:input type="checkbox" id="devRegYn" names="devRegYn"/>
					</div>

				</div>
				<div class="row qt_border">
					일 제한 횟수
					<label class="col-xs-2 control-label"><span class="asterisk" id="oneMaxCntAstr">*</span>기간내 최대</label>
					<div class="col-xs-4 control_content">
						<ifvm:input type="number" className="text-right" id="totLimitCnt" names="totLimitCnt" required="true"/>
					</div>
					<div class="col-xs-1 swung_dash"> 회</div>
				</div>
				
				<div class="row qt_border">
					일 제한 횟수
					등급제한 여부
					<label class="col-xs-2 control-label onair">등급 제한</label>
					<div class="col-xs-4 control_content onair">
						<ifvm:input type="checkbox" id="tierLimitYn" names="tierLimitYn"/>
					</div>
				</div>
				<div class="row qt_border">
					일 제한 횟수
					<label class="col-xs-2 control-label">포인트 차감</label>
					<div class="col-xs-4 control_content">
						<ifvm:input type="number" className="text-right" id="usePntAmt" names="usePntAmt"/>
					</div>
					<div class="col-xs-1 swung_dash"> P</div>
				</div>
				<div class="row qt_border">
					일 제한 횟수
					<label class="col-xs-2 control-label">Ticket차감</label>
					<div class="col-xs-4 control_content">
					    <div class="input-group">
						<ifvm:input type="text" disabled="true" id="ticketOfrNm" names="ticketOfrNm"/>
						<span class="input-group-addon" id="btnTicketPopBtn">
								<a><i class="fa fa-search"></i></a>
							</span>
						</div>
					</div>
					<div class="col-xs-2 control_content">
						<ifvm:input type="number" id="useOfrAmt" className="text-right" names="useOfrAmt"/>
					</div>
					<div class="col-xs-1 swung_dash"> 개</div>
				</div>
			</div>
		</div> --%>	
		
		<%-- <div class="half_content half_right">
			<div class="page_btn_area">
				<div class="col-xs-12">
					<span>혜택 오퍼</span>
					<a><i class="helpBtn" style="vertical-align: middle;">
						<div class="helptxt" style="display:none;">
							당첨자에게 포인트 혜택을 지급하기 위해서는 이벤트캠페인을 등록 후 아래 오퍼에서 선택하여야 합니다.
						</div>
					</i></a>
				</div>
			</div>
			<div class="row qt_border">
				<label class="col-xs-2 control-label">오퍼/수량</label>
					<div class="col-xs-4 control_content">
					    <div class="input-group">
						<ifvm:input type="text" disabled="true" id="bnftOfrNm" names="bnftOfrNm"/>
						<span class="input-group-addon" id="btnBnftOfrAmtPopBtn">
								<a><i class="fa fa-search"></i></a>
							</span>
						</div>
					</div>
					<div class="col-xs-2 control_content">
						<ifvm:input type="number" id="bnftOfrAmt" className="text-right" names="bnftOfrAmt"/>
					</div>
					
					<label class="col-xs-2 control-label">유효시작</label>
					<div class="col-xs-1 control_content">
						<ifvm:input type="number" className="text-right" id="effStrtDayCnt" names="effStrtDayCnt"/>
					</div>
					<div class="col-xs-1 swung_dash"> 일</div>
				</div>		

			<div class="row qt_border">
				<label class="col-xs-2 control-label">당첨시점</label>
				<div class="col-xs-9 control_content">
					<ifvm:input type="select" id="evtWinTypeCd" names="evtWinTypeCd"/> 
				</div>
			
				<label class="col-xs-2 control-label">당첨자 수</label>
				<div class="col-xs-6 control_content">
					<ifvm:input type="text" className="text-right" id="winMbrCnt" names="winMbrCnt" /> 
				</div>
				
			</div>
			
			<div class="row qt_border">
				<label class="col-xs-2 control-label">당첨확률</label>
				<div class="col-xs-6 control_content">
					<ifvm:input type="text" className="text-right" id="winRate" names="winRate" /> 	
				</div>
				<div class="col-xs-1 swung_dash"> %</div>
			</div>
		</div> --%>
	</div>

<%-- 	<div class="page_btn_area">
		<div class="col-xs-12">
			<span>이벤트 상세</span>
		</div>
	</div>
	<div class="well form-horizontal underline" id="monthlyArea">
		<div class="row qt_border onair">
			<div class="col-xs-1 control-label">이벤트 일시</div>
			<div class="col-xs-2 control_content">
				<ifvm:input type="date" id="eventDate" names="eventDate" />		
			</div>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="time" id="eventTime" />
			</div>
			<div class="col-xs-3 control-label">당첨발표일</div>
			<div class="col-xs-2 control_content">
				<ifvm:input type="date" id="eventWiningDate" names="eventDate" />		
			</div>
		</div>
		
		<div class="row qt_border onair">
			<div class="col-xs-1 control-label">이벤트 장소</div>
			<div class="col-xs-3 control_content">
				<ifvm:input type="text" id="eventPlace" names="eventPlace" maxLength = "500"/>		
			</div>
		</div>
	</div> --%>
	<div class="well form-horizontal underline onair" id="snsArea">
		<div class="row qt_border">
			<%-- <label class="col-xs-1 control-label">
				다운로드 파일
				<ifvm:input type="radio" id="downFilecheck" names="downFilecheck" checked="checked" values="file"/>
			</label>
			<!-- 파일업로드   -->
			<div class="col-xs-2 control_content">
				<ifvm:input type="file" id="fileAdd" /> <!-- 파일 경로  -->
				<span class="downFileObj" id="viewFileNm"></span>
				<button style="padding-left:5px; display: none;" class="btn btn-sm btn_gray btn_lightGray2 downFileObj" id="downFileRemoveBtn">삭제</button>
				<ifvm:input type="hidden" id="fileNm"/>
				<ifvm:input type="hidden" id="realFilePath"/>
			</div>
			<label class="col-xs-1 control_content red" style="text-align:center; font-size: 11px;; line-height: 22px;">(최대 10MB)</label>
			<!-- 다운로드 URL  -->
			<label class="control-label col-xs-3">
				<ifvm:input type="radio" id="downFilecheck" names="downFilecheck" values="url"/>
				다운로드 URL
			</label>
			<div class="col-xs-2 control_content">
				<ifvm:input type="text" id="downURL"/>
			</div> --%>
		</div>
	</div>
	<%-- <div class="well form-horizontal underline onair" id="giftArea">
		<div class="row qt_border">
			<div class="col-xs-1 control-label">배송지 등록 여부</div>
			<div class="col-xs-11 control_content">
				<ifvm:input type="checkbox" id="addrRegYn" names="addrRegYn"/>
			</div>
		</div>
	</div> --%>		
<%-- 	<div class="well form-horizontal underline" id="onAirArea">
		<div class="row qt_border">
			<!-- 동영상 최소 재생시간(초) -->
			<div class="col-xs-1 control-label"><span class="asterisk" id="videoTimeAstr">*</span><spring:message code="L02538"/><br/><spring:message code="L02539"/></div>
			<div class="col-xs-1 control_content">
				<ifvm:input type="number" id="videoTime" names="videoTime"/>
			</div>
		</div>
	</div> --%>
	
	<%-- <div class="page_btn_area">
		<div class="col-xs-12">
			<span>상세 이미지</span>
		</div>
	</div>
	<div class="well form-horizontal underline">
		<div class="row qt_border" style="padding-top: 10px;">
			<div class="row qt_border">
				<label class="col-xs-1 control-label thumImage">썸네일 이미지</label>
				<div class="col-xs-1 thumImage" style="font-size:0; line-height:0;">
					<div class="picture_area" id="thumImage"></div>
					<label class="col-xs-9 red" style="text-align:left; font-size: 11px;;">(600 X 600)</label>
				</div>
				<label class="col-xs-1 control-label mainImage" id="mainImageLbl">메인 이미지 </label>
				<div class="col-xs-1 mainImage" style="font-size:0; line-height:0;">
					<div class="picture_area" id="mainImage"></div>
					<label class="col-xs-9 red" id="mainImageSize" style="text-align:left;font-size: 11px;; "></label>
					<a  id="mainImgHelp" ><i class="helpBtn" style="vertical-align: middle;" >
							<div class="helptxt" style="display:none;">
								서버에 동영상 직접 업로드 시, 
								<br/>
								최대 50MB로 제한됩니다.
							</div>
						</i></a>
				</div>
				<label class="col-xs-1 control-label detailImageOne" id="detailImageLbl">상세 이미지 1</label>
				<div class="col-xs-1 detailImageOne" style="font-size:0; line-height:0;">
					<div class="picture_area" id="detailImageOne"></div>
					<label class="col-xs-9 red" id="detailImageOneSize" style="text-align:left; font-size: 11px;;"></label>
					<a id="detailImgHelp"><i class="helpBtn" style="vertical-align: middle;">
							<div class="helptxt" style="display:none;">
								동영상 파일의 썸네일이 변경되며
								<br/>
								미등록 시, 기본 썸네일이 적용됩니다.
							</div>
						</i></a>
				</div>
				<label class="col-xs-1 control-label detailImageTwo">상세 이미지 2</label>
				<div class="col-xs-1 detailImageTwo" style="font-size:0; line-height:0;">
					<div class="picture_area" id="detailImageTwo"></div>
					<label class="col-xs-9 red" style="text-align:left; font-size: 11px;;">(1200 X n)</label>
				</div>
				<label class="col-xs-1 control-label detailImageThree">상세 이미지 3</label>
				<div class="col-xs-1 detailImageThree" style="font-size:0; line-height:0;">
					<div class="picture_area" id="detailImageThree"></div>
					<label class="col-xs-9 red" style="text-align:left; font-size: 11px;;">(1200 X n)</label>
				</div>
			</div>
		</div>
		
		<div class="row qt_border mainUrlReg" style="padding-top: 10px; display: none;">
			<label class="col-xs-1 control-label mainImage">유튜브 URL 등록</label>
			<div class="col-xs-3" style="font-size:0; line-height:0;">
				<ifvm:input type="text" id="mainRegUrl" names="mainRegUrl" maxLength="500" />
			</div>
			<div class="col-xs-1" style="padding-left:5px;">
				<button class="btn btn-sm btn_gray btn_lightGray2" id="mainUrlRegBtn">등록</button>
				<a><i class="helpBtn" style="vertical-align: middle;">
					<div class="helptxt" style="display:none;">
					<li>유튜브 URL 찾는 방법</li>
					<li>1. 해당 유뷰브 화면에서 [공유] 버튼 클릭.</li> 
					<li>2. URL을 복사하여 위 텍스트 박스에 붙여 넣기 하여 등록 합니다.</li>
					<li>ex) https://youtu.be/dsu6Rclod1o</li>
					<!-- <li>2. 링크 공유에서 [퍼가기] 클릭.</li>
					<li>3. 동영상 퍼가기 태그 중 src="유튜브 URL" URL만 복사 하여 위 텍스트 박스에 붙여 넣기 하여 등록 합니다.</li> -->
					</div>
				</i></a>
			</div>
		</div>
		
	</div> --%>
	
</div>
	
</div>
	
<div id="eventTabDiv" style="margin-top:20px"></div>
<div id="popupContainer" class="popup_container"></div><!-- 팝업 -->
<div id="eventImageViewPop" class="popup_container"></div><!-- 팝업 -->
<div id="ofrPop" class="popup_container"></div><!-- 팝업 -->
<div id="bnftOfrPop" class="popup_container"></div><!-- 팝업 -->

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

<script>
var eventRid =  '<%= cleanXss(request.getParameter("rid")) %>';
if(eventRid == "null") eventRid = null;
var eventTypeCd =  '<%= cleanXss(request.getParameter("eventTypeCd")) %>';
if(eventTypeCd == "null") eventTypeCd = null;
var thumImage = null;
var mainImage = null;
var detailImageOne = null;
var detailImageTwo = null;
var detailImageThree = null;
var uploadFile = null;
/* var promotion = null;
var promotionRid = null; */
var evtStatusCd = null;
var winCmpltYn = null;
var winCmpltYn = null;
var evtCatCd = null;

var attrib01 = '${pageContext.request.contextPath}/resources/images/beacon/store/ico_bg_camera.gif';
var evtType = null;
var maxStmpCnt = null;//최대 스탬프 개수
var offerRid=null;
var bnftOfrRid=null;

$(document).ready(function() {
	
	/* if(promotion != null) $("#promotion").val(promotion); */
	
	//날짜설정
	setChannelCalendar();
	//탭설정
	initTab();
	
	$.fn.ifvmSetSelectOptionCommCode("eventType", "EVT_TYPE_CD", null, null, true);
	$.fn.ifvmSetSelectOptionCommCode("evtStatusCd", "EVT_STATUS_CD", null, null, true);
	$.fn.ifvmSetSelectOptionCommCode("evtWinTypeCd", "EVT_WIN_TYPE_CD", null, null, true);
	$.fn.ifvmSetSelectOptionCommCode("eventCategory", "LNL_EVT_CD", null, null, false);

	if(eventTypeCd != null){
		$('#eventType').val(eventTypeCd);
		/* $('#eventType').prop("disabled","true"); */
		$('#evtStatusCd').prop("disabled","true");
	}
	
	//이미지 설정
	thumImage = settingImageObject(eventRid, "thumImage", 1, 1, attrib01);
	mainImage = settingImageObject(eventRid, "mainImage", 1, 1, attrib01);
	detailImageOne = settingImageObject(eventRid, "detailImageOne", 1, 1, attrib01);
	detailImageTwo = settingImageObject(eventRid, "detailImageTwo", 1, 1, attrib01);
	detailImageThree = settingImageObject(eventRid, "detailImageThree", 1, 1, attrib01);
	
	
	//초기셋팅
	disableCheck();
	eventCehck();
	
	if(eventRid != null){
		/* $('#eventType').prop("disabled","true"); */
		eventPlanDetail(eventRid);	
		
		var eventType=$('#eventType').val();
		
		
		//사용하지 않는 탭 숨기기
		$('.tab-list').children('.disabled').hide();
	}
	
	$("#fileAdd").on("change" , function(){
		tempFileUpload(this);
	});
	
	//다운로드 radio 버튼
	$("input:radio[name=downFilecheck]").click(function(){
		disableCheck();
	});

	$('#eventType').change(function(){
		eventCehck();
		disableCheck();
	});

	//메인이미지 수동 등록 버튼
	$("#mainUrlRegBtn").click(function(){
		mainUrlReg();
	});
	
	//다운로드파일  제거 버튼
	$("#downFileRemoveBtn").click(function(){
		downFileRemove();
	});
	
	//다운로드파일  제거 버튼
	$("#btnTicketPopBtn").click(function(){
		TicketPopup();
	});
	
	//다운로드파일  제거 버튼
	$("#btnBnftOfrAmtPopBtn").click(function(){
		bnftOfrPopup();
	});
	
    $('.helpBtn').setupHelpMessage();
	
    /* $('#videoTime').on("blur keyup",function(){
        $(this).val($(this).val().replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g,''));
     }); */
});

function TicketPopup() {
	$("#ofrPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="ofrPop"/>',
        contentType: "ajax",
        title: '오퍼 조회',
        width: 600,
        close : 'ofrClosePop'
	});
}

function ofrClosePop() {
	ofrPop._destroy();
}

function bnftOfrPopup() {
	$("#bnftOfrPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="bnftOfrPop"/>',
        contentType: "ajax",
        title: '오퍼 조회',
        width: 600,
        close : 'bnftOfrClosePop'
	});
}

function bnftOfrClosePop() {
	bnftOfrPop._destroy();
}


//이미지 뷰 팝업
function imageViewPopup(args) {
	var id = args.id.replace("LogoImg0", "");
	
	var list = eval(id).getImageList();
	
	if (list.length > 0) {
		var obj = list[0];
		var path = obj.filePath;
		
	    $("#eventImageViewPop").ifvsfPopup({
	        enableModal : true,
	          enableResize: false,
	          contentUrl: '<ifvm:url name="eventImageViewPop"/>?path=' + path,
	          contentType: "ajax",
	          title: '', 
	          width: '900px',
	          close : 'eventImageViewPopupClose'
	      });
	}
}

function eventImageViewPopupClose() {
	eventImageViewPop._destroy();
}

//다운로드파일 제거
function downFileRemove() {
	$(".downFileObj").hide();
	$("#viewFileNm").text("");
	$("#fileNm").val("");
	$("#realFilePath").val("");
	$("#fileAdd").val('');
	$("#fileAdd").show();
}

//파일첨부 추가하기
function tempFileUpload(_this){
	if(_this.value){
		var arr = _this.value.split("\\");
		var fileName = arr[arr.length-1];
		
		var count = 0;
		var typeCheck = false;
		
		var SubSize = $("#fileAdd")[0].files[0].name.split('.');			
		var formData = new FormData();
		formData.append("file", $("#fileAdd")[0].files[0]);
		$.ajax({
			url: '<ifvm:action name="tempUploadS3"/>',
			data: formData,
			processData: false,
			contentType: false,
			type: 'POST',
			success: function(data){
				changeFile();
				data[0].saveFlag = true;
				$("#realFilePath").val(data[0].url);
				$("#viewFileNm").text(fileName);
				$("#fileNm").val(fileName);
				$("#fileAdd").hide();
				$(".downFileObj").show();
				
		        FileData = data;	
			}
		});
	}
}

function changeFile(){
	var value = $("#fileAdd").val();
	var array = value.split("\\");
	$("#fileValue").val(array[array.length-1]);
}

//S3 이미지 삭제
function s3Delete(fileName, imgObj){
	$.ifvSyncPostJSON('<ifvm:action name="tempUploadS3Delete"/>',{
       	FileName : fileName
    },function(result){
    	updateImg(imgObj);
	});
};

//S3 이미지 삭제 후 DB 이미지 업데이트
function updateImg(imgObj){
	if(eventRid == null){
		$.ifvErrorPop('<spring:message code="M00255"/>');//삭제되었습니다. 
		return;
	} else{
		var imgNm= imgObj.imgId.replace("LogoImg","");

		//DB 이미지 업데이트
    	$.ifvSyncPostJSON('<ifvm:action name="updateEventEmg"/>',{
			rid : eventRid,
			fileNm : imgNm
		},function(result){
			if(result.success == true){
				$.ifvErrorPop('<spring:message code="M00255"/>');//삭제되었습니다. 
				eventRid = result.message;
				qtjs.href('<ifvm:url name="eventPlanExcutionDetail"/>' + '?rid=' + eventRid);
			}else{
				$.ifvErrorPop('<spring:message code="M00029"/>');//작업도중실패
			}
		});
   		return;
	};
}
//저장
function btnMasterSaveClick(){
	var url;
	validation = $("#bannerMasterForm").ifvValidation();
	var eventType = $("#eventType").val();
    var maxVoteCnt = $("#maxVoteCnt").val(); //최대응모수
    
	if(validation.confirm() === false) return;
		
	else{
		//업로드 파일 셋팅
		var uploadImgThum = thumImage.getImageList();
		var uploadImgMain = mainImage.getImageList();
		var uploadImgOne = detailImageOne.getImageList();
		var uploadImgTwo = detailImageTwo.getImageList();
		var uploadImgThree = detailImageThree.getImageList();
		var uploadImgNm = null;
		
		var upImgThum, upImgMain, upImgOne, upImgTwo, upImgThree
		
		if(uploadImgThum.length == 0){
			//upImgThum = $("#thumImageLogoImg0").attr('src')
		}else{
			upImgThum = uploadImgThum[0].filePath;
		}
		
		if(uploadImgMain.length == 0){
			//upImgMain = $("#mainImageLogoImg0").attr('src')
		}else{
			upImgMain = uploadImgMain[0].filePath;
		}
		
		if(uploadImgOne.length == 0){
			//upImgOne = $("#detailImageOneLogoImg0").attr('src')
		}else{
			upImgOne = uploadImgOne[0].filePath;
		}
		
		if(uploadImgTwo.length == 0){
			//upImgTwo = $("#detailImageTwoLogoImg0").attr('src')
		}else{
			upImgTwo = uploadImgTwo[0].filePath;
		}
		
		if(uploadImgThree.length == 0){
			//upImgThree = $("#detailImageThreeLogoImg0").attr('src')
		}else{
			upImgThree = uploadImgThree[0].filePath;
		}
		
		/* if($.fn.ifvmIsEmpty(promotionRid)){
			promotionRid == null;
		} */
		//신규 수정 여부 
		if(eventRid == null){
			url = '<ifvm:action name="saveEventPlane"/>'
			evtType=$("#eventType").val()
			if(confirm('<spring:message code="M01633"/>') === false) return;
		} else{
			url = '<ifvm:action name="updateEventPlane"/>'
			if(confirm('<spring:message code="M01633"/>') === false) return;
		}
		
        
		if($('input:checkbox[id="addrRegYn"]').is(":checked") == true){
			addrRegYn = 'Y'
		}else{
			addrRegYn = 'N'
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
	}
	$.ifvSyncPostJSON(url,{
		rid : eventRid,
		eventNm : $("#eventNm").val(),
		noteText : $("#noteText").val(),
		eventType : evtType,
		eventCategory : $("#eventCategory").val(),
		voteStartDate : $("#voteStartDate").val(),
		voteEndDate : $("#voteEndDate").val(),
		eventSeq : $("#eventSeq").val(),
		maxApplyCnt : $("#maxApplyCnt").val(),
		oneMaxCnt : $("#dayLimitCnt").val(),
		totLimitCnt : $("#totLimitCnt").val(),
		usePntAmt : $("#usePntAmt").val(),
		useOfrAmt : $("#useOfrAmt").val(),
		evtWinTypeCd : $("#evtWinTypeCd").val(),
		winMbrCnt : $("#winMbrCnt").val(),
		winRate : $("#winRate").val(),
		noteText : $("#noteText").val(),
		effStrtDayCnt : $("#effStrtDayCnt").val(),
		bnftOfrAmt : $("#bnftOfrAmt").val(),
		bnftOfrNm : $("#bnftOfrNm").val(),
		bnftOfrRid : bnftOfrRid,
		ofrUseRid : offerRid,
		//eventNo : $("#eventNo").val(),
		oneEventVoteTicketCnt : $("#oneEventVoteTicketCnt").val(),
		maxVoteCnt : $("#maxVoteCnt").val(),
		eventDate : $("#eventDate").val(),
		eventTime : $("#eventTime").val(),
		//videoTime : $("#videoTime").val(),
		eventWiningDate : $("#eventWiningDate").val(),
		eventPlace : $("#eventPlace").val(),
		downFilecheck : $("#downFilecheck").val(),
		downURL : $("#downURL").val(),
		downFile : $("#realFilePath").val(),
		downFileNm : $("#fileNm").val(),
		thumImg : upImgThum,
		mainImg : upImgMain,
		detailImg1 : upImgOne,
		detailImg2 : upImgTwo,
		detailImg3 : upImgThree,
		notice : $("#notice").val(),
		radioCheck : $("input:radio[name=downFilecheck]:checked").val(),
		addrRegYn : addrRegYn,
		devRegYn : devRegYn,
		tierLimitYn : tierLimitYn,
	},function(result){
		if(result.success == true){
			alert('<spring:message code="M00005"/>');
			if( $.fn.ifvmIsNotEmpty(result.message)) {
				eventRid = result.message;
				qtjs.href('<ifvm:url name="eventPlanExcutionDetail"/>' + '?rid=' + eventRid);
			} else {
				location.reload();
			}
		}else{
			alert('<spring:message code="M00029"/>');
		}
	});
}

//상세화면
function eventPlanDetail(args){
	$.ifvSyncPostJSON('<ifvm:action name="eventPlanDetail"/>',{
		rid : args
	},function(result){
		evtType=result.evtTypeCd;
		var subDate = result.evtDt;
		var date,min;
		if($.fn.ifvmIsNotEmpty(subDate) || subDate != null){
			date = subDate.substring(0,10);
			min	 = subDate.substring(10,16);
		}
		$("#eventNo").val(result.evtNo);
		$("#eventNm").val(result.evtNm);
		$("#eventSeq").val(result.evtSeq);
		$("#eventType").val(result.evtTypeCd).change();
		$("#eventCategory").val(result.evtCatCd);

		if($.fn.ifvmIsNotEmpty(result.addrRegYn)){
			if(result.addrRegYn == 'Y'){
				$("#addrRegYn").prop('checked',true);
			}else{
				$("#addrRegYn").prop('checked',false);
			}
		}else{
			$("#addrRegYn").prop('checked',false);
		}
		
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
			}else{
				$("#tierLimitYn").prop('checked',false);
			}
		}
	
		
		//이벤트 유형별 화면 설정
		eventCehck();
		
		$("#voteStartDate").val(result.applyStartDt);
		$("#totLimitCnt").val(result.totLimitCnt);
		$("#voteEndDate").val(result.applyEndDt);
		$("#eventDate").val(date);
		$("#eventTime").val(min);
		$("#ticketOfrNm").val(result.ticketOfrNm);
		//$("#videoTime").val(result.onairTime);
		$("#eventPlace").val(result.evtPlace);
		$("#eventWiningDate").val(result.winDt);
		$("fileNm").val(result.fileNm);
		$("#realFilePath").val(result.downFile);
		$("#downUrl").val(result.downUrl);
		$("#oneEventVoteTicketCnt").val(result.oneApplyTicket);
		$("#maxVoteCnt").val(result.maxApplyCnt);
		$("#dayLimitCnt").val(result.oneMaxApplyCnt);
		$("#notice").val(result.notice);
		$("#winCmpltDt").val(result.winCmpltDt);
		$("#usePntAmt").val(result.usePntAmt);
		offerRid = result.ofrUseRid;
		$("#useOfrAmt").val(result.useOfrAmt);
		$("#bnftOfrAmt").val(result.bnftOfrAmt);
		$("#bnftOfrNm").val(result.bnftOfrNm);
		$("#effStrtDayCnt").val(result.effStrtDayCnt);
		bnftOfrRid = result.bnftOfrRid
		$("#evtWinTypeCd").val(result.evtWinTypeCd);
		$("#winMbrCnt").val(result.winMbrCnt);
		$("#winRate").val(result.winRate);
		$("#noteText").val(result.noteText);
		$("#maxApplyCnt").val(result.maxApplyCnt);
		winCmpltYn = result.winCmpltYn;
		evtStatusCd = result.evtStatusCd;
		evtTypeCd = result.evtTypeCd;
		evtCatCd = result.evtCatCd;
		
		$.fn.ifvmSetSelectOptionCommCode("eventType", "EVT_TYPE_CD", evtTypeCd, null, true);
		$.fn.ifvmSetSelectOptionCommCode("evtStatusCd", "EVT_STATUS_CD", evtStatusCd, null, true);
		$.fn.ifvmSetSelectOptionCommCode("evtWinTypeCd", "EVT_WIN_TYPE_CD", winCmpltYn, null, true);
		$.fn.ifvmSetSelectOptionCommCode("eventCategory", "LNL_EVT_CD", evtCatCd, null, false);
		maxStmpCnt = result.maxApplyCnt;
		//다운로드 파일 확인
		if($.fn.ifvmIsNotEmpty(result.downFile)) {
			$("#viewFileNm").text(result.fileNm);
			$(".downFileObj").show();
			$("#fileAdd").hide(); 
		} else {
			$(".downFileObj").hide();
			$("#fileAdd").show();
		}
		
		if($.fn.ifvmIsNotEmpty(result.thumbNailImg)){
			//$("#thumImageLogoImg0").attr('src',result.thumbNailImg);
			var imgobj = [{imgOrgUrl: result.thumbNailImg}];
			thumImage.setImgArr(imgobj);
			
		}
		
		if($.fn.ifvmIsNotEmpty(result.mainImg)){
			//$("#mainImageLogoImg0").attr('src',result.mainImg);
			var imgobj = [{imgOrgUrl: result.mainImg}];
			mainImage.setImgArr(imgobj);
			
		}
		
		if($.fn.ifvmIsNotEmpty(result.detailImg1)){
			//$("#detailImageOneLogoImg0").attr('src',result.detailImg1);
			var imgobj = [{imgOrgUrl: result.detailImg1}];
			detailImageOne.setImgArr(imgobj);
			
		}
		
		if($.fn.ifvmIsNotEmpty(result.detailImg2)){
			//$("#detailImageTwoLogoImg0").attr('src',result.detailImg2);
			var imgobj = [{imgOrgUrl: result.detailImg2}];
			detailImageTwo.setImgArr(imgobj);
			
		}
		
		if($.fn.ifvmIsNotEmpty(result.detailImg3)){
			//$("#detailImageThreeLogoImg0").attr('src',result.detailImg3);
			var imgobj = [{imgOrgUrl: result.detailImg3}];
			detailImageThree.setImgArr(imgobj);
		}
		
		//종료된 이벤트 수정 X
		if(evtStatusCd == 'E'){
			$("#btnMasterSave").prop('disabled',true);
		}
	});
}

//달력셋팅
function setChannelCalendar() {
	var startDate = $('#voteStartDate');
	var endDate = $('#voteEndDate');
	var eventDate = $('#eventDate');
	var eventTime = $('#eventTime');
	var eventWiningDate = $('#eventWiningDate');
	
	//이벤트 날짜
	eventDate.val($.ifvGetTodayDate());
	eventDate.ifvDateChecker();
	eventWiningDate.val($.ifvGetTodayDate());
	eventWiningDate.ifvDateChecker();
	
	//오늘날짜
	startDate.val($.ifvGetTodayDate());
	
	//오늘부터 한달 뒤
	endDate.val($.ifvGetNewDate('m', +1).newDateS);
	eventWiningDate.val($.ifvGetNewDate('m',+1).newDateS);
	
	$('#eventTime').timepicker({
        showMeridian: false,
        defaultTime: '00:00',
        showSeconds: false,
        minuteStep: 5,
        secondStep: 1,
	});
	
	//설정
	startDate.ifvDateChecker({
	 maxDate : endDate
	});
	
	endDate.ifvDateChecker({
	 minDate : startDate
	});
	
	/* eventWiningDate.ifvDateChecker({
	 minDate : eventDate
	}); */
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
	imgObj.customValidFunc = function(files, data) {
		var eventType = $("#eventType").val();
		var rObj = {originData : data};
		rObj.valid = false;
		if(eventType == "ONAIR" && data.fileInput.context.id == "mainImageTempUploadBtn0"){
			var extensionRegex = /(\.|\/)(mp4|avi|mkv)$/i
				
			// 확장자가 mp4, avi가 아닐 경우 에러
			if (!extensionRegex .test(files[0].name)) {
				rObj.message = '<spring:message code="L02546"/>';//동영상 확장자만 업로드 가능합니다.
			// 50메가 초과일 경우 에러
			} else if(files[0].size > 52428800) {
				rObj.message = '<spring:message code="L02590"/>';//용량이 초과되었습니다.
			} else {
				rObj.valid = true;
			}
		}else{
	    	rObj.valid = true;
	    }
		return rObj;
	}
	
	imgObj.imageRemove = function(args) {
	   var idx = args.id.substr(args.id.length - 1, 1);
	   var obj = imgObj.getImgArr()[idx];
	   
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
	}
	return imgObj;
};


function imageRemove(_this) {
	var idx = _this.id.substr(_this.id.length - 1, 1);
	var obj = backImage.getImgArr()[idx];
	backImage.delImage(_this);
}

//메인이미지 수동 등록
function mainUrlReg() {
	var url = $("#mainRegUrl").val();
	
	if (url != "") {
		url=url.replace('https://youtu.be/','');
		url="https://www.youtube.com/embed/"+url;
		
		mainImage.removeAll();
		
		var imgobj = [{imgOrgUrl: url}];
		mainImage.setImgArr(imgobj);
	}
}

//라디오버튼 체크
function disableCheck(){
	var radioCheck = $("input:radio[name=downFilecheck]:checked").val();
	if($("#eventType").val() == "SNS"){
		if(radioCheck == 'file'){
			$('#downURL').attr('disabled',true);
			$('#downURL').val('');
			$("#TempUploadBtn").attr('disabled',false);
			$("#fileAdd").attr('disabled',false);
		}else if(radioCheck == 'url'){
			$('#downURL').attr('disabled',false);
			$("#TempUploadBtn").attr('disabled',true);
			$('#TempUploadBtn').val('');
			downFileRemove();
			$("#fileAdd").attr('disabled',true);
			$("#fileAdd").val('');
		}
	}
}

//select Box 체크 이벤트 유형
function eventCehck(){
	var eventType = $("#eventType").val(); 							//이벤트 유형
	/* $("#promotion").removeAttr('required'); */
	/* $("#promotionAstr").hide(); */
	/* $("#oneMaxCntAstr").hide(); */
	/* $("#noticeAstr").hide(); */
	$/* ("#promotion").removeClass('ifv_vali_wrong'); */
	/* $("#videoTimeAstr").hide();
	$("#videoTime").removeAttr('required'); */
	
	if(eventType == 'ONLINE'){
		$('.onair').show();											//onair 유형 시 숨김 class설정
		/* $("#eventDate").attr('disabled',false); */						//이벤트일시
		/* $("#eventTime").attr('disabled',false)	 */					//이벤트일시
		/* $("#eventWiningDate").attr('disabled',false); */				//당첨발표일
		/* $("#eventPlace").attr('disabled',false); */					//이벤트 장소
		/* $('#downURL').attr('disabled',true);
		$("#TempUploadBtn").attr('disabled',true); */
		$('#downURL').val('');
		$("#TempUploadBtn").val('');
		$('#mainImageEvt0').prop('value','MONTHLY'); 				//이벤트유형 넘기기
		/* $("#videoTime").prop('disabled',true)						//동영상 최소재생시간
		$("#videoTime").val('');									//동영상 최소재생시간 */
		
		$("#oneEventVoteTicketCnt").val('1'); 						//1회 응모 티켓수
		$("#maxVoteCnt").val('0');									//최대 응모수
		/* $("#maxVoteCnt").prop('disabled',false); */					//최대 응모수
		/* $("#oneMaxCnt").prop('disabled',true); */						//일 제한 횟수
		/* $("#oneMaxCnt").prop('required',false); */						//일 제한 횟수 필수값 설정
		$("#oneMaxCnt").val(''); 									//일 제한 횟수
		/* $("#oneEventVoteTicketCnt").prop('required',true); */			//1회 응모 티켓수
		/* $("#oneEventVoteTicketCnt").attr('disabled', false);  */		//1회응모티켓수
		$("#thumImageTempUploadBtn0").attr('disabled',false);  		//썸네일 이미지
		$("#detailImageOneTempUploadBtn0").attr('disabled',false); 	//상세이미지1
		$("#detailImageTwoTempUploadBtn0").attr('disabled',false); 	//상세이미지2
		$("#detailImageThreeTempUploadBtn0").attr('disabled',false);//상세이미지3
		$("#mainImageTempUploadBtn0").attr('disabled',false);		//메인이미지
		$("input[name='downFilecheck']").attr('disabled',true);
		$("#fileAdd").attr('disabled',true);
		$("#fileAdd").val('');
		/* $("#notice").attr('disabled',false);
		$("#notice").attr('required',false); */
		$("#notice").val('');
		$(".mainImage").show();
		$(".thumImage").show();
		$(".detailImageOne").show();
		$(".detailImageTwo").show();
		$(".detailImageThree").show();
		$(".mainUrlReg").hide();
		$("#mainImageSize").text('(1600 X 800)'); 					//메인이미지 사이즈
		$("#mainImageLbl").text('메인 이미지'); 						//메인이미지 라벨명
		$("#mainImgHelp").hide();									//메인이미지 helptxt
		$("#detailImageLbl").text('상세 이미지 1'); 					//상세 이미지 1 라벨명
		$("#detailImgHelp").hide();									//상세 이미지1 helptxt
		$("#addrRegYn").prop('disabled',true);
		$("#mainImageTempUploadBtn0").removeAttr('accept');			//비디오타입 제한
		$("#mainImageLogoImg0").removeAttr('onLoad'); 				//파일타입체크 실행해제
		$("#devRegYn").prop('disabled',true);						//기기등록 여부
		$("#oneEventVoteCntAstr").show();							//1회 응모 티켓수 
		$("#devRegYnAstr").hide();									//기기등록 여부
		$("#tierLimitAstr").hide();									//등급제한 여부
		$("#detailImageOneSize").text('(1200 X n)');
		/* $("#tierLimitYn").prop('disabled',true); */					//등급제한 여부
		/* $("#winnerRdm").prop('disabled',false); */
	}else if(eventType == 'OFFLINE'){
		$('.onair').show();											//onair 유형 시 숨김 class설정
		/* $("#eventDate").attr('disabled',false); */						//이벤트일시
		/* $("#eventTime").attr('disabled',false)	 */					//이벤트일시
		/* $("#eventWiningDate").attr('disabled',false); */				//당첨발표일
		/* $("#eventPlace").attr('disabled',false); */					//이벤트 장소
		/* $('#downURL').attr('disabled',true);
		$("#TempUploadBtn").attr('disabled',true); */
		$('#downURL').val('');
		$("#TempUploadBtn").val('');
		$('#mainImageEvt0').prop('value','MONTHLY'); 				//이벤트유형 넘기기
		/* $("#videoTime").prop('disabled',true)						//동영상 최소재생시간
		$("#videoTime").val('');									//동영상 최소재생시간 */
		
		$("#oneEventVoteTicketCnt").val('1'); 						//1회 응모 티켓수
		$("#maxVoteCnt").val('0');									//최대 응모수
		/* $("#maxVoteCnt").prop('disabled',false); */					//최대 응모수
		/* $("#oneMaxCnt").prop('disabled',true); */						//일 제한 횟수
		/* $("#oneMaxCnt").prop('required',false); */						//일 제한 횟수 필수값 설정
		$("#oneMaxCnt").val(''); 									//일 제한 횟수
		/* $("#oneEventVoteTicketCnt").prop('required',true); */			//1회 응모 티켓수
		/* $("#oneEventVoteTicketCnt").attr('disabled', false);  */		//1회응모티켓수
		$("#thumImageTempUploadBtn0").attr('disabled',false);  		//썸네일 이미지
		$("#detailImageOneTempUploadBtn0").attr('disabled',false); 	//상세이미지1
		$("#detailImageTwoTempUploadBtn0").attr('disabled',false); 	//상세이미지2
		$("#detailImageThreeTempUploadBtn0").attr('disabled',false);//상세이미지3
		$("#mainImageTempUploadBtn0").attr('disabled',false);		//메인이미지
		$("input[name='downFilecheck']").attr('disabled',true);
		$("#fileAdd").attr('disabled',true);
		$("#fileAdd").val('');
		/* $("#notice").attr('disabled',false);
		$("#notice").attr('required',false); */
		$("#notice").val('');
		$(".mainImage").show();
		$(".thumImage").show();
		$(".detailImageOne").show();
		$(".detailImageTwo").show();
		$(".detailImageThree").show();
		$(".mainUrlReg").hide();
		$("#mainImageSize").text('(1600 X 800)'); 					//메인이미지 사이즈
		$("#mainImageLbl").text('메인 이미지'); 						//메인이미지 라벨명
		$("#mainImgHelp").hide();									//메인이미지 helptxt
		$("#detailImageLbl").text('상세 이미지 1'); 					//상세 이미지 1 라벨명
		$("#detailImgHelp").hide();									//상세 이미지1 helptxt
		$("#addrRegYn").prop('disabled',true);
		$("#mainImageTempUploadBtn0").removeAttr('accept');			//비디오타입 제한
		$("#mainImageLogoImg0").removeAttr('onLoad'); 				//파일타입체크 실행해제
		$("#devRegYn").prop('disabled',true);						//기기등록 여부
		$("#oneEventVoteCntAstr").show();							//1회 응모 티켓수 
		$("#devRegYnAstr").hide();									//기기등록 여부
		$("#tierLimitAstr").hide();									//등급제한 여부
		$("#detailImageOneSize").text('(1200 X n)');
		/* $("#tierLimitYn").prop('disabled',true); */					//등급제한 여부
		/* $("#winnerRdm").prop('disabled',false); */
	}else if(eventType == 'SNS'){
		$('.onair').show();											//onair 유형 시 숨김 class설정
		$("input[name='downFilecheck']").attr('disabled',false);
		/* $("#eventDate").attr('disabled',true); */						//이벤트일시
		/* $("#eventTime").attr('disabled',true)						//이벤트일시
		$("#eventWiningDate").attr('disabled',true);				//당첨발표일
		$("#eventPlace").prop('disabled',true); */						//이벤트 장소
		/* $("#videoTime").prop('disabled',true)						//동영상 최소재생시간
		$("#videoTime").val('');									//동영상 최소재생시간 */

		
		$("#thumImageTempUploadBtn0").attr('disabled',true); 		//썸네일 이미지 
		$("#detailImageOneTempUploadBtn0").attr('disabled',true); 	//상세이미지1
		$("#detailImageTwoTempUploadBtn0").attr('disabled',true); 	//상세이미지2
		$("#detailImageThreeTempUploadBtn0").attr('disabled',true); //상세이미지3
		$("#mainImageTempUploadBtn0").attr('disabled',false);		//메인이미지
		$("#oneEventVoteTicketCnt").val('0'); 	 					//1회 응모 티켓수
		/* $("#oneEventVoteTicketCnt").attr('disabled', false); */ 		//1회응모티켓수
		/* $("#maxVoteCnt").val('1');	 */								//최대 응모수
		/* $("#maxVoteCnt").prop('disabled',false); */					//최대 응모수
		/* $("#oneMaxCnt").prop('disabled',true); */						//일 제한 횟수
		/* $("#oneMaxCnt").prop('required',false); */						//일 제한 횟수 필수값 설정
		$("#oneMaxCnt").val(''); 									//일 제한 횟수
		/* $("#oneEventVoteTicketCnt").prop('required',true); */			//1회 응모 티켓수
		$("#eventDate").val('');
		$("#eventTime").val('');
		$("#eventWiningDate").val('');
		$("#eventPlace").val('');
		$("#fileAdd").attr('disabled',false);
		/* $("#notice").attr('disabled',true);
		$("#notice").attr('required',false); */
		$("#notice").val('');
		$('#mainImageEvt0').attr('value','SNS'); 					//이벤트유형 넘기기
		$(".mainImage").show();
		$(".thumImage").hide();
		$(".detailImageOne").hide();
		$(".detailImageTwo").hide();
		$(".detailImageThree").hide();
		$(".mainUrlReg").show();
		$("#mainImageSize").text('(704 X 360)');
		$("#mainImageLbl").text('메인 이미지'); 						//메인이미지 라벨명
		$("#mainImgHelp").hide();									//메인이미지 helptxt
		$("#detailImageLbl").text('상세 이미지 1'); 					//상세 이미지 1 라벨명
		$("#detailImgHelp").hide();									//상세 이미지1 helptxt
		$("#addrRegYn").prop('disabled',true);
		/* $("#promotion").attr('required',true); */
		$("#promotionAstr").show();
		$("#mainImageTempUploadBtn0").removeAttr('accept');			//비디오타입 제한
		$("#mainImageLogoImg0").removeAttr('onLoad'); 				//파일타입체크 실행해제
		$("#devRegYn").prop('disabled',true);						//기기등록 여부
		$("#winningCondBtn").prop('disabled',true);				//당첨조건
		$("#oneEventVoteCntAstr").show();							//1회 응모 티켓수 
		$("#devRegYnAstr").hide();									//기기등록 여부
		$("#tierLimitAstr").hide();									//등급제한 여부
		/* $("#tierLimitYn").prop('disabled',true); */					//등급제한 여부
		$("#winnerRdm").prop('disabled',true);
	}else if(eventType == 'ONAIR'){
	/* 	$('.onair').hide();	 */										//onair 유형 시 숨김 class설정
		/* $("input[name='downFilecheck']").attr('disabled',false); */
		/* $("#eventDate").attr('disabled',true);						//이벤트일시
		$("#eventTime").attr('disabled',true); */						//이벤트일시
		/* $("#videoTime").prop('disabled',false);						//동영상 최소재생시간
		$("#videoTime").prop('required',true); */
		/* $("#eventWiningDate").attr('disabled',true);				//당첨발표일
		$("#eventPlace").attr('disabled',true);	 */					//이벤트 장소
		
		$("#thumImageTempUploadBtn0").attr('disabled',true); 		//썸네일 이미지 
		$("#detailImageOneTempUploadBtn0").attr('disabled',false); 	//상세이미지1
		$("#detailImageTwoTempUploadBtn0").attr('disabled',true); 	//상세이미지2
		$("#detailImageThreeTempUploadBtn0").attr('disabled',true); //상세이미지3
		$("#mainImageTempUploadBtn0").attr('disabled',false);		//메인이미지
		$("#oneEventVoteTicketCnt").val('0'); 	 					//1회 응모 티켓수
		$("#maxVoteCnt").val('1');									//최대 응모수
		/* $("#maxVoteCnt").prop('disabled',true); */						//최대 응모수
		$("#oneMaxCnt").val('1');									//일 제한 횟수
		/* $("#oneMaxCnt").attr('disabled',true); */						//일 제한 횟수
		/* $("#oneMaxCntAstr").show();	 */								//일 제한 횟수 필수값 설정 
		
		/* $("#oneEventVoteTicketCnt").attr('disabled', true); */ 		//1회응모티켓수
		$("#oneEventVoteTicketCnt").val('');
	/* 	$("#oneEventVoteTicketCnt").prop('required',false); */
		
		$("#eventDate").val('');
		$("#eventTime").val('');

		//$("#videoTimeAstr").show();
		$("#eventWiningDate").val('');
		$("#eventPlace").val('');
		$("#fileAdd").attr('disabled',false);
		/* $("#notice").attr('disabled',false);
		$("#notice").attr('required',true); */
		$('#mainImageEvt0').attr('value','ONAIR'); 					//이벤트유형 넘기기
		$(".thumImage").hide();
		$(".mainImage").show();
		$(".detailImageOne").show();
		$(".detailImageTwo").hide();
		$(".detailImageThree").hide();
		$(".mainUrlReg").show();
		$("#mainImageSize").text('(동영상 파일)');
		$("#mainImageLbl").text('동영상'); 							//메인이미지 라벨명
		$("#mainImgHelp").show();									//메인이미지 helptxt
		$("#detailImageLbl").text('동영상 썸네일'); 					//상세 이미지 1 라벨명
		$("#detailImgHelp").show();									//상세 이미지1 helptxt
		$("#addrRegYn").prop('disabled',true);
		/* $("#promotion").attr('required',true); */
		/* $("#promotionAstr").show(); */
		/* $("#noticeAstr").show(); */
		$("#oneEventVoteCntAstr").hide();							//1회 응모 티켓수 
		$("#devRegYnAstr").hide();									//기기등록 여부
		$("#tierLimitAstr").hide();									//등급제한 여부
		$("#detailImageOneSize").text('(1080 X 608)');
		$("#mainImageTempUploadBtn0").prop('accept','.avi, .mp4, .mkv');//비디오타입 제한
        
        $("#devRegYn").prop('disabled',true);						//기기등록 여부
        $("#winningCondBtn").prop('disabled',true);				//당첨조건
		/* $("#tierLimitYn").prop('disabled',true); */					//등급제한 여부
		$("#winnerRdm").prop('disabled',true);
	}
	
}

/**
 * 탭 설정
 */
function initTab() {
    /* 탭 */
    eventTab = $('#eventTabDiv').DrawTab({
        item: items
        /* [
            {label: '<spring:message code="L02651"/>', href: '/loyalty/event/include/evtApplicant'},
            {label: '당첨자', href: '/loyalty/event/include/winner'}/* ,
        ] */
    });
}

function btnListClick() {
	qtjs.href('<ifvm:url name="eventPlanExcution"/>');
}
</script>