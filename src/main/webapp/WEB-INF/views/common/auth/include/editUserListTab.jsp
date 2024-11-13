<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var userGrid;

/**
 * 사용자 등록 그리드 조회
 */
function initUserGrid() {

	var jqGridOption = {
		serializeGridData : function(data) {
			data.authGroupId = groupId;
			return data;
		},
        url : '<ifvm:action name="getAuthEmpList"/>',
        colNames:[
            '<spring:message code="I02082"/>',
            '<spring:message code="I02078"/>',
            '<spring:message code="I02079"/>',
            '<spring:message code="I02055"/>',
            '<spring:message code="I02056"/>',
            'id'
				],
        colModel:[
            { name:'userId', index:'u1.user_id', resizable : false },
            { name:'empName', index:'e.name', resizable : false },
            { name:'empType', index:'cc.mark_name', resizable : false },
            { name:'empCreater', index:'e2.name', resizable : false },
            { name:'empCreateDate',  index:'e.create_date', resizable : false, formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} },
            { name:'id', index:'aur.id', resizable : false, hidden : true }
        ],
        sortname: 'e.create_date',
        sortorder: "desc",
        multiselect: true,
        rowList: $.ifvmGetSelectBoxNum(),
        tempId: 'ifvGridOriginTemplete'
    };
	userGrid = $("#userGridDiv").ifvGrid({ jqGridOption : jqGridOption });
};

/**
 * 사용자 등록 팝업 호출
 */
function addUserDetail() {
	if (groupId != null && groupId != "null") {
		$.ifvLoadPop({
			url : '<ifvm:url name="empAddListModal"/>',
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
 * 사용자 삭제
 */
function delUserDetail() {

	var checkedList = userGrid.getCheckedList();
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
			$.ifvSyncPostJSON('<ifvm:action name="deleteEmpList"/>', {
				delIdList : delIdList,
			}, function(result) {
				userGrid.requestData({
					groupId : groupId
				});
				alert('<spring:message code="I00726"/>');
			});
		}
	}
}

$(document).ready(function() {

	// 그리드 조회
	initUserGrid();

});

</script>

<div class="page_btn_area">
	<div class="col-sm-7">
		<span><spring:message code="I02077"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew id="btnSave" type="button" btnFunc="addUserDetail" className="authCretBtn" text="I00080" btnType="plus"/>
		<ifvm:inputNew id="btnDel" type="button" btnFunc="delUserDetail" className="authDelBtn" text="I00248" btnType="minus"/>
	</div>
</div>
<div id="userGridDiv"></div>