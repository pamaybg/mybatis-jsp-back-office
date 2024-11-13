<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>
<style>
   textarea {font-size:13px;}
</style>


<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span>조회결과</span>
		</div>
		<div class="col-xs-5 searchbtn_r">
		</div>
	</div>
	<div class="row">
		<ifvm:inputNew type="textarea" id="attr1" dto="attr1" label="D10213" labelClass="1" conClass="7" rows="15" />
	</div>
	<div class="row">
		<ifvm:inputNew type="textarea" id="attr2" dto="attr2" label="D10214" labelClass="1" conClass="7" rows="15" />
	</div>
</div>
<script>
setReqResVal(trNum);
function setDataVal(){

	if(reqData!=null){
		$("#attr1").val(reqData);
		$("#attr2").val(resData);
	}else{
		$("#attr1").val('');
		$("#attr2").val('');
	}
}
function setReqResVal(trNum){
	$.ifvPostJSON('/system/batchRgst/setReqResData.do',{trNo :trNum} ,
		function(result) {
			if(result!=null){
				$("#attr1").val(result.reqMsg);
				$("#attr2").val(result.resMsg);
			}else{
				$("#attr1").val('');
				$("#attr2").val('');
			}
		});
}


</script>