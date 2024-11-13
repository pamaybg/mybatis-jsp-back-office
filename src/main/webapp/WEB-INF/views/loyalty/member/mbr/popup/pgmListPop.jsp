<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="pgmListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnPgmSelect" objCode="pgmListPopSelect_OBJ">
		<spring:message code="L00072" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="closePgmListPop" objCode="pgmListPopList_OBJ">
		<spring:message code="M00441" />
	</button>
</div>
<script type="text/javascript">
var pgmList;
var pgmRid;
var pgmNo;
var pgmNm;
var rep = $("#repYn").val();

function getPgmListSearch() {
		var ejGridOption = {
					serializeGridData : function(data) {
						if ($.fn.ifvmIsNotEmpty(requestitem)) {
							data.item = requestitem;
						}
						if(rep != undefined) data.repYn = rep;
						return data;
					},
					rowSelected : function (args) {
						pgmRid = args.data.rid;
						pgmNo = args.data.pgmNo;
						pgmNm = args.data.pgmNm;
			        },
	        dataUrl: '<ifvm:action name="getPgmPopup"/>',
	        columns: [ 
	            {
	                field: 'pgmNo',headerText: '<spring:message code="L00087"/>', textAlign : 'center',customAttributes: {searchable: true}
	            }, {
	                field: 'pgmNm',headerText: '<spring:message code="L00088"/>',textAlign : 'center',customAttributes: {searchable: true}
	            }, {
	                field: 'chnlNm', headerText: '<spring:message code="L00089"/>',textAlign : 'center'
	            }, {
	                field: 'pgmStatNm',headerText: '<spring:message code="L00090"/>', textAlign : 'center', customAttributes: { index: 'pgmStat'}
	            }, {
	                field: 'modifyBy', headerText: '<spring:message code="L00095"/>', textAlign : 'center', visible: false,
	            }, {
	                field: 'modifyDate', headerText: '<spring:message code="L00094"/>', textAlign : 'center', visible: false,
	            }, {
	                field: 'rid', headerText: 'rid', visible: false,
	            }],
	        requestGridData: {
	            sidx: 'pgmNo',
	        },
	        radio: true
	    };
		pgmList = $("#pgmListGrid").ifvsfGrid({ejGridOption: ejGridOption});
	    
}

$(document).ready(function(){
	getPgmListSearch();
	
	$("#btnPgmSelect").click(function(){
		if(pgmRid == null){
			alert("목록을 선택하세요.")
		}else{
	        $('#parPgmRid, #pgmRid').val(pgmRid);
	        $('#parPgmNm, #pgmNm').val(pgmNm);
	        
	        //회원가입 프로그램 체크로직에 사용
	        pastPgm = $("#pgmNo").val();
	        $('#pgmNo').val(pgmNo);
	        
	        pgmPopupContainer._destroy();
	        
	      //회원가입 프로그램 체크로직에 사용
	        $("#pgmNo").trigger('change');
		}
	});
	
	$("#closePgmListPop").click(function(){
		pgmPopupContainer._destroy();
	});
})
</script>