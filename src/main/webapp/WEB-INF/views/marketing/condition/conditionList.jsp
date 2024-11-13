<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
$.ifvmLnbSetting('conditionList');

var conditionResultGrid;

var menuId = null;			//화면 아이디
var baseTableId = null;		//테이블 선택 시 해당 아이디를 저장
var targetTableId = null;	//대상 테이블 선택 시 해당 아이디 저장
var tableFlag = true;		//테이블 구분자 (기본테이블인지 대상 테이블인지 구분)

var targetColumFlag = null;	//어떤 테이블에 컬럼인지 구분 (기본테이블과 대상테이블)
var targetColId = null;		//선탣괸 타겟 컬럼 아이디
var comparedColId = null;	//선택된 비교대상 컬럼
var srcColId = null;		//선택된 소스 컬럼 아이디

var conditionGroupName = null;		//드랍다운 명
var conditionGroupCode = null;		//드랍다운 코드명

var condModifyFlag = false;	//신규 수정 구분

var conditionId = null;		//조건 아이디


//조건 삭제
function removeCondition(){
	var selectData = conditionResultGrid.getCheckedGridData()[0];
	
	if( selectData == null ){
		alert('<spring:message code="M00004" />');
	}else{
		$.ifvSyncPostJSON('<ifvm:action name="removeCondition"/>',{
			conditionId	: selectData.condId
		},function(result) {
			alert('<spring:message code="M00255" />');
			conditionResultGrid.requestData( { screenId :menuId } );
			//조건내용 초기화
			$("#conditionName").val("");
			$("#droupDownCode").val("");
			$("#baseTableName").val("");
			$("#srcColName").val("");
			$("#targetTableName").val("");
			$("#targetColName").val("");
			$("#comparedColName").val("");
			$("#dropDownListRow").show();
			$("#conditionType").val("DDL");
			$("#defaultCondition").val("0");
			
			//조건 변수 초기화
			 baseTableId = null;		//테이블 선택 시 해당 아이디를 저장
			 targetTableId = null;	//대상 테이블 선택 시 해당 아이디 저장
			 targetColId = null;		//선탣괸 타겟 컬럼 아이디
			 comparedColId = null;	//선택된 비교대상 컬럼
			 srcColId = null;		//선택된 소스 컬럼 아이디
			 conditionGroupName = null;		//드랍다운 명
			 conditionGroupCode = null;		//드랍다운 코드명
			 conditionId = null;		//조건 아이디
			 
			 $("#condContent").hide();
			 
		});
	}
	
	
	
}

//조건 상세 조회
function conditionDetail(obj){
	$.ifvSyncPostJSON('<ifvm:action name="getConditionDetail"/>',{
		conditionId : obj.condId
	},function(result) {
		$("#conditionName").val(result.condName);
		$("#conditionType").val(result.condType);
		
		$("#baseTableAlias").val(result.baseTblAlias);
		$("#targetTableAlias").val(result.comprTgtTblAlias);
		
		if(result.dropDownCD != null && result.dropDownCD != ''){
			$("#droupDownCode").val(result.dropDownCD);
			conditionGroupCode = result.dropDownCD;
		}
		
		if(result.condType != 'DDL'){
			$("#dropDownListRow").hide();
		}
		else{
			$("#dropDownListRow").show();
		}
		
		$("#defaultCondition").val(result.defaultCond);
		$("#baseTableName").val(result.baseTable);
		baseTableId = result.baseTableId;
		$("#targetTableName").val(result.tgTable);
		targetTableId = result.tgTableId;
		
		$("#targetColName").val(result.tgCol);
		targetColId = result.tgColId;
		$("#comparedColName").val(result.comTgCol);
		comparedColId = result.comTgColId;
		$("#srcColName").val(result.srcCol);
		srcColId = result.srcColId;
		
		condModifyFlag = true;
		conditionId = obj.condId;
	});
}

//공통코드 조회 - 조건유형
function conditionType(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_SEARCH_TYPE_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#conditionTypeTemplate").tmpl(result.rows);
		$("#conditionType").append(temp);
		
	});
}; 

