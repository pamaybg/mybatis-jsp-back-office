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
var testViewList_rid = rid;
var cardDtlListObj={};
var popSelectlId; //팝업에서 선택한 값이 세팅되는 input ID
var cardDtlList;
var ridPnt;

var rid = '<%= cleanXss(request.getParameter("rid")) %>';
var cardObj ={};
var transCheckObj = {}
var cardValid;
var tempObj = {};
var promoCnt=null;

gUnRgstCardInfo = {
		data : {},
		checkBoxIds : ['activeFlag'],
		pointFieldId : ['preSavePoint'],
		dateFieldId : [],
		dateTimeFieldId : ['firstCardUseDt', 'lastCardUseDt','apvRqtDt','apvDt'],
		setCheckBox : function(result){
			for(i in gUnRgstCardInfo.checkBoxIds){
				if(result[gUnRgstCardInfo.checkBoxIds[i]] != "" && result[gUnRgstCardInfo.checkBoxIds[i]] != null && (result[gUnRgstCardInfo.checkBoxIds[i]]).toUpperCase() == "Y"){

					$("#unRgstCardDtlForm input[type='checkbox'][id='"+gUnRgstCardInfo.checkBoxIds[i]+"']").prop('checked',true);
					
				}
			}
		},
		/* setPointField : function(){
			for(var pi = 0 ; pi < this.pointFieldId.length ; pi++){
				var _pval = $("#"+this.pointFieldId[pi]).val();
				var _aval="";
				if(_pval){
					_aval = (_pval.split(".")[0]).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				}
				$("#unRgstCardDtlForm #"+this.pointFieldId[pi]).css("text-align","right").val(_aval);
			}
		}, */
		setDateField : function(){
			for(var pi = 0 ; pi < this.dateFieldId.length ; pi++){
				var _pval = $("#"+this.dateFieldId[pi]).val();
				var _aval="";
				if(_pval){
					_aval = _pval.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
				}
				$("#unRgstCardDtlForm #"+this.dateFieldId[pi]).val(_aval);
			}
		},
		setDateTimeField : function(){
			for(var pi = 0 ; pi < this.dateTimeFieldId.length ; pi++){
				var _pval = $("#"+this.dateTimeFieldId[pi]).val();
				var _aval="";
				if(_pval){
					_aval = _pval.split('.')[0];
				}
				$("#unRgstCardDtlForm #"+this.dateTimeFieldId[pi]).val(_aval);
			}
		},
		init : function(){
			$.ifvGetCommCodeList('select', 'unRgstCardDtlForm #preSaveStatus', '<ifvm:action name="getCommCodeList2"/>', 'PRE_SAVE_STATUS', 'loy', true, true);
			$.ifvGetCommCodeList('select', 'unRgstCardDtlForm #cardTypeCd', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_CARD_CD', 'loy', true, true);
			$.ifvGetCommCodeList('select', 'unRgstCardDtlForm #apvStatus', '<ifvm:action name="getCommCodeList2"/>', 'REQ_STATUS_CD', 'loy', true, true);
			this.loadData();

		},
		loadData : function(){
			 $.ifvSyncPostJSON('<ifvm:action name="getUnRgstCardDtlPop"/>', {
				  rid: rid
				 }, function(result) {

					 
				  if($.fn.ifvmIsNotEmpty(result)) {
					  $("#unRgstCardDtlForm input").val(null);
					  $("#unRgstCardDtlForm").dataSetting(result);					  
					  $("#preSavePoint , #preAcuEfctPeriod ").attr("disabled",true);
					  $("#approverSearchBtn").addClass("hidden");
					  $("#prodSearchBtn").addClass("hidden");
					  tempObj.apvNm = result.apvNm;
					  
					  
					  numberFormatterSetting();
					  gUnRgstCardInfo.setDateTimeField();
					  gUnRgstCardInfo.setCheckBox(result);
					  $("#requestCancelBtn").addClass("hidden");
					 
					  
				  }
			})

		},
		unRgstButtonValid : function(val){
	 			$("#prodSearchBtn").addClass("hidden");
	 			$("#apprRequestBtn , #cardInfoSave ,#approverSearchBtn").addClass("hidden");
	 			/* $("#cardInfoSave, #confirmBtn").attr("disabled",true); */
	 			$('#unRgstCardDtlForm').find('input').each(function(index, item){
	 				$(item).attr("disabled",val);
	 			});

	 			$('#unRgstCardDtlForm').find('select').each(function(index, item){
	 				$(item).attr("disabled",val);
	 			});


		}
		

}
//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink(cellvalue, options, rowObjec){
	var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag=null;

    if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
    return tag;
}

function dateSetting(){
    var peroidDate = $("#preAcuEfctPeriod");
    peroidDate.val($.ifvGetNewDate('y', +1).newDateS);
    peroidDate.ifvDateChecker({});
}

