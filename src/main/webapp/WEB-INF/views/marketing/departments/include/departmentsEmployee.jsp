<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.js' type="text/javascript"></script>


<script>
var popSelectlId;
var temp;
var temp2;
var temp3;
var temp4;
var temp5;

function employeeDetail(employeeId){
	//직원상세
	qtjs.href('<ifvm:url name="employeeDetailUrl"/>' + '?employeeId=' + employeeId);
}

function clickInsertEmployee(){
	var ridDivision = $('#ridDivision').val();
	//직원 신규
	qtjs.href('<ifvm:url name="employeeDetailUrl"/>' + '?ridDivision=' + ridDivision);
}

function beforeDeleteEmployee(){
	$('#beforeDeleteModal').ejDialog({
		enableModal : true,
	    enableResize: false,
	    contentUrl: '<ifvm:url name="beforeDeletePop"/>',
	    contentType: "ajax",
	    title: '',
	    width: 600,
	    close : 'deptPopupClose'
	});
}
function clickDeleteEmployee() {
	//삭제
	var checkedList = employeeListCon.getCheckedList();
	var employeeIdsList = [];
	var managerCheck = true;

	for( var i = 0; i < checkedList.length; i++ ){
		employeeIdsList.push( checkedList[i].id );

		if ( checkedList[i].adminUser )
			managerCheck = false;
	}

	if(employeeIdsList.length > 0){
		if( confirm('<spring:message code="M00127"/>') == true ){

			/* if (managerCheck == false) {
				alert('<spring:message code="M00233" />');
				return;
			} */

			$.ifvSyncPostJSON('<ifvm:action name="MKTDeleteEmployee"/>',{
				listEmployeeId : employeeIdsList
			},
			function(result) {
				employeeListCon.delCheckedRow();
				alert('<spring:message code="M00003" />');

				beforeDeletePopupClose();
				$('#userListCon').hide();
				employeeList();
			});

		}
	}else{
		alert('<spring:message code="M00004" />');
	}
}

var employeeListCon = null;

function authGroupList(rid, empId){
	$('#authGroupListArea').show();
	$('#authGroupListCon').show();
	var jqGridOption = {
		ondblClickRow : function (data) {

		},
		serializeGridData : function( data ){
			data.rid = rid;
			data.empId = empId;
			return data;
		},
        url : '<ifvm:action name="getAuthGroupListByEmpIdAndRidUser"/>',
        colNames:[
                   '<spring:message code="M01243"/>',
                   /* '<spring:message code="M01275"/>', */
                   '<spring:message code="M01264"/>',
                   '<spring:message code="M01846"/>',
                   'id',
                   'autGroupId'
                 ],
        colModel:[
			{ name:'authGroupName', 		index:'ag.aut_group_nm', 			searchable : true,		resizable : false },
			/* { name:'authGroupType',			index:'ag.auth_data_group_type',	searchable : true, 		resizable : false }, */
			{ name:'authGroupDesc', 		index:'ag.aut_group_desc', 			searchable : true, 		resizable : false },
			{ name:'modifyDate', 			index:'ag.modify_date', 			searchable : true, 		resizable : false },
			{ name:'id', 					index:'ag.id', 						hidden : true },
			{ name:'autGroupId', 			index:'aur.aut_group_id', 			hidden : true },
        ],
        sortname: 'ag.modify_date',
        sortorder: "desc",
        radio: true,
        tempId: 'ifvGridOriginTemplete'
    };
	authGroupListCon = $("#authGroupListCon").ifvGrid({ jqGridOption : jqGridOption });
};