//공통코드 조회 - 초기 조건
function defaultCondition(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'COMM_STATUS'
		, enableNA : true
	},function(result) {
		var temp = $("#defaultConditionTemplate").tmpl(result.rows);
		$("#defaultCondition").append(temp);
		
	});
}; 

//화면 조회 팝업 리스트 선택 결과
function screenListModalSelected(obj){
	$('#screenId').val(obj.menuName);
	menuId = obj.menuId;
	conditionResultGrid.requestData( { screenId : obj.menuId } );
	$('#condContent').hide();
}

//테이블 리스트 선택 결과
function tableListModalSelected(obj){
	
	if(tableFlag){
		$('#baseTableName').val(obj.tableName);
		srcColId = "";
		targetColId="";
		$("#targetColName").val("");
		$("#srcColName").val("");
		baseTableId = obj.id;
	}
	else{
		$('#targetTableName').val(obj.tableName);
		srcColId = "";
		comparedColId="";
		$("#srcColName").val("");
		$("#comparedColName").val("");
		
		targetTableId = obj.id;
	}
	
}

//컬럼 리스트 선택 결과
function colListModalSelected(obj){
	if(targetColumFlag == 'joinSrcCol'){
		srcColId = obj.id;	
		$("#srcColName").val(obj.colName);
		
	}
	else if(targetColumFlag == 'joinSrc'){
		targetColId = obj.id;	
		$("#targetColName").val(obj.colName);
	}
	else if(targetColumFlag == 'joinTarget'){
		comparedColId = obj.id;		
		$("#comparedColName").val(obj.colName);
	}
	else if(targetColumFlag == 'target'){
		srcColId = obj.id;	
		$("#srcColName").val(obj.colName);
	}
	else{
		//joinSrc
		targetColId = obj.id;	
		$("#targetColName").val(obj.colName);
		
	}
}

//조회 결과 그리드
function conditionResultGrid(){
	
	
	var jqGridOption = {
			serializeGridData : function( data ){
				//data.screenId = '55555yza6r1pgw5hedfq0010';
				return data;
			},
			onSelectRow : function (data) {
				conditionGroupCode = null;
				conditionDetail(data);
				$('#condContent').show();
			},
			url:'<ifvm:action name="getConditionList"/>',
		    colNames:['<spring:message code="M00516"/>', 
		              '<spring:message code="M00517"/>',
		              '<spring:message code="M00518"/>', 
		              '<spring:message code="M00519"/>', 
		              '<spring:message code="M00520"/>', 
		              '<spring:message code="M00521"/>',
		              '<spring:message code="M00522"/>',
		              '<spring:message code="M00523"/>',
		              '<spring:message code="M00525"/>',
		              'condId'],
		    colModel:[
		  	        {name:'menuName',index:'p.pgm_nm', resizable : false},
			        {name:'condName',index:'mcs.srch_cond_dp_val', resizable : false},
			        {name:'condType',index:'cc.mark_name', resizable : false},
			        {name:'tableName',index:'stl.tbl_eng_nm', resizable : false},
			        {name:'tgtTable',index:'stl2.tbl_eng_nm', resizable : false},
			        {name:'tgtClm',index:'scl.col_eng_nm', resizable : false},
			        {name:'joinSrcClm',index:'scl2.col_eng_nm', resizable : false},
			        {name:'joinTgtClm',index:'scl3.col_eng_nm', resizable : false},
			        {name:'defaultCond',index:'cc2.mark_name', resizable : false},
			        {name:'condId', hidden : true}
			    ],
		    //autowidth:true,
		    ajaxGridOptions : {async : false},
		    radio : true,
		    sortname: 'mcs.create_date',
			sortorder: "desc",
		    tempId : 'ifvGridOriginTemplete',
		};
	conditionResultGrid = $("#conditionResultGrid").ifvGrid({ jqGridOption : jqGridOption });
	}
	

/* 팝업 닫기 */
function popupClose(){
	$('#popupContainer').ejDialog('destroy');
}

/* 테이블 팝업 생성 */
function tablePopOpen(){
	$("#popupContainer").ejDialog({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="MKTTableListPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M00533"/>',
        width: 600,
        close : 'popupClose',
        open : function(){
        	new ifvm.PopupCenter({
        		popupDivId : 'popupContainer'
        	});
        }
    });
}

