<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
/* 일시적으로 숨김 처리 함 */
.temporarilyHide { display: none; }
</style>

<script>

//model
var campaignStampInfo;
//dialog
var planPop;
//validation
var campaignStampInfoPopValidation;

//model 정의
function initModels(data) {
    var infoModel = function(data) {

        //data set
        this.camDefaultInfo = data;
        //캠페인아이디
        this.camDefaultInfo.ridCam = campaign.id;
        //기획자 Account Id
        this.camDefaultInfo.accountId = $.ifvmGetUserInfo().accountId;

        campaignStampInfo = this;
    };
    
    //konckout bindings
    ko.applyBindings(new infoModel(data), document.getElementById("campaignB2CInfoPop") );
}

//캠페인기본정보 저장
function saveCampaignStampInfo() {
    
	var sWrap = $('#stampWrap');
	var stampVali = sWrap.ifvValidation();
	if(stampVali.confirm() == false) return;

	campaignStampInfo.camDefaultInfo.rows = [];

	var itemCnt = sWrap.children('.form-horizontal').length;
	for(var i = 0; i < itemCnt; i++) {
		var indItem = $(sWrap.children('.form-horizontal')[i]);
		var itemObj = {};
		indItem.stampSeq = indItem.find('.seq_stamp').val();
		indItem.stampTypeCd = indItem.find('.stcd_stamp').val();
		indItem.stampCnt = indItem.find('.cnt_stamp').val();
		indItem.stampPeriod = indItem.find('.period_stamp').val();
		indItem.stampPeriodCd = indItem.find('.spcd_stamp').val();
		indItem.totStampCnt = indItem.find('.totcnt_stamp').val();
		indItem.stampGiveCnt = indItem.find('.givecnt_stamp').val();
		indItem.stampGiveCriteria = indItem.find('.givecrit_stamp').val();
		indItem.stampGiveCriteriaCd = indItem.find('.gccd_stamp').val();
		indItem.rid = indItem.attr('data-rid');
		
		campaignStampInfo.camDefaultInfo.rows.push(indItem);
	}
	
	//상세일 경우 ridCam 필요
	campaignStampInfo.camDefaultInfo.ridCam = campaign.id;
	
	//통신필요
    $.ifvSyncPostJSON('<ifvm:action name="saveCampaignStampInfo"/>', campaignStampInfo.camDefaultInfo, function(result) {
        alert('<spring:message code="M00152" />');
        //close popup
        closeCampaignStampInfoPop();
    });
}

//캠페인기본정보 팝업 설정
function campaignStampInfoInit() {
    pageSetUp();

    //노출번호
    //$.fn.ifvmSetSelectOptionCommCode("stampSeq", "SEQ_NO_TYPE", null, null, true);
    
    //스탬프유형
    //$.fn.ifvmSetSelectOptionCommCode("stampTypeCd", "STAMP_TYPE_CD", null, null, true);    
    
    //팝업설정
    cDialog.model.title = '<spring:message code="E00064"/>';
    $("#dialog_title").append('<spring:message code="E00064"/>');
    cDialog.model.width = "750";
    cDialog.model.close = "closeCampaignStampInfoPop";

    //validation
    campaignStampInfoPopValidation = $("#campaignStampInfoPop").ifvValidation();
    
	$('#inactiveStampFileUploaderBtn').click(function(){
		$("#inactiveStampHideFile").trigger("click");
	});
    
	$('#activeStampFileUploaderBtn').click(function(){
		$("#activeStampHideFile").trigger("click");
	});
}

function inactiveStampHandleFileSelect(evt) {

	var files = evt.target.files;
	if( files !== undefined ){
		var f = files[0];
		if(!f.type.match("png.*")) {
	    	return;
	    }

       var reader = new FileReader();
       reader.onload = function (e) {

           var formData = new FormData();
 			formData.append("file", $("#inactiveStampHideFile")[0].files[0]);

			$.ifvFilePostJSON('<ifvm:action name="tempUpload"/>', formData,
  				function(data){
					campaignStampInfo.camDefaultInfo.inactiveStampImageFile = data[0].url;
					campaignStampInfo.camDefaultInfo.inactiveStampImageFileName = data[0].name;
					campaignStampInfo.camDefaultInfo.inactiveStampOriName = data[0].oriName;
   				}
 			);

          $('#inactiveStampFileValue').val(f.name);
          $('#inactiveStampShowImg').empty().append($('<img/>').attr('src',e.target.result));
          
        };
    	reader.readAsDataURL(f);
	}
}

