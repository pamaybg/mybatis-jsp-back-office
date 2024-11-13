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

	var ejGridOption = {
		serializeGridData : function(data) {
			data.authGroupId = groupId;
			return data;
		},
		dataUrl : '<ifvm:action name="getAuthEmpList"/>',
        columns:[
        		{
        		  field : 'userId', headerText : '<spring:message code="I02082"/>', headerTextAlign : 'center',
        	  },{
          		  field : 'empName', headerText : '<spring:message code="I02078"/>', headerTextAlign : 'center',
          	  },{
          		  field : 'empType', headerText : '<spring:message code="I02079"/>', headerTextAlign : 'center',
          	  },{
          		  field : 'empCreater', headerText : '<spring:message code="I02055"/>', headerTextAlign : 'center',
          	  },{
          		  field : 'empCreateDate', headerText : '<spring:message code="I02056"/>', headerTextAlign : 'center',
          	  },{
          		  field : 'id', headerText : 'id', visible :false ,
          	  },{
          		  field : 'ridCrmUser', headerText : 'ridCrmUser', visible :false ,
          	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'empCreateDate',
      	  sord : 'desc',
      	  _search : false
        },
        radio: true,
        rowList: $.ifvmGetSelectBoxNum(),
        tempId: 'ifvGridOriginTemplete'
    };
	userGrid = $("#userGridDiv").ifvsfGrid({ ejGridOption : ejGridOption });
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

	var checkedList = userGrid.opt.gridControl.getSelectedRecords();
	var delIdList = [];
	var ridCrmUserList = [];
	var url = null;
	if (checkedList.length == 0) {
		alert('<spring:message code="I02051"/>');
	}
	else {
		for (var i = 0; i < checkedList.length; i++) {
			delIdList.push(checkedList[i].id);
			ridCrmUserList.push(checkedList[i].ridCrmUser);
		}
		if (confirm('<spring:message code="I01500"/>') == true) {
			$.ifvSyncPostJSON('<ifvm:action name="deleteEmpList"/>', {
				delIdList : delIdList,
				ridCrmUserList : ridCrmUserList,
				authGroupId : groupId
			}, function(result) {
				userGrid.searchGrid({
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
		<ifvm:inputNew id="btnSave" type="button" btnFunc="addUserDetail" className="authCretBtn" text="I00080" btnType="plus" objCode="editUserListCreBtn_OBJ"/>
		<ifvm:inputNew id="btnDel" type="button" btnFunc="delUserDetail" className="authDelBtn" text="I00248" btnType="minus" objCode="editUserListDelBtn_OBJ"/>
	</div>
</div>
<div id="userGridDiv"></div>