/* 컬럼 팝업 생성 */
function columnPopOpen(){
	$("#popupContainer").ejDialog({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="MKTColumnListPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M00536"/>',
        width: 600,
        close : 'popupClose',
        open : function(){
        	new ifvm.PopupCenter({
        		popupDivId : 'popupContainer'
        	});
        }
    });
}

/* 드롭다운 목록 코드 활성 여부 */
function dropDownListCode(){
	
	$("#droupDownCode").val("");
	
	var typeVal = $('#conditionType').val();
	
	if(typeVal == 'DDL'){
		$('#dropDownListRow').show();
	} else {
		$('#dropDownListRow').hide();
	}
}

$(document).ready(function(){
	
	$("#conditionFormArea").ifvValidation();
	
	$('#dropDownListRow').show();
	
	//조건상세 하이드 하며 클릭 시 보이도록 설정
	$('#condContent').hide();
	
	//조건 조회
	conditionResultGrid();
	
	//조건 상세 조건 유형 컴코드 조회
	conditionType(); 
	
	//조건 상세 기본값 조회
	defaultCondition();
	
	//삭제 버튼 클릭
	$("#removeCondition").on('click', function(){
		removeCondition();
	});
	
	//저장 버튼 클릭
	$("#saveBtn").on('click', function(){
		//수정
		if(condModifyFlag == true){
			
			validation = $("#conditionFormArea").ifvValidation();
			
			if(validation.confirm()){
			
				var obj = {};
				obj.conditionId = conditionId;
				obj.condName = $("#conditionName").val();
				obj.condType = $("#conditionType").val();
				obj.dropDownCD = conditionGroupCode;
				obj.defaultCond = $("#defaultCondition").val();
				obj.baseTable = baseTableId;
				obj.tgTable = targetTableId;
				
				
				obj.tgCol = targetColId;
				obj.comTgCol = comparedColId;
				obj.srcCol = srcColId;
				
				
				obj.accountId = $.ifvmGetUserInfo().accountId;
				obj.pageId = menuId;
				obj.baseTblAlias = $("#baseTableAlias").val();
				obj.comprTgtTblAlias = $("#targetTableAlias").val();
				
				
				$.ifvSyncPostJSON('<ifvm:action name="modifyCondition"/>',obj
				,function(result) {
					alert('<spring:message code="M00106"/>');
					conditionResultGrid.requestData( { screenId :menuId } );
				});
			}

		}
		else{	//신규
			
			validation = $("#conditionFormArea").ifvValidation();
			
			if(validation.confirm()){
				
			
				var obj = {};
			
				obj.condName = $("#conditionName").val();
				obj.condType = $("#conditionType").val();
				obj.dropDownCD = conditionGroupCode;
				obj.defaultCond = $("#defaultCondition").val();
				obj.baseTable = baseTableId;
				obj.tgTable = targetTableId;
				obj.tgCol = targetColId;
				obj.comTgCol = comparedColId;
				obj.srcCol = srcColId;
				obj.accountId = $.ifvmGetUserInfo().accountId;
				obj.pageId = menuId;
				obj.baseTblAlias = $("#baseTableAlias").val();
				obj.comprTgtTblAlias = $("#targetTableAlias").val();
				
				
				$.ifvSyncPostJSON('<ifvm:action name="setCondition"/>',obj
				,function(result) {
					alert('<spring:message code="M00006"/>');
					conditionResultGrid.requestData( { screenId :menuId } );
					condModifyFlag = true;
					conditionId = result.message;
				});
			}
			
		}
		
	});
	
	//신규 버튼 클릭
	$("#newCondition").on('click', function(){
		
		//화면을 선택 안했을 경우 분기
		if($('#screenId').val() != null && $('#screenId').val() != ''){
			$('#condContent').show();
			
			//조건내용 초기화
			$("#conditionName").val("");
			$("#droupDownCode").val("");
			$("#baseTableName").val("");
			$("#srcColName").val("");
			$("#targetTableName").val("");
			$("#targetColName").val("");
			$("#comparedColName").val("");
			$("#dropDownListRow").show();
			$("#conditionType").val("DDL");
			$("#defaultCondition").val("0");
			$("#baseTableAlias").val("");
			$("#targetTableAlias").val("");
			
			//조건 변수 초기화
			 baseTableId = null;		//테이블 선택 시 해당 아이디를 저장
			 targetTableId = null;	//대상 테이블 선택 시 해당 아이디 저장
			 targetColId = null;		//선탣괸 타겟 컬럼 아이디
			 comparedColId = null;	//선택된 비교대상 컬럼
			 srcColId = null;		//선택된 소스 컬럼 아이디
			 conditionGroupName = null;		//드랍다운 명
			 conditionGroupCode = null;		//드랍다운 코드명
			 conditionId = null;		//조건 아이디
			

			//신규 플래그값 저장
			condModifyFlag = false;
		}
		else{
			alert('<spring:message code="M00549"/>');
		}
	});
	
	
	/* 화면 선택 */
	$('#conditionScreenBtn').on('click', function(){
		$("#popupContainer").ejDialog({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="MKTScreenListPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M00528"/>',
	        width: 600,
	        close : 'popupClose',
        	open : function(){
        		new ifvm.PopupCenter({
            		popupDivId : 'popupContainer'
            	});
	        }
	    });
	});
	
	/* 드롭다운 목록 코드 */
	$('#dropDownListCode').on('click', function(){
		
		$("#popupContainer").ejDialog({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="MKTConditionListPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M00542"/>',
	        width: 600,
	        close : 'popupClose',
	        open : function(){
	        	new ifvm.PopupCenter({
	        		popupDivId : 'popupContainer'
	        	});
	        }
	    });
	});
	
	/* 테이블 팝업 */
	$('#basicTableBtn').on('click', function(){
		tableFlag = true;
		tablePopOpen();
	});
	$('#comparedTargetTableBtn').on('click', function(){
		tableFlag = false;
		tablePopOpen();
	});
	
	/* 컬럼 팝업 */
	
	//대상 컬럼 버튼 클릭 시 수행
	$('#sourceColumnBtn').on('click', function(){
		targetColumFlag = 'joinSrc';
		columnPopOpen();
	});
	$('#comparedTargetColumnBtn').on('click', function(){
		targetColumFlag = 'joinTarget';
		columnPopOpen();
	});
	
	//이름잘못됨 소스컬럼 버튼 클릭 시 수행
	$('#targetColumnBtn').on('click', function(){
		//기본테이블이 있을 경우 기본 테이블로 컬럼 조회 하며 비교 대상 테이블이 있을 경우 비교 대상 테이블 컬럼 조회
		/* if($("#baseTableName").val() != null && $("#baseTableName").val().length > 0){
			targetColumFlag = 'joinSrc';
		} */
		
		targetColumFlag = 'target';
		
		if($("#targetTableName").val() != null && $("#targetTableName").val().length > 0){
			targetColumFlag = 'joinSrcCol';
		}
		
		columnPopOpen();
	});
	
	/* 조건 유형 변경시 */
	$('#conditionType').on('change', function(){
		dropDownListCode();
	});
	
	
	
});
</script>
 
