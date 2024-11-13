<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//grid
var expDividListPopGrid; 
var expDividListPopGridDiv;

/**
 * 재원 분담처 선택을 위한 채널 목록 조회
 */
function initExpDividListPopData() {
    
	var jqGridOption = {
	        
		loadComplete: function(obj) {
 		},
		onSelectRow: function (data) {
		},
		serializeGridData: function(data) {
		},
	    url:'<ifvm:action name="getChannelList"/>',
	    colNames:[ 
                  '<spring:message code="L00630" />',
                  '<spring:message code="L00564" />',
                  '<spring:message code="V00022" />',
                  '<spring:message code="M02283" />',
                  '<spring:message code="L00621" />',
                  '<spring:message code="L00626" />',
	              'rid'
	    ],
	    colModel:[
            { name:'ouTypeCd',      index:'a.ou_type_cd', resizable : true, align:'center', width:'100px', searchable : false },
            { name:'chnlNo',        index:'a.chnl_no',    resizable : true, align:'center', width:'100px' },
            { name:'chnlNm',        index:'a.chnl_nm',    resizable : true, align:'center', width:'100px' },
            { name:'stnMgmtDiv',    index:'e.div_nm',     resizable : true, align:'center', width:'100px' },
            { name:'parChnlNm',     index:'b.chnl_nm',    resizable : true, align:'center', width:'100px' },
            { name:'pointContType', index:'g.mark_name',  resizable : true, align:'center', width:'100px', searchable : false},
            { name:'rid',           index:'a.rid',        resizable : false,  hidden : true,  searchable : false}
	    ],
        sortname: 'a.rid',
        sortorder: "desc",
        radio: true,
        tempId : 'ifvGridOriginTemplete'
	};
	
	expDividListPopGrid = $("#expDividListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
	expDividListPopGridDiv = $("#expDividListPopGrid");
	expDividListPopGridDiv.resize();
}

$(document).ready(function() {
	
    initExpDividListPopData();
	
	//선택 클릭시
    $('#expDividListPopSelectBtn').on('click', function(){
    	expDividListPopupSelect();
    });
	
	//취소 클릭시
    $('#expDividListPopCancelBtn').on('click', function(){
    	expDividListPopupClose();
    });
});
</script>

<div id="expDividListPopWrap">
	<div class="pop_inner_wrap">
		<div id="expDividListPopGrid"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="expDividListPopSelectBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="expDividListPopCancelBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>