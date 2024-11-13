<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
tr.jqgrow td[aria-describedby=gridIdcommCodeListCon_id] 
	{white-space: normal; word-break: break-all;}
tr.jqgrow td[aria-describedby=gridIdcommCodeListCon_groupCode] 
	{white-space: normal; word-break: break-all;}
tr.jqgrow td[aria-describedby=gridIdcommCodeListCon_groupName] 
	{white-space: normal; word-break: break-all;}
tr.jqgrow td[aria-describedby=gridIdcommCodeListCon_markCode] 
	{white-space: normal; word-break: break-all;}	
tr.jqgrow td[aria-describedby=gridIdcommCodeListCon_markName] 
	{white-space: normal; word-break: break-all;}	
tr.jqgrow td[aria-describedby=gridIdcommCodeListCon_codeName] 
	{white-space: normal; word-break: break-all;}			
</style>


<script>

var commCodeGrid;
var isFirstGrid = true;

function init() {
	 $.ifvmLnbSetting("commCodeList");
	//버튼 비활성화
	$('#addCommCodeByCopy').attr("disabled",true);
	$('#delCommCode').attr("disabled",true);
}

function getAppServiceType() {
	
	//appService type code
	$.ifvSyncPostJSON('<ifvm:action name="getSystem"/>', {
	}, function(result) {
		
		var temp = $("#appServiceTypeTemplate").tmpl(result.rows);
		$("#appServiceType").append(temp);
	});
	
	
}

function getCommonCode() {
	//language code
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'LANG_TYPE'
		,schemas : 'com'//com스키마에만 있기 때문이다.
		, enableNA : true
	}, function(result) {
		for (var i=0; i<result.rows.length; i++) {
			if (result.rows[i].codeName != "NA") {
				result.rows[i].codeName = result.rows[i].codeName.toLowerCase();
			}
		}
		var temp = $("#languageTemplate").tmpl(result.rows);
		$("#language").append(temp);
	});
	$("#language").val('NA');
}

