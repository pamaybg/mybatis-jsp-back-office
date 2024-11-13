
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>

<script>
var interfaceGrid;

getInterfaceList = {
	init : function (){
		interfaceGrid = $("#interfaceGrid").ifvGrid({ jqGridOption : getInterfaceList.jqGridOption });
	},
	jqGridOption : {
		serializeGridData : function( data ){
	      	if ($.fn.ifvmIsNotEmpty(requestitem)) {
	      		data.item = requestitem;
	        }
        },
        ondblClickRow : function (data) {
        	var tRid = interfaceGrid.getRowData()[data-1].rid;
        	getInterfaceList.moveDetail(tRid);
        },
        onSelectRow : function (data) {
        },
        loadComplete : function(result){
        },
        url : '<ifvm:action name="getInterfaceList"/>',
        colNames:[
			'<spring:message code="Q02841"/>', /* 인터페이스ID */
			'<spring:message code="Q02842"/>', /* 인터페이스명 */
			'<spring:message code="Q02843"/>', /* 인터페이스 방법 */
			'<spring:message code="Q02844"/>', /* 원본 시스템 */
			'<spring:message code="Q02845"/>', /* 대상 시스템 */
			'<spring:message code="Q02846"/>', /* 리소스명 */
			'<spring:message code="Q02830"/>', /* 활성여부 */
			'<spring:message code="Q02847"/>', /* 생성일시 */
			'<spring:message code="Q02834"/>', /* 수정일시 */
			'<spring:message code="Q02848"/>', /* 생성자 */
			'rid'
                ],
       colModel:[
			{ name:'ifId', 	    	index:'qim.if_id', 				width:'80px', 	align: 'center', 	resizable : false },
			{ name:'ifName', 		index:'qim.if_name', 			width:'120px', 	align: 'center', 	resizable : false },
			{ name:'ifMethod', 	    index:'qim.if_method', 			width:'120px', 	align: 'center', 	resizable : false },
			{ name:'sourceAlias', 	index:'qst1.srctgt_alias', 		width:'80px', 	align: 'center', 	resizable : false },
			{ name:'targetAlias', 	index:'qst2.srctgt_alias', 		width:'80px', 	align: 'center', 	resizable : false },
			{ name:'rscNm', 		index:'qr.RSC_NM', 				width:'80px', 	align: 'center', 	resizable : false },
			{ name:'useYn', 		index:'qim.USE_YN', 			width:'80px', 	align: 'center', 	resizable : false, 		formatter:checkActYn },
			{ name:'createDate', 	index:'qim.create_date', 		width:'80px', 	align: 'center', 	resizable : false },
			{ name:'modifyDate', 	index:'qim.modify_date', 		width:'80px', 	align: 'center', 	resizable : false },
			{ name:'modifyBy', 		index:'cu1.USER_ID', 			width:'80px', 	align: 'center', 	resizable : false },
			{ name:'rid', 			index:'qim.rid', 				hidden : true }
       ],
        sortname: 'qim.create_date',
//         autowidth : true ,
        sortorder: "desc",
	    radio : true,
	    tempId : 'ifvGridOriginTemplete',
	},
	newInterface : function(){
		qtjs.href('<ifvm:url name="interfaceDetail"/>');
	},
	deleteInterface : function(){
		var tRid = interfaceGrid.getCheckedGridData()[0].rid;
		
		$.ifvSyncPostJSON('<ifvm:action name="removeInterface"/>', {
			rid : tRid
		}, function(result) {
			if ($.fn.ifvmIsNotEmpty(result)) {
				alert('<spring:message code="V00219" />'); /* 완료되었습니다. */
				getInterfaceList.init();
			}
		}, function(result) {
			alert(result.message);
		});
	},
	moveDetail : function(rid){
		qtjs.href('<ifvm:url name="interfaceDetail"/>' + '?rid=' + rid);
	}
};

function checkActYn(cellvalue, options, rowObjec){
	var isYn="";
	var regCnt = null;
	regCnt = rowObjec.useYn;

	if(regCnt == 1 || regCnt == "Y"){
		isYn="Y"
	}else{
		isYn="N";
	}
	
	return isYn;
}

//공통 조회 호출
function interfaceListSearch() {
	$.fn.ifvmSubmitSearchCondition("interfaceSearchList", getInterfaceList.init);
}

function interfaceListSearchInit() {
    $.fn.ifvmSetCommonCondList("interfaceSearchList","PQIM_004");
}
$(document).ready(function(){
	getInterfaceList.init();
	interfaceListSearchInit();
});
</script>

<div class="page-title">
    <h1>
        <spring:message code="Q02849"/> <!-- 인터페이스 관리 -->
    </h1>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span> <!-- 조회 조건 -->
        </div>
        <div class="col-xs-5 searchbtn_r">
            <ifvm:inputNew type="button" btnFunc="interfaceListSearch" btnType="search" text="L00081" /> <!-- 조회 -->
            <ifvm:inputNew type="button" btnFunc="interfaceListSearchInit" text="L00082" /> <!-- 초기화 -->
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="interfaceSearchList" ></div>
</div>
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="L00930"/></span> <!-- 조회결과 -->
        </div>
        <div class="col-xs-5 searchbtn_r">
           	<ifvm:inputNew type="button" id="" text="I00247" btnFunc="getInterfaceList.newInterface" /> <!-- 신규 -->
           	<ifvm:inputNew type="button" id="" text="I00248" btnFunc="getInterfaceList.deleteInterface" /> <!-- 삭제 -->
        </div>
    </div>
    <div id="interfaceGrid" class="white_bg grid_bd0"></div>
</div>