<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script type="text/javascript">
var ipAccessControlHistListCon = null;

function ipAccessControlHistList(){
	var jqGridOption = {
		serializeGridData : function( data ){
		},
        url : '<ifvm:action name="getIpAccessControlHistList"/>',
        colNames:[ 
                   '<spring:message code="L01603"/>',
                   '<spring:message code="L01604"/>',
                   '<spring:message code="V00160"/>',
                   '<spring:message code="V00161"/>',
                   '<spring:message code="V00162"/>',
                   '<spring:message code="V00164"/>',
                   'rid'
                 ],
        colModel:[
			{ name:'modifyDate', 		index:'a.modify_date', 			searchable : true, 		resizable : false,		width:'130px', 		align:'left' },
			{ name:'modifyBy', 			index:'d.user_id', 				searchable : true, 		resizable : false,		width:'100px', 		align:'left' },
			{ name:'accessIpAddr', 		index:'a.access_ip_addr', 		searchable : true,		resizable : false,		width:'100px', 		align:'center' },
			{ name:'aclType', 			index:'a.acl_type', 			searchable : true, 		resizable : false,		width:'80px', 		align:'center' },
			{ name:'useYn', 			index:'a.USE_YN', 				searchable : true, 		resizable : false,		width:'80px', 		align:'center' },
			{ name:'userId', 			index:'u.user_id', 				searchable : true, 		resizable : false,		width:'100px', 		align:'left' },
			{ name:'rid', 				index:'a.rid', 					hidden : true },
        ],        
        sortname: 'a.modify_date',
        sortorder: "desc",
        tempId: 'ifvGridOriginTemplete'
    };
	ipAccessControlHistListCon = $("#ipAccessControlHistListCon").ifvGrid({ jqGridOption : jqGridOption });
};

//로그인 사용자 팝업 IP접근제어 팝업 닫기
function ipAcesCtrlHistPopClose() {
	ipAcesCtrlHist.close();
}

$(document).ready(function(){
	ipAccessControlHistList();
});

</script>

<div class="row">
	<div id="ipAccessControlHistListCon" class="con_size"></div>
</div>
<center>
	<div class="row qt_border">
		<ifvm:inputNew type="button" id="" text="L00913" btnFunc="ipAcesCtrlHistPopClose" objCode="ipAcesCtrlHistPopClose_OBJ"/>
	</div>
</center>
