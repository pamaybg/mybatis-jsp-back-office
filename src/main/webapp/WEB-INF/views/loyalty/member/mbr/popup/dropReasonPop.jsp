<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

$(document).ready(function() {

});

function searchInitialize(){
	$(".SearchCondition .searchCondition").val("EQUAL(=)")
}

function defaultSearch() {

}

//탈회
function dropMbrFn() {
	var data = $('#dropReasonForm').getSubmitData();
		console.log(data);
		mbr_rid;
	 $.ifvSyncPostJSON( '<ifvm:action name="dropReason"/>',
	     {
			ridMbr : mbr_rid,
			dropReason : data.reasonData
	     },
         function(result) {
	    	 alert('<spring:message code="M00005"/>');

	    	 $.ifvSyncPostJSON('<ifvm:action name="daisoDropMember"/>', {
				  ridMbr : mbr_rid
			}, function(result) {
				if (result.success) {

				  	//탈회 되었습니다. 회원가입 다시 해야되죠
					alert('<spring:message code="L00501"/>');
					gMbrDetail.loadData();
				}
			}, function(result) {

			   	//탈회에 실패하였습니다.
				alert('<spring:message code="L02347"/>');
			});

	    	 dropReasonPop.close();
//              if(result.success == true){
//                alert('<spring:message code="M00005"/>');
//                location.href = '<ifvm:url name=""/>';
//                }
//             else{
//                alert('<spring:message code="M00029"/>');
//                }
         }
      );

}

//닫기
function cancelMbrSearchHelpFn() {
	dropReasonPop.close();
}

</script>

<div id="pop_main_div_mbr">
	<div>
	    <div class="page_btn_area">
	        <div class="col-xs-7">
	            <span><spring:message code="D10224" /></span>
	        </div>
	    </div>
	    <div class="row">
			<div class="row qt_border" id = "dropReasonForm">
   				<ifvm:inputNew type="textarea" id="reasonData" names="reasonData" dto="reasonData" label="D10223" labelClass="2" conClass="6" rows="3"/>
		    </div>
        </div>
	</div>

	<div class="pop_btn_area">
		<ifvm:inputNew type="button" btnType="save"  text="L00459"  id="dropMbrBtn" btnFunc="dropMbrFn"/>
	</div>
</div>