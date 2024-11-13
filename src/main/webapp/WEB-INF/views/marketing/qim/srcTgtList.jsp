<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>

<script>
var srcTgtGrid;

getSrcTgtList = {
	init : function (){
		srcTgtGrid = $("#srcTgtGrid").ifvGrid({ jqGridOption : getSrcTgtList.jqGridOption });
	},
	jqGridOption : {
		serializeGridData : function(data){
        },
        ondblClickRow : function (data) {
        	var tRid = srcTgtGrid.getRowData()[data-1].rid;
        	getSrcTgtList.moveDetail(tRid);
        },
        onSelectRow : function (data) {
        },
        loadComplete : function(result){
        },
        url : '<ifvm:action name="getSrcTgtList"/>',
        colNames:[
                  '<spring:message code="Q02827"/>', /* 소스/타겟 명 */
                  '<spring:message code="Q02828"/>', /* 약어 */
                  '<spring:message code="I00075"/>', /* 설명 */
                  '<spring:message code="Q02830"/>', /* 활성여부 */
                  '<spring:message code="Q02831"/>', /* 등록자 */
                  '<spring:message code="Q02832"/>', /* 등록일시 */
                  '<spring:message code="Q02833"/>', /* 수정자 */
                  '<spring:message code="Q02834"/>', /* 수정일시 */
                  'rid'
                ],
       colModel:[
           { name:'srcTgtNm', 	    index:'qst.srctgt_nm', 		width:'120px', 	align: 'center', 	resizable : false },
           { name:'srcTgtAlias', 	index:'qst.srctgt_alias', 	width:'100px', 	align: 'center', 	resizable : false },
           { name:'comment', 	    index:'qst.comment', 		width:'140px', 	align: 'center', 	resizable : false },
           { name:'useYn', 			index:'qst.USE_YN', 		width:'80px', 	align: 'center', 	resizable : false, 		formatter:checkActYn },
           { name:'createBy', 		index:'cu1.USER_ID', 		width:'100px', 	align: 'center', 	resizable : false },
           { name:'createDate', 	index:'qst.create_date', 	width:'120px', 	align: 'center', 	resizable : false },
           { name:'modifyBy', 		index:'cu2.USER_ID', 		width:'100px', 	align: 'center', 	resizable : false },
           { name:'modifyDate', 	index:'qst.modify_date', 	width:'120px', 	align: 'center', 	resizable : false },
           { name:'rid', 			index:'qst.rid', 			hidden : true }
       ],
        sortname: 'qst.create_date',
//         autowidth : true ,
        sortorder: "desc",
	    radio : true,
	    rowList: $.ifvmGetSelectBoxNum(),
	    tempId : 'ifvGridOriginTemplete',
	    },
	newSrcTgt : function(){
		qtjs.href('<ifvm:url name="srcTgtDetail"/>');
	},
	deleteSrcTgt : function(){
		
		if (srcTgtGrid.getCheckedGridData()[0] == undefined){
			alert('<spring:message code="Q00015" />'); //삭제 대상을 선택하여 주세요.
			return;
		} else {
			if (confirm('<spring:message code="Q00016" />')) { //삭제하시겠습니까?
				var tRid = srcTgtGrid.getCheckedGridData()[0].rid;
				
				$.ifvSyncPostJSON('<ifvm:action name="removeSrcTgt"/>', {
					rid : tRid
				}, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						alert('<spring:message code="V00219" />'); /* 완료되었습니다. */
						getSrcTgtList.init();
					}
				}, function(result) {
					alert(result.message);
				});
			}
		}
	},
	moveDetail : function(rid){
		qtjs.href('<ifvm:url name="srcTgtDetail"/>' + '?rid=' + rid);
	}
}

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
$(document).ready(function(){
	getSrcTgtList.init();
});
</script>

<div class="page-title">
    <h1>
        <spring:message code="Q02839"/> <!-- 소스/타겟 관리 -->
    </h1>
</div>
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="Q02840"/></span> <!-- 소스/타겟 -->
        </div>
        <div class="col-xs-5 searchbtn_r">
           	<ifvm:inputNew type="button" id="" text="I00080" btnFunc="getSrcTgtList.newSrcTgt" /> <!-- 신규 -->
           	<ifvm:inputNew type="button" id="" text="I00248" btnFunc="getSrcTgtList.deleteSrcTgt" /> <!-- 삭제 -->
        </div>
    </div>
    <div id="srcTgtGrid" class="white_bg grid_bd0"></div>
</div>