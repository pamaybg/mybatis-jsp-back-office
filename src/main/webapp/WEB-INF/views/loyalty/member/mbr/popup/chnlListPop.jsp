<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="chnlListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnChnlSelect" objCode="chnlListPopSelect_OBJ">
		<spring:message code="L00072" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="closeChnlListPop" objCode="chnlListPopClose_OBJ">
		<spring:message code="M00441" />
	</button>
</div>
<script type="text/javascript">
var chnlList;
var chnlRid;
var chnlNo;
var chnlNm;

function getChnlListSearch() {
		var ejGridOption = {
					serializeGridData : function(data) {
						if ($.fn.ifvmIsNotEmpty(requestitem)) {
							data.item = requestitem;
						}
						return data;
					},
					rowSelected : function (args) {
						chnlRid = args.data.rid;
						chnlNo = args.data.chnlNo;
						chnlNm = args.data.chnlNm;
			        },
			        recordDoubleClick : function (args) {
				        $('#chnlPrNm, #chnlNm').val(args.data.chnlNm);
				        $("#chnlNo").val(args.data.chnlNo);
				        $("#chnlRid").val(args.data.rid);
				        $.fn.ifvmPopupClose();
					},
	        dataUrl: '<ifvm:action name="getChnlPopup"/>',
	        columns: [ 
	        	   {
                       field: 'chnlNo',headerText: '<spring:message code="L00128"/>',textAlign : 'center',customAttributes: { searchable: true }
                   }, {
                       field: 'chnlNm',headerText: '<spring:message code="L00129"/>',customAttributes: { searchable: true  }
                   }, {
                       field: 'chnlTypeCdNm', headerText: '<spring:message code="L00165"/>', textAlign : 'center', customAttributes: { index: 'chnlTypeCd' }
                   }, {
                       field: 'parChnlNm', headerText: '<spring:message code="L00130"/>', textAlign : 'center',
                   }, {
                       field: 'modifyBy',headerText: '<spring:message code="L00095"/>',visible : false
                   }, {
                       field: 'modifyDate',headerText: '<spring:message code="L00094"/>', visible : false
                   }, {
                       field: 'rid', headerText: 'rid',visible: false,
                   }],
               requestGridData: {
                   sidx: 'chnlNo',
               },
	        radio: true
	    };
		chnlList = $("#chnlListGrid").ifvsfGrid({ejGridOption: ejGridOption});
	    
}

$(document).ready(function(){
	getChnlListSearch();
	
	$("#btnChnlSelect").click(function(){
		if(chnlRid == null){
			alert("목록을 선택하세요.")
		}else{
	        $('#chnlPrNm, #chnlNm').val(chnlNm);
	        $("#chnlNo").val(chnlNo);
	        $("#chnlRid").val(chnlRid);
	        chnlPopupContainer._destroy();
		}
	});
	
	$("#closeChnlListPop").click(function(){
		chnlPopupContainer._destroy();
	});
})
</script>