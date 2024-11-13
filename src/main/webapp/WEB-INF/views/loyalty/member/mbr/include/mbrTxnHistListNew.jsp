<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
#settleAmtSum,#discntAmtSum, #sellAmtSum ,#settleDeliSum ,#settleDeliCnt{
	font-weight : bold
}

#pnt{
text-align : right;

}


</style>

<style type="text/css">
.descript{
	width : 98%;
	height: 10%;
	font-size: 13px;
	box-sizing: border-box;
	margin: 10px;
	padding: 10px;

}
#mbrTxnHist {
 min-height : 0px;

}
#mbrTxnHistListGrid {
 min-height: 235px;

}

</style>
<div class="page_btn_area" >
     <div class="col-xs-7">
     	<span><spring:message code="구매 이력" /></span>
     </div>
     <div class="col-xs-5 searchbtn_r">
		<%-- <ifvm:inputNew type="button" text="포인트" nuc="true" id="acrlMileagePopOpen"  btnFunc="acrlMileagePopOpen" /> --%>
<%-- 		<ifvm:inputNew type="button" text="적립"  id="purAcrlPointBtn" names="purAcrlPointBtn" btnFunc="purAcrlPoint"/> --%>
		<ifvm:inputNew type="button" text="구매이력 상세"  id="buyDetailBtn" names="buyDetailBtn" btnFunc="buyDetailBtn" objCode="mbrTxnHistDetail_OBJ"/>
		<%-- <ifvm:inputNew type="button" text="수하물 적립"  id="packageAcrlPointBtn" names="packageAcrlPointBtn" btnFunc="packageAcrlPoint"/> --%>
		<ifvm:inputNew type="button" text="M01218" id="mbrTxnHistExcelList"  btnFunc="mbrTxnHistExcelList" objCode="mbrTxnHistExcelList_OBJ"/> <!-- 다운로드 버튼 -->
     </div>
</div>
<div class="row">
            <br>
            <div class = "col-xs-12">
                        <div class = "col-xs-3">
                                  <%-- <ifvm:inputNew type="text" id="chnlName"  label="채널명" labelClass="3" conClass="9" /> --%>
			                        <div class="col-xs-4">
				                        <select id="searchSelBox">
				                        	<option value="optChnlNm">매장명</option>
				                         	<option value="optDivision">구분</option>
				                         	<option value="optBillNo">거래(주문)번호</option>
				                         	<option value="optSalesType">판매유형</option>
				                        </select>
			                        </div>
			                        
			                        <div id="chnlFieldDiv" class="col-xs-7" style="margin-left:5px;">
				                        <input type="text" id="chnlName" name="chnlName"/>
			                        </div>
			                        <div id="divisionFieldDiv" class="col-xs-7" style="margin-left:5px;">
			                         	<select id="divisionName">
				                        	<option value="온라인">온라인</option>
				                         	<option value="오프라인">오프라인</option>
				                        </select>
			                        </div>
			                         <div id="salesType" class="col-xs-7" style="margin-left:5px;">
			                         	<select id="salesTypeName">
				                        	<option value="판매">판매</option>
				                         	<option value="취소">취소</option>
				                        </select>
			                        </div>
			                        <div id="billFieldDiv" class="col-xs-7" style="margin-left:5px;">
				                        <input type="text" id="billNo" name="billNo"/>
			                        </div>
                                  	 
                        </div>    
                        <div class = "col-xs-9">
				                  <ifvm:inputNew type="dateTerm" startDto="startDt" endDto="endDt" startId="startDt" endId="endDt" required="false" label="매출일자" labelClass="1" conClass="3" />
				                  <div class="col-xs-2 control_content">
				                          <ifvm:inputNew type="button" id="searchBtn"  text="M00096" objCode="mbrTxnHistListSearch_OBJ"/>
				                  </div>
				                  
				                  <%--<div class="control_content" id="pnt">
				                  <!--  판매금액 : <span id ="sellAmtSum">0</span>원 &nbsp; &nbsp; &nbsp; &nbsp; 
				              	 할인금액 : <span id ="discntAmtSum">0</span>원 &nbsp; &nbsp; &nbsp; &nbsp;  -->
				                    실결제금액 : <span id ="settleAmtSum">0</span>원 
				                     &nbsp; &nbsp; &nbsp; &nbsp; 
				          (통합회원)배송완료 : <span id ="settleDeliSum">0</span>원
				                    / <span id ="settleDeliCnt">0</span>회
				                  </div> --%>
		                  </div>
		                 
            </div>
            <br>
            <br>
