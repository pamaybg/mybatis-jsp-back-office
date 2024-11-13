<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn" ><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn" >
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="commSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="clearMaskBtn" >
                <spring:message code="L00326"/></button>
        </div>
    </div>
    <div id="custListGrid" class="white_bg grid_bd0"></div>
</div>

<script type="text/javascript">
var obj = null;
var custListGrid = null;
//고객 목록
function getCustList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			//페이지 설정
			return data;
		},
   		recordDoubleClick : function (args) {
   			var data = args.data.rid ;
   			obj = data;
   	    	CustDetail(data);
        },

        dataUrl : '<ifvm:action name="getCustListPage"/>',

        columns : [
        	{
      		  field : 'custNo', headerText : '고객번호', headerTextAlign : 'center', textAlign : 'center',
      		  customAttributes : {
      			  index : 'lcm.cust_no'
      		  }
      	  },{
    		  field : 'custNm', headerText : '고객명', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'lci.cust_nm'
    		  }
    	  },{
    		  field : 'hhp', headerText : '전화번호', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'lci.hhp'
    		  }
    	  },{
    		  field : 'custTypeCdNm', headerText : '유형', headerTextAlign : 'center', textAlign : 'center',
    		  customAttributes : {
    			  index : 'lcm.cust_type_cd'
    		  }
    	  },{
    		  field : 'custStatCdNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center',
    		  customAttributes : {
    			  index : 'lcm.cust_stat_cd'
    		  }
    	  },{
    		  field : 'rid', headerText : 'rid', headerTextAlign : '' ,visible: false,
    		  customAttributes : {
    			  index : 'lcm.rid'
    		  }
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '1',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: false,
        radio: true,
        tempId : 'ifvGridSimplePageTemplete2'
    };

    custListGrid = $("#custListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function searchCondInit() {
    $.fn.ifvmSetCommonCondList("commSearchList","CUST_PAGE_001"); //CUSTOMER_SEARCH_POP
}

//공통 조회 호출
function custListSearch() {
    $.fn.ifvmSubmitSearchCondition_NoAllSearch("commSearchList", function() {
    	if ($.fn.ifvmIsNotEmpty(requestitem)) {
	    	custListGrid.searchGrid({item: requestitem});
	//     		getCustList);
    	} else {
    		alert('최소 1개의 조회조건을 입력해주세요.');
    	}
    });
}

//마스크해제
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(custListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = custListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="clearMaskCustList"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = custListGrid.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.unMaskCustNm);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhp'), result.unMaskHhp);
        });
    }
}

//고객 상세 이동
function CustDetail(id) {
	$.fn.ifvmPersonalCondLogPageId("CUSTOMER_SEARCH_POP", true);
	location.href = '<ifvm:url name="custDetailNewPage"/>' + '?rid=' + id;
}

$(document).ready(function() {
	 searchCondInit();

	 //마스킹해제 권한 체크
	 getCustList();
	 
	//조회
	 $('#searchCondBtn').on('click', function(){
	 	custListSearch();
	 });

	 //초기화
	 $("#searchCondInitBtn").on('click', function(){
	 	searchCondInit();
	 });
	 
	 //마스킹해제 클릭시
	    $('#clearMaskBtn').on('click', function(){
	        clearMaskAction();
	    });
});




</script>