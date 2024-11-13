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
var campaignEntryInfo;
//dialog
var planPop;
//validation
var campaignEntryInfoPopValidation;

//model 정의
function initModels(data) {
    var infoModel = function(data) {

        //data set
        this.camDefaultInfo = data;
        //캠페인아이디
        this.camDefaultInfo.ridCam = campaign.id;
        //기획자 Account Id
        this.camDefaultInfo.accountId = $.ifvmGetUserInfo().accountId;
        
        campaignEntryInfo = this;
    };
    
    //konckout bindings
    ko.applyBindings(new infoModel(data), document.getElementById("campaignB2CInfoPop") );
}

//캠페인기본정보 저장
function saveCampaignEntryInfo() {

    campaignEntryInfo.camDefaultInfo.loginFlg = $("input:checkbox[id='loginFlg']").is(":checked") ? "1" : "0";
    campaignEntryInfo.camDefaultInfo.replyMethodCd = $('input:radio[name="replyMethodCd"]:checked').val();
    campaignEntryInfo.camDefaultInfo.starPntFlg = $("input:checkbox[id='starPntFlg']").is(":checked") ? "1" : "0";
    campaignEntryInfo.camDefaultInfo.halfStarPntFlg = $("input:checkbox[id='halfStarPntFlg']").is(":checked") ? "1" : "0";
    campaignEntryInfo.camDefaultInfo.rid = $("#rid").val();
    
    $.ifvSyncPostJSON('<ifvm:action name="saveCampaignEntryInfo"/>', campaignEntryInfo.camDefaultInfo, function(result) {
        alert('<spring:message code="M00152" />');
        //close popup
        closeCampaignEntryInfoPop();
    });
}

//캠페인기본정보 팝업 설정
function campaignEntryInfoInit() {
    pageSetUp();

    //응모조건
    $.fn.ifvmSetSelectOptionCommCode("applyCriteriaCd", "APPLY_CRITERIA_CD", null, null, true);
    
    //팝업설정
    cDialog.model.title = '<spring:message code="E00037"/>';
    $("#dialog_title").append('<spring:message code="E00037"/>');
    cDialog.model.width = "750";
    cDialog.model.close = "closeCampaignEntryInfoPop";

    //validation
    campaignEntryInfoPopValidation = $("#campaignEntryInfoPop").ifvValidation();
    
	$('#buttonFileUploaderBtn').click(function(){
		$("#buttonHideFile").trigger("click");
	});
	
	$('#inactiveStarFileUploaderBtn').click(function(){
		$("#inactiveStarHideFile").trigger("click");
	});
    
	$('#activeStarFileUploaderBtn').click(function(){
		$("#activeStarHideFile").trigger("click");
	});
}

//캠페인기본정보 팝업 데이터 설정
function campaignEntryInfoInitData() {
    campaignEntryInfo = {camDefaultInfo: {}};

    //set task type
    diagram._selectedObject.taskType = "ENTRY";

    //캠페인 ID
    var id = diagram._selectedObject.campaignId;

    //캠페인기본정보 호출
    $.ifvSyncPostJSON('<ifvm:action name="getCampaignEntryInfo"/>', {
    	ridCam: id
    },
    function(result) {
        if ($.fn.ifvmIsNotEmpty(result)){
            campaignEntryInfo.camDefaultInfo = result;
            
            $("#rid").val(result.rid);
            
            $("input:checkbox[id='loginFlg']").attr("checked", (result.loginFlg == "1"));
            $('input[name=replyMethodCd][value=' + result.replyMethodCd + ']').prop('checked', true);
            $("input:checkbox[id='starPntFlg']").attr("checked", (result.starPntFlg == "1"));
            $("input:checkbox[id='halfStarPntFlg']").attr("checked", (result.halfStarPntFlg == "1"));
            
            $('#buttonShowImg').empty().append($('<img/>').attr('src',result.buttonImgUrl));
            $('#inactiveStarShowImg').empty().append($('<img/>').attr('src',result.inactiveStarImgUrl));
            $('#activeStarShowImg').empty().append($('<img/>').attr('src',result.activeStarImgUrl));
        }
    });

    initModels(campaignEntryInfo.camDefaultInfo);
}

