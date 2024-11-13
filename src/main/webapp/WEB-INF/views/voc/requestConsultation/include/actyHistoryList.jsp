<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>

<script>
var actyHistoryGrid;
var data = {};

function actyHistoryList(){
	var ejGridOption = {
		rowSelected : function (data) {
	    	actyHistoryData = null;
	    	actyHistoryData = data;
	    	console.log(data);
	    	if(data.atvyTypeCd == '20' || data.atvyTypeCd == '70' || data.atvyTypeCd == '30'){//메일
				$("#smsBtn").prop('disabled',true);
				$("#emailBtn").prop('disabled',false);
	    	}else if(data.atvyTypeCd == '40'||data.atvyTypeCd == 'S'){//sms
	    		$("#smsBtn").prop('disabled',false);
				$("#emailBtn").prop('disabled',true);
	    	}

	    	$("#msgBtn").attr("disabled",false);
		},
		serializeGridData : function( data ){
			if(rid != "null"){
				data.ridSvcReq = rid;
			}
		},
	 	loadComplete : function(data) {
	 		if(opener){
	 			opener.parent.setParentIframeHeight();
	 		}else{
	 			parent.setParentIframeHeight();
	 		}
		},
		dataUrl : '<ifvm:action name="getActyHistoryList"/>',

        columns : [
        	{
      		  field : 'atvyType', headerText : '유형', headerTextAlign : 'center', width:'80px' ,textAlign : 'center', customAttributes :{index : 'atvyType'}
      	  },{
    		  field : 'sbst', headerText : '내용', headerTextAlign : 'center', textAlign : 'left',  width:'300px' ,customAttributes :{searchable : true}
    	  },{
    		  field : 'actCreatedDt', headerText : '등록일자', textAlign : 'center',width:'170px' , headerTextAlign : 'center'
    	  },{
    		  field : 'cuserId', headerText : '<spring:message code="V00071"/>',width:'180px' , headerTextAlign : 'center', textAlign : 'left' ,format : '{0:n0}', customAttributes :{searchable : true, index : 'a.CREATOR_LOGIN'}
    	  },{
    		  field : 'chnlSendDt', headerText : '전송일자',width:'190px' ,headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'chnlSendDt'}
    	  },{
    		  field : 'chnlRpyRsn', headerText : '<spring:message code="V00286"/>',width:'90px',headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'chnlRpyRsn'} 
    	  },{
    		  field : 'chnlRpyDt', headerText : '응답일자',width:'170px',headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'chnlRpyDt'}
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  },{
    		  field : 'atvyTypeCd', headerText : 'atvyTypeCd',visible : false 
    	  },{
    		  field : 'msgSubject', headerText : 'msgSubject',visible : false 
    	  }
        ],

        requestGridData : {
      	  sidx : '5',
      	  sord : 'desc',
        },
        radio: true,	
    };
	
	actyHistoryGrid = $("#actyHistoryList").ifvsfGrid({ ejGridOption : ejGridOption });
}

//활동내역 신규
function clickNewActyBtn(){
	if($("#detail_srNo").val() != ""){
		$("#actyHistoryPop").ifvsfPopup({
	       enableModal : true,
		   enableResize: false,
		   contentUrl: '<ifvm:url name="newActyHistoryPop"/>',
		   contentType: "ajax",
		   title: "<spring:message code='V00070'/>",
		   width: 600,
		   close : 'actyHistoryPopClose'
		});
	}else{
		alert('<spring:message code="V00135"/>');
	}
}

//활동내역 신규 팝업 닫기
function actyHistoryPopClose() {
	actyHistoryPop._destroy();
}

