<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="form-horizontal top_well" id="prodRevwDetailForm">
		<br>
		<div class="row qt_border">
			<div class="col-xs-12">
				<ifvm:inputNew type="text" id="subject" names="subject" dto="subject" label="제목" labelClass="1" conClass="11" disabled="true" />
			</div>
		</div>
		<div class="row qt_border">
			<div class="col-xs-12">
				<ifvm:inputNew type="textarea" id="content" names="content" dto="content" label="내용" labelClass="1" conClass="11" rows="8" disabled="true"/>
			</div>
		</div>
</div>
<div class="pop_btn_area">
	<%-- <button class="btn btn-sm btn_gray"  id="btnCommClubPopSelect" objCode="btnCommClubPopSelect_OBJ">
		<spring:message code="L00072" />
	</button>  --%>
	<button class="btn btn-sm btn_gray" id="btnPopCancel" objCode="">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var prodRevwDetialPop;

var prodRevwDetialPop = function(mbrRid){
	this.init = function(){
		this.action();
		this.getAlertDetail();
	},
	this.getAlertDetail = function(){
		$.ifvSyncPostJSON('<ifvm:action name="getProdRevwDetail"/>',{rid : rid}, function(result){
			$("#prodRevwDetailForm").dataSetting(result);
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
	prodRevwDetialPop = new prodRevwDetialPop();
	prodRevwDetialPop.init();
	
});
</script>