<!-- 				<div class = "col-xs-9 control_content"> -->
<%-- 						<label class="col-xs-1 control-label"><spring:message code="거래일자"/></label> --%>
<!-- 						<div class="col-xs-4 control_content"> -->
<%-- 							<ifvm:inputNew type="dateTerm" startDto="startDt" endDto="endDt" startId="startDt" endId="endDt" nuc="true"/>  --%>
<!-- 						</div> -->
<!-- 						<div class="col-xs-4 control_content"> -->
<%-- 							<ifvm:inputNew type="button" id="searchBtn"  text="M00096" objCode=""/> --%>
<!-- 						</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
</div>
<div class ="row white_bg">
    <div id="mbrTxnHistListGrid" class="white_bg grid_bd0"></div>
</div>	

<%--<div id="mbrTxnHist" class="white_bg grid_bd0"></div>
         <div class="page_btn_area" >
   		<div class="col-xs-9">
		 <span>용어설명</span>
    	</div>
    </div>
<textarea id="desc" class = "descript" maxlength="100" rows="7" readonly = true>
• 정상가총액 : 상품 정상가 * 수량 (배송비 미포함)
• 실결제금액 : 정상가총액  - 총할인금액 + 배송비
• 총할인금액 : 온/오프 할인액 + 사용적립금
• 배송비       : 구매 시 발생한 배송비
• 사용적립금 : 거래에서 사용한 적립금
• 발생적립금 : 적립금 산출 요청금액(실결제금액 - 배송비)을 기준으로 발생된 적립금
</textarea>--%>

<div id="acrlMileagePopup" class="popup_container"></div>	 
<div id="buyDetailPopup" class="popup_container"></div>    
<div id="buyDetailPopupOnline" class="popup_container"></div>    


<script type="text/javascript">
var rowData;
var rid=null;
function buyDetailBtn(){

    var v_rid = null;
    if ($.fn.ifvmIsNotEmpty(mbrTxnHistListGrid.opt.gridControl.getSelectedRecords()[0])) {
        v_rid = mbrTxnHistListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M00004"/>');
    }

	if($.fn.ifvmIsNotEmpty(v_rid)){
		$("#buyDetailPopup").ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : '<ifvm:url name="purDetailPop"/>',
			contentType : "ajax",
			title : '구매이력 상세',
			width : 1200,
			maxWidth : '100%',
			close : 'buyDetailPopClose',
		});
	}

    /*if ($.fn.ifvmIsNotEmpty(v_rid)&& bsalClsCd=="오프라인") {
		    $("#buyDetailPopup").ifvsfPopup({
		        enableModal : true,
		        enableResize: false,
		        contentUrl: '<ifvm:url name="buyDetailPop"/>',
		        contentType: "ajax",
		        title: '구매이력 상세',
		        width: 1700,
		        maxWidth : 1700,
		        close : 'buyDetailPopClose'
		    });
    }
    
    
    else if ($.fn.ifvmIsNotEmpty(v_rid)&& bsalClsCd=="온라인") {
	    $("#buyDetailPopupOnline").ifvsfPopup({
	        enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="buyDetailPopOnline"/>',
	        contentType: "ajax",
	        title: '구매이력 상세',
	        width: 1700,
	        maxWidth : 1700,
	        close : 'buyDetailPopCloseOnline'
	    });
	    
	}*/
   }
   
 function buyDetailPopCloseOnline(){
	 buyDetailPopupOnline._destroy();
 }  

