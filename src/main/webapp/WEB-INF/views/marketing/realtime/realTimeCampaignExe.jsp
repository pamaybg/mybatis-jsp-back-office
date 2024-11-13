<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script>
var realTimeCampGrid;			//조회결과 그리드 (캠페인 목록)
var campaignPromExecGrid;		//프로모션 그리드
var campaignChnlExecGrid;		//채널실행 그리드
var errorHistoryPop;
var camId=null;						//캠페인ID

/**
 * 화면 초기화
 */
function initCampaignExecInfo() {

    camId = '';

	campaignResult();
}

/**
 * 캠페인 목록
 */
function campaignResult() {

    var ejGridOption = {
        serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        recordDoubleClick : function(args) {
		},
		rowSelected : function(args) {
		    var selectData = args.data;
		    camId = selectData.id;
		    
			$.fn.ifvmSubmitSearchCondition("campaignChnlExecGrid", getCampaignChnlExecGrid);
		},
		loadComplete : function(args) {
	
			getCampaignChnlExecGrid();
		},
		dataUrl : '<ifvm:action name="getRealTimeCampExeList"/>',
        columns:[
        	{
	      		  field : 'dispNo', headerText : '<spring:message code="L00417"/>', headerTextAlign : 'center', width : '90px',
	      		  customAttributes : {
	      			  index : 'c.DISP_NO' }/*캠페인 번호 */
	      	  },{
	      		  field : 'campaignName', headerText : '<spring:message code="M00592"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'c.CAM_NM' }/*캠페인명 */
	      	  },{
	      		  field : 'campaignStartDate', headerText : '<spring:message code="M00593"/>', headerTextAlign : 'center',width : '80px',
	      		  customAttributes : {
	      			  index : 'c.CAM_START_DD' }/*시작일 */
	      	  },{
	      		  field : 'campaignEndDate', headerText : '<spring:message code="M00594"/>', headerTextAlign : 'center', width : '80px',
	      		  customAttributes : {
	      			  index : 'c.CAM_END_DD' }/*종료일 */
	      	  },{
	      		  field : 'campaignStatusCodeName', headerText : '<spring:message code="M00595"/>', headerTextAlign : 'center', width : '50px',
	      		  customAttributes : {
	      			  index : 'c2.MARK_NAME' }/*상태 */
	      	  },
// 	      	  {
// 	      		  field : 'campaignApprovalStatusCodeName', headerText : '<spring:message code="M00974"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'c9.MARK_NAME' }/*승인진행상태*/
// 	      	  },
	      	  {
	      		  field : 'campaignTypeCodeName', headerText : '<spring:message code="M00598"/>', headerTextAlign : 'center', width : '90px',
	      		  customAttributes : {
	      			  index : 'c8.MARK_NAME' }/*유형*/
	      	  },
// 	      	  {
// 	      		  field : 'camScopeTypeNm', headerText : '<spring:message code="M02304"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'c10.MARK_NAME' }/*캠페인 범위*/
// 	      	  },
	      	  //{
	      	  //	  field : 'promYn', headerText : '<spring:message code="M02295"/>', headerTextAlign : 'center', template :"#ynTemplate", width : '90px',textAlign : ej.TextAlign.Center ,
	      	  //	  customAttributes : {
	          //	  index : 'c.prom_yn' }/*프로모션 */
	      	  //},
	      	  {
	      		  field : 'campaignPlannerName', headerText : '<spring:message code="M00596"/>', headerTextAlign : 'center', width : '90px',
	      		  customAttributes : {
	      			  index : 'e.NAME' } /*기획자*/
	      	  },
// 	      	  {
// 	      		  field : 'planOrgCodeName', headerText : '<spring:message code="M00597"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'd1.div_nm' }/* 부서*/
// 	      	  },
	      	  {
	      		  field : 'offerName', headerText : '<spring:message code="M01870"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'o.OFFER_NM' }/*오퍼 */
	      	  },
// 	      	  {
// 	      		  field : 'description', headerText : '<spring:message code="M00600"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'c.CAM_DESC' }/*비고 */
// 	      	  },
	      	  {
	      		  field : 'campaignTypeCode', headerText : 'typeCode', visible : false ,
	      		  customAttributes : {
	      			  index : 'c8.CODE_NAME' }/* */
	      	  },{
	      		  field : 'id', headerText : 'id', visible : false ,
	      		  customAttributes : {
	      			  index : 'c.id' }/* */
	      	  },{
	      		  field : 'type', headerText : 'type', visible : false ,
	      		  customAttributes : {
	      			  index : 'c.type' }/* */
	      	  },{
	      		  field : 'campaignApprovalStatusCode', headerText : 'campaignApprovalStatusCode', visible : false ,
	      		  customAttributes : {
	      			  index : 'c9.CODE_NAME' }/* */
	      	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'c.create_date',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true,
    };

	realTimeCampGrid = $("#realTimeCampGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

/**
 * 채널 실행 정보 조회
 */
function getCampaignChnlExecGrid() {
    $('#chnlExecGridArea').show();

	var ejGridOption = {
		serializeGridData : function(data) {
			data.camId = camId;
			return data;
		},
	    dataUrl: '<ifvm:action name="getRTCampChnlExeList"/>',
	    columns:[
	    	{
	      		  field : 'dispNo', headerText : '캠페인번호', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'c.DISP_NO' }/*캠페인번호 */
	      	  },
	      	{
	      		  field : 'camNm', headerText : '캠페인명', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, width : '210px',
	      		  customAttributes : {
	      			  index : 'c.CAM_NM' }/*캠페인명 */
	      	  },
	      	  {
	      		  field : 'eventDataCnt', headerText : '이벤트 발생건수', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'eventDataCnt' }/*이벤트 발생건수 */
	      	  },{
	      		  field : 'epntCnt', headerText : '포인트 적립건수', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'epntCnt' }/*포인트 적립건수 */
	      	  },{
	      		  field : 'retailOfferCnt', headerText : '개인화오퍼(유통) 제공건수', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'retailOfferCnt' }/*개인화오퍼(유통) 제공건수 */
	      	  },{
	      		  field : 'foodOfferCnt', headerText : '개인화오퍼(외식) 제공건수', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'foodOfferCnt' }/*개인화오퍼(외식) 제공건수 */
	      	  },{
	      		  field : 'smsCnt', headerText : 'SMS 전송건수', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'smsCnt' }/*SMS 전송건수 */
	      	  },{
	      		  field : 'lmsCnt', headerText : 'LMS 전송건수', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'lmsCnt' }/*SMS 전송건수 */
	      	  },{
	      		  field : 'mmsCnt', headerText : 'MMS 전송건수', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'mmsCnt' }/*SMS 전송건수 */
	      	  },{
	      		  field : 'kkoChatBotCnt', headerText : '카카오챗봇 전송건수', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'kkoChatBotCnt' }/*SMS 전송건수 */
	      	  },{
	      		  field : 'kakaoCnt', headerText : '카카오친구톡 전송건수', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'kakaoCnt' }/*SMS 전송건수 */
	      	  },
	      	  {
	      		  field : 'pushCnt', headerText : 'PUSH 전송건수', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'pushCnt' }/*push 전송건수 */
	      	  },{
	      		  field : 'emailCnt', headerText : '이메일 전송건수', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'emailCnt' }/*email 전송건수 */
	      	  }
	      	  
		],
		requestGridData : {
	    	  nd   : new Date().getTime(),
	    	  rows : 10,
	      	  sidx : 'c.DISP_NO',
	      	  sord : 'asc',
	    	  _search : false
	      },
	      rowList : [10,25,50,100],
	      radio: false,
		  tempId : 'ifvGridNotSearchTemplete',
	};
	campaignChnlExecGrid = $("#campaignChnlExecGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function searchCondInit(gridId) {
    $.fn.ifvmSetCommonCondList("commSearchList","STNCAM002",gridId);
}