function activeStampHandleFileSelect(evt) {

	var files = evt.target.files;
	if( files !== undefined ){
		var f = files[0];
		if(!f.type.match("png.*")) {
	    	return;
	    }

       var reader = new FileReader();
       reader.onload = function (e) {

           var formData = new FormData();
 			formData.append("file", $("#activeStampHideFile")[0].files[0]);

			$.ifvFilePostJSON('<ifvm:action name="tempUpload"/>', formData,
  				function(data){
					campaignStampInfo.camDefaultInfo.activeStampImageFile = data[0].url;
					campaignStampInfo.camDefaultInfo.activeStampImageFileName = data[0].name;
					campaignStampInfo.camDefaultInfo.activeStampOriName = data[0].oriName;
   				}
 			);

          $('#activeStampFileValue').val(f.name);
          $('#activeStampShowImg').empty().append($('<img/>').attr('src',e.target.result));
          
        };
    	reader.readAsDataURL(f);
	}
}


//캠페인기본정보 팝업 데이터 설정
function campaignStampInfoInitData() {
    campaignStampInfo = {camDefaultInfo: {}};

    //set task type
    diagram._selectedObject.taskType = "STAMP";

    //캠페인 ID
    var id = diagram._selectedObject.campaignId;

    //캠페인기본정보 호출
    $.ifvSyncPostJSON('<ifvm:action name="getCampaignStampInfo"/>', {
    	ridCam: id
    },
    function(result) {
        if ($.fn.ifvmIsNotEmpty(result)){
            campaignStampInfo.camDefaultInfo.rows = result.rows;
            
            $('#inactiveStampShowImg').empty().append($('<img/>').attr('src',result.inactiveStampImgUrl));
            $('#activeStampShowImg').empty().append($('<img/>').attr('src',result.activeStampImgUrl));
            
        	var temp = $("#stampTmpl").tmpl(result.rows);
        	$('#stampWrap').append(temp);
        	setRemoveStampBtnEvent(); 
        } else {
    		var emptyObj = {
    				stampCnt: ""
    				, stampTypeCd: ""
    				, stampPeriod: ""
    				, stampPeriodCd: ""
    				, totStampCnt: ""
    				, stampGiveCnt: ""
    				, stampGiveCriteria: ""
    				, stampGiveCriteriaCd: ""
    				, rid: ""
    			}
    		
    		emptyObj.stampSeq = $('#stampWrap').children('.form-horizontal').length + 1;
    		
    		var temp = $("#stampTmpl").tmpl(emptyObj);
    		$('#stampWrap').append(temp);
    		setRemoveStampBtnEvent();        	
        }
    });
    
	$("#inactiveStampHideFile").on("change", function(e){
		inactiveStampHandleFileSelect(e);
	});
	
	$("#activeStampHideFile").on("change", function(e){
		activeStampHandleFileSelect(e);
	});

    initModels(campaignStampInfo.camDefaultInfo);
}

function addStampItem() {
	var itemCnt = $('#stampWrap').children('.form-horizontal').length;
	if(itemCnt > 9) {
		alert('<spring:message code="E00082"/>');
		return false;
	} else {
		var emptyObj = {
				stampCnt: ""
				, stampTypeCd: ""
				, stampPeriod: ""
				, stampPeriodCd: ""
				, totStampCnt: ""
				, stampGiveCnt: ""
				, stampGiveCriteria: ""
				, stampGiveCriteriaCd: ""
				, rid: ""
			}
		
		emptyObj.stampSeq = $('#stampWrap').children('.form-horizontal').length + 1;
		
		var temp = $("#stampTmpl").tmpl(emptyObj);
		$('#stampWrap').append(temp);
		setRemoveStampBtnEvent();		
	}
}

function setRemoveStampBtnEvent() {
	$('.remove_stamp').off().on('click', function() {
		var itemCnt = $('#stampWrap').children('.form-horizontal').length;
		if(itemCnt < 2) {
			alert('<spring:message code="E00090"/>');
			return false;
		} else {
			$(this).parents('.form-horizontal').remove();
			for(var i = 0; i < itemCnt-1; i++) {
				$('.seq_stamp')[i].value = i + 1;
			}
		}
	});	
}