//활동내역 이메일 전송
function clickActyEmailBtn(){
	var checkedList = actyHistoryGrid.opt.gridControl.getSelectedRecords()[0];

	if($.fn.ifvmIsEmpty(checkedList)){
		alert('<spring:message code="V00139"/>'); //활동내역 목록을 선택해주세요.
	}else{
		var checkedObj = checkedList;
		if(checkedObj.atvyTypeCd != '20' && checkedObj.atvyTypeCd != '70' && checkedObj.atvyTypeCd != '30'){
			alert('<spring:message code="V00137"/>'); //활동유형이 일치하지 않습니다.
		}else if($("#detail_email").val() == ""){
			alert('<spring:message code="V00140"/>'); //email을 입력해주세요.
		}else if($("#detail_email").val().indexOf("*") > 0){
			alert('<spring:message code="V00199"/>'); //마스킹을 해제하세요.
		} else if(checkedObj.chnlSendDt != null){
			alert('<spring:message code="V00288"/>'); //해당 활동내역을 이미 전송하였습니다.
		} else{
			var tData = null;
			var tChnlType = null;
			if(checkedObj.atvyTypeCd == '20' || checkedObj.atvyTypeCd == '70'){
				//활동유형이 email 일 때
				tChnlType = "email";
				if(opener){
					tData = {
							chnlType : tChnlType,
							msgType : "S001",
							mbrNo : $("#memNo").val(),
							ridMbr : $("#ridMbr").val(),
							ridCust : $("#detail_ridCust").val(),
							emailAddr : $("#detail_email").val(),
							comment : actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].sbst,
							creatorLogin : $.ifvmGetUserInfo().userId,
							ridVocReq : rid,
							senderEmail : "e1@e1.co.kr",
							emailTitle : actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].msgSubject,
							actyRid : actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].rid,
							insertFlag : '1'
						};
				}else{
					tData = {
							chnlType : tChnlType,
							msgType : "S001",
							mbrNo : $("#detail_memNo").val(),
							ridMbr : $("#detail_memRid").val(),
							ridCust : $("#detail_ridCust").val(),
							emailAddr : $("#detail_email").val(),
							comment : actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].sbst,
							creatorLogin : $.ifvmGetUserInfo().userId,
							ridVocReq : rid,
							senderEmail : "e1@e1.co.kr",
							emailTitle : actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].msgSubject,
							actyRid : actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].rid,
							insertFlag : '1'
						};
				}


			}else if(checkedObj.atvyTypeCd == '30'){
				//활동유형이 웹답변 일 때
				tChnlType = "webAnswer";

				if(opener){
					tData = {
							chnlType : tChnlType,
							msgType : "S001",
							mbrNo : $("#memNo").val(),
							ridMbr : $("#ridMbr").val(),
							ridCust : $("#detail_ridCust").val(),
							emailAddr : $("#detail_email").val(),
							comment : actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].sbst,
							creatorLogin : $.ifvmGetUserInfo().userId,
							ridVocReq : rid,
							senderEmail : "e1@e1.co.kr",
							emailTitle : actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].msgSubject,
							actyRid : actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].rid,
							insertFlag : '1',
							receiverName : $("#memNm").val(),
							inquiryTitle : $("#detail_consultTitle").val(),
							inquiryContents : $("#detail_consultContent").val(),
							inquiryDate : $("#detail_receptionDate").val().split(" ")[0],
							answerDate : actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].actCreatedDt.split(" ")[0]
						};
				}else{
					tData = {
							chnlType : tChnlType,
							msgType : "S001",
							mbrNo : $("#detail_memNo").val(),
							ridMbr : $("#detail_memRid").val(),
							ridCust : $("#detail_ridCust").val(),
							emailAddr : $("#detail_email").val(),
							comment : actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].sbst,
							creatorLogin : $.ifvmGetUserInfo().userId,
							ridVocReq : rid,
							senderEmail : "e1@e1.co.kr",
							emailTitle : actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].msgSubject,
							actyRid : actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].rid,
							insertFlag : '1',
							receiverName : $("#detail_memName").val(),
							inquiryTitle : $("#detail_consultTitle").val(),
							inquiryContents : $("#detail_consultContent").val(),
							inquiryDate : $("#detail_receptionDate").val().split(" ")[0],
							answerDate : actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].actCreatedDt.split(" ")[0]
						};
				}

			}



			$.ifvSyncPostJSON('<ifvm:action name="transChnl"/>', tData
			,function(result) {

		       	if (result.success) {
					alert('<spring:message code="L01914"/>'); //성공적으로 전송요청 하였습니다.
					data = {};
					data = {
						chnlType : "email"
						, rid : actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].rid
					};
					modifyActyHistory();
		       	}
		    }, function(result){
		       	alert(result.message);
		    });
		}
	}

}

