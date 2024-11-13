<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/voc/softPhoneOCX.js'></script>
<script type="text/javascript">
var alliTypeListModal = null;
var groupId;
	
var data2 = [];

function alliTypeListModalInit(){
	var jqGridOption = {
		onSelectCell : function (data) {
		},
		onSelectRow : function(data) {
			data2 = [];
			data2 = data;
		},
		serializeGridData : function(data){
		},
 
        url : '<ifvm:action name="getAlliTypeList"/>',
        colNames:[ 
					'<spring:message code="V00145" />', /* 제휴사 유형 */
					'<spring:message code="V00146" />', /* 제휴사 유형 코드 */
					'id',
                   ],
        colModel:[
					{ name:'markName', 		index:'a.mark_name', 		resizable : false,		width:'100px' },
			        { name:'codeName', 		index:'a.code_name', 		resizable : false, 		width:'100px' },
			        { name:'id', 			index:'a.id', 				hidden : true, 			searchable : false},	
        ],
        sortname: 'a.mark_name',
        sortorder: "desc",
        radio: true,
    }; 
	alliTypeListModal = $("#alliTypeListGridCon").ifvGrid({ jqGridOption : jqGridOption });
};

function clickAddBtn(){
	TSPhone.SoftphoneRec_Start(data2.codeName);
	setAlliTypePopClose();
}

//제휴사 유형 팝업 닫기
function setAlliTypePopClose() {
	setAlliTypePop._destroy();
}

$(document).ready(function(){
	alliTypeListModalInit();
});

</script>

<div class="row">
	<div id="alliTypeListGridCon" class="con_size"></div>
</div>
<center>
	<div class="row qt_border">
		<ifvm:inputNew type="button" id="" text="V00191" btnFunc="clickAddBtn"/>
		<ifvm:inputNew type="button" id="" text="M00750" btnFunc="setAlliTypePopClose"/>
	</div>
</center>
