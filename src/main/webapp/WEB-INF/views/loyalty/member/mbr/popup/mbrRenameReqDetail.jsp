
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

var mbrRenameReqDetail_rid = '<%= cleanXss(request.getParameter("rid")) %>';
var mbrRenameReqDetail_isNew = true;  // 신규 여부. 신규: true, 수정 : false

var mbrRenameReqDetail_validation;
var popSelectlId; //팝업에서 선택한 값이 세팅되는 input ID
var mbrNoTemp ="" ;

/* 팝업 닫기 */
function mbrRenameReqDetailPopupClose(){
 mbrRenameReqDetailPopupContainer._destroy();
}

function mbrRenameReqDetailDataLoad(mbrRenameReqDetail_rid) {
 mbrRenameReqDetail_isNew = false; // 해당 함수는 수정모드일 경우에만 호출되므로, 신규 여부 플래그 값을 false로 세팅함.

 $.ifvSyncPostJSON('<ifvm:action name="getMbrRenameReqDetail"/>', {
  rid: mbrRenameReqDetail_rid
 }, function(result) {
  if($.fn.ifvmIsNotEmpty(result)) {
   /*  */
   //#x조회세팅x#
	  $('#mbrRenameReqDetailForm').dataSetting( result );

	  $('#mbrNo').val(result.mbrNo);
	  mbrNoTemp = result.mbrNo;

   }

    });

}


function mbrRenameReqDetailSaveSubmit(){
 $.ifvSyncPostJSON(mbrRenameReqDetail_isNew ? '<ifvm:action name="saveMbrRenameReqDetail"/>' : '<ifvm:action name="editMbrRenameReqDetail"/>', getmbrRenameReqDetailObjForSubmit()
 , function(result) {
   alert('<spring:message code="L00127"/>');
   if(mbrRenameReqDetail_isNew){

	   mbrRenameReqDetail_rid = result.message;
   	   mbrRenameReqDetailDataLoad(mbrRenameReqDetail_rid);
   	   fieldSetting();
   }
   mbrRenameReqListSearch();
   mbrRenameReqDetailPopClose();

 }, function(result){
	 alert(result.message);
 });
}

/*
 submit을 위한 form 데이터 파라미터 세팅
 */


function getmbrRenameReqDetailObjForSubmit(){



 //체크박스 처리 샘플
 //var v_mbrJoinPsblYn = $.fn.ifvmIsNotEmpty($("#mbrJoinPsblYn").attr("checked")) ?  "Y" : "N";


  var submitData =$("#mbrRenameReqDetailForm").getSubmitData();

 return submitData;

}

//저장 버튼클릭 시 동작
function mbrRenameReqDetailActionSave() {
  if(mbrRenameReqDetail_validation.confirm()){
	  var oldName = $("#mbrRenameReqDetailForm #oldName").val().trim();
	  var newName = $("#mbrRenameReqDetailForm #newName").val().trim();
	  if(oldName == newName){
		  alert('<spring:message code="L01987"/>');
		  return;
	  }
	  mbrRenameReqDetailSaveSubmit();
  }
}

function mbrRenameReqDetailActionClose() {
	mbrRenameReqDetailPopClose();
}





function mbrSearchHelpBlur(){
	if(mbrNoTemp!=$('#mbrNo').val()){
		if($('#mbrNo').val()==""){
			$('#ridMbr').val("");
			$('#oldName').val("");
			mbrNoTemp = "";
		}else{
			openMbrSearchHelp('<ifvm:url name="mbrSearchHelp"/>?mbrNo='+encodeURI(encodeURIComponent($('#mbrNo').val())));
		}
	}
}
function mbrSearchHelpBtn(){

	openMbrSearchHelp('<ifvm:url name="mbrSearchHelp"/>');

}

function mbrSearchHelpEnter(){

		if($('#mbrNo').val()==""){
			$('#ridMbr').val("");
			$('#oldName').val("");
			mbrNoTemp = "";
		}else{
			openMbrSearchHelp('<ifvm:url name="mbrSearchHelp"/>?mbrNo='+encodeURI(encodeURIComponent($('#mbrNo').val())));
		}

}




