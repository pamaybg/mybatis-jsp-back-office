<%@page trimDirectiveWhitespaces="true" %>
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

<script>

var smsRejectDetailPopup_rid = '<%= cleanXss(request.getParameter("rid")) %>';
var smsRejectDetailPopup_isNew = true;  //신규 여부. 신규: true, 수정 : false

var smsRejectDetailPopup_validation;
var popSelectlId; //팝업에서 선택한 값이 세팅되는 input ID


/* 팝업 닫기 */
function smsRejectDetailPopupPopupClose(){
 $('#smsRejectDetailPopupPopupContainer').ejDialog('destroy');
}


//초기 설정 함수
/* function detailInit() {
 if($.fn.ifvmIsNotEmpty(chnl_rid) && chnl_rid != "null") smsRejectDetailPopupDataLoad(chnl_rid);
} */

function smsRejectDetailPopupDataLoad(smsRejectDetailPopup_rid) {
 smsRejectDetailPopup_isNew = false; // 해당 함수는 수정모드일 경우에만 호출되므로, 신규 여부 플래그 값을 false로 세팅함.

 $.ifvSyncPostJSON('<ifvm:action name="getSmsRejectDetail"/>', {
  rid: smsRejectDetailPopup_rid
 }, function(result) {
  if($.fn.ifvmIsNotEmpty(result)) {


	  // 마스킹 해지
	    if ($.fn.ifvmIsNotEmpty(smsRejectDetailPopup_rid)) {
	        $.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	            rid : smsRejectDetailPopup_rid,
	            type : 'sms',
	            field : 'phone'

	        }, function(rtnVal) {
	        	if (rtnVal.message != null) {
	        		
	        		result.mphonNo = rtnVal.message;
	        	}

	        });
	    }



  	$('#smsRejectDetailPopupForm').dataSetting( result );
		
		if(result.flg === '1') {
			$('#flg').attr('checked', 'true');
		}



   		}

    });

}


function smsRejectDetailPopupSaveSubmit(){
 $.ifvSyncPostJSON(smsRejectDetailPopup_isNew ? '<ifvm:action name="saveSmsRejectDetail"/>' : '<ifvm:action name="editSmsRejectDetail"/>', getsmsRejectDetailPopupObjForSubmit()
 , function(result) {
	alert('<spring:message code="L00127"/>');
	smsRejectDetailPopupPopClose();
	getsmsRejectListSearch();

 }, function(result) {
	alert(result.message);
 }

 );
}




function getsmsRejectDetailPopupObjForSubmit(){




  var submitData =$("#smsRejectDetailPopupForm").getSubmitData();

  if( $('#flg').prop('checked')){
	  submitData.flg = 1;

  }else{
	  submitData.flg = 0;
  }
 return submitData;

}

//저장 버튼클릭 시 동작
function smsRejectDetailPopupActionSave() {
  if(smsRejectDetailPopup_validation.confirm())  smsRejectDetailPopupSaveSubmit();
}


$(function(){



 if(typeof smsRejectDetailPopup_rid != "undefined" && smsRejectDetailPopup_rid != "undefined"
		 && $.fn.ifvmIsNotEmpty(smsRejectDetailPopup_rid) && smsRejectDetailPopup_rid != "null") {
  smsRejectDetailPopupDataLoad(smsRejectDetailPopup_rid);
 }else {  //신규일경우 로그인 세선의 프로그램을 세팅함.
  var userInfo = $.ifvmGetUserInfo();
   $("#flg").prop("checked",true);
 

 }

});


function fnSmsUnmaskingBtn(){

}


$(document).ready(function(){


 $.ifvmLnbSetting('smsRejectDetailPopup');




 $("#smsRejectDetailPopupBtnSave").click(function(){
  	smsRejectDetailPopupActionSave();
    });
 $("#smsRejectDetailPopupBtnClose").click(function(){
	 smsRejectDetailPopupPopClose();
    });





 smsRejectDetailPopup_validation = $("#smsRejectDetailPopupForm").ifvValidation();

 $("input[vali-type=number]").keyup(function() {
        $(this).val($.fn.ifvmNumberWithCommas(this.value));
    });

});

</script>

<div class="content">
	<div class="form-horizontal underline top_well" id="smsRejectDetailPopupForm" >

		<div class="row">
			<ifvm:inputNew type="text" id="mphonNo"  dto="mphonNo"  required="true"  label="L00436" labelClass="2" conClass="6"  valiItem="phone" />
		</div>
		<div class="row">
			<ifvm:inputNew type="text" id="rsn" maxLength="50"  dto="rsn"  required="true"  label="L00660" labelClass="2" conClass="9" />
		</div>
		<div class="row">
			<ifvm:inputNew type="singleCheckbox" id="flg" label="I02072" values="Y" labelClass="2" conClass="2" checked="false" />
			<ifvm:inputNew type="hidden" id="rid" maxLength="50"  dto="rid"  labelClass="0" conClass="6" />
		</div>
	</div>
</div>

<div class="pop_btn_area">
	 <button class="btn btn-sm" id="smsRejectDetailPopupBtnSave"><i class="glyphicon glyphicon-check"></i><spring:message code="L00125"/></button>
  	 <button class="btn btn-sm" id="smsRejectDetailPopupBtnClose"><spring:message code="M00441"/></button>
</div>
<div id="smsRejectDetailPopupPopupContainer" class="popup_container"></div><!-- 팝업 -->
