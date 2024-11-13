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

<script>

var testViewList_rid = '<%= cleanXss(request.getParameter("rid")) %>';

var popSelectlId; //팝업에서 선택한 값이 세팅되는 input ID
var isEmpty ;

function transactionDetailDataLoad(testViewList_rid) {
 $.ifvSyncPostJSON('<ifvm:action name="getTransArchiveDetail"/>', {
  rid: testViewList_rid
 }, function(result) {
  if($.fn.ifvmIsNotEmpty(result)) {
	  var transObj=result.rows[0];

		$($('#transactDetailForm').find('input')).each(function(index, item){
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
 			$(item).attr("disabled",true);
 		});

 		$($('#transactDetailForm').find('select')).each(function(index, item){
 			$(item).val(result.rows[0][$(item).attr('id')]);
 			$(item).attr("disabled",true);
 		});

 		//콜센터 관리자만 마스킹 해제된 데이터 노출
 		var authList = $.ifvmGetAuthInfo().authList;
 		var isAuth = true;
 		for(var i = 0 ; i < authList.length ; i++){
 			if(authList[i].authName == 'E10005'){
 				isAuth = false;
 			}
 		}
 		if(isAuth){
 			if((transObj.dtlCardTypeCd=="20"&&transObj.dtlCprtCardCd!='' )||transObj.dtlCardTypeCd=='30'){
 				  $.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
 			            rid: testViewList_rid ,
 			            type: 'txn' ,
 			            field: 'cardNo'
 			        },function(result) {
 			        	if(result.message!=null){
 				        	 $("#dtlCardNum").val(result.message);
 			        	}
 			        });
 			  }
 		}
 		result.rows[0].dtlCprtCardCd
  }
    });

 numberFormatter();

}

function isEmptyCheck(value){

	if(value=="" || value==null || typeof value=='undefined'){
		isEmpty = false;
	}else{
		isEmpty = true;
	}
}


function tabContent(){
	var testTab = $('#tabContent').DrawTab({
		item: [
			{label: '<spring:message code="L00598"/>', href: '<ifvm:url name="transAddInfo"/>' + '?defaultArchive=Y' },
			{label: '<spring:message code="L00599"/>', href: '<ifvm:url name="transPromoList"/>' + '?defaultArchive=Y'},
		]
	});
}
/* function changeContent(type, tab) {
	var cUrl;
	switch( type ) {

	case 'transAddInfo' :
		cUrl = '<ifvm:url name="transAddInfo"/>';
		$('#tabName').text('<spring:message code="L00598"/>');

		break;

	case 'transPromoList' :
		cUrl = '<ifvm:url name="transPromoList"/>';
		$('#tabName').text('<spring:message code="L00599"/>');
		break;


	default :
		break;
	}



$.ifvCachedHtml( cUrl ).done( function(script, textStatus){
		var cTab = $("#" + tab);

		$('#tabContent').empty();
		$('#tabArea .btn.btn-default.btn-tab').removeClass('active');
		$('#' + type).addClass('active');

		cTab.empty();
		cTab.html('');
		cTab.append( script );
		var fileName = cUrl.split('/').pop();


		if( window[fileName + '_init'] != null ) window[fileName + '_init']();

	});
}
 */