function openMbrSearchHelp(url){

		mbrSearchHelpPop ={
			        id : "mbrRenameReqDetailPopupContainer"
			    };
		mbrSearchHelpPop.popup = function (){
			mbrSearchHelpPop.pop = $('#'+mbrSearchHelpPop.id).ifvsfPopup({
			            enableModal: true,
			            enableResize: false,
			            contentUrl: url,
			            contentType: "ajax",
			            title: '<spring:message code="L00988"/>',
			            width: '700px',
			            close: mbrSearchHelpPop.close
			        });
			};
			mbrSearchHelpPop.beforeClose = function (obj) {
			};
			mbrSearchHelpPop.close = function (obj) {
				 if(obj!=null&&obj.type!="close"){

					    $("#oldName").val(obj.custNm);
			        	$("#ridMbr").val(obj.rid);
			        	$("#mbrNo").val(obj.mbrNo);
			        	mbrNoTemp = obj.mbrNo;


				 }else{
					 $("#mbrNo").val(mbrNoTemp);
				 }
				 mbrSearchHelpPop.beforeClose(obj);
				 mbrRenameReqDetailPopupContainer._destroy();
			 };
			 mbrSearchHelpPop.popup();


}

certiOwn = {
		id : "certiPopup",
		pop : function(){
			var url = '<ifvm:url name="certiOwnPop"/>';
   			url += '?certiCase=002'
			$("#"+this.id).ifvsfPopup({
	            enableModal : true,
	            enableResize : false,
	            contentUrl : url,
	            contentType : "ajax",
	            title : '<spring:message code="L00741"/>', // 회원 찾기
	            width : '500px'
	        });
		},
		beforeClose : function(obj){
			console.log(obj);

		},
		close: function(obj){
			if(obj){
				this.beforeClose(obj)
			}
			var _popObj = eval(this.id)
			_popObj._destroy();
		}
}




function mbrRenameReqAction() {

	var oldName = $("#mbrRenameReqDetailForm #oldName").val().trim();
	  var newName = $("#mbrRenameReqDetailForm #newName").val().trim();
	  if(oldName == newName){
		  alert('<spring:message code="L01987"/>');
		  return;
	  }



	var data = $("#mbrRenameReqDetailForm").getSubmitData();
	data = {
		oldName : $("#mbrRenameReqDetailForm #oldName").val()
		, ridMbr : $("#ridMbr").val()
		, newName : $("#mbrRenameReqDetailForm #newName").val()
		, rid : $("#rid").val()
	}

	certiOwn.pop();

	/*
	var mypinVali = $("#mbrRenameReqDetailForm").ifvValidation();
	if(mypinVali.confirm() == true){
		var dataObj = $("#mbrRenameReqDetailForm").getSubmitData();
		console.log(dataObj);
		if(!pinNumVali(dataObj.mypin)){
			alert('<spring:message code="L01839"/>');//잘못된 핀번호 입니다.
			return;
		}

		var data = $("#mbrRenameReqDetailForm").getSubmitData();
		data = {
			pinNo : $("#mbrRenameReqDetailForm #mypin").val().replaceAll('-','')
			, oldName : $("#mbrRenameReqDetailForm #oldName").val()
			, ridMbr : $("#ridMbr").val()
			, newName : $("#mbrRenameReqDetailForm #newName").val()
			, rid : $("#rid").val()

		}
		var action = '<ifvm:action name="editMbrName"/>';
		$.ifvSyncPostJSON(action, data , function(result) {

			if (result.success) {
				alert('<spring:message code="L01260"/>')//정상적으로 수정되었습니다.
				mbrRenameReqDetailActionClose();
			}
		}, function(result){
			alert(result.message);
		})
	}
*/

}

function pinNumVali(_pinNum){
	var regNum = /^[0-9]*$/;
	if(regNum.test(_pinNum) && _pinNum.length==13) return true;
	else return false;
}

