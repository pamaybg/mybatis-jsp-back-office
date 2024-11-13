<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var previousCampaignGrid;
var previousCampaignGridDiv;

/**
 * 캠페인 목록 조회
 */
function initPreviousCampaignGrid() {

    var jqGridOption = {
        serializeGridData : function(data) {
            return data;
        },
        url: '<ifvm:action name="getCampaignListForMultistage"/>',
        colNames:[
            '<spring:message code="M00592" />',
            '<spring:message code="M00593" />',
            '<spring:message code="M00594" />',
            '<spring:message code="M00595" />',
            '<spring:message code="M00596" />',
            '<spring:message code="M00597" />',
            '<spring:message code="M00598" />',
            '<spring:message code="M02369" />',
            'typeCode',
            'id'
        ],
        colModel:[
            { name:'campaignName',           index:'c.CAM_NM',       width:'250px', resizable : false, cellattr: function(){ return 'style="text-overflow:ellipsis;"';} },
            { name:'campaignStartDate',      index:'c.CAM_START_DD', width:'100px', resizable : false, align: 'center' },
            { name:'campaignEndDate',        index:'c.CAM_END_DD',   width:'100px', resizable : false, align: 'center' },
            { name:'campaignStatusCodeName', index:'c2.MARK_NAME',   width:'100px', resizable : false, align: 'center' },
            { name:'campaignPlannerName',    index:'e.NAME',         width:'120px', resizable : false },
            { name:'planOrgCodeName',        index:'di.div_nm',      width:'100px', resizable : false },
            { name:'campaignTypeCodeName',   index:'c8.MARK_NAME',   width:'120px', resizable : false },
            { name:'useableYN',              index:"if (t.useableYN is null, 'N', t.useableYN)", width:'120px', resizable : false, align: 'center' },
            { name:'campaignTypeCode',       index:'c8.CODE_NAME',   hidden : true },
            { name:'id',                     index:'c.id',           hidden : true }, 
        ],
        sortname: 'c.create_date',
        sortorder: "desc",
        radio: true,
        tempId : 'ifvGridOriginTemplete',
    };
    previousCampaignGrid = $("#previousCampaignGridDiv").ifvGrid({
        jqGridOption : jqGridOption
    });
    previousCampaignGridDiv = $("#previousCampaignGridDiv");
    previousCampaignGridDiv.resize();
}

/**
 * 선행 캠페인 선택
 */
function previousCampaignSelect() {
    
    var len = previousCampaignGrid.getCheckedGridData().length;
    
    if (len > 0) {
        var preCampaign = previousCampaignGrid.getCheckedGridData()[0];
        
        multiStageInfo.changeCamId = true;
        
        multiStageInfo.bfCamId                = preCampaign.id;
        multiStageInfo.campaignTypeCode       = preCampaign.campaignTypeCode;
        multiStageInfo.campaignDate           = preCampaign.campaignStartDate + ' ~ ' + preCampaign.campaignEndDate
        multiStageInfo.campaignStatusCodeName = preCampaign.campaignStatusCodeName;
        multiStageInfo.campaignName           = preCampaign.campaignName;
        
        multiStageInfo.condition = [];
        
        // 화면 정보 셋팅
        setMultiStageData();
        
        // 선행 캠페인 팝업 종료
        previousCampaignPopupClose();
    }
    else {
        alert('<spring:message code="L00066"/>');
    }
}

$(document).ready(function() {
    
    //캠페인 목록 조회
    initPreviousCampaignGrid();

    //선택 버튼
    $('#previousCampaignSelectBtn').on('click', function() {
        previousCampaignSelect();
    });
    
    //닫기 버튼
    $('#previousCampaignPopCancelBtn').on('click', function() {
        previousCampaignPopupClose();
    });
});

</script>

<div id="previousCampaignPopWrap">
    <div class="pop_inner_wrap">
        <div id="previousCampaignGridDiv"></div>
    </div>
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="previousCampaignSelectBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00282"/>
        </button> 
        <button class="btn btn-sm btn_lightGray2" id="previousCampaignPopCancelBtn">         
            <spring:message code="M00441"/>
        </button> 
    </div>
</div>