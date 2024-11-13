<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
/**
 * Action, Rule 정보팝업에서 동일한 ruleFilterSetPop.jsp 를 사용하므로
 * 참조할 룰 필터설정 데이터셋을 분기치기 위해 사용 
 */
var currentData = null;

var filterSetPopGrid = null;
var filterData = null;
var filterSetPopValidation = null;
var filterOperatCode = "";
var clickInputTextBox = "";

//init
function initRuleFilterSetPop() {
    filterData = diagram._selectedObject.data;
    
    //그룹 함수
    //$.fn.ifvmSetSelectOptionCommCode("groupFuncTypeCode", "ANL_GROUP_FUNC_TYPE");
    
    //조건
    $.fn.ifvmSetSelectOptionCommCode("operatCode", "MKT_SERC_OPRT_TYPE");
    
    //조건 상세 설정
    $("#groupFuncDtl").attr("onSELECT", "storeCaret(this);");
    $("#groupFuncDtl").attr("onCLICK", "storeCaret(this);");
    $("#groupFuncDtl").attr("onKEYUP", "storeCaret(this);");
    
	if (filterData.operatCode == "CUSTDTDEF") {
	    //사용자날짜정의 항목선택 그리드 설정
// 	    setSelectItemGrid();
	} else {
	  	//항목 선택 목록 설정
    	setAttributeGroupColumnValueList();
	}
	
	filterOperatCode = filterData.operatCode;
    
    setFilterData();
    
    setFilterAreaDiv("");
}

