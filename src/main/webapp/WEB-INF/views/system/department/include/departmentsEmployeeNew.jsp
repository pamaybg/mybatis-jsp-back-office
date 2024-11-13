<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.js' type="text/javascript"></script>

<script type="text/x-jsrender" id="loginLockYnTemplate">
	{{if errCnt >=5 }}
		isYn ="Y"
	{{else}}
		isYn="N"
	{{/if}}

</script>

<script>
var popSelectlId;
var temp;
var temp2;
var temp3;
var temp4;
var temp5;
var user = null;
var employeeId = null;

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
	var checkedList = employeeListCon.opt.gridControl.getSelectedRecords();
	var employeeIdsList = [];
	var managerCheck = true;

	for( var i = 0; i < checkedList.length; i++ ){
		employeeIdsList.push( checkedList[i].id );

		if ( checkedList[i].adminUser )
			managerCheck = false;
	}

	if(employeeIdsList.length > 0){
		if( confirm('<spring:message code="M00127"/>') == true ){

			$.ifvSyncPostJSON('<ifvm:action name="MKTDeleteEmployee"/>',{
				listEmployeeId : employeeIdsList
			},
			function(result) {
				employeeListCon.searchGrid();
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
	var ejGridOption = {
		serializeGridData : function( data ){
			data.rid = rid;
			data.empId = empId;
			return data;
		},
		dataUrl : '<ifvm:action name="getAuthGroupListByEmpIdAndRidUser"/>',
        columns:[
        	{
        		  field : 'authGroupName', headerText : '<spring:message code="M01243"/>', headerTextAlign : 'center',
        	  },{
          		  field : 'authGroupDesc', headerText : '<spring:message code="M01264"/>', headerTextAlign : 'center',
          	  },{
          		  field : 'modifyDate', headerText : '<spring:message code="M01846"/>', headerTextAlign : 'center',
          	  },{
          		  field : 'id', headerText : 'id', visible : false ,
          	  },{
          		  field : 'autGroupId', headerText : 'autGroupId', visible : false ,
          	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'modifyDate',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true,
        tempId: 'ifvGridOriginTemplete'
    };
	authGroupListCon = $("#authGroupListCon").ifvsfGrid({ ejGridOption : ejGridOption });
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
	var ejGridOption = {
//		recordDoubleClick : function (args) {
//
//			var user = args.data;
//			var url = '<ifvm:url name="userDetailPop"/>?empNo='+temp3+'&ridUser='+user.rid+'&id='+temp2.id;
//			userPopup(url);
			/*
			$.fn.ifvmPopupOpen('userModal',
					'',
					'<ifvm:url name="userDetailPop"/>?empNo='+temp3+'&ridUser='+user.rid+'&id='+temp2.id
							,'<spring:message code="M01911"/>',
							860);	 */
//		},
		serializeGridData : function( data ){
			data.empId = empId;
			return data;
		},
		rowSelected : function(args){

			$('#authGroupListCon').hide();
			$('#ipAccessControlListCon').hide();
			$('#userModal').hide();
			temp = "";
			temp = args.data;
// 			userModal._destroy();
			authGroupList(args.data.rid, empId);
			ipAccessControlList(args.data.rid);
			user = args.data;

		},
// 		loadComplete : function(data){
// 		},
        dataUrl : '<ifvm:action name="getUserListByEmpId"/>',
        columns:[
        	 {
         		  field : 'userId', headerText : '<spring:message code="M00193"/>', headerTextAlign : 'center',
         		  customAttributes : {
         			  index : 'cu.user_id' } //
         	  }, {
          		  field : 'pwExpireDate', headerText : '<spring:message code="M01906"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'cu.pw_expir_date' } //
          	  }, {
          		  field : 'userPwCnt', headerText : '<spring:message code="V00169"/>', headerTextAlign : 'center', templates : "#loginLockYnTemplate",
          		  customAttributes : {
          			  index : 'cu.USER_PW_CNT' } //
          	  }, {
          		  field : 'rid', headerText : 'rid', visible : false ,
          		  customAttributes : {
          			  index : 'cu.rid' } //
          	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'cu.pw_expir_date',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true,
        tempId: 'ifvGridOriginTemplete',
        ajaxGridOptions :{async : true}
    };
	userListCon = $("#userListCon").ifvsfGrid({ ejGridOption : ejGridOption });
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

	var ejGridOption = {
/* 		recordDoubleClick : function (args) {
			var data = args.data;
			$.ifvSyncPostJSON('<ifvm:action name="setCurrentdivision"/>',{
				  storeId : data.storeId
				, storeName : data.storeName
				, storeType : data.storeType
				, storeMarkType : data.markName
			}
			,function(result) {
			});
			employeeDetail( data.id );
		}, */
		serializeGridData : function( data ){
			data.storeId = storeId;
			//data.storeType = $.ifvmGetUserInfo().accountType;
			return data;
		},
		rowSelected : function(args){

			$('#userListArea').hide();
			$('#authGroupListArea').hide();
			$('#ipAccessControlListArea').hide();
			$('#userListCon').hide();
			$('#authGroupListCon').hide();
			$('#ipAccessControlListCon').hide();
			temp2 = "";
			temp2 = args.data;
			temp3 = "";
			temp3 = args.data.employeeNo;
			userList(args.data.id);
			employeeId = args.data.id;
		},
// 		loadComplete : function(data){
// 		},
        dataUrl : '<ifvm:action name="MKTSelectEmployeeList"/>',
        columns:[
        	{
       		  field : 'storeName', headerText : '<spring:message code="M00558"/>', headerTextAlign : 'center',
       		  customAttributes : {
       			  index : 'cd.div_nm' } //
       	  },{
     		  field : 'employeeNo', headerText : '<spring:message code="M00562"/>', headerTextAlign : 'center',
     		  customAttributes : {
     			  index : 'e.emp_no' } //
     	  },{
     		  field : 'employeeName', headerText : '<spring:message code="M00007"/>', headerTextAlign : 'center',
     		  customAttributes : {
     			  index : 'e.name' } //
     	  },{
     		  field : 'position', headerText : '<spring:message code="M00563"/>', headerTextAlign : 'center',
     		  customAttributes : {
     			  index : 'c1.mark_name' } //
     	  },{
     		  field : 'responsibility', headerText : '<spring:message code="M00564"/>', headerTextAlign : 'center',
     		  customAttributes : {
     			  index : 'c2.mark_name' } //
     	  },{
     		  field : 'workStatus', headerText : '<spring:message code="M00565"/>', headerTextAlign : 'center',
     		  customAttributes : {
     			  index : 'c3.mark_name' } //
     	  },{
     		  field : 'id', headerText : 'id', visible : false ,
     		  customAttributes : {
     			  index : 'e.id' } //
     	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'e.emp_no',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true,
        tempId: 'ifvGridOriginTemplete'
    };
	employeeListCon = $("#employeeListCon").ifvsfGrid({ ejGridOption : ejGridOption });
};

function ipAccessControlList(rid){
	$('#ipAccessControlListArea').show();
	$('#ipAccessControlListCon').show();
	var ejGridOption = {
		/* recordDoubleClick : function (args) {
			temp4 = "";
			temp4 = args.data.rid;

			clickInsertIpAccessControl();
		}, */
		rowSelected : function(args){
			temp4 = "";
			temp4 = args.data.rid;
			temp5 = "";
			temp5 = args.data;
		},
		serializeGridData : function( data ){
			data.rid = rid;
			return data;
		},
		dataUrl : '<ifvm:action name="getIpAccessControlList"/>',
		columns:[
        	  {
        		  field : 'accessIpAddr', headerText : '<spring:message code="V00160"/>', headerTextAlign : 'center',
        		  customAttributes : {
        			  index : 'a.access_ip_addr' } //
        	  },{
          		  field : 'aclType', headerText : '<spring:message code="V00161"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'a.acl_type' } //
          	  },{
          		  field : 'useYn', headerText : '<spring:message code="V00162"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'a.USE_YN' } //
          	  },{
          		  field : 'aclTypeCd', headerText : 'aclTypeCd', visible :false ,
          		  customAttributes : {
          			  index : 'a.acl_type' } //
          	  },{
          		  field : 'useYnCd', headerText : 'useYnCd', visible :false ,
          		  customAttributes : {
          			  index : 'a.use_yn' } //
          	  },{
          		  field : 'userId', headerText : 'userId', visible :false ,
          		  customAttributes : {
          			  index : 'u.user_id' } //
          	  },{
          		  field : 'rid', headerText : 'rid', visible :false ,
          		  customAttributes : {
          			  index : 'a.rid' } //
          	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'a.access_ip_addr',
      	  sord : 'asc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true,
        tempId: 'ifvGridOriginTemplete'
    };
	ipAccessControlListCon = $("#ipAccessControlListCon").ifvsfGrid({ ejGridOption : ejGridOption });
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
	employeeListCon.searchGrid();
// 	employeeListCon.requestData( { storeId : obj.rid, storeType : obj.storeType } );
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

	var authGroupData = authGroupListCon.opt.gridControl.getSelectedRecords()[0];
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

	var userData = userListCon.opt.gridControl.getSelectedRecords()[0];
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

//직원 상세
function modifyEmployee(){
	if(employeeId == null){
		alert('<spring:message code="I00728"/>');	
	}else{
		qtjs.href('<ifvm:url name="employeeDetailUrl2"/>' + '?employeeId=' + employeeId);
	}
}

function modifyUser(){
	if(employeeId == null){
		alert('<spring:message code="I00728"/>');	
	}else{
		var url = '<ifvm:url name="userDetailPop"/>?empNo='+temp3+'&ridUser='+user.rid+'&id='+temp2.id;
		userPopup(url); 
	}
}

function clickModifyIpAccessControl(){
	if(temp4 == null){
		alert('<spring:message code="I00728"/>');	
	}else{
		clickInsertIpAccessControl();
	}
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
		<button class="btn btn-sm" id='employeeListSearchBtn' objCode="dptEmployeeListSearchBtn_OBJ"><i class="fa fa-search"></i>
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
		<ifvm:inputNew type="button" id="insertEmployee"  text="M00571" btnType="plus" btnFunc="clickInsertEmployee" objCode="dptEmployeeNewAdd_OBJ"/>
		<ifvm:inputNew type="button" id="modifyEmployee"  text="M00283" btnFunc="modifyEmployee()" objCode="dptEmployeeNewModify_OBJ"/>
		<ifvm:inputNew type="button" id="deleteEmployee"  text="M00572" btnType="minus" btnFunc="clickDeleteEmployee" objCode="dptEmployeeNewDel_OBJ"/>
	</div>
</div>
<div id="employeeListCon" class="grid_bd0"></div>
<div class="page_btn_area" id="userListArea">
	<div class="col-sm-7">
		<span><spring:message code="M01905"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" id="showLoginHistPop"  text="M02159" btnType="" btnFunc="clickShowLoginHistPop" objCode="dptEmpNewShowLoginHist_OBJ"/>
		<ifvm:inputNew type="button" id="insertUser"  text="M00571" btnType="plus" btnFunc="clickInsertUser" objCode="dptEmpNewShowLoginAdd_OBJ"/>
		<ifvm:inputNew type="button" id="modifyUser"  text="M00283" btnFunc="modifyUser()" objCode="dptEmpNewShowLoginModify_OBJ"/>
		<ifvm:inputNew type="button" id="deleteUser"  text="M00572" btnType="minus" btnFunc="clickDeleteUser" objCode="dptEmpNewShowLoginDel_OBJ"/>
	</div>
</div>
<div id="userListCon" class="grid_bd0"></div>
<div class="page_btn_area" id="authGroupListArea">
	<div class="col-sm-7">
		<span><spring:message code="M01908"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" id="insertAuthGroup"  text="M00571" btnType="plus" btnFunc="clickInsertAuthGroup" objCode="dptEmpNewAuthGroupAdd_OBJ" />
		<ifvm:inputNew type="button" id="deleteAuthGroup"  text="M00572" btnType="minus" btnFunc="clickDeleteAuthGroup" objCode="dptEmpNewAuthGroupDel_OBJ"/>
	</div>
</div>
<div id="authGroupListCon" class="grid_bd0"></div>
<!-- 로그인 사용자 IP접근제어 -->
<div class="page_btn_area" id="ipAccessControlListArea">
	<div class="col-sm-7">
		<span><spring:message code="V00159"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" id="setIpAcesCtrlPop"  text="V00163" btnType="" btnFunc="showIpAcesCtrlHistPop" objCode="dptEmpNewAccessCtlHist_OBJ"/>
		<ifvm:inputNew type="button" id="insertIpAccessControl"  text="M00571" btnType="plus" btnFunc="clickInsertIpAccessControl" objCode="dptEmpNewAccessCtlAdd_OBJ"/>
		<ifvm:inputNew type="button" id="modifyAcessControl"  	 text="M00283" btnFunc="clickModifyIpAccessControl()" objCode="dptEmpNewAccessCtlModify_OBJ"/>
		<ifvm:inputNew type="button" id="deleteIpAccessControl"  text="M00572" btnType="minus" btnFunc="clickDeleteIpAccessControl" objCode="dptEmpNewAccessCtlDel_OBJ"/>
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