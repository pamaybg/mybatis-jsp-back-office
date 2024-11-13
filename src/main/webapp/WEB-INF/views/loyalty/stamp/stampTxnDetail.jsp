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

var testViewList_rid = '<%= cleanXss(request.getParameter("rid")) %>';

var popSelectlId; //팝업에서 선택한 값이 세팅되는 input ID

function stampDetailDataLoad(testViewList_rid) {
 if(testViewList_rid!="null"){
	 $.ifvSyncPostJSON('<ifvm:action name="getStampDetail"/>', {
		  rid: testViewList_rid
		 }, function(result) {
		  if($.fn.ifvmIsNotEmpty(result)) {
		 		$($('#stampTxnDetailForm').find('input')).each(function(index, item){
		 			var value=result.rows[0][$(item).attr('id')];
					isEmptyCheck(value);
					if(isEmpty){
						if(result.rows[0][$(item).attr('id')].split(".").length>1){
							var numVal=result.rows[0][$(item).attr('id')].split(".")[0];
							if(numVal.split("-").length>1){ 	//날짜필드
								$(item).val(numVal);
							}else{ //숫자필드
								$(item).val(numberWithCommas(numVal));
								$(item).attr("style", "text-align:right;");
							}

						}else{
					 		$(item).val(result.rows[0][$(item).attr('id')]);
						}

					}


		 	 		if($(this).attr('type')=="checkbox"){
		 	 			if(result.rows[0][$(item).attr('id')]=='Y'){
		 	 				$(this).attr('checked', 'true');
		 	 			}
		 	 		}
		 			$(item).attr("disabled",true);


		 		});

		 		$($('#stampTxnDetailForm').find('select')).each(function(index, item){
		 			$(item).val(result.rows[0][$(item).attr('id')]);
		 			$(item).attr("disabled",true);

		 		});
		  }
		    });

 }
}

//1000단위 정규식
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function numberFormatter(){
	var numFormatVal=$("#dtlAcrlStamp").val();

	$("#dtlAcrlStamp").val(numberWithCommas(numFormatVal));
	$("#dtlAcrlStamp").attr("style", "text-align:right;");

	numFormatVal=$("#dtlUseStamp").val();
	$("#dtlUseStamp").val(numberWithCommas(numFormatVal));
	$("#dtlUseStamp").attr("style", "text-align:right;");

	numFormatVal=$("#dtlGiftStamp").val();
	$("#dtlGiftStamp").val(numberWithCommas(numFormatVal));
	$("#dtlGiftStamp").attr("style", "text-align:right;");

	numFormatVal=$("#dtlAvlStamp").val();
	$("#dtlAvlStamp").val(numberWithCommas(numFormatVal));
	$("#dtlAvlStamp").attr("style", "text-align:right;");

}


function commCodeSetting(){
	//요청 유형
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'STAMP_TXN_TYPE_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#dtlTxnType1CdDiv").tmpl(result.rows);
		$("#dtlTxnType1Cd").append(temp);
	});


	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'STAMP_TXN_SUB_TYPE_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#dtlTxnType2CdDiv").tmpl(result.rows);
		$("#dtlTxnType2Cd").append(temp);
	});


	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'MEMBER_TYPE'
		, enableNA : true
	},function(result) {
		var temp = $("#dtlMemDivDiv").tmpl(result.rows);
		$("#dtlMemDiv").append(temp);
	});

	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'MEMBER_GRADE'
		, enableNA : true
	},function(result) {
		var temp = $("#dtlMemGradeDiv").tmpl(result.rows);
		$("#dtlMemGrade").append(temp);
	});
}

function currentStampInfo(){
	 $.ifvSyncPostJSON('<ifvm:action name="getStampDetailPop"/>', {
		  rid: testViewList_rid
		 }, function(result) {
		  if($.fn.ifvmIsNotEmpty(result)) {
			  $("#stampTotal").val(result.rows[0].stampTotal);
			  $("#popUsedStamp").val(result.rows[0].dtlUseStamp);
			  $("#popAvlStamp").val(result.rows[0].dtlAvlStamp);
		  }

		    });

	$("#closeStampDtlPop").click(function(){
		stampDetailPop.close();
	})
}

function stampInfoDetail() {
	 stampDetailPop ={
		        id : "stampDetailPopDiv"
		    };
	stampDetailPop.popup = function (){
	stampDetailPop.pop = $('#'+stampDetailPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="stampDetailPop"/>',
		            contentType: "ajax",
		            title: '현재스탬프정보',
		            width: '1000px'
		        });
		};
		stampDetailPop.beforeClose = function (obj) {
		};
		stampDetailPop.close = function (obj) {
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		 };
		 stampDetailPop.popup();
}

function isEmptyCheck(value){
	if(value=="" || value==null || typeof value=='undefined'){
		isEmpty = false;
	}else{
		isEmpty = true;
	}
}

$(document).ready(function(){
	$.ifvmLnbSetting('stampTxnList');

	commCodeSetting();
	stampDetailDataLoad(testViewList_rid);
	numberFormatter();

 $.ifvmLnbSetting('testViewList');

 $("#stampInfoDetailBtn").click(function(){
  	stampInfoDetail();
    });

 $("#stampListBtn").click(function(){
	 qtjs.href('<ifvm:url name="stampTxnList"/>');
    });
 	currentStampInfo();

});

</script>