//필터 데이터 설정
function setFilterData() {
    if ($.fn.ifvmIsNotEmpty(currentData.selRowData)) {
        
        //연산자
        $("#operatCode").val(currentData.selRowData.lcCompOper);
        
        //값
        var value = currentData.selRowData.lcCompVal;
        if (currentData.selRowData.lcCompOper == "BETWEEN"){
            $("#between").show();
            if ($.fn.ifvmIsNotEmpty(value)) {
                var idx = value.indexOf('AND');
                var fValue = value.substring(0, idx-1);
                var andValue = value.substring(idx+4, value.length);
                
                fValue = fValue.replace(/\'/g,"");
                fValue = fValue.replace(/\%/g,"");
                fValue = fValue.replace(/\(/g,"");
                fValue = fValue.replace(/\)/g,"");
                andValue = andValue.replace(/\'/g,"");
                
                $("#filterValue").val(fValue);
                $("#andValue").val(andValue);
            }
            
        } else {
            var filterValue = currentData.selRowData.lcCompVal;
            if ($.fn.ifvmIsNotEmpty(filterValue)) {
                filterValue = filterValue.replace(/\'/g,"");
                filterValue = filterValue.replace(/\%/g,"");
                filterValue = filterValue.replace(/\(/g,"");
                filterValue = filterValue.replace(/\)/g,"");
                $("#filterValue").val(filterValue);
            }
        }
    }
}

//항목 선택 목록 설정
function setAttributeGroupColumnValueList() {
    var atribGroupColId = currentData.etScoringCond.lgclFld;
    var lcCompOper = currentData.etScoringCond.lcCompOper;
    
    var radioSetting;
    var selectionTypeSetting;
    var columnsSetting = [];
    //사용자 날짜 정의인 경우 그리드 설정이 다름.
    if(lcCompOper === 'CUSTDTDEF') {
    	radioSetting = true;
    	selectionTypeSetting = "";
    	
    	columnsSetting.push({
  			field:'colValue',headerText:'<spring:message code="M01233"/>',headerTextAlign:'center',width:'200',
  			customAttributes:{
  				index : 'mark_name'
		}});
    } else {
    	radioSetting = false;
    	selectionTypeSetting = "multiple";
    	
    	columnsSetting.push({
			type:'checkbox',width:'50'
		});
    	columnsSetting.push({
  			field:'colValue',headerText:'<spring:message code="M01233"/>',headerTextAlign:'center',width:'200',
  			customAttributes:{
  				index : 'colValue'
		}});
    }
    
    var ejGridOption = {
    		serializeGridData : function( data ){
    			data.atribGroupColId = atribGroupColId;
    			data.lcCompOper = lcCompOper;
    		},	
    		dataUrl : '<ifvm:action name="getScoringAttributeGroupColumnValueList"/>',
    		columns : columnsSetting,
//             colNames:[ '<spring:message code="M01233"/>',
//                      ],
//             colModel:[
//                 { name:'colValue', index:'colValue', width:'200px', align: 'center', resizable : false},
//             ],
//             multiselect : true,
            requestGridData : {
            	  nd   : new Date().getTime(),
            	  rows : 10,
            	  sidx : 'colValue',
            	  sord : 'asc',
            	  _search : false
            },
            radio : radioSetting,
            allowSelection : true,
//             selectionType : selectionTypeSetting,
//             sortname: '1',
//             sortorder: "desc",
            tempId : 'ifvGridOriginTemplete'
        };
        
    filterSetPopGrid = $("#filterSetPopGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//사용자날짜정의 항목선택 그리드 설정
function setSelectItemGrid() {
	var jqGridOptions = {
		url: "<ifvm:action name='getCommCodeList' />"
        , serializeGridData : function( data ) {
        	data.groupCode = "MKT_DT_DEFAULT"
        }
		, colNames: [
			"<spring:message code='M01206' />"
			, "<spring:message code='M01233' />"
		]
		, colModel: [
			{ name: "codeName", index: "codeName", resizable: false, align: "center" }
			, { name: "markName", index: "markName", resizable: false, align: "center" }
		]
		, sortname: "seq"
		, sortorder: "asc"
		, radio: true
		, tempId: "ifvGridOriginTemplete"
	};
	
	filterSetPopGrid = $( "#filterSetPopGrid" ).ifvGrid({
		jqGridOption: jqGridOptions
	});
}

//조건 변경시
function changeoperatCode(args) {
    if (args.value != "CUSTDTDEF" && filterOperatCode == "CUSTDTDEF") {
        setAttributeGroupColumnValueList();
    }
    
    filterOperatCode = args.value;
    
    //between시 andvalue 보이기
    if (args.value == "BETWEEN") {
        $("#between").show();
    } 
    //사용자날짜정의
    else if(args.value == "CUSTDTDEF") {
        $("#filterValue").val("");
        $("#andValue").val("");
        $("#between").hide();
        
//         setSelectItemGrid();
    } else {
        $("#between").hide();
        $("#andValue").val("");
    }
}

//선택 필드 설정
function setSelectField() {
    var data = $('#gridIdfilterSetPopGrid').ejGrid("getSelectedRecords");
    var operatCode = $("#operatCode").val(); 
    
    //선택된 텍스트박스 확인
    var selInputTextBox;
    if ($.fn.ifvmIsEmpty(clickInputTextBox)) {
        selInputTextBox = $("#filterValue");
    } else {
        selInputTextBox = $("#" + clickInputTextBox);
    }
    
    //값에 선택된 값 넣기 (콤마 구분)
    $.each(data, function (index, data) {
        //사용자날짜정의
        if (operatCode == "CUSTDTDEF") {
            selInputTextBox.val(data.colValue);
        } else {
            //기존 값이 있을경우 뒤에 콤마구분 추가한다.
            var value = selInputTextBox.val();
            if ( $.trim(value).length > 0) {
                value += "," + data.colValue;
                selInputTextBox.val(value);
            } else {
                selInputTextBox.val(data.colValue);
            }
        }
    })
}

//취소 필드 설정
function setCancleField() {
    var data = filterSetPopGrid.getCheckedList();
    
    //값에 선택된 값 삭제
    /* $.each(data, function (index, data) {
        var value = $("#filterValue").val();
        if ( $.trim(value).length > 0) {
           
        }
    }) */
    
    filterSetPopGrid.resetChecked();
}

//필터 저장
function saveFilterSet() {
    if (filterSetPopValidation.confirm()) {
		var rowid = currentData.selRowData.rowid;
		
		var operatCode = $("#operatCode").val();
        var filterValue = $("#filterValue").val();
        var andValue = $("#andValue").val();
        
        var check = true;
        if (operatCode == "BETWEEN") {
        	if ($.fn.ifvmIsNotEmpty(andValue)) {
        		filterValue = filterValue + ' AND ' + andValue;
        	} else {
        		alert("<spring:message code='M01876'/>");
        		check = false;
        	}
        }
		
        if (check) {
    		$("#lcCompOper_" + rowid).val(operatCode);
    		$("#lcCompVal_" + rowid).val(filterValue);
        }
    }
    
    ruleFilterSetPopupClose();
}

function getfilterValue() {
    //필터 값
    var filterValue = $("#filterValue").val();
    filterValue = filterValue.replace(/\'/g,"");
    filterValue = filterValue.replace(/\%/g,"");
    filterValue = filterValue.replace(/\(/g,"");
    filterValue = filterValue.replace(/\)/g,"");
    
    if (filterData.operatCode == "LIKE") {
        filterValue = "'%" + filterValue + "%'";
    } else {
        var valArray = filterValue.split(',');
        
        filterValue = "";
        for (var i=0; i < valArray.length; i++) {
            if (i==0) {
            	filterValue += "'" + valArray[i] +"'";
            } else {
                filterValue += ",'" + valArray[i] +"'"; 
            }
        }
        
        if (valArray.length > 1) {
            filterValue = "(" + filterValue + ")";
        }
    }
    
    //and 값 있을경우
    var andValue = $("#andValue").val();
    if (andValue.length > 0) {
        andValue = andValue.replace(/\'/g,"");
        andValue = "'" + andValue +"'";
        
        filterValue = filterValue + " AND " + andValue;
    }
    
    filterValue = filterValue.replace(/\'/g,"");
    filterValue = filterValue.replace(/\%/g,"");
    filterValue = filterValue.replace(/\(/g,"");
    filterValue = filterValue.replace(/\)/g,"");
    
    return filterValue;
}

//필터 구역 설정
function setFilterAreaDiv(type) {
    
    //그룹 함수 사용
    if (type == "GROUP_FUNC") {
        $("#groupFuncTypeCode").attr("required", "true");
        $("#groupFunc").show();
    }
    
    //그룹 함수 사용 안 함
    else {
        $("#groupFuncTypeCode").val("");
        $("#groupFuncTypeCode").removeAttr("required");
        $("#groupFunc").hide();
    }
    
    filterSetPopValidation = $("#filterArea").ifvValidation();
}

//textarea 이벤트
var groupFuncDtlPos = 0;
function storeCaret (textel){ 
    groupFuncDtlPos = textel.selectionStart; 
} 

//필드 목록 설정
function setFieldList() {
    var logicalCompId = segment.logicalCompId;
    
    $.ifvSyncPostJSON('<ifvm:action name="getLogicalComponentColumnList"/>', {
        	logicalCompId: logicalCompId
    		},
            function(result) {
    		    
    		    var data = {columnName: "", displayName: ""};
    		    var temp = $("#fieldsTemp").tmpl(data);
    			$("#fields").append(temp);
    			
                $.each(result, function(index, data) {
                	var temp = $("#fieldsTemp").tmpl(data);
        			$("#fields").append(temp);
                });
            });
    
  	//그룹함수 사용 안함
    $("#fields").change(function() {
        setSelectFields($(this).val());
    });
}

//필드 선택
function setSelectFields(text) {
    var val = $("#groupFuncDtl").val();
    var cut = val.substring(groupFuncDtlPos, val.length);
    val = val.substring(0, groupFuncDtlPos);
    
    val += text + cut;
    
    $("#groupFuncDtl").val(val);
}

$(document).ready(function(){
	currentData = null;
	if(currentPopup === "scoringRuleInfoPop") { currentData = ruleInfoPopData }
	else if(currentPopup === "scoringActionInfoPop") { currentData = actionInfoPopData }
	
    initRuleFilterSetPop();
    
    //조건 변경시
    $("#operatCode").on("change", function(){
        changeoperatCode(this);
    })
    
    //선택 클릭시
    $('#selectField').on('click', function(){
        setSelectField();
    });
    
    //취소 클릭시
    $('#cancleField').on('click', function(){
        setCancleField();
    });
    
    //확인 클릭시
    $('#filterSetPopSaveBtn').on('click', function(){
        saveFilterSet();
    });
    
    //닫기 클릭시
    $('#filterSetPopCloseBtn').on('click', function(){
    	ruleFilterSetPopupClose();
    });
    
    //그룹함수 사용 안함
    $("input[name=filterTypeCode]").change(function() {
        setFilterAreaDiv($(this).val());
    });
    
    $('#filterValue').on('click', function(){
        clickInputTextBox = "filterValue";
    });
    
    $('#andValue').on('click', function(){
        clickInputTextBox = "andValue";
    });
});
</script>

<script id="fieldsTemp" type="text/x-jquery-tmpl">
<option value="${'${'}columnName}">${'${'}displayName}</option>
</script>

<div id="ruleFilterSetPop_wrap" class="popup_container">
<div class="pop_inner_wrap filterSet_wrap">
	<header class="" style="display: none;">
		<label class="radio-inline">
			<ifvm:input type="radio" names="filterTypeCode" values="DEFAULT" checked="true" id="filterTypeCode" />
			<spring:message code="M01478"/>
		</label>
		<label class="radio-inline">
			<ifvm:input type="radio" names="filterTypeCode" values="GROUP_FUNC" id="filterTypeCode" />
			<spring:message code="M01479"/>
		</label>
	</header>
    
	<div class="filter_left" id="FormArea">
		<div id="filterArea">
            <!-- 필터 조건 -->
            <div class="temp_title">
                <spring:message code="M01232"/>
            </div>
            <div class="group_box_bg2 group_func">
                <div class="row row_bottom" id="groupFunc">
                    <label class="filter_label text-right"><spring:message code="M01237"/></label>
                    <ifvm:input type="select" className="filter_input" required="true" id="groupFuncTypeCode" names="groupFuncTypeCode" />
                </div>
                <div class="row row_bottom" style="display:none;">
                    <label class="filter_label text-right"><spring:message code="M01480"/></label>
                    <ifvm:input type="textarea" className="filter_textarea" id="groupFuncDtl" names="groupFuncDtl" maxLength="300" rows="3" />
					<div style="position: relative; left:65px; top:-35px;"><ifvm:input type="select" className="filter_input" id="fields" names="fields"/></div>	
                </div>
                <div class="row row_bottom">
                    <label class="filter_label text-right"><spring:message code="M01463"/></label>
                    <ifvm:input type="select" className="filter_input" required="true" id="operatCode" names="operatCode"/>
                </div>
                <div class="row row_bottom">
                    <label class="filter_label text-right"><spring:message code="M01233"/></label>
                    <ifvm:input type="text" className="long_text" required="true" maxLength="150" id="filterValue" names="filterValue" />
                </div>
				<div class="row between" id="between" style="display:none;">
                    <label class="filter_label text-right"><spring:message code="M01234"/></label>
                    <ifvm:input type="text" className="long_text" maxLength="50" id="andValue" names="andValue"/>
                </div>
            </div>
        </div>
	</div>
	<div class="filter_right">
		<!-- 목록 선택 -->
		<div class="temp_title">
			<spring:message code="M01476"/>
			<div class="pop_top_btn">
				<button class="btn_pop_white" id="selectField">
			        <img src="<ifvm:image name='ico_check' />" alt="">
			      	<spring:message code="M00282"/>
			    </button>  
			    <button class="btn_pop_white" id="cancleField">  
			        <img src="<ifvm:image name='btn_delete' />" alt="">
			      	<spring:message code="M00284"/>
			   </button> 
			</div>
		</div>
		<div id="filterSetPopGrid" class="grid_bd0 con_size"></div>
	</div>
	
	
</div>
<div class="pop_btn_area bd_top0">
	<button class="btn btn-sm btn_gray" id="filterSetPopSaveBtn">  
		<i class="glyphicon glyphicon-check"></i>       
		<spring:message code="C00039"/>
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="filterSetPopCloseBtn">         
		<spring:message code="M01322"/>
	</button>
</div> 
</div>
