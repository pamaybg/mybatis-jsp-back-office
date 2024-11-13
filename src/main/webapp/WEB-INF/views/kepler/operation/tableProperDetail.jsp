<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
.e-tab .e-active-content {padding: 0;}
</style>

<script>
var tableId = null;
var dbInformId = null;
var tblNm = null;
var dbType = null;
var oldTblNm = null;
var tableNm = null;
var dpNm = null;
var dbmsTypeCd = null;
var schmaNm = null;
var subjectAreaNm = null;
var tableType = null;
var colId = null;

var convert_beforeType = null;
var convert_afterType = null;

function tableMstPopClose() {
	dialog._destroy();
}

/* 테이블구분 / 주제영역 호출 */
function comboData(){
	getDbServiceComboList();
 	getTblTypeComboList();
 	getSubjectAreaComboList();
}

/* 서비스명 호출 */
function getDbServiceComboList(){
	$.ifvSyncPostJSON(
		'<ifv:action name="getDbServiceComboList"/>'
	   , {}
	   , function(result) {
			var temp = $("#selectTmp").tmpl(result.rows);
			$("#serviceId").append(temp);
			if(tableId == null){
				dbInformId = $("#serviceId").val();
			}
	   });
}

function getTblTypeComboList(){
	$.ifvSyncPostJSON('<ifv:action name="getCommCodeList"/>',{ groupCode : 'ANL_TABLE_TYPE_CD', enableNA : true
	},function(result) {
		var temp = $("#dbTypeTemplate").tmpl(result.rows);
		$("#tableType").append(temp);
		if(tableId == null){
			tableType = $("#tableType").val();
		}
	});
};

function getSubjectAreaComboList(){
	$.ifvSyncPostJSON('<ifv:action name="getSubjectAreaComboList_KPR"/>', { dbInformId : dbInformId , tableType : tableType
	}, function(result) {
		if(result.rows.length > 0){
			var temp = $("#selectTmp").tmpl(result.rows);
			$("#subjectAreaId").empty();
			$("#subjectAreaId").append(temp);
		} else {
			alert('<spring:message code="M01710"/>');
			$("#subjectAreaId").empty();
			$("#subjectAreaId").val("");
		}
	});
}

// 테이블 정보 L.C사용유뮤
function getTableLgcChk(){
	$.ifvSyncPostJSON('<ifv:action name="getTableLgcChk"/>', { tableId : tableId
	}, function(result) {
		if(result.lgcFlag == 0){
			$("#tableNm").attr("disabled",true);
			$("#serviceId").attr("disabled",true);
	        $("#convertToDimensionBtn").attr("disabled", true);
	        $("#convertToMeasureBtn").attr("disabled", true);
		} else {
			$("#tableNm").attr("disabled",false);
			$("#serviceId").attr("disabled",false);
	        $("#convertToDimensionBtn").attr("disabled", false);
	        $("#convertToMeasureBtn").attr("disabled", false);
		}
	});
}

//타겟 레벨 조회
function getTableList(){
	$.ifvSyncPostJSON('<ifv:action name="getTableList_KPR"/>',{tableId : tableId}
	,function(result) {
		$("#dpNm").val(result.dpNm);
		$("#tableType").val(result.tblTypeCd);
		$("#subjectAreaId").val(result.subjectAreaId);
		$("#tblSpaceNm").val(result.tblSpaceNm);
		$("#schmaNm").val(result.schmaNm);

		$("#tableColtNewBtn").attr("disabled", false);
		$("#tableColEditeBtn").attr("disabled", false);
		$("#tableColDelBtn").attr("disabled", false);

		$("#convertToDimensionBtn").attr("disabled", false);
		$("#convertToMeasureBtn").attr("disabled", false);
	});
}

//타겟 레벨 수정
 function modifyTableList(){
	var obj = {};
	tableNmchk = false;
	validation = $("#tableFormArea").ifvValidation();

	if(validation.confirm()){
		obj.tableId = tableId;
		obj.dpNm = $("#dpNm").val();
		obj.tblTypeCd = $("#tableType").val();
		obj.subjectAreaId = $("#subjectAreaId").val();
		obj.tblSpaceNm = $("#tblSpaceNm").val();
		obj.schmaNm = $("#schmaNm").val();
		obj.tblNm = tblNm;
		obj.dbInformId = dbInformId;
		if(oldTblNm != tblNm){
			$.ifvSyncPostJSON('<ifv:action name="tableNmChk"/>',obj
			,function(result) {
				if(result.cnt > 0){
					alert('<spring:message code="M01609"/>');
					tableNmchk = true;
				}
			});
		}
		if(tableNmchk == false){
			$.ifvSyncPostJSON('<ifv:action name="editTableList_KPR"/>',obj
			,function(result) {
				alert('<spring:message code="M00624"/>');
				getTableList();
			});
		}
	}
}

