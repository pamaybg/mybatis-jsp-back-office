<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="stampList"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnCommStampPopSelect" objCode="">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnCommStampPopCancel" objCode="">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var stampList = null;
var stampNm;
var stampNo;

function getStampListPop(){
	var ejGridOption = {
		rowSelected : function (args) {
			var data = args.data;
			stampId = data.rid;
			stampNm = data.stbgNm;
			stampNo = data.stbgNo;
        },
		serializeGridData : function( data ){
			return data;
		},
        dataUrl : '<ifvm:action name="getStampListPop"/>',
        columns:[
        	 {
                 field: 'stbgNo',
                 headerText: '<spring:message code="L02796"/>',
                 width: '60px',
                 textAlign: 'center',
                 customAttributes: {
                     searchable: true
                 }
             }, {
                 field: 'stbgNm',
                 headerText: '<spring:message code="L02795"/>',
                 width: '150px',
                 textAlign: 'left',
                 customAttributes: {
                     searchable: true
                 }
             }, {
                 field: 'statCdNm',
                 headerText: '<spring:message code="C00125"/>',
                 width: '100px',
                 textAlign: 'center',
                 customAttributes: {
                     index: 'statCd'
                 }
             }, {
                 field: 'promTypeCdNm',
                 headerText: '<spring:message code="L00155"/>',
                 width: '100px',
                 textAlign: 'center',
                 customAttributes: {
                     index: 'promTypeCd'
                 }
             }, {
                 field: 'validStartDate',
                 headerText: '<spring:message code="L00272"/>',
                 width: '80px',
                 textAlign: 'center'
             }, {
                 field: 'validEndDate',
                 headerText: '<spring:message code="L00273"/>',
                 width: '80px',
                 textAlign: 'center'
             }, {
                 field: 'rid',
                 headerText: 'rid',
                 visible: false
             }],
             requestGridData: {
                 sidx: '1'
             },
             radio: true
      };
	stampList = $("#stampList").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function(){
	getStampListPop();
	
	$("#btnCommStampPopSelect").click(function(){
		if(stampList.opt.gridControl.getSelectedRecords().length == 0){
    		alert('<spring:message code="M00285"/>');
    	} else {
    		$('#stampNo').val(stampNo);
    		$('#stampNm').val(stampNm);
    		stampRid = stampId;
        	$.fn.ifvmPopupClose();
    	}
	});
	
	$("#btnCommStampPopCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
});
</script>