function fieldSetting(){
	// 신규 또는 개명신청 완료 상태 일경우
	if( mbrRenameReqDetail_isNew || $("#renmYn").val()=='Y' ){
		$("#renameReqeButton, #mypinDiv").addClass("hidden");
		if($("#renmYn").val()=='Y'){
			$("#mbrRenameReqDetailForm input, #mbrRenameReqDetailForm textarea").prop('disabled',true);
			$("#mbrNoSearch, #renameSaveButton").remove();
		}
	}else{
		$("#renameReqeButton, #mypinDiv").removeClass("hidden");
	}
}

$(function(){

 //상태

 //공통코드



 if( typeof mbrRenameReqDetail_rid != "undefined" && mbrRenameReqDetail_rid != "undefined" &&
		 $.fn.ifvmIsNotEmpty(mbrRenameReqDetail_rid) && mbrRenameReqDetail_rid != "null") {

  mbrRenameReqDetailDataLoad(mbrRenameReqDetail_rid);
 }else {  //신규일경우 로그인 세선의 프로그램을 세팅함.
  var userInfo = $.ifvmGetUserInfo();

 }

});






$(document).ready(function(){


 $.ifvmLnbSetting('mbrRenameReqDetail');




 $("#mbrRenameReqDetailBtnSave").click(function(){
  mbrRenameReqDetailActionSave();
    });

 $("#mbrRenameReqDetailBtnList").click(function(){
  qtjs.href('<ifvm:url name="mbrRenameReqList"/>');
    });




 // 필수필드 체크
	mbrRenameReqDetail_validation = $("#mbrRenameReqDetailForm").ifvValidation();

//회원 서치핼프


//필드 활성화 세팅
	fieldSetting();
});





</script>










<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
</style>




<div class="form-horizontal underline top_well" id="mbrRenameReqDetailForm" >
  <div class="row  qt_border">


 <ifvm:inputNew type="search" id="mbrNo|mbrNoSearch" names="mbrNo" hidId="ridMbr" hidDto="ridMbr" dto="mbrNo" disabled="false"  required="true"
			  btnFunc="mbrSearchHelpBtn" searchBlurEvent="mbrSearchHelpBlur" searchEnterEvent="mbrSearchHelpEnter" label="L00797"  labelClass="2" conClass="2" />


<ifvm:inputNew type="text" id="oldName" maxLength="50"  dto="oldName"  required="true"  label="L00798" labelClass="2" conClass="2"  disabled="true"/>
<ifvm:inputNew type="text" id="newName" maxLength="50"  dto="newName"  required="true"  label="L00800" labelClass="2" conClass="2" />


 </div>
 <div class="row  qt_border">
 <ifvm:inputNew type="textarea" id="remark" maxLength="50"  dto="remark"    label="L00799" labelClass="2" conClass="10" />


 </div>

<%--  <div id="mypinDiv" class="row  qt_border">
 <ifvm:inputNew type="text" id="mypin" maxLength="50"  dto="mypin"    label="L00801" labelClass="2" conClass="2" />


 </div> --%>



 <ifvm:inputNew type="hidden" id="rid" maxLength="50"  dto="rid"    labelClass="2" conClass="10" />
  <ifvm:inputNew type="hidden" id="renmYn" maxLength="50"  dto="renmYn"    labelClass="2" conClass="10" />






</div>

 <div class="pop_btn_area" style="height:60px;">


  <ifvm:inputNew type="button" text="L00806" id="renameReqeButton"  btnFunc="mbrRenameReqAction" objCode="LOY_RNM_001"/>
  <ifvm:inputNew type="button" btnType="save" text="I00745" id="renameSaveButton" btnFunc="mbrRenameReqDetailActionSave" />
  <ifvm:inputNew type="button" btnType="close" text="I00404" id="renameCloseButton"  btnFunc="mbrRenameReqDetailActionClose" />

 </div>

<div id="mbrRenameReqDetailPopupContainer" class="popup_container"></div><!-- 팝업 -->
<div id="certiPopup" class="popup_container"></div><!--본인인증-->

