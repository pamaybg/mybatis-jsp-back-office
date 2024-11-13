<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
#txnAmtSum,#pntAmtSum{
	font-weight : bold;
}

#pnt{
	text-align : right;
}
.tab-contents .page_btn_area .btn.disabled, .tab-contents .page_btn_area .btn[disabled]
{
	display: inline !important;
}
</style>

<script type="text/x-jsrender" id="typeTemplate">
{{:pntTxnTpye1CdNm}} / {{:pntTxnType2CdNm}}
</script>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="포인트 이력" /></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<ifvm:inputNew type="button" btnType="search" text="거래 상세" id="txnDtlListBtn"  btnFunc="fnPromotionList" objCode="txnDtlListBtn_obj"/>
		<ifvm:inputNew type="button" text="수동 적립" nuc="true" id="mbrPointAcrl" btnFunc="mbrPointAcrl"  objCode="vocPointButton_obj"/>
		<ifvm:inputNew type="button" text="수동 차감" nuc="true" id="mbrPointRdm" btnFunc="fnVocRdmPointOpen"  objCode="vocPointRdmButton_obj"/>
	     <button class="btn btn-sm btn_gray" id="chngPntPwdYn"  onclick="chngPntPwdYnFn();" objcode="mbrPointChgPntPwd_OBJ" >비밀번호 변경</button>

<%-- 		<ifvm:inputNew type="button" text="이상거래 심사"  id="fileUploadBtn" btnFunc="blackRuleTest" objCode="pntBatchRgstListNewUpload_OBJ"/>
		<ifvm:inputNew type="button" text="포인트 양도" nuc="true" id="mbrPoinGiftBtn"  btnFunc="mbrPoinGiftPop" objCode="mbrPoinGiftBtn_OBJ"/> --%>
		
		<%-- <ifvm:inputNew type="button" text="엑셀 다운로드" nuc="true" id="mbrPointExcelList"  btnFunc="mbrPointExcelList" objCode="mbrPointExcelList_OBJ"/> --%>
     </div>
</div> 
<div class="row">
            <br>
            <div class = "col-xs-12">
                <div class = "col-xs-3">
	                 <div class="col-xs-4">
		                 <select id="searchSelBox">
		                 	<option value="txnUniqNo">주문(영수증)번호</option>
<!-- 		                   	<option value="apprNo">승인번호</option> -->
		                   	<option value="chnlNm">채널</option>
		                   	 <option value="pntTxnType">유형</option>
		                   	
		                 </select>
	                 </div>
	                 <div id="pntTxnType" class="col-xs-7" style="margin-left:5px;">
			                         	<select id="pntTxnTypeNm">
				                        	<option value="100">적립</option>
				                         	<option value="200">사용</option>
				                        </select>
			         </div>
	                 <div class="col-xs-7" id="searchFieldDiv" style="margin-left:5px;">
		                 <input type="text" id="searchVal" name="searchVal"/>
	                 </div>
                 </div>    
                 <div class = "col-xs-9">
			        <ifvm:inputNew type="dateTerm" startDto="startDt" endDto="endDt" startId="startDt" endId="endDt" required="false" label="거래일자" labelClass="1" conClass="3" /> 
			        <div class="col-xs-2 control_content">
			              <ifvm:inputNew type="button" id="searchBtn"  text="M00096" objCode=""/>
			        </div>
			
			         <div class="control_content" id="pnt">
				        <span class="price">결제금액 :</span> <span id ="txnAmtSum">0</span>원 
				         &nbsp; &nbsp; &nbsp; &nbsp; 
				         <span class="price">포인트 :</span> <span id ="pntAmtSum">0</span>point
				      </div>
				
				 
		         </div>
            </div>
            <br>
            <br>
</div>


<div id="mbrPointHistListGrid" class="white_bg grid_bd0"></div>	 
<div id="poinGiftpopupContainer"></div>	 
<div id="rgstPromoDetailPopDiv"></div>
<div id="mbrVocPop"></div>
<div id="mbrRdmPop"></div>
<div id="pwdChangePop"></div>
<div id="pointUseDetailPopDiv"></div>


