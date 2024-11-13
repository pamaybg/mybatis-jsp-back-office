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
<script src="${pageContext.request.contextPath}/resources/js/marketing/diagram/js/util.js" type="text/javascript"></script>

<script>
var validation;

var identiTypeCd = '<%= cleanXss(request.getParameter("identiTypeCd")) %>';
var identiVal = '<%= cleanXss(request.getParameter("identiVal")) %>';
var offerNo ;
var saved = false;


//VOV 포인트 요청 
function reqSubmit(){	
	

		
	$.ifvSyncPostJSON( '<ifvm:action name="vocPntReq"/>' 
		,{
	 	   identiTypeCd      :  identiTypeCd
		 , identiVal         :  identiVal
		 , pntTxnType1Cd     :  $("#pntTxnType1Cd").val()
		 , pntTxnType2Cd     :  $("#pntTxnType2Cd").val()
		 , pntAmt            :  $("#pntAmt").val()
		 , reqDate           :  $("#reqDate").val()
		 , reqByRid          :  $("#reqByRid").val()
		 , txnTypeDtlDesc    :  $("#txnTypeDtlDesc").val()
         }
			
	, function(result) {
		alert('<spring:message code="L00127"/>');
		$('#popupContainer1').ejDialog('destroy');
		grid.opt.grid.trigger("reloadGrid");
      
	}
	, function(result) {
		if(result.rsltDtlMs == '900004') {
			alert('<spring:message code="L00441"/>');
		}else {
			alert("error!!!");
		}
	}
	
	);
}



//요청 버튼클릭 시 동작
function vocReqSave() {
 	if(validation.confirm())  reqSubmit();
}

// 오퍼 조회 팝업
function searchOfferBtn() {
	
    $("#benefitsOfferListPop").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="benefitsOfferListPop"/>?newOfferYn=X',
        contentType: "ajax",
        title: '<spring:message code="M00794"/>',
        width: '1024px',
        close : 'benefitsOfferListPopClose',
        open : function(){
            new ifvm.PopupCenter({
                popupDivId : 'benefitsOfferListPop'
            });
        }
    });
    
    benefitsOfferListPop = $("#benefitsOfferListPop").data("ejDialog");
    
}

//오퍼 조회 팝업 닫기
function benefitsOfferListPopClose(){
	
	if(saved == false){
		benefitsOfferListPop._destroy();
	}else{
		benefitsOfferListPop2._destroy();
		saved=false;
	}
}

//오퍼 선택 
function benefitsOfferListPopSelect() {
	var rowId = gridIdbenefitsOfferListPopGrid.getGridParam("selrow");
	var rowData = gridIdbenefitsOfferListPopGrid.getRowData(rowId);	
	rowData.offerId = rowData.id;	
	delete rowData.id;
	
	//오퍼 목록에 선택 오퍼가 있는지 확인
	if ($.fn.ifvmIsNotEmpty(rowId)) {
    
     	$("#vocOfferNm").val(rowData.offerName);
     	offerNo = rowData.offerNo;             
        //팝업 닫기
        benefitsOfferListPopClose();
    	
	} else {
		alert( "<spring:message code='M01018' />" );
	}
}


//신규 오퍼 등록
function newOfferEnrollmentBtn() {

    $("#benefitsOfferListPop2").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="loyOfferDetailLoad"/>',
        contentType: "ajax",
        title: '<spring:message code="M00793"/>',
        width: '1000px',
        close : 'benefitsOfferListPop2Close',
        beforeOpen : function (){
            $("#benefitsOfferListPop2 .page-title").hide();
        },
        open: function (args) {       	        	
        	
        	//목록버튼 삭제
        	$("#loyOfferListBtn").remove();
        }
    });
    
    benefitsOfferListPop2  = $("#benefitsOfferListPop2").data("ejDialog");

}

//오퍼 조회 팝업 닫기
function benefitsOfferListPop2Close(){
	benefitsOfferListPop2._destroy();
}




