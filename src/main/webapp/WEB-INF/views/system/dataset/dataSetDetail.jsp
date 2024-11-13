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
<div class="page-title">
    <h1>
        <spring:message code="데이터셋"/>
         &gt; <spring:message code="상세"/>
    </h1>
</div>
<div>
	<div class="page_btn_area" id="headForm">
	    <div class="col-xs-7">
	        <span><spring:message code="데이터셋 상세"/></span>
	    </div>
	    <div class="col-xs-5 searchbtn_r">
	        <ifvm:inputNew type="button" id="goNewSave" btnFunc="newsave" text="신규 저장" objCode="dataSetDetailGoSave_OBJ"/>
	        <ifvm:inputNew type="button" id="goSave" btnFunc="getDataSetDetail.save" text="I00745" objCode="dataSetDetailGoSave_OBJ"/>
			<ifvm:inputNew type="button" id="goTermsList" btnFunc="gridopen" text="L00824" objCode="dataSetDetailGoSave_OBJ"/>
	    </div>
	</div>
	
	<div class="form-horizontal underline top_well" id="dataSetForm" >
		<div class="row  qt_border">
             <label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="데이터셋명"/></label>
			<div class="col-xs-3 control_content">
			         <ifvm:inputNew type="text" id="dsNm"  dto="dsNm" conClass="8" required="true" />
			         <button class="btn btn-sm" id="dsNmPopBtn" objCode="dataSetdsNmPopBtn_OBJ" ><i class="fa fa-search"></i>
			         </button>
			</div>
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="오브젝트명"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="text" id="objNm" dto="objNm" required="true" conClass="9"/>
			    <ifvm:inputNew type="button" id="btnShowSrcQuery" btnFunc="showSrcQuery" text="소스보기" conClass="3" objCode="dataSetDetaildsNmPopBtn_OBJ"/>
			</div>
			
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="카테고리"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="select" id="cateCd" dto="cateCd" names="cateCd"/>
			</div>
		</div>
		
		</div>
</div>
<div id="dataSetDetailTabArea"></div>
<div id=popupContainer class="popup_container"></div>
<div id=srcQueryPopupContainer class="popup_container"></div>

<script>
var resultRid = '<%= cleanXss(request.getParameter("resultRid")) %>';

// 오브젝트의 소스쿼리를 팝업으로 띄워 확인하는 함수
function showSrcQuery(){
	//오브젝트명 필드의 테이블명값을 가져온다(스키마는 제거하고 순수테이블명만)
	var tblNm = $('#objNm').val().substring( ($('#objNm').val().lastIndexOf('.')) + 1 );
	
	$('#srcQueryPopupContainer').ifvsfPopup({
		enableModal: true,
		enableResize: false,
		contentType: 'ajax',
		contentUrl: '<ifvm:url name="srcQueryPop"/>' + '?tblNm='+tblNm,
		title: '소스보기',
		width: '800px',
		close: 'closeSrcQueryPop'
	});	
}//end showSrcQuery


function gridopen(){
    qtjs.href('<ifvm:url name="dataSetMasterList"/>');                      
}
function dsNmPop(){
    $.fn.ifvmPopupOpen('popupContainer', null,
            '<ifvm:url name="datasetNameSetPop"/>',
            '데이터셋 조회', 860, true, true);
}
function newsave(){
    qtjs.href('<ifvm:url name="dataSetDetail"/>' + '?rid=undefined')
}


var dataSetDetailTabArea = $('#dataSetDetailTabArea').DrawTab({
	item: [
		{label: '<spring:message code="아이템"/> ', href: '<ifvm:url name="dataSetItemList"/>'}

	]
});
var dataSet_rid = '<%= cleanXss(request.getParameter("rid")) %>';
if(dataSet_rid == 'undefined' || dataSet_rid == 'null') {
	dataSet_rid = null;
}
var dataSet_isNew = true;  //신규 여부. 신규: true, 수정 : false

var getDataSetDetail={
		init : function(){
			$.fn.ifvmSetSelectOptionCommCode("cateCd", "LOY_DS_CATE_CD", null, null, true);
	    	if (dataSet_rid === null){
	    		dataSet_isNew = true;
	    		dataSetDetailTabArea.disabledTab([0]);
	    	}
			else
				dataSet_isNew = false;
			if (!dataSet_isNew) {
				$.ifvSyncPostJSON('<ifvm:action name="getDataSetDetail"/>', {
					rid : dataSet_rid
				}, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						$("#dataSetForm").dataSetting(result);
					}
				}, function(result) {
					alert(result.message);
				});
			}
		},//INIT END
		save : function(){
			var validation = $("#dataSetForm").ifvValidation();
			
			//유효성 체크
			if(validation.confirm()){
				var url = dataSet_isNew? '<ifvm:action name="saveDataSet"/>' : '<ifvm:action name="modifyDataSet"/>';
				var varData = null;
				varData = $("#dataSetForm").getSubmitData();
				varData.rid = dataSet_rid;
				
				$.ifvSyncPostJSON(url, varData, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						alert("<spring:message code="C00094" />");
                            if(dataSet_isNew == true){
                                resultRid = result.message
                                qtjs.href('<ifvm:url name="dataSetDetail"/>' + '?rid=' + resultRid  );
                            } else {
                                qtjs.href('<ifvm:url name="dataSetDetail"/>' + '?rid=' + dataSet_rid  );
                            }
					}
				}, function(result) {
					alert("<spring:message code="M02248" />");
				});
			 }
		}
	}

$(document).ready(function() {
	getDataSetDetail.init();
	   $("#dsNmPopBtn").click(function() {
	       dsNmPop()
	    });
});

</script>