<script type="text/javascript">
var txnRid=null;
var pntTxnTpye1CdNm = null;
var pntTxnTypeVal =null;
var txnUniqNo = null;

function getMbrPointHistList(startDt, endDt, searchVal){
    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = mbr_rid;
			data.intRidMbr = mbr_rid;
			data.startDt = startDt;
			data.endDt = endDt;
			if( $('#searchSelBox').val() == 'txnUniqNo' ) {
				data.rceptNo = $('#searchVal').val();	
			} 
// 			else if( $('#searchSelBox').val() == 'apprNo' ) {
// 				data.apprNo = searchVal;
// 			} 
			else if( $('#searchSelBox').val() == 'chnlNm' ) {
				data.chnlNm = $('#searchVal').val();
			} else if($('#searchSelBox').val() == 'pntTxnType'){
					data.pntTxnType = $("#pntTxnTypeNm").val();
			}
			return data;
		},rowSelected : function (args) {
			txnRid = args.data.rid;
			pntTxnTpye1CdNm = args.data.pntTxnTpye1CdNm;
			pntTxnTypeVal = args.data.pntTxnType1Cd;
			txnUniqNo =args.data.txnUniqNo;
			txnDtlDesc   = args.data.txnDtlDesc;
			/* if(pntTxnTpye1CdNm=='적립') {
				$("#txnDtlListBtn").attr("disabled",false);
			} else {
				$("#txnDtlListBtn").attr("disabled",true);
			} */
    	},
        dataUrl : '<ifvm:action name="getMbrPointHistList"/>',

        columns : [
        	{
      		  field : 'txnDt', headerText : '거래일자', headerTextAlign : 'center', textAlign : 'center', width:120
      	  },
        	{
    		 field : 'txnDesc', headerText : '거래명', headerTextAlign : 'center', textAlign : 'left', width:300, customAttributes :{searchable : true}
    	  }          
          ,{
              field : 'pntTxnTpye1CdNm', headerText : '유형', headerTextAlign : 'center', textAlign : 'center',width:60, customAttributes : {index : 'pnt_Txn_Type_1_Cd'} 
    	  },{
              field : 'pntTxnType2CdNm', headerText : '상세유형', headerTextAlign : 'center', textAlign : 'center',width:140, customAttributes : {index : 'pnt_Txn_Type_2_Cd'}
    	  } ,{
    		  field : 'txnStatCdNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center', width:70,customAttributes : {index : 'txnStatCd'}
    	  } 
    	  ,{
    		  field : 'chnlNm', headerText : '채널명', headerTextAlign : 'center', textAlign : 'left', width:130,format : '{0:n0}', customAttributes :{searchable : true}

    	  },{
      		  field : 'salesAmt', headerText : '판매가', headerTextAlign : 'center', textAlign: 'right',width:'80', format : '{0:n0}',customAttributes : {index : 'salesAmt'}
	      },{
    		  field : 'txnAmt', headerText : '결제금액', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}', width:80
    	  },{
    		  field : 'pntAmt', headerText : '포인트', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}', width:80
    	  },{
    		  field : 'usablePnt', headerText : '가용포인트', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}', width:100
    	  },{
      		  field : 'rceptNo', headerText : '주문(영수증)번호', headerTextAlign : 'center', textAlign : 'left',width:260,customAttributes :{searchable : true}
      	  },{
      		  field : 'ridMbrInt', headerText : '(구)회원번호', headerTextAlign : 'center', textAlign : 'left',width:110,customAttributes :{searchable : true}
      	  },
    	 {
    		  field : 'rid', visible: false

    	  },{
    		  field : 'txnDesc', visible: false

    	  }
        ],

        requestGridData : {
      	  sidx : 'lpt.appr_dt desc,lpt.APPR_NO',
      	  sord : 'desc'

        },
        gridDataInit: true,
        radio: true,
        tempId: 'ifvGridSimplePageTemplete5'
    };

    mbrPointHistListGrid = $("#mbrPointHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function mbrPointExcelList() {
	$.ifvExcelDn('/loyalty/member/mbr/mbrPointExcelList.do','mbrPointHistListGrid');
}