<script id="conditionTypeTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="defaultConditionTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<style>
#dropDownListRow{display:none;}
</style>

<div class="page-title">
	<h1>
		<spring:message code="M00513"/>
	</h1>
</div>

<!-- 조회 조건 -->
<div>
	<div class="page_btn_area">
		<div class="col-xs-12">
			<span><spring:message code="M00281"/></span>
		</div>
	</div>
	<div class="well form-horizontal">
		<div class="row">
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00515"/></label>	
			<div class="col-xs-3 control_content">
				<div class="input-group">
					<ifvm:input type="text" id="screenId" disabled="true" required="true" />
					<span class="input-group-addon" id="conditionScreenBtn">
						<a><i class="fa fa-search"></i></a>
					</span>
				</div>
			</div>
		</div> 
	</div>
</div>

<!-- 조회 결과 -->
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00277"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="newCondition">         
				<i class="fa fa-plus"></i>    
				<spring:message code="M00274"/>
			</button>
			<button class="btn btn-sm" id="removeCondition">         
				<i class="fa fa-minus"></i>    
				<spring:message code="M00275"/>
			</button> 
		</div>
	</div>
	<div id="conditionResultGrid" class="grid_bd0"></div>
</div>

<!-- 조건 내용 -->
<div id="conditionFormArea">