// dialog close
function closeCampaignStampInfoPop(args) {
    campaignStampInfo = {};
    //konckout bindings stop
    ko.virtualElements.allowedBindings.stopBinding = true;

    //dialog 파괴
    cDialog._destroy();
}

$(function () {

    //캠페인기본정보 폼 설정
    campaignStampInfoInit();

    //캠페인기본정보 데이터
    campaignStampInfoInitData();

    //저장 클릭시
    $('#campaignStampInfoPopSaveBtn').on('click', function(){
        saveCampaignStampInfo();
    });

    //취소 클릭시
    $('#campaignStampInfoPopCancelBtn').on('click', function(){
        closeCampaignStampInfoPop();
    });

    setTimeout(function() {
        //popup 높이 맞추기
        new ifvm.PopupHeight({
            popupDivId : 'dialog',
            contentsId : 'dialogPopupWrap'
        });

        cDialog.refresh();
    }, 500);
});
</script>
<style type="text/css">
.input-group.file input[type="file"]{display:none;}
</style>


<script id="stampTmpl" type="text/x-jquery-tmpl">
<div class="well form-horizontal row_part_line" data-rid="${'${'}rid}">
    <div class="row qt_border">
    	<ifvm:inputNew type="text" className="seq_stamp" required="true" label="E00065" labelClass="2" conClass="1" readonly="true" values="${'${'}stampSeq}" />
		<label class="col-xs-5 control-label"><spring:message code="E00066"/></label>
		<div class="col-xs-2 control_content">
			<select class="stcd_stamp">
				<option value="E01"><spring:message code="E00083"/></option>
				<option value="E02" {{if stampTypeCd == "E02"}} selected{{/if}}><spring:message code="E00084"/></option>
				<option value="E03" {{if stampTypeCd == "E03"}} selected{{/if}}><spring:message code="E00085"/></option>
			</select>
		</div> 
	</div>

	<div class="row qt_border">
		<label class="col-xs-2 control-label"><spring:message code="E00067"/></label>
		<div class="col-xs-2">
			<div class="col-xs-8 control_content">
				<input type="text" class="cnt_stamp" required="true" maxlength="3" title="" value="${'${'}stampCnt}">
			</div>
			<div class="col-xs-4 control_content side_text"><spring:message code="E00068"/> /</div>
		</div>
		<div class="col-xs-1 control_content">
			<input type="text" class="period_stamp" required="true" maxlength="3" title="" value="${'${'}stampPeriod}">
		</div>
		<div class="col-xs-2">
			<div class="col-xs-8 control_content">
				<select class="spcd_stamp">
					<option value="E01"><spring:message code="E00086"/></option>
					<option value="E02" {{if stampPeriodCd == "E02"}} selected{{/if}}><spring:message code="E00087"/></option>
					<option value="E03" {{if stampPeriodCd == "E03"}} selected{{/if}}><spring:message code="E00088"/></option>
				</select>
			</div>
			<div class="col-xs-4 control_content side_text text_right">/ <spring:message code="E00028"/></div>
		</div>
		<div class="col-xs-2">
			<div class="col-xs-8 control_content">
				<input type="text" class="totcnt_stamp" required="true" maxlength="3" title="" value="${'${'}totStampCnt}">
			</div>
			<div class="col-xs-4 control_content side_text"><spring:message code="E00068"/></div>
		</div>
	</div>

	<div class="row qt_border">
		<label class="col-xs-2 control-label"><spring:message code="E00074"/></label>
		<div class="col-xs-2">
			<div class="col-xs-8 control_content">
				<input type="text" class="givecnt_stamp" required="true" maxlength="3" title="" value="${'${'}stampGiveCnt}">
			</div>
			<div class="col-xs-4 control_content side_text"><spring:message code="E00068"/> /</div>
		</div>
		<div class="col-xs-1 control_content">
			<input type="text" class="givecrit_stamp" required="true" maxlength="3" title="" value="${'${'}stampGiveCriteria}">
		</div>
		<div class="col-xs-2">
			<div class="col-xs-8 control_content">
				<select class="gccd_stamp"> 
					<option value="E01">원</option>
					<option value="E02" {{if stampGiveCriteriaCd == "E02"}} selected{{/if}}><spring:message code="E00088"/></option>
					<option value="E03" {{if stampGiveCriteriaCd == "E03"}} selected{{/if}}><spring:message code="E00089"/></option>
				</select>
			</div>
		</div>
	</div>
    <div class="row block_btn_area">
    	<div class="control_content text-right">
			<ifvm:inputNew type="button" text="L00029" btnType="minus" className="remove_stamp"/>
		</div>	
	</div>
