<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script>
var ridMbr = '<%= cleanXss(request.getParameter("ridMbr")) %>';
var scrTypeCd = '<%= cleanXss(request.getParameter("scrTypeCd")) %>';
var scoringResultDetailGrid;
var gridIdscoringResultDetailGrid;

/**
 * 이벤트트리거 scorign 결과 상세 조회
 */
function getScoringResultDetailList() {
    
    var ejGridOption = {
        rowSelected : function (args) {

        },
        recordDoubleClick : function (args) {
        	
        },
        serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            
            data.ridMbr = ridMbr;
            data.scrTypeCd = scrTypeCd;
            
            return data;
        },
        dataUrl : '<ifvm:action name="getScoringResultDetailList"/>',
        columns:[ 
        		{
	      		  field : 'seq', headerText : 'No', headerTextAlign : 'center', width : '40px' ,
	      		  customAttributes : {
	      			  searchable : false,
	      			  index : 'seq' }/* No */
	      	  },{
	      		  field : 'dispNo', headerText : '<spring:message code="L02201"/>', headerTextAlign : 'center',width : '80px' ,
	      		  customAttributes : {
	      			  index : 'dispNo' }/* 관리번호 */
	      	  },{
	      		  field : 'scrNm', headerText : '<spring:message code="L02202"/>', headerTextAlign : 'center',width : '80px' ,
	      		  customAttributes : {
	      			  index : 'scrNm' }/* 지수명 */
	      	  },{
	      		  field : 'title', headerText : '<spring:message code="L02232"/>', headerTextAlign : 'center',width : '80px' ,
	      		  customAttributes : {
	      			  index : 'title' }/* 조건명 */
	      	  },{
	      		  field : 'scrPnt', headerText : '<spring:message code="L02227"/>', headerTextAlign : 'center',width : '50px' ,
	      		  customAttributes : {
	      			  index : 'scrPnt' }/* 점수 */
	      	  },{
	      		  field : 'scrCreateDate', headerText : '<spring:message code="L02233"/>', headerTextAlign : 'center',width : '80px' ,
	      		  customAttributes : {
	      			  index : 'scrCreateDate' }/* 산출일 */
	      	  },{
	      		  field : 'scrCancelDate', headerText : '<spring:message code="L02234"/>', headerTextAlign : 'center',width : '80px' ,
	      		  customAttributes : {
	      			  index : 'scrCancelDate' }/* 취소일 */
	      	  },{
	      		  field : 'ridScrDtl', headerText : 'id', visible : false ,
	      		  customAttributes : {
	      			searchable : false,
	      			  index : 'ridScrDtl' }/* */
	      	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'seq',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: false
        //tempId : 'ifvGridOriginTemplete'
    };
    scoringResultDetailGrid = $("#scoringResultDetailGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    gridIdscoringResultDetailGrid = $("#gridIdscoringResultDetailGrid");
}

/**
 * popup 높이 맞추기
 */
function setPopupHeight() {
	new ifvm.PopupHeight({
	    popupDivId : 'scoringResultDetailPop',
	    contentsId : 'dialogPopupWrap'
	});

	cDialog.refresh();
}

$(function () {

	getScoringResultDetailList();

// 	setPopupHeight();
});
</script>

<div id="dialogPopupWrap">
    <div class="pop_inner_wrap">
        <div class="form-horizontal" id="scoringResultDetailPop">
			<div id="scoringResultDetailGrid" class="con_size" style="width:770px;"></div>
		</div>
	</div>
</div>

