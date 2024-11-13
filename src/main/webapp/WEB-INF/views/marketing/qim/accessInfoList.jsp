<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>

<script>
var accessInfoGrid;


getAccessInfoList = {
	init : function (){
		accessInfoGrid = $("#accessInfoGrid").ifvGrid({ jqGridOption : getAccessInfoList.jqGridOption });
	},
	jqGridOption : {
		serializeGridData : function( data ){
	      	if ($.fn.ifvmIsNotEmpty(requestitem)) {
	      		data.item = requestitem;
	        }
        },
        ondblClickRow : function (data) {
        	var tRid = accessInfoGrid.getRowData()[data-1].rid;
        	getAccessInfoList.moveDetail(tRid);
        },
        onSelectRow : function (data) {
        },
        loadComplete : function(result){
        },
        url : '<ifvm:action name="getAccessInfoList"/>',
        colNames:[
                  '<spring:message code="L01841"/>', /* 유형 */
                  '<spring:message code="Q02846"/>', /* 리소스명 */
                  '<spring:message code="Q02859"/>', /* DB Type */
                  '<spring:message code="Q02860"/>', /* 호스트 주소 */
                  '<spring:message code="Q02861"/>', /* Port */
                  '<spring:message code="Q02862"/>', /* 스키마 */
                  '<spring:message code="Q02830"/>', /* 활성여부 */
                  '<spring:message code="Q02863"/>', /* User Name */
                  '<spring:message code="Q02847"/>', /* 생성일시 */
                  '<spring:message code="Q02834"/>', /* 수정일시 */
                  '<spring:message code="Q02848"/>', /* 생성자 */
                  'rid'
                ],
       colModel:[
           { name:'rscType', 	    index:'qr.RSC_TYPE', 			width:'80px', 		align: 'center', 	resizable : false },
           { name:'rscNm', 			index:'qr.RSC_NM', 				width:'120px', 		align: 'center', 	resizable : false },
           { name:'dbType', 	    index:'qr.DB_TYPE', 			width:'80px', 		align: 'center', 	resizable : false },
           { name:'hostAddr', 		index:'qr.HOST_ADDR', 			width:'100px', 		align: 'center', 	resizable : false },
           { name:'port', 			index:'qr.PORT', 				width:'80px', 		align: 'center', 	resizable : false },
           { name:'dbSchema', 		index:'qr.DBSCHEMA', 			width:'100px', 		align: 'center', 	resizable : false },
           { name:'useYn', 			index:'qr.USE_YN', 				width:'80px', 		align: 'center', 	resizable : false },
           { name:'userName', 		index:'qr.LOGIN_ID', 			width:'100px', 		align: 'center', 	resizable : false },
           { name:'createDate', 	index:'qr.create_date', 		width:'120px', 		align: 'center', 	resizable : false },
           { name:'modifyDate', 	index:'qr.modify_date', 		width:'120px', 		align: 'center', 	resizable : false },
           { name:'modifyBy', 		index:'qr.modify_by', 			width:'100px', 		align: 'center', 	resizable : false },
           { name:'rid', 			index:'qr.rid', 				hidden : true }
       ],
        sortname: 'qr.create_date',
        sortorder: "desc",
	    radio : true,
	    tempId : 'ifvGridOriginTemplete'

	},
	moveDetail : function(rid){
		qtjs.href('<ifvm:url name="accessInfoDetail"/>' + '?rid=' + rid);
	},
	newAccessInfo : function(){
		qtjs.href('<ifvm:url name="accessInfoDetail"/>');
	},
	deleteAccessInfo : function(){
		
		if (accessInfoGrid.getCheckedGridData()[0] == undefined){
			alert('<spring:message code="Q00015" />'); //삭제 대상을 선택하여 주세요.
			return;
		} else {
			if (confirm('<spring:message code="Q00016" />')) { //삭제하시겠습니까?
				var tRid = accessInfoGrid.getCheckedGridData()[0].rid;
				
		 		$.ifvSyncPostJSON('<ifvm:action name="removeAccessInfo"/>', {
					rid : tRid
				}, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						alert('<spring:message code="V00219" />'); // 완료되었습니다.
						getAccessInfoList.init();
					}
				}, function(result) {
					alert(result.message);
				});						
			}
		}
	},
}

/* function checkActYn(cellvalue, options, rowObjec){
	var isYn="";
	var regCnt = null;
	regCnt = rowObjec.useYn;

	if(regCnt == 1 || regCnt == "Y"){
		isYn="Y"
	}else{
		isYn="N";
	}
	
	return isYn;
} */

function searchCondInit() {
	$.fn.ifvmSetCommonCondList("resourceSearchList","PQIM_003");
}

//공통 조회 호출
function resourceListSearch() {
	$.fn.ifvmSubmitSearchCondition("resourceSearchList", getAccessInfoList.init);
}

$(document).ready(function(){
	
	getAccessInfoList.init();
	
	searchCondInit();
	
	  //조회
    $('#searchCondBtn').on('click', function(){
    	resourceListSearch();
    });

    //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit();
    });
    
});
</script>

<div class="page-title">
    <h1>
        <spring:message code="Q02858"/> <!-- 리소스 관리 -->
    </h1>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span> <!-- 조회 조건 -->
        </div>
        <div class="col-xs-5 searchbtn_r">
            <ifvm:inputNew type="button" id="searchCondBtn" btnType="search" text="L00081" /> <!-- 조회 -->
            <ifvm:inputNew type="button" id="searchCondInitBtn" text="L00082" /> <!-- 초기화 -->
        </div>
    </div>
	<div class="well form-horizontal well_bt5" id="resourceSearchList" ></div>
</div>
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="L00930"/></span> <!-- 조회결과 -->
        </div>
        <div class="col-xs-5 searchbtn_r">
           	<ifvm:inputNew type="button" id="" text="I00247" btnFunc="getAccessInfoList.newAccessInfo" /> <!-- 신규 -->
           	<!-- 로그보기 -->
           	<%-- <ifvm:inputNew type="button" id="" text="Q02873" btnFunc="" /> --%>
           	<!-- 로그위치지정 -->
           	<%-- <ifvm:inputNew type="button" id="" text="Q02874" btnFunc="" /> --%>
           	<ifvm:inputNew type="button" id="" text="I00248" btnFunc="getAccessInfoList.deleteAccessInfo" /> <!-- 삭제 -->
        </div>
    </div>
    <div id="accessInfoGrid" class="white_bg grid_bd0"></div>
</div>