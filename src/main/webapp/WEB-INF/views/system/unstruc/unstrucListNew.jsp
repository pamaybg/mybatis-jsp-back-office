<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>

<script>

var editOperatingFlag = null; // 작업할 내용의 상태값 ( NEW_ITEM : 등록 , MODIFY_ITEM : 수정 ) 
var unstrucRId = null;        // 목록에서 가져온 rid
var unstrucListGrid = null;   // 그리드 

// 비정형 목록 그리드 출력 
function setUnstrucListGrid() {

    var ejGridOption = {
        serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        // ROW 클릭시 이벤트  상세화면 호출 
        recordDoubleClick : function(args) {
            var data = args.data;
            unstrucDetailPopOpen("MODIFY_ITEM", data.rid);
        },
        dataUrl: '<ifvm:action name="getUnstrucList"/>',
        columns:[
        	{
      		  field : 'nodeTypeNm', headerText : '<spring:message code="L00389"/>', textAlign : 'center', customAttributes : {searchable : true}  //유형
      	  },{
    		  field : 'subTypeNm', headerText : '<spring:message code="M02174"/>', textAlign : 'center',  customAttributes : {searchable : true}//하위유형
    	  },{
    		  field : 'inputScrn', headerText : '<spring:message code="M02175"/>',  //이름
    	  },{
    		  field : 'desctxt', headerText : '<spring:message code="L00340"/>', customAttributes : {searchable : true}//설명
    	  },{
    		  field : 'execCls', headerText : '<spring:message code="M02176"/>', textAlign : 'center', customAttributes : {searchable : true}//클래스명
    	  },{
    		  field : 'execMthd', headerText : '<spring:message code="M02177"/>', textAlign : 'center', customAttributes : {searchable : true}//function
    	  },{
    		  field : 'createrName', headerText : '<spring:message code="L00220"/>', textAlign : 'center', //등록자
    	  },{
    		  field : 'createDate', headerText : '<spring:message code="M00222"/>', textAlign : 'center', //등록일자
    	  },{
    		  field : 'rid', headerText : 'rid', visible : false //rid
    	  },{
    		  field : 'subTypeCd', headerText : 'subTypeCd', visible : false //rid
    	  },{
    		  field : 'nodeTypeCd', headerText : 'subTypeCd', visible : false //rid
    	  },
        ],
        requestGridData : {
        	  nd   : new Date().getTime(),
        	  rows : 10,
        	  sidx : 'rid',
        	  sord : 'desc',
        	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true,
    };
    unstrucListGrid = $("#unstrucListGrid").ifvsfGrid({
        ejGridOption : ejGridOption
    });
}

// 상세 팝업 호출 
function unstrucDetailPopOpen(editFlag, getRowNo) {

    editOperatingFlag = editFlag;
    
    // 신규 등록
    if (editFlag == "NEW_ITEM") {
        unstrucRId = null;
    }
    // 수정 
    else {
        unstrucRId = getRowNo;
    }
    // 팝업 호출 
    $("#unstrucDetailPop").ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : '<ifvm:url name="unstrucDetailPop"/>',
        contentType : "ajax",
        title : '<spring:message code="M02179" />',
        width : '700px',
        close : 'unstrucDetailPopClose'
    });
}

/* 팝업 닫기 */
function unstrucDetailPopClose() {
    unstrucDetailPop._destroy();
}

/**
 * 사용중인 캠페인이 존재하는가?
 * 
 * @param getData
 * @returns 
 *          true  : 사용중인 캠페인이 존재.          > 수정/삭제 불가
 *          false : 사용중인 캠페인이 존재하지 않음. > 수정/삭제 가능 
 */
function isUsingByCampaign(getData) {

    var returnFlag = false;

    // 사용중인 캠페인 개수 체크
    $.ifvSyncPostJSON('<ifvm:action name="getUnstrucUsingByCampaignChk"/>', getData, 
            function(chkResult_campaign) {
        
                // 사용중인 캠페인 존재할 경우
                if (chkResult_campaign.chkCount > 0) {
                    alert("<spring:message code='M02180'/>");
                    returnFlag = true;
                }
            });

    return returnFlag;
}

