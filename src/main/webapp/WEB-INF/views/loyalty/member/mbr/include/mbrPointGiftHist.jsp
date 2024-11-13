<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="mbrPointGiftHistListGrid" class="white_bg grid_bd0"></div>

<script type="text/x-jsrender" id="giftCommentTemp">
   <span title="{{:giftComment}}">{{:giftComment}}</span>
</script>

<script type="text/x-jsrender" id="txnUniqNoTemp">
   <span title="{{:txnUniqNo}}">{{:txnUniqNo}}</span>
</script>

<script type="text/javascript">
var rid;
var mbrPointGiftHistList;

function getGiftPointHistList(){
	var ejGridOption = {
			serializeGridData : function(data) {
				if ($.fn.ifvmIsNotEmpty(requestitem)) {
					data.item = requestitem;
				}
				data.rid = mbr_rid;
				return data;
			},
			rowSelected : function (args) {
				rid = args.data.rid;
	        },
	        dataUrl : '<ifvm:action name="getGiftPointHistList"/>',
			columns : [
			 	{
					field : 'txnUniqNo', headerText : '<spring:message code="거래번호"/>',  textAlign : 'center', customAttributes :{searchable : true}, template: "#txnUniqNoTemp"
				}, {
					field : 'txnDate', headerText : '<spring:message code="거래일자"/>',  textAlign : 'center', customAttributes :{searchable : false}, width : '9%'
				}, {
					field : 'custNm', headerText : '<spring:message code="양도회원"/>', textAlign : 'center', width : '8%'
				}, {
					field : 'tgtCustNm', headerText : '<spring:message code="양도받은회원"/>',  textAlign : 'center', width : '10%'
				}, {
					field : 'pntAmt', headerText : '<spring:message code="포인트"/>',  textAlign : 'center', width : '7%'
				}, /* {
					field : 'feeAmt', headerText : '<spring:message code="수수료"/>', textAlign : 'center', width : '7%'
				}, {
					field : 'feeLevyCdNm', headerText : '<spring:message code="수수료부과유형"/>',  textAlign : 'center', customAttributes :{index : 'feeLevyCd'}, width : '11%'
				}, {
					field : 'feeRcptNo', headerText : '<spring:message code="수수료영수증"/>',  textAlign : 'center', width : '10%'
				}, */ {
					field : 'giftComment', headerText : '<spring:message code="사유"/>',  textAlign : 'center', template: "#giftCommentTemp"
				}, {
					field : 'rid', headerText : 'rid', visible : false,
				} ],
			 requestGridData : {
				sidx : 'A.txnDate',
				sord : 'DESC'
			},
			rowList : [ 10, 25, 50, 100 ],
			radio : false
			/* tempId : 'ifvGridNotSearchTemplete' */
		};

		mbrPointGiftHistList = $("#mbrPointGiftHistListGrid").ifvsfGrid({ejGridOption: ejGridOption});
}

$(document).ready(function(){
	getGiftPointHistList()
});

</script>