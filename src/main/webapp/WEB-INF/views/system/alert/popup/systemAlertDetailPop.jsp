<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="form-horizontal top_well" id="alertDetailForm">
		<br>
		<div class="row qt_border">
			<div class="col-xs-12">
				<ifvm:inputNew type="text" id="title" names="title" dto="title" label="제목" labelClass="1" conClass="11" disabled="true" />
			</div>
		</div>
		<div class="row qt_border">
			<div class="col-xs-6">
				<ifvm:inputNew type="text" id="alertTypeCdNm" names="alertTypeCdNm" dto="alertTypeCdNm" label="알림유형" labelClass="2" conClass="10" disabled="true" />
			</div>
			<div class="col-xs-6">
				<ifvm:inputNew type="text" id="createDate" names="createDate" dto="createDate" label="발생일자" labelClass="2" conClass="10" disabled="true" />
			</div>
		</div>
<%--		<div class="row qt_border">--%>
<%--			<div class="col-xs-6">--%>
<%--				<ifvm:inputNew type="text" id="emailSndYn" names="emailSndYn" dto="emailSndYn" label="이메일발송" labelClass="2" conClass="10" disabled="true"/>	--%>
<%--			</div>--%>
<%--			<div class="col-xs-6">--%>
<%--				<ifvm:inputNew type="text" id="emailSndStatCdNm" names="emailSndStatCdNm" dto="emailSndStatCdNm" label="상태" labelClass="2" conClass="10" disabled="true"/>--%>
<%--			</div>--%>
<%--		</div>--%>
<%--		<div class="row qt_border">--%>
<%--			<div class="col-xs-6">--%>
<%--				<ifvm:inputNew type="text" id="smsSndYn" names="smsSndYn" dto="smsSndYn" label="SMS발송" labelClass="2" conClass="10" disabled="true"/>	--%>
<%--			</div>--%>
<%--			<div class="col-xs-6">--%>
<%--				<ifvm:inputNew type="text" id="smsSndStatCdNm" names="smsSndStatCdNm" dto="smsSndStatCdNm" label="상태" labelClass="2" conClass="10" disabled="true"/>--%>
<%--			</div>--%>
<%--		</div>--%>
		<div class="row qt_border">
			<div class="col-xs-12">
				<ifvm:inputNew type="textarea" id="contents" names="contents" dto="contents" label="내용" labelClass="1" conClass="11" rows="15" disabled="true"/>
			</div>
		</div>
</div>
<div class="pop_btn_area">
	<%-- <button class="btn btn-sm btn_gray"  id="btnCommClubPopSelect" objCode="btnCommClubPopSelect_OBJ">
		<spring:message code="L00072" />
	</button>  --%>
	<button class="btn btn-sm btn_gray" id="btnPopCancel" objCode="systemAlertDetailCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var alertDetialPop;

var systemAlertDetialPop = function(mbrRid){
	this.init = function(){
		this.action();
		this.getAlertDetail();
	},
	this.getAlertDetail = function(){
		$.ifvSyncPostJSON('<ifvm:action name="getSystemAlertDetail"/>',{rid : rid}, function(result){
			$("#alertDetailForm").dataSetting(result);
		}.bind(this));
	}
	this.close = function(){
		$.fn.ifvmPopupClose();
	},
	this.action = function() {
		$("#btnPopCancel").click(function(){
			//rid = null;
			this.close();
		}.bind(this));
	}
	
}


$(document).ready(function(){
	alertDetialPop = new systemAlertDetialPop();
	alertDetialPop.init();
	
});
</script>