<div id="condContent">
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00514"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="saveBtn">         
				<i class="glyphicon glyphicon-check"></i>    
				<spring:message code="M00280"/>
			</button>  
		</div>
	</div>
	
	<div class="well form-horizontal underline" id="" >
		<div class="row  qt_border">
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00517"/></label>	
			<div class="col-xs-3 control_content">
				<ifvm:input type="text" id="conditionName" required="true"/>
			</div>
			<label class="col-xs-3 control-label"><spring:message code="M00518"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:input type="select" id="conditionType" />
			</div>
		</div> 
		
		<div class="row qt_border" id="dropDownListRow">
			<label class="col-xs-2 control-label"><spring:message code="M00527"/></label>
			<div class="col-xs-9 control_content">
				<div class="input-group">
					<ifvm:input type="text" id="droupDownCode" disabled="true" />
					<span class="input-group-addon" id="dropDownListCode">
						<a><i class="fa fa-search"></i></a>
					</span>
				</div>
			</div>
			
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-2 control-label"><spring:message code="M00525"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:input type="select" id="defaultCondition"/>
			</div>
			
			<label class="col-xs-3 control-label"><spring:message code="M00526"/></label>
			<div class="col-xs-3 control_content">
				<div class="input-group">
					<ifvm:input type="text" disabled="true" id="baseTableName"/>
					<span class="input-group-addon" id="basicTableBtn">
						<a><i class="fa fa-search"></i></a>
					</span>
				</div>
			</div>
			
		</div>
		<div class="row qt_border">
			
			<label class="col-xs-2 control-label"><spring:message code="M00520"/></label>
			<div class="col-xs-3 control_content">
				<div class="input-group">
					<ifvm:input type="text" id="targetTableName" disabled="true"  />
					<span class="input-group-addon" id="comparedTargetTableBtn">
						<a><i class="fa fa-search"></i></a>
					</span>
				</div>
			</div>
			
			
			<label class="col-xs-3 control-label"><spring:message code="M00523"/></label>
			<div class="col-xs-3 control_content">
				<div class="input-group">
					<ifvm:input type="text" id="targetColName" disabled="true"  />
					<span class="input-group-addon" id="sourceColumnBtn">
						<a><i class="fa fa-search"></i></a>
					</span>
				</div>
			</div>
			
		</div>
		
		<div class="row">
			<label class="col-xs-2 control-label"><spring:message code="M00521"/></label>
			<div class="col-xs-3 control_content">
				<div class="input-group">
					<ifvm:input type="text" id="comparedColName" disabled="true"  />
					<span class="input-group-addon" id="comparedTargetColumnBtn">
						<a><i class="fa fa-search"></i></a>
					</span>
				</div>
			</div>
			<label class="col-xs-3 control-label"><spring:message code="M00522"/></label>
			<div class="col-xs-3 control_content">
				<div class="input-group">
					<ifvm:input type="text" id="srcColName" disabled="true"  />
					<span class="input-group-addon" id="targetColumnBtn">
						<a><i class="fa fa-search"></i></a>
					</span>
				</div>
			</div>
		</div>
		
		<div class="row">
			<label class="col-xs-2 control-label"><spring:message code="M00550"/></label>
			<div class="col-xs-3 control_content">
				<div class="input-group">
					<ifvm:input type="text" id="baseTableAlias"  />
				</div>
			</div>
			<label class="col-xs-3 control-label"><spring:message code="M00551"/></label>
			<div class="col-xs-3 control_content">
				<div class="input-group">
					<ifvm:input type="text" id="targetTableAlias"  />
				</div>
			</div>
		</div>
		
	</div>
</div>

</div>

<div id="popupContainer" class="popup_container"></div><!-- 팝업 -->