function buyDetailPopClose() {
    buyDetailPopup._destroy();
} 
function getMbrTxnHistList(startDt, endDt,chnlNameGrid){
    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = mbr_rid;
			data.intRidMbr = mbr_rid;
			data.intMbrNo = mbr_no;
			data.startDt = $('#startDt').val();
			data.endDt = $('#endDt').val();
			data.chnlNameGrid = $('#chnlName').val();
			data.srcTypeNm = $('#divisionName').val(); // '구분(divisionName)'필드 내용이 srcTypeNm임
			data.billNo = $('#billNo').val();
			data.salesTypeName = $('#salesTypeName').val();
			var slrtClsCd = null;
			if($('#salesTypeName').val() == '판매') slrtClsCd = '01';
			else if($('#salesTypeName').val() == '취소') slrtClsCd = '02';
			data.slrtClsCd = slrtClsCd;
			data.mbrStatCd = $("#mbrStatCd").val();
			return data;
		},loadComplete : function(obj){
			//에러로인한 임시 주석
			//mbrTxnHistListGrid.opt.gridControl.selectRows(0);
        },
        rowSelected : function(args) {
            rid = args.data.rid;
			bsalClsCd = args.data.bsalClsCd;
        },	recordDoubleClick : function (args) {
			buyDetailBtn();
	 	 },
        dataUrl : '<ifvm:action name="getMbrTxnHistList"/>',

        columns : [
            {
                field : 'bsalClsCd', headerText : '<spring:message code="L00616"/>',  textAlign : 'center', customAttributes : {index : 'bsalClsCd'},width:65
            } 
            ,{
                field : 'brdNm', headerText : '<spring:message code="L02927"/>',  textAlign : 'center',width:70
            }
			,{
                field : 'saleDate', headerText : '<spring:message code="O00172"/>',  textAlign : 'center', customAttributes : {index : 'saleDate'},width:125
            }
            ,{
                field : 'ordNo', headerText : '거래(주문)번호', textAlign : 'center', customAttributes :{index : 'ordNo'},width:145
            }
            ,{
                field : 'saleProdNm', headerText : '거래명',  textAlign : 'left', customAttributes : {index : 'saleProdNm'},width:250
            }
           ,{
    		  field : 'sellTypeCd', headerText : '거래유형', textAlign : 'center', customAttributes : {index : 'sellTypeCd'},width:60
    	  	}
           ,{
    		  field : 'sellAmt', headerText : '정상가총액', format : '{0:n0}', textAlign : 'right', customAttributes : {index : 'sellAmt'},width:70
    	  	} 
        	,{
    		  field : 'actAmt', headerText : '실결제금액',  format : '{0:n0}', textAlign : 'right',customAttributes : {index : 'actAmt'},width:70
    	  	}
        	,{
                field : 'discntAmt', headerText : '총할인금액', format : '{0:n0}', textAlign : 'right',customAttributes : {index : 'discntAmt'},width:70
            },{
                field : 'dlvAmt', headerText : '배송비', format : '{0:n0}', textAlign : 'right',customAttributes : {index : 'dlvAmt'},width:70
            }
        	,{
      		  field : 'rdmPoint', headerText : '사용적립금', format : '{0:n0}', textAlign : 'right',customAttributes : {index : 'rdmPoint'},width:100
      	  	}
            /*,{
                field : 'acrlPoint', headerText : '발생적립금', format : '{0:n0}', textAlign : 'right', customAttributes :{index : 'acrlPoint'},width:70
            }*/
            ,{
                field : 'chnlNm', headerText : '매장명', textAlign : 'center', customAttributes :{index: 'chnlNm'},width:160
            }
           /*  ,{
                field : 'chnlNo', headerText : '매장번호', textAlign : 'center', customAttributes :{index : 'chnlNo'},width:75
            } */
			/*,{
                field : 'posNo', headerText : 'POS', textAlign : 'center', customAttributes :{index : 'posNo'},width:50
            }*/,{
                field : 'cancleDate', headerText : '취소일자', textAlign : 'center', customAttributes :{index : 'cancleDate'},width:110
            }
			/*,{
                field : 'mbrNo', headerText : '(구)회원번호', textAlign : 'center', customAttributes :{index : 'posNo'},width:100
            }*/
            ,{
                field : 'rid', headerText : 'rid', visible : false
            }
        ],

        requestGridData : {
      	  sidx : 'saleDate',
      	  sord : 'desc'
        },
        rowList : [10,25,50,100],
        radio: true,
        isHorizontalScroll : true,
        tempId : 'ifvGridSimplePageTemplete5'
    };

    mbrTxnHistListGrid = $("#mbrTxnHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function mbrTxnHistExcelList() {
	$.ifvExcelDn('/loyalty/member/mbr/mbrTxnHistExcelList.do','mbrTxnHistListGrid');
}

/* function acrlMileagePopOpen() {
	$("#acrlMileagePopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '/demo/koreanair/popup/acrlMileagePop',
        contentType: "ajax",
        title: '포인트 적립',
        width: 400,
        close : 'acrlMileagePopClose'
    });
}

function acrlMileagePopClose() {
	acrlMileagePopup._destroy();
} */


