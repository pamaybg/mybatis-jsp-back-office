<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<link href="${pageContext.request.contextPath}/resources/js/jstree/themes/default/style.min.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/marketing/storeManage.css" />

<script src='${pageContext.request.contextPath}/resources/js/jquery.splitter-0.14.0.js' type="text/javascript"></script>

<script src="${pageContext.request.contextPath}/resources/js/jstree/jstree.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/marketing/storeManage.js"></script>



<script id="storeManageCommCodeTemplate" type="text/x-jquery-tmpl">
{{if codeName != "ACCOUNT" && codeName != "HOLD" && codeName !="QUICK"}}
<option value="${'${'}codeName}">${'${'}markName}</option>
{{/if}}
</script>

<div class="page-title">
	<h1>
		<spring:message code="M00552"/>
	</h1>
</div>

<div id="manageCon" class="row store_manage">

	<div class="tree_menu left_panel" id="treeMenu">
		<div>
			<div id="treeView"></div>
		</div>
	</div>

	<div id="manageContent" class="manage_content right_panel" >
		<div class="btn-group btn-group-justified" id="storeManageNavTab">
			<a href="javascript:;" id="goDepartmentsEmployee"  class="btn btn-default"><spring:message code="M00557"/></a>
		</div>
		<div id="storeManageContent" class="storemanage_content con_top_gap"></div>
	</div>
</div>

<div id="progress_big" class="big_progress_icon"><img src="${pageContext.request.contextPath}/resources/images/icons/loading_big.gif" /></div>


<script>
setGoogleMapLang();
var storeManage;
var storeManageValidation;
var employeeListCon;
//storeName
var storeName;
//메뉴 트리
var menuTree = new Object;

function departmentsManageTabClick(type, tab){
	storeManage.tabClick( type, tab );
};

function showProgressBar(){
	var tarT = $(window).height()/2 - ($("#progress_big").height()/2);
	$("#progress_big").css({ top : tarT });
	$("#progress_big").show();
};

function hideProgressBar(){
	$("#progress_big").hide();
};

$.fn.ifvmCreateKPRNodeTree = function( options ) {
	var _this = this;
	window[ _this.attr( "id" ) ];

	this.opt = $.extend({
		targetUrl: "<ifvm:action name='getOrganizationNodeList' />"
		, target: null
		, targetId: null
		, reportFlag: "N"
		, fields: {
			id: "nodeId"
			, parentId: "parNodeId"
			, text: "nodeText"
			, expanded: "expandedFlag"
		}
		, template : "#baseTreeTemplate"
	}, options);

	this.init = function() {
		var opt = this.opt;
		opt.target = $( "#" + opt.targetId ).ifvsfTree( opt );

		$.ifvPostJSON( opt.targetUrl, {
			reportFlag: opt.reportFlag
		}, function( rst ) {
			var thisTreeView = opt.target.data( "ejTreeView" );

			var nodeList = rst.nodeList;
			nodeList.forEach(function( thisObj, idx ) {
				thisObj.nodeId = opt.targetId + "_" + thisObj.nodeId;

				if( $.fn.ifvmIsNotEmpty( thisObj.parNodeId ) ) {
					thisObj.parNodeId = opt.targetId + "_" + thisObj.parNodeId;
				}
			});
			thisTreeView.dataSource( rst.nodeList );
			thisTreeView.refresh();
		});
	};

	this.init();

	return this;
};

//직원 목록 화면 설정
function setEmployeeCon() {
	var departmentsEmployeeUrl = '<ifvm:url name="departmentsEmployeeUrlNew"/>';
	$.ifvCachedHtml( departmentsEmployeeUrl ).done( function(script){
		$("#manageContent").html( script );
	});
}

function storeListModalSelected(obj) {
	$('#storeName').val(obj.storeName);
	$('#ridDivision').val(obj.rid);
	ifvmDivisionInfo.storeId = obj.storeId;
	ifvmDivisionInfo.storeName = obj.storeName;
	ifvmDivisionInfo.storeType = obj.storeType;
}
function setTreeview(){
	$( "#treeView" ).ifvmCreateKPRNodeTree({
		targetId: "treeView"
		, reportFlag: "N"
		, setBtn: {
			add: false
			, mod: false
			, del: false
		}
		, nodeClick: function( args ) {

			var target = $( args.currentElement );
			var targetId = target.closest( "li[id]" ).attr( "id" );
			if( $.fn.ifvmIsNotEmpty( targetId ) ) {
				var idIdx = targetId.indexOf( "treeView_" );

				if( idIdx > -1 ) {
					targetId = targetId.substring( ( "treeView_" ).length );

					$.ifvPostJSON( '<ifvm:action name="getOrganizationDetail"/>',
							{rid : targetId},
							function(result) {
								storeName = result.divNm;
								fillStoreName(storeName);
							},
					);

					//직원 목록 그리드 설정
					employeeList(targetId);
					$('#ridDivision').val(targetId);
				}
			}
		}
		, template : "#baseTreeTemplate"
	});
}

$(document).ready(function() {
	//직원 목록 화면 설정
	setEmployeeCon();

	setTreeview();

	storeManageValidation = $("#storeManageFormArea").ifvValidation();
	var wd = $(window).width();

	if( wd < 1015 ){
		$("body").addClass('hidden-menu');
	}
	$('#manageCon').split({orientation:'vertical', limit:100, position:'15%'});

	storeManage = new StoreManage({
		commcodeUrl : '<ifvm:action name="getCommCodeList"/>',
		setStoreUrl : '<ifvm:action name="setCurrentdivision"/>',
		departmentsInfoUrl : '<ifvm:url name="departmentsInfoUrl"/>',
		departmentsEmployeeUrl : '<ifvm:url name="departmentsEmployeeUrl"/>',
		employeeDetailUrl : '<ifvm:url name="employeeDetailUrl"/>',
		getSubAccountList : '<ifvm:action name="getSubAccountList"/>',
		getRootAccountList : '<ifvm:action name="getRootAccountList"/>',
		setAccountLevel : '<ifvm:action name="setAccountLevel"/>'
	});

	$('#goDepartmentsEmployee').on('click', function() {
		departmentsManageTabClick('departmentsEmployee', this);
	});

});
</script>