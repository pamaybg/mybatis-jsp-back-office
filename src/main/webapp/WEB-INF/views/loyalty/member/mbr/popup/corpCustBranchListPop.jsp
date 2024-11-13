<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="custBranchListPopGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="selectBranchBtn" objCode="">
		<spring:message code="선택" />
	</button> 
	<button class="btn btn-sm btn_gray"  id="closeBranchPopBtn" objCode="">
		<spring:message code="L00941" />
	</button> 
</div>
<script type="text/javascript">
var custCBranchListPop;
var rid;
var branchNo;
var branchNm;

function getCorpCustBranchListPop(){
	var ejGridOption = {
	        	serializeGridData : function(data) {
	        		data.ridMbrC = $("#mbrCRid").val();
	    			return data;
	    		},
	       		recordDoubleClick : function (args) {
	       			var data = args.data;
	            },
				rowSelected : function(args){
					var data = args.data;
					rid = data.rid;
					branchNo = data.brNo;
					branchNm = data.brNm;
				},
	        dataUrl : '<ifvm:action name="getCorpBranchListPop"/>',
	        columns: [{
	            field: 'rid', visible: false
	        }, {
	            field: 'brNo', headerText: '<spring:message code="L02844"/>', textAlign : 'center', customAttributes: { searchable: true }
	        }, {
	            field: 'brNm', headerText: '<spring:message code="L02845"/>', textAlign : 'left', customAttributes: { searchable: true }
	        }, {
	            field: 'chnlNo', headerText: '<spring:message code="L02846"/>', textAlign : 'center'
	        }, {
	            field: 'chnlNm', headerText: '<spring:message code="L02847"/>', textAlign : 'left',
	        }, {
	            field: 'charger', headerText: '<spring:message code="L00618"/>',textAlign : 'left', visible: false
	        }, {
	           field: 'telNo', headerText: '<spring:message code="L02848"/>', textAlign : 'left', visible: false
	       	}, {
	            field: 'createDate', headerText: '<spring:message code="L01125"/>', textAlign : 'center', visible: false
	        }],
	        requestGridData : {
	        	  nd   : new Date().getTime(),
	        	  rows : 10,
	        	  sidx : 'createDate',
	        	  sord : 'desc',
	        	  _search : false,
	
	          },
	          rowList : [10,25,50,100],
	          radio: true,
		};
	
	custCBranchListPop = $("#custBranchListPopGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function(){
	getCorpCustBranchListPop();
	
    $('#selectBranchBtn').on('click', function(){
    	$("#mbrCBrNo").val(branchNo);
    	$("#mbrCBrNm").val(branchNm);
    	$.fn.ifvmPopupClose();
    });
    
    $('#closeBranchPopBtn').on('click', function(){
    	$.fn.ifvmPopupClose();
    });
});
</script>