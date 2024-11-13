<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

/** 
 * 채널목록 조회
 */
function getuseDeskChannelList() {
    
    var jqGridOption = {
        ondblClickRow : function(data) {
            var data = useDeskChannelList.getRowData()[data - 1];
            rid = data.rid;
        },
        onSelectRow : function(data) {
        },
        serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        loadComplete : function(obj) {
        	new ifvm.PopupHeight({
        		popupDivId : 'offerPopupCon' ,
        		contentsId : 'userDeskPopWrap'
        	});
        },
        url : '<ifvm:action name="getChannelList"/>',
        colNames:[ 
//          '<spring:message code="L00630" />',
            '<spring:message code="L00564" />',
            '<spring:message code="V00022" />',
//          '<spring:message code="M02283" />',
            '<spring:message code="L00621" />',
//          '<spring:message code="L00626" />',
            'rid'
        ],
        colModel:[
 //          { name:'ouTypeCd',      index:'a.ou_type_cd',  resizable : true, align:'center', width:'100px', searchable : false },
             { name:'chnlNo',        index:'chnlNo',     resizable : true, align:'center', width:'100px' },
             { name:'chnlNm',        index:'chnlNm',     resizable : true, align:'center', width:'100px' },
 //          { name:'stnMgmtDiv',    index:'e.div_nm',      resizable : true, align:'center', width:'100px' },
             { name:'parChnlNm',     index:'parChnlNm',     resizable : true, align:'center', width:'100px' },
 //          { name:'pointContType', index:'g.mark_name',   resizable : true, align:'center', width:'100px', searchable : false },
             { name:'rid',           index:'rid',         hidden : true}
        ],
        sortname : 'a.rid',
        sortorder : "desc",
        multiselect: true, 
        tempId : 'ifvGridOriginTemplete'
    };

    useDeskChannelList = $("#useDeskChannelListGrid").ifvGrid({
        jqGridOption : jqGridOption
    });
    gridIduseDeskChannelList = $("#useDeskChannelListGrid");
    gridIduseDeskChannelList.resize();
}

$(document).ready(function() {
    getuseDeskChannelList();
    
    // 추가
    $("#useDeskAddBtn").on("click", function() {
        useDeskAdd();
    });
    
    // 취소 
    $("#useDeskPopCancelBtn").on("click", function() {
        useDeskPopClose();
    });
    
});

</script>

<div id="useDeskPopWrap">
    <div class="pop_inner_wrap form-horizontal" id="useDeskPop" >
        <div id="useDeskChannelListGrid"></div>
    </div>
    
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="useDeskAddBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M01855"/>
        </button> 
        <button class="btn btn-sm btn_lightGray2" id="useDeskPopCancelBtn">         
            <spring:message code="M00441"/>
        </button> 
    </div>
</div>
<div id="loyChannelListPopup"></div>