//타겟 레벨 저장
 function setTableList(){
	var obj = {};
	tableNmchk = false;
	validation = $("#tableFormArea").ifvValidation();

	if(validation.confirm()){
		obj.dpNm = $("#dpNm").val();
		obj.tblTypeCd = $("#tableType").val();
		obj.subjectAreaId = $("#subjectAreaId").val();
		obj.tblSpaceNm = $("#tblSpaceNm").val();
		obj.schmaNm = $("#schmaNm").val();
		obj.tblNm = tblNm;
		obj.dbInformId = dbInformId;
		$.ifvSyncPostJSON('<ifv:action name="tableNmChk"/>',obj
		,function(result) {
			if(result.cnt > 0){
				alert('<spring:message code="M01609"/>');
				tableNmchk = true;
			}
		});
		if(tableNmchk == false){
			$.ifvSyncPostJSON('<ifv:action name="setTableList_KPR"/>',obj
			,function(result) {
				alert('<spring:message code="M00623"/>');
				if(result.tableId.length > 0){
					tableId = result.tableId
					getTableList();
				}
			});
		}
	}
}


function removeTableCol(){
	var selectData = tableColListGrid.opt.gridControl.getSelectedRecords();
	delChk = false;

	if( selectData.length == 0 ){
		alert('<spring:message code="M00004" />');
	} else {
		if(confirm('<spring:message code="M00296"/>')){
			var colIdList = [];

			for(var i=0; i<selectData.length; i++){
				colIdList.push(selectData[i].colId);
			}
 			$.ifvSyncPostJSON('<ifv:action name="tableAddColDelChk"/>',{
				colId1 : colIdList, tableId : tableId
		    },function(result) {
				if(result.delFlag == "1"){
					alert('<spring:message code="M01552"/>');
					delChk = true;
				}
			});
			if(delChk == false){
				$.ifvSyncPostJSON('<ifv:action name="removeTableAddColList"/>',{
					colId	: colIdList, tableId : tableId
				},function(result) {
					alert('<spring:message code="M00622"/>');
					getTableColList();
				});
			}
		}
	}
}
//캠페인 목록
function getTableColList(){
    var ejGridOption = {
   		recordDoubleClick : function(args){
           	colId = args.data.colId;
           	dbGubun = "U";
           	tableAddPopOpen();
        },
        rowSelected : function (args) {
        	var selectData = tableColListGrid.opt.gridControl.getSelectedRecords();
    		for(var i=0; i<selectData.length; i++){
    			colId  = selectData[i].colId;
			}
        },
   		serializeGridData : function( data ){
   			data.tableId = tableId;
   			data.dbType = dbType;
   		},
   		dataUrl : '<ifv:action name="getTableColList"/>',
        columns:[
        	{
      		  field : 'colNm', headerText : '<spring:message code="M01164"/>', headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'c.col_nm' } //
      	  },{
    		  field : 'pkYn', headerText : '<spring:message code="M01202"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'c.pk_yn' } //
    	  },{
    		  field : 'dataTypeCd', headerText : '<spring:message code="M01571"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'c1.mark_name' } //
    	  },{
    		  field : 'len', headerText : '<spring:message code="M00444"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'c.len' } //
    	  },{
    		  field : 'nullYn', headerText : '<spring:message code="M01564"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'c.null_yn' } //
    	  },{
    		  field : 'deftVal', headerText : '<spring:message code="M01574"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'c.deft_val' } //
    	  },{
    		  field : 'seq', headerText : '<spring:message code="M01602"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'c.seq' } //
    	  },{
    		  field : 'dpNm', headerText : '<spring:message code="M01573"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'c.dp_nm' } //
    	  },{
    		  field : 'colTypeCd', headerText : '<spring:message code="M01572"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'c2.mark_name' } //
    	  },{
    		  field : 'colId', headerText : 'id', visible : false ,
    		  customAttributes : {
    			  index : 'mc.chnl_nm' } //
    	  },
        ],
        requestGridData : {
        	  nd   : new Date().getTime(),
        	  rows : 10,
        	  sidx : 'c.seq',
        	  sord : 'asc',
        	  _search : false
          },
        rowList : [10,25,50,100],
        radio: true,
        tempId : 'ifvGridNoneLeftTemplete'
    };

    tableColListGrid = $("#tableColListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    gridIdtableColListGrid = $("#gridIdtableColListGrid");
}


