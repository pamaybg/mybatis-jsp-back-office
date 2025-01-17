<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var authGrid;

/**
 * 권한 목록 조회
 */
function initAuthGrid() {

	var jqGridOption = {
		serializeGridData : function(data) {
			data.groupId = groupId;
			return data;
		},
        url : '<ifvm:action name="getAuthGroupAuthList"/>',
        colNames:[
            '<spring:message code="I02060"/>',
            '<spring:message code="I00075"/>',
            '<spring:message code="I02055"/>',
            '<spring:message code="I02056"/>',
            'id'
                 ],
        colModel:[
            { name:'authName', index:'at.aut_nm', resizable : false },
            { name:'authDesc', index:'at.aut_desc', resizable : false },
            { name:'authCreater', index:'e.name', resizable : false },
            { name:'authCreateDate', index:'at.create_date', resizable : false , formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"}},
            { name:'id', index:'agr.id', resizable : false, hidden : true}
        ],
        sortname: 'at.create_date',
        sortorder: "desc",
        multiselect: true,
        rowList: $.ifvmGetSelectBoxNum(),
        tempId: 'ifvGridOriginTemplete'
    };
	authGrid = $("#authGridDiv").ifvGrid({
		jqGridOption : jqGridOption
	});
};
/**
 * 권한 추가
 */
function addAuthDetail() {
	if (groupId != null && groupId != "null") {
		$.ifvLoadPop({
			url : '<ifvm:url name="authAddListModal"/>',
			params : '',
			close : function() {
			}
		});
	}
	else {
		alert('<spring:message code="I02081"/>');
	}
}

/**
 * 권한 삭제
 */
function delAuthDetail() {
	var checkedList = authGrid.getCheckedList();
	var delIdList = [];
	var url = null;
	if (checkedList.length == 0) {
		alert('<spring:message code="I02051"/>');
	}
	else {
		for (var i = 0; i < checkedList.length; i++) {
			delIdList.push(checkedList[i].id);
		}
		if (confirm('<spring:message code="I01500"/>') == true) {
			$.ifvSyncPostJSON('<ifvm:action name="deleteGroupAuthList"/>', {
				delIdList : delIdList,
			}, function(result) {
				authGrid.requestData({
					groupId : groupId
				});
				alert('<spring:message code="I00726"/>');
			});
		}
	}
}

$(document).ready(function() {

	// 그리드 조회
	initAuthGrid();

});

</script>


<div class="page_btn_area">
	<div class="col-sm-7">
		<span><spring:message code="I02062"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew id="btnSave" type="button" btnFunc="addAuthDetail" className="authCretBtn" text="I00080" btnType="plus"/>
		<ifvm:inputNew id="btnDel" type="button"  btnFunc="delAuthDetail" className="authDelBtn" text="I00248" btnType="minus"/>
	</div>
</div>
<div id="authGridDiv"></div>