//공통 조회 호출
function camExecSerach() {
    $.fn.ifvmSubmitSearchCondition("commSearchList", campaignResult);
}



//숫자 콤마표시
function numberFormat(cellvalue) {
	var value = "";
	if ($.fn.ifvmIsNotEmpty(cellvalue)) {
		value = $.fn.ifvmNumberWithCommas(cellvalue);
	}
	return value;
}

function chkFlag(cellValue) {
    if (cellValue == '1') return 'Y';
    else return 'N';
}

/**
 * 오류내역조회 팝업 종료
 */
function errorHistoryPopClose() {
    errorHistoryPop._destroy();
}

$(document).ready(function() {
	//공통 조회 조건 목록 설정
    searchCondInit();

    //화면 초기화
	initCampaignExecInfo();



	//캠페인 조회 리스트
	var LeftMenuId = $(".leftMenu").find(".active").attr('prognum');
	// 	$.fn.ifvmSetCommonCondList("campaignViewList", LeftMenuId);

	//오류내역조회
	$("#errorHistoryBtn").on("click", function() {

	    if (camId != '') {
		    $("#errorHistoryPop").ifvsfPopup({
		        enableModal : true,
		        enableResize : false,
		        contentUrl : '<ifvm:url name="realTimeCampErrorHistPop"/>',
		        contentType : "ajax",
		        title : '<spring:message code="M01346"/>',
		        width : 900,
		        close : 'errorHistoryPopClose'
		    });
	    }
	    else {
	        //목록을 선택해 주세요
			alert('<spring:message code="I00728"/>');
	    }
	});

	//공통 조회 조건 목록 설정
//     campaignListSearchInit();

	//searchCondInit();
  	//조회
    $('#campaignListSearchBtn').on('click', function() {
    	camExecSerach();
//       $.fn.ifvmSubmitSearchCondition("campaignViewList", campaignResult);
    });

    // 초기화
    $("#campaignListSearchInitBtn").on('click', function() {
    	searchCondInit('realTimeCampGrid');
//         $.fn.ifvmSetCommonCondList("campaignViewList", "STNCAM002");
    });

    $("#commonDtlBtn").on('click', function() {
        var data = realTimeCampGrid.opt.gridControl.getSelectedRecords()[0];
        if (typeof (data) == 'undefined') {
            alert('<spring:message code="M00004" />');
        }
        else {
            qtjs.href('<ifvm:url name="campTargetReact"/>?camId=' + data.id);
        }
    });
});
</script>