function saveCardInfo(){
	cardValid = $("#unRgstCardDtlForm").ifvValidation();
	
	if(cardValid.confirm() == true){
		var submitData=$("#unRgstCardDtlForm").getSubmitData();

		submitData.cardRid=rid;
		var periodDate = submitData.preAcuEfctPeriod.split("-")[0]+ submitData.preAcuEfctPeriod.split("-")[1]+  submitData.preAcuEfctPeriod.split("-")[2];
		submitData.preAcuEfctPeriod = periodDate;

		if($("#preSaveStatus").val()==""){
			submitData.preSaveStatus ="10";
		}

		$.ifvSyncPostJSON('<ifvm:action name="updateCardInfo"/>',
				 submitData
			 , function(result) {
				
			 	alert("<spring:message code='C00094'/>");
				/* unRgstCardDetailDataLoad(testViewList_rid); */
				gUnRgstCardInfo.loadData();
				cardList.requestData();

			    },function(result){
	            });
	}

}
function fnUnRgstPromoPop(){
	unRgstPromoDetailPop ={
	        id : "unRgstPromoDetailPopDiv"
	    };
	unRgstPromoDetailPop.popup = function (){
		unRgstPromoDetailPop.pop = $('#'+unRgstPromoDetailPop.id).ifvsfPopup({
	            enableModal: true,
	            enableResize: false,
	            contentUrl: '<ifvm:url name="pointDetailPop"/>'+"?promoRid="+ridPnt,
	            contentType: "ajax",
	            title: "<spring:message code='L00599'/>",
	            width: "1000px"
	        });
	};
	unRgstPromoDetailPop.beforeClose = function (obj) {
	};
	unRgstPromoDetailPop.close = function (obj) {
	        this.beforeClose(obj);
	        this.pop.data('ejDialog')._destroy();
	 };
	 unRgstPromoDetailPop.popup();
}

function prodSearchHelpBlur(){
	if($("#prodNm").val()==""){
		$("#ridProd").val("");
		$("#prodCd").val("");
	}else{
		prodSearchHelpOpenPop('<ifvm:url name="prodSearchHelp"/>' +"?prodNm="+encodeURI(encodeURIComponent($("#prodNm").val())));
	}
}
function prodSearchHelpEnter(){
	if($("#prodNm").val()==""){
		$("#ridProd").val("");
		$("#prodCd").val("");

	}else{
		prodSearchHelpOpenPop('<ifvm:url name="prodSearchHelp"/>' +"?prodNm="+encodeURI(encodeURIComponent($("#prodNm").val())));
	}
}

function prodSearchHelpFn(){
	prodSearchHelpOpenPop('<ifvm:url name="prodSearchHelp"/>')
}

function prodSearchHelpOpenPop(url){
	prodSearchHelpPop ={
	        id : "prodSearchHelpPopDiv"
	    };
	prodSearchHelpPop.popup = function (){
		prodSearchHelpPop.pop = $('#'+prodSearchHelpPop.id).ifvsfPopup({
	            enableModal: true,
	            enableResize: false,
	            contentUrl: url,
	            contentType: "ajax",
	            title: "<spring:message code='L01394'/>",
	            width: '1000px'
	        });
	};
	prodSearchHelpPop.beforeClose = function (obj) {
	};
	prodSearchHelpPop.close = function (obj) {
		if(typeof obj !="undefined"){
			$("#prodCd").val(obj.prodId);
			$("#prodNm").val(obj.prodNm);
			$("#ridProd").val(obj.rid);
			cardObj.prodNm = obj.prodNm;
		}else{
			$("#prodNm").val(cardObj.prodNm);
		}
		this.beforeClose(obj);
	    this.pop.data('ejDialog')._destroy();
	 };
	 prodSearchHelpPop.popup();
}


function confirmBtnFn(){
	if(confirm('<spring:message code="L02010"/>')) {
		cardValid = $("#unRgstCardDtlForm").ifvValidation();
		if(cardValid.confirm() == true){
			var submitData = $("#unRgstCardDtlForm").getSubmitData();
			submitData.cardRid  = testViewList_rid;
			

			$.ifvSyncPostJSON('<ifvm:action name="updateCardRecvStatusConfirm"/>', submitData
				 ,function(result){
				 alert("<spring:message code='L01588'/>" );
				 gUnRgstCardInfo.loadData();
				 cardList.requestData();
			});
		}
	}
}

function promoIsYn(cellvalue, options, rowObjec){
	var isYn;

	promoCnt = rowObjec.promoCnt;

	if(promoCnt !=0  && promoCnt !=null){
		isYn="Y"
	}else{
		isYn="N";
	}
	return isYn;
}