//활동내역 sms 전송
function clickActySmsBtn(){
	var checkedList = actyHistoryGrid.opt.gridControl.getSelectedRecords()[0];
	if($.fn.ifvmIsEmpty(checkedList)){
		alert('<spring:message code="V00139"/>'); //활동내역 목록을 선택해주세요.
	}else{
		var checkedObj = checkedList;
		var callBackNo = null;

		if(checkedObj.atvyTypeCd != '40'&&checkedObj.atvyTypeCd != 'S'){
			alert('<spring:message code="V00137"/>'); //활동유형이 일치하지 않습니다.
		}else if($("#detail_phoneNo").val() == ""){
			alert('<spring:message code="V00138"/>'); //휴대폰번호를 입력해주세요.
		}else if($("#detail_phoneNo").val().indexOf("*") > 0){
			alert('<spring:message code="V00199"/>'); //마스킹을 해제하세요.
		} else if(checkedObj.chnlSendDt!=null){
			alert('<spring:message code="V00288"/>'); //해당 활동내역을 이미 전송하였습니다.
		} else{
			var tData = null;

			$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
	    		groupCode : 'SMS_CALL_BACK',
	    		codeName : 'SR'
	    	} , function(result) {

	        	if (result.success) {
	        		callBackNo = result.rows[0].markName;
	        	}
	        }, function(result){
	        	alert(result.message);
	        })

	        if(opener){
	        	tData = {
					chnlType :"sms",
					msgType : "S001",
					mbrNo : $("#memNo").val(),
					ridMbr : $("#ridMbr").val(),
					ridCust : $("#detail_ridCust").val(),
					hhpNo : $("#detail_phoneNo").val().replaceAll('-',''),
					comment : actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].sbst,
					creatorLogin : $.ifvmGetUserInfo().userId,
					ridVocReq : rid,
					callBackNo :callBackNo,
					actyRid : actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].rid,
					insertFlag : '1'
				}
	        }else{
	        	tData = {
					chnlType :"sms",
					msgType : "S001",
					mbrNo : $("#detail_memNo").val(),
					ridMbr : $("#detail_memRid").val(),
					ridCust : $("#detail_ridCust").val(),
					hhpNo : $("#detail_phoneNo").val().replaceAll('-',''),
					comment : actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].sbst,
					creatorLogin : $.ifvmGetUserInfo().userId,
					ridVocReq : rid,
					callBackNo :callBackNo,
					actyRid : actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].rid,
					insertFlag : '1'
				}
	        }



			$.ifvSyncPostJSON('<ifvm:action name="transChnl"/>', tData,function(result) {

		       	if (result.success) {
					alert('<spring:message code="L01914"/>'); //성공적으로 전송요청 하였습니다.
					data = {};
					data = {
						chnlType : "sms"
						, rid : actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].rid
					};
					modifyActyHistory();
		       	}
		    }, function(result){
		       	alert(result.message);
		    });
		}
	}

}

//활동내역 이메일 또는 SMS 발송 후, 활동내역 수정
function modifyActyHistory(){
	$.ifvSyncPostJSON('<ifvm:action name="modifyActyHistory"/>', data
	,function(result) {
	   	if (result.success) {
	   		actyHistoryList();
	   	}
	});
}


function init(){
	//$("#emailBtn ,#smsBtn, #msgBtn").prop("disabled",true);
	actyHistoryList();
}

function clickMsgBtn(){
	var checkedList = actyHistoryGrid.opt.gridControl.getSelectedRecords()[0];
	if($.fn.ifvmIsEmpty(checkedList)){
		alert('<spring:message code="V00139"/>'); //활동내역 목록을 선택해주세요.
	}else{
		$("#actyHistoryMsgPop").ifvsfPopup({
	       enableModal : true,
		   enableResize: false,
		   contentUrl: '<ifvm:url name="actyHistoryMsgPop"/>?actyMsgRid='+actyHistoryGrid.opt.gridControl.getSelectedRecords()[0].rid,
		   contentType: "ajax",
		   title: "<spring:message code='V00036'/>",
		   width: 600,
		   close : 'actyHistoryMsgPopClose'
		});
	}
}

function actyHistoryMsgPopClose() {
	actyHistoryMsgPop._destroy();
}

$(document).ready(function(){
	init();

	if(closedFlag){
		//setBtnDisabledAll();
		$("#saveBtn, #newBtn, #smsBtn, #emailBtn").attr("disabled",true);
	}
});
</script>

<div class="page_btn_area">
	<div class="col-xs-2">
	<span><spring:message code="활동내역" /></span>
	</div>
	<div class="col-xs-10 searchbtn_r">
		<ifvm:inputNew type="button" id="newBtn"  text="V00002" btnType="plus" btnFunc="clickNewActyBtn" objCode="actyHistoryListNew_OBJ"/>
		<ifvm:inputNew type="button" id="msgBtn"  text="M02517" btnType="" btnFunc="clickMsgBtn" objCode="actyHistoryListMsg_OBJ"/>
		<ifvm:inputNew type="button" id="emailBtn"  text="E-mail" btnType="" btnFunc="clickActyEmailBtn" objCode="actyHistoryListEmail_OBJ"/>
		<ifvm:inputNew type="button" id="smsBtn"  text="V00034" btnType="" btnFunc="clickActySmsBtn" objCode="actyHistoryListSms_OBJ"/>
	</div>
</div>
<div id="actyHistoryList" class="white_bg grid_bd0"></div>

<!-- 활동내역 신규 팝업 -->
<div id="actyHistoryPop"></div>
<!-- 활동내역 메시지 팝업 -->
<div id="actyHistoryMsgPop"></div>
