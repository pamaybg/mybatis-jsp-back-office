<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 선물한 회원 상세 이동 -->
<script type="text/x-jsrender" id="ValidDateFormat">
	{{:validStartDate}} ~ {{:validEndDate}}
</script>

<!-- 선물한 회원 상세 이동 -->
<script type="text/x-jsrender" id="goFromMbrDetailPntGiftHistList">
	<span style="color:#1266FF; text-decoration:underline;">{{:mbrNoFrom}}</span>
</script>

<!-- 선물받은 회원 상세 이동 -->
<script type="text/x-jsrender" id="goToMbrDetailPntGiftHistList">
	<span style="color:#1266FF; text-decoration:underline;">{{:mbrNoTo}}</span>
</script>

<script type="text/javascript">

var pntGiftHistList;

function getPntGiftHistListSearch(){
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
        dataUrl : '<ifvm:action name="getTransPntGiftHistList"/>',
        columns : [
				{
					field : 'mbrNoFrom', headerText : '선물한 회원번호', headerTextAlign : 'center', textAlign : 'center', template : "#goFromMbrDetailPntGiftHistList", width : '110px',
					customAttributes : {
					index : 'lmFrom.MBR_NO' }
				},{
					field : 'custNmFrom', headerText : '선물한 회원명', headerTextAlign : 'center', textAlign : 'center', width : '110px',
					customAttributes : {
					index : 'lcFrom.CUST_NM' }
				},{
					field : 'mbrNoTo', headerText : '선물받은 회원번호', headerTextAlign : 'center', textAlign : 'center', template : "#goToMbrDetailPntGiftHistList", width : '110px',
					customAttributes : {
					index : 'lmTo.MBR_NO' }
				},{
					field : 'custNmTo', headerText : '선물받은 회원명', headerTextAlign : 'center', textAlign : 'center', width : '110px',
					customAttributes : {
					index : 'lcTo.CUST_NM' }
				},{
					field : 'txnUniqNoFrom', headerText : '선물한 거래번호', headerTextAlign : 'center', textAlign : 'left',
					customAttributes : {
					index : 'lptRdm.TXN_UNIQ_NO' }
				},{
					field : 'txnUniqNoTo', headerText : '선물받은 거래번호', headerTextAlign : 'center', textAlign : 'left',
					customAttributes : {
					index : 'lptAcrl.TXN_UNIQ_NO' }
				},{
					field : 'regDt', headerText : '선물일시', headerTextAlign : 'center', textAlign : 'center', width : '150px',
					customAttributes : {
					index : 'lpgh.REG_DT' }
				},{
					field : 'giftPnt', headerText : '선물포인트', headerTextAlign : 'center', textAlign : ej.TextAlign.Right , format : "{0:n0}", width : '110px',
					customAttributes : {
					index : 'lpgh.GIFT_PNT' }
				},{
					field : 'apprNoFrom', headerText : '선물한 승인번호', headerTextAlign : 'center', textAlign : 'left', width : '110px',
					customAttributes : {
					index : 'lptRdm.APPR_NO' }
				},{
					field : 'apprNoTo', headerText : '선물받은 승인번호', headerTextAlign : 'center', textAlign : 'left', width : '110px',
					customAttributes : {
					index : 'lptAcrl.APPR_NO' }
				},{
					field : 'validEndDate', headerText : '포인트 유효기간', headerTextAlign : 'center', textAlign : 'center', template : "#ValidDateFormat", width : '180px',
					customAttributes : {
					index : 'lpaAcrl.VALID_END_DATE' }
// 				},{
// 					field : 'apprDateFrom', headerText : '선물한 승인일시', headerTextAlign : 'center', textAlign : 'center',
// 					customAttributes : {
// 					index : 'lptRdm.APPR_DATE' }
// 				},{
// 					field : 'apprDateTo', headerText : '선물받은 승인일시', headerTextAlign : 'center', textAlign : 'center',
// 					customAttributes : {
// 					index : 'lptAcrl.APPR_DATE' }
				},{
					field : 'ridMbrFrom', headerText : 'ridMbrFrom', headerTextAlign : 'center', textAlign : 'center', visible : false,
					customAttributes : {
					index : 'lmFrom.RID' }
				},{
					field : 'ridMbrTo', headerText : 'ridMbrTo', headerTextAlign : 'center', textAlign : 'center', visible : false,
					customAttributes : {
					index : 'lmTo.RID' }
				}
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'lpgh.reg_dt',
      	  sord : 'desc',
      	  _search : false
        },
        gridDataInit: false,
        tempId : 'ifvGridSimplePageTemplete2'
    };
	pntGiftHistList = $("#pntGiftHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function pntGiftHistListSearchInit() {
    $.fn.ifvmSetCommonCondList("pntGiftHistListSearchList","PNT_GIFT_001");
}

//공통 조회 호출
function pntGiftHistListSearch() {
    $.fn.ifvmSubmitSearchCondition("pntGiftHistListSearchList", function(){
    	pntGiftHistList.searchGrid({item: requestitem});
    });
}

//엑셀 다운로드
function excelDownPntGiftFn() {
	$.ifvExcelDn('/loyalty/trans/excelDownPntGiftHistList.do','pntGiftHistListGrid');
}

$(document).ready(function() {
	pntGiftHistListSearchInit();
	getPntGiftHistListSearch();
});
</script>

<div class="page-title">
    <h1>
        포인트 선물하기 리스트
        &gt;<spring:message code="L00081"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="search"  text="M00135"  id="pntGiftHistListSearchBtn" btnFunc="pntGiftHistListSearch"/>
            <ifvm:inputNew type="button"   text="M00278"  id="pntGiftHistListSearchInitBtn" btnFunc="pntGiftHistListSearchInit"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="pntGiftHistListSearchList">
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="save" text="M01356" btnFunc="excelDownPntGiftFn"/>
        </div>
    </div>
    <div id="pntGiftHistListGrid" class="white_bg grid_bd0"></div>
</div>