function commCodeListInit(){
	
	var jqGridOption = {
		ondblClickRow : function (index) {
			var selectedRowData = commCodeGrid.getRowData()[index-1];
			qtjs.href('<ifvm:url name="commCodeDetail"/>?id='+selectedRowData.id+'&schema='+$("#schema option:selected").val()+'&lang='+selectedRowData.lang);
		},
		serializeGridData : function( data ){
			$.extend( data, getData() );
			return data;
		},
		loadComplete : function( obj ){
			isFirstGrid = false;
		},
		url : '<ifvm:action name="getCommCodeGridList"/>',
		colNames:[ 
			'ID',//ID
			'<spring:message code="M00240"/>',//순번
			'<spring:message code="M00241"/>',//그룹코드
			'<spring:message code="M00238"/>',//그룹명
			'<spring:message code="M00242"/>',//Mark Code
			'<spring:message code="M00243"/>',//Mark Name
			'<spring:message code="M00244"/>',//Code Name
			'<spring:message code="M00245"/>',//상태
			'<spring:message code="M00246"/>',//국가
			'<spring:message code="M00237"/>',//언어
			'<spring:message code="M00260"/>',//상위코드ID
			'<spring:message code="M00261"/>',//attrib01
			'<spring:message code="M00262"/>',//attrib02
			'<spring:message code="M00263"/>',//attrib03
			'<spring:message code="M00264"/>',//attrib04
			'<spring:message code="M00265"/>',//attrib05,
			'<spring:message code="M00248"/>',//등록자
			'<spring:message code="M00249"/>',//등록일자
			'<spring:message code="M00250"/>',//변경자
			'<spring:message code="M00251"/>'//변경일자

		],
		colModel:[
			{ name:'id', index:'cc.id', resizable : false, searchable : true },
			{ name:'seq', index:'cc.seq', resizable : false, searchable : true, align : 'center', width : 30 },
			{ name:'groupCode', index:'cc.group_code', resizable : false, searchable : true },
			{ name:'groupName', index:'cc.group_name', resizable : false, searchable : true },
			{ name:'markCode', index:'cc.mark_code', resizable : false, searchable : true },
			{ name:'markName', index:'cc.mark_name', resizable : false, searchable : true },
			{ name:'codeName', index:'cc.code_name', resizable : false, searchable : true },
			{ name:'status', index:'cc.flag', resizable : false, searchable : false, align : 'center', formatter : statusFormat, width : 50 },
			{ name:'country', index:'cc.country', resizable : false, searchable : true, align : 'center', width : 40 },
			{ name:'lang', index:'cc.lang', resizable : false, searchable : true, align : 'center', width : 40 },
			{ name:'parentCodeId', index:'cc.par_code_id', resizable : false, searchable : true},
			{ name:'attrib01', index:'cc.attrib01', resizable : false, searchable : true, width : 60 },
			{ name:'attrib02', index:'cc.attrib02', resizable : false, searchable : true, width : 60 },
			{ name:'attrib03', index:'cc.attrib03', resizable : false, searchable : true, width : 60 },
			{ name:'attrib04', index:'cc.attrib04', resizable : false, searchable : true, width : 60 },
			{ name:'attrib05', index:'cc.attrib05', resizable : false, searchable : true, width : 60 },
			{ name:'createBy', index:'e1.name', resizable : false, searchable : true, align : 'center' },
			{ name:'createDate', index:'cc.create_date', resizable : false, searchable : true, formatter:'date', formatoptions:{newformat:"Y-m-d"} },
			{ name:'modifyBy', index:'e2.name', resizable : false, searchable : true, align : 'center' },
			{ name:'modifyDate', index:'cc.modify_date', resizable : false, searchable : true, formatter:'date', formatoptions:{newformat:"Y-m-d"} }
		],
		multiselect: true,
		sortname: 'cc.modify_date',
		rowList: $.ifvmGetSelectBoxNum(),
		sortorder: "desc",
		tempId : 'ifvGridOriginTemplete'
	};
	commCodeGrid = $("#commCodeListCon").ifvGrid({ jqGridOption : jqGridOption });
};

function statusFormat(data){//0일 경우 '삭제', 1일 경우 '정상' 표시
	return data == 0 ? '<spring:message code="M00165" />' : '<spring:message code="M00253" />' ;
}

function getData(){
	var obj = $('#commCodeListFormArea').getSubmitData();
	return obj;
}

function search(){
	if (isFirstGrid) {
		commCodeListInit();
		//버튼 활성화 시켜준다.
		$('#addCommCodeByCopy').attr("disabled",false);
		$('#delCommCode').attr("disabled",false);
	} else {
		commCodeGrid.requestData( getData() );
	}
};

/* 팝업 닫기 */
function commCodePopupClose(){
	$('#commCodeAddByCopyModal').ejDialog('destroy');
}

function commCodeAddByCopy() {
	var selectedRowArray = commCodeGrid.getCheckedGridData();
	if (selectedRowArray.length == 1) {
		//다국어복사생성을 위한 팝업 - 데이터 셋팅
		$("#commCodeAddByCopyModal").ejDialog({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="commCodeAddByCopyModal"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M00257"/>',
	        width: 600,
	        close : 'commCodePopupClose'
	    });
		//commCodeAddByCopyPopInit(selectedRowArray);
	} else if (selectedRowArray.length > 1) {
		alert('<spring:message code="M00256"/>');
	} else {
		alert('<spring:message code="M00153"/>');
	} 
}

function commCodeAdd() {
	qtjs.href('<ifvm:url name="commCodeDetail"/>');
}

