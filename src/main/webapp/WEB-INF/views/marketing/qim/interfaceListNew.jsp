<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>

<script type="text/x-jsrender" id="checkActYn">
	{{if useYn ==1 || useYn == "Y" }}
		<span>Y</span>
	{{else}}
		<span>N</span>
	{{/if}}
</script>

<script>
var interfaceGrid;

getInterfaceList = {
	init : function (){
		interfaceGrid = $("#interfaceGrid").ifvsfGrid({ ejGridOption : getInterfaceList.ejGridOption });
	},
	ejGridOption : {
		serializeGridData : function( data ){
	      	if ($.fn.ifvmIsNotEmpty(requestitem)) {
	      		data.item = requestitem;
	        }
        },
        recordDoubleClick : function (args) {
        	var tRid = args.data.rid
        	getInterfaceList.moveDetail(tRid);
        },
        dataUrl : '<ifvm:action name="getInterfaceList"/>',
        columns:[
        	  {
	      		  field : 'ifId', headerText : '<spring:message code="Q02841"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qim.if_id' } /* 인터페이스ID */
	      	  },{
	      		  field : 'ifName', headerText : '<spring:message code="Q02842"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qim.if_name' } /* 인터페이스명 */
	      	  },{
	      		  field : 'ifMethod', headerText : '<spring:message code="Q02843"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qim.if_method' } /* 인터페이스 방법 */
	      	  },{
	      		  field : 'sourceAlias', headerText : '<spring:message code="Q02844"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qst1.srctgt_alias' } /* 원본 시스템 */
	      	  },{
	      		  field : 'targetAlias', headerText : '<spring:message code="Q02845"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qst2.srctgt_alias' } /* 대상 시스템 */
	      	  },{
	      		  field : 'rscNm', headerText : '<spring:message code="Q02846"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qr.RSC_NM' } /* 리소스명 */
	      	  },{
	      		  field : 'useYn', headerText : '<spring:message code="Q02830"/>', headerTextAlign : 'center', template : "#checkActYn",
	      		  customAttributes : {
	      			  index : 'qim.USE_YN' } /* 활성여부 */
	      	  },{
	      		  field : 'createDate', headerText : '<spring:message code="Q02847"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qim.create_date' } /* 생성일시 */
	      	  },{
	      		  field : 'modifyDate', headerText : '<spring:message code="Q02834"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qim.modify_date' } /* 수정일시 */
	      	  },{
	      		  field : 'modifyBy', headerText : '<spring:message code="Q02848"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'cu1.USER_ID' } /* 생성자 */
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false,
	      		  customAttributes : {
	      			  index : 'qim.rid' }
	      	  },
       ],
       requestGridData : {
     	  nd   : new Date().getTime(),
     	  rows : 10,
     	  sidx : 'qim.create_date',
     	  sord : 'desc',
     	  _search : false
       },
       rowList : [10,25,50,100],
       radio: true,
	   tempId : 'ifvGridOriginTemplete',
	},
	newInterface : function(){
		qtjs.href('<ifvm:url name="interfaceDetail"/>');
	},
	deleteInterface : function(){
		var tRid = interfaceGrid.opt.gridControl.getSelectedRecords()[0].rid;
		
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

// function checkActYn(cellvalue, options, rowObjec){
// 	var isYn="";
// 	var regCnt = null;
// 	regCnt = rowObjec.useYn;

// 	if(regCnt == 1 || regCnt == "Y"){
// 		isYn="Y"
// 	}else{
// 		isYn="N";
// 	}
	
// 	return isYn;
// }

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