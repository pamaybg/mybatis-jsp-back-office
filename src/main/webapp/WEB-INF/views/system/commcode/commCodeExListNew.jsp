<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

/*****************
 *	* 목차 *
 * 1. 변수 선언부
 * 2. 화면 로드 시 처리 함수
 * 3. 그리드 처리 함수
 * 4. 팝업 화면 관련 처리 함수
 * 5. 삭제 관련 처리 함수
 ******************/

/************************************************************ 1. 변수 선언부 **************************************************************************/

// 그리드를 담을 변수
var commCodeExGroupList;			// 그룹코드 리스트 그리드
var commCodeExCodeList;				// 코드리스트 그리드

// 팝업창을 담을 변수
var objCommCodeExPopup;				// 코드 등록 및 수정을 할 디테일 화면 팝업창
var objCommCodeExGroupNamePopup;	// 그룹코드 변경을 위한 팝업창

// 현재 선택된 데이터
var currentGroupCodeData;			// 그룹코드의 데이터 - 그룹 코드 선택 시 값 세팅, 그룹 코드 검색 시 초기화
var currentRowData;					// 코드의 데이터 - Detail 화면에서 사용 :: Detail Pop open 시 값 세팅, Pop Close 시, 초기화

// 제어관련 플래그
var editOperatingFlag;				// 작업할 내용의 상태값 :: NEW_GROUP - 신규 그룹, NEW_CODE - 신규 코드, MODIFY_CODE - 코드 수정 (, MODIFY_GROUP_NAME - 그룹명 수정, DEL_GROUP - 그룹코드 삭제, DEL_CODE - 코드 삭제)
var removeTransactionFlag;			// 다건 삭제 처리 시, 트렌젝션 관리에 필요
var langType = "ko";
var countryType = "KR";

var rowData = null;
var dtlRowData = null;
var CheckBox = null;

/************************************************************ 변수 선언부 END **************************************************************************/



/************************************************************ 2. 화면 로드 시 처리 함수 **********************************************************************/

$(document).ready(function() {
	getCommonCode();			//언어에 대한 셀렉트박스 조회
    setCommCodeExGroupGrid();	// 초기 그리드 세팅

    $.fn.ifvmSetSelectOptionCommCode("searchType", "COM_CATEGORY_TYPE_CD", null, null, false);
    	
    $.ifvEnterSetting(["#groupCode", "#groupName", "#codeName", "#markName", "#searchType"], commCodeExGroupSearch); // 엔터키 입력 시, 검색을 시키기 위함

    $('#commCodeSearch').on('click', function(){
    	commCodeExGroupSearch();
    });

    $('#delCommCodeGroup').on('click', function(){	
    	removeGroupCode();
    });

    $('#delCommCode').on('click', function(){
    	removeCommCodeItems();
    });

    $('#addCommCodeGroup').on('click', function(){
    	langType = "ko";
    	countryType = "KR";
    	commCodeExDetailPopupOpen("NEW_GROUP");
    });

    $('#addCommCode').on('click', function(){
    	commCodeExDetailPopupOpen_tab("NEW_CODE");
    });

 	// 그룹 코드 수정
    $('#modifyCommCodeGroup').on('click',function(){
    	if(currentGroupCodeData == null){
    		alert('<spring:message code="I00728"/>');
    	}else{
    		commCodeExGroupNamePopupOpen();
    	}
    });

    //그룹 코드 상세 수정
    $('#modifyCommCode').on('click',function(){
    	if(dtlRowData == null){
    		alert('<spring:message code="I00728"/>');
    	}else{
    		commCodeExDetailPopupOpen("MODIFY_CODE", dtlRowData);
    	}
    });
    
    $('#reApplyCache').on('click',function(){
    	reApplyServerCommCode();
    });

});

// 언어코드 콤보박스
function getCommonCode() {
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'LANG_TYPE'
		,schemas : 'com'
		, enableNA : true
	}, function(result) {
		for (var i=0; i<result.rows.length; i++) {
			if (result.rows[i].codeName != "NA") {
				result.rows[i].codeName = result.rows[i].codeName.toLowerCase();
			}
		}
		
		var temp = $("#selectLangTemplate").tmpl(result.rows);
		$("#selectLang").append(temp);
	});
	$("#selectLang").val('NA');
}

/************************************************************ 화면 로드 시 처리 함수 END **********************************************************************/




