<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" id="showCommentBtn"	btnFunc="showCommentFn" text="V00097" />

        </div>
    </div>

    <div id="mbrInOutHistListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="playRecordFilePop" class="popup_container"></div>
<script>
gMbrInOutList  = {
		checkedData : null,
		ejGridOption : 	{
		     serializeGridData : function( data ){
		    	 data.rid = gMbrDetail.data.rid;
		    	 return data;
		     },
		     recordDoubleClick : function (args) {
		     	var data = args.data;
		     	console.log(data);
		     },
		     rowSelected : function (data) {
		    	 console.log(data);

		    	 $("#showCommentBtn").prop('disabled',false);

	        },
		     loadComplete : function(result){
		    	 $("#showCommentBtn").prop('disabled',true);
		     	window.top.setParentIframeHeight();
		     },
		     dataUrl : '<ifvm:action name="getMbrChnlHistList"/>',
		     columns:[
		    	 {
		       		  field : 'atvyType', headerText : '<spring:message code="L00165"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 'atvyType' }
		       	  }, {
		       		  field : 'atvySubType', headerText : '<spring:message code="L01297"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 'atvySubType' }
		       	  }, {
		       		  field : 'chnlSendDt', headerText : '<spring:message code="L00601"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 'chnlSendDt' }
		       	  }, {
		       		  field : 'openYn', headerText : '<spring:message code="L02184"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 'openYn' }
		       	  }, {
		       		  field : 'chnlRpyDt', headerText : '<spring:message code="L01981"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 'chnlRpyDt' }
		       	  }, {
		       		  field : 'chnlRpyRsn', headerText : '<spring:message code="M00862"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 'chnlRpyRsn' }
		       	  }, {
		       		  field : 'comments', headerText : '<spring:message code="L01420"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 'comments' }
		       	  }, {
		       		  field : 'creatorLogin', headerText : '<spring:message code="L01299"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 'creatorLogin' }
		       	  }, {
		       		  field : 'acdCallDuration', headerText : '<spring:message code="L01298"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 'acdCallDuration' }
		       	  }, {
		       		  field : 'callId', headerText : '<spring:message code="L01300"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 'callId' }
		       	  },{
		       		  field : 'rid', headerText : 'rid', headerTextAlign : '',visible : false,
		       		  customAttributes : {
		       			  index : 'rid' }
		       	  },{
		       		  field : 'chnlTypeCd', headerText : 'chnlTypeCd', headerTextAlign : '', visible : false,
		       		  customAttributes : {
		       			  index : 'chnlTypeCd' }
		       	  }
		    ],
		    requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : 'reqDate',
		      	  sord : 'desc',
		      	  _search : false
		        },
		        rowList : [10,25,50,100],
		        radio: true
		}
}
mbrInOutHistList = $("#mbrInOutHistListGrid").ifvsfGrid({ ejGridOption : gMbrInOutList.ejGridOption });
function summaryComment(cellvalue, options, rowObject){
	if(cellvalue){
		var rtnVal = ""
		if(cellvalue.length >30){

			rtnVal = cellvalue.substring(0,30);
			rtnVal = rtnVal.replace(/\n/g, "");//엔터제거
			rtnVal += "..."
		}else{
			rtnVal = cellvalue;
		}
		return rtnVal;
	}
	else{
		return "";
	}
}
function convertTime(cellvalue, options, rowObject){
	if(cellvalue){
		var sec = cellvalue.split('.')[0];
		var rtnVal = ""
		rtnVal += pad(Math.floor((sec / 3600)),2) + ":";
		rtnVal += pad(Math.floor((sec % 3600 / 60)),2) + ":";
		rtnVal += pad((sec % 3600 % 60),2);
		return rtnVal;
	}
	else{
		return "";
	}
}
function pad(n, width) {
  n = n + '';
  return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
}
function showCommentFn(){
	var v_rid;
	var v_chnlTypeCd;
	var v_width;
	if ($.fn.ifvmIsNotEmpty(mbrInOutHistList.opt.gridControl.getSelectedRecords()[0])) {
		v_rid = mbrInOutHistList.opt.gridControl.getSelectedRecords()[0].rid;
		v_chnlTypeCd = mbrInOutHistList.opt.gridControl.getSelectedRecords()[0].chnlTypeCd;
	}
	if (v_chnlTypeCd =='20' ||v_chnlTypeCd =='70'){
		v_width = '900px';
	}else{
		v_width = '100px';
	}
	if ($.fn.ifvmIsNotEmpty(v_rid)) {

	 $("#commentsDialog").ifvsfPopup({
		  enableModal : true,
		        enableResize: true,
		        contentUrl: '<ifvm:url name="mbrChnlHistContents"/>'+'?rid='+v_rid+'&chnlTypeCd='+v_chnlTypeCd,
		        contentType: "ajax",
		        title: '메시지', //E1 오렌지카드
		        width: v_width,
		        close : 'commentsClose'
		    });
	}

}
//팝업 닫기
function commentsClose() {
	commentsDialog._destroy();
}

function buttonStatus(){

}

gMbrInOutSubList  = {
		checkedData : null,
		jqGridOption : 	{
		     serializeGridData : function( data ){
		    	 data.rid = gMbrDetail.data.rid;
		    	 return data;
		     },
		     ondblClickRow : function (rowNo) {
		     	var data = mbrInOutHistList.getRowData()[rowNo-1];
		     	console.log(data);
		     },
		     loadComplete : function(result){

		     },
		     url : '<ifvm:action name="getMbrChnlHistSubList"/>',
		     colNames:[
		               '<spring:message code="L01425"/>',
		               '<spring:message code="L01426"/>',
		               '<spring:message code="L01427"/>',
		               '<spring:message code="L01428"/>',
		               '<spring:message code="L01429"/>',
		               '<spring:message code="L01430"/>',
		               '<spring:message code="L01431"/>',
		               'rid'
		             ],
		    colModel:[
		        { name:'smsRpyMsg', 	index:'vah.sms_rpy_msg', 	width:'80px', 	align: 'center', 	resizable : true },
		        { name:'sendDt',		index:'vah.send_dt', 		width:'80px', 	align: 'center', 	resizable : true },
		        { name:'smsStage', 		index:'vah.cuser_id', 		width:'100px', 	align: 'center', 	resizable : true },
		        { name:'msgType', 	    index:'vah.call_id', 		width:'80px', 	align: 'center', 	resizable : true },
		        { name:'smsStage', 		index:'vah.sms_stage', 		width:'100px', 	align: 'center', 	resizable : true },
		        { name:'msgType', 		index:'vah.msg_type', 		width:'80px', 	align: 'center', 	resizable : true ,  formatter:'date', formatoptions:{newformat:"Y-m-d"}},
		        { name:'msgTitle', 		index:'vah.msg_title', 		width:'80px', 	align: 'center', 	resizable : true },

		        { name:'rid', 	   		index:'rid', 			width:'80px', 	align: 'center', 	resizable : true, 	hidden:true },

		    ],
		     sortname: 'vah.modify_date',
		     autowidth : true , sortorder: "desc"
		}
}
$(document).ready(function(){
	window.top.setParentIframeHeight();
});
		/* mbrInOutHistSubList = $("#mbrInOutHistSubListGrid").ifvGrid({ jqGridOption : gMbrInOutSubList.jqGridOption }); */
</script>



<div id="commentsDialog" class="popup_container"></div>