<script id="ifvGridExecutionTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		<div class="filter_area">
			<div class="left">
				{searchBox}
			</div>
		</div>
		<div class="grid_con">
			{grid}
		</div>
	</div>
</script>

<div class="page-title">
    <h1>
        <spring:message code="M02452" />
        &gt; <spring:message code="M01325" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="campaignListSearchBtn">
            	<i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="campaignListSearchInitBtn">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
     <div class="well form-horizontal well_bt5" id="commSearchList" >
    </div>
</div>

<!-- 캠페인 목록 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<%-- 대상자 반응 조회 --%>
       		<button class="btn btn-sm" id="commonDtlBtn">
       			<spring:message code="M01424" />
      	  	</button>
      	  	<!-- 오류내역조회 -->
			<button class="btn btn-sm" id="errorHistoryBtn">
				<spring:message code="M01337"/>
			</button>
        </div>
    </div>
    <div id="realTimeCampGrid" class="white_bg grid_bd0"></div>
</div>


<!-- 채널 실행 정보 -->
<div id="chnlExecGridArea">
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M02805" /></span>
        </div>
    </div>
    <div id="campaignChnlExecGrid" class="white_bg grid_bd0 grid_scroll5"></div>
</div>

<div id="errorHistoryPop" class="popup_container"></div>