</div>
</script>


<div id="dialogPopupWrap">
    <div class="pop_inner_wrap">
        <div id="campaignStampInfoPop">
        	<div class="page_btn_area">
        		<div class="col-xs-7">스탬프 설정</div>
        	</div>
        	<div class="well form-horizontal row_part_line">
				<div class="row qt_border">
	                <%-- 비활성별점 --%>
	                <label class="col-xs-2 control-label"><spring:message code="E00076"/></label>
		        	<div class="col-xs-4 control_content">
		                <%-- 비활성별점 이미지 --%>
	                	<div class="input-group file">
							<form id="inactiveStampAjaxform" method="post" enctype="multipart/form-data">
								<ifvm:input type="file" id="inactiveStampHideFile" names="inactiveStampHideFile"/>
							</form>
							<ifvm:input type="text" id="inactiveStampFileValue" readonly="true" />
							<span class="pos_r">
								<a class="btn btn_sm btn_blueLight ifileBtn authCretBtn" id='inactiveStampFileUploaderBtn'><spring:message code="I02034" /></a>
							</span>
						</div>							
		            </div>
	            	<%-- 활성별점 --%>
	                <label class="col-xs-2 control-label"><spring:message code="E00077"/></label>
	                <div class="col-xs-4 control_content">
		                <%-- 활성별점 이미지 --%>
	                	<div class="input-group file">
							<form id="activeStampAjaxform" method="post" enctype="multipart/form-data">
								<ifvm:input type="file" id="activeStampHideFile" names="activeStampHideFile"/>
							</form>
							<ifvm:input type="text" id="activeStampFileValue" readonly="true" />
							<span class="pos_r">
								<a class="btn btn_sm btn_blueLight ifileBtn authCretBtn" id='activeStampFileUploaderBtn'><spring:message code="I02034" /></a>
							</span>
						</div>			                    
	                </div>		                
	            </div>
	            <div class="row qt_border row_uploadfile_preview">
	            	<label class="col-xs-2 control-label"></label>
	            	<%-- 미리보기 이미지 --%>
					<div class="col-xs-4 control_content text-left">
						<div class="input-group file"><div id='inactiveStampShowImg'></div></div>
					</div>
					
					<label class="col-xs-2 control-label"></label>
	            	<%-- 미리보기 이미지 --%>
					<div class="col-xs-4 control_content text-left">
						<div class="input-group file"><div id='activeStampShowImg'></div></div>
					</div>
	            </div>
	            
	            <div class="row qt_border">
	            	<%-- 이미지문구 --%>
	                <label class="col-xs-2 control-label"></label>
	                <div class="col-xs-6 control_content text-left"><span class="asterisk"><spring:message code="E00078"/></span></div>
	        	</div>	        	
        	</div>
        	<div class="page_btn_area">
        		<div class="col-xs-7">스탬프 지급 조건 설정</div>
        		<div class="col-xs-5 searchbtn_r">
        			<ifvm:inputNew type="button" text="C00085" btnType="plus" btnFunc="addStampItem"/>
        		</div>
        	</div>
        	<div id="stampWrap" class="stamp_wrap">
        	</div>
        </div>
    </div>
    <div class="pop_btn_area">
   		<ifvm:inputNew type="button" id="campaignStampInfoPopSaveBtn" className="btn_gray" btnType="save" text="M00280" />
        <ifvm:inputNew type="button" id="campaignStampInfoPopCancelBtn" className="btn_lightGray2 cancel" text="M00441" />
    </div>
</div>

<div id="programPop" class="popup_container"></div>
<div id="intactTypePopup" class="popup_container"></div>
<div id="planPopup" class="popup_container"></div>
<div id="parCamPopup" class="popup_container"></div>