//신규 오퍼 등록 후 오퍼 목록 새로고침
function addNewBenefitsOffer(obj) {	
	//benefitsOfferListPopGrid();  
	
	saved=true;
}


$(document).ready(function(){
	
	/* 오퍼 팝업  */
	$("#offerSearchPop").click(function(){
		searchOfferBtn();
    });
		
	
	
	$("#btnReqSave").click(function(){
		vocReqSave();
    });
		
	
	$("#cancelBtn").click(function(){
		$('#popupContainer1').ejDialog('destroy');
	});
	
	validation = $("#vocPntForm").ifvValidation();

	
	// 숫자만 입력 가능
	$("input[id=pntAmt]").keyup(function(event){ 
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi,''));
		}
	});
	
	
});

</script>

<!-- 포인트 거래 유형 -->
<script id="pntTxnType1CdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<!-- 포인트 거래 상세 유형  -->
<script id="pntTxnType2CdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>





<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
</style>




<div class="form-horizontal underline top_well" id="vocPntForm" >
	<div class="row  qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M02128" /></label>	
		<div class="col-xs-4 control_content">
			<ifvm:input type="select" required="true" id="pntTxnType1Cd"/>
		</div>
		
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M02129" /></label>
		<div class="col-xs-3 control_content">
			<ifvm:input type="select" required="true" id="pntTxnType2Cd"   disabled="true"/>
		</div>
	</div>	
	<div class="row  qt_border">	
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='M00314' /></label>
		<div class="col-xs-4 control_content">
			<div class="input-group">
			<ifvm:input type="text" disabled="true" required="true" id="vocOfferNm"/>
			<span class="input-group-addon" id="offerSearchPop">
					<a><i class="fa fa-search"></i></a>
			</span>
			</div>
		</div>
		<label class="col-xs-2 control-label"><span class="asterisk"></span></label>
		<div class="col-xs-3 control_content">
			
		</div>
	</div>
	
	<div class="row  qt_border">	
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='L00422' /></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="text" required="true" id="pntAmt"  />
		</div>
		<label class="col-xs-2 control-label"><span class="asterisk"></span><spring:message code="M02130" /></label>
		<div class="col-xs-3 control_content">
			<ifvm:input type="text"  id="reqDate" disabled="true"/>
		</div>
	</div>	
		
	
	<div class="row qt_border">
		<label class="col-xs-2 control-label"></label>
		<div class="col-xs-4 control_content">
				
		</div>
		<label class="col-xs-2 control-label"><spring:message code='M01661' /></label>
		<div class="col-xs-3 control_content">
			<ifvm:input type="text" id="reqName" disabled="true" />
		</div>
	</div>
</div>

<div class="pop_btn_area">
    <button class="btn btn-sm" id="btnReqSave"><i class="glyphicon glyphicon-check"></i>
			<spring:message code="L00125"/>
	</button> 
    <button class="btn btn-sm btn_lightGray2" id="cancelBtn">
    <spring:message code="L00124"/>         
    </button> 
</div>


<script>



$(function(){
	
	
	
	//포인트 거래유형 
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'PNT_TXN_TYPE'		
		, enableNA : true
	},function(result) {
		
		var temp = $("#pntTxnType1CdTemp").tmpl(result.rows);
		$("#pntTxnType1Cd").append(temp);
		
		
	});
	
	//포인트 거래 상세유형
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'PNT_TXN_DTL_TYPE'
		, enableNA : true
	},function(result) {
	
		var temp = $("#pntTxnType2CdTemp").tmpl(result.rows);
		$("#pntTxnType2Cd").append(temp);
		
		//VOC 포인트로 세팅
		$("#pntTxnType2Cd").val("160");
	});
	


	
	
	
});



</script>

<div id="benefitsOfferListPop" class="popup_container"></div>
<div id="benefitsOfferListPop2" class="popup_container"></div>
