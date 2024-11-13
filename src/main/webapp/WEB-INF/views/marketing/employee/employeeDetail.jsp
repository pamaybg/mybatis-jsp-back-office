<%@page import="java.util.UUID"%>
<%@page trimDirectiveWhitespaces="true" %>
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
<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.js' type="text/javascript"></script>

<script>
var employeeId = '<%= cleanXss(request.getParameter("employeeId"))%>';

var ridDivision = '<%= cleanXss(request.getParameter("ridDivision")) %>';

var isNew = true;
/* var fakePassword; // 20150522 update
var newPassword; // 20150522 update */
var validation = null;

/* function employee_init(){
	//if(ifvmDivisionInfo.storeName != null )
	$('#storeName').val( $.ifvmGetUserInfo().orgName );
}; */

/* function clearPassword() {
	// 20150604 update
	if( $("#password").val() != fakePassword ) {
		newPassword = $.ifvmEncryptAES($("#password").val());
	} else {
		newPassword = fakePassword;
	}
}; */

function getEmployeeDetail() {
	if(employeeId == null || employeeId == 'null' || employeeId == "undefined" || employeeId.length <= 0) {
		return;
	}
	$.ifvSyncPostJSON('<ifvm:action name="MKTSelectEmployeeDetail"/>',{
		id : employeeId
	},
	function(result) {
		/* // 20150522 update
		fakePassword = result.password;
		newPassword = result.password; */

		$('#formArea').dataSetting( result );
		var mobileArr =[];
		var phoneArr =[];
		/* if(result.mobileNo !=null){
			mobileArr = result.mobileNo.split("-");
			for(var i=0; i<mobileArr.length;i++){
				var j = i+1
				$("#mobile"+j).val(mobileArr[i]);
			}

		}
		if(result.phoneNo != null){
			phoneArr =  result.phoneNo.split("-");
			for(var i=0; i<phoneArr.length;i++){
				var j = i+1
				$("#phone"+j).val(phoneArr[i]);
			}
		} */
	});
};

function storeListModalSelected(obj) {
	$('#storeName').val(obj.storeName);
	$('#ridDivision').val(obj.rid);
	//employeeListCon.requestData( { storeId : obj.storeId, storeType : obj.storeType } );
	ifvmDivisionInfo.storeId = obj.storeId;
	ifvmDivisionInfo.storeName = obj.storeName;
	ifvmDivisionInfo.storeType = obj.storeType;
}

function deptPopupClose() {
	popupContainer._destroy();
}

function getCommonCode() {
	// 재직상태
	$.fn.ifvmSetSelectOptionCommCode( "workStatus", "WORK_STATUS" );
	// 직위
	$.fn.ifvmSetSelectOptionCommCode( "position", "POSITION" );
	// 직책
	$.fn.ifvmSetSelectOptionCommCode( "responsibility", "RESPONSIBILITY" );
};

//목록 돌아가기
function goList() {
	qtjs.href('<ifvm:url name="employeeNew"/>');
}

$(document).ready(function() {
	
	$('#mobileNo').on("blur keyup",function(){
		$(this).val($(this).val().replace(/[a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|-]/g,''));
	});
	
	$.ifvPostJSON( '<ifvm:action name="getOrganizationDetail"/>',
			{rid : ridDivision},
			function(result) {
				if(result!=null){
					$('#storeName').val(result.divNm);
				}
				//success
				if(ridDivision != "null"){
					$('#ridDivision').val(ridDivision);
				}
			},
			function(result) {
				//error
			}
		);

	$.ifvmLnbSetting('departmentsEmployeeNew');
	getCommonCode();
	validation = $("#formArea").ifvValidation();

	//신규 or 수정 여부 확인
	isNew = (employeeId != 'null' && employeeId.length > 0 ? false : true);

	$('#findStore').on('click', function() {
		$("#popupContainer").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="MKTStorePopupList"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M00566"/>',
	        width: 600,
	        close : 'deptPopupClose'
	    });
	});

	if(!isNew) {
		getEmployeeDetail();
		/* $('#password').val(fakePassword);
		$('.input-group-addon').hide(); */
	}

	/* $('#password').on('blur', function() {
		clearPassword();
	}); */

	$('#btnSave').on('click', function() {
		//저장로직
		if( validation.confirm() == false ) return;
		var obj = $('#formArea').getSubmitData();
		obj.storeId = $.ifvmGetUserInfo().accountId;
		obj.empType = 'NORMAL';
		obj.id = employeeId;

/* 		if(!isNew) {
		} */
		$.ifvPostHeaderJSON(isNew ? '<ifvm:action name="MKTInsertEmployee"/>' : '<ifvm:action name="MKTUpdateEmployee"/>', obj,
		{
			// 20150522 update
			/* password : newPassword */

		},
		function(result) {
			alert('<spring:message code="M00005" />');
			if( typeof storeManage == 'undefined' ){
				qtjs.href('<ifvm:url name="employeeNew"/>');
			}else{
				clearInput();
			}
		},
		function(result) {
			var str;
			switch(result.message) {
				case "MSG_1008" :
					str = MESSAGE.storeManage.error_MSG_1008
					break;
				case "MSG_3002" :
					str = MESSAGE.departments.error_MSG_3002
					break;
			}
			alert(str);
		}
		,  "#btnSave" );
	});

	/* employee_init(); */
});
</script>