function setCalendar() {
	 var startDate = $('#startDt');
	 var endDate = $('#endDt');
	 //오늘날짜
	 startDate.val($.ifvGetTodayDate());
	 startDate.val($.ifvGetNewDate('y01', -1).newDateS);
	 //오늘부터 한달 뒤
	 endDate.val($.ifvGetTodayDate());

	 //
	 
	 startDate.ifvDateChecker({
	  maxDate : endDate
	 });

	 endDate.ifvDateChecker({
	  minDate : startDate
	 });
}
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
    var chnlNameGrid = $('#chnlName').val();
   getMbrTxnHistList(startDt, endDt,chnlNameGrid);
}
//적립(H)
function purAcrlPoint(){
	var v_rid = null;
	if ($.fn.ifvmIsNotEmpty(mbrTxnHistListGrid.opt.gridControl.getSelectedRecords()[0])) {
		v_rid = mbrTxnHistListGrid.opt.gridControl.getSelectedRecords()[0].purHeadRid;
	}
	else {
	    alert('<spring:message code="M00004"/>');
	}
	if ($.fn.ifvmIsNotEmpty(v_rid)) {
		if(confirm('<spring:message code="적립하시겠습니까?"/>')){
			$.ifvSyncPostJSON('<ifvm:action name="purAcrlPointProc"/>',{pgmRid : pgmRid, purHeadRid : v_rid, value : 'H'},function(result){
				if(result.message) alert(result.message);
				else alert('적립되었습니다.')
				//mbrTxnHistListGrid._doAjax();
				//qtjs.href('<ifvm:url name="mbrDetailNewPage"/>'+'?rid='+mbr_rid);
			});
		}
	}
}
//수화물적립(I)
function packageAcrlPoint(){
	var v_rid = null;
	if ($.fn.ifvmIsNotEmpty(mbrTxnHistListGrid.opt.gridControl.getSelectedRecords()[0])) {
		v_rid = mbrTxnHistListGrid.opt.gridControl.getSelectedRecords()[0].purHeadRid;
	}
	else {
	    alert('<spring:message code="M00004"/>');
	}
	if ($.fn.ifvmIsNotEmpty(v_rid)) {
		if(confirm('<spring:message code="적립하시겠습니까?"/>')){
			$.ifvSyncPostJSON('<ifvm:action name="purAcrlPointProc"/>',{pgmRid : pgmRid, purHeadRid : v_rid, value : 'I'},function(result){
				if(result.message) alert(result.message);
				else alert('적립되었습니다.')

			});
		}
	}
}

function priceSetting(){
	$.ifvSyncPostJSON(	'<ifvm:action name="getMbrTxnHistSumList"/>',
	{
		ridMbr : mbr_rid
		,startDt : $('#startDt').val()
		,endDt : $('#endDt').val()
		,intRidMbr : mbr_rid
		,mbrStatCd : $("#mbrStatCd").val()
	},
	function(result) {
		//$("#sellAmtSum")[0].innerHTML =setComma(result.rows[0].sellAmtSum);
		//$("#discntAmtSum")[0].innerHTML =setComma(result.rows[0].discntAmtSum);
		if($.fn.ifvmIsNotEmpty(result)){
			$("#settleAmtSum")[0].innerHTML =setComma(result.rows[0].settleAmtSum);
		}
	});
}

