<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="회원" /></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="mbrListDown" objCode="custDetailMbrExcelDown_OBJ">
			<spring:message code="D10003" />
		</button>
	</div>
</div>
<div id="custMbrListGrid" class="white_bg grid_bd0"></div>

<script type="text/javascript">
var custMbrList;
var mbrRid;

function custDetailMbrList() {
	var ejGridOption = {
			serializeGridData : function(data) {
				if ($.fn.ifvmIsNotEmpty(cust_rid)) {
					data.ridCust = cust_rid;
				}
				return data;
			},
			rowSelected : function (args) {
				mbrRid = args.data.rid;
	        },
	        dataUrl : '<ifvm:action name="getCustDetailMbrList"/>',
	        columns : [
			 	{
					field : 'mbrNo', headerText : '<spring:message code="L00690"/>',  textAlign : 'center', customAttributes :{searchable : true}
				}, {
					field : 'pgmNm', headerText : '<spring:message code="L00026"/>',  textAlign : 'left', customAttributes :{searchable : true}
				}, {
					field : 'mbrStat', headerText : '<spring:message code="L00090"/>', textAlign : 'center', customAttributes :{index : 'mbrStatCd'}
				}, {
					field : 'sbscDate', headerText : '<spring:message code="L00750"/>',  textAlign : 'center'
				}, {
					field : 'chnlNm', headerText : '<spring:message code="L00859"/>',  textAlign : 'center'
				},{
					field : 'rid', headerText : 'rid', visible : false,
				} ],
			 requestGridData : {
				sidx : 'mbrNo',
				sord : 'asc'
			},
			rowList : [ 10, 25, 50, 100 ],
			radio : true
	};
	
	custMbrList = $("#custMbrListGrid").ifvsfGrid({ejGridOption: ejGridOption});
}

function excelDn(){
	$.ifvExcelDn('/loyalty/member/customer/mbrExcelDn.do','custMbrListGrid');
}

$(document).ready(function(){
	
	custDetailMbrList();
	
	$("#mbrListDown").on('click', function() {
		excelDn();
	});
    
});
</script>