//컬럼추가 팝업 열기
function tableAddPopOpen() {
 $("#dialog").ifvsfPopup({
		enableModal : true,
     enableResize: false,
     contentUrl: '<ifv:url name="tableAddColPop"/>',
     contentType: "ajax",
     title: '<spring:message code="M01603" />',
     width: "500",
     close : 'tableMstPopClose'
 });
}


function dbTypeCheck(){
	if($("#serviceId").val() != null){
		$.ifvSyncPostJSON('<ifv:action name="getDbType"/>'
	   , {dbInformId : dbInformId}
	   , function(result) {
 			if(result.conDbType == "MySQL"){
 				dbType = "MySQL";
			} else {
				dbType = "Oracle";
			}
	   });
	}
}


var getParameter = function (param) {
    var returnValue;
    var url = location.href;
    var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&');
    for (var i = 0; i < parameters.length; i++) {
        var varName = parameters[i].split('=')[0];
        if (varName.toUpperCase() == param.toUpperCase()) {
            returnValue = parameters[i].split('=')[1];
            return decodeURIComponent(returnValue);
        }
    }
};

/**
 * Dimension으로, Measure로 일괄 변환하는 팝업 호출
 *
 * @date 2017. 7. 24
 * @author jh.kim
 * @afterStatus = "DIMENSION" // Dimension으로 변환
 *              = "MEASURE"   // Measure로 변환
 * @returns
 */
function tableColConvertPopOpen(beforeType, afterType) {

    convert_beforeType = beforeType;
    convert_afterType = afterType;

    var titleTxt = "";
    if (afterType == "DIMENSION") {
        titleTxt = '<spring:message code="M02244" />';
    }
    else {
        titleTxt = '<spring:message code="M02245" />';
    }

    $("#dialog").ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : '<ifv:url name="tableColConvertPop"/>',
        contentType : "ajax",
        title : titleTxt,
        width : "600",
        close : 'tableMstPopClose'
    });
}

/**
 * 목록 페이지로 이동
 */
function goTableList() {
    qtjs.href('<ifv:url name="tableMstListNew"/>');
}

$(document).ready(function() {

    $.ifvmLnbSetting('tableMstListNew');

	$("#tableFormArea").ifvValidation();
	tableId = getParameter('tableId');

	/* 수정모드 테이블명 / 서비스명 바인딩*/
	if( tableId != null){
		tblType = getParameter('tblType');
		dbInformId = getParameter('dbId');
		oldTblNm = getParameter('tblNm');
		subjectAreaNm = getParameter('subjectAreaNm');
		subjectAreaNm = decodeURIComponent(subjectAreaNm);

		comboData();
		getTableList();  /* 테이블 정보 조회 */
		getTableLgcChk();

		$("#tableNm").val(getParameter('tblNm'));
		$("#tblType").val(getParameter('tblType'));
		$("#serviceId").val(getParameter('dbId'));
	}
	// 등록모드
	else {
		dbInformId = $("#serviceId").val();

		comboData();

		$("#tableColtNewBtn").attr("disabled",true);
		$("#tableColEditeBtn").attr("disabled",true);
		$("#tableColDelBtn").attr("disabled",true);
        $("#convertToDimensionBtn").attr("disabled", true);
        $("#convertToMeasureBtn").attr("disabled", true);

		$("#subjectAreaId").attr("disabled",true);
	}

	if (subjectAreaNm == 'Dimension' || subjectAreaNm == 'Aggregation') {
		$("#subjectAreaId").attr("disabled",true);
	}

	dbTypeCheck();

	getTableColList(); /* 컬럼 정보 조회 */
	/* 저장버튼 */
	$("#btnSave").click(function () {
		tblNm = $("#tableNm").val();
		dbInformId = $("#serviceId").val();

		if(tableId != null) modifyTableList();
		else setTableList();
	});

	/* 서비스명 변경*/
	$("#serviceId").change(function(e){
		dbInformId = $("#serviceId").val();
		getSubjectAreaComboList();
		dbTypeCheck();
	});

    //신규 클릭시
    $('#tableColtNewBtn').on('click', function(){
    	colId = null;
    	dbGubun = "I";
    	tableAddPopOpen();
    	$("#gridIdtableColListGrid").trigger('reloadGrid');
    });

    //수정 클릭시
    $('#tableColEditeBtn').on('click', function(){
    	if( colId == null ){
    		alert('<spring:message code="M00004" />');
    	} else {
	    	dbGubun = "U";
	    	tableAddPopOpen();
    	}
    });

    //삭제 클릭시
    $('#tableColDelBtn').on('click', function(){
    	removeTableCol();
    });

    /* 테이블 구분 - FACT일때만 주제영역 활성화 */
 	$("#tableType").change(function(e){
   		if($(this).val()=="FACT"){
   			$("#subjectAreaId").attr("disabled",false);
   			tableType = $("#tableType").val();
   			getSubjectAreaComboList();
   		} else {
   			$("#subjectAreaId").attr("disabled",true);
   			tableType = $("#tableType").val();
   			getSubjectAreaComboList();
   		}
	});

    // Dimension으로 일괄변환 버튼 클릭시
    $('#convertToDimensionBtn').on('click', function() {
        tableColConvertPopOpen("MEASURE", "DIMENSION");
    });

    // Measure로 일괄변환 버튼 클릭시
    $('#convertToMeasureBtn').on('click', function() {
        tableColConvertPopOpen("DIMENSION", "MEASURE");
    });

    //목록 버튼
    $('#tableMstListBtn').on('click', function() {
        goTableList();
    });
});

