<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

//고객 목록
function getCustList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			//페이지 설정
			return data;
		},loadComplete : function(obj){
    		//로그 저장 -> 회원상세로 들어갈때만 로그저장 하게 바꿈
    		//$.fn.ifvmComCondLogging("CUST_PAGE_001", custListGrid.opt.data.records);
        },
   		recordDoubleClick : function (args) {
   			var data = args.data.rid;
   	    	custDetail(data);
        },
        dataUrl : '<ifvm:action name="getCustListPage"/>',

        columns : [
        	{
      		  field : 'custNo', headerText : '고객번호', headerTextAlign : 'center', textAlign : 'center',
      		  customAttributes : {
      			  index : '1'
      		  }
      	  },{
    		  field : 'custNm', headerText : '고객명', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : '2'
    		  }
    	  },{
    		  field : 'hhp', headerText : '전화번호', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : '3'
    		  }
    	  },{
    		  field : 'custTypeCdNm', headerText : '유형', headerTextAlign : 'center', textAlign : 'center',
    		  customAttributes : {
    			  index : '4'
    		  }
    	  },{
    		  field : 'custStatCdNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center',
    		  customAttributes : {
    			  index : '5'
    		  }
    	  },{
    		  field : 'sbscDate', headerText : '가입일자', headerTextAlign : 'center', textAlign : 'center',
    		  customAttributes : {
    			  index : '6'
    		  }
    	  },
    	   {
    		  field : 'chnlNm', headerText : '가입채널', headerTextAlign : 'center', 
    		  customAttributes : {
    			  index : '7'
    		  }
    	  },{
    		  field : 'rid', headerText : 'rid', headerTextAlign : '' ,visible: false,
    		  customAttributes : {
    			  index : '8'
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
        gridDataInit: false,
        radio: true,
        tempId : 'ifvGridSimplePageTemplete2'
    };

    custListGrid = $("#custListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//고객 상세 이동
function custDetail(id) {
	//개인정보 조회 이력남기기
	$.fn.ifvmPersonalCondLogPageId("CUST_PAGE_001", true);
	qtjs.href('<ifvm:url name="custDetailNewPage"/>' + '?rid=' + id);
}

//공통 조회 조건 목록 설정
function searchCondInit() {
    $.fn.ifvmSetCommonCondList("commSearchList","CUST_PAGE_001");
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

$(document).ready(function() {
	//공통 조회 조건 목록 설정
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

<div class="page-title">
    <h1>
        <spring:message code="고객"/><!-- 회원 -->
        &gt; <spring:message code="개인고객"/><!-- 고객 -->
    </h1>
</div>

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
            <button class="btn btn-sm" id="clearMaskBtn" objCode="custListMaskClear_OBJ">
                <spring:message code="L00326"/></button>
        </div>
    </div>
    <div id="custListGrid" class="white_bg grid_bd0"></div>
</div>