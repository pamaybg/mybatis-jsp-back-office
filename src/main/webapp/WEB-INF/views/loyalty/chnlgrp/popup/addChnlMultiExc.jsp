<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div id="chnlListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnChnlPopSelect" objCode="addChnlMultiExcSelect_OBJ">
		<spring:message code="저장" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnChnlPopCancel" objCode="addChnlMultiExcCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var chnlListGrid = null;

function getChnlList(){
	var ejGridOption = {
		rowSelected : function (args) {
				var data = args.data;
				
	    },
		serializeGridData : function( data ){
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			//페이지 설정	
			return data;
		},
		 dataUrl: '<ifvm:action name="getChnlMulitExcPopup"/>',
         columns: [ 
        	 { 
				 type : "checkbox", width : 60,headerText: '선택', customAttributes : { sortable : false }
			 },{
                 field: 'dept',
                 headerText: '레벨',
                 width : '50px',
                 textAlign : 'center',
                 customAttributes: { searchable: true, index : 'lc1.LVL_CD' }
             },{
                 field: 'chnlNo',
                 headerText: '<spring:message code="L00128"/>',
                 textAlign : 'center',
                 customAttributes: { searchable: true, index : 'lc1.CHNL_NO' }
             }, {
                 field: 'chnlNm',
                 headerText: '<spring:message code="L00129"/>',
                 customAttributes: { searchable: true, index: 'lc1.CHNL_NM'  }
             }, {
                 field: 'chnlTypeCdNm',
                 headerText: '<spring:message code="L00165"/>', textAlign : 'center',
                 customAttributes: { index: 'lc1.CHNL_TYPE_CD' }
             },{
                 field: 'rid',
                 headerText: 'rid',
                 visible: false,
             }],
             requestGridData: {
                 sidx: '1',
                 sord : 'ASC',
             },
             radio: false
    };

    chnlListGrid = $("#chnlListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}



$(document).ready(function(){
	
	getChnlList();
	
	$("#btnChnlPopSelect").click(function(){
    		var add_rid = [];
    		var checkedList = chnlListGrid.opt.gridControl.getSelectedRecords();
    		if (checkedList.length == 0) {
    			alert('<spring:message code="M00285"/>');
    		}else{
    			for(var i = 0; i < checkedList.length; i++){
    				var rowData = {
    						chnlRid : checkedList[i].rid
    				};
    				add_rid.push(rowData);
    			}
    		}
    		 $.ifvSyncPostJSON('<ifvm:action name="addChnlExc"/>', {
 		        chnlGrpRid : chnlGrp_Rid,
 		    	ridList : add_rid
 		    }, function(result) {
 		    	alert(result.message);
 		    	$.fn.ifvmPopupClose();
 		    	chnlExcListGrid._doAjax();

 		    });

	});
	
	$("#btnChnlPopCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
	
});
</script>