<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
	.ui-jqgrid .ui-jqgrid-bdiv {
		overflow: hidden;
	}
</style>
<script type="text/javascript">
var loginHistoryListGrid;
var gridIdloginHistoryListGrid;

//캠페인 목록
function getLoginHistoryList(){
    //var page = $.fn.ifvmIsNotEmpty(page) ? page : 1;
		var ejGridOption = {
			serializeGridData : function (data) {
				data.loginUserId = temp.userId;
				return data;
			},
			dataUrl: '<ifvm:action name="getLoginHistoryList"/>',
			columns: [
				{
					field: 'loginDt',
					headerText: '<spring:message code="M02160" />',
					//index: 't1.create_date',
					textAlign: 'center',
					resizable: true,
					customAttributes: {
						searchable: true
					}
				}, {
					field: 'loginSuccessYn',
					headerText: '<spring:message code="V00170" />',
					//index: 't1.LOGIN_SUCCESS_YN',
					textAlign: 'center',
					resizable: true,
					customAttributes: {
						searchable: true
					}
				}, {
					field: 'ip',
					headerText: '<spring:message code="M02161" />',
					//index: 't1.ip',
					textAlign: 'center',
					resizable: true,
					customAttributes: {
						searchable: true
					}
				}, {
					field: 'sessnId',
					headerText: '<spring:message code="M02162" />',
					//index: 't1.sessn_id',
					textAlign: 'center',
					resizable: true,
					customAttributes: {
						searchable: true
					}
				}, {
					field: 'userId',
					headerText: '<spring:message code="M02163" />',
					//index: 'u1.user_id',
					textAlign: 'center',
					resizable: true,
					customAttributes: {
						searchable: true
					}
				}, {
					field: 'userStatNm',
					headerText: '<spring:message code="M02164" />',
					//index: 'c2.mark_name',
					textAlign: 'center',
					resizable: true,
					customAttributes: {
						searchable: true
					}
				}, {
					field: 'divNo',
					headerText: '<spring:message code="M02165" />',
					//index: 'd1.div_no',
					textAlign: 'center',
					resizable: true,
					customAttributes: {
						searchable: true
					}
				}, {
					field: 'divNm',
					headerText: '<spring:message code="M02166" />',
					//index: 'd1.div_nm',
					textAlign: 'center',
					resizable: true,
					customAttributes: {
						searchable: true
					}
				}, {
					field: 'empNm',
					headerText: '<spring:message code="M02167" />',
					//index: 'e1.name',
					textAlign: 'center',
					resizable: true,
					customAttributes: {
						searchable: true
					}
				}, {
					field: 'email',
					headerText: '<spring:message code="M02168" />',
					//index: 'e1.email',
					textAlign: 'center',
					resizable: true,
					customAttributes: {
						searchable: true
					}
				}, {
					field: 'workStatusNm',
					headerText: '<spring:message code="M02172" />',
					//index: 'c3.markName',
					textAlign: 'center',
					resizable: true,
					customAttributes: {
						searchable: true
					}
				}, {
					field: 'id',
					headerText: '<spring:message code="id" />',
					visible: false, //index: '', hidden: true
				}
			],
			requestGridData: {
				sidx: 't1.create_date',
				sord: 'desc'
			},
			rowList : [10,25,50,100],
			radio: true,
			tempId : 'ifvGridOriginTemplete'
			//tempId: 'ifvGridOriginTemplete'
		};
		loginHistoryListGrid = $("#loginHistoryListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
		gridIdloginHistoryListGrid = $("#gridIdloginHistoryListGrid");
	}

//로그인 사용자 팝업 IP접근제어 팝업 닫기
$("#loginHistPopClose").click(function(){
	//$('#loginHistPop').ejDialog('destroy');
	$.fn.ifvmPopupClose();
});

$(document).ready(function(){
	getLoginHistoryList();
});

</script>

<div class="pop_inner_wrap">
	<div id="loginHistoryListGrid"></div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_lightGray2" id="loginHistPopClose" objCode="loginHistPopClose_OBJ">
			<spring:message code="L00913"/>
		</button>
	</div>
</div>
