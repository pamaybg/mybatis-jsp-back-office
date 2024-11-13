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

	var ejGridOption = {
		serializeGridData : function(data) {
			data.groupId = groupId;
			return data;
		},
		dataUrl : '<ifvm:action name="getAuthGroupAuthList"/>',
		columns:[
        	{
        		  field : 'authName', headerText : '<spring:message code="I02060"/>', headerTextAlign : 'center',
        	  },{
          		  field : 'authDesc', headerText : '<spring:message code="I00075"/>', headerTextAlign : 'center',
          	  },{
          		  field : 'authCreater', headerText : '<spring:message code="I02055"/>', headerTextAlign : 'center',
          	  },{
          		  field : 'authCreateDate', headerText : '<spring:message code="I02056"/>', headerTextAlign : 'center',
          	  },{
          		  field : 'id', headerText : 'id', headerTextAlign : 'center', visible :false ,
          	  },{
          		  field : 'authId', headerText : 'authId', headerTextAlign : 'center', visible :false ,
          	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'authCreateDate',
      	  sord : 'desc',
      	  _search : false
        },
        radio: true,
        multiselect: true,
        rowList: $.ifvmGetSelectBoxNum(),
        tempId: 'ifvGridOriginTemplete'
    };
	authGrid = $("#authGridDiv").ifvsfGrid({
		ejGridOption : ejGridOption
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
	var checkedList = authGrid.opt.gridControl.getSelectedRecords();
	var delIdList = [];
	var authIdList = [];
	var url = null;
	if (checkedList.length == 0) {
		alert('<spring:message code="I02051"/>');
	}
	else {
		for (var i = 0; i < checkedList.length; i++) {
			delIdList.push(checkedList[i].id);
			authIdList.push(checkedList[i].authId);
		}
		if (confirm('<spring:message code="I01500"/>') == true) {
			$.ifvSyncPostJSON('<ifvm:action name="deleteGroupAuthList"/>', {
				delIdList : delIdList,
				authIdList : authIdList,
				authGroupId : groupId
			}, function(result) {
				authGrid.searchGrid({
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
		<ifvm:inputNew id="btnSave" type="button" btnFunc="addAuthDetail" className="authCretBtn" text="I00080" btnType="plus" objCode="editAuthListTabAdd_OBJ"/>
		<ifvm:inputNew id="btnDel" type="button"  btnFunc="delAuthDetail" className="authDelBtn" text="I00248" btnType="minus" objCode="editAuthListTabDel_OBJ"/>
	</div>
</div>
<div id="authGridDiv"></div>