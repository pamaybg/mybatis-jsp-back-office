<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var tableColListGrid;
var colId = null;
var dbGubun = null;
var tblId = null;
var tableNmchk = false;
var tableDelchk = false;

/* 테이블구분 / 주제영역 호출 */
function comboData(){
 	getTblTypeComboList();
 	getSubjectAreaComboList();
}

function getTblTypeComboList(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{ groupCode : 'ANL_TABLE_TYPE_CD', enableNA : true
	},function(result) {
		var temp = $("#dbTypeTemplate").tmpl(result.rows);
		$("#tableType").append(temp);
		if(tableId == null){
			tableType = $("#tableType").val();
		}
	});
}; 

function getSubjectAreaComboList(){
	$.ifvSyncPostJSON('<ifvm:action name="getSubjectAreaComboList_KPR"/>', { dbInformId : dbInformId , tableType : tableType
	}, function(result) {
		var temp = $("#selectTmp").tmpl(result.rows);
		$("#subjectAreaId").empty();
		$("#subjectAreaId").append(temp);
	});
}

//타겟 레벨 조회
function getTableList(){
		$.ifvSyncPostJSON('<ifvm:action name="getTableList_KPR"/>',{tableId : tableId}
		,function(result) {
			$("#dpNm").val(result.dpNm);
			$("#tableType").val(result.tblTypeCd);
			$("#subjectAreaId").val(result.subjectAreaId);
			$("#tblSpaceNm").val(result.tblSpaceNm);
			$("#schmaNm").val(result.schmaNm);
			
			$("#tableColtNewBtn").attr("disabled",false);
			$("#tableColEditeBtn").attr("disabled",false);
			$("#tableColDelBtn").attr("disabled",false);
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
			$.ifvSyncPostJSON('<ifvm:action name="tableNmChk"/>',obj
			,function(result) {
				if(result.cnt > 0){
					alert('<spring:message code="M01609"/>');
					tableNmchk = true;
				}
			});
		}
		if(tableNmchk == false){
			$.ifvSyncPostJSON('<ifvm:action name="editTableList_KPR"/>',obj
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
		$.ifvSyncPostJSON('<ifvm:action name="tableNmChk"/>',obj
		,function(result) {
			if(result.cnt > 0){
				alert('<spring:message code="M01609"/>');
				tableNmchk = true;
			}
		});
		if(tableNmchk == false){
			$.ifvSyncPostJSON('<ifvm:action name="setTableList_KPR"/>',obj
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
	var selectData = tableColListGrid.getCheckedGridData();
	delChk = false;
	
	if( selectData.length == 0 ){
		alert('<spring:message code="M00004" />');
	}else{
		if(confirm('<spring:message code="M00296"/>')){
			var colIdList = [];
			
			for(var i=0; i<selectData.length; i++){
				colIdList.push(selectData[i].colId);
			}
 			$.ifvSyncPostJSON('<ifvm:action name="tableAddColDelChk"/>',{
				colId1 : colIdList, tableId : tableId
		    },function(result) {
				if(result.delFlag == "1"){
					alert('<spring:message code="M01552"/>');
					tableDelchk = true;
				}			
			});
			if(tableDelchk == false){ 
				$.ifvSyncPostJSON('<ifvm:action name="removeTableAddColList"/>',{
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
    var jqGridOption = {
        ondblClickRow : function(data){
           	colId = data;
           	dbGubun = "U";
           	tableAddPopOpen();
        },
        onSelectRow : function (data) {
        	var selectData = tableColListGrid.getCheckedGridData();
    		for(var i=0; i<selectData.length; i++){
    			colId  = selectData[i].colId;
			}
        },
   		serializeGridData : function( data ){
   			data.tableId = tableId;
   		},		
   		loadComplete : function(obj){
   		},
        url : '<ifvm:action name="getTableColList"/>',
        colNames:[ 
                  '<spring:message code="M01164"/>',
	              '<spring:message code="M01202"/>',
	              '<spring:message code="M01571"/>',
	              '<spring:message code="M00444"/>',
	              '<spring:message code="M01564"/>',
	              '<spring:message code="M01574"/>',
	              '<spring:message code="M01602"/>',
	              '<spring:message code="M01573"/>',
	              '<spring:message code="M01572"/>',
	              'id'
                 ],
        colModel:[
            { name:'colNm', index:'c.col_nm',  resizable : false },
            { name:'pkYn', index:'c.pk_yn', align: 'center', resizable : false },
            { name:'dataTypeCd', index:'c1.mark_name',  resizable : false },
            { name:'len', index:'c.len',  align: 'right', resizable : false },
            { name:'nullYn', index:'c.null_yn', align: 'center',  resizable : false },
            { name:'deftVal', index:'c.deft_val',  resizable : false },
            { name:'seq', index:'c.seq',  align: 'right', resizable : false },
            { name:'dpNm', index:'c.dp_nm',  resizable : false },
            { name:'colTypeCd', index:'c2.mark_name',  resizable : false },
            { name:'colId', index:'c.id', hidden : true } 
        ],
        radio:true,
        sortname: 'c.seq',
        sortorder: "asc",
        tempId : 'ifvGridOriginTemplete'
    };
    
    tableColListGrid = $("#tableColListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

// 고급설정 팝업 열기
function tableAdvancePopOpen() {
    $("#dialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tableAdvancePop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01604" />',
        width: 400,
        close : 'tableMstPopClose'
    });
}

// 테이블생성 팝업 열기
function tableCreatPopOpen() {
	tableNm = $("#tableNm").val();
	dpNm = $("#dpNm").val();
	tblSpaceNm = $("#tblSpaceNm").val();
	schmaNm = $("#schmaNm").val();
	
    $("#dialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tableCreatPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01607" />',
        width: 400,
        close : 'tableMstPopClose'
    });
}

// 컬럼추가 팝업 열기
function tableAddPopOpen() {
    $("#dialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tableAddColPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01603" />',
        width: 500,
        close : 'tableMstPopClose'
    });
}

$(document).ready(function() {
	$("#tableFormArea").ifvValidation();
	comboData();
	dbTypeCheck(); // 오라클인경우 고급설정 활성화
	if(tableId != null){
		getTableList();  /* 테이블 정보 조회 */
		
		$("#tableNm").attr("disabled",true);
		$("#serviceId").attr("disabled",true);
	}else{
		$("#tableColtNewBtn").attr("disabled",true);
		$("#tableColEditeBtn").attr("disabled",true);
		$("#tableColDelBtn").attr("disabled",true);
		
		$("#subjectAreaId").attr("disabled",true);
		$("#tableNm").attr("disabled",false);
		$("#serviceId").attr("disabled",false);
	}

	if(subjectAreaNm == 'Dimension' || subjectAreaNm == 'Aggregation'){
		$("#subjectAreaId").attr("disabled",true);
	}
	
	getTableColList(); /* 컬럼 정보 조회 */
	 
    //고급설정
    $('#advanceBtn').on('click', function(){
    	tableAdvancePopOpen();
    });
    
    //테이블생성
    $("#tableCreatBtn").on('click', function(){
    	tableCreatPopOpen();
    });
    
    //신규 클릭시
    $('#tableColtNewBtn').on('click', function(){
    	colId = null;
    	dbGubun = "I";
    	tableAddPopOpen();
    });
    
    //수정 클릭시
    $('#tableColEditeBtn').on('click', function(){
    	dbGubun = "U";
    	tableAddPopOpen();
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
   		}else{
   			$("#subjectAreaId").attr("disabled",true);
   			tableType = $("#tableType").val();
   			getSubjectAreaComboList();
   		}
	});

});

</script>

<script id="dbTypeTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}markName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="selectTmp" type="text/x-jquery-tmpl">
<option value="${'${'}id}">${'${'}text}</option>
</script>


<%-- <div class="page_btn_area">
    <div class="col-xs-7">
    </div>
    <div class="col-xs-5 searchbtn_r">
        <button class="btn btn-sm" id="advanceBtn">
             <spring:message code="M01570" />
        </button> 
        <button class="btn btn-sm" id="tableCreatBtn">
            <spring:message code="M01607" />
        </button> 
    </div>
</div> --%>

<div id='tableFormArea'>
<!-- 	<div class="well"> -->
		<div class="form-horizontal">		
		<div class="row qt_border"></div>	
		<div class="row qt_border">
			<label class="col-sm-2 control-label"><spring:message code="M01573" /></label>
			<div class="col-sm-5 control_content">
				<div class="input-group" >
				<ifvm:input type="text"  id="dpNm" maxLength="500" />
				</div>
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-sm-2 control-label"><spring:message code="M01605" /></label>
			<div class="col-sm-5 control_content">
				<div class="input-group" >
				<ifvm:input type="select" id="tableType"  />
				</div>
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-sm-2 control-label"><spring:message code="M01155" /></label>
			<div class="col-sm-5 control_content">
				<div class="input-group" >
				<ifvm:input type="select" id="subjectAreaId"  />
				</div>
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-sm-2 control-label"><spring:message code="M01593" /></label>
			<div class="col-sm-5 control_content">
				<div class="input-group">
				<ifvm:input type="text"  id="tblSpaceNm" maxLength="50" />
				</div>
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-sm-2 control-label"><spring:message code="M01583" /></label>
			<div class="col-sm-5 control_content">
				<div class="input-group" >
				<ifvm:input type="text"  id="schmaNm" maxLength="50" />
				</div>
			</div>
		</div>
		</div>
<!-- 	</div> -->
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="tableColtNewBtn"><i class="fa fa-plus"></i>
                 <spring:message code="M00136" />
            </button> 
            <button class="btn btn-sm" id="tableColEditeBtn">
                <spring:message code="M00259" />
            </button> 
            <button class="btn btn-sm" id="tableColDelBtn"><i class="fa fa-minus"></i>
                <spring:message code="M00165" />
            </button> 
        </div>
    </div>
    <div id="tableColListGrid" class="white_bg grid_bd0"></div>     
</div>
