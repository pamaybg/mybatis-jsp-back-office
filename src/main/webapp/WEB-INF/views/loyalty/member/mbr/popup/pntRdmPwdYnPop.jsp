<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="form-horizontal underline top_well clearfix" id="pntPwdDiv">
<br>
	<div class="row">
		<div class="control_content col-xs-12"> 
				<label class="control-label col-xs-2"><span class="asterisk">*</span>채널</label>				
					<ifvm:inputNew type="radio" id="chnlType" names="chnlType" dto="chnlType" conClass="8" text="문자(SMS)" values="LMS" checkIndex="1"/>
				</div>
	   </div>
	<div class="row">
			<ifvm:inputNew type="text" id="chngeResn"   dto="chngeResn" 
				label="사유" labelClass="2" conClass="8" maxLength="100"  required="true"/><!-- 사유-->
		</div>
</div>
<div class="pop_btn_area">

    <ifvm:inputNew type="button" text="L00817" btnFunc="saveFn" className="btn btn-sm btn_gray" objCode="pntRdmPwdYnPopSave_OBJ"/>
    <ifvm:inputNew type="button" text="L00073" btnFunc="closeFn" className="btn btn-sm btn_gray" objCode="pntRdmPwdYnPopClose_OBJ"/>
</div>

<script type="text/javascript">
var afterPntRdmYnVal =null;
var beforePntRdmYnVal =null;

$(document).ready(function() {
	

});	

function saveFn(){
	validation = $("#pntPwdDiv").ifvValidation();
	var data = $('#pntPwdDiv').getSubmitData();
	
	if(data.chnlType=="EMAIL"){
		if($("#email").val()==""){
			alert("email정보가 존재하지 않습니다.");
			return;
		}
	}
	if(data.chnlType=="LMS" || data.chnlType=="KAKAO_ALT"){
		if($("#hhp").val()==""){
			alert("휴대전화 정보가 존재하지 않습니다.");
			return;
		}
	}

	if(validation.confirm()){
			$.ifvSyncPostJSON('<ifvm:action name="editMbrPntUsePwLL"/>', {
				  ridMbr : mbr_rid
					 ,ridCust : custRid
					 ,altChnlTypeCd :data.chnlType
					, ridPgm : pgmRid
					, mbrNo : $('#mbrNo').val()
					, pntResn : data.chngeResn
					, custNm  : $("#cust_nm").val()
			}, function(result) {
				alert(result.message);
				pwdChangePopClose();
			}, function(result) {
				alert(result.message);
			});
		
	}	
}
function closeFn(){
	pwdChangePopClose();
}
</script>