function mbrPoinGiftPop(){
	alert("현재 지원하지 않는 기능입니다.");ㅣ
	return;
	/* $("#poinGiftpopupContainer").ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : '<ifvm:url name="mbrPointGiftPop"/>',
        contentType : "ajax",
        title : "<spring:message code="포인트 양도"/>",
        width : '1000px',
        close : 'poinGiftPopupClose',
     }); */
}

function chngPntPwdYnFn(){
	$("#pwdChangePop").ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : '<ifvm:url name="pntRdmPwdYnPop"/>',
        contentType : "ajax",
        title : "<spring:message code="포인트 사용 비밀번호 변경"/>",
        width : '600px',
        close : 'pwdChangePopClose',
     });
}

function pwdChangePopClose(){
	pwdChangePop._destroy();
}

function poinGiftPopupClose(){
	poinGiftpopupContainer._destroy();
}

function fnPromotionList(){
	if(mbrPointHistListGrid.opt.gridControl.getSelectedRecords().length == 0){
		alert('<spring:message code="M00285"/>');
		return;
	}
	//100 : 적립 , 200 : 사용
	if(pntTxnTypeVal=="200"){ //사용
		$("#pointUseDetailPopDiv").ifvsfPopup({
        	enableModal : true,
        	enableResize : false,
        	contentUrl : '<ifvm:url name="pointUseDetailPopNew"/>',
       	 	contentType : "ajax",
        	title : "<spring:message code="포인트 사용 상세"/>",
        	width : '1200px',
        	width : '1200px',
        	close : 'pointUseDetailClosePopDiv',
    	});
		
	}else if(pntTxnTypeVal=="100"){  /*포인트 적립일 경우 */
		$("#rgstPromoDetailPopDiv").ifvsfPopup({
        	enableModal : true,
        	enableResize : false,
        	contentUrl : '<ifvm:url name="pointDetailPopNew"/>',
       	 	contentType : "ajax",
        	title : "<spring:message code="포인트 적립 상세"/>",
        	width : '1500px',
        	maxWidth : '1500px',
        	close : 'rgstPromoDetailClosePopDiv',
    	});
	}
}

function pointUseDetailClosePopDiv(){
	pointUseDetailPopDiv._destroy();
}


function rgstPromoDetailClosePopDiv(){
	rgstPromoDetailPopDiv._destroy();
}

function blackRuleTest() {
    alert("현재 지원하지않는 기능입니다.");
    return;
	/* $.ifvSyncPostJSON('<ifvm:action name="blackRuleTest"/>', {
        
    },
    function(result) {
        mbrPointHistListGrid._doAjax();
		alert('<spring:message code="이상정책 실행완료"/>');
    },function(result) {
    	if($.fn.ifvmIsNotEmpty(result.message)) {
    		alert(result.message);
    		return;
    	}
    }); */
}

function mbrPointAcrl() {
	/* var authCheck = true;
	$.ifvSyncPostJSON('<ifvm:action name="validAuthCheck"/>', {
    },function(result){
    	authCheck = true;
    	fnVocPointOpen();
    },function(result){
    	authCheck = false;
		alert('권한이없습니다.');
    });
	return authCheck; */
	if(pntAcrlYn=="불가능"){
		alert("포인트 적립이 불가능한 회원입니다.");
		return;
	}
	fnVocPointOpen();
}

function fnVocPointOpen() {
	$("#mbrVocPop").ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : '<ifvm:url name="mbrVocPop"/>',
        contentType : "ajax",
        title : "<spring:message code='포인트 수동 적립'/>",
        width : '1000px',
        close : 'mbrVocClosePop',
     });
}

function mbrVocClosePop(){
	mbrVocPop._destroy();
}

