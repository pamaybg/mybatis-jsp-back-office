<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="com.icignal.common.util.CommonUtil" %>
<div class="page-title">
	<h1>
		<spring:message code="L02907" />
		&gt; <spring:message code="I00195" />
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L02908" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="check" text="L00125" id="btnSave" objCode="systemMgtDetailSave_OBJ"/>
			<ifvm:inputNew type="button" text="M00002" id="btnList" objCode="systemMgtDetailList_OBJ"/>
		</div>
	</div>

	<div id="systemMgtDetailValid">
		<div class="form-horizontal top_well">
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="systemNm" dto="systemNm" label="시스템명" labelClass="1" conClass="4"  required="true"/>
				<ifvm:inputNew type="select" id="systemTypeCd" names="systemTypeCd" dto="systemTypeCd" label="시스템 유형" labelClass="2" conClass="4" />
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="hostNm" dto="hostNm" label="호스트 명" labelClass="1" conClass="4" />
				<ifvm:inputNew type="text" id="port" dto="port" label="포트" labelClass="2" conClass="4" maxLength="6" />
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="select" id="purposeCd" names="purposeCd" dto="purposeCd" label="용도" labelClass="1" conClass="4" />
				<ifvm:inputNew type="select" id="statCd" names="statCd" dto="statCd" label="상태" labelClass="2" conClass="4" />
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="apiSiteId" dto="apiSiteId" label="API SITE ID" labelClass="1" conClass="4"/>
				<ifvm:inputNew type="text" id="apiSecreetKey" dto="apiSecreetKey" label="SecreetKey" labelClass="2" conClass="4" disabled="true"/>
				<ifvm:inputNew type="button" id="secreetKeyBtn" nuc="true" text="키 생성" conClass="1" objCode="systemMgtDetailKeyAdd_OBJ"/>
				
			</div>
            <div class="row qt_border">
				<ifvm:inputNew type="text" id="company" dto="company" label="회사명" labelClass="1" conClass="4"  />
            </div>
            <div class="row qt_border">
            	<ifvm:inputNew type="textarea" id="systemDesc" names="systemDesc" dto="systemDesc" label="설명" labelClass="1" conClass="10" rows="2" />
            </div>
		</div>
	</div>
</div>

<script type="text/javascript">

var systemMgtDetail = function(rid){
	
	var _rid = rid;
	var _formId = "systemMgtDetailValid";
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
		{ fieldName: "systemTypeCd", commCode: "SYSTEM_TYPE_CD" },
		{ fieldName: "purposeCd", commCode: "SYSTEM_PURPOSE_TYPE_CD" , isFirstLowBlank: true },
		{ fieldName: "statCd", commCode: "COM_STAT_TYPE_2_CD"}
	],
	this.formDataLoad = function () {
		
		var _callback = function (result) {
			if ($.fn.ifvmIsNotEmpty(result)) {
				_loadedData = $.extend(true, {}, result);
				$.ifvLoadFormData(result, this.fields, this.optionFields);
			}
		}
		
		$.ifvSyncPostJSON('<ifvm:action name="getSystemMgtDetail"/>', { rid: this.getRid() }, _callback.bind(this));
	},
	this.init = function(){
		if (!this.isNew) {
			this.formDataLoad();
			if($("#apiStieId").val()==null) {
				$("#apiStieId").attr("disabled", true);
			}
			if($("#apiSecreetKey").val()==null) {
				$("#apiSecreetKey").attr("disabled", true);
			}
		}
		else  $.ifvSetSelectOptions(this.optionFields);
		
		this.action();
		
		numArr = ['port'];
		this.NumberOnly(numArr);
	},
	this.NumberOnly = function(item){
		for(var i = 0; i<item.length; i++) $("#"+item[i]).onlyNumber();
	}
	this.save = function(){
		
		var _url = this.isNew ? '<ifvm:action name="saveSystemMgtDetail"/>' : '<ifvm:action name="modifySystemMgtDetail"/>';
		
		var _data = function () {

			var vObj = $.ifvGetFieldData(this.fields, this.optionFields);

			_updatedData = $.extend(true, {}, vObj);

			if (!this.isNew) {
			    vObj['rid'] = this.getRid();
			}
			
			return vObj;
		}
		
		$.ifvSyncPostJSON( _url, _data.call(this) , this.afterSave.bind(this), this.afterSave.bind(this))
	},
	
	this.secreetKey = function(){
		if (!this.isNew && $("#apiSecreetKey").val()!=null) {
			alert("신규또는 빈값일때만 생성 가능합니다.");
			return;
		}
				
		var apiSecreetKey="<%= CommonUtil.newRid()%>";               
		$("#apiSecreetKey").val(apiSecreetKey); 
		
	},
	
	this.afterSave = function(result){
		
		if(result.success){
			if(result.message) alert(result.message);
			else alert('<spring:message code="C00094"/>');
			qtjs.href('<ifvm:url name="systemMgtList"/>');
		}else{
			if(result.message) alert(result.message);
			else alert('<spring:message code="M02248"/>');
		}
		
	},
	this.action = function(){
		
		$("#btnSave").click(function(){
			this.save()
		}.bind(this));
		
		$("#btnList").click(function(){
			qtjs.href('<ifvm:url name="systemMgtList"/>');
		});
		
		$("#secreetKeyBtn").click(function(){
			this.secreetKey()
		}.bind(this));
	
	}
}


$(document).ready(function(){
    var urlParams = $.ifvGetParams();
    var rid = urlParams.rid;

	ifvGlobal["sysMgtRid"] = rid;
	
	var systemMgtDetailNew = new systemMgtDetail(rid);
	systemMgtDetailNew.init();
	
});

</script>