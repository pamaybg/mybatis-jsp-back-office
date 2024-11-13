<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style type="text/css">

 .con_size_3 {
	width : 1200px;
 	max-width: 1200px;
}


 


</style>

<script>
//grid
var logicalComponentListGrid;

//로지컬 컴포넌트 목록
function getLogicalComponentListGrid(){
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
        url : '<ifvm:action name="getCommonLogicalComponentList"/>',
        colNames:[ '<spring:message code="M01427"/>',
        		   '<spring:message code="로지컬컴포넌트 설명"/>',
                   '<spring:message code="M00184"/>',
                   '<spring:message code="등록일자"/>',
                   'id'
                 ],
        colModel:[
        	{ name:'logicalCompName', index:'l.LGC_COMP_NM', align: 'left', resizable : false,width:250 },
            { name:'logicalCompDesc', index:'l.LGC_DESC', align: 'left', resizable : false,width:500},
            { name:'createByName', index:'e.NAME', align: 'center', resizable : false ,width:80},
            { name:'createDate', index:'l.CREATE_DATE', align: 'center', resizable : false,width:80 },
            { name:'logicalCompId', index:'l.id', hidden : true }
        ],
        sortname: 'l.CREATE_DATE',
        sortorder: "desc",
        radio: true,
        rows : 15,
        rowList : [15,50,100],  // 한 번에 출력될 데이터row의 갯수 설정(15개)
        rowNum: 15,
        tempId : 'ifvGridOriginTemplete'
    };
    
    logicalComponentListGrid = $("#logicalComponentListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function() {
    getLogicalComponentListGrid();
	
	//확인 클릭시
    $('#logicalComponentListPopConfirmBtn').on('click', function(){
        logicalComponentListPopConfirm();
    });
    
	//닫기 클릭시
    $('#logicalComponentListPopCloseBtn').on('click', function(){
        logicalComponentListPopup._destroy();
    });
});
</script>

<div id="dialogProgPopupWrap">
	<div class="pop_inner_wrap" id="logicalComponentListPop" >
        <div id="logicalComponentListGrid" class="con_size_3"></div>
	</div>
	<div class="pop_btn_area bd_top0">
	    <button class="btn btn-sm btn_gray" id="logicalComponentListPopConfirmBtn" objCode="logicalComponentListPopConfirmBtn_OBJ">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00804"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray" id="logicalComponentListPopCloseBtn" objCode="logicalComponentListPopCloseBtn_OBJ">
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>