<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var segmentListGrid;
//권한
var empId = '';
var authType = '';
var brandCd = '';

//공통 조회 조건 목록 설정
function segmentListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("segmentSearchList","ANL_SEG_001",gridId);
}

//공통 조회 호출
function segmentListSearch() {
	$.fn.ifvmSubmitSearchCondition("segmentSearchList", function() {
		segmentListGrid.searchGrid({
			item : requestitem
		});
	});
}
//캠페인 목록
function getSegmentList(page){

    var page = $.fn.ifvmIsNotEmpty(page) ? page : 1;

    var ejGridOption = {
        serializeGridData : function( data ){

        	if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }

        	//페이지 설정
        	data.page = page;

            return data;
        },
        recordDoubleClick : function (args) {
        	var data = args.data;

        	goSegmentDetail(data.segmentId);
        },
        dataUrl : '<ifvm:action name="getSegmentList_KPR"/>',
        columns:[
        	 {
	      		  field : 'segmentName', headerText : '<spring:message code="M00677"/>', width:200,headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 's.SEG_NM',
	      			  searchable: true}/* */
	      	  }, {
	      		  field : 'logicalCompName', headerText : '로지컬컴포넌트', headerTextAlign : 'center',width:200,
	      		  customAttributes : {
	      			  index : 'l.LGC_COMP_NM',
	      			  searchable: true}/* */
	      	  }, {
	      		  field : 'lgcDesc', headerText : '로지컬컴포넌트 설명', headerTextAlign : 'center',width:280,
	      		  customAttributes : {
	      			  index : 'l.LGC_DESC',
	      			  searchable: true}/* */
	      	  }, {
	      		  field : 'createByName', headerText : '<spring:message code="M00184"/>', headerTextAlign : 'center',width:80, textAlign : ej.TextAlign.Center ,
	      		  customAttributes : {
	      			  index : 'e.NAME' }/* */
	      	  }, {
	      		  field : 'createDate', headerText : '<spring:message code="등록일자"/>', headerTextAlign : 'center', width:80,textAlign : ej.TextAlign.Center ,
	      		  customAttributes : {
	      			  index : 's.CREATE_DATE' }/* */
	      	  }, {
	      		  field : 'segmentId', headerText : 'id', visible : false ,
	      		  customAttributes : {
	      			  index : 's.id' }/* */
	      	  },
        ],
        requestGridData : {
            empId : empId,
            authType : authType,
            brandCd : brandCd,
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 's.create_date',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true
//         tempId : 'ifvGridOriginTemplete'
    };

    segmentListGrid = $("#segmentListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//세그먼트 상세 이동
function goSegmentDetail(id) {
	var url = '<ifvm:url name="segmentDetail_KPR"/>?segmentId=' + id
    qtjs.href(url);
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
	segmentNewPopup._destroy();
}


//세그먼트 생성 팝업 열기
function segmentNewPopOpen() {
    $("#segmentNewPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="segmentNewPop_KPR"/>',
        contentType: "ajax",
        title: '<spring:message code="M01470" />',
        width: 1200,
        maxWidth : 1200,
        close : 'segmentNewPopClose'
    });
}

//타겟그룹 삭제
function removeSegment() {
    var segmentId;
    if ($.fn.ifvmIsNotEmpty(segmentListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	segmentId = segmentListGrid.opt.gridControl.getSelectedRecords()[0].segmentId;
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

//권한 불러오기
function campaignAuth(){
    $.ifvSyncPostJSON('<ifvm:action name="selectCampaignAuth"/>', {
    }, function(result) {
        empId = result.rows[0].empId;
        authType = result.rows[0].authType;
        brandCd = result.rows[0].brandCd;
    });
}

$(document).ready(function() {
    //권한 불러오기
    campaignAuth();

	//공통 조회 조건 목록 설정
    segmentListSearchInit();

	getSegmentList();


    //조회
    $('#segmentListSearchBtn').on('click', function(){
    	segmentListSearch();
    });

    //초기화
    $("#segmentListSearchInitBtn").on('click', function(){
    	segmentListSearchInit('segmentListGrid');
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
            <button class="btn btn-sm" id="segmentListSearchBtn" objCode="segmentListSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="segmentListSearchInitBtn" objCode="segmentListSearchInitBtn_OBJ">
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
            <button class="btn btn-sm" id="segmentNewBtn" objCode="segmentNewBtn_OBJ"><i class="fa fa-plus"></i>
                <spring:message code="M00274" />
            </button>
            <button class="btn btn-sm" id="segmentRemoveBtn" objCode="segmentRemoveBtn_OBJ"><i class="fa fa-minus"></i>
                <spring:message code="M00165" />
            </button>
        </div>
    </div>
    <div id="segmentListGrid" class="white_bg grid_bd0"></div>
</div>


<div id="segmentNewPopup" class="popup_container"></div>
<div id="dialogTempPop" class="popup_container"></div>