<script id="commCodeListTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>


<div class="page-title">
	<h1>
		<spring:message code="M00581"/>
		&gt; <spring:message code="M00582"/>
	</h1>
</div>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M00581"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<button class="btn btn-sm" id="btnSave" objCode="employDetailSave_OBJ"> <i class="glyphicon glyphicon-check"></i>
			<spring:message code="M00573"/>
		</button>
		<ifvm:inputNew type="button" id="goDepartmentsEmlpoyeeNew" btnFunc="goList" text="L00824" objCode="goDepartmentsEmlpoyeeNew_OBJ"/>
	</div>
</div>

<div class="well underline form-horizontal" id="formArea">
	<div class="row qt_border">
		<div class="row">
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="M00558"/></label>
			<div class="col-xs-4 control_content">
				<div class="input-group" style="width: 100%;">
					<ifvm:input type="text" className="form-control" required="true" id="storeName" dto="storeName" disabled="true" />
					<ifvm:input type="hidden" className="form-control" required="true" id="ridDivision" dto="ridDivision" disabled="true" />
					<span id="findStore" style="cursor: pointer" class="input-group-addon">
						<a><i class="fa fa-search"></i></a>
					</span>
				</div>
			</div>

		</div>
	</div>

	<div class="row  qt_border">
		<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="M00583"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="text" className="form-control" required="true" valiItem="email" dto="email" maxLength="50"/>
		</div>
		<%-- <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00584"/></label>
		<div class="col-xs-3 control_content">
			20150522 update 비밀번호 요소 수정.
			<ifvm:input type="password" id="password" className="form-control" required="true" dto="password" maxLength="16" minLength="8"/>
		</div> --%>
	</div>

	<div class="row  qt_border">
		<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="M00562"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="text" className="form-control" required="true" dto="employeeNo" maxLength="16"/>
		</div>
		<label class="col-xs-2 control-label"><spring:message code="M00007"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="text" className="form-control" dto="employeeName" maxLength="33"/>
		</div>
	</div>

	<div class="row  qt_border">
		<label class="col-xs-1 control-label"><spring:message code="M00563"/></label>
		<div class="col-xs-4 control_content">
			<div class="input-group" style="width:100%">
				<ifvm:input type="select" id="position" names="position" dto="position" className="form-control"/>
			</div>
		</div>

		<label class="col-xs-2 control-label"><spring:message code="M00564"/></label>
		<div class="col-xs-4 control_content">
			<div class="input-group" style="width:100%">
				<ifvm:input type="select" dto="responsibility" id="responsibility" names="responsibility" className="form-control"/>
			</div>
		</div>
	</div>

	<div class="row  qt_border">
		<label class="col-xs-1 control-label"><spring:message code="M00576"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="text" className="form-control" dto="phoneNo" maxLength="11"/>
			<%-- <ifvm:input type="text" className="style_type1 phone_size3" valiItem="number" dto="phone1" id="phone1" maxLength="3"/>
			<ifvm:input type="text" className="style_type1 phone_size4" valiItem="number" dto="phone2" id="phone2" maxLength="4"/>
			<ifvm:input type="text" className="style_type1 phone_size4" valiItem="number" dto="phone3" id="phone3" maxLength="4"/> --%>
		</div>
		<label class="col-xs-2 control-label"><spring:message code="M00585"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="select" id="workStatus" names="workStatus" dto="workStatus" className="form-control"/>
		</div>
	</div>

	<div class="row">
		<label class="col-xs-1 control-label"><spring:message code="M00577"/></label>
		<div class="col-xs-4 control_content">
			<div> 
				<ifvm:input type="text" className="form-control" id="mobileNo" dto="mobileNo" maxLength="11"/>
				<%-- <ifvm:input type="text" className="style_type1 phone_size3" dto="mobile1" id="mobile1" valiItem="number" maxLength="3"/>
				<ifvm:input type="text" className="style_type1 phone_size4" dto="mobile2" id="mobile2" valiItem="number" maxLength="4"/>
				<ifvm:input type="text" className="style_type1 phone_size4" dto="mobile3" id="mobile3" valiItem="number" maxLength="4"/> --%>
			</div>
		</div>

		<label class="col-xs-2 control-label">
			<spring:message code="M00586"/>
		</label>
		<div class="col-xs-4 control_content">
			<div class="input-group" style="width:100%">
				<ifvm:input type="text" dto="extention" maxLength="4" className="form-control"/>
			</div>
		</div>
	</div>
</div>

<div id="popupContainer" class="popup_container"></div>



