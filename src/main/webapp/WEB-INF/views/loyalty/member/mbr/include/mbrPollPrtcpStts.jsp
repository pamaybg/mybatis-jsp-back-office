<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="mbrPollColumnTemplate">
   <img style="max-width: 60px;" src="{{:itemImg}}"/>
</script>

<div> 
    <div id="mbrPollPrtcpSttsGrid" class="white_bg grid_bd0"></div>
</div>

<script type="text/javascript">

var mbrPollPrtcpStts;


var mbrPollPrtcpSttsObj = {
	initMbrPollPrtcpStts : function(data) {
		var ejGridOption = {
	       	serializeGridData : function(data) {
	       	 	data.rid = gMbrDetail.data.rid;
	         	return data;
	       	},
	       	dataUrl : '<ifvm:action name="getmbrPollPrtcpStts"/>',
	        columns:[
	        	  {
	         		  field : 'pollNm', headerText : '<spring:message code="L02667"/>', headerTextAlign : 'center', textAlign : 'center',
	         		  customAttributes : {
	         			  index : 'lp.poll_nm' }/* glo Choice명 */
	         	  },{
	         		  field : 'pollTypeCd', headerText : '<spring:message code="L02460"/>', headerTextAlign : 'center', textAlign : 'center', width:'50px',
	         		  customAttributes : {
	         			  index : 'lp.POLL_TYPE_CD'}/* 유형 */
	         	  },{
	         		  field : 'itemNo', headerText : '<spring:message code="L02600"/>', headerTextAlign : 'center', textAlign : 'right', width:'60px',
	         		  customAttributes : {
	         			  index : 'lpi.item_no'}/* 항목 */
	         	  },{
	         		  field : 'itemNm', headerText : '<spring:message code="L02601"/>', headerTextAlign : 'center', textAlign : 'left',
	         		  customAttributes : {
	         			  index : 'lpi.item_nm' }/* 항목명 */
	         	  },{
	         		  field : 'itemImg', headerText : '<spring:message code="L02602"/>', headerTextAlign : 'center', textAlign : 'center', template: "#mbrPollColumnTemplate", width:'80px',
	         		  customAttributes : {
	         			  index : 'lpi.item_img' }/* 이미지 */
	         	  },{
	         		  field : 'regDt', headerText : '<spring:message code="L02603"/>', headerTextAlign : 'center', textAlign : 'center', width:'120px',
	         		  customAttributes : {
	         			  index : 'lpa.reg_dt' }/* 참여일시 */
	         	  },{
	         		  field : 'apprDt', headerText : '<spring:message code="L02663"/>', headerTextAlign : 'center', textAlign : 'center', width:'120px',
	         		  customAttributes : {
	         			  index : 'lpt.APPR_DT' }/* 혜택지급일시 */
	         	  },{
	         		  field : 'pntAmt', headerText : '<spring:message code="L02666"/>', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'100px',
	         		  customAttributes : {
	         			  index : 'lpt.PNT_AMT' }/* 혜택포인트 */
	         	  },
	         ],
	         requestGridData : {
	        	 nd   : new Date().getTime(),
	        	 rows : 10,    		   //한 페이지에 몇개의 로우를 보여줄지
	        	 sidx : 'regDt',  //xml에서 strorderby 에 들어갈 값
	        	 sord : 'desc',        // storderby옆에 들어갈 정렬값
	        	 _search : true
			},
			radio : false,
			tempId : 'ifvGridSimplePageTemplete2'

	    }
		mbrPollPrtcpStts = $("#mbrPollPrtcpSttsGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	},
}

$(document).ready(function(){
	mbrPollPrtcpSttsObj.initMbrPollPrtcpStts();
	/* window.top.setParentIframeHeight(); */
});

</script>