<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//grid
var campaignLgcCompListGrid;

//로지컬 컴포넌트 목록
function getCampaignLgcCompListGrid(){
    //그리드 생성
    var jqGridOption = {
        serializeGridData : function( data ){
        	
            //세그먼트 화면일경우
            try {
	        	if ($.fn.ifvmIsNotEmpty(segmentFlag)) {
	                data.segmentFlag = segmentFlag;
	            }
            } catch( exception ) {
            }
        	
            return data;
        },
        url : '<ifvm:action name="getETLogicalComponentList"/>',
        colNames:[ '<spring:message code="M01427"/>',
                   '<spring:message code="M00184"/>',
                   '<spring:message code="M00185"/>',
                   'id'
                 ],
        colModel:[
            { name:'logicalCompName', index:'l.LGC_COMP_NM', align: 'center', resizable : false },
            { name:'createByName', index:'e.NAME', align: 'center', resizable : false },
            { name:'createDate', index:'l.CREATE_DATE', align: 'center', resizable : false },
            { name:'logicalCompId', index:'l.id', hidden : true }
        ],
        sortname: 'l.CREATE_DATE',
        sortorder: "desc",
        radio: true,
        tempId : 'ifvGridOriginTemplete'
    };
    
    campaignLgcCompListGrid = $("#campaignLgcCompListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function() {
    getCampaignLgcCompListGrid();
	
	//확인 클릭시
    $('#campaignLgcCompListPopConfirmBtn').on('click', function(){
    	campaignLgcCompListPopConfirm();
    });
    
	//닫기 클릭시
    $('#campaignLgcCompListPopCloseBtn').on('click', function(){
        campaignLgcCompListPopup._destroy();
    });
});
</script>

<div id="dialogProgPopupWrap">
	<div class="pop_inner_wrap form-horizontal" id="campaignLgcCompListPop" >
        <div id="campaignLgcCompListGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area bd_top0">
	    <button class="btn btn-sm btn_gray" id="campaignLgcCompListPopConfirmBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00804"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="campaignLgcCompListPopCloseBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>