<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var targetGroupListGrid;
var gridIdtargetGroupListGrid;

//캠페인 목록
function getTargetGroupList(page){

    var page = $.fn.ifvmIsNotEmpty(page) ? page : 1;

    var jqGridOption = {
        serializeGridData : function(data) {
        	if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
        	//페이지 설정
        	data.page = page;
            return data;
        },
        ondblClickRow : function (rowNo) {
            //상세화면으로 이동
        	var data = targetGroupListGrid.getRowData()[rowNo-1];
           	if (data.type == 'SEG') {
        		goTargetGroupDetail(data.targetGroupId);
           	}
           	else if (data.type == 'IMP') {
           	 	goTargetImportDetail(data.segmentId);
           	}
        },
        url : '<ifvm:action name="getTargetGroupImportList"/>',
        colNames:[
            '<spring:message code="L00198" />',
            '<spring:message code="M00677" />',
            '<spring:message code="M01490" />',
            '<spring:message code="M00443" />',
            '<spring:message code="M00184" />',
            '<spring:message code="M00185" />',
            'segmentId',
            'id',
            'type',
            'camId',
            'camStatusCd',
        ],
        colModel:[
            { name:'typeNm', 		   	index:'typeNm', 	 	 width:'100px', align: 'center', resizable : false },
            { name:'segmentName', 		index:'segmentName', 	 width:'200px', align: 'left',   resizable : false },
            { name:'targetGroupName', 	index:'targetGroupName', width:'200px', align: 'left',   resizable : false },
            { name:'fileNm',      		index:'fileNm', 		 width:'200px', align: 'left',   resizable : false },
            { name:'createByName', 		index:'createByName', 	 width:'100px', align: 'center', resizable : false },
            { name:'createDate', 		index:'createDate', 	 width:'100px', align: 'center', resizable : false, formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"} },
            { name:'segmentId', 		index:'segmentId',		 hidden : true },
            { name:'targetGroupId', 	index:'targetGroupId', 	 hidden : true },
            { name:'type', 				index:'type', 			 hidden : true },
            { name:'camId', 			index:'camId', 			 hidden : true },
            { name:'camStatusCd', 		index:'camStatusCd', 	 hidden : true },
        ],
        sortname: 'createDate',
        sortorder: "desc",
        radio: true,
    };

    targetGroupListGrid = $("#targetGroupListGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdtargetGroupListGrid = $("#gridIdtargetGroupListGrid");
}

/**
 * 타겟그룹 상세 이동
 */
function goTargetGroupDetail(id) {
    qtjs.href('<ifvm:url name="targetGroupDetail"/>' + '?targetGroupId=' + id);
}

/**
 * 타겟 파일 업로드 상세 이동
 */
function goTargetImportDetail(id) {
    qtjs.href('<ifvm:url name="importTargetingDetail"/>?targetingId=' + id + "&type=LIST");
}

//그리드 텍스트 선택시 상세로 이동
function goGridRowLink(cellvalue, options, rowObjec) {
    var id = rowObjec.targetGroupId;
    var url = '<ifvm:url name="targetGroupDetail"/>?targetGroupId=' + id;
    var tag = '<a href="' + url + '" >' + cellvalue + '</a>';

    return tag;
}

/* 팝업 닫기 */
function targetGroupNewPopClose() {
	$('#targetGroupNewPopup').ejDialog('destroy');
}

//공통 조회 조건 목록 설정
function targetGroupListSearchInit() {
    $.fn.ifvmSetCommonCondList("targetGroupSearchList","ANL_TGT_001");
}

//공통 조회 호출
function targetGroupListSearch() {
    $.fn.ifvmSubmitSearchCondition("targetGroupSearchList", getTargetGroupList);
}

//세그먼트 목록 열기
function segmentListOpen() {
    var url = '<ifvm:url name="segmentList_KPR"/>';
    qtjs.href(url);
}

//세그먼트 팝업 열기
function openSegmentViewPopup() {
    var segmentId;
    var type;
    if ($.fn.ifvmIsNotEmpty(targetGroupListGrid.getCheckedGridData()[0])) {
    	segmentId = targetGroupListGrid.getCheckedGridData()[0].segmentId;
    	type = targetGroupListGrid.getCheckedGridData()[0].type;
    }

    if ('IMP' == type) {
        alert('<spring:message code="M02826" />'); //파일업로드는 조건 상세가 없습니다
    }
    else {
        if ($.fn.ifvmIsNotEmpty(segmentId)) {
            $("#segmentViewPopup").ifvsfPopup({
        		enableModal : true,
                enableResize: false,
                contentUrl: '<ifvm:url name="targetGroupSegmentViewPop"/>?segmentId=' + segmentId,
                contentType: "ajax",
                title: '<spring:message code="M00546" />',
                width: 800,
                close : 'segmentViewPopupClose'
            });
        }
        else {
            alert('<spring:message code="I00728" />');	//목록을 선택해주세요
        }
    }
}

//세그먼트 팝업 닫기
function segmentViewPopupClose() {
    $('#segmentViewPopup').ejDialog('destroy');
    $('.tooltip').remove();
}

//타겟그룹 삭제
function removeTargetGroup() {
    var targetGroupId;
    var segmentId;
    var camId;
    var camStatusCd;
    if ($.fn.ifvmIsNotEmpty(targetGroupListGrid.getCheckedGridData()[0])) {
    	targetGroupId = targetGroupListGrid.getCheckedGridData()[0].targetGroupId;
    	segmentId = targetGroupListGrid.getCheckedGridData()[0].segmentId;
    	camId = targetGroupListGrid.getCheckedGridData()[0].camId;
    	camStatusCd = targetGroupListGrid.getCheckedGridData()[0].camStatusCd;
    }

    //타겟 그룹삭제
    if ($.fn.ifvmIsNotEmpty(targetGroupId)) {
        if (confirm('<spring:message code="C00079" />')) {	//삭제 하시겠습니까?
            $.ifvProgressControl(true);

            //타겟그룹 삭제
            $.ifvPostJSON('<ifvm:action name="removeTargetGroup"/>', {
                targetGroupId: targetGroupId,
                segmentId: segmentId
            },
            function(result) {
                alert('<spring:message code="M00255" />');	//삭제되었습니다.

                //타겟그룹 목록
                getTargetGroupList(getGridPage());

                $.ifvProgressControl(false);
            },
            function(result) {
                if (result.message == "MSG_T0001") {
                    $.ifvErrorPop('<spring:message code="M01718" />'); //선택한 타겟그룹은 현재 캠페인에서 사용중입니다.
                }
                else {
                	$.errorChecker(result);
                }

                $.ifvProgressControl(false);
            });
        }
    }
    //타겟 Import 삭제
    else if ($.fn.ifvmIsNotEmpty(segmentId)) {

        var delFlag = true;

        //사용중인 캠페인이 존재할때
		if ($.fn.ifvmIsNotEmpty(camId)) {

		    // 캠페인 상태가 W인 경우에만 삭제가능
			if (camStatusCd == 'W') {
			 	if (confirm('<spring:message code="M02812" />') == false) { //사용중인 캠페인이 존재합니다. 삭제하시겠습니까?
			 	   delFlag = false;
			 	}
			}
			else {
			   	alert("<spring:message code='M02813' />"); // 작성중인 캠페인이 아니므로 삭제하실수 없습니다.
			    delFlag = false;
			}
		}

        if (delFlag == true && confirm('<spring:message code="I01500" />')) {	//삭제하시겠습니까?

            //타겟그룹 삭제
            $.ifvPostJSON('<ifvm:action name="removeTargetImport"/>', {
                ridTgtHad: segmentId
            },
            function(result) {
                alert('<spring:message code="M00255" />'); //삭제되었습니다.

                //타겟그룹 목록
                getTargetGroupList(getGridPage());
                $.ifvProgressControl(false);
            });
        }
    }
    else {
        alert('<spring:message code="M00108"/>'); //목록을 선택해주세요.
    }
}

//페이지 구하기
function getGridPage() {
    var rtnVal = 1;
    var page = targetGroupListGrid.opt.data.page;
    var total = targetGroupListGrid.opt.data.records;

    if (total % page > 0) {
        rtnVal = page;
    }

    return rtnVal;
}

$(document).ready(function() {
    getTargetGroupList();

  	//공통 조회 조건 목록 설정
    targetGroupListSearchInit();

    // 조회
    $('#targetGroupListSearchBtn').on('click', function() {
        targetGroupListSearch();
    });

    // 초기화
    $("#targetGroupListSearchInitBtn").on('click', function() {
        targetGroupListSearchInit();
    });

    // 신규 클릭시
    $('#targetGroupNewBtn').on('click', function() {
        segmentListOpen();
    });
    $('#targetImportNewBtn').on('click', function() {
        goTargetImportDetail('');
    });

    // 세그먼트 팝업
    $('#targetGroupSegmentViewPopBtn').on('click', function() {
        openSegmentViewPopup();
    });

    // 타겟그룹 삭제
    $('#targetGroupRemoveBtn').on('click', function() {
        removeTargetGroup();
    });
});

</script>

<div class="page-title">
    <h1>
        <spring:message code="M01494" />
        &gt; <spring:message code="M00273" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">

        	<%-- 조회 --%>
            <button class="btn btn-sm" id="targetGroupListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>

            <%-- 초기화 --%>
            <button class="btn btn-sm" id="targetGroupListSearchInitBtn">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="targetGroupSearchList"></div>
</div>

<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">

        	<%-- 조건상세 --%>
            <button class="btn btn-sm" id="targetGroupSegmentViewPopBtn"><i class="fa fa-search"></i>
                <spring:message code="M00546" />
            </button>

            <%-- 신규 --%>
            <button class="btn btn-sm" id="targetGroupNewBtn">
                <spring:message code="M02811" />
            </button>
            <button class="btn btn-sm" id="targetImportNewBtn">
                <spring:message code="M02810" />
            </button>

            <%-- 삭제 --%>
            <button class="btn btn-sm" id="targetGroupRemoveBtn"><i class="fa fa-minus"></i>
                <spring:message code="M00165" />
            </button>
        </div>
    </div>
    <div id="targetGroupListGrid" class="white_bg grid_bd0"></div>
</div>

<div class="well">
    <ol class="targetGroup_order">
    </ol>
</div>

<div id="targetGroupNewPopup" class="popup_container"></div>
<div id="dialogTempPop"></div>
<div id="segmentViewPopup"></div>