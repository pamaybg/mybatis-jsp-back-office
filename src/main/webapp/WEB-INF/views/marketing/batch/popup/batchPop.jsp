<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var batchPopObject = function() {
	this.setPopData = function(data) {
		if ($.fn.ifvmIsNotEmpty(data)) {
			$("#batchPop").dataSetting(data);
		}
	},
	this.setSelect = function() {
		var obj = [
			{value: "N", text: "N"}
			, {value: "Y", text: "Y"}
		];
		
		var tmpl = $("#optionTmpl").tmpl(obj);
		$("#useYn").append(tmpl);
	},
	this.setButtons = function () {
        // 저장
        $('#btnSaveBatchPop').on('click', function () {
            this.saveAction();
        }.bind(this));
        
        // 닫기
        $('#btnCancelBatchPop').on('click', function () {
            this.cancelAction();
        }.bind(this));
	},
	this.saveAction = function() {
		var validation = $("#batchPop").ifvValidation();
		
        if (validation.confirm()) {
            $.ifvProgressControl(true);
            
            var data = $("#batchPop").getSubmitData();
            
            $.ifvPostJSON('/marketing/batch/saveMktBatchJob.do', data, 
            function(result) {
            	alert("저장 하였습니다.");
            	batchObj.searchAction();
            	$.ifvProgressControl(false);
            	$.fn.ifvmPopupClose();
            },
            function(result) {
            	alert(result.message);
            	batchObj.searchAction();
            	$.ifvProgressControl(false);
            });
        }
	},
	this.cancelAction = function() {
		$.fn.ifvmPopupClose();
	},
	this.init = function(data) {
		this.setSelect();
		
		this.setPopData(data);
		
		this.setButtons();
		
	}
}
var batchPopObj;
$(document).ready(function(){
	batchPopObj = new batchPopObject();
});
</script>

<script id="optionTmpl" type="text/x-jquery-tmpl">
	<option value="${'${'}value}">${'${'}text}</option>
</script>


<div id='batchPop'>
	<div class="pop_inner_wrap form-horizontal">
	<br>
		<ifvm:inputNew type="hidden" id="rid" dto="rid" />
	    <div class="row qt_border">
	        <ifvm:inputNew type="text" id="jobNm" dto="jobNm" label="Job" nuc="true" labelClass="3" conClass="9" required="true"/>
	    </div>
	    <div class="row qt_border">
	        <ifvm:inputNew type="text" id="jobDesc" dto="jobDesc" label="Job명" nuc="true" labelClass="3" conClass="9" required="true"/>
	    </div>
	    <div class="row qt_border">
	        <ifvm:inputNew type="select" id="useYn" dto="useYn" label="사용여부" nuc="true" labelClass="3" conClass="9" required="true"/>
	    </div>
	    <div class="row qt_border">
	        <ifvm:inputNew type="text" id="execCycle" dto="execCycle" label="Cron" nuc="true" labelClass="3" conClass="9" required="true"/>
	    </div>
	</div>
</div>
</br>
<div class="pop_btn_area">
	<ifvm:inputNew type="button" id="btnSaveBatchPop" text="C00164" objCode="btnSaveBatchPop_OBJ" />
	<ifvm:inputNew type="button" id="btnCancelBatchPop" text="M00284" objCode="btnCancelBatchPop_OBJ" />
</div>