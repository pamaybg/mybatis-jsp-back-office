<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script>
var campaignResultGrid;			//조회결과 그리드 (캠페인 목록)
var campaignPromExecGrid;		//프로모션 그리드
var campaignChnlExecGrid;		//채널실행 그리드
var channelUnsentPop;
var camId = '<%= cleanXss(request.getParameter("camId")) %>';	//캠페인ID
var promId;						//프로모션ID

/**
 * 화면 초기화
 */
function initCampaignExecInfo() {
    promId = '';
    
	campaignResult();
	
	$('#promExecGridArea').hide();
	$('#chnlExecGridArea').hide();
    $('#tgtRspnsGridArea').hide();
}

/**
 * 캠페인 목록
 */
function campaignResult() {

    var jqGridOption = {
        serializeGridData : function(data) {
            data.camId = camId;
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        onSelectRow : function (data) {
        },
		ondblClickRow : function(data) {
		},
		onSelectRow : function() {
		    getCampaignPromExecGrid();
		    getCampaignChnlExecGrid();
		    
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
            { name:'campaignStartDate',              index:'c.CAM_START_DD', width:'100px', align: 'center', resizable : false },
            { name:'campaignEndDate',                index:'c.CAM_END_DD', 	 width:'100px', align: 'center', resizable : false },
            { name:'campaignStatusCodeName',         index:'c2.MARK_NAME', 	 width:'100px', align: 'center', resizable : false },
            { name:'campaignApprovalStatusCodeName', index:'c9.MARK_NAME', 	 width:'100px', align: 'center', resizable : false },
            { name:'campaignTypeCodeName',           index:'c8.MARK_NAME', 	 width:'150px', resizable : false },
            { name:'camScopeTypeNm',                 index:'c10.MARK_NAME',  width:'100px', align: 'center', resizable : false },
            { name:'promYn',   				         index:'c.prom_yn', 	 width:'100px', resizable : false },
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
		tempId : 'ifvGridOriginTemplete',
    };    
    
	campaignResultGrid = $("#campaignResultGrid").ifvGrid({ jqGridOption : jqGridOption });
}

/**
 * 프로모션 실행 정보 조회 
 */
function getCampaignPromExecGrid() {

    var selectCamData = campaignResultGrid.getRowData()[0];
    
    // 프로모션인 경우 
    if (selectCamData.promYn != '1') {
        return;
    }
    
    $('#promExecGridArea').show();
	var jqGridOption = {
		serializeGridData : function(data) {
			data.camId = camId;
			return data;
		},
		onSelectRow : function() {
		    var selectData = campaignPromExecGrid.getCheckedGridData()[0];
		    promId = selectData.promId;
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

    var selectCamData = campaignResultGrid.getRowData()[0];
    if (selectCamData.campaignTypeCode == 'MASS') {	//MASS캠페인인 경우 출력되지 않음.
        return;
    }
    
    $('#chnlExecGridArea').show();
    
	var jqGridOption = {
		serializeGridData : function(data) {
			data.camId = camId;
			data.promId = promId;
			return data;
		},
		onSelectRow : function() {
		    getGridReactionInfo();
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
	              'itemId',
	              ],
    	colModel:[
    		{name:'promNo', 				index:'t2.prom_no',			  resizable : false, align: 'center', width: '100px'},
    		{name:'exeSeq', 				index:'i2.exe_seq',			  resizable : false, align: 'center', width: '100px'},
    		{name:'chnlTypeCd', 			index:'t1.chnl_type_cd',	  resizable : false, align: 'center', width: '120px'},
    		{name:'chnlSendCnt',			index:'t1.chnl_send_cnt',	  resizable : false, align: 'center', formatter: numberFormat, width: '120px'},
    		{name:'prmsChkRmvCnt', 			index:'t1.prms_chk_rmv_cnt',  resizable : false, align: 'center', formatter: numberFormat, width: '120px'},
    		{name:'fatiChkRmvCnt', 			index:'t1.fati_chk_rmv_cnt',  resizable : false, align: 'center', formatter: numberFormat, width: '120px'},
    		{name:'exceptRmvCnt', 			index:'t1.except_rmv_cnt',	  resizable : false, align: 'center', formatter: numberFormat, width: '120px'},
    		{name:'exeInfoStatusNm', 		index:'c1.mark_name',		  resizable : false, align: 'center', width: '120px'},
    		{name:'exeInfoStatusBatDtlNm', 	index:'c2.mark_name',		  resizable : false, align: 'center'},
    		{name:'tgtCount', 				index:'(select count(*) from mkt.mkt_tgt_dtl where cam_id = t1.cam_id and exe_info_prom_id = t2.id)',
    		    	resizable : false, width: '120px', align: 'center', formatter: numberFormat},
    		{name:'itemId', 	index:'',		  hidden: true},
    	],
	    sortname: 't1.exe_info_item_id asc, t1.chnl_type_cd asc, i2.exe_seq',
		sortorder: "asc",
		radio : true,
		tempId : 'ifvGridOriginTemplete',
	};
	campaignChnlExecGrid = $("#campaignChnlExecGrid").ifvGrid({ jqGridOption : jqGridOption });
}

/**
 * 대상자 목록 조회
 */
function getGridReactionInfo() {

    var paramColNames = [
         '<spring:message code="M01338"/>',
         '<spring:message code="M01359"/>',
         '<spring:message code="M01340"/>',
         '<spring:message code="M01360"/>',
         '<spring:message code="M01361"/>',
         '<spring:message code="M01362"/>',
         '<spring:message code="M01363"/>',
         'tgtDtlId',
    ];
    var paramColModel = [
        {name:'exeSeq',				index:'a.exeSeq', 		  resizable: false, align:'center', width: 80},
        {name:'exeDt',				index:'a.exeDt', 		  resizable: false, align:'center', formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"}},
        {name:'exeInfoStatusNm',	index:'a.exeInfoStatusNm',resizable: false},
        {name:'memId',				index:'a.memId', 		  resizable: false, align:'center', width: 120},
        {name:'conYn',				index:'a.conYn', 		  resizable: false, align:'center'},
        {name:'chanSendYn',			index:'a.chanSendYn',     resizable: false, align:'center'},
        {name:'userYn',				index:'a.userYn', 		  resizable: false, align:'center'},
        {name:'tgtDtlId',			index:'a.tgtDtlId', 	  hidden: true},
    ];
    var chnlType = campaignChnlExecGrid.getCheckedGridData()[0].chnlTypeCd;
    var itemId   = campaignChnlExecGrid.getCheckedGridData()[0].itemId;

    if (chnlType == 'SMS' || chnlType == 'LMS' || chnlType == 'MMS'
        	|| chnlType == 'KAKAO'
           	|| chnlType == 'EMAIL'
			|| chnlType == 'PUSH'
            ) {
        $('#tgtRspnsGridArea').show();
    }
    else {
        $('#tgtRspnsGridArea').hide();
       	return;
    }

    if (chnlType == 'EMAIL') {
        paramColNames.push('<spring:message code="M01402"/>');
        paramColModel.push({name:'openSucesYn',	index:'a.openSucesYn', align:'center', resizable: false});
    }
    else if (chnlType == 'KAKAO') {
        paramColNames.push(chnlType + ' <spring:message code="M02536"/>');
        paramColModel.push({name:'kakaoMsgType', index:'a.kakaoMsgType', resizable: false, width: 100, formatter: setKakaoType, align:'center'});
    }

    //결과 추가
    paramColNames.push(chnlType + ' <spring:message code="M02808" />');
    paramColNames.push(chnlType + ' <spring:message code="M02806" />');
    paramColNames.push(chnlType + ' <spring:message code="M02807" />');
    paramColModel.push({name:'batSendStatus', index:'a.batSendStatus',  align:'center', resizable: false});
    paramColModel.push({name:'sendSucesYn',	  index:'a.sendSucesYn',    align:'center', resizable: false});
    paramColModel.push({name:'sendFailYn',	  index:'a.sendFailYn',     align:'center', resizable: false});

    var jqGridOption = {
        serializeGridData : function(data) {
            data.itemId = itemId;
            data.chnlTypeCd = chnlType;
            data.camId = camId;
            return data;
        },
        onSelectRow : function() {
        },
        url : '<ifvm:action name="getStnCampaignTargetRspnsList"/>',
        colNames : paramColNames,
        colModel : paramColModel,
        sortname : 'a.exeSeq',
        sortorder : "asc",
        tempId : 'ifvGridOriginTemplete2',
        radio : true
    };

    campaignExecStatusDtlGrid = $("#campaignExecStatusDtlGrid").ifvGrid({
        jqGridOption : jqGridOption
    });
}

/**
 * 반응정보 컬럼 설정
 * 
 * @param cellValue
 * @param options
 * @param rowdata
 * @returns {String}
 */
function setKakaoType(cellValue) {
    if (cellValue == '004') return '<spring:message code="M02404"/>';	    //알림톡
    else if (cellValue == '005') return '<spring:message code="M02403"/>';	//친구톡
}

function gridDataSetFlag(cellValue) {
    if (cellValue == '1') return 'Y' 
    else return 'N'
}

/**
 * 캠페인 대상자 반응 조회 그리드
 * 
 * @param colNames
 * @param colModel
 */
function campaignExecStatusDtlGrid(colNames, colModel) {

    var jqGridOption = {
        serializeGridData : function(data) {
        },
        onSelectRow : function() {
        },
        colNames : colNames,
        colModel : colModel,
        sortname : '',
        sortorder : "desc",
        tempId : 'ifvGridScrollTemplete',
        radio : true
    };
    campaignExecStatusDtlGrid = $("#campaignExecStatusDtlGrid").ifvGrid({
		jqGridOption : jqGridOption
	});
}

function channelUnsentPopClose() {
    channelUnsentPop._destroy();
}

//숫자 콤마표시
function numberFormat(cellvalue) {
	var value = "";
	if ($.fn.ifvmIsNotEmpty(cellvalue)) {
		value = $.fn.ifvmNumberWithCommas(cellvalue);
	}
	return value;
}

$(document).ready(function() {
    
	$.ifvmLnbSetting('stnCamExecStatusList');
	
    //화면 초기화
	initCampaignExecInfo();
	
	//캠페인 조회 리스트
	var LeftMenuId = $(".leftMenu").find(".active").attr('prognum');
	$.fn.ifvmSetCommonCondList("campaignViewList", LeftMenuId);

	//목록 버튼
	$('#camExecStatusListBtn').on('click', function() {
	    qtjs.href('<ifvm:url name="stnCampaignSubjectsList"/>');
	});
	
	//엑셀 다운로드
	$("#excelCampaignDetailListBtn").on("click", function() {
	    var camInfo = campaignResultGrid.getRowData()[0];
	    if (camInfo.chnlTypeCd == "") {
	        alert('<spring:message code="S00045"/>');
	    }
	    else {
	        var selectChnlData = campaignChnlExecGrid.getCheckedGridData()[0];
	        var chnlType = selectChnlData.chnlTypeCd;
	        
	        var addParam = '?camId=' + camId;
	        addParam += '&chnlTypeCd=' + chnlType;
	        addParam += '&itemId=' + selectChnlData.itemId;
	        
	        qtjs.href('<ifvm:action name="excelStnCampaignTargetRspnsList"/>' + addParam);
	    }
	});

	//미전송 내역 조회
	$("#channelUnsentReasonsBtn").on("click", function() {
	    var rowData = campaignExecStatusDtlGrid.getCheckedGridData()[0];
	    if (rowData != null) {
	        $("#channelUnsentPop").ifvsfPopup({
	            enableModal : true,
	            enableResize : false,
	            contentUrl : '<ifvm:url name="stnExecStatusChannelUnsentPop"/>?tgtDtlId=' + rowData.tgtDtlId,
	            contentType : "ajax",
	            title : '<spring:message code="M01357"/>',
	            width : 900,
	            close : 'channelUnsentPopClose'
	        });
	    }
	    else {
	        alert('<spring:message code="M00004"/>');
	    }
	});

    $("#commonDtlBtn").on('click', function() {
        var data = campaignResultGrid.getCheckedList()[0];
        if (typeof (data) == 'undefined') {
            alert('<spring:message code="M00004" />');
        }
        else {
            qtjs.href('<ifvm:url name="stnCamExecStatusDetail"/>?camId=' + data.camId);
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

<!-- 캠페인 목록 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M01355" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<%-- 대상자 반응 조회 --%>
       		<button class="btn btn-sm" id="camExecStatusListBtn">
       			<spring:message code="M00002" />
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

<!-- 캠페인 대상자 반응 조회 -->
<div class="mg_top20" id="tgtRspnsGridArea">
    <div class="page_btn_area" id=''>
        <div class="col-xs-6">
            <span><spring:message code="M01353" /></span>
        </div>
        <div class="col-xs-6 searchbtn_r">
        
        	<%-- 엑셀 다운로드 --%>
            <button class="btn btn-sm" id="excelCampaignDetailListBtn">
                <spring:message code="M01218" />
            </button>
            
            <%-- 채널 미전송 사유 --%>
            <button class="btn btn-sm" id="channelUnsentReasonsBtn">
                <spring:message code="M01357" />
            </button>
        </div>
    </div>
    <div class="modal-open" id="SubjectReactGridWrap">
    	<div id="campaignExecStatusDtlGrid" class="grid_bd0"></div>
    </div>
</div>

<div id="channelUnsentPop" class="popup_container"></div>