function commCodeDel() {
	var selectedRowArray = commCodeGrid.getCheckedGridData();
	if (selectedRowArray.length > 0) {
		if( confirm('<spring:message code="M00127"/>') == true ) {
			var commCodeIdList = new Array();
			for(i=0; i<selectedRowArray.length; i++) {
				commCodeIdList.push(
					{ id : selectedRowArray[i].id,
						language : selectedRowArray[i].lang
					}
				);
			}
			$.ifvSyncPostJSON('<ifvm:action name="editCommCodeFlag"/>'
				,{commCodeIdList : commCodeIdList,
 				schema : $("#schema option:selected").val()
 				}
				,function(result) {
					alert('<spring:message code="M00255"/>');
					commCodeGrid.requestData( getData() );
				}
			);
		}
	} else {
		alert('<spring:message code="M00153"/>');
	}
}

function eventSetting(){
	$.ifvEnterSetting(["#groupName"], search );
	$.ifvEnterSetting(["#markName"], search );
	$.ifvEnterSetting(["#codeName"], search );
};

$(document).ready(function(){
		
	init();
	getAppServiceType();
	getCommonCode();
	eventSetting();
	
	$("#commCodeSearch").on("click", search);	//조회
	$("#addCommCodeByCopy").on("click", commCodeAddByCopy);	//다국어복사생성
	$("#addCommCode").on("click", commCodeAdd);	//신규
	$("#delCommCode").on("click", commCodeDel);	//삭제
});

</script>

<script id="appServiceTypeTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}id}">${'${'}and_app_name}</option>
</script>

<script id="languageTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div id="pop"></div>
<div class="page-title">
	<h1>
		<spring:message code="M00156"/>
		<span> &gt; <spring:message code="M00234"/></span>
		<span> &gt; <spring:message code="M00162"/></span>
	</h1>
</div>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M00168"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="commCodeSearch"><i class="fa fa-search"></i>
			<spring:message code="M00135"/>
		</button> 
	</div>
</div>

<div class="well" id="commCodeListFormArea" >
	<div class="row  qt_border">
		<div class="form-horizontal">
			<%-- <label class="col-xs-1 control-label two_line"><spring:message code="M00235"/></label>
			<div class="col-xs-3">
				<ifvm:input type="select" id="appServiceType" dto="appServiceType" disabled="true" />
			</div> --%>
			
			<label class="col-xs-1 control-label"><spring:message code="M00236"/></label>
			<div class="col-xs-3">
				<ifvm:input type="select" id="schema" dto="schema" text="M00252" values="com" checkIndex="1" disabled="true"/>
			</div>	
			<label class="col-xs-1 control-label"><spring:message code="M00237"/></label>
			<div class="col-xs-3">
				<ifvm:input type="select" id="language" dto="language" />
			</div>	
			<label class="col-xs-1 control-label"><spring:message code="M00238"/></label>
			<div class="col-xs-3">
				<ifvm:input type="text" id="groupName" dto="groupName" maxLength="50" />
			</div>
		</div>
	</div>
	<div class="row">
		<div class="form-horizontal">
			
			<label class="col-xs-1 control-label two_line"><spring:message code="M00243"/></label>
			<div class="col-xs-3">
				<ifvm:input type="text" id="markName" dto="markName" maxLength="50" />
			</div>	
			<label class="col-xs-1 control-label two_line"><spring:message code="M00244"/></label>
			<div class="col-xs-3">
				<ifvm:input type="text" id="codeName" dto="codeName" maxLength="50" />
			</div>
		</div>
	</div>
</div>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M00239"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm btn_gray" id='addCommCodeByCopy'>
			<i class="fa fa-plus"></i>
			<spring:message code="M00254"/>
		</button> 
		<button class="btn btn-sm btn_gray" id='addCommCode'>
			<i class="fa fa-plus"></i>
			<spring:message code="M00163"/>
		</button> 
		<button class="btn btn-sm btn_gray" id='delCommCode'>
			<i class="fa fa-minus"></i>
			 <spring:message code="M00165"/>
		</button> 	
	</div>
</div>
<div id="commCodeListCon"></div><!-- 공통코드 목록 grid -->

<div id="commCodeAddByCopyModal" class="popup_container"></div><!-- 다국어복사생성 팝업 -->