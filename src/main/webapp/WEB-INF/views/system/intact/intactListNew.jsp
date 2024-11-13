<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var intactListGrid = null;    // 그리드 

// 인터렉션 그리드 출력 
function setIntactListGrid() {

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
            intactDetailPopOpen(false, data.rid);
        },
        dataUrl: '<ifvm:action name="getIntactList"/>',
        columns:[
        	{
      		  field : 'typeName', headerText : '<spring:message code="L00389"/>', textAlign : 'center',
      		  customAttributes : {
      			  index : 'typeNameCd' } //유형
      	  },{
    		  field : 'subTypeName', headerText : '<spring:message code="M02174"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'subTypeNameCd' } //하위유형
    	  },{
    		  field : 'saveTblNm', headerText : '<spring:message code="M02181"/>', headerTextAlign : 'center',
    	  },{
    		  field : 'createrName', headerText : '<spring:message code="L00220"/>', textAlign : 'center',
    	  },{
    		  field : 'createDate', headerText : '<spring:message code="M00222"/>', textAlign : 'center',
    	  },{
    		  field : 'rid', headerText : 'rid', visible : false,
    	  }
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

    intactListGrid = $("#intactListGrid").ifvsfGrid({
        ejGridOption : ejGridOption
    });
}

// 상세 팝업 호출 
function intactDetailPopOpen(newFlag, intactRId) {

    // 신규 등록
    if (newFlag == true) {
        intactRId = '';
    }

    // 팝업 호출 
    $("#intactDetailPop").ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : '<ifvm:url name="intactDetailPop"/>?intactRid=' + intactRId,
        contentType : "ajax",
        title : '<spring:message code="M02184" />',
        width : '700px',
        close : 'intactDetailPopClose'
    });
}

/* 팝업 닫기 */
function intactDetailPopClose() {
    intactDetailPop._destroy();
}

/**
 * 사용중인 캠페인이 존재하는가?
 * 
 * @param getData
 * @returns 
 *          true  : 사용중인 캠페인이 존재.          > 수정/삭제 불가
 *          false : 사용중인 캠페인이 존재하지 않음. > 수정/삭제 가능 
 */
function checkCampaignsUsingIntect(getData) {

    var returnFlag = false;

    // 사용중인 캠페인 개수 체크
    $.ifvSyncPostJSON('<ifvm:action name="checkCampaignsUsingIntect"/>', getData, function(chkResult_campaign) {

        // 사용중인 캠페인 존재할 경우
        if (chkResult_campaign.chkCount > 0) {
            alert("<spring:message code='M02182'/>");
            returnFlag = true;
        }
    });

    return returnFlag;
}

/*
 * 삭제
 */
function deleteIntactItem() {

    var v_rid;
    if ($.fn.ifvmIsNotEmpty(intactListGrid.opt.gridControl.getSelectedRecords()[0])) {
        v_rid = intactListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }

    var objData = {
        rid : v_rid
    };

    var checkCampaignsUsingIntectFlag = checkCampaignsUsingIntect(objData);

    // 사용중인 캠페인 체크 > 사용중인 캠페인이 없을 경우
    if (checkCampaignsUsingIntectFlag == false) {

        if (confirm("<spring:message code='M00074'/>")) {

            // 삭제
            $.ifvPostJSON('<ifvm:action name="removeIntactItem"/>', objData, function(delResult) {
                if (delResult.success == true) {
                    alert("<spring:message code='M00003'/>");
                    setIntactListGrid(); // 목록 조회
                }
            });
        }
    }
}

/**
 * 공통조회 조건 설정 
 */
function intactListSearchInit() {
    $.fn.ifvmSetCommonCondList("intactRequiredList","INTERACT001");
}

$(document).ready(function() {
    
    // 그리드 설정
    setIntactListGrid();
    
    // 공통조회조건 설정
    intactListSearchInit();
    
    // 조회
    $("#intactListSearchBtn").on('click', function() {
        $.fn.ifvmSubmitSearchCondition("intactRequiredList", setIntactListGrid);
    });

    // 초기화
    $("#intactListSearchInitBtn").on('click', function() {
        intactListSearchInit();
    });

    // 신규 작성
    $('#intactNewBtn').on('click', function() {
        intactDetailPopOpen(true, null);
    });
    
    // 삭제 
    $('#intactDelBtn').on('click', function() {
        deleteIntactItem();
    });
    
});
</script>

<style>
.well{padding-bottom:5px;}
</style>

<script id="intactListTextTemp" type="text/x-jquery-tmpl">
<div class="col-xs-2">
    <ifvm:input type="text" />              
</div>
</script>

<script id="intactListSelectTemp" type="text/x-jquery-tmpl">
<div class="col-xs-2">
    <ifvm:input type="select" id="SelectListValue"/>            
</div>
</script>

<div class="page-title">
    <h1>
        <spring:message code="M02183"/> &gt;  <spring:message code="L00030"/>
    </h1>
</div>
<div>
	<div class="page_btn_area">
	    <div class="col-xs-7">
	        <span><spring:message code="M00310"/></span>
	    </div>
	    <div class="col-xs-5 searchbtn_r">
	        <!-- 조회 버튼 -->
	        <button class="btn btn-sm" id='intactListSearchBtn' objCode="interactListNewSearch_OBJ"><i class="fa fa-search"></i>
	            <spring:message code="M00273"/>
	        </button>
	        <!-- 초기화 버튼 -->
	        <button class="btn btn-sm" id='intactListSearchInitBtn' objCode="interactListNewInit_OBJ">
	            <spring:message code="M00311"/>
	        </button>
	    </div>
	</div>
	<div class="well form-horizontal" id="intactRequiredList" ></div>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M00312"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <!-- 추가 버튼 -->
            <button class="btn btn-sm" id="intactNewBtn" objCode="interactListNewAdd_OBJ">         
                <i class="fa fa-plus"></i>    
                <spring:message code="M00274"/>
            </button>
            <!-- 삭제버튼 -->
            <button class="btn btn-sm" id='intactDelBtn' objCode="interactListNewDel_OBJ">
                <i class="fa fa-minus"></i>
                 <spring:message code="M00165"/>
            </button>
        </div>
    </div>
    <div id="intactListGrid" class="grid_bd0"></div>
</div>

<div id="intactDetailPop" class="popup_container"></div>
<div id="dialogTempPop"></div>