function userPopup(url){
	userDetailPop ={
	        id : "userModal"
	    };
	userDetailPop.popup = function (){
		userDetailPop.pop = $('#'+userDetailPop.id).ifvsfPopup({
	            enableModal: true,
	            enableResize: false,
	            contentUrl: url,
	            contentType: "ajax",
	            title: '<spring:message code="M01911"/>',
	            width: '860px',
	            close: userDetailPop.close
	        });
	};
	userDetailPop.beforeClose = function (obj) {
	};
	userDetailPop.close = function (obj) {

		userModal._destroy();
	 };
	 userDetailPop.popup();


}
function userList(empId){
	$('#userListArea').show();
	$('#userListCon').show();
	var jqGridOption = {
		ondblClickRow : function (data) {

			var user = userListCon.getRowData()[data-1];
			var url = '<ifvm:url name="userDetailPop"/>?empNo='+temp3+'&ridUser='+user.rid+'&id='+temp2.id;
			userPopup(url);
			/*
			$.fn.ifvmPopupOpen('userModal',
					'',
					'<ifvm:url name="userDetailPop"/>?empNo='+temp3+'&ridUser='+user.rid+'&id='+temp2.id
							,'<spring:message code="M01911"/>',
							860);	 */
		},
		serializeGridData : function( data ){
			data.empId = empId;
			return data;
		},
		onSelectRow : function(data){

			$('#authGroupListCon').hide();
			$('#ipAccessControlListCon').hide();
			$('#userModal').hide();
			temp = "";
			temp = data;
// 			userModal._destroy();
			authGroupList(data.rid, empId);
			ipAccessControlList(data.rid);


		},
		loadComplete : function(data){
		},
        url : '<ifvm:action name="getUserListByEmpId"/>',
        colNames:[
                   '<spring:message code="M00193"/>',
                   '<spring:message code="M01906"/>',
                   '<spring:message code="V00169"/>',
                   'rid'
                 ],
        colModel:[
			{ name:'userId', 		index:'cu.user_id', 		searchable : true,		resizable : false, 		align:'left',    	width:'100px' },
            { name:'pwExpireDate',	index:'cu.pw_expir_date',	searchable : true, 		resizable : false, 		align:'center',    	width:'100px' },
            { name:'userPwCnt',		index:'cu.USER_PW_CNT',		searchable : true, 		resizable : false, 		align:'center',    	width:'100px', 			formatter:loginLockYn },
            { name:'rid', 			index:'cu.rid', 			hidden : true },
        ],
        sortname: 'cu.pw_expir_date',
        sortorder: "desc",
        radio: true,
        tempId: 'ifvGridOriginTemplete',
        ajaxGridOptions :{async : true}
    };
	userListCon = $("#userListCon").ifvGrid({ jqGridOption : jqGridOption });
};

//로그인 Lock formatter
function loginLockYn(cellvalue, options, rowObjec){
	var isYn = "";
	var errCnt=null;
	errCnt = rowObjec.userPwCnt;

	if(errCnt >= 5){
		isYn="Y"
	}else{
		isYn="N";

	}
	return isYn;
}

function employeeList(divId){
	var storeId = $.ifvmGetUserInfo().orgId;

	if (typeof divId != "undefined") {
		storeId = divId;

	}

	var jqGridOption = {
		ondblClickRow : function (data) {
			var data = employeeListCon.getRowData()[data-1];
			$.ifvSyncPostJSON('<ifvm:action name="setCurrentdivision"/>',{
				  storeId : data.storeId
				, storeName : data.storeName
				, storeType : data.storeType
				, storeMarkType : data.markName
			}
			,function(result) {
			});
			employeeDetail( data.id );
		},
		serializeGridData : function( data ){
			data.storeId = storeId;
			//data.storeType = $.ifvmGetUserInfo().accountType;
			return data;
		},
		onSelectRow : function(data){

			$('#userListArea').hide();
			$('#authGroupListArea').hide();
			$('#ipAccessControlListArea').hide();
			$('#userListCon').hide();
			$('#authGroupListCon').hide();
			$('#ipAccessControlListCon').hide();
			temp2 = "";
			temp2 = data;
			temp3 = "";
			temp3 = data.employeeNo;
			userList(data.id);
		},
		loadComplete : function(data){
		},
        url : '<ifvm:action name="MKTSelectEmployeeList"/>',
        colNames:[ '<spring:message code="M00558"/>',
                   '<spring:message code="M00562"/>',
                   '<spring:message code="M00007"/>',
                   '<spring:message code="M00563"/>',
                   '<spring:message code="M00564"/>',
                   '<spring:message code="M00565"/>',
                   'id'],
        colModel:[
			{ name:'storeName', index:'cd.div_nm', searchable : true,resizable : false },
            { name:'employeeNo', index:'e.emp_no', searchable : true,resizable : false },
            { name:'employeeName', index:'e.name', searchable : true,resizable : false },
            { name:'position', index:'c1.mark_name', searchable : true, resizable : false },
            { name:'responsibility', index:'c2.mark_name', searchable : true, resizable : false },
            { name:'workStatus', index:'c3.mark_name', searchable : true, resizable : false },
            { name:'id', index:'e.id', hidden : true },
        ],
        sortname: 'e.emp_no',
        sortorder: "desc",
        radio: true,
        tempId: 'ifvGridOriginTemplete'
    };
	employeeListCon = $("#employeeListCon").ifvGrid({ jqGridOption : jqGridOption });
};

