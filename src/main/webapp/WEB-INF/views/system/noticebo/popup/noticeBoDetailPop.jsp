<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div>
	<div id="noticeBoDetailValid">
		<div class="form-horizontal top_well">
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="noticeNm" dto="noticeNm" label="제목" labelClass="1" conClass="10"  required="true"/>
			</div>
            <div class="row qt_border">
            	<ifvm:inputNew type="textarea" id="noticeContent" names="noticeContent" dto="noticeContent" label="내용" labelClass="1" conClass="10" rows="30" maxLength="4000"  />
            </div>
		</div>
	</div>
	
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="btnSave" objCode="noticeBoDetailSave_OBJ">
			<spring:message code="저장" />
		</button>
		<button class="btn btn-sm" id="btnCancle" objCode="noticeBoDetailCancle_OBJ">
			<spring:message code="M00441" />
		</button>
	</div>
</div>

<script type="text/javascript">

var noticeBoDetail = function(rid){
	
	var _rid = rid;
	var _formId = "noticeBoDetailValid";
	var _loadedData = {};
	
	this.setRid = function(rid){
		_rid = rid;
	},
	this.getRid =function(){
		return _rid;
	},
	this.isNew = !$.fn.ifvmIsNotEmpty(this.getRid()) || this.getRid() === 'null',
	this.validation = $("#" + _formId).ifvValidation(),
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
		
		if (!this.isNew) this.formDataLoad();
		
		this.action();
		
	},
	this.save = function(){
		
		var _url = this.isNew ? '<ifvm:action name="saveNoticeBo"/>' : '<ifvm:action name="modifyNoticeBo"/>';
		
		var _data = function () {

			var vObj = $.ifvGetFieldData(this.fields, this.optionFields);

			_updatedData = $.extend(true, {}, vObj);

			if (!this.isNew) {
			    vObj['rid'] = this.getRid();
			}
			
			return vObj;
		}
		
		if(this.validation.confirm()) $.ifvSyncPostJSON( _url, _data.call(this) , this.afterSave.bind(this), this.afterSave.bind(this))
	},
	this.afterSave = function(result){
		
		if(result.success){
			if(result.message) alert(result.message);
			else alert('<spring:message code="C00094"/>');
			$.fn.ifvmPopupClose();
			var noticeBo = new noticeBoList();
			noticeBo.setGridAndDataLoad();
			//qtjs.href('<ifvm:url name="noticeBoList"/>');
		}else{
			if(result.message) alert(result.message);
			else alert('<spring:message code="M02248"/>');
		}
		
	},
	this.action = function(){
		
		$("#btnSave").click(function(){
			this.save()
		}.bind(this));
		
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