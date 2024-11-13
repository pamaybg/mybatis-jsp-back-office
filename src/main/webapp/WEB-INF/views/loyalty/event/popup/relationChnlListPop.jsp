<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="pop_main_div">
	<div class="pop_inner_wrap">
		<div id="relationChnlGrid" class="white_bg grid_bd0"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="selectBtn">
	        <i class="glyphicon glyphicon-check"></i><spring:message code="L00123"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="cancelBtn"><spring:message code="L00124"/>   
	    </button> 
	</div>
</div>
<script>
var getRelationChnlGrid;

function relationChnlGrid(){
	var ejGridOption = {
			serializeGridData : function( data ){
	      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
	      			data.item = requestitem;
	            }     
	            return data;
			},
		    dataUrl:'<ifvm:action name="getRelationChnlList"/>',
		    columns:[
		    	  {
		      		  field : 'chnlNo', headerText : '채널 번호', headerTextAlign : 'center', textAlign : 'center', width:'70px',
		      		  customAttributes : {
		      			  index : 'lc.CHNL_NO' }  /* 채널 번호 */
		      	  },{
		      		  field : 'chnlSubType', headerText : '스토어 유형', headerTextAlign : 'center', textAlign : 'center',  width:'70px',
		      		  customAttributes : {
		      			  index : 'cc1.MARK_NAME' }/* 스토어 유형 */
		      	  },{
		      		  field : 'storeCd', headerText : '스토어코드', headerTextAlign : 'center', textAlign : 'center',  width:'70px',
		      		  customAttributes : {
		      			  index : 'lc.STORE_CD' }/* 스토어코드  */
		      	  },{
		      		  field : 'chnlRealNm', headerText : '채널명', headerTextAlign : 'center', textAlign : 'left', width:'200px',
		      		  customAttributes : {
		      			  index : 'lc.CHNL_REAL_NM' }	  /* 채널명 */
		      	  },{
		      		  field : 'jibunAddr', headerText : '스토어위치', headerTextAlign : 'center', textAlign : 'left', width:'150px',
		      		  customAttributes : {
		      			  index : 'lc.JIBUN_ADDR' }	  /* 스토어위치 */
		      	  },{
		      		  field : 'openCloseTime', headerText : '영업시간', headerTextAlign : 'center', textAlign : 'center',  width:'70px',
		      		  customAttributes : {
		      			  index : 'openCloseTime' }/* 영업시간 */
		      	  },{
		      		  field : 'chnlTypeSubCd', headerText : '유형코드', headerTextAlign : 'center', textAlign : 'center', visible : false,
		      		  customAttributes : {
		      			  index : 'lc.CHNL_TYPE_SUB_CD' }/* 유형코드*/
		      	  },{
		      		  field : 'chnlOpenTime', headerText : '', headerTextAlign : 'center', textAlign : 'center', visible : false,
		      		  customAttributes : {
		      			  index : 'lc.CHNL_OPEN_TIME' }/* 오픈시간 */
		      	  },{
		      		  field : 'chnlCloseTime', headerText : '', headerTextAlign : 'center', textAlign : 'center', visible : false,
		      		  customAttributes : {
		      			  index : 'lc.CHNL_CLOSE_TIME' }/* 종료시간*/
		      	  },{
		      		  field : 'chnlRid', headerText : 'rid', visible : false,
		      		  customAttributes : {
		      			  index : 'lc.rid' }  /* rid */
		      	  }
		    ],
	        requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : 'lc.CHNL_NO',
		      	  sord : 'desc',
		      	  _search : false
		    },
		   	 rowList : [10,25,50,100],
	     	 autowidth : false, 
	     	 radio : true
	     };
		
	getRelationChnlGrid = $("#relationChnlGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function(){
	relationChnlGrid();
	
	//선택 클릭시
    $('#selectBtn').on('click', function(){
    	if(getRelationChnlGrid.opt.gridControl.getSelectedRecords()[0] == null){
    		alert('<spring:message code="L00117"/>');
    	}else {
    		chnlRealNm = getRelationChnlGrid.opt.gridControl.getSelectedRecords()[0].chnlRealNm;
    		storeCd = getRelationChnlGrid.opt.gridControl.getSelectedRecords()[0].storeCd;
    		chnlTypeSubCd = getRelationChnlGrid.opt.gridControl.getSelectedRecords()[0].chnlTypeSubCd;
    		chnlRid = getRelationChnlGrid.opt.gridControl.getSelectedRecords()[0].chnlRid;
    		jibunAddr = getRelationChnlGrid.opt.gridControl.getSelectedRecords()[0].jibunAddr;
    		chnlOpenTime = getRelationChnlGrid.opt.gridControl.getSelectedRecords()[0].chnlOpenTime;
    		chnlCloseTime = getRelationChnlGrid.opt.gridControl.getSelectedRecords()[0].chnlCloseTime;
    		
    		$("#jibunAddr").val(jibunAddr);
    		$("#chnlOpenTime").val(chnlOpenTime);
    		$("#chnlCloseTime").val(chnlCloseTime);
    		$("#relationChnlNm").val(chnlRealNm);
    		$("#storeCode").val(storeCd);
    		$("#storeType").val(chnlTypeSubCd);
    		
    		storeTypeCheck();
    		
    		relationChnlPopClose();
    	}
    });
	
  	//취소 클릭시
    $("#cancelBtn").on("click", function(){
    	relationChnlPopClose();
    });
});

</script>