function ipAccessControlList(rid){
	$('#ipAccessControlListArea').show();
	$('#ipAccessControlListCon').show();
	var jqGridOption = {
		ondblClickRow : function (data) {
			temp4 = "";
			temp4 = ipAccessControlListCon.getRowData()[data-1].rid;

			clickInsertIpAccessControl();
		},
		onSelectRow : function(data){
			temp5 = "";
			temp5 = data;
		},
		serializeGridData : function( data ){
			data.rid = rid;
			return data;
		},
        url : '<ifvm:action name="getIpAccessControlList"/>',
        colNames:[
//                    '<spring:message code="L01603"/>',
//                    '<spring:message code="L01604"/>',
                   '<spring:message code="V00160"/>',
                   '<spring:message code="V00161"/>',
                   '<spring:message code="V00162"/>',
                   'aclTypeCd',
                   'useYnCd',
                   'userId',
                   'rid'
                 ],
        colModel:[
// 			{ name:'modifyDate', 		index:'a.modify_date', 			searchable : true, 		resizable : false },
// 			{ name:'modifyBy', 			index:'a.modify_by', 			searchable : true, 		resizable : false },
			{ name:'accessIpAddr', 		index:'a.access_ip_addr', 		searchable : true,		resizable : false,		width:'100px', 		align:'center'  },
			{ name:'aclType', 			index:'a.acl_type', 			searchable : true, 		resizable : false,		width:'100px', 		align:'center'  },
			{ name:'useYn', 			index:'a.USE_YN', 				searchable : true, 		resizable : false,		width:'100px', 		align:'center'  },
			{ name:'aclTypeCd', 		index:'a.acl_type', 			hidden : true },
			{ name:'useYnCd', 			index:'a.use_yn', 				hidden : true },
			{ name:'userId', 			index:'u.user_id', 				hidden : true },
			{ name:'rid', 				index:'a.rid', 					hidden : true },
        ],
        sortname: 'a.access_ip_addr',
        sortorder: "asc",
        radio: true,
        tempId: 'ifvGridOriginTemplete'
    };
	ipAccessControlListCon = $("#ipAccessControlListCon").ifvGrid({ jqGridOption : jqGridOption });
};

function clickInsertIpAccessControl(){
	//로그인 사용자 IP접근제어 상세 팝업
	$("#setIpAcesCtrl").ifvsfPopup({
       enableModal : true,
	   enableResize: false,
	   contentUrl: '<ifvm:url name="setIpAcesCtrlPop"/>?ridUserAcl='+temp4,
	   contentType: "ajax",
	   title: "<spring:message code='V00159'/>",
	   width: 600,
	   close : 'setIpAcesCtrlPopClose'
	});
}

//로그인 사용자 IP접근제어 삭제
function clickDeleteIpAccessControl(){
	$.ifvSyncPostJSON('<ifvm:action name="removeIpAccessControl"/>',{
		ridCrmuser : temp.rid
		, ridUserAcl : temp5.rid
		, aclType : temp5.aclTypeCd
		, accessIpAddr : temp5.accessIpAddr
		, useYn : temp5.useYnCd
	},function(result) {
		ipAccessControlList(temp.rid);
	});
}