</script>

<script id="selectTmp" type="text/x-jquery-tmpl">
<option value="${'${'}id}">${'${'}text}</option>
</script>

<script id="dbTypeTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}markName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div class="page-title">
	<h1>
		<spring:message code="M01291" /> &gt; <spring:message code="M00136" />
	</h1>
</div>
<div>
<div class="page_btn_area">
	<div class="col-xs-7">
	</div>
	<div class="col-xs-5 searchbtn_r">
        <button id="btnSave" class="btn btn-sm" objCode="tableProperbtnSave_OBJ">
        	<i class="glyphicon glyphicon-check"></i>
			<spring:message code="M00137" />
        </button>
        <%-- 목록 버튼 --%>
        <button id="tableMstListBtn" class="btn btn-sm" objCode="tableMstListBtn_OBJ">
            <spring:message code="M00002" />
        </button>
    </div>
</div>
<div id='tableFormArea'>
<div class="well form-horizontal">
	<div class="row qt_border">
		<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="M00519" /></label>
		<div class="col-xs-4 control_content">
			<div class="input-group">
				<ifv:input id="tableNm" type="text" required="true"/>
			</div>
		</div>
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01440" /></label>
		<div class="col-xs-4 control_content">
			<div class="input-group">
				<ifv:input id="serviceId"  type="select" required="true"/>
			</div>
		</div>
	</div>
		<div class="row qt_border">
			<label class="col-sm-1 control-label"><spring:message code="M01573" /></label>
			<div class="col-sm-4 control_content">
				<div class="input-group" >
				<ifv:input type="text"  id="dpNm" maxLength="500" />
				</div>
			</div>
			<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="M01155" /></label>
			<div class="col-sm-4 control_content">
				<div class="input-group" >
				<ifv:input type="select" id="subjectAreaId" required="true"  />
				</div>
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-sm-1 control-label"><span class="asterisk">*</span><spring:message code="M01605" /></label>
			<div class="col-sm-4 control_content">
				<div class="input-group" >
				<ifv:input type="select" id="tableType" required="true"  />
				</div>
			</div>
			<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="M01583" /></label>
			<div class="col-sm-4 control_content">
				<div class="input-group" >
				<ifv:input type="text"  id="schmaNm" required="true" maxLength="50" />
				</div>
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-sm-1 control-label"><spring:message code="M01593" /></label>
			<div class="col-sm-4 control_content">
				<div class="input-group">
				<ifv:input type="text"  id="tblSpaceNm" maxLength="50" />
				</div>
			</div>

		</div>
    </div>
</div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area">
        <div class="col-xs-5">
            <span class="asterisk">※ <spring:message code="M01676" /></span>
        </div>
        <div class="col-xs-7 searchbtn_r">
            <%-- Dimension으로 일괄 변환 --%>
            <button class="btn btn-sm" id="convertToDimensionBtn" objCode="convertToDimensionBtn_OBJ">
                <spring:message code="M02251" />
            </button>
            <%-- Measure로 일괄 변환 --%>
            <button class="btn btn-sm" id="convertToMeasureBtn" objCode="convertToMeasureBtn_OBJ">
                <spring:message code="M02252" />
            </button>
            <%-- 신규 --%>
            <button class="btn btn-sm" id="tableColtNewBtn" objCode="tableColtNewBtn_OBJ"><i class="fa fa-plus"></i>
                 <spring:message code="M00136" />
            </button>
            <%-- 수정 --%>
            <button class="btn btn-sm" id="tableColEditeBtn" objCode="tableColEditeBtn_OBJ">
                <spring:message code="M00259" />
            </button>
            <%-- 삭제 --%>
            <button class="btn btn-sm" id="tableColDelBtn" objCode="tableColDelBtn_OBJ"><i class="fa fa-minus"></i>
                <spring:message code="M00165" />
            </button>
        </div>
    </div>
    <div id="tableColListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="dialog" class="popup_container"></div>
