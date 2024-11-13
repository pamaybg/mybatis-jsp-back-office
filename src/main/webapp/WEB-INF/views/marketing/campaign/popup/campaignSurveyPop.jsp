<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
/* 일시적으로 숨김 처리 함 */
.temporarilyHide { display: none; }
/* 설문 전체 wrap */
.survey_wrap {
	max-height: 250px;
	overflow-y: auto;
}
</style>

<script>

//model
var campaignSurveyInfo;
//dialog
var planPop;
//validation
var campaignSurveyInfoPopValidation;

//model 정의
function initModels(data) {
    var infoModel = function(data) {
        //data set
        this.camDefaultInfo = data;
        //캠페인아이디
        this.camDefaultInfo.ridCam = campaign.id;
        //기획자 Account Id
        this.camDefaultInfo.accountId = $.ifvmGetUserInfo().accountId;

        campaignSurveyInfo = this;
    };
    
    //konckout bindings
    ko.applyBindings(new infoModel(data), document.getElementById("campaignB2CInfoPop") );
}

//캠페인기본정보 저장
function saveCampaignSurveyInfo() {

	var sWrap = $('#surveyWrap');
	var surveyVali = sWrap.ifvValidation();
	if(surveyVali.confirm() == false) return;
	
	campaignSurveyInfo.camDefaultInfo.rows = [];

	var itemCnt = sWrap.children('.form-horizontal').length;
	for(var i = 0; i < itemCnt; i++) {
		var indItem = $(sWrap.children('.form-horizontal')[i]);
		var itemObj = {};
		indItem.questionSeq = indItem.find('.seq_survey').val();
		
		indItem.duplicationFlg = indItem.find('.dup_survey').val();
		indItem.questionDesc = indItem.find('.ques_survey').val();
		indItem.answer1 = indItem.find('.ans1_survey').val();
		indItem.answer2 = indItem.find('.ans2_survey').val();
		indItem.answer3 = indItem.find('.ans3_survey').val();
		indItem.answer4 = indItem.find('.ans4_survey').val();
		indItem.rid = indItem.attr('data-rid');
		
		campaignSurveyInfo.camDefaultInfo.rows.push(indItem);
	}
	
	//상세일 경우 ridCam 필요
	campaignSurveyInfo.camDefaultInfo.ridCam = campaign.id;
	
	//통신필요
    $.ifvSyncPostJSON('<ifvm:action name="saveCampaignSurveyInfo"/>', campaignSurveyInfo.camDefaultInfo, function(result) {
       alert('<spring:message code="M00152" />');
       //close popup
       closeCampaignSurveyInfoPop();
   	});
    
}

//캠페인기본정보 팝업 설정
function campaignSurveyInfoInit() {
    //pageSetUp();

    //번호
    //$.fn.ifvmSetSelectOptionCommCode("seqNoType", "SEQ_NO_TYPE", null, null, true);
    
    //팝업설정
    cDialog.model.title = '<spring:message code="E00054"/>';
    $("#dialog_title").append('<spring:message code="E00054"/>');
    cDialog.model.width = "750";
    cDialog.model.close = "closeCampaignSurveyInfoPop";

    //validation
    campaignSurveyInfoPopValidation = $("#campaignSurveyInfoPop").ifvValidation();
}


