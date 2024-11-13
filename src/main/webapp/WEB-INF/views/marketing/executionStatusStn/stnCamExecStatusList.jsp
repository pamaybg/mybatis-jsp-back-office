<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var campaignResultGrid;			//조회결과 그리드 (캠페인 목록)
var campaignPromExecGrid;		//프로모션 그리드
var campaignChnlExecGrid;		//채널실행 그리드
var errorHistoryPop;
var camId;						//캠페인ID
var promId;						//프로모션ID

/**
 * 화면 초기화
 */
function initCampaignExecInfo() {

    camId = '';
    promId = '';
    
	campaignResult();
	$('#promExecGridArea').hide();
	$('#chnlExecGridArea').hide();
}

/**
 * 캠페인 목록
 */
function campaignResult() {

    var jqGridOption = {
        serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        onSelectRow : function (data) {
        },
		ondblClickRow : function(data) {
		    camId = campaignResultGrid.getCheckedGridData()[0].id;
			qtjs.href('<ifvm:url name="stnCamExecStatusDetail"/>?camId=' + camId);
		},
		onSelectRow : function() {
		    var selectData = campaignResultGrid.getCheckedGridData()[0];
		    camId = selectData.id;
		    // 프로모션인 경우 
		    if (selectData.promYn == 'Y') {
		        $.fn.ifvmSubmitSearchCondition("campaignPromExecGrid", getCampaignPromExecGrid);
		    }
		    else $('#promExecGridArea').hide();
		    
		    // 캠페인 유형의 경우 MASS가 아닐때 
		    if (selectData.campaignTypeCode != 'MASS') {
				$.fn.ifvmSubmitSearchCondition("campaignChnlExecGrid", getCampaignChnlExecGrid);  
		    }
		    else $('#chnlExecGridArea').hide();
		},
        url : '<ifvm:action name="getStnCampaignListForExecResult"/>',
        colNames:[
                   '<spring:message code="L00417"/>',
                   '<spring:message code="M00592"/>',
                   '<spring:message code="M00593" />',
                   '<spring:message code="M00594" />',
                   '<spring:message code="M00595" />',
                   '<spring:message code="M00974" />',  //승인진행상태
                   '<spring:message code="M00598" />',  //유형
                   '<spring:message code="M02304" />',  //캠페인 범위
                   '<spring:message code="M02295" />',  //프로모션 여부
                   '<spring:message code="M00596" />',  //기획자
                   '<spring:message code="M00597" />',  //부서
                   '<spring:message code="M01870" />',  //오퍼
                   '<spring:message code="M00600" />',  //비고
                   'typeCode',
                   'id',
                   'type',
                   'campaignApprovalStatusCode'
        ],
        colModel:[
            { name:'dispNo',                         index:'c.DISP_NO',  	 width:'100px', resizable : false, align: 'center', },
            { name:'campaignName',                   index:'c.CAM_NM',   	 width:'250px', resizable : false, cellattr: function(){ return 'style="text-overflow:ellipsis;"';} },
            { name:'campaignStartDate',              index:'c.CAM_START_DD', width:'100px', align: 'center', resizable : false, formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"}},
            { name:'campaignEndDate',                index:'c.CAM_END_DD', 	 width:'100px', align: 'center', resizable : false, formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"}},
            { name:'campaignStatusCodeName',         index:'c2.MARK_NAME', 	 width:'100px', align: 'center', resizable : false },
            { name:'campaignApprovalStatusCodeName', index:'c9.MARK_NAME', 	 width:'100px', align: 'center', resizable : false },
            { name:'campaignTypeCodeName',           index:'c8.MARK_NAME', 	 width:'150px', resizable : false },
            { name:'camScopeTypeNm',                 index:'c10.MARK_NAME',  width:'100px', align: 'center', resizable : false },
            { name:'promYn',   				         index:'c.prom_yn', 	 width:'100px', align: 'center', resizable : false, formatter: chkFlag },
            { name:'campaignPlannerName',            index:'e.NAME', 		 width:'150px', resizable : false },
            { name:'planOrgCodeName',                index:'d1.div_nm', 	 width:'150px', resizable : false },
            { name:'offerName',                      index:'o.OFFER_NM', 	 width:'150px', resizable : false },
            { name:'description',                    index:'c.CAM_DESC', 	 width:'150px', resizable : false },
            { name:'campaignTypeCode',               index:'c8.CODE_NAME',   hidden: true, searchable : false },
            { name:'id',                             index:'c.id',           hidden: true, searchable : false },
            { name:'type',                           index:'c.type',         hidden: true, searchable : false },
            { name:'campaignApprovalStatusCode',     index:'c9.CODE_NAME',   hidden: true, searchable : false },
        ],
        sortname: 'c.create_date',
        sortorder: "desc",
        radio: true,
    };
    
	campaignResultGrid = $("#campaignResultGrid").ifvGrid({ jqGridOption : jqGridOption });
}

/**
 * 프로모션 실행 정보 조회 
 */
function getCampaignPromExecGrid() {
    $('#promExecGridArea').show();
    
	var jqGridOption = {
		serializeGridData : function(data) {
			data.camId = camId;
			return data;
		},
		onSelectRow : function() {
		    var selectData = campaignPromExecGrid.getCheckedGridData()[0];
		    promId = selectData.promId;
		    camId = selectData.camId;
		    $.fn.ifvmSubmitSearchCondition("campaignChnlExecGrid", getCampaignChnlExecGrid);
		},
	    url: '<ifvm:action name="getStnCampaignPromExecList"/>', 
	    colNames:[
 	              '<spring:message code="M02799"/>',	//프로모션번호
 	              '<spring:message code="M01338"/>',	//실행차수
 	              '<spring:message code="M02747"/>',	//기간
 	              '<spring:message code="M00891"/>',	//상태
 	              '<spring:message code="M00860"/>',	//대상자수
 	              '<spring:message code="M02796"/>',	//승인서버전송여부
 	              '<spring:message code="M02797"/>',	//배치상태
 	              '<spring:message code="M02798"/>',	//배치상세상태
 	              'promId',					//프로모션ID
 	              'camId',					//캠페인ID
 	              'exeInfoStatusCd',		//배치상태코드
 	              'exeInfoStatusBatDtlCd',	//배치상세상태코드
 	              'promStartDt', 
 	              'promEndDt', 
		],
	    colModel:[
				{name:'promNo', 				index:'t1.prom_no', 	 	resizable: false, align: 'center', width: '100px'},
				{name:'exeSeq', 				index:'t1.exe_seq', 	 	resizable: false, align: 'center', width: '100px'},
				{name:'promTerm', 				index:'t1.prom_start_dt',	resizable: false, align: 'center'},
				{name:'promStatusNm', 			index:'c3.mark_name', 	   	resizable: false, align: 'center', width: '120px'},
				{name:'tgtCount', 				index:'(select count(*) from mkt.mkt_tgt_dtl where cam_id = i1.id and exe_info_prom_id = t1.id)', resizable: false, searchable: false, align: 'center', formatter: numberFormat, width: '120px'},
				{name:'txnTranYn', 				index:'t1.txn_tran_yn',	    resizable: false, align: 'center', width: '120px'},
				{name:'exeInfoStatusNm', 		index:'c1.mark_name',	    resizable: false, align: 'center', width: '120px'},
				{name:'exeInfoStatusBatDtlNm', 	index:'c2.mark_name', 	    resizable: false, align: 'center'},
				{name:'promId', 				index:'t1.id', 					       hidden: true},
				{name:'camId', 					index:'t1.cam_id', 			           hidden: true},
				{name:'exeInfoStatusCd', 		index:'t1.exe_info_status_cd', 	       hidden: true},
				{name:'exeInfoStatusBatDtlCd', 	index:'t1.exe_info_status_bat_dtl_cd', hidden: true},
				{name:'promStartDt', 			index:'t1.prom_start_dt', 		       hidden: true},
				{name:'promEndDt', 				index:'t1.prom_end_dt', 		       hidden: true},
	    ],
	    sortname: 't1.id asc, t1.exe_seq',
		sortorder: "asc",
        radio: true,
		tempId : 'ifvGridOriginTemplete',
	};
	campaignPromExecGrid = $("#campaignPromExecGrid").ifvGrid({ jqGridOption : jqGridOption });
}

/**
 * 채널 실행 정보 조회
 */
function getCampaignChnlExecGrid() {
    $('#chnlExecGridArea').show();
    
	var jqGridOption = {
		serializeGridData : function(data) {
			data.camId = camId;
			data.promId = promId;
			return data;
		},
	    url: '<ifvm:action name="getStnCampaignChnlExecList"/>', 
	    colNames:['<spring:message code="M02799"/>',	//프로모션번호
	              '<spring:message code="M01338"/>',	//실행차수
	              '<spring:message code="L00132"/>',	//채널유형
	              '<spring:message code="M02800"/>',	//발송건수
	              '<spring:message code="M02801"/>',	//퍼미션 제외건수
	              '<spring:message code="M02802"/>',	//피로도 제외건수
	              '<spring:message code="M02803"/>',	//기타 제외건수
	              '<spring:message code="M02797"/>',	//배치 상태
	              '<spring:message code="M02798"/>',	//배치 상세 상태
	              '<spring:message code="M00860"/>',	//대상자수
		],
	    colModel:[
				{name:'promNo', 				index:'t2.prom_no',			  resizable : false, align: 'center', width: '100px'},
				{name:'exeSeq', 				index:'i2.exe_seq',			  resizable : false, align: 'center', width: '100px'},
				{name:'chnlTypeCd', 			index:'t1.chnl_type_cd',	  resizable : false, align: 'center', width: '120px'},
				{name:'chnlSendCnt',			index:'t1.chnl_send_cnt',	  resizable : false, align: 'center', width: '120px'},
				{name:'prmsChkRmvCnt', 			index:'t1.prms_chk_rmv_cnt',  resizable : false, align: 'center', formatter: numberFormat, width: '120px'},
				{name:'fatiChkRmvCnt', 			index:'t1.fati_chk_rmv_cnt',  resizable : false, align: 'center', formatter: numberFormat, width: '120px'},
				{name:'exceptRmvCnt', 			index:'t1.except_rmv_cnt',	  resizable : false, align: 'center', formatter: numberFormat, width: '120px'},
				{name:'exeInfoStatusNm', 		index:'c1.mark_name',		  resizable : false, align: 'center', width: '120px'},
				{name:'exeInfoStatusBatDtlNm', 	index:'c2.mark_name',		  resizable : false, align: 'center'},
				{name:'tgtCount', 				index:'(select count(*) from mkt.mkt_tgt_dtl where cam_id = t1.cam_id and exe_info_prom_id = t2.id)',
				    	resizable : false, width: '120px', align: 'center', formatter: numberFormat},
	    ],
	    sortname: 't1.exe_info_item_id asc, t1.chnl_type_cd asc, i2.exe_seq',
		sortorder: "asc",
		radio : false,
		tempId : 'ifvGridOriginTemplete',
	};
	campaignChnlExecGrid = $("#campaignChnlExecGrid").ifvGrid({ jqGridOption : jqGridOption });
}

// 공통 조회 조건 목록 설정
function campaignListSearchInit() {
    $.fn.ifvmSetCommonCondList("campaignViewList", "MKTMNG004");
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
    
    //화면 초기화
	initCampaignExecInfo();
	
	//캠페인 조회 리스트
	var LeftMenuId = $(".leftMenu").find(".active").attr('prognum');
	$.fn.ifvmSetCommonCondList("campaignViewList", LeftMenuId);
	
	//오류내역조회
	$("#errorHistoryBtn").on("click", function() {
	    
	    if (camId != '') {
		    $("#errorHistoryPop").ifvsfPopup({
		        enableModal : true,
		        enableResize : false,
		        contentUrl : '<ifvm:url name="stnExecStatusErrorHistoryPop"/>',
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
    campaignListSearchInit();
	
  	//조회
    $('#campaignListSearchBtn').on('click', function() {
        $.fn.ifvmSubmitSearchCondition("campaignViewList", campaignResult);
    });

    // 초기화
    $("#campaignListSearchInitBtn").on('click', function() {
        $.fn.ifvmSetCommonCondList("campaignViewList", "STNCAM002");
    });

    $("#commonDtlBtn").on('click', function() {
        var data = campaignResultGrid.getCheckedGridData()[0];
        if (typeof (data) == 'undefined') {
            alert('<spring:message code="M00004" />');
        }
        else {
            qtjs.href('<ifvm:url name="stnCamExecStatusDetail"/>?camId=' + data.id);
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
    <div class="well form-horizontal well_bt5" id="campaignViewList"></div>
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
    <div id="campaignResultGrid" class="white_bg grid_bd0"></div>     
</div>

<!-- 프로모션 실행정보 -->
<div id="promExecGridArea">
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M02804" /></span>
        </div>
    </div>
    <div id="campaignPromExecGrid" class="white_bg grid_bd0 grid_scroll5"></div>     
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
