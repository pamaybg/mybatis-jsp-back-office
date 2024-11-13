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
var srcTgtGrid;

getSrcTgtList = {
	init : function (){
		srcTgtGrid = $("#srcTgtGrid").ifvsfGrid({ ejGridOption : getSrcTgtList.ejGridOption });
	},
	ejGridOption : {
// 		serializeGridData : function(data){
//         },
        recordDoubleClick : function (args) {
        	var tRid = args.data.rid;
        	getSrcTgtList.moveDetail(tRid);
        },
        dataUrl : '<ifvm:action name="getSrcTgtList"/>',
        columns:[
        	{
	      		  field : 'srcTgtNm', headerText : '<spring:message code="Q02827"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qst.srctgt_nm' }/* 소스/타겟 명 */
	      	  },{
	      		  field : 'srcTgtAlias', headerText : '<spring:message code="Q02828"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qst.srctgt_alias' }/* 약어 */
	      	  },{
	      		  field : 'comment', headerText : '<spring:message code="I00075"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qst.comment' }/* 설명 */
	      	  },{
	      		  field : 'useYn', headerText : '<spring:message code="Q02830"/>', headerTextAlign : 'center', template : "#checkActYn",
	      		  customAttributes : {
	      			  index : 'qst.USE_YN' }/* 활성여부 */
	      	  },{
	      		  field : 'createBy', headerText : '<spring:message code="Q02831"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'cu1.USER_ID' }/* 등록자 */
	      	  },{
	      		  field : 'createDate', headerText : '<spring:message code="Q02832"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qst.create_date' }/* 등록일시 */
	      	  },{
	      		  field : 'modifyBy', headerText : '<spring:message code="Q02833"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'cu2.USER_ID' }/* 수정자 */
	      	  },{
	      		  field : 'modifyDate', headerText : '<spring:message code="Q02834"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qst.modify_date' }/* 수정일시 */
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false ,
	      		  customAttributes : {
	      			  index : 'qst.rid' }
	      	  },
       ],
       requestGridData : {
       	  nd   : new Date().getTime(),
       	  rows : 10,
       	  sidx : 'qst.create_date',
       	  sord : 'desc',
       	  _search : false
         },
        radio: true,
	    rowList: $.ifvmGetSelectBoxNum(),
	    tempId : 'ifvGridOriginTemplete',
	    },
	newSrcTgt : function(){
		qtjs.href('<ifvm:url name="srcTgtDetail"/>');
	},
	deleteSrcTgt : function(){
		
		if (srcTgtGrid.opt.gridControl.getSelectedRecords()[0] == undefined){
			alert('<spring:message code="Q00015" />'); //삭제 대상을 선택하여 주세요.
			return;
		} else {
			if (confirm('<spring:message code="Q00016" />')) { //삭제하시겠습니까?
				var tRid = srcTgtGrid.opt.gridControl.getSelectedRecords()[0].rid;
				
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