function showIpAcesCtrlHistPop(){
	//로그인 사용자 IP접근제어 이력 팝업
	$("#ipAcesCtrlHist").ifvsfPopup({
       enableModal : true,
	   enableResize: false,
	   contentUrl: '<ifvm:url name="ipAcesCtrlHistPop"/>',
	   contentType: "ajax",
	   title: "<spring:message code='V00163'/>",
	   width: 600,
	   close : 'ipAcesCtrlHistPopClose'
	});
}

function employee_init(){
	//초기값설정
	//if(ifvmStoreInfo.storeName != null )
	$('#storeName').val( $.ifvmGetUserInfo().orgName );
	$("#storeName").prop("disabled", "disabled");
};

function storeListModalSelected(obj) {
	//가져온 obj 안에서 key값 추출후 처리
	//employeeListCon.requestData( { ?? : 요청parameter } );
	$('#storeName').val(obj.storeName);
	employeeListCon.requestData( { storeId : obj.rid, storeType : obj.storeType } );
}

function deptPopupClose() {
	$('#popupContainer').ejDialog('destroy');
}

function authGroupPopupClose(){
	$('#authGroupModal').ejDialog('destroy');
}

function loyPgmPopupClose(){
	$('#loyPgmModal').ejDialog('destroy');
}

function userDetailPopupClose(){
	$('#userModal').ejDialog('destroy');
}

function beforeDeletePopupClose(){
	$('#beforeDeleteModal').ejDialog('destroy');
}

function fillStoreName(storeName){
	$('#storeName').val(storeName);
}


function deleteAuthGroup(){

	var authGroupData = authGroupListCon.getCheckedGridData()[0];
	$.ifvSyncPostJSON('<ifvm:action name="deleteAuthGroupByRid"/>',{
		id : authGroupData.id,
		ridUser : temp.rid,
		autGroupId : authGroupData.autGroupId

	},
	function(result){
		alert('<spring:message code="I00726"/>');
	},
	function(result){
		alert('<spring:message code="M00911"/>');
	});
	authGroupList(temp.rid, temp2.id);
}

function deleteUser(){

	var userData = userListCon.getCheckedGridData()[0];
	$.ifvSyncPostJSON('<ifvm:action name="deleteUserDetail"/>',{
		rid : userData.rid
	},
	function(result){
		alert('<spring:message code="I00726"/>');
	},
	function(result){
		alert('<spring:message code="I00742"/>');
	});
	userList(temp2.id);
	$('#authGroupListCon').hide();
	$('#ipAccessControlListCon').hide();
}

//로그인 사용자 소유 권한그룹
function clickInsertAuthGroup(){
	$.fn.ifvmPopupOpen('authGroupModal', '', '<ifvm:url name="authGroupPop"/>?rid='+temp.rid+'&employeeId='+temp2.id, '<spring:message code="M00219"/>',860);
}

function clickDeleteAuthGroup(){
	deleteAuthGroup();
}

//로그인 사용자 정보
function clickInsertUser(){
	$.fn.ifvmPopupOpen('userModal', '', '<ifvm:url name="userDetailPop"/>?empNo='+temp3+'&id='+temp2.id, '<spring:message code="M01911"/>',860);
}

function clickDeleteUser(){
	deleteUser();
}

//로그인 사용자 이력 조회 팝업
function clickShowLoginHistPop(){
	if(temp != null){
		$("#loginHistPop").ifvsfPopup({
		 	   enableModal : true,
			   enableResize: false,
			   contentUrl: '<ifvm:url name="loginHistPop"/>',
			   contentType: "ajax",
			   title: "<spring:message code='M02159'/>",
			   width: 600,
			   close : 'loginHistPopClose'
		});
	}
}

$(document).ready(function() {
	$('#userListArea').hide();
	$('#authGroupListArea').hide();
	$('#ipAccessControlListArea').hide();

	/* employee_init(); */
	employeeList();

	//팝업생성
	$('#findStore').on('click', function() {
		$("#popupContainer").ejDialog({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="MKTStorePopupList"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M00566"/>',
	        width: 600,
	        close : 'deptPopupClose'
//	        open : function(){
//	        	new ifvm.PopupCenter();
//	        }
	    });
	});

	$('#employeeListSearchBtn').click(function(){
		employeeList();
	});

	$('#insertEmployee').on('click', function() {

		insertEmployee(ridDivision);
	});

	$('#deleteEmployee').on('click', function() {
		beforeDeleteEmployee();
	});

});
</script>
<div class="page-title">
	<h1>
		<spring:message code="M00567"/>
		&gt; <spring:message code="M00568"/>
	</h1>
