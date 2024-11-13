<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
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

    //캠페인 정보
	campaignResult();
    
    //대상자 반응 조회
    getGridReactionInfo();
}

/**
 * 캠페인 목록
 */
function campaignResult() {
    var ejGridOption = {
        serializeGridData : function(data) {
            data.camId = camId;
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        rowSelected : function() {
        	getCampaignChnlExecGrid();
		},
		loadComplete : function(args) {
			getCampaignChnlExecGrid();
		},
		dataUrl : '<ifvm:action name="getRealTimeCampExeList"/>',
		columns:[
        	{
	      		  field : 'dispNo', headerText : '<spring:message code="L00417"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'c.DISP_NO' }/* */
	      	  },{
	      		  field : 'campaignName', headerText : '<spring:message code="M00592"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'c.CAM_NM' }/* */
	      	  },{
	      		  field : 'campaignStartDate', headerText : '<spring:message code="M00593"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'c.CAM_START_DD' }/* */
	      	  },{
	      		  field : 'campaignEndDate', headerText : '<spring:message code="M00594"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'c.CAM_END_DD' }/* */
	      	  },{
	      		  field : 'campaignStatusCodeName', headerText : '<spring:message code="M00595"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'c2.MARK_NAME' }/* */
	      	  },{
	      		  field : 'campaignApprovalStatusCodeName', headerText : '<spring:message code="M00974"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'c9.MARK_NAME' }/* */
	      	  },{
	      		  field : 'camScopeTypeNm', headerText : '<spring:message code="M02304"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'c10.MARK_NAME' }/* 캠페인*/
	      	  },{
	      		  field : 'campaignPlannerName', headerText : '<spring:message code="M00596"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'e.NAME' }/* 기획자*/
	      	  },{
	      		  field : 'planOrgCodeName', headerText : '<spring:message code="M00597"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'd1.div_nm' }/* 부서*/
	      	  },{
	      		  field : 'offerName', headerText : '<spring:message code="M01870"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'o.OFFER_NM' }/* 오퍼*/
	      	  },{
	      		  field : 'description', headerText : '<spring:message code="M00600"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'c.CAM_DESC' }/*비고 */
	      	  },{
	      		  field : 'campaignTypeCode', headerText : 'typeCode', headerTextAlign : 'center', visible :false ,
	      		  customAttributes : {
	      			  index : 'c8.CODE_NAME' }/* */
	      	  },{
	      		  field : 'id', headerText : 'id', visible :false ,
	      		  customAttributes : {
	      			  index : 'c.id' }/* */
	      	  },{
	      		  field : 'type', headerText : 'type', visible :false ,
	      		  customAttributes : {
	      			  index : 'c.type' }/* */
	      	  },{
	      		  field : 'campaignApprovalStatusCode', headerText : 'campaignApprovalStatusCode', visible :false ,
	      		  customAttributes : {
	      			  index : 'c9.CODE_NAME' }/*카드번호 */
	      	  }
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'c.create_date',
	      	  sord : 'desc',
	      	  _search : false
	        },
        rowList : [10,25,50,100],
        radio: false,
		tempId : 'ifvGridSimpleTemplete2'
    };

	campaignResultGrid = $("#campaignResultGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function getCampaignChnlExecGrid() {

    $('#chnlExecGridArea').show();

	var ejGridOption = {
		serializeGridData : function(data) {
			data.camId = camId;
			data.promId = promId;
			return data;
		},
		rowSelected : function() {
		    getGridReactionInfo();
		},
	    dataUrl: '<ifvm:action name="getRTCampChnlExeList"/>',
	    columns:[
	    	  {
	      		  field : 'exeSeq', headerText : '<spring:message code="M01338"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'exeSeq' }/*실행차수 */
	      	  },{
	      		  field : 'exeDt', headerText : '<spring:message code="M00859"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'exeDt' }/*실행일시 */
	      	  },{
	      		  field : 'chnlTypeCd', headerText : '<spring:message code="L00132"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'chnlTypeCd' }/*채널유형 */
	      	  },{
	      		  field : 'exeInfoStatusNm', headerText : '<spring:message code="M02797"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'exeInfoStatusNm' }/*배치 상태 */
	      	  },{
	      		  field : 'exeInfoStatusBatDtlNm', headerText : '<spring:message code="M02798"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'exeInfoStatusBatDtlNm' }/*배치 상세 상태 */
	      	  },{
	      		  field : 'tgtCnt', headerText : '<spring:message code="M00860"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Right, format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'camTgtCnt' }/*대상자수 */
	      	  },{
	      		  field : 'chnlSendCnt', headerText : '<spring:message code="M02800"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Right, format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'chnlSendCnt' }/*발송건수 */
	      	  },{
	      		  field : 'prmsChkRmvCnt', headerText : '<spring:message code="M02801"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Right, format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'prmsChkRmvCnt' }/*퍼미션 제외건수 */
	      	  },{
	      		  field : 'fatiChkRmvCnt', headerText : '<spring:message code="M02802"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Right, format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'fatiChkRmvCnt' }/*피로도 제외건수 */
	      	  },{
	      		  field : 'exceptRmvCnt', headerText : '<spring:message code="M02803"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Right, format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'exceptRmvCnt' }/*제외건수 */
	      	  },{
	      		  field : 'sendSucesCnt', headerText : '<spring:message code="M02916"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Right, format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'sendSucesCnt' }/*발송성공수 */
	      	  },{
	      		  field : 'sendFailCnt', headerText : '<spring:message code="M02917"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Right, format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'sendFailCnt' }/*발송실패수 */
	      	  },{
	      		  field : 'revSucesCnt', headerText : '<spring:message code="M02918"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Right, format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'revSucesCnt' }/*수신성공수 */
	      	  },{
	      		  field : 'readSucesCnt', headerText : '<spring:message code="M02919"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Right, format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'readSucesCnt' }/*읽음(오픈)성공수 */
	      	  },{
	      		  field : 'exeStartDt', headerText : '<spring:message code="M02914"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'exeStartDt' }/*실행시작일시 */
	      	  },{
	      		  field : 'exeEndDt', headerText : '<spring:message code="M02915"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'exeEndDt' }/*실행종료일시 */
	      	  }, 
		],
		requestGridData : {
	    	  nd   : new Date().getTime(),
	    	  rows : 10,
	    	  sidx : 'exeSeq asc, chnlTypeCd',
	    	  sord : 'asc',
	    	  _search : false
	      },
	      rowList : [10,25,50,100],
	      radio: true,
		  tempId : 'ifvGridOriginTemplete',
	};
	campaignChnlExecGrid = $("#campaignChnlExeGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

/**
 * 대상자 목록 조회
 */
function getGridReactionInfo() {

    var chnlType = "";
    var exeInfoItemId = "";
    var exeInfoChnlId = "";
    
    if (campaignChnlExecGrid.opt.gridControl.getSelectedRecords().length > 0) {
	    var obj = campaignChnlExecGrid.opt.gridControl.getSelectedRecords()[0];
	    chnlType = obj.chnlTypeCd != null ? obj.chnlTypeCd : "";
	    exeInfoItemId = obj.exeInfoItemId;
	    exeInfoChnlId = obj.exeInfoChnlId;
    }
    
    var columns = [
  	  	  {
    		  field : 'itemSeq', headerText : '<spring:message code="M01972"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
    		  customAttributes : {
    			  index : 't3.item_seq' }
    	  },{
    		  field : 'memId', headerText : '<spring:message code="M01360"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
    		  customAttributes : {
    			  index : 't3.mem_id' }/*배치 상태 */
    	  },{
    		  field : 'tgtDtlId', headerText : 'tgtDtlId', visible : false ,
    		  customAttributes : {
    			  index : 'tgtDtlId' }/*배치 상세 상태 */
    	  },
    ];
    
    //채널 관련
    if (chnlType != "") {
	    columns.push({
			  field : 'batSendStatusNm', headerText : chnlType + ' <spring:message code="M02808" />', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
			  customAttributes : {
				  index : 'c2.mark_name' }
		  });
	    columns.push({
			  field : 'batSendProcTime', headerText : chnlType + ' <spring:message code="M02925" />', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
			  customAttributes : {
				  index : 't5.bat_send_proc_time', searchable : false }
		  });
	    columns.push({
			  field : 'sendSucesYn', headerText : chnlType + ' <spring:message code="M02806" />', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
			  customAttributes : {
				  index : 't5.send_suces_yn' }
		  });
	    columns.push({
			  field : 'sendFailYn', headerText : chnlType + ' <spring:message code="M02807" />', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
			  customAttributes : {
				  index : 't5.send_fail_yn' }
		  });
	    
	    if (chnlType == 'EMAIL') {
		    columns.push({
				  field : 'openSucesYn', headerText : chnlType + ' <spring:message code="M01402" />', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
				  customAttributes : {
					  index : 't5.open_suces_yn' }
			  });
	    }
	    else if (chnlType == 'PUSH') {
		    columns.push({
				  field : 'revSucesYn', headerText : chnlType + ' <spring:message code="M02920" />', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
				  customAttributes : {
					  index : 't5.rev_suces_yn' }
			  });
		    columns.push({
				  field : 'readSucesYn', headerText : chnlType + ' <spring:message code="M02921" />', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
				  customAttributes : {
					  index : 't5.read_suces_yn' }
			  });
	    }
    }

    var ejGridOption = {
		serializeGridData : function(data) {
            data.exeInfoItemId = exeInfoItemId;
            data.exeInfoChnlId = exeInfoChnlId;
            data.chnlTypeCd = chnlType;
            data.camId = camId;
            
			return data;
		},
		rowSelected : function() {
		},
	    dataUrl: '<ifvm:action name="getRTCampTargetReact"/>',
	    columns : columns,
		requestGridData : {
	    	  nd   : new Date().getTime(),
	    	  rows : 10,
	    	  sidx : 'itemSeq',
	    	  sord : 'asc',
	    	  _search : false
	      },
	      rowList : [10,25,50,100],
	      radio: true,
		  tempId : 'ifvGridOriginTemplete',
	};
   	//ifvGridOriginTemplete2
	
	campaignExecStatusDtlGrid = $("#campaignExecStatusDtlGrid").ifvsfGrid({ ejGridOption : ejGridOption });
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

 	$.ifvmLnbSetting('realTimeCampaignExe'); 

    //화면 초기화
	initCampaignExecInfo();

	//캠페인 조회 리스트
	var LeftMenuId = $(".leftMenu").find(".active").attr('prognum');
	$.fn.ifvmSetCommonCondList("campaignViewList", LeftMenuId);

	//목록 버튼
	$('#camExecStatusListBtn').on('click', function() {
	    qtjs.href('<ifvm:url name="realTimeCampaignExe"/>');
	});

	//엑셀 다운로드
	$("#excelCampaignDetailListBtn").on("click", function() {
		$.ifvExcelDn('<ifvm:action name="excelCampaignTargetRspnsList"/>','campaignExecStatusDtlGrid');
	});

	//미전송 내역 조회
	$("#channelUnsentReasonsBtn").on("click", function() {
	    if (campaignExecStatusDtlGrid.opt.gridControl.getSelectedRecords().length > 0) {
	    	var obj = campaignExecStatusDtlGrid.opt.gridControl.getSelectedRecords()[0];
	    	var tgtDtlId = obj.tgtDtlId;
	    	
	    	var obj2 = campaignChnlExecGrid.opt.gridControl.getSelectedRecords()[0];
	    	var exeInfoItemId = obj2.exeInfoItemId;
		    var exeInfoChnlId = obj2.exeInfoChnlId;
	    	
	        $("#channelUnsentPop").ifvsfPopup({
	            enableModal : true,
	            enableResize : false,
	            contentUrl : '<ifvm:url name="execStatusChannelUnsentPop"/>?tgtDtlId=' + tgtDtlId + "&exeInfoChnlId=" + exeInfoChnlId,
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
        var data = campaignResultGrid.opt.gridControl.getSelectedRecords()[0];
        if (typeof (data) == 'undefined') {
            alert('<spring:message code="M00004" />');
        }
        else {
            qtjs.href('<ifvm:url name="campTargetReact"/>?camId=' + data.camId);
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
<%-- <div id="promExecGridArea">
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M02804" /></span>
        </div>
    </div>
    <div id="campaignPromExecGrid" class="white_bg grid_bd0 grid_scroll5"></div>
</div> --%>

<!-- 캠페인 실행 정보 -->
<div id="chnlExecGridArea">
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M01327" /></span>
        </div>
    </div>
    <div id="campaignChnlExeGrid" class="white_bg grid_bd0 grid_scroll5"></div>
</div>

<!-- 캠페인 대상자 반응 조회 -->
<div id="tgtRspnsGridArea">
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