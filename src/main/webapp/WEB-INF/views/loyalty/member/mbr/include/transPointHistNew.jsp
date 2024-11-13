<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
    </div>
    <div id="mbrChangeHistListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="emptyDialog" class="popup_container"></div>
<script type="text/javascript">
	transPointHistList = {
		ejGridOption : {
	       	serializeGridData : function(data) {
	       	 	data.ridMbr = gMbrDetail.data.rid;
	         	return data;
	       	},
	        dataUrl : '<ifvm:action name="transPointHist"/>',
	        columns:[
	        		{
	         		  field : 'regDt', headerText : '등록일시', headerTextAlign : 'center',textAlign : 'center',
	         		  customAttributes : {
	         			  index : 'lmpmh.REG_DT' }
	         	  },{
	         		  field : 'tgtMbr', headerText : '적립대상회원', headerTextAlign : 'center',textAlign : 'center',
	         		  customAttributes : {
	         			  index : '' }
	         	  },{
	         		  field : 'srcMbr', headerText : '이관대상회원', headerTextAlign : 'center',textAlign : 'center',
	         		  customAttributes : {
	         			  index : '' }
	         	  },{
	         		  field : 'srcMbrCd', headerText : '이관대상회원상태', headerTextAlign : 'center',textAlign : 'center',
	         		  customAttributes : {
	         			  index : '' }
	         	  },{
	         		  field : 'pnt', headerText : '이관 포인트', headerTextAlign : 'center',textAlign : 'right', format : '{0:n0}',
	         		  customAttributes : {
	         			  index : 'a.pnt' }
	         	  },{
	         		  field : 'regUser', headerText : '이관 처리자', headerTextAlign : 'center',textAlign : 'center',
	         		  customAttributes : {
	         			  index : '' }
	         	  },{
	         		  field : 'reason', headerText : '이관 사유', headerTextAlign : 'center', 
	         		  customAttributes : {
	         			  index : '' }
	         	  },{
	         		  field : 'RID', headerText : 'rid',visible : false,
	         		  customAttributes : {
	         			  index : '' }
	         	  },
	         ],
	         requestGridData : {
	        	 nd   : new Date().getTime(),
	        	 rows : 10 ,
// 	        	 sidx : 'a.REG_DT' ,
// 	        	 sord : 'desc' ,
	        	 _search : false
	         },
			rowList : [10, 25, 50, 100],
		    radio : true
	    }
	    // 마스킹 해제
}
//transPointHistList.checkButtnAuth();
mbrTransPointHistList = $("#mbrChangeHistListGrid").ifvsfGrid({ ejGridOption : transPointHistList.ejGridOption });
$(document).ready(function(){
	window.top.setParentIframeHeight();
});
</script>