</div>

<div class="page_btn_area">
	<div class="col-sm-7">
		<span><spring:message code="M00569"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<button class="btn btn-sm" id='employeeListSearchBtn'><i class="fa fa-search"></i>
			<spring:message code="M00135" />
		</button>
	</div>
</div>

<div class="well">
	<div class="form-horizontal">
	<div class="row">
		<label class="col-sm-1 control-label"><span class="asterisk">*</span><spring:message code="M00558"/></label>
		<div class="col-sm-4 control_content">
			<div class="input-group" style="width:100%;">
			<ifvm:input type="text" className="form-control" id="storeName" />
			<ifvm:input type="hidden" className="form-control" id="ridDivision" />
			<span style="cursor:pointer" class="input-group-addon manageHideItem" id="findStore"><a><i class="fa fa-search"></i></a></span>
			</div>
		</div>
	</div>
	</div>
</div>

<div class="page_btn_area">
	<div class="col-sm-7">
		<span><spring:message code="M00570"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" id="insertEmployee"  text="M00571" btnType="plus" btnFunc="clickInsertEmployee"/>
		<ifvm:inputNew type="button" id="deleteEmployee"  text="M00572" btnType="minus" btnFunc="clickDeleteEmployee"/>
	</div>
</div>
<div id="employeeListCon" class="grid_bd0"></div>
<div class="page_btn_area" id="userListArea">
	<div class="col-sm-7">
		<span><spring:message code="M01905"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" id="showLoginHistPop"  text="M02159" btnType="" btnFunc="clickShowLoginHistPop"/>
		<ifvm:inputNew type="button" id="insertUser"  text="M00571" btnType="plus" btnFunc="clickInsertUser"/>
		<ifvm:inputNew type="button" id="deleteUser"  text="M00572" btnType="minus" btnFunc="clickDeleteUser"/>
	</div>
</div>
<div id="userListCon" class="grid_bd0"></div>
<div class="page_btn_area" id="authGroupListArea">
	<div class="col-sm-7">
		<span><spring:message code="M01908"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" id="insertAuthGroup"  text="M00571" btnType="plus" btnFunc="clickInsertAuthGroup"/>
		<ifvm:inputNew type="button" id="deleteAuthGroup"  text="M00572" btnType="minus" btnFunc="clickDeleteAuthGroup"/>
	</div>
</div>
<div id="authGroupListCon" class="grid_bd0"></div>
<!-- 로그인 사용자 IP접근제어 -->
<div class="page_btn_area" id="ipAccessControlListArea">
	<div class="col-sm-7">
		<span><spring:message code="V00159"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" id="setIpAcesCtrlPop"  text="V00163" btnType="" btnFunc="showIpAcesCtrlHistPop"/>
		<ifvm:inputNew type="button" id="insertIpAccessControl"  text="M00571" btnType="plus" btnFunc="clickInsertIpAccessControl"/>
		<ifvm:inputNew type="button" id="deleteIpAccessControl"  text="M00572" btnType="minus" btnFunc="clickDeleteIpAccessControl"/>
	</div>
</div>
<div id="ipAccessControlListCon" class="grid_bd0"></div>

<div id="popupContainer" class="popup_container"></div>
<div id="userModal" class="popup_container"></div>
<div id="loyPgmModal" class="popup_container"></div>
<div id="authGroupModal" class="popup_container"></div>
<div id="beforeDeleteModal" class="popup_container"></div>
<!-- 로그인 사용자 IP접근제어 팝업 -->
<div id="setIpAcesCtrl"></div>
<!-- 로그인 사용자 IP접근제어 이력 팝업 -->
<div id="ipAcesCtrlHist"></div>
<!-- 로그인 이력 -->
<div id="loginHistPop"></div>