// dialog close
function closeCampaignEntryInfoPop(args) {
    campaignEntryInfo = {};
    //konckout bindings stop
    ko.virtualElements.allowedBindings.stopBinding = true;

    //dialog 파괴
    cDialog._destroy();
}

function buttonHandleFileSelect(evt) {

	var files = evt.target.files;
	if( files !== undefined ){
		var f = files[0];
		if(!f.type.match("png.*")) {
	    	return;
	    }

       var reader = new FileReader();
       reader.onload = function (e) {

           var formData = new FormData();
 			formData.append("file", $("#buttonHideFile")[0].files[0]);

			$.ifvFilePostJSON('<ifvm:action name="tempUpload"/>', formData,
  				function(data){
		    		campaignEntryInfo.camDefaultInfo.buttonImageFile = data[0].url;
		    		campaignEntryInfo.camDefaultInfo.buttonImageFileName = data[0].name;
		    		campaignEntryInfo.camDefaultInfo.buttonOriName = data[0].oriName;
   				}
 			);

          $('#buttonFileValue').val(f.name);
          $('#buttonShowImg').empty().append($('<img/>').attr('src',e.target.result));
          
        };
    	reader.readAsDataURL(f);
	}
}

function inactiveStarHandleFileSelect(evt) {

	var files = evt.target.files;
	if( files !== undefined ){
		var f = files[0];
		if(!f.type.match("image.*")) {
	    	return;
	    }

       var reader = new FileReader();
       reader.onload = function (e) {

           var formData = new FormData();
 			formData.append("file", $("#inactiveStarHideFile")[0].files[0]);

			$.ifvFilePostJSON('<ifvm:action name="tempUpload"/>', formData,
  				function(data){
		    		campaignEntryInfo.camDefaultInfo.inactiveStarImageFile = data[0].url;
		    		campaignEntryInfo.camDefaultInfo.inactiveStarImageFileName = data[0].name;
		    		campaignEntryInfo.camDefaultInfo.inactiveStarOriName = data[0].oriName;
   				}
 			);

          $('#inactiveStarFileValue').val(f.name);
          $('#inactiveStarShowImg').empty().append($('<img/>').attr('src',e.target.result));
          
        };
    	reader.readAsDataURL(f);
	}
}

function activeStarHandleFileSelect(evt) {

	var files = evt.target.files;
	if( files !== undefined ){
		var f = files[0];
		if(!f.type.match("image.*")) {
	    	return;
	    }

       var reader = new FileReader();
       reader.onload = function (e) {

           var formData = new FormData();
 			formData.append("file", $("#activeStarHideFile")[0].files[0]);

			$.ifvFilePostJSON('<ifvm:action name="tempUpload"/>', formData,
  				function(data){
		    		campaignEntryInfo.camDefaultInfo.activeStarImageFile = data[0].url;
		    		campaignEntryInfo.camDefaultInfo.activeStarImageFileName = data[0].name;
		    		campaignEntryInfo.camDefaultInfo.activeStarOriName = data[0].oriName;
   				}
 			);

          $('#activeStarFileValue').val(f.name);
          $('#activeStarShowImg').empty().append($('<img/>').attr('src',e.target.result));
          
        };
    	reader.readAsDataURL(f);
	}
}

