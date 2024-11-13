<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>



<script type="text/javascript">
var callTransferListModal = null;
var groupId;
	
var data1 = [];	

function callTransferListModalInit(){
	var jqGridOption = {
		onSelectCell : function (data) {
		},
		onSelectRow : function(data) {
			data1 = [];
			data1 = data;
		},
		serializeGridData : function(data){
		},
        url : '<ifvm:action name="getCallTransferList"/>',
        colNames:[ 
					'<spring:message code="V00147" />', /* 전화번호 */
					'<spring:message code="V00148" />', /* 전화번호 코드 */
					'<spring:message code="V00149" />', /* 제휴사명 */
					'<spring:message code="V00150" />', /* 제휴사 구분 */
					'<spring:message code="V00151" />', /* 제휴사 구분 코드 */
					'id',
                   ],
        colModel:[
					{ name:'allianceTelNo', 		index:'b.MARK_NAME', 		resizable : false,		width:'100px' },
					{ name:'allianceTelCd', 		index:'b.CODE_NAME', 		resizable : false, 		width:'100px' },
					{ name:'alliacneNm', 			index:'b.attrib01', 		resizable : false, 		width:'100px' },
					{ name:'allianceTypeNm', 		index:'a.MARK_NAME', 		resizable : false, 		width:'100px' },
					{ name:'allianceTypeCd', 		index:'a.CODE_NAME', 		resizable : false, 		width:'100px' },
					{ name:'id', 					index:'b.id', 				hidden : true, 			searchable : false},	
        ],
        sortname: 'b.attrib01',
        sortorder: "desc",
        radio: true,
    }; 
	callTransferListModal = $("#callTransferListGridCon").ifvGrid({ jqGridOption : jqGridOption });
};

function clickAddBtn(){
// 	TSPhone.softConsultaion("1006", "", data1.allianceTelNo, data1.allianceTelCd, data1.alliacneNm , data1.allianceTypeNm, data1.allianceTypeCd);
	TSPhone.softConsultaion(data1.allianceTelNo, "", data1.allianceTelNo, data1.allianceTelCd, data1.alliacneNm , data1.allianceTypeNm, data1.allianceTypeCd);
	softphoneData = [];
	softphoneData.push(data1.alliacneNm);
	softphoneData.push(data1.allianceTelNo);
	softphoneData.push(data1.allianceTypeCd);
	modifyCallTransferPopClose();
}

//호전환 리스트 팝업 닫기
function modifyCallTransferPopClose() {
	modifyCallTransferPop._destroy();
	
}

$(document).ready(function(){
 	callTransferListModalInit();
});

</script>

<div class="row">
	<div id="callTransferListGridCon" class="con_size"></div>
</div>
<center>
	<div class="row qt_border">
		<ifvm:inputNew type="button" id="" text="V00190" btnFunc="clickAddBtn"/>
		<ifvm:inputNew type="button" id="" text="M00750" btnFunc="modifyCallTransferPopClose"/>
	</div>
</center>