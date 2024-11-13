<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div>
	<div id="noticeBoDetailValid">
		<div class="form-horizontal top_well">
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="noticeNm" dto="noticeNm" label="제목" labelClass="1" conClass="10"  readonly="true"/>
			</div>
            <div class="row qt_border">
            	<ifvm:inputNew type="textarea" id="noticeContent" names="noticeContent" dto="noticeContent" label="내용" labelClass="1" conClass="10" rows="30"  readonly="true"/>
            </div>
            <div class="row qt_border">
            	<ifvm:inputNew type="text" id="modifyBy" dto="modifyBy" label="작성자" labelClass="1" conClass="4"  className="text-right"  disabled="true"/>
            	<ifvm:inputNew type="text" id="modifyDate" dto="modifyDate" label="작성일자" labelClass="2" conClass="4"  className="text-right"  disabled="true"/>
            </div>
		</div>
	</div>
	
	<div class="pop_btn_area">
		<button class="btn btn-sm" id="btnCancle" objCode="btnCancle_OBJ">
			<spring:message code="M00441" />
		</button>
	</div>
</div>

<script type="text/javascript">

var noticeBoDetail = function(rid){
	
	var _rid = rid;
	var _loadedData = {};
	var _formId = "noticeBoDetailValid";
	
	this.setRid = function(rid){
		_rid = rid;
	},
	this.getRid =function(){
		return _rid;
	},
    this.fields = $.ifvGetFields(_formId),
	this.optionFields = [
		/* { fieldName: "", commCode: "" } */
	],
	this.formDataLoad = function () {
		
		var _callback = function (result) {
			if ($.fn.ifvmIsNotEmpty(result)) {
				_loadedData = $.extend(true, {}, result);
				$.ifvLoadFormData(result, this.fields, this.optionFields);
			}
		}
		
		$.ifvSyncPostJSON('<ifvm:action name="getNoticeBoDetail"/>', { rid: this.getRid() }, _callback.bind(this));
	},
	this.init = function(){
		
		this.formDataLoad();
		
		this.action();
		
	},
	this.action = function(){
		
		$("#btnCancle").click(function(){
			$.fn.ifvmPopupClose();
		});
		
	}
}

$(document).ready(function(){
    var rid = ifvGlobal["noticeRid"];
	
	var noticeBoDetailNew = new noticeBoDetail(rid);
	noticeBoDetailNew.init();
});

</script>