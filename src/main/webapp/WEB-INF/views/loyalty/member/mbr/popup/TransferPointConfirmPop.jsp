<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<div class="form-horizontal underline top_well clearfix" id="editMbrPntUsePwForm">
		<div class="page_btn_area">
			<div class="col-xs-7">
				<span class="asterisk">*</span><span>이관 사유</span>
			</div>
		</div>
		<div class="row">
<!-- 			<label class="control-label col-xs-4"> -->
			<div class="row qt_border">
     			 <ifvm:inputNew type="textarea" id="reasonData" names="reasonData" dto="reasonData"  conClass="12" rows="7"/>
  			</div>
		</div>
</div>
<div class="pop_btn_area">
	<ifvm:inputNew type="button" btnType="save"	text="이관후 탈회처리" nuc="true" id="dropMbrPoint" btnFunc="dropMbrPointClick" className="btn_lightGray2"/>
    <ifvm:inputNew type="button" btnType="save"	text="이관하기" 	nuc="true" id="transPoint" btnFunc="transPointClick" className="btn_lightGray2"/>
    <ifvm:inputNew type="button" btnType="close"	text="L00913" id="closeBtn" btnFunc="closeBtnClick" className="btn_lightGray2"/>
</div>


<script type="text/javascript">
var trans_rid = '<%=cleanXss(request.getParameter("rid"))%>';
var trans_cdflag = '<%=cleanXss(request.getParameter("cdFlag"))%>';
if(trans_cdflag == "A1") $('#transPoint').hide();

var sumPoint=Number(pntUse)+Number(pntPreUse);


// 팝업 닫기
function closeBtnClick() {
	popupClose();
}

function transPointClick() {
	var srgMbr = trans_rid;
	var tgtMbr = mbr_rid;
	var modifyby = ifvmUserInfo.id;
	var dropReason =$("#reasonData").val(); 
	if ($.fn.ifvmIsNotEmpty(dropReason)){
		if (!confirm(tgtCustNm + '님 포인트를 '+srcCustNm+'님에게 이관 하시겠습니까?')) {
			return;
		}
		$.ifvPostJSON('<ifvm:action name="transPointExec"/>', 
				{ 'pDropMbrYn':"N",
				  'pRidMbrRcv' :tgtMbr,
				  'pRidMbrGiv':srgMbr,
				  'pModifyBy':modifyby,
				  'pReason':dropReason
		}, function(result) {
	// 			$.ifvSyncPostJSON('<ifvm:action name="transPntReason"/>', 
	// 					{ 'reasonData':dropReason,
	// 					  'srgMbr' :srgMbr,
	// 					  'tgtMbr':tgtMbr,
	// 					  'pnt':sumPoint,
	// 			}, function(result) {
	// 					if ($.fn.ifvmIsNotEmpty(result)) {
	// 						alert('<spring:message code="V00219" />'); // 완료되었습니다.
	// 						location.reload();
	// 					}
	// 			}, function(result) {
	// 				alert(result.message);
	// 			});
			alert('<spring:message code="V00219" />'); // 완료되었습니다.
// 			location.reload();
			closeBtnClick();
			cancelmbrTransFerFn();
			gMbrDetail.loadData();
			mbrDetailTab.moveTabIndex(6);
		}, function(result) {
			alert(result.message);
		});
	}
	else{
		alert('이관사유를 필수로 입력해주세요');
	}
}
function dropMbrPointClick() {
	var srgMbr = trans_rid;
	var tgtMbr = mbr_rid;
	var modifyby = ifvmUserInfo.id;
	var dropReason =$("#reasonData").val();
	if ($.fn.ifvmIsNotEmpty(dropReason)){
		if (!confirm(tgtCustNm + '님 포인트를 '+srcCustNm+'님에게 이관후 탈회처리 하시겠습니까 ?')) {
			return;
		}
		$.ifvPostJSON('<ifvm:action name="transPointExec"/>', 
				{ 'pDropMbrYn':"Y",
				  'pRidMbrRcv' :tgtMbr,
				  'pRidMbrGiv':srgMbr,
				  'pModifyBy':modifyby,
				  'pReason':dropReason
		}, function(result) {
			
	// 			$.ifvSyncPostJSON('<ifvm:action name="transPntReason"/>', 
	// 					{ 'reasonData':dropReason,
	// 					  'srgMbr' :srgMbr,
	// 					  'tgtMbr':tgtMbr,
	// 					  'pnt':sumPoint
	// 			}, function(result) {
	// 					if ($.fn.ifvmIsNotEmpty(result)) {
	// 						alert('<spring:message code="V00219" />'); // 완료되었습니다.
	// 						location.reload();
	// 					}
	// 			}, function(result) {
	// 				alert(result.message);
	// 			});
			alert('<spring:message code="V00219" />'); // 완료되었습니다.
			closeBtnClick();
			cancelmbrTransFerFn();
			gMbrDetail.loadData();
			mbrDetailTab.moveTabIndex(6);
		}, function(result) {
			alert(result.message);
		});
	}else{
		alert('이관사유를 필수로 입력해주세요');
	}
	
	
}



</script>