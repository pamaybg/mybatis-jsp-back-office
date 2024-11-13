<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var autoRespMsgGrid;
var listUrl;


function getAutoRespMsgList(){
	var jqGridOption = {
		ondblClickRow : function(data){
		},
	    onSelectRow : function (data) {
		},
		serializeGridData : function( data ){
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }     
            return data;
		},		
		url: '<ifvm:action name="getAutoRespMsgList"/>',
	    colNames:[
	              '<spring:message code="V00097"/>', /* 메시지 */
	              '<spring:message code="V00098"/>', /* 요청번호 */
	              '<spring:message code="V00099"/>', /* 응답코드 */
	              '<spring:message code="V00100"/>', /* 응답일 */
	              '<spring:message code="V00101"/>', /* 응답 */
	              '<spring:message code="V00102"/>', /* 전송일 */
	              '<spring:message code="V00103"/>', /* 발신번호 */
	              'rid'
	              ],
	    colModel:[
	              {name:'smsMsgNm',  			index:'b.mark_name', 			resizable : false, 		align:'left',    	width:'100px'},
	              {name:'smsSendCp', 			index:'a.SMS_SEND_CP', 			resizable : false, 		align:'center',    	width:'100px'},
	              {name:'responseCd', 			index:'a.RESPONSE_CD', 			resizable : false, 		align:'center',    	width:'100px'},
	              {name:'responseDt',     		index:'a.RESPONSE_DT', 			resizable : false, 		align:'center',    	width:'100px',  		formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"}},
	              {name:'responseMsg', 			index:'a.RESPONSE_MSG', 		resizable : false, 		align:'left',    	width:'100px'},
	              {name:'smsSendDt', 			index:'a.SMS_SEND_DT', 			resizable : false, 		align:'center',    	width:'100px',  		formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"}},
	              {name:'otgorTelNo', 			index:'a.OTGOR_TEL_NO', 		resizable : false, 		align:'center',    	width:'100px'},
	              {name:'rid', 					index:'a.rid', 					resizable : false, hidden : true},
			      ],  			
		radio:true,
		sortname: 'a.CREATE_DATE',
		sortorder: "desc",
// 		tempId : 'ifvGridExcelTemplete'
	};
	autoRespMsgGrid = $("#autoRespMsgListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function init(){
	clickSearchAutoRespMsgListBtn();
	clickInitializeAutoRespMsgListBtn();
}

//공통 조회 호출
function clickSearchAutoRespMsgListBtn() {
    $.fn.ifvmSubmitSearchCondition("autoRespMsgSearchList", getAutoRespMsgList);
}

//공통 조회 조건 목록 설정
function clickInitializeAutoRespMsgListBtn() {
    $.fn.ifvmSetCommonCondList("autoRespMsgSearchList","PGM_V_004");
} 

$(document).ready(function(){
	init();
	
	$.ifvEnterSetting(["#autoRespMsgSearchList"], function(){
		clickSearchAutoRespMsgListBtn();
	});
});
</script>

<div class="page-title">
    <h1>
    <spring:message code="V00096" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-2">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-10 searchbtn_r">
            <ifvm:inputNew type="button" id="searchAutoRespMsgListBtn"  text="L00030" btnType="search" btnFunc="clickSearchAutoRespMsgListBtn"/>
            <ifvm:inputNew type="button" id="initializeAutoRespMsgListBtn"  text="L00031" btnType="" btnFunc="clickInitializeAutoRespMsgListBtn"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="autoRespMsgSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-2">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-10 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload('autoRespMsgListGrid')" />
        </div>
    </div>
    <div id="autoRespMsgListGrid" class="white_bg grid_bd0"></div>     
</div>