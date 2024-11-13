<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="pop_inner_wrap" id="tmCamAssignWrap">
	<div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="V00274"/></span><!-- TM 대상 회원 -->
        </div>
    </div>
    <div class="form-horizontal underline top_well" id="tmCamTgtDetailWrap" >
		<div class="row">
			<ifvm:inputNew type="text" id="mbrNo"   	dto="mbrNo"    label="V00277" labelClass="2" conClass="2" disabled="true"/>
			<ifvm:inputNew type="text" id="custNm" 		dto="custNm"    label="V00278" labelClass="2" conClass="2" disabled="true"/>
			<ifvm:inputNew type="text" id="tierNm"  	dto="tierNm"    label="V00279" labelClass="2" conClass="2"	disabled="true" />
		</div>

		<div class="row">
			<ifvm:inputNew type="text" 		id="hhpNo"   		dto="hhpNo"    		label="V00280" labelClass="2" conClass="2" disabled="true"/>
			<ifvm:inputNew type="select" 	id="tmStatus" 		dto="tmStatus"    	label="V00281" labelClass="2" conClass="2" />
			<ifvm:inputNew type="text" 		id="callStatus"  	dto="callStatus"    label="V00282" labelClass="2" conClass="2" />
		</div>
		<div class="row">
			<ifvm:inputNew type="textarea" 	id="callDesc"  	dto="callDesc"    label="V00283" labelClass="2" conClass="10" />
		</div>

	</div>
</div>
<div class="pop_btn_area">
   <ifvm:inputNew type="button" btnType="save"	text="L01462" id="saveBtn"	btnFunc="gTmCamTgtDetailPop.save" className="btn_lightGray2"/>
   <ifvm:inputNew type="button" btnType="close"	text="L00913" btnFunc="tmCamTgtDetailPopup.close" className="btn_lightGray2"/>
</div>
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
var rid = '<%= cleanXss(request.getParameter("rid")) %>';
gTmCamTgtDetailPop = {
		init : function(){
			$.ifvGetCommCodeList('select', 'tmCamTgtDetailWrap tmStatus', '<ifvm:action name="getCommCodeList2"/>', 'YES_NO_FLAG', 'loy', false, false, true);
			this.loadData();
		},
		loadData : function(){
			var action = '<ifvm:action name="getTmCamTgtDetail"/>';
			$.ifvSyncPostJSON(action, {
				rid: rid
			}, function(result) {
				$("#tmCamTgtDetailWrap").dataSetting(result);

			},function(result){

			});
		},
		save : function(){

		},
}
$(document).ready(function() {
	gTmCamTgtDetailPop.init();
});
</script>