function commCodeSetting(){
	 $.ifvGetCommCodeList('select', 'dtlPntTxnType1Cd', '<ifvm:action name="getCommCodeList2"/>', 'TXN_TYPE_CD', 'loy', false, false, true);
	 $.ifvGetCommCodeList('select', 'dtlPntTxnType2Cd', '<ifvm:action name="getCommCodeList2"/>', 'TXN_SUB_TYPE_CD', 'loy', false, false, true);
	 $.ifvGetCommCodeList('select', 'dtlMemDiv', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_TYPE', 'loy', false, false, true);
	 $.ifvGetCommCodeList('select', 'dtlMemGrade', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_GRADE', 'loy', false, false, true);
}
// 숫자데이터 포매터 처리
function numberFormatter(){
	var numFormatVal=$("#dtlPntAmt").val();

	$("#dtlPntAmt").ifvNumberOnly();
	$("#dtlPntAmt").val(numberWithCommas(numFormatVal));

	numFormatVal=$("#dtlUsePnt").val();
	$("#dtlUsePnt").ifvNumberOnly();
	$("#dtlUsePnt").val(numberWithCommas(numFormatVal));

	numFormatVal=$("#dtlGiftPnt").val();
	$("#dtlGiftPnt").ifvNumberOnly();
	$("#dtlGiftPnt").val(numberWithCommas(numFormatVal));

	numFormatVal=$("#dtlTotalPntAvl").val();
	$("#dtlTotalPntAvl").ifvNumberOnly();
	$("#dtlTotalPntAvl").val(numberWithCommas(numFormatVal));




}

//1000단위 정규식
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


$(document).ready(function(){
	$.ifvmLnbSetting('transactionList');
	commCodeSetting();
	numberFormatter();
	transactionDetailDataLoad(testViewList_rid);


 $.ifvmLnbSetting('testViewList');

 $("#transactListBtn").click(function(){
	 qtjs.href('<ifvm:url name="transactionList"/>');
    });
 tabContent();
 /* changeContent('transAddInfo', 'tabContent');
 $('#tabArea .btn.btn-default.btn-tab').on('click', function() {
		changeContent($(this).attr('id'), 'tabContent');
	});
 */

});
</script>


<script id="dtlPntTxnType1CdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="dtlPntTxnType2CdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="dtlMemDivTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="dtlMemGradeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
</style>

<div class="page-title">
 <h1>
 	<spring:message code="L01821"/> &gt;  <spring:message code="L00079"/>
 </h1>
</div>

<div class="page_btn_area" id="headForm">
 <div class="col-xs-7">
  <span> <spring:message code="L00595"/></span></span>
 </div>

 <div class="col-xs-5 searchbtn_r">
  <button class="btn btn-sm" id="transactListBtn"><spring:message code="M00002"/></button>
 </div>
</div>


<div class="form-horizontal underline top_well" id="transactDetailForm" >

 <div class="row  qt_border">
  <ifvm:inputNew type="text" id="dtlApprDate" maxLength="50"  dto="dtlApprDate"   label="L00555" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlMbrNo" maxLength="50"  dto="dtlMbrNo"   label="M00849" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlPntAmt" maxLength="50"  dto="dtlPntAmt"   label="L00582" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlCardNum" maxLength="50"  dto="dtlCardNum"   label="L00414" labelClass="1" conClass="2" />
 </div>

 <div class="row  qt_border">
  <ifvm:inputNew type="text" id="dtlApprNo" maxLength="50"  dto="dtlApprNo"   label="M00966" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlCustNm" maxLength="50"  dto="dtlCustNm"   label="L00435" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlUsePnt" maxLength="50"  dto="dtlUsePnt"   label="L00583" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlChnlNo" maxLength="50"  dto="dtlChnlNo"   label="L00564" labelClass="1" conClass="2" />
 </div>

 <div class="row  qt_border">
  <ifvm:inputNew type="select" id="dtlPntTxnType1Cd" maxLength="50"  dto="dtlPntTxnType1Cd"   label="L00356" labelClass="1" conClass="2" />
  <ifvm:inputNew type="select" id="dtlMemDiv" maxLength="50"  dto="dtlMemDiv"   label="L00557" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlGiftPnt" maxLength="50"  dto="dtlGiftPnt"   label="L00584" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlChnlNm" maxLength="50"  dto="dtlChnlNm"   label="L00565" labelClass="1" conClass="2" />
 </div>

 <div class="row  qt_border">
  <ifvm:inputNew type="select" id="dtlPntTxnType2Cd" maxLength="50"  dto="dtlPntTxnType2Cd"   label="L00556" labelClass="1" conClass="2" />
  <ifvm:inputNew type="select" id="dtlMemGrade" maxLength="50"  dto="dtlMemGrade"   label="L00180" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlTotalPntAvl" maxLength="50"  dto="dtlTotalPntAvl"   label="L00596" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlBizno" maxLength="50"  dto="dtlBizno"   label="L00597" labelClass="1" conClass="2" />
 </div>
</div>

<div id="testViewListTabArea">
 <div class="btn-group btn-group-justified" id="tabType">
 </div>
 <!-- 탭 컨텐츠 -->
 <div id="tabArea">
	<div class="btn-group btn-group-justified" id="tabType">
		        <div id="tabContent" ></div>
	</div>
 </div>
 <div>


</div>

</div>



<script>
</script>
<div id="testViewListPopupContainer" class="popup_container"></div><!-- 팝업 -->
 <div id="stampDetailPopDiv" class="popup_container content_container"></div>
