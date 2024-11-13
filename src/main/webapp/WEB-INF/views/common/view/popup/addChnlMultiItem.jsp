<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn" objCode="addChnlMultiSearch_OBJ" ><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn" objCode="addChnlMultiSearchInit_OBJ">
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="commSearchList" >
    </div>
</div>

<div id="chnlListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnChnlPopSelect" objCode="addChnlMultiSelect_OBJ">
		<spring:message code="저장" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnChnlPopCancel" objCode="addChnlMultiCancel_OBJ">
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
		 dataUrl: '<ifvm:action name="getChnlMulitPopup"/>',
         columns: [ 
        	 { 
				 type : "checkbox", width : 60,headerText: '선택', customAttributes : { sortable : false }
			 },{
                 field: 'dept',
                 headerText: '레벨',
                 width : '50px',
                 textAlign : 'center'
             },{
                 field: 'chnlNo',
                 headerText: '<spring:message code="L00128"/>',
                 textAlign : 'center',
                 customAttributes: { searchable: true }
             }, {
                 field: 'chnlNm',
                 headerText: '<spring:message code="L00129"/>',
                 customAttributes: { searchable: true  }
             }, {
                 field: 'chnlTypeCdNm',
                 headerText: '<spring:message code="L00165"/>', textAlign : 'center',
                 customAttributes: { index: 'chnlTypeCd' }
             },{
                 field: 'rid',
                 headerText: 'rid',
                 visible: false,
             }],
             requestGridData: {
                 sidx: '1',
                 sord : 'ASC',
             },
             rowList : [10,25,50,100],
             radio: false,
    };

    chnlListGrid = $("#chnlListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function searchCondInit() {
    $.fn.ifvmSetCommonCondList("commSearchList","CHNL_GRP_MUTIL_LIST");
}

//공통 조회 호출
function chnlGrpListSearch() {
	$.fn.ifvmSubmitSearchCondition("commSearchList", function(){
		chnlListGrid.searchGrid({item: requestitem});
    });
	
}


$(document).ready(function(){
	searchCondInit();
	
	getChnlList();
	
	$("#btnChnlPopSelect").click(function(){
    		var add_rid = [];
    		var checkedList = chnlListGrid.opt.gridControl.getSelectedRecords();
    		if (checkedList.length == 0) {
    			alert('<spring:message code="M00285"/>');
    		}else{
    			for(var i = 0; i < checkedList.length; i++){
    				var rowData = {
    						chnlRid : checkedList[i].rid,
    						lvlCd   : checkedList[i].dept
    				};
    				add_rid.push(rowData);
    			}
    		}
    		 $.ifvSyncPostJSON('<ifvm:action name="addChnlItem"/>', {
 		        chnlGrpRid : chnlGrp_Rid,
 		    	ridList : add_rid
 		    }, function(result) {
 		    	alert(result.message);
 		    	$.fn.ifvmPopupClose();
 		    	chnlItemListGrid._doAjax();

 		    });

	});
	
	$("#btnChnlPopCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
	
	//조회
	 $('#searchCondBtn').on('click', function(){
		 chnlGrpListSearch();
	 });
	
	//초기화
	 $("#searchCondInitBtn").on('click', function(){
	 	searchCondInit();
	 });
});
</script>