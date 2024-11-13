<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
    </div>
    <div class="form-horizontal underline top_well" id="mbrSignInfoForm" >
    	<div class="row">
			<ifvm:inputNew type="text" id="empNo"   dto="empNo"    disabled="true"
				label="L01323" labelClass="2" conClass="2" /><!-- 사원번호-->
			<ifvm:inputNew type="text" id="sbscTmscnt"   dto="sbscTmscnt"    disabled="true"
				label="L01324" labelClass="2" conClass="2" /><!-- 가입횟수 -->
			<ifvm:inputNew type="text" id="firstSbscDt"   dto="firstSbscDt"    disabled="true"
				label="L01325" labelClass="2" conClass="2" /><!-- 최초가입일시 -->
    	</div>
    	<div class="row">
			<ifvm:inputNew type="text" id="firstCardRegDt"   dto="firstCardRegDt"    disabled="true"
				label="L01326" labelClass="2" conClass="2" /><!-- 첫카드 등록일시-->
			<ifvm:inputNew type="text" id="sbscPointPrvdYn"   dto="sbscPointPrvdYn"    disabled="true"
				label="L01327" labelClass="2" conClass="2" /><!-- 가입포인트지급여부 -->
			<ifvm:inputNew type="text" id="sbscPointPrvdDt"   dto="sbscPointPrvdDt"    disabled="true"
				label="L01328" labelClass="2" conClass="2" /><!-- 가입포인트지급일시 -->
    	</div>
    	<div class="row">
			<ifvm:inputNew type="text" id="dnatPointPrvdYn"   dto="dnatPointPrvdYn"    disabled="true"
				label="L01329" labelClass="2" conClass="2" /><!-- 기부포인트지급여부-->
			<ifvm:inputNew type="text" id="dnatPointPrvdDt"   dto="dnatPointPrvdDt"    disabled="true"
				label="L01330" labelClass="2" conClass="2" /><!-- 기부포인트지급일시 -->
			<ifvm:inputNew type="text" id="fraudCustRegDt"   dto="fraudCustRegDt"    disabled="true"
				label="L01331" labelClass="2" conClass="2" /><!-- 부정고객등록일시 -->
    	</div>
    </div>
</div>
<script>
gMbrSignInfo  = {
		dateTimeFieldId : ['firstSbscDt', 'firstCardRegDt', 'sbscPointPrvdDt', 'dnatPointPrvdDt', 'fraudCustRegDt'],
		setDateTimeField : function(){
			for(var pi = 0 ; pi < this.dateTimeFieldId.length ; pi++){
				var _pval = $("#"+this.dateTimeFieldId[pi]).val();
				var _aval="";
				if(_pval){
					_aval = _pval.split('.')[0];
				}
				$("#mbrSignInfoForm #"+this.dateTimeFieldId[pi]).val(_aval);
			}
		},
		init : function(){
			var action ='<ifvm:action name="getMbrSignInfo"/>';
			$.ifvSyncPostJSON(action, {
				rid: gMbrDetail.data.rid
			}, function(result) {

				if ($.fn.ifvmIsNotEmpty(result)) {
					$("#mbrSignInfoForm").dataSetting(result);
					gMbrSignInfo.setDateTimeField();

				}
			})
		}
}
gMbrSignInfo.init();
$(document).ready(function(){
	window.top.setParentIframeHeight();
});
</script>