/************************************************************ 3. 그리드 처리 함수 **********************************************************************/
// 그룹코드 리스트 그리드를 그리는 함수
function setCommCodeExGroupGrid() {
    var ejGridOption = {
/*     		recordDoubleClick : function(args){
           		var rowData = args.data;
           		currentGroupCodeData = rowData;
           		commCodeExGroupNamePopupOpen();
           	}, */
           	rowSelected : function (args) {
            	currentGroupCodeData = args.data;
            	setCommCodeExCodeGrid(args.data);
            	langType = args.data.lang;
            	countryType = args.data.country;
            	rowData = args.data;
           	},
          	serializeGridData : function( data ){
          		data.strSchema	= $("#strSchema").val();
          		data.type	= $("#searchType").val();
          		data.groupCode	= $("#groupCode").val();
          		data.groupName	= $("#groupName").val();
          		data.selectLang	= $("#selectLang").val();
          		data.codeName	= $("#codeName").val();
          		data.markName	= $("#markName").val();
           	},
//            	loadComplete : function(obj){
//            	},
            dataUrl : '<ifvm:action name="getCommCodeExGroupList"/>',
            columns:[
            	  {
	          		  field : 'typeMarkNm', headerText : '<spring:message code="LO2683"/>',  textAlign : 'center',
	          		  customAttributes : {index : 'type' }
	          	  },{
	          		  field : 'groupCode', headerText : '<spring:message code="M00241"/>',
	          		  customAttributes : {searchable : true} //
	          	  },{
	          		  field : 'groupName', headerText : '<spring:message code="M00238"/>', 
	          		  customAttributes : { searchable : true} //
	          	  },{
	          		  field : 'lang', headerText : '<spring:message code="M00237"/>', textAlign : 'center',
	          		  customAttributes : {searchable : true} //
	          	  }
            ],
            requestGridData : {
	        	  nd   : new Date().getTime(),
	        	  rows : 10,
	        	  sidx : 'groupCode',
	        	  sord : 'ASC',
	        	  _search : false
	          },
	        radio: true,
            rowList:[5],
            tempId : 'commCodeExGroupCodeGrid'
        };

    commCodeExGroupList = $("#commCodeExGroupGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//코드 리스트 그리드를 그리는 함수
function setCommCodeExCodeGrid(rowData) {
    var ejGridOption = {
/*     		recordDoubleClick : function(args){
           		var rowData = args.data;
           		commCodeExDetailPopupOpen("MODIFY_CODE", rowData);
           	}, */
           	rowSelected : function (args) {
           		dtlRowData = args.data;
           		//CheckBox = args.data.chashYn;
            },
          	serializeGridData : function( data ){
          		data.strSchema	= $("#strSchema").val();
          		data.type	= $("#searchType").val();
          		data.selectLang	= rowData.lang;
          		data.groupCode	= rowData.groupCode;
           	},
           	recordDoubleClick : function(args) {
           		commCodeExDetailPopupOpen("MODIFY_CODE", dtlRowData);
          	},
//            	loadComplete : function(obj){
//            	},
            dataUrl : '<ifvm:action name="getCommCodeExCodeList"/>',
            columns:[
            	{
	          		  field : 'seq', headerText : 'SEQ', textAlign : 'center',
	          		  customAttributes : {
	          			  index : 'A.SEQ' } //
	          	  },{
	          		  field : 'codeName', headerText : '코드값',
	          		  customAttributes : {
	          			  index : 'A.CODE_NAME' } //
	          	  },{
	          		  field : 'markName', headerText : '표시명', textAlign : 'center',
	          		  customAttributes : {
	          			  index : 'A.MARK_NAME' } //
	          	  },{
	          		  field : 'markCode', headerText : '표시코드값',
	          		  customAttributes : {
	          			  index : 'A.MARK_CODE' } //
	          	  },{
	          		  field : 'parCodeNm', headerText : '상위코드값', // 상위코드 ID -> 상위코드값
	          		  customAttributes : {
	          			  index : 'B.CODE_NAME' } //
	          	  },{
	          		  field : 'parMarkNm', headerText : '상위코드 표시명', textAlign: 'center',
	          		  customAttributes : {
	          			  index : 'B.MARK_NAME' } // 새로 추가한 칼럼 '상위코드 표시명'(2020.12.10)
	          	  },{
	          		  field : 'lang', headerText : '<spring:message code="M00237"/>', textAlign : 'center',
	          		  customAttributes : {
	          			  index : 'A.LANG' } //
	          	  }/* ,{
	          		  field : 'typeMarkNm', headerText : '<spring:message code="LO2683"/>',  textAlign : 'center',
	          		  customAttributes : {
	          			  index : 'A.TYPE' } //
	          	  },{
	          		  field : 'attrib01', headerText : 'ATTRIB01',
	          		  customAttributes : {
	          			  index : 'A.ATTRIB01' } //
	          	  },{
	          		  field : 'attrib02', headerText : 'ATTRIB02',
	          		  customAttributes : {
	          			  index : 'A.ATTRIB02' } //
	          	  },{
	          		  field : 'attrib03', headerText : 'ATTRIB03',
	          		  customAttributes : {
	          			  index : 'A.ATTRIB03' } //
	          	  },{
	          		  field : 'attrib04', headerText : 'ATTRIB04',
	          		  customAttributes : {
	          			  index : 'A.ATTRIB04' } //
	          	  },{
	          		  field : 'attrib05', headerText : 'ATTRIB05',
	          		  customAttributes : {
	          			  index : 'A.ATTRIB05' } //
	          	  } */,{
	          		  field : 'chashYn', headerText : 'ATTRIB05', visible : false,
	          		  customAttributes : {
	          			  index : 'A.CHASH_YN ' } //
	          	  },{
	          		  field : 'id', headerText : 'id', visible : false ,
	          		  customAttributes : {
	          			  index : 'A.ID' } //
	          	  },{
	          		  field : 'groupCode', headerText : 'groupCode',visible : false ,
	          		  customAttributes : {
	          			  index : 'A.GROUP_CODE'} //
	          	  },{
	          		  field : 'groupName', headerText : 'groupName',visible : false ,
	          		  customAttributes : {
	          			  index : 'A.GROUP_NAME' } //
	          	  },{
	          		  field : 'createBy', headerText : 'createBy', visible : false ,
	          		  customAttributes : {
	          			  index : 'A.CREATE_BY' } //
	          	  },{
	          		  field : 'modifyBy', headerText : 'modofyBy', visible : false ,
	          		  customAttributes : {
	          			  index : 'A.MODIFY_BY' } //
	          	  },{
	          		  field : 'createDate', headerText : 'createDate',visible : false ,
	          		  customAttributes : {
	          			  index : 'A.CREATE_DATE' } //
	          	  },{
	          		  field : 'modifyDate', headerText : 'modifyDate',visible : false ,
	          		  customAttributes : {
	          			  index : 'A.MODIFY_DATE' } //
	          	  },{
	          		  field : 'parCodeId', headerText : 'parCodeId',visible : false ,
	          		  customAttributes : {
	          			  index : 'A.PAR_CODE_ID' } //
	          	  }
            ],
            requestGridData : {
	        	  nd   : new Date().getTime(),
	        	  rows : 10,
	        	  sidx : '6',
	        	  sord : 'ASC',
	        	  _search : false
	          },
	        rowList : [10,25,50,100],
	        radio: true,
	        multiselect: true,
            tempId : 'ifvGridNotSearchTemplete '
        };

    commCodeExCodeList = $("#commCodeExCodeGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//조건에 따라 화면을 갱신시키는 함수
function reflashCommCodeExList() {
	/* commCodeExGroupSearch();
	var newGroupCode = $("#validationArea #groupCode").val();
	if($.fn.ifvmIsNotEmpty(newGroupCode)) {
		$("#groupCode").val(newGroupCode);
		if(editOperatingFlag == "NEW_CODE" || editOperatingFlag == "MODIFY_CODE") {
			$.fn.ifvmSubmitSearchCondition("commCodeExGroupGrid", setCommCodeExGroupGrid);
			if($.fn.ifvmIsNotEmpty(currentGroupCodeData)) {
				setCommCodeExCodeGrid(currentGroupCodeData);
			}
		} else {
			commCodeExGroupSearch();
		}
	} else {
		if($.fn.ifvmIsNotEmpty(currentGroupCodeData)) {
			$("#groupCode").val(currentGroupCodeData.groupCode);
			commCodeExGroupSearch();
		}
	} */
	commCodeExGroupSearch();

}

//그룹코드 리스트 그리드 그리는 함수
function commCodeExGroupSearch() {
    $.fn.ifvmSubmitSearchCondition("commCodeExGroupGrid", setCommCodeExGroupGrid);
    currentGroupCodeData = null;
    commCodeExCodeList = null;
    $("#commCodeExCodeGrid").empty();
}

/************************************************************ 그리드 처리 함수 END **********************************************************************/




/************************************************************ 4. 팝업 화면 관련 처리 함수 **********************************************************************/
function commCodeExDetailPopupOpen(editFlag, rowData) {
	if(editFlag == "NEW_CODE") {
		if(!$.fn.ifvmIsNotEmpty( currentGroupCodeData )) {
			alert('<spring:message code="M01697" />');
			return;
		}
	}
	editOperatingFlag = editFlag;
	if($.fn.ifvmIsNotEmpty( rowData )) {
		currentRowData = rowData;
	}
	objCommCodeExPopup = $("#commCodeExDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="commCodeExDetail"/>',
        contentType: "ajax",
        title: '<spring:message code="M00234" />',
        width: 1000,
        close : 'commCodeExDetailPopupClose'
    });
}

/************************************************************ 4. 팝업 화면 관련 처리 함수 **********************************************************************/
function commCodeExDetailPopupOpen_tab(editFlag, rowData) {
	if(editFlag == "NEW_CODE") {
		if(!$.fn.ifvmIsNotEmpty( currentGroupCodeData )) {
			alert('<spring:message code="M01697" />');
			return;
		}
	}
	editOperatingFlag = editFlag;
	if($.fn.ifvmIsNotEmpty( rowData )) {
		currentRowData = rowData;
	}
	objCommCodeExPopup = $("#commCodeExDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="commCodeExDetail_tab"/>',
        contentType: "ajax",
        title: '<spring:message code="M00234" />',
        width: 1000,
        close : 'commCodeExDetailPopupClose'
    });
}

// 그룹코드 상세 목록 팝업 닫기
function commCodeExDetailPopupClose(actionFlag){
	if(actionFlag == true) {
		commCodeExCodeList._doAjax();
		//reflashCommCodeExList();
		currentRowData = null;
	}
	objCommCodeExPopup.ejDialog('destroy');
}

function commCodeExGroupNamePopupOpen() {
	editOperatingFlag = "MODIFY_GROUP_NAME";
	objCommCodeExGroupNamePopup = $("#commCodeExGroupNameDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="commCodeExGroupNamePop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01698" />',
        width: 400,
        close : 'commCodeExGroupNamePopupClose'
    });
}

// 팝업 닫기
function commCodeExGroupNamePopupClose(actionFlag){
	if(actionFlag == true) {
		$("#groupCode").val(currentGroupCodeData.groupCode);
		commCodeExGroupSearch();
	}
	objCommCodeExGroupNamePopup.ejDialog('destroy');
}



/************************************************************ 팝업 화면 관련 처리 함수 END **********************************************************************/




/************************************************************ 5. 삭제 관련 처리 함수 **********************************************************************/
// 그룹코드 삭제시 실
function removeGroupCode() {
	if($.fn.ifvmIsNotEmpty(commCodeExGroupList)) {
		var delList = commCodeExGroupList.opt.gridControl.getSelectedRecords();
		if($.fn.ifvmIsNotEmpty(delList)) {
			if(!confirm('<spring:message code="M01700" />')) return;
			editOperatingFlag = "DEL_GROUP";
			$.ifvSyncPostJSON('<ifvm:action name="editCommCodeExGroupCodeDel"/>', {
				groupCode: delList[0].groupCode
				, strSchema: $("#strSchema").val()
			}, function(result) {
				alert('<spring:message code="M01266" />');
				reflashCommCodeExList();
			});
		} else {
			alert('<spring:message code="M01701" />')
		}
	}
}

function removeCommCodeItems() {
	if($.fn.ifvmIsNotEmpty(commCodeExCodeList)) {
		var delList = commCodeExCodeList.opt.gridControl.getSelectedRecords();
		removeTransactionFlag = 0;
		editOperatingFlag = "DEL_CODE"
		if($.fn.ifvmIsNotEmpty(delList)) {
			if(!confirm('<spring:message code="M01702" />')) return;
			for(var idx = 0; idx < delList.length; idx++) {
				removeCommCodeAction(delList[idx].groupCode, delList[idx].codeName, delList[idx].lang, delList.length);
			}
		} else {
			alert('<spring:message code="M01703" />');
		}
	} else {
		alert('<spring:message code="M01701" />');
	}
}


function removeCommCodeAction(varGroupCode, varCodeName, varLang, delListLength) {
	$.ifvSyncPostJSON('<ifvm:action name="editCommCodeExCodeNameDel"/>', {
		groupCode: varGroupCode
		, strSchema: $("#strSchema").val()
		, codeName: varCodeName
		, selectLang: varLang
	}, function(result) {
		if(removeTransactionFlag == delListLength - 1) {
			alert('<spring:message code="M01266" />');
			//그룹코드 상세 삭제시
			commCodeExCodeList._doAjax();
			//reflashCommCodeExList();
		} else {
			removeTransactionFlag++;
		}
	});
}

/************************************************************ 삭제 관련 처리 함수 END **********************************************************************/

function reApplyServerCommCode(){
	$.ifvSyncPostJSON('<ifvm:action name="reApplyServerCommCode"/>', {
		
	},function(result) {
		alert('<spring:message code="L02673" />');
	},function(result) {
		alert('<spring:message code="I00742" />');
	});

}

</script>

<script id="commCodeExGroupCodeGrid" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		{title}

		<div class="filter_area">
			<div class="left">
				{searchBox}
			</div>
		</div>

		<div class="grid_con">
			{grid}
		</div>
		<div class="page">
			{page}
			<div class="total_area">{total}</div>
		<div>
	</div>
</script>

<script id="selectLangTemplate" type="text/x-jquery-tmpl">
	<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div id="pop"></div>
<div class="page-title">
	<h1>
		<spring:message code="M00234"/> &gt; <spring:message code="L00030"/>
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00168"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="commCodeSearch" objCode="commCodeExListNewSearch_OBJ"><i class="fa fa-search"></i>
				<spring:message code="M00135"/>
			</button>
		</div>
	</div>
	
	<div class="well" id="commCodeListFormArea" >
		<div class="row  qt_border">
			<div class="form-horizontal">
				<label class="col-xs-1"><spring:message code="LO2683"/></label>
				<div class="col-xs-3">
					<ifvm:input type="hidden" id="strSchema" dto="strSchema" text="M00252" values="com" checkIndex="1" disabled="true"/>
					<ifvm:input type="select" id="searchType" names="searchType" required="true"/>
				</div>
				<label class="col-xs-1 two_line"><spring:message code="M00241"/></label>
				<div class="col-xs-3">
					<ifvm:input type="text" id="groupCode" dto="groupCode" maxLength="50" autoCompleted="true" />
				</div>
				<label class="col-xs-1"><spring:message code="M00238"/></label>
				<div class="col-xs-3">
					<ifvm:input type="text" id="groupName" dto="groupName" maxLength="50" />
				</div>
			</div>
		</div>
		<div class="row">
			<div class="form-horizontal">
				<label class="col-xs-1"><spring:message code="M00237"/></label>
				<div class="col-xs-3">
					<ifvm:input type="select" id="selectLang" dto="selectLang" />
				</div>
				<label class="col-xs-1 two_line"><spring:message code="M00244"/></label>
				<div class="col-xs-3">
					<ifvm:input type="text" id="codeName" dto="codeName" maxLength="50" />
				</div>
				<label class="col-xs-1 two_line"><spring:message code="M00243"/></label>
				<div class="col-xs-3">
					<ifvm:input type="text" id="markName" dto="markName" maxLength="50" />
				</div>
			</div>
		</div>
	</div>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-5">
			<span><spring:message code="M00241"/></span>
		</div>
		<div class="col-xs-7 searchbtn_r">
			<button class="btn btn-sm btn_gray" id="reApplyCache" objCode="refreshCache_OBJ">
				<spring:message code="L02671"/>
			</button>
			<button class="btn btn-sm btn_gray" id='addCommCodeGroup' objCode="addCommCodeGroup_OBJ">
				<i class="fa fa-plus"></i>
				<spring:message code="M00163"/>
			</button>
			<button class="btn btn-sm btn_gray" id='modifyCommCodeGroup' objCode="modifyCommCodeGroup_OBJ">
				<spring:message code="M00283"/>
			</button>
			<button class="btn btn-sm btn_gray" id='delCommCodeGroup' objCode="delCommCodeGroup_OBJ">
				<i class="fa fa-minus"></i>
				 <spring:message code="M00165"/>
			</button>
		</div>
	</div>
	<div id="commCodeExGroupGrid" class="white_bg grid_bd0"></div>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M01699" /></span> <!-- 그룹코드 상세목록 -->
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm btn_gray" id='addCommCodeByCopy' objCode="addCommCodeDetailByCopy_OBJ">
				<i class="fa fa-plus"></i>
				<spring:message code="M00254"/>
			</button>
			<button class="btn btn-sm btn_gray" id='addCommCode' objCode="addCommCodeDetailAdd_OBJ">
				<i class="fa fa-plus"></i>
				<spring:message code="M00163"/>
			</button>
			<button class="btn btn-sm btn_gray" id='modifyCommCode' objCode="addCommCodeDetailModify_OBJ"> <!-- 수정 버튼 -->
				<spring:message code="M00283"/>
			</button>
			<button class="btn btn-sm btn_gray" id='delCommCode' objCode="addCommCodeByDetailDel_OBJ">
				<i class="fa fa-minus"></i>
				 <spring:message code="M00165"/>
			</button>
		</div>
	</div>
	<div id="commCodeExCodeGrid" class="white_bg grid_bd0"></div>
</div>
<div id="commCodeExDialog" class="popup_container"></div>
<div id="commCodeExGroupNameDialog" class="popup_container"></div>