function fnVocRdmPointOpen() {
	
	if(pntRdmYn=="불가능"){
		alert("포인트 차감이 불가능한 회원입니다.");
		return;
	}
	
	$("#mbrRdmPop").ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : '<ifvm:url name="mbrRdmPop"/>',
        contentType : "ajax",
        title : "<spring:message code="포인트 수동 차감"/>",
        width : '1000px',
        close : 'mbrRdmClosePop',
     });
}

function mbrRdmClosePop(){
	mbrRdmPop._destroy();
}

// 거래일자에 따라 검색해오는 함수
function searchDate(){
    var startDt = $('#startDt').val();
	var endDt = $('#endDt').val();
	if(startDt != "" && endDt != ""){
	    searchChnlName(startDt, endDt)
	}else{
		alert('<spring:message code="L01859"/>');
	}
}

function searchChnlName(startDt,endDt){
    var searchVal = $('#searchVal').val();
    getMbrPointHistList(startDt, endDt, searchVal);
}

// 거래일자 날짜범위필드 날짜값 설정
function setCalendar() {
	 var startDate = $('#startDt');
	 var endDate = $('#endDt');
 	//startDate.val($.ifvGetTodayDate());
	 startDate.val($.ifvGetNewDate('y01', -1).newDateS); // startDate는 디폴트로 3달 전
	 endDate.val($.ifvGetTodayDate()); // endDate는 오늘까지
	 
	 startDate.ifvDateChecker({
	  maxDate : endDate
	 });

	 endDate.ifvDateChecker({
	  minDate : startDate
	 });
}

function setComma(value){
    var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
    value += '';                          // 숫자를 문자열로 변환
    while (reg.test(value)) {
   	 value = value.replace(reg, '$1' + ',' + '$2');
    }
    return value;
}

function priceSetting(){
	$.ifvSyncPostJSON(	'<ifvm:action name="getMbrPntHistSumList"/>',
	{
		ridMbr : mbr_rid
		,startDt : $('#startDt').val()
		,endDt : $('#endDt').val()
	},
	function(result) {
		$("#txnAmtSum")[0].innerHTML =setComma(result.rows[0].txnAmtSum);
		
		$("#pntAmtSum")[0].innerHTML =setComma(result.rows[0].pntAmtSum);
	});
}

function searchBoxChange() {
	if($('#searchSelBox').val() != 'pntTxnType') { // 검색셀렉트박스가 '채널명'일 경우
		$('#pntTxnType').hide();
		$('#searchFieldDiv').show();
		$('#pntTxnTypeNm').val(null); // 채널명필드값은 없는 상태이므로 null로 초기화(""가 됨)
	} else {
		$('#pntTxnType').show();
		$('#searchFieldDiv').hide();
		$('#searchVal').val(null);
	}
}

$(document).ready(function(){
	searchBoxChange();
	setCalendar();
	getMbrPointHistList();
	priceSetting();
	
	if($("#custTypeCd").val()=="I"){ // I 개인
		if(mbrTypeCd=="M1"){
			$("#chngPntPwdYn").prop('disabled', true); //비번 수정 불가능
		}else if(mbrTypeCd=="M2"){
			$("#chngPntPwdYn").prop('disabled', true); //비번 수정 불가능
		}else if(mbrTypeCd=="M3"){
			// 통합회원
			$("#chngPntPwdYn").prop('disabled', false); //비번 수정 가능
		}
	}else if($("#custTypeCd").val()=="C" || $("#custTypeCd").val()=="E"){
		$("#chngPntPwdYn").prop('disabled', false);	//비번 수정 가능
	}else if($("#custTypeCd").val()=="D" || $("#custTypeCd").val()=="O"||$("#custTypeCd").val()=="X"){
		$("#chngPntPwdYn").prop('disabled', true); 	//비번 수정 불가

	}
	
	
	
	$("#searchBtn").click(function(){
		searchDate();
		priceSetting();
	});
	$('#searchSelBox').change(function(){
		searchBoxChange();
	});


});

</script>