/*
 * 삭제
 */
function deleteUnstrucItem() {

    var v_rid;
    if ($.fn.ifvmIsNotEmpty(unstrucListGrid.opt.gridControl.getSelectedRecords()[0])) {
        v_rid = unstrucListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    
    var data = {rid : v_rid};
    
    var isUsingByCampaignFlag = isUsingByCampaign(data);
    
    // 사용중인 캠페인 체크 > 사용중인 캠페인이 없을 경우 
    if (isUsingByCampaignFlag == false) {
        
        if (confirm("<spring:message code='M00074'/>")) {
    
            // 삭제
            $.ifvPostJSON('<ifvm:action name="removeUnstrucItem"/>', data, function(delResult) {
                if (delResult.success == true) {
                    alert("<spring:message code='M00003'/>");
                    setUnstrucListGrid(); // 목록 조회
                }
            });
        }
    }
}

/**
 * 공통조회 조건 설정 
 */
function unstrucListSearchInit() {
    $.fn.ifvmSetCommonCondList("unstrucRequiredList","PLOY_064");
}

$(document).ready(function() {
    
    // 그리드 설정
    setUnstrucListGrid();
    
    // 공통조회조건 설정
    unstrucListSearchInit();
    
    // 조회
    $("#unstrucListSearchBtn").on('click', function() {
        $.fn.ifvmSubmitSearchCondition("unstrucRequiredList", setUnstrucListGrid);
    });

    // 초기화
    $("#unstrucListSearchInitBtn").on('click', function() {
        unstrucListSearchInit();
    });

    // 신규 작성
    $('#unstrucNewBtn').on('click', function() {
        unstrucDetailPopOpen("NEW_ITEM", null);
    });
    
    // 삭제 
    $('#unstrucDelBtn').on('click', function() {
        deleteUnstrucItem();
    });
    
});
</script>

<style>
.well{padding-bottom:5px;}
</style>

<script id="unstrucListTextTemp" type="text/x-jquery-tmpl">
<div class="col-xs-2">
    <ifvm:input type="text" />              
</div>
</script>

<script id="unstrucListSelectTemp" type="text/x-jquery-tmpl">
<div class="col-xs-2">
    <ifvm:input type="select" id="SelectListValue"/>            
</div>
</script>

<div class="page-title">
    <h1>
        <spring:message code="M02178"/> &gt;  <spring:message code="L00030"/>
    </h1>
</div>
<div>
	<div class="page_btn_area">
	    <div class="col-xs-7">
	        <span><spring:message code="M00310"/></span>
	    </div>
	    <div class="col-xs-5 searchbtn_r">
	        <!-- 조회 버튼 -->
	        <button class="btn btn-sm" id='unstrucListSearchBtn' objCode="unstrucListNewSearch_OBJ"><i class="fa fa-search"></i>
	            <spring:message code="M00273"/>
	        </button>
	        <!-- 초기화 버튼 -->
	        <button class="btn btn-sm" id='unstrucListSearchInitBtn' objCode="unstrucListNewInit_OBJ">
	            <spring:message code="M00311"/>
	        </button>
	    </div>
	</div>
<div class="well form-horizontal" id="unstrucRequiredList" ></div>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M00312"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <!-- 추가 버튼 -->
            <button class="btn btn-sm" id="unstrucNewBtn" objCode="unstrucListNewAdd_OBJ">         
                <i class="fa fa-plus"></i>    
                <spring:message code="M00274"/>
            </button>
            <!-- 삭제버튼 -->
            <button class="btn btn-sm" id='unstrucDelBtn' objCode="unstrucListNewDel_OBJ">
                <i class="fa fa-minus"></i>
                 <spring:message code="M00165"/>
            </button>
        </div>
    </div>
    <div id="unstrucListGrid" class="grid_bd0"></div>
</div>

<div id="unstrucDetailPop" class="popup_container"></div>
<div id="dialogTempPop"></div>