function transButtonValid(promoCnt){

	if(promoCnt ==0 || promoCnt ==null){
		$("#unRgstPromoPopBtn").attr('disabled',true);

	}else{
		$("#unRgstPromoPopBtn").attr('disabled',false);
	}

}


function apprRequestFn(){
	cardValid = $("#unRgstCardDtlForm").ifvValidation();
	
	if(cardValid.confirm() == true){

		
		var submitData=$("#unRgstCardDtlForm").getSubmitData();

		if(submitData.preSavePoint <= 0 ){
			alert("<spring:message code='L02061'/>");
		}else{
		submitData.cardRid=rid;
		var periodDate = submitData.preAcuEfctPeriod.split("-")[0]+ submitData.preAcuEfctPeriod.split("-")[1]+  submitData.preAcuEfctPeriod.split("-")[2];
		submitData.preAcuEfctPeriod = periodDate;

		if($("#preSaveStatus").val()==""){
			submitData.preSaveStatus ="10";
		}

		$.ifvSyncPostJSON('<ifvm:action name="updateCardInfo"/>',
				 submitData
			 , function(result) {
			 	/* alert("<spring:message code='C00094'/>");
				unRgstCardDetailDataLoad(testViewList_rid);
				cardList.requestData(); */
				 gUnRgstCardInfo.loadData();
			    },function(result){
	            });

		$.ifvSyncPostJSON('<ifvm:action name="cardApprRequest"/>',
				 submitData
			 , function(result) {
				if(result.success){
			 	 	alert("<spring:message code='L02031'/>");
				 	gUnRgstCardInfo.init();
					cardList.requestData();
				}else{
					alert(result.message);
				}
			    },function(result){
				    alert(result.message);
	            });

		}


	}


}

function requestCancelFn(){
	var submitData=$("#unRgstCardDtlForm").getSubmitData();
	submitData.cardRid=rid;
	$.ifvSyncPostJSON('<ifvm:action name="cardApprRequestCancel"/>',
			 submitData
		 , function(result) {
			
			alert("<spring:message code='L02031'/>");

			gUnRgstCardInfo.init();
			cardList.requestData();

		    },function(result){
           });


}

function approverSearchHelpEnter() {
	if($('#apvNm').val() != tempObj.apvNm){
		if ($('#apvNm').val() == "") {
			$('#ridApv').val("");
		} else {
			approverSearchHelpOpenPop('<ifvm:url name="empSearchHelp"/>'
					+ '?authNm=E10008&&name='
					+ encodeURI(encodeURIComponent($('#apvNm').val())));
		}
	}
}

function approverSearchHelpBlur() {
	if($('#apvNm').val() != tempObj.apvNm){
		if ($('#apvNm').val() == "") {
			$('#ridApv').val("");
		} else {
			approverSearchHelpOpenPop('<ifvm:url name="empSearchHelp"/>'
					+ '?authNm=E10008&&name='
					+ encodeURI(encodeURIComponent($('#apvNm').val())));
		}
	}
}

function approverSearchHelpOpenPop(url) {
	empSearchHelpPop = {
		id : "empSearchPopDiv"
	};
	empSearchHelpPop.popup = function() {
		empSearchHelpPop.pop = $('#' + empSearchHelpPop.id).ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : url,
			contentType : "ajax",
			title : "<spring:message code='L00990'/>",
			width : "700px" ,
			close : this.close
		});
	};
	empSearchHelpPop.beforeClose = function(obj) {
	};
	empSearchHelpPop.close = function(obj) {
		
		if (obj.rid != null || typeof obj.rid != "undefined") {

			if(obj.rid==$.ifvmGetUserInfo().empId){
				alert("<spring:message code='L01868'/>");
				$("#apvNm").val(tempObj.apvNm)
				return;
			}
			$("#apvNm").val(obj.name);
			$("#ridApv").val(obj.rid);
			tempObj.apvNm = obj.name;
		} else {
			$("#apvNm").val(tempObj.apvNm)
		}

		empSearchPopDiv._destroy();
	};
	empSearchHelpPop.popup();
}
function approverSearchFn() {
	approverSearchHelpOpenPop('<ifvm:url name="empSearchHelp"/>'
			+ '?authNm=' + 'E10008')
}



function numInputInit() {	 
	 $("#preSavePoint").ifvNumberOnly();
	 
	}
	
function numberWithCommas(x) {
	 return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}	
function numberFormatterSetting(){

	 var numFormatVal=$("#preSavePoint").val().split(".")[0];
	 $("#preSavePoint").val(numberWithCommas(numFormatVal));


	}

$(document).ready(function(){
	numInputInit() ;
 	dateSetting();

 	gUnRgstCardInfo.init();

 	
 	

});
</script>