//캠페인기본정보 팝업 데이터 설정
function campaignSurveyInfoInitData() {
    campaignSurveyInfo = {camDefaultInfo: {}};

    //set task type
    diagram._selectedObject.taskType = "INFO";
    
    //캠페인 ID
    var id = diagram._selectedObject.campaignId;
    
    //캠페인기본정보 호출
    $.ifvSyncPostJSON('<ifvm:action name="getCampaignSurveyInfo"/>', {
    	ridCam: id
    },
    function(result) {
        if ($.fn.ifvmIsNotEmpty(result)){
            campaignSurveyInfo.camDefaultInfo.rows = result;
            
        	var temp = $("#surveyTmpl").tmpl(result);
        	$('#surveyWrap').append(temp);

        	setRemoveSurveyBtnEvent();            
        } else {
        	var emptyObj = {
    				duplicationFlg: ""
    				, questionDesc: ""
    				, answer1: ""
    				, answer2: ""
    				, answer3: ""
    				, answer4: ""
    				, rid: ""
    			}
    		
    		emptyObj.questionSeq = $('#surveyWrap').children('.form-horizontal').length + 1;
    		
    		var temp = $("#surveyTmpl").tmpl(emptyObj);
    		$('#surveyWrap').append(temp);
    		setRemoveSurveyBtnEvent();        	
        }
    });

    initModels(campaignSurveyInfo.camDefaultInfo);
}

// dialog close
function closeCampaignSurveyInfoPop(args) {
    campaignSurveyInfo = {};
    //dialog 파괴
    cDialog._destroy();
}

function addSurveyItem() {
	var itemCnt = $('#surveyWrap').children('.form-horizontal').length;
	if(itemCnt > 9) {
		alert('<spring:message code="E00081"/>');
		return false;
	} else {
		var emptyObj = {
				duplicationFlg: ""
				, questionDesc: ""
				, answer1: ""
				, answer2: ""
				, answer3: ""
				, answer4: ""
				, rid: ""
			}
		
		emptyObj.questionSeq = $('#surveyWrap').children('.form-horizontal').length + 1;
		
		var temp = $("#surveyTmpl").tmpl(emptyObj);
		$('#surveyWrap').append(temp);
		setRemoveSurveyBtnEvent();
	}
}

function setRemoveSurveyBtnEvent() {
	$('.remove_survey').off().on('click', function() {
		var itemCnt = $('#surveyWrap').children('.form-horizontal').length;
		if(itemCnt < 2) {
			alert('<spring:message code="E00080"/>');
			return false;
		} else {
			$(this).parents('.form-horizontal').remove();
			for(var i = 0; i < itemCnt-1; i++) {
				$('.seq_survey')[i].value = i + 1;
			}
		}
	});	
}

