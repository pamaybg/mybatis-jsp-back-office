<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var segmentListGrid;

//캠페인 목록
function getSegmentList(page){
    
    var page = $.fn.ifvmIsNotEmpty(page) ? page : 1; 
    
    var jqGridOption = {
        serializeGridData : function( data ){
        	
        	if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
        	
        	//페이지 설정
        	data.page = page;
        	
            return data;
        },
        ondblClickRow : function (rowNo) {
        	var data = segmentListGrid.getRowData()[rowNo-1];
        	
        	goSegmentDetail(data.segmentId);
        },
        url : '<ifvm:action name="getSegmentList_KPR"/>',
        colNames:[ '<spring:message code="M00677"/>',
                   '<spring:message code="M01427" />',
                   '<spring:message code="M00184" />',
                   '<spring:message code="M00185" />',
                   'id'
                 ],
        colModel:[
            { name:'segmentName', index:'s.SEG_NM', width:'200px', align: 'left', resizable : false},
            { name:'logicalCompName', index:'l.LGC_COMP_NM', width:'200px', align: 'left', resizable : false },
            { name:'createByName', index:'e.NAME', width:'100px', align: 'center', resizable : false },
            { name:'createDate', index:'s.CREATE_DATE', width:'100px', align: 'center', resizable : false },
            { name:'segmentId', index:'s.id', hidden : true } 
        ],
        sortname: 's.create_date',
        sortorder: "desc",
        radio: true,
//         tempId : 'ifvGridOriginTemplete'
    };
    
    segmentListGrid = $("#segmentListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//세그먼트 상세 이동
function goSegmentDetail(id) {
    qtjs.href('<ifvm:url name="segmentDetail_KPR"/>' + '?segmentId=' + id);
}

//그리드 텍스트 선택시 상세로 이동
function goGridRowLink(cellvalue, options, rowObjec){
    var id = rowObjec.segmentId;
    var url = '<ifvm:url name="segmentDetail_KPR"/>?segmentId=' + id; 
    var tag = '<a href="' + url + '" >' + cellvalue + '</a>';
    
    return tag;
}

/* 팝업 닫기 */
function segmentNewPopClose(){
	$('#segmentNewPopup').ejDialog('destroy');
}

//공통 조회 조건 목록 설정
function segmentListSearchInit() {
    $.fn.ifvmSetCommonCondList("segmentSearchList","ANL_SEG_001");
}

//공통 조회 호출
function segmentListSearch() {
    $.fn.ifvmSubmitSearchCondition("segmentSearchList", getSegmentList);
}

//세그먼트 생성 팝업 열기
function segmentNewPopOpen() {
    $("#segmentNewPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="segmentNewPop_KPR"/>',
        contentType: "ajax",
        title: '<spring:message code="M01470" />',
        width: 700,
        close : 'segmentNewPopClose'
    });
}

//타겟그룹 삭제
function removeSegment() {
    var segmentId;
    if ($.fn.ifvmIsNotEmpty(segmentListGrid.getCheckedGridData()[0])) {
    	segmentId = segmentListGrid.getCheckedGridData()[0].segmentId;
    }
    
    if ($.fn.ifvmIsNotEmpty(segmentId)) {
        if (confirm('<spring:message code="C00079" />')) {
            $.ifvProgressControl(true);
            
            //세그먼트 삭제
            $.ifvPostJSON('<ifvm:action name="removeSegment"/>', {
                segmentId: segmentId
            },
            function(result) {
                alert('<spring:message code="M00255" />');
                
                //세그먼트 목록
                getSegmentList(getGridPage());
                
                $.ifvProgressControl(false);
            },
            function(result) {
                
                $.errorChecker(result);
                
                $.ifvProgressControl(false);
            });
        }
    } else {
        alert('<spring:message code="M00108"/>');
    }
}

//페이지 구하기
function getGridPage() {
    var rtnVal = 1;
    var page = segmentListGrid.opt.data.page;
    var total = segmentListGrid.opt.data.records;
    
    if (total % page > 0) {
        rtnVal = page;
    }
    
    return rtnVal;
}

$(document).ready(function() {
    getSegmentList();
    
    //공통 조회 조건 목록 설정
    segmentListSearchInit();
    
    //조회
    $('#segmentListSearchBtn').on('click', function(){
    	segmentListSearch();
    });
    
    //초기화
    $("#segmentListSearchInitBtn").on('click', function(){
    	segmentListSearchInit();
    });
    
    //신규 클릭시
    $('#segmentNewBtn').on('click', function(){
        segmentNewPopOpen();
    });
    
    //타겟그룹 삭제
    $('#segmentRemoveBtn').on('click', function(){
        removeSegment();
    });
});

</script>

<div class="page-title">
    <h1>
        <spring:message code="M01469" />
        &gt; <spring:message code="M00273" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="segmentListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="segmentListSearchInitBtn">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="segmentSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="segmentNewBtn"><i class="fa fa-plus"></i>
                <spring:message code="M00274" />
            </button>
            <button class="btn btn-sm" id="segmentRemoveBtn"><i class="fa fa-minus"></i>
                <spring:message code="M00165" />
            </button>  
        </div>
    </div>
    <div id="segmentListGrid" class="white_bg grid_bd0"></div>     
</div>


<div class="well">
    <ol class="segment_order">
    </ol>
</div>

<div id="segmentNewPopup" class="popup_container"></div>
<div id="dialogTempPop"></div>