function priceDeliSetting(){
	$.ifvSyncPostJSON(	'<ifvm:action name="getMbrTxnHistDeliSumList"/>',
	{
		rid : mbr_rid
		,startDt : $('#startDt').val()
		,endDt : $('#endDt').val()
		,mbrStatCd : $("#mbrStatCd").val()
	},
	function(result) {
		//$("#sellAmtSum")[0].innerHTML =setComma(result.rows[0].sellAmtSum);
		//$("#discntAmtSum")[0].innerHTML =setComma(result.rows[0].discntAmtSum);
		if($.fn.ifvmIsNotEmpty(result)){
			$("#settleDeliSum")[0].innerHTML =setComma(result.rows[0].settleDeliSum);
			$("#settleDeliCnt")[0].innerHTML =setComma(result.rows[0].settleDeliCnt);
		}
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
$(document).ready(function(){
	

	// 맨 처음 로드 시 조회박스 선택항목에 따라 입력필드 변화 // text필드에는 jquery로 null로 초기화를 해줘도(.val(null)) ""로 표시된다.
	if($('#searchSelBox').val() == 'optChnlNm') { // 검색셀렉트박스가 '채널명'일 경우
		$('#chnlFieldDiv').show();
		$('#billFieldDiv').hide();
		$('#billNo').val(null); // 채널명필드값은 없는 상태이므로 null로 초기화(""가 됨)
		$('#divisionFieldDiv').hide();
		$('#divisionName').val(null); // 구분필드값은 없는 상태이므로 null로 초기화
		$('#salesType').hide();
		$('#salesTypeName').val(null); // 구분필드값은 없는 상태이므로 null로 초기화)
	} else if($('#searchSelBox').val() == 'optDivision') {// 검색셀렉트박스가 '구분'일 경우
		$('#divisionFieldDiv').show();
		$('#divisionName').val('판매');
		$('#billFieldDiv').hide();
		$('#billNo').val(null); // 채널명필드값은 없는 상태이므로 null로 초기화(""가 됨)
		$('#chnlFieldDiv').hide();
		$('#chnlName').val(null); // 채널명필드값은 없는 상태이므로 null로 초기화(""가 됨)
		$('#salesType').hide();
		$('#salesTypeName').val(null); // 구분필드값은 없는 상태이므로 null로 초기화
	} else if($('#searchSelBox').val() == 'optSalesType') {// 검색셀렉트박스가 '구분'일 경우
		$('#salesType').show();
		$('#salesTypeName').val('판매');
		$('#billFieldDiv').hide();
		$('#billNo').val(null); // 채널명필드값은 없는 상태이므로 null로 초기화(""가 됨)
		$('#chnlFieldDiv').hide();
		$('#chnlName').val(null); // 채널명필드값은 없는 상태이므로 null로 초기화(""가 됨)
		$('#divisionFieldDiv').hide();
		$('#divisionName').val(null); // 구분필드값은 없는 상태이므로 null로 초기화
	} else if($('#searchSelBox').val() == 'optBillNo'){
		$('#billFieldDiv').show();
		$('#chnlFieldDiv').hide();
		$('#chnlName').val(null); // 채널명필드값은 없는 상태이므로 null로 초기화(""가 됨)
		$('#divisionFieldDiv').hide();
		$('#divisionName').val(null); // 구분필드값은 없는 상태이므로 null로 초기화
		$('#salesType').hide();
		$('#salesTypeName').val(null); // 구분필드값은 없는 상태이므로 null로 초기화
	}
	
	setCalendar();
	getMbrTxnHistList();
	
	// 조회박스 선택항목에 따라 입력필드 변화
	$('#searchSelBox').change(function(){
		if($('#searchSelBox').val() == 'optChnlNm') { // 검색셀렉트박스가 '채널명'일 경우
			$('#chnlFieldDiv').show();
			$('#billFieldDiv').hide();
			$('#billNo').val(null); // 채널명필드값은 없는 상태이므로 null로 초기화(""가 됨)
			$('#divisionFieldDiv').hide();
			$('#divisionName').val(null); // 구분필드값은 없는 상태이므로 null로 초기화
			$('#salesType').hide();
			$('#salesTypeName').val(null); // 구분필드값은 없는 상태이므로 null로 초기화
		} else if($('#searchSelBox').val() == 'optDivision') {// 검색셀렉트박스가 '구분'일 경우
			$('#divisionFieldDiv').show();
			$('#divisionName').val('온라인');
			$('#billFieldDiv').hide();
			$('#billNo').val(null); // 채널명필드값은 없는 상태이므로 null로 초기화(""가 됨)
			$('#chnlFieldDiv').hide();
			$('#chnlName').val(null); // 채널명필드값은 없는 상태이므로 null로 초기화(""가 됨)
			$('#salesType').hide();
			$('#salesTypeName').val(null); // 구분필드값은 없는 상태이므로 null로 초기화
		} else if($('#searchSelBox').val() == 'optSalesType') {// 검색셀렉트박스가 '구분'일 경우
			$('#salesType').show();
			$('#salesTypeName').val('판매');
			$('#billFieldDiv').hide();
			$('#billNo').val(null); // 채널명필드값은 없는 상태이므로 null로 초기화(""가 됨)
			$('#chnlFieldDiv').hide();
			$('#chnlName').val(null); // 채널명필드값은 없는 상태이므로 null로 초기화(""가 됨)
			$('#divisionFieldDiv').hide();
			$('#divisionName').val(null); // 구분필드값은 없는 상태이므로 null로 초기화
		} else if($('#searchSelBox').val() == 'optBillNo'){
			$('#billFieldDiv').show();
			$('#chnlFieldDiv').hide();
			$('#chnlName').val(null); // 채널명필드값은 없는 상태이므로 null로 초기화(""가 됨)
			$('#divisionFieldDiv').hide();
			$('#divisionName').val(null); // 구분필드값은 없는 상태이므로 null로 초기화
			$('#salesType').hide();
			$('#salesTypeName').val(null); // 구분필드값은 없는 상태이므로 null로 초기화
		}
	});
	
	$("#searchBtn").click(function(){
		searchDate();
		 //priceSetting();
		 //priceDeliSetting();
	});
	//priceSetting();
	//priceDeliSetting();

});

</script>