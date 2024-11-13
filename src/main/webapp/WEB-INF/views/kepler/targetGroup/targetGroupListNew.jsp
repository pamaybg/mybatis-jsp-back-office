<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var targetGroupListGrid;
var gridIdtargetGroupListGrid;
var targetGroupNewPopup;
var segmentViewPopup;
var workflowFlag = false;
//권한
var empId = '';
var authType = '';
var brandCd = '';

//캠페인 목록
function getTargetGroupList(page){

    var page = $.fn.ifvmIsNotEmpty(page) ? page : 1;

    var ejGridOption = {
        serializeGridData : function(data) {
        	if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
        	//페이지 설정
        	data.page = page;
            return data;
        },
        recordDoubleClick : function (args) {
            //상세화면으로 이동
        	var data = args.data;
           	if (data.type == 'SEG') {
        		goTargetGroupDetail(data.targetGroupId);
           	}
           	else if (data.type == 'IMP') {
           	 	goTargetImportDetail(data.targetGroupId);
           	}
           	else if (data.type == 'SQL' && data.extrYn != 'Y' ) {
           	 	goTargetSqlDetail(data.targetGroupId);
           	}
           	else if (data.type == 'CND') {
           		aleadyTargetGroupSimpleOpen(data.targetGroupId);
           	}
           	else if(data.type == 'SQL' && data.extrYn == 'Y'){
           		goTargetSqlDetail(data.targetGroupId);
           	}
        },
        dataUrl : '<ifvm:action name="getTargetGroupList"/>',
        columns:[
        	{
	      		  field : 'typeNm', headerText : '<spring:message code="L00198"/>', headerTextAlign : 'center', width : '7%',
	      		  customAttributes : {
	      			  index : 'c2.mark_name' , searchable : true}
	      	  },{
	      		  field : 'targetGroupName', headerText : '<spring:message code="M01490"/>', headerTextAlign : 'center', width : '20%',
	      		  customAttributes : {
	      			  index : 'tg.tgt_group_nm' ,searchable : true}
	      	  },{
	      		  field : 'segmentName', headerText : '<spring:message code="M00677"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'sm.seg_nm' , searchable : true}
	      	  },{
	      		  field : 'fileNm', headerText : '<spring:message code="M00443"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'tg.IMP_FILE_NM' }
	      	  },{
                field : 'targetCount', headerText : '대상자 수', headerTextAlign : 'center',textAlign: ej.TextAlign.Right,
                customAttributes : {
                    index : 'targetCount' }
            },{
	      		  field : 'createByName', headerText : '<spring:message code="M00184"/>', headerTextAlign : 'center',textAlign: ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'createByName' }
	      	  },{
	      		  field : 'createDate', headerText : '<spring:message code="M00185"/>', headerTextAlign : 'center',textAlign: ej.TextAlign.Center,
	      		  customAttributes : {
	      			searchable : false ,
	      			  index : 'createDate' }
	      	  },{
	      		  field : 'segmentId', headerText : 'segmentId', visible : false ,
	      		  customAttributes : {
	      			  index : 'segmentId' }
	      	  },{
	      		  field : 'targetGroupId', headerText : 'id', visible : false ,
	      		  customAttributes : {
	      			  index : 'targetGroupId' }
	      	  },{
	      		  field : 'type', headerText : 'type', visible : false ,
	      		  customAttributes : {
	      			  index : 'type' }
	      	  },{
	      		  field : 'camId', headerText : 'camId', visible : false ,
	      		  customAttributes : {
	      			  index : 'camId' }
	      	  },{
	      		  field : 'camStatusCd', headerText : 'camStatusCd', visible : false ,
	      		  customAttributes : {
	      			  index : 'camStatusCd' }
	      	  },
        ],
        requestGridData : {
              empId : empId,
              authType : authType,
              brandCd : brandCd,
              empType : empType,
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'createDate',
	      	  sord : 'desc',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        radio: true
    };

    targetGroupListGrid = $("#targetGroupListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
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
    qtjs.href('<ifvm:url name="targetImportDetail"/>?targetGroupId=' + id);
}

/**
 * 타겟 쿼리 상세 이동
 */
function goTargetSqlDetail(id) {
	qtjs.href('<ifvm:url name="targetSqlDetail"/>?targetGroupId=' + id);
}

//그리드 텍스트 선택시 상세로 이동
// function goGridRowLink(cellvalue, options, rowObjec) {
//     var id = rowObjec.targetGroupId;
//     var url = '<ifvm:url name="targetGroupDetail"/>?targetGroupId=' + id;
//     var tag = '<a href="' + url + '" >' + cellvalue + '</a>';

//     return tag;
// }

function goTargetCafe24Detail(id){
	qtjs.href('<ifvm:url name="targetCafe24Detail"/>?targetGroupId=' + id);
}

/* 팝업 닫기 */
function targetGroupNewPopClose() {
	targetGroupNewPopup._destroy();
}

//공통 조회 조건 목록 설정
function targetGroupListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("targetGroupSearchList","ANL_TGT_001",gridId);
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
function aleadyTargetGroupSimpleOpen(){
	targetGroupId = targetGroupListGrid.opt.gridControl.getSelectedRecords()[0].targetGroupId;
	type = targetGroupListGrid.opt.gridControl.getSelectedRecords()[0].type;
    if ($.fn.ifvmIsNotEmpty(targetGroupId)) {
    		var url = '<ifvm:url name="simpleTargeting"/>?targetGroupId='+ targetGroupId;;
    		qtjs.href(url);
    }
}

//세그먼트 팝업 열기
function openSegmentViewPopup() {
    var segmentId;
    var type;
    if ($.fn.ifvmIsNotEmpty(targetGroupListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	segmentId = targetGroupListGrid.opt.gridControl.getSelectedRecords()[0].segmentId;
    	type = targetGroupListGrid.opt.gridControl.getSelectedRecords()[0].type;
    }

    if ('SEG' != type) {
        alert('세그먼트명이 있는 목록을 선택해 주세요');
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
	segmentViewPopup._destroy();
    $('.tooltip').remove();
}

//타겟그룹 삭제
function removeTargetGroup() {
    var targetGroupId;
    var segmentId;
    var camId;
    var camStatusCd;
    if ($.fn.ifvmIsNotEmpty(targetGroupListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	targetGroupId = targetGroupListGrid.opt.gridControl.getSelectedRecords()[0].targetGroupId;
    	segmentId = targetGroupListGrid.opt.gridControl.getSelectedRecords()[0].segmentId;
    	camId = targetGroupListGrid.opt.gridControl.getSelectedRecords()[0].camId;
    	camStatusCd = targetGroupListGrid.opt.gridControl.getSelectedRecords()[0].camStatusCd;
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
    } else {
        alert('<spring:message code="M00108"/>'); //목록을 선택해주세요.
    }
}

function targetGroupSimpleBtn(){
        var url = '<ifvm:url name="simpleTargeting"/>?targetGroupId=';
    	qtjs.href(url);
}

//권한 불러오기
function campaignAuth(){
    $.ifvSyncPostJSON('<ifvm:action name="selectCampaignAuth"/>', {
    }, function(result) {

        empId = result.rows[0].empId;
        empType = result.rows[0].empType;
        authType = result.rows[0].authType;
        brandCd = result.rows[0].brandCd;
    });
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

    //권한 불러오기
    campaignAuth();

	//공통 조회 조건 목록 설정
    /*targetGroupListSearchInit();*/

	getTargetGroupList();

    // 조회
    $('#targetGroupListSearchBtn').on('click', function() {
        targetGroupListSearch();
    });

    // 초기화
    $("#targetGroupListSearchInitBtn").on('click', function() {
        targetGroupListSearchInit('targetGroupListGrid');
    });

    // 신규 클릭시
    $('#targetGroupNewBtn').on('click', function() {
        segmentListOpen();
    });

    $('#targetImportNewBtn').on('click', function() {
        goTargetImportDetail('');
    });

    //타겟Sql 신규
    $('#targetSqlNewBtn').on('click', function() {
        goTargetSqlDetail('');
    });

    // 세그먼트 팝업
//     $('#targetGroupSegmentViewPopBtn').on('click', function() {
//         openSegmentViewPopup();
//     });
    
    // 심플 타겟팅
    $('#targetGroupSimpleBtn').on('click', function() {
    	targetGroupSimpleBtn();
    });

    // 타겟그룹 삭제
    $('#targetGroupRemoveBtn').on('click', function() {
        removeTargetGroup();
    });

});

</script>

<div class="page-title">
    <h1>
        <spring:message code="O00195" />
        &gt; <spring:message code="M00273" />
    </h1>
</div>

<%--<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">

        	&lt;%&ndash; 조회 &ndash;%&gt;
            <button class="btn btn-sm" id="targetGroupListSearchBtn" objCode="targetGroupListSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>

            &lt;%&ndash; 초기화 &ndash;%&gt;
            <button class="btn btn-sm" id="targetGroupListSearchInitBtn" objCode="targetGroupListSearchInitBtn_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="targetGroupSearchList"></div>
</div>--%>

<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-12 searchbtn_r" style>

        	<%-- 조건상세 --%>
<!--             <button class="btn btn-sm" id="targetGroupSegmentViewPopBtn"><i class="fa fa-search"></i> -->
<%--                 <spring:message code="M00546" /> --%>
<!--             </button> -->

            <%-- 신규 --%>
<%--             <button class="btn btn-sm" id="targetGroupNewBtn" objCode="targetImportNewBtn_OBJ">
                <spring:message code="M02811" />
            </button>--%>
            <%-- 파일 업로드 --%>
            <button class="btn btn-sm" id="targetImportNewBtn" objCode="targetImportNewBtn_OBJ">
                <spring:message code="M02436" />
            </button>
            <%--<button class="btn btn-sm" id="targetSqlNewBtn" objCode="targetSqlNewBtn_OBJ">
             	   타겟SQL
            </button>--%>
            <%-- 심플 타겟팅 --%>
            <button class="btn btn-sm" id="targetGroupSimpleBtn" objCode="targetGroupSimpleBtn_OBJ">
               	 신규
            </button>
            <%-- 삭제 --%>
            <button class="btn btn-sm" id="targetGroupRemoveBtn" objCode="targetGroupRemoveBtn_OBJ"><i class="fa fa-minus"></i>
                <spring:message code="M00165" />
            </button>
        </div>
    </div>
    <div id="targetGroupListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="targetGroupNewPopup" class="popup_container"></div>
<div id="dialogTempPop"></div>
<div id="segmentViewPopup"></div>