<div id="unRgstCardDtlForm" >
	<div class="form-horizontal underline top_well" >
		<div class="page_btn_area">
			<div class="col-xs-7">
				<span><spring:message code="L02046"/></span>
			</div>
			<div class="col-xs-5 searchbtn_r">
				
 			</div>
		</div>
	  	<div class="row">
			<ifvm:inputNew type="text" id="cardNum" maxLength="50"  dto="cardNum"   label="L00414" labelClass="1" conClass="2"  disabled="true"/>
			<ifvm:inputNew type="select" id="cardTypeCd" maxLength="50"  dto="cardTypeCd"   label="L00192" labelClass="1" conClass="2" disabled="true" />
			<ifvm:inputNew type="text"  id="preSavePoint" maxLength="50"  dto="preSavePoint"    label="L00700" labelClass="1" conClass="2" required="true" />
	 	  	<ifvm:inputNew type="date" id="preAcuEfctPeriod" dto="preAcuEfctPeriod" maxLength="50" label="L00705" labelClass="1" conClass="2" />
	 	</div>

	 	<div class="row">
	    	<ifvm:inputNew type="text" id="firstCardUseDt" maxLength="50"  dto="firstCardUseDt"   label="L00706" labelClass="1" conClass="2" disabled="true"/>
	    	<ifvm:inputNew type="text" id="lastCardUseDt" maxLength="50"  dto="lastCardUseDt"   label="L00707" labelClass="1" conClass="2" disabled="true"/>
			<ifvm:inputNew type="search" id="prodNm|prodSearchBtn"  dto="prodNm" names="prodNm" hidId="ridProd" hidDto="ridProd"  disabled="false" required="true"
			   btnFunc="prodSearchHelpFn" searchBlurEvent="prodSearchHelpBlur" searchEnterEvent="prodSearchHelpEnter" label="L00567"  labelClass="1" conClass="2" />

		    <ifvm:inputNew type="text" id="prodCd" maxLength="50"  dto="prodCd"   label="L00566" labelClass="1" conClass="2" disabled="true"	/>
		    <ifvm:inputNew type="hidden" id="cardRid" dto="cardRid" />
	 	</div>

	 	<div class="row">
	    	<label class="col-xs-1 control-label"><spring:message code="M01139"/></label>

	 		<div class="col-xs-2 control_content">
	   			<input type="checkbox"  id="activeFlag"  value="activeFlag" disabled="true"/>
	  		</div>
	  		<%-- <ifvm:inputNew type="select" id="preSaveStatus" maxLength="50"  dto="preSaveStatus"   label="L01678" labelClass="1" conClass="2" disabled="true"/> --%>

	 	</div>
	</div>

	<div class="form-horizontal underline top_well" >
		<div class="page_btn_area">
			<div class="col-xs-7">
				<span><spring:message code="L02047"/></span>
			</div>
		</div>
	  	<div class="row">

			<ifvm:inputNew type="text" 	maxLength="50"	label="L02048"	id="rqtNm" 	dto="rqtNm"   	labelClass="1" conClass="2"  disabled="true"/>
			<ifvm:inputNew type="text" 	maxLength="50"	label="L02049"	id="apvRqtDt" 	dto="apvRqtDt" 	labelClass="1" conClass="2" disabled="true" />
			<ifvm:inputNew type="search" id="apvNm|approverSearchBtn"
						names="apvNm" hidId="ridApv" hidDto="ridApv" dto="apvNm"
						disabled="false" btnFunc="approverSearchFn"
						searchBlurEvent="approverSearchHelpBlur"
						searchEnterEvent="approverSearchHelpEnter" label="L00678"
						labelClass="1" conClass="2" required="true" />



	 	  	<ifvm:inputNew type="text" 	maxLength="50"	label="L02051"	id="apvDt" 		dto="apvDt"   	labelClass="1" conClass="2" disabled="true" />
	 	</div>
		<ifvm:inputNew type="hidden" 	maxLength="50"	id="ridRqt" 	dto="ridRqt"   conClass="2"  />


	 	<div class="row">
	    	<ifvm:inputNew type="select"  	maxLength="50"	label="L02052"		id="apvStatus" 	  	dto="apvStatus"    	labelClass="1" conClass="2" disabled="true" />
	 	  	<ifvm:inputNew type="text" 		maxLength="50"	label="L02053"		id="apvRjtRsn" 	dto="apvRjtRsn"   labelClass="1" conClass="8" disabled="true" />


	 	</div>

	</div>
</div>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L00637"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<ifvm:inputNew type="button"   text="M00169"  id="unRgstPromoPopBtn" btnFunc="fnUnRgstPromoPop" disabled="true"/>
 	</div>
</div>
   	


 <div id="unRgstPromoDetailPopDiv" class="popup_container content_container"></div>
 <div id="prodSearchHelpPopDiv" class="popup_container content_container"></div>
 <div id="empSearchPopDiv" class="popup_container"></div>