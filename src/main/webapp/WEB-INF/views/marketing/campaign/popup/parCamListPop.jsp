<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var parCamGridDiv;
var gridIdparCamGridDiv;

function initParCamGrid() {

    var jqGridOption = {
        serializeGridData : function(data) {
            data.id = campaign.id
            return data;
        },
        onSelectCell : function(data) {
        },
        loadComplete : function(obj) {
        },
        url: '<ifvm:action name="getCampaignListExcludeMyCam"/>',
        colNames:[
                  '<spring:message code="L00417"/>',
                  '<spring:message code="M00592"/>',
                  '<spring:message code="M00593" />',
                  '<spring:message code="M00594" />',
                  '<spring:message code="M00595" />',
           		  'id'
        ],
        colModel:[
			{ name:'dispNo',                 index:'c.DISP_NO',      width:'100px', resizable : false, align: 'center', },
			{ name:'campaignName',           index:'c.CAM_NM',       width:'250px', resizable : false, cellattr: function(){ return 'style="text-overflow:ellipsis;"';} },
			{ name:'campaignStartDate',      index:'c.CAM_START_DD', width:'100px', align: 'center', resizable : false },
			{ name:'campaignEndDate',        index:'c.CAM_END_DD',   width:'100px', align: 'center', resizable : false },
			{ name:'campaignStatusCodeName', index:'c2.MARK_NAME',   align: 'center', resizable : false },
            { name:'id',                     index:'c.id',           hidden : true }, 
        ],
        sortname: 'c.create_date',
        sortorder: "desc",
        radio: true,
        tempId : 'ifvGridOriginTemplete',
    };
    parCamGridDiv = $("#parCamGridDiv").ifvGrid({
        jqGridOption : jqGridOption
    });
    gridIdparCamGridDiv = $("#gridIdparCamGridDiv");
    gridIdparCamGridDiv.resize();
}

/**
 * 선택 
 */
function parCamSelect() {
    
    var len = parCamGridDiv.getCheckedGridData().length;
    
    if (len > 0) {
        var selectCam = parCamGridDiv.getCheckedGridData()[0];

        $('#parCampaignId').val(selectCam.id);
        $('#parDispNo').val(selectCam.dispNo);
        
        // 팝업 종료
        parCamPopupClose();
    }
    else {
        alert('<spring:message code="L00066"/>');
    }
}

$(document).ready(function() {
    
    initParCamGrid();
    
    //선택 버튼
    $('#parCamSelectBtn').on('click', function() {
        parCamSelect();
    });
    
    //닫기 버튼
    $('#parCamPopCancelBtn').on('click', function() {
        parCamPopupClose();
    });
});

</script>

<div id="parCamListPopWrap">
    <div class="pop_inner_wrap">
        <div id="parCamGridDiv"></div>
    </div>
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="parCamSelectBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00282"/>
        </button> 
        <button class="btn btn-sm btn_lightGray2" id="parCamPopCancelBtn">         
            <spring:message code="M00441"/>
        </button> 
    </div>
</div>