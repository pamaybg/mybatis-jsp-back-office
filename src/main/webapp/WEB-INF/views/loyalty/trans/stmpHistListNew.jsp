<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var stmpHistList;

function getStmpHistListSearch(){
	var ejGridOption = {
		recordDoubleClick : function(args){
			
        },
        rowSelected : function (data) {
        	
        },
		serializeGridData : function( data ){
        	if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
            }
            return data;
        },
        loadComplete : function(obj){
        	
        },
        dataUrl : '<ifvm:action name="getTransStmpHistList"/>',
        columns : [
				{
					field : 'stmpTxnNo', headerText : '스탬프 거래번호', headerTextAlign : 'center', textAlign : 'left', width : '130px',
					customAttributes : {
					index : 'lst.STMP_TXN_NO' }
				},{
					field : 'txnUniqNo', headerText : '포인트 거래번호', headerTextAlign : 'center', textAlign : 'left', width : '130px',
					customAttributes : {
					index : 'lpt1.TXN_UNIQ_NO' }
				},{
					field : 'txnDt', headerText : '거래일시', headerTextAlign : 'center', textAlign : 'center', width : '100px',
					customAttributes : {
					index : 'lpt1.TXN_DT' }
				},{
					field : 'apprDt', headerText : '승인일시', headerTextAlign : 'center', textAlign : 'center', width : '100px',
					customAttributes : {
					index : 'lpt1.APPR_DT' }
				},{
					field : 'chnlNo', headerText : '매장코드', headerTextAlign : 'center', textAlign : 'left', width : '100px',
					customAttributes : {
					index : 'lc.CHNL_NO' }
				},{
					field : 'chnlNm', headerText : '매장명', headerTextAlign : 'center', textAlign : 'left', width : '100px',
					customAttributes : {
					index : 'lc.CHNL_NM' }
				},{
					field : 'purAmt', headerText : '구매금액', headerTextAlign : 'center', textAlign : 'right', width : '80px', format : "{0:n0}",
					customAttributes : {
					index : 'lst.PUR_AMT' }
				},{
					field : 'stmpTxnStatusNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center' , width : '80px',
					customAttributes : {
					index : 'c1.MARK_NAME' }
				},{
					field : 'orgTxnUniqNo', headerText : '포인트 원거래번호', headerTextAlign : 'center', textAlign : 'left', width : '130px',
					customAttributes : {
					index : 'lpt2.TXN_UNIQ_NO' }
				}
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'lst.reg_dt',
      	  sord : 'desc',
      	  _search : false
        },
        gridDataInit: false,
    };
	stmpHistList = $("#stmpHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function stmpHistListSearchInit() {
    $.fn.ifvmSetCommonCondList("stmpHistListSearchList","STMP_HIST_001");
}

//공통 조회 호출
function stmpHistListSearch() {
    $.fn.ifvmSubmitSearchCondition("stmpHistListSearchList", function(){
    	stmpHistList.searchGrid({item: requestitem});
    });
}

//엑셀 다운로드
function excelDownStmpFn() {
	$.ifvExcelDn('/loyalty/trans/excelDownStmpHistList.do','stmpHistListGrid');
}

$(document).ready(function() {
	stmpHistListSearchInit();
	getStmpHistListSearch();
});
</script>

<div class="page-title">
    <h1>
        스탬프 거래 리스트
        &gt;<spring:message code="L00081"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="search"  text="M00135"  id="stmpHistListSearchBtn" btnFunc="stmpHistListSearch"/>
            <ifvm:inputNew type="button"   text="M00278"  id="stmpHistListSearchInitBtn" btnFunc="stmpHistListSearchInit"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="stmpHistListSearchList">
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="save" text="M01356" btnFunc="excelDownStmpFn"/>
        </div>
    </div>
    <div id="stmpHistListGrid" class="white_bg grid_bd0"></div>
</div>
