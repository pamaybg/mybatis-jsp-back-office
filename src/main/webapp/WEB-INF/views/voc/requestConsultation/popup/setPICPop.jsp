<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script type="text/javascript">
var empAddListModal = null;
var groupId;
var pic = [];

function empAddListModalInit(accountId){
	var ejGridOption = {
		rowSelected : function(data) {
			pic = [];
			pic = data.data;
		},
		serializeGridData : function(data){
			data.accountId = $.ifvmGetUserInfo().accountId;
 			data.authGroupId = groupId;
		},

		dataUrl : '<ifvm:action name="getEmpAddListModalForCallCenter"/>',
		
		columns:[
			  {
	      		  field : 'userId', headerText : '<spring:message code="M02163"/>', headerTextAlign : 'center', width:'180px', textAlign : 'center' ,
	      		  customAttributes : {searchable:true}/*접수일시 */
	      	  },{
	      		  field : 'empName', headerText : '<spring:message code="I02078"/>', headerTextAlign : 'center', width:'150px', textAlign : 'center' ,
	      	  },{
	      		  field : 'empEmail', headerText : '<spring:message code="I00187"/>', headerTextAlign : 'center',  width:'150px'
	      	  },{
	      		  field : 'empType', headerText : '<spring:message code="I02079"/>', headerTextAlign : 'center', width:'80px',
	      		  customAttributes : {index : 'empType'}/*회원명 */
	      	  },{
	      		  field : 'empId', headerText : 'empId', visible: false,
	      		  customAttributes : {
	      			  index : 't1.cntc_desk' }/* 연락처*/
	      	  },{
	      		  field : 'ridUser', headerText : 'ridUser', visible: false,
	      		  customAttributes : {
	      			  index : 't1.mem_ptbl_no' }/*휴대폰번호 */
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
	empAddListModalInit();
});

function clearMasking(){
	var selectedRid = empAddListModal.opt.gridControl.getSelectedRecords()[0].empId;
	$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>',
			{
		type : 'emp',
		field : 'email',
		rid : selectedRid
	},
    function(result) {
		var rowid = empAddListModal.opt.gridControl.getSelectedRecords();
		empAddListModal.opt.grid.setCell(rowid , 'empEmail' , result.message );
     })
}

</script>
<div class="page_btn_area">
	<div class="col-xs-2">
		<span><spring:message code="I02077"/></span><!-- 사용자 목록 -->
	</div>
	<div class="col-xs-10 searchbtn_r">
		<ifvm:inputNew type="button" id="clearMaskingBtn" text="L00326" btnFunc="clearMasking"/>
	</div>
</div>
<div class="row">
	<div id="empListGridCon"></div>
</div>
<div class="pop_btn_area">
   <ifvm:inputNew type="button" btnType="save"	id="addBtn"	text="L01462" btnFunc="clickAddBtn"/>
</div>