$(function () {

    //캠페인기본정보 폼 설정
    campaignEntryInfoInit();

    //캠페인기본정보 데이터
    campaignEntryInfoInitData();

    //저장 클릭시
    $('#campaignEntryInfoPopSaveBtn').on('click', function(){
        saveCampaignEntryInfo();
    });

    //취소 클릭시
    $('#campaignEntryInfoPopCancelBtn').on('click', function(){
        closeCampaignEntryInfoPop();
    });

    setTimeout(function() {
        //popup 높이 맞추기
        new ifvm.PopupHeight({
            popupDivId : 'dialog',
            contentsId : 'dialogPopupWrap'
        });

        cDialog.refresh();
    }, 1000);
    
	$("#buttonHideFile").on("change", function(e){
		buttonHandleFileSelect(e);
	});
	
	$("#inactiveStarHideFile").on("change", function(e){
		inactiveStarHandleFileSelect(e);
	});
	
	$("#activeStarHideFile").on("change", function(e){
		activeStarHandleFileSelect(e);
	});
	
});
</script>
<style type="text/css">
.input-group.file input[type="file"]{display:none;}
</style>
<div id="dialogPopupWrap">
    <div class="pop_inner_wrap">
        <div id="campaignEntryInfoPop">
        <ifvm:input type="hidden" id="rid" names="rid" />
        
        	<div class="well form-horizontal">
	            <div class="row qt_border">
	                <%-- 응모조건 --%>
	                <label class="col-xs-2 control-label text-right"><spring:message code="E00038"/></label>
	                <div class="col-xs-4 control_content">
	                    <ifvm:input type="select" id="applyCriteriaCd" names="applyCriteriaCd" required="true" dataBind="value: camDefaultInfo.applyCriteriaCd" />
	                </div>
	                
	                <%-- 로그인확인여부 --%>
	                <label class="col-xs-2 control-label text-right"><spring:message code="E00039"/></label>
	                <div class="col-xs-1 control-label text-left">
	                    <ifvm:input type="checkbox" id="loginFlg"/>
	                </div>
	            </div>
	        </div>    
            <div class="form-horizontal">
        		<div class="page_btn_area"><spring:message code="E00040"/></div>
	           	<div class="well underline form-horizontal">
		            <div class="row qt_border">
		                <%-- 버튼이미지 --%>
		                <label class="col-xs-2 control-label"><spring:message code="E00041"/></label>
		                <div class="col-xs-4 control_content">
		                	<div class="input-group file">
								<form id="buttonAjaxform" method="post" enctype="multipart/form-data">
									<ifvm:input type="file" id="buttonHideFile" names="buttonHideFile"/>
								</form>
								<ifvm:input type="text" id="buttonFileValue" readonly="true" />
								<span class="pos_r">
									<a class="btn btn_sm btn_blueLight ifileBtn authCretBtn" id='buttonFileUploaderBtn'><spring:message code="I02034" /></a>
								</span>
							</div>
		                </div>
		            </div>
		        	<div class="row qt_border row_uploadfile_preview">
		        		<div class="col-xs-2 control-label"></div>
		                <%-- 미리보기 이미지 --%>
						<div class="col-xs-4 control_content text-left">
							<div class="input-group file"><div id='buttonShowImg'></div></div>
						</div>			                
		            </div>
		            <div class="row qt_border">
		            	<%-- 이미지문구 --%>
		                <label class="col-xs-2 control-label"></label>
		                <div class="col-xs-4 control_content text-left"><span class="asterisk"><spring:message code="E00042"/></span></div>
		        	</div> 
		        </div> 
		    </div>    
		    
	        <div class="form-horizontal">    
            	<div class="page_btn_area"><spring:message code="E00043"/></div>
	            <div class="well underline form-horizontal">
	            	<div class="row qt_border">
	            		<%-- 댓글방식 --%>
		            	<label class="col-xs-2 control-label"><spring:message code="E00044"/></label>
						<div class="col-xs-4 control_content">
								<label class="radio-inline">
									<ifvm:input type="radio" names="replyMethodCd" id="replyMethodCd_E01" values="E01" checked="true"/>
									<spring:message code="E00043"/>
								</label>
																			<label class="radio-inline">
									<ifvm:input type="radio" names="replyMethodCd" id="replyMethodCd_E02" values="E02" />
									<spring:message code="E00045"/>
								</label>
						</div>    
						
		                <%-- 최대댓글글자수 --%>
		                <label class="col-xs-2 control-label"><spring:message code="E00046"/></label>
		                <div class="col-xs-1 control_content">
		                    <ifvm:input type="number" id="replyMaxLength" maxLength="6" dataBind="value: camDefaultInfo.replyMaxLength" />
		                </div>       
		                <div class="col-xs-1 control_content"><spring:message code="E00047"/></div>					        	
	            	</div>
	            	
	            	<div class="row qt_border">
	            		<%-- 별점여부 --%>
						<label class="col-xs-2 control-label"><spring:message code="E00048"/></label>
						<div class="col-xs-1 control_content text-left">
							<input type="checkbox" id="starPntFlg">
						</div>
						
		                <%-- 최대별점점수 --%>
		                <label class="col-xs-2 control-label"><spring:message code="E00049"/></label>
		                <div class="col-xs-1 control_content">
		                    <ifvm:input type="number" id="maxStarPnt" maxLength="3" dataBind="value: camDefaultInfo.maxStarPnt" />
		                </div>       
		                <div class="col-xs-1 control_content"><spring:message code="E00050"/></div>		
		                
		                <%-- 0.5점 적용 --%>
						<label class="col-xs-1 control-label"><spring:message code="E00051"/></label>
						<div class="col-xs-1 control_content text-left">
							<input type="checkbox" id="halfStarPntFlg">
						</div>
					</div>
					
		            <div class="row qt_border">
		                <%-- 비활성별점 --%>
		                <label class="col-xs-2 control-label"><spring:message code="E00052"/></label>
			        	<div class="col-xs-4 control_content">
			                <%-- 비활성별점 이미지 --%>
		                	<div class="input-group file">
								<form id="inactiveStarAjaxform" method="post" enctype="multipart/form-data">
									<ifvm:input type="file" id="inactiveStarHideFile" names="inactiveStarHideFile"/>
								</form>
								<ifvm:input type="text" id="inactiveStarFileValue" readonly="true" />
								<span class="pos_r">
									<a class="btn btn_sm btn_blueLight ifileBtn authCretBtn" id='inactiveStarFileUploaderBtn'><spring:message code="I02034" /></a>
								</span>
							</div>							
			            </div>
		            	<%-- 활성별점 --%>
		                <label class="col-xs-2 control-label"><spring:message code="E00053"/></label>
		                <div class="col-xs-4 control_content">
			                <%-- 활성별점 이미지 --%>
		                	<div class="input-group file">
								<form id="activeStarAjaxform" method="post" enctype="multipart/form-data">
									<ifvm:input type="file" id="activeStarHideFile" names="activeStarHideFile"/>
								</form>
								<ifvm:input type="text" id="activeStarFileValue" readonly="true" />
								<span class="pos_r">
									<a class="btn btn_sm btn_blueLight ifileBtn authCretBtn" id='activeStarFileUploaderBtn'><spring:message code="I02034" /></a>
								</span>
							</div>			                    
		                </div>		 		
		            </div>
		            <div class="row qt_border row_uploadfile_preview">
		            	<label class="col-xs-2 control-label"></label>
		            	<%-- 미리보기 이미지 --%>
						<div class="col-xs-4 control_content text-left">
							<div class="input-group file"><div id='inactiveStarShowImg'></div></div>
						</div>
						
						<label class="col-xs-2 control-label"></label>
		            	<%-- 미리보기 이미지 --%>
						<div class="col-xs-4 control_content text-left">
							<div class="input-group file"><div id='activeStarShowImg'></div></div>
						</div>
		            </div>
		            
		            <div class="row qt_border">
		            	<%-- 이미지문구 --%>
		                <label class="col-xs-2 control-label"></label>
		                <div class="col-xs-6 control_content text-left"><span class="asterisk"><spring:message code="E00042"/></span></div>
		        	</div>	
		        </div>
		    </div>    	            				            
        </div>
    </div>
    <div class="pop_btn_area">
        <%-- 저장 --%>
        <button class="btn btn-sm btn_gray" id="campaignEntryInfoPopSaveBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00280"/>
        </button>
        <%-- 닫기 --%>
        <button class="btn btn-sm btn_lightGray2 cancel" id="campaignEntryInfoPopCancelBtn">
            <spring:message code="M00441"/>
        </button>
    </div>
</div>

<div id="programPop" class="popup_container"></div>
<div id="intactTypePopup" class="popup_container"></div>
<div id="planPopup" class="popup_container"></div>
<div id="parCamPopup" class="popup_container"></div>