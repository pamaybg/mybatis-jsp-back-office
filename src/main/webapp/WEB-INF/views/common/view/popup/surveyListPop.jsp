<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="surveyListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnCommSurveyPopSelect" objCode="">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnCommSurveyPopCancel" objCode="">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var surveyListGrid = null;
var surveyNm;
var surveyNo;
var surveyId;

function surveyListSetting(){
	var ejGridOption = {
		rowSelected : function (args) {
			var data = args.data;
			surveyId = data.rid;
			surveyNm = data.survNm;
			surveyNo = data.survNo;
        },
		serializeGridData : function( data ){
			return data;
		},
        dataUrl : '<ifvm:action name="getSurveyList"/>',
        columns : [
        	{
      		  field : 'pgmNm', headerText : '<spring:message code="C00168"/>', headerTextAlign : 'center', textAlign : 'left', customAttributes : {searchable : true}
      	  },{
    		  field : 'survNo', headerText : '설문번호', headerTextAlign : 'center',textAlign : 'center', width : '190px', customAttributes : {searchable : true}
    	  },{
    		  field : 'survNm', headerText : '<spring:message code="S00074"/>', headerTextAlign : 'center',textAlign : 'left', width : '190px', customAttributes : {searchable : true}
    	  },{
    		  field : 'vaildDate', headerText : '<spring:message code="S00075"/>', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'statCdNm', headerText : '<spring:message code="L00165"/>', headerTextAlign : 'center', textAlign : 'center', customAttributes : {index : 'statCdNm'}
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'survNo',
      	  sord : 'ASC',
        },
        radio: true
      };
	surveyListGrid = $("#surveyListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function(){
	surveyListSetting();
	
	$("#btnCommSurveyPopSelect").click(function(){
		if(surveyListGrid.opt.gridControl.getSelectedRecords().length == 0){
    		alert('<spring:message code="M00285"/>');
    	} else {
    		$('#surveyNo').val(surveyNo);
    		$('#surveyNm').val(surveyNm);
    		surveyRid = surveyId;
    		$.fn.ifvmPopupClose();
    	}
	});
	
	$("#btnCommSurveyPopCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
});
</script>