<script id="dtlTxnType1CdDiv" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="dtlTxnType2CdDiv" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="dtlMemDivDiv" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="dtlMemGradeDiv" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
</style>

<div class="page-title">
 <h1>
 	<spring:message code="L00553"/> &gt;  <spring:message code="L00079"/>
 </h1>
</div>

<div class="page_btn_area" id="headForm">
 <div class="col-xs-7">
  <span> <spring:message code="L00570"/></span></span>
 </div>

 <div class="col-xs-5 searchbtn_r">
  <%-- <button class="btn btn-sm" id="stampInfoDetailBtn"><spring:message code="L00578"/></button>  --%>
  <button class="btn btn-sm" id="stampListBtn"><spring:message code="M00002"/></button>
 </div>
</div>


<div class="form-horizontal underline top_well" id="stampTxnDetailForm" >
  <div class="row  qt_border" id="rowTest">
  <ifvm:inputNew type="text" id="dtlApprDt" maxLength="50"  dto="dtlApprDt"   label="L00555" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlMbrNo" maxLength="50"  dto="dtlMbrNo"   label="M00688" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlAcrlStamp" maxLength="50"  dto="dtlAcrlStamp"   label="L00558" labelClass="1" conClass="2" />
   <label class="col-xs-1 control-label"><spring:message code="L00571"/></label>

 <div class="col-xs-2 control_content">
   <input type="checkbox"  id="dtlCnclYn" />
  </div>
 </div>

 <div class="row  qt_border">
  <ifvm:inputNew type="text" id="dtlApprNo" maxLength="50"  dto="dtlApprNo"   label="M00966" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlCustNm" maxLength="50"  dto="dtlCustNm"   label="L00435" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlUseStamp" maxLength="50"  dto="dtlUseStamp"   label="L00559" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlCnclDt" maxLength="50"  dto="dtlCnclDt"   label="L00411" labelClass="1" conClass="2" />
 </div>

<div class="row  qt_border">

  <ifvm:inputNew type="select" id="dtlTxnType1Cd" maxLength="50"  dto="dtlTxnType1Cd"   label="L00356" labelClass="1" conClass="2" />
  <ifvm:inputNew type="select" id="dtlMemDiv" maxLength="50"  dto="dtlMemDiv"   label="L00557" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlGiftStamp" maxLength="50"  dto="dtlGiftStamp"   label="L00560" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlCnclRsnCd" maxLength="50"  dto="dtlCnclRsnCd"   label="L00572" labelClass="1" conClass="2" />

 </div>

 <div class="row  qt_border">
    <ifvm:inputNew type="select" id="dtlTxnType2Cd" maxLength="50"  dto="dtlTxnType2Cd"   label="L00556" labelClass="1" conClass="2" />
  <ifvm:inputNew type="select" id="dtlMemGrade" maxLength="50"  dto="dtlMemGrade"   label="L00180" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlAvlStamp" maxLength="50"  dto="dtlAvlStamp"   label="L00574" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlOrgnApprDate" maxLength="50"  dto="dtlOrgnApprDate"   label="M02021" labelClass="1" conClass="2" />

 </div>
 <div class="row  qt_border">
    <ifvm:inputNew type="text" id="dtlChnlNo" maxLength="50"  dto="dtlChnlNo"   label="L00564" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlGiftMbrNo" maxLength="50"  dto="dtlGiftMbrNo"   label="L00562" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlProdId" maxLength="50"  dto="dtlProdId"   label="L00566" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlOrgnApprNo" maxLength="50"  dto="dtlOrgnApprNo"   label="L00575" labelClass="1" conClass="2" />

 </div>
 <div class="row  qt_border">
    <ifvm:inputNew type="text" id="dtlChnlNm" maxLength="50"  dto="dtlChnlNm"   label="L00565" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlGiftCustNm" maxLength="50"  dto="dtlGiftCustNm"   label="L00563" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlProdNm" maxLength="50"  dto="dtlProdNm"   label="L00567" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlTicketNum" maxLength="50"  dto="dtlTicketNum"   label="L00576" labelClass="1" conClass="2" />

 </div>
 <div class="row  qt_border">
  <label class="col-xs-1 control-label"><spring:message code="L00573"/></label>
 <div class="col-xs-2 control_content">
   <input type="checkbox"  id="name" />
  </div>

  <ifvm:inputNew type="text" id="appName" maxLength="50"  dto="appName"   label="L00568" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlCompnApprNo" maxLength="50"  dto="dtlCompnApprNo"   label="L00577" labelClass="1" conClass="2" />

 </div>

</div>


 <div class="page_btn_area" >
 	<div class="col-xs-7">
    	<span> <spring:message code="L00578"/></span>
    </div>
</div>
		<div class="form-horizontal underline top_well" id="">
			<div class="form_row">
			<div class="row  qt_border">
			   <ifvm:inputNew type="text" id="stampTotal" maxLength="50"  dto="stampTotal"   label="L00579" labelClass="2" conClass="2"  disabled="true"/>
  			   <ifvm:inputNew type="text" id="popUsedStamp" maxLength="50"  dto="popUsedStamp"   label="L00580" labelClass="2" conClass="2"  disabled="true" />
  			   <ifvm:inputNew type="text" id="popAvlStamp" maxLength="50"  dto="popAvlStamp"   label="L00581" labelClass="2" conClass="2"  disabled="true"/>
				</div>
			</div>
		</div>