$(function () {

    //캠페인기본정보 폼 설정
    campaignSurveyInfoInit();

    //캠페인기본정보 데이터
    campaignSurveyInfoInitData();

    //저장 클릭시
     $('#campaignSurveyInfoPopSaveBtn').on('click', function(){
         saveCampaignSurveyInfo();
     });

    //취소 클릭시
    $('#campaignSurveyInfoPopCancelBtn').on('click', function(){
        closeCampaignSurveyInfoPop();
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

<script id="surveyTmpl" type="text/x-jquery-tmpl">
<div class="well form-horizontal row_part_line" data-rid="${'${'}rid}">
	<div class="row qt_border">
        <ifvm:inputNew type="text" className="seq_survey" required="true" values="${'${'}questionSeq}" label="E00055" labelClass="1" conClass="1" readonly="true"/>
	
	    <label class="col-xs-8 control-label text-right"><spring:message code="E00056"/></label>
		<div class="col-xs-2 control_content">
			<select class="dup_survey">
				<option value="0"><spring:message code="E00057"/></option>
				<option value="1" {{if duplicationFlg == 1}} selected {{/if}}><spring:message code="E00058"/></option>
			</select>
		</div>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" label="E00059" className="ques_survey" maxLength="50" required="true" labelClass="1" conClass="11" values="${'${'}questionDesc}" />
	</div>
	<div class="row qt_border">
        <ifvm:inputNew type="text" label="E00060" className="ans1_survey" maxLength="50" required="true" labelClass="2" conClass="10" values="${'${'}answer1}" />
        <ifvm:inputNew type="text" label="E00061" className="ans2_survey" maxLength="50" required="true" labelClass="2" conClass="10" values="${'${'}answer2}" />
        <ifvm:inputNew type="text" label="E00062" className="ans3_survey" maxLength="50" required="true" labelClass="2" conClass="10" values="${'${'}answer3}" />
        <ifvm:inputNew type="text" label="E00063" className="ans4_survey" maxLength="50" required="true" labelClass="2" conClass="10" values="${'${'}answer4}" />
	</div>
	
	<div class="row block_btn_area">
		<div class="control_content text-right">
			<ifvm:inputNew type="button" text="L00029" btnType="minus" className="remove_survey"/>
		</div>	
	</div> 	
</div>
</script>

<div id="dialogPopupWrap">
    <div class="pop_inner_wrap">
        <div id="campaignSurveyInfoPop">
        	<div class="page_btn_area">
        		<div class="col-xs-7"></div>
        		<div class="col-xs-5 searchbtn_r">
        			<ifvm:inputNew type="button" text="C00085" btnType="plus" btnFunc="addSurveyItem"/>
        		</div>
        	</div>
        	<div id="surveyWrap" class="survey_wrap">
        		
        	</div>
        </div>
    </div>
    <div class="pop_btn_area">
		<ifvm:inputNew type="button" id="campaignSurveyInfoPopSaveBtn" className="btn_gray" btnType="save" text="M00280" />
        <ifvm:inputNew type="button" id="campaignSurveyInfoPopCancelBtn" className="btn_lightGray2 cancel" text="M00441" />
    </div>
</div>

<div id="programPop" class="popup_container"></div>
<div id="intactTypePopup" class="popup_container"></div>
<div id="planPopup" class="popup_container"></div>
<div id="parCamPopup" class="popup_container"></div>

<script>
//$(document).ready(function() {
	//getDetailYN();
//});

function getDetailYN() {
// 	$.ifvPostJSON('url', {params: params}, function(result) {
//      success callback
//		surveyDefaultSetting(result.isDetail);
// 	}, function(result) {
//      error callback, 필요시 사용		
// 	});


	var isDetail = true;
	//var isDetail = false;
	surveyDefaultSetting(isDetail);
}

function surveyDefaultSetting(isDetail) {
	$('#surveyWrap').empty();
	
	var dummyObj = [];
	
	//dummy
	if(isDetail) {
		dummyObj =  [
			{
				seqNoType: "1"
				, duplicationFlg: "1"
				, questionDesc: "questionDesc1"
				, answer1: "1"
				, answer2: "2"
				, answer3: "3"
				, answer4: "4"
				, rid: "asdfasdf"
			}
			, {
				seqNoType: "2"
				, duplicationFlg: "0"
				, questionDesc: "questionDesc2"
				, answer1: "1"
				, answer2: "2"
				, answer3: "3"
				, answer4: "4"
				, rid: "asdfasdf"
			}
			, {
				seqNoType: "3"
				, duplicationFlg: "1"
				, questionDesc: "questionDesc3"
				, answer1: "1"
				, answer2: "2"
				, answer3: "3"
				, answer4: "4"
				, rid: "asdfasdf"
			}
			, {
				seqNoType: "4"
				, duplicationFlg: "0"
				, questionDesc: "questionDesc4"
				, answer1: "1"
				, answer2: "2"
				, answer3: "3"
				, answer4: "4"
				, rid: "asdfasdf"
			}
			, {
				seqNoType: "5"
				, duplicationFlg: "1"
				, questionDesc: "questionDesc5"
				, answer1: "1"
				, answer2: "2"
				, answer3: "3"
				, answer4: "4"
				, rid: "asdfasdf"
			}
		]

	} else {
		dummyObj = [
			{
				seqNoType: "1"
				, duplicationFlg: ""
				, questionDesc: ""
				, answer1: ""
				, answer2: ""
				, answer3: ""
				, answer4: ""
				, rid: ""
			}
		]
	}

	var temp = $("#surveyTmpl").tmpl(dummyObj);
	$('#surveyWrap').append(temp);

	setRemoveSurveyBtnEvent();
}


function saveSurvey() {

}

</script>