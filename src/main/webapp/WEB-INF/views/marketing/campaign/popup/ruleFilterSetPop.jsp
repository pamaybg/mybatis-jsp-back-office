<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var filterSetPopGrid = null;
var filterData = null;
var filterSetPopValidation = null;
var filterOperatCode = "";
var clickInputTextBox = "";

//init
function initRuleFilterSetPop() {
    filterData = diagram._selectedObject.data;
    
	if ($.fn.ifvmIsNotEmpty(ruleInfoPopData.lgcCompColumnList)){
		var temp = $("#lcFieldTemplate").tmpl(ruleInfoPopData.lgcCompColumnList);
		$("#lcField").append(temp);
	}
    
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
	    setSelectItemGrid();
	} else {
	  	//항목 선택 목록 설정
    	setAttributeGroupColumnValueList();
	}
	
	filterOperatCode = filterData.operatCode;
    
    setFilterData();
    
    //setFilterAreaDiv("");
}

//필터 데이터 설정
function setFilterData() {
    if ($.fn.ifvmIsNotEmpty(ruleInfoPopData.selRowData)) {
        
    	var type = ruleInfoPopData.selRowData.lcCompValType;
    	
    	if (type != "") {
    		$('input:radio[name=filterTypeCode]:input[value=' + type + ']').attr("checked", true);
    		setFilterAreaDiv(type);
    	}
    	
    	if (type == "EXPR") {
    		$("#exprArea #operatCode").val(ruleInfoPopData.selRowData.lcCompOper);
    		$("#exprArea #filterValue").val(ruleInfoPopData.selRowData.lcCompVal);

    	} else {
	        //연산자
	        $("#defaultArea #operatCode").val(ruleInfoPopData.selRowData.lcCompOper);
	        
	        //값
	        var value = ruleInfoPopData.selRowData.lcCompVal;
	        if (ruleInfoPopData.selRowData.lcCompOper == "BETWEEN"){
	            $("#defaultArea #between").show();
	            if ($.fn.ifvmIsNotEmpty(value)) {
	                var idx = value.indexOf('AND');
	                var fValue = value.substring(0, idx-1);
	                var andValue = value.substring(idx+4, value.length);
	                
	                fValue = fValue.replace(/\'/g,"");
	                fValue = fValue.replace(/\%/g,"");
	                fValue = fValue.replace(/\(/g,"");
	                fValue = fValue.replace(/\)/g,"");
	                andValue = andValue.replace(/\'/g,"");
	                
	                $("#defaultArea #filterValue").val(fValue);
	                $("#defaultArea #andValue").val(andValue);
	            }
	            
	        } else {
	            var filterValue = ruleInfoPopData.selRowData.lcCompVal;
	            if ($.fn.ifvmIsNotEmpty(filterValue)) {
	                filterValue = filterValue.replace(/\'/g,"");
	                filterValue = filterValue.replace(/\%/g,"");
	                filterValue = filterValue.replace(/\(/g,"");
	                filterValue = filterValue.replace(/\)/g,"");
	                $("#defaultArea #filterValue").val(filterValue);
	            }
	        }
    	}
    }
}

//항목 선택 목록 설정
function setAttributeGroupColumnValueList() {
    var atribGroupColId = ruleInfoPopData.lgclFld;
    var ejGridOption = {
    		serializeGridData : function( data ){
    			data.atribGroupColId = atribGroupColId;
    		},	
            dataUrl: '<ifvm:action name="getAttributeGroupColumnValueList"/>',
    		columns:[
    	    	{
    	      		  field : 'COL_VALUE', headerText : '<spring:message code="M01233"/>', headerTextAlign : 'center', textAlign : 'center',
    	      		  customAttributes : { searchable: true  }
    	      	  }
    	    	],
            requestGridData : {
            	  nd   : new Date().getTime(),
            	  rows : 10,
            	  sidx : '1',
            	  sord : 'desc',
            	  _search : false
              },
            selectionType: "multiple",
            rowList : [10,25,50,100],
    	    tempId : 'ifvGridOriginTemplete'
        };
        
    filterSetPopGrid = $("#filterSetPopGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//사용자날짜정의 항목선택 그리드 설정
function setSelectItemGrid() {
    var ejGridOption = {
    		serializeGridData : function( data ){
    			data.groupCode = "MKT_DT_DEFAULT"
    		},	
            dataUrl: '<ifvm:action name="getCommCodeList"/>',
    		columns:[
    	    	{
   	      		  field : 'codeName', headerText : '<spring:message code="M01206"/>', headerTextAlign : 'center', textAlign : 'center',
   	      		  customAttributes : { searchable: true  }
    	      	},
    	    	{
  	      		  field : 'markName', headerText : '<spring:message code="M01233"/>', headerTextAlign : 'center', textAlign : 'center',
  	      		  customAttributes : { searchable: true  }
  	      	  	}
    	    	],
            requestGridData : {
            	  nd   : new Date().getTime(),
            	  rows : 10,
            	  sidx : 'seq',
            	  sord : 'asc',
            	  _search : false
              },
            rowList : [10,25,50,100],
    	    tempId : 'ifvGridOriginTemplete'
        };
        
    filterSetPopGrid = $("#filterSetPopGrid").ifvsfGrid({ ejGridOption : ejGridOption });
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
        
        setSelectItemGrid();
    } else {
        $("#between").hide();
        $("#andValue").val("");
    }
}

//선택 필드 설정
function setSelectField() {
    var data = filterSetPopGrid.opt.gridControl.getSelectedRecords();
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
            selInputTextBox.val(data.codeName);
        } else {
            //기존 값이 있을경우 뒤에 콤마구분 추가한다.
            var value = selInputTextBox.val();
            if ( $.trim(value).length > 0) {
                value += "," + data.COL_VALUE;
                selInputTextBox.val(value);
            } else {
                selInputTextBox.val(data.COL_VALUE);
            }
        }
    })
}

//취소 필드 설정
function setCancleField() {
    var data = filterSetPopGrid.opt.gridControl.getSelectedRecords()[0];
    
    //값에 선택된 값 삭제
    /* $.each(data, function (index, data) {
        var value = $("#filterValue").val();
        if ( $.trim(value).length > 0) {
           
        }
    }) */
    
    //filterSetPopGrid.resetChecked();
}

//필터 저장
function saveFilterSet() {
	var rowid = ruleInfoPopData.selRowData.rowid;
	
	var type = $(":input:radio[name=filterTypeCode]:checked").val();
	var check = true;
	var operatCode = "";
	var filterValue = "";
	
	if (type == "EXPR") {
		operatCode = $("#exprArea #operatCode").val();
		filterValue = $("#exprArea #filterValue").val();
	} else {
		operatCode = $("#defaultArea #operatCode").val();
        filterValue = $("#defaultArea #filterValue").val();
        var andValue = $("#defaultArea #andValue").val();
        
        if (operatCode == "BETWEEN") {
        	if ($.fn.ifvmIsNotEmpty(andValue)) {
        		filterValue = filterValue + ' AND ' + andValue;
        	} else {
        		alert("<spring:message code='M01876'/>");
        		check = false;
        	}
        }
	}
	
    if (check) {
		//$("#lcCompOper_" + rowid).val(operatCode);
		//$("#lcCompVal_" + rowid).val(filterValue);
		ruleInfoListGrid.setRowDatas({lcCompValType: type, lcCompVal: filterValue, lcCompOper: operatCode});
	    
		//값 버튼 클릭시 setRowDatas 시 초기화 됨
	    $(".colValPopupOpenBtn").on('click', function(){
	    	//컬럼값 목록 팝업 열기
	    	columnValueListPopupOpen(this);
	    });
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
    if (type == "EXPR") {
        $("#defaultArea").hide();
        $("#exprArea").show();
    }
    
    //그룹 함수 사용 안 함
    else {
        $("#exprArea").hide();
        $("#defaultArea").show();
    }
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

//LC 필드 선택
function lcFieldSelBtn() {
	var text = $("#lcField  option:checked").val();
	textCopy(text);
}

function textCopy(string) {
	  var textarea = document.createElement('textarea');
	  textarea.value = string;

	  document.body.appendChild(textarea);
	  textarea.select();
	  textarea.setSelectionRange(0, 9999);  // 추가

	  document.execCommand('copy');
	  document.body.removeChild(textarea);
}

$(document).ready(function(){
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

<script id="lcFieldTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}id}" value="${'${'}alias}">${'${'}displayName}(${'${'}alias})</option>
</script>

<div id="ruleFilterSetPop_wrap" class="popup_container">
<div class="pop_inner_wrap filterSet_wrap">
	<header class="">
		<label class="radio-inline">
			<ifvm:input type="radio" names="filterTypeCode" values="DEFAULT" checked="true" id="filterTypeCode" />
			<spring:message code="M01478"/>
		</label>
		<label class="radio-inline">
			<ifvm:input type="radio" names="filterTypeCode" values="EXPR" id="filterTypeCode" />
			조건값 수식
		</label>
	</header>
    <div id="defaultArea">
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
	<div id="exprArea" style="display:none;">
	    <div class="temp_title">
	        	조건값 수식
	    </div>
        <div class="row row_bottom">
            <label class="filter_label text-right"><spring:message code="M01463"/></label>
            <ifvm:input type="select" className="filter_input" required="true" id="operatCode" names="operatCode"/>
        </div>
        <div class="row qt_border">
            <label class="col-xs-1 control-label">Field</label>
            <div class="col-xs-3 control_content">
            	<ifvm:input type="select" id="lcField" names="lcField"/>
            </div>
            <div class="col-xs-1 control_content">
            	<ifvm:inputNew type="button" className="btn_pop_white" text="Copy" nuc="true" id="lcFieldSelBtn"  btnFunc="lcFieldSelBtn" />
            </div>
        </div>
		<div class="row row_bottom">
			<label class="col-xs-1 control-label">수식</label>
			<div class="col-xs-11 control_content">
		    	<ifvm:input type="textarea" className="long_text" required="true" rows="2"  id="filterValue" names="filterValue" />
		    </div>
		</div>
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
