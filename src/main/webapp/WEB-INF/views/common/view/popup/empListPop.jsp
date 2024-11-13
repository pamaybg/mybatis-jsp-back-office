<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="empListGridCon"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnCommEmpPopSelect" objCode="btnCommEmpPopSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnCommEmpPopCancel" objCode="btnCommEmpPopCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var empAddListModal = null;
var empId = null;
var empNm = null;
var empNo = null;
var orgRid = null;
function empListSetting(){
	var ejGridOption = {
		rowSelected : function (args) {
			empNm = args.data.name;
			empNo = args.data.empNo;
			orgRid = args.data.ridDivision;
			empId = args.data.employeeRid;
        },recordDoubleClick : function(row) {
			$('#approvalNm').val(empNm);
			empRid = empId;
			orgRid = orgRid;
			$("#empRid").val(empId);
			$("#empNm").val(empNm);
			$("#empNo").val(empNo);
			$.fn.ifvmPopupClose();
        },
		serializeGridData : function( data ){
			return data;
		},
		dataUrl : '<ifvm:action name="getEmpListPop"/>',
		
		columns:[
	          {
				  field: 'empNo', headerText: '사번', headerTextAlign: 'center', textAlign: 'center', customAttributes : {index : 'e.EMP_NO', searchable : true}
			  }, {
	      		  field : 'userId', headerText : '<spring:message code="M02163"/>', headerTextAlign : 'center', textAlign : 'center'
	      	  },{
	      		  field : 'name', headerText : '<spring:message code="I02078"/>', headerTextAlign : 'center', textAlign : 'center' , customAttributes :  {index : 'e.NAME', searchable : true}
	      	  },{
	      		  field : 'email', headerText : '<spring:message code="I00187"/>', headerTextAlign : 'center'
	      	  },{
	      		  field : 'workStatusNm', headerText : '<spring:message code="I02079"/>', headerTextAlign : 'center', textAlign : 'center' ,
	      		  customAttributes : {index : 'workStatus'}, visible: false,
	      	  },{
	      		  field : 'employeeRid', headerText : 'employeeRid', visible: false,
	      	  },{
	      		  field : 'crmUserRid', headerText : 'crmUserRid', visible: false,
	      	  },{
	      		  field : 'ridDivision', headerText : 'ridDivision', visible: false,
	      	  }
		   ],
		   requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : '1',
		      	  sord : 'desc',
		      	  _search : false
		        },
		        rowList : [10,25,50,100],
		        radio: true
		};
	empAddListModal = $("#empListGridCon").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function(){
	empListSetting();
	
	$("#btnCommEmpPopSelect").click(function(){
		if(empAddListModal.opt.gridControl.getSelectedRecords().length == 0){
			alert('<spring:message code="M00285"/>');
		} else {
			$('#approvalNm').val(empNm);
			empRid = empId;
			orgRid = orgRid;
			$("#empRid").val(empId);
			$("#empNm").val(empNm);
			$("#empNo").val(empNo);
			$.fn.ifvmPopupClose();
		}
	});
	
	$("#btnCommEmpPopCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
});
</script>