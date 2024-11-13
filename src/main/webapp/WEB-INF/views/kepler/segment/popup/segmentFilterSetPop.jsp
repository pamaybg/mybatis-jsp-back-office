<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
	.ifv_search_box_search_btn.search_fl {margin-left: 5px; height: 27px;}
	.ui-jqgrid .ui-jqgrid-bdiv {
		position: relative;
		margin: 0em;
		padding: 0;
		overflow: hidden;
		text-align: left;
	}
	.import_form_area .right-box-no-border2 {
		height: 450px;
		overflow-y: auto;
		overflow-x: hidden;
		padding-top: 5px;
	}
</style>
<script>

var filterSetPopGrid = null;
var filterData = null;
var filterSetPopValidation = null;
var filterOperatCode = "";
var clickInputTextBox = "";
var searchYn = "";
var searchText = "";
var filterSetPopListGrid;
//init
function initSegmentFilterSetPop() {
    filterData = diagram._selectedObject.data;

    //그룹 함수
    $.fn.ifvmSetSelectOptionCommCode("groupFuncTypeCode", "ANL_GROUP_FUNC_TYPE");

    //조건
    $.fn.ifvmSetSelectOptionCommCode("operatCode", "MKT_TARGET_SERC_OPRT_TYPE");

    //조건 상세 설정
    $("#groupFuncDtl").attr("onSELECT", "storeCaret(this);");
    $("#groupFuncDtl").attr("onCLICK", "storeCaret(this);");
    $("#groupFuncDtl").attr("onKEYUP", "storeCaret(this);");

	if (filterData.operatCode == "CUSTDTDEF") {
	    //사용자날짜정의 항목선택 그리드 설정
		setSelectItemGridEmpty();
	} else {
	  	//항목 선택 목록 설정
		setAttributeGroupColumnValueListEmpty();
	}

	filterOperatCode = filterData.operatCode;

    setFilterData();
}

//필터 데이터 설정
function setFilterData() {

    if ($.fn.ifvmIsNotEmpty(filterData)) {

	    //filter div 설정
	    $('input:radio[name=filterTypeCode]:input[value=' + filterData.filterTypeCode + ']').attr("checked", true);
        setFilterAreaDiv(filterData.filterTypeCode);

        //연산자
        $("#operatCode").val(filterData.operatCode);

		$("#operatCode option[value='']").remove();

		if($("#operatCode").val() == null || $("#operatCode").val() == '') {
			$("#operatCode option:eq(1)").prop("selected", true);
		}

        //연산자 설정
        changeoperatCode();

        $("#groupFuncTypeCode").val(filterData.groupFuncTypeCode);
        /* $("#groupFuncDtl").val(filterData.groupFuncDtl); */

        //IN 또는 NOT IN
        if (filterData.operatCode == "IN" || filterData.operatCode == "NOT IN"){
        	if ($.fn.ifvmIsNotEmpty(filterData.filterValueList)) {
				$.each(filterData.filterValueList, function(index, data) {
					if (index == 0) {
						$("#filterValue").val(data);
					} else {
						setFilterValueAdd(data);
					}
				});
        	}
        }

        //BETWEEN
        else if (filterData.operatCode == "BETWEEN") {
        	$("#filterValue").val(filterData.filterValue);
            $("#andValue").val(filterData.andValue);
        }

        //그외
        else {
        	$("#filterValue").val(filterData.filterValue);
        }
    }
}

//항목 선택 목록 설정 빈값
function setAttributeGroupColumnValueListEmpty() {
    var atribGroupColId = diagram._selectedObject.data.atribGroupColId;
    var jqGridOption = {
    		serializeGridData : function( data ){

    		},
            colNames:[ '<spring:message code="M01233"/>',
                     ],
            colModel:[
                { name:'', index:'', width:'', align: 'center', resizable : false},
            ],
            data:[],
            datatype : 'clientSide',
			searchYn : searchYn,
			searchText : searchText,
            multiselect : true,
            gridview : true,
            tempId : 'ifvGridOriginTemplete5'
        };

    filterSetPopGrid = $("#filterSetPopGrid").ifvGrid({ jqGridOption : jqGridOption });
	filterSetPopListGrid = $("#filterSetPopGrid");
}

//사용자날짜정의 항목선택 그리드 설정
function setSelectItemGridEmpty() {
	var jqGridOptions = {
		serializeGridData : function( data ){

		}
		,colNames:[ '<spring:message code="M01233"/>',
		]
		,colModel:[
			{ name:'', index:'', width:'', align: 'center', resizable : false}
		]
		,data:[]
		,datatype : 'clientSide'
		, sortname: "seq"
		, sortorder: "asc"
		, radio: true
		,gridview : true
		, tempId: "ifvGridOriginTemplete5"
	};

	filterSetPopGrid = $( "#filterSetPopGrid" ).ifvGrid({
		jqGridOption: jqGridOptions
	});
}



//항목 선택 목록 설정
function setAttributeGroupColumnValueList() {
    var atribGroupColId = diagram._selectedObject.data.atribGroupColId;
    var jqGridOption = {
    		serializeGridData : function( data ){
    			data.atribGroupColId = atribGroupColId;
				data.searchYn = searchYn;
				data.searchText = searchText;
    		},
            url : '<ifvm:action name="getAttributeGroupColumnValueList"/>',
            colNames:[ '<spring:message code="M01233"/>',
            		   '설명',
                     ],
            colModel:[
                { name:'COL_VALUE',     index:'COL_VALUE', align: 'center', formatter : colValueSet},
                { name:'COL_NM', 		index:'COL_NM', 	 hidden : true , hiddensrch : true},
            ],
            multiselect : true,
            sortname: '1',
            sortorder: "desc",
            tempId : 'ifvGridOriginTemplete5'
        };

    filterSetPopGrid = $("#filterSetPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function colValueSet(cellValue, obj, data) {
	if (typeof data.COL_NM != "undefined") {
		return data.COL_VALUE + " (" + data.COL_NM + ")";
	} else {
		return data.COL_VALUE;
	}
}

//사용자날짜정의 항목선택 그리드 설정
function setSelectItemGrid() {
	var jqGridOptions = {
		url: "<ifvm:action name='getCommCodeList' />"
        , serializeGridData : function( data ) {
        	data.groupCode = "MKT_DT_DEFAULT";
        	data.pagingFlag = "1";
        }
		, colNames: [
			"<spring:message code='M01206' />"
			, "<spring:message code='M01233' />"
		]
		, colModel: [
			{ name: "codeName", index: "codeName", align: "center" }
			, { name: "markName", index: "markName", align: "center" }
		]
		, sortname: "seq"
		, sortorder: "asc"
		, radio: true
		, tempId: "ifvGridOriginTemplete5"
	};

	filterSetPopGrid = $( "#filterSetPopGrid" ).ifvGrid({
		jqGridOption: jqGridOptions
	});
}

//조건 변경시
function changeoperatCode() {
	var _thisCode = $("#operatCode").val();

	//그리드 초기화
	if($.fn.ifvmIsNotEmpty(filterSetPopListGrid)) {
		if (_thisCode != "CUSTDTDEF" && filterOperatCode == "CUSTDTDEF") {

			setAttributeGroupColumnValueListEmpty();
		} else {
			setSelectItemGridEmpty();
		}
	}

	$("#filterValue").attr("disabled", false);


    filterOperatCode = _thisCode;


    $(".filter_btn").show();

    //IN 또는 NOTIN 버튼 보이기/숨김
	if(filterOperatCode == "IN" || filterOperatCode == "NOT IN") {
		$(".filter_btn").show();
    } else {
    	$(".filter_btn").hide();
    	$(".filter_row").remove();
    }

    //between시 andvalue 보이기
    if (filterOperatCode == "BETWEEN") {
        $("#between").show();
    }
    //사용자날짜정의
    else if(filterOperatCode == "CUSTDTDEF") {
        $("#filterValue").val("");
        $("#andValue").val("");
        $("#between").hide();
/*
        setSelectItemGrid();*/
    }

    else {
        $("#between").hide();
        $("#andValue").val("");
    }

    if (filterOperatCode == "IS NOT NULL" || filterOperatCode == "IS NULL") {
		$("#filterValue").val("");
		$("#filterValue").attr("disabled", true);
	}
}

//선택 필드 설정
function setSelectField() {
    var data = filterSetPopGrid.getCheckedList();
    var operatCode = $("#operatCode").val();

    //선택된 텍스트박스 확인
    var selInputTextBox;
    if ($.fn.ifvmIsEmpty(clickInputTextBox)) {
        selInputTextBox = $("#filterValue");
    } else {
        selInputTextBox = $("#" + clickInputTextBox);
    }

  	//IN 또는 NOT IN 일 경우
    if(operatCode == "IN" || operatCode == "NOT IN") {

	    //값에 선택된 값 넣기 (콤마 구분)
	    $.each(data, function (index, data) {
	    	var value = data.COL_VALUE;

	    	//값 존재여부 확인
	    	var use = true;
			$.each($("input[name=filterValue]"), function(index, data) {
            	var _this = data.value;

            	if (_this == value) {
            		use = false;
                }
			});

	    	if (use) {
				var filterValue = $("#filterValue").val().trim();

		    	if (index == 0 && filterValue == "") {
					$("#filterValue").val(value);
				} else {
					setFilterValueAdd(value);
				}
	    	}
	    });
	}

	//사용자 날짜 정의 일 경우
    else if (operatCode == "CUSTDTDEF") {
    	var value = data[0].codeName;
    	selInputTextBox.val(value);
    }

  	//그외
    else {
    	var value = data[0].COL_VALUE;
    	selInputTextBox.val(value);
    }
}

//취소 필드 설정
function setCancleField() {
    var data = filterSetPopGrid.getCheckedList();

    filterSetPopGrid.resetChecked();
}

//필터 저장
function saveFilterSet() {
	filterData.operatCode = $("#operatCode").val();
	var confirm = true;

	if(filterData.operatCode == "IS NULL" || filterData.operatCode == "IS NOT NULL") {
		confirm = true;
	} else {
		confirm = filterSetPopValidation.confirm();
	}

	if (confirm) {
        var node = diagram.selectionList[0];
        filterData.offSetX = node.offsetX;
        filterData.offSetY = node.offsetY;

        //첫번째 필터여부 확인
        var checkFirstFlag = checkFirstFilter(node.name);
        if (checkFirstFlag) {
        	filterData.firstFlag = "Y";
        };

        //데이터 상태(신규 등록이 아닐 경우 수정 상태)
        if (filterData.dataStatus != "I") {
            filterData.dataStatus = "U";
        }

        filterData.filterTypeCode = $(":input:radio[name=filterTypeCode]:checked").val();
        filterData.operatCode = $("#operatCode").val();

        if(filterData.operatCode == "IN" || filterData.operatCode == "NOT IN") {
            var filterValueList = [];
            var filterValue = "";
        	$.each($("input[name=filterValue]"), function(index, data) {
            	var value = data.value;

        		filterValueList.push(value);

        		if (index == 0) {
        			filterValue = "'" + value + "'";
            	} else {
            		filterValue += ", '" + value + "'";
                }
            });


        	filterData.filterValue = "( " + filterValue + " )";
        	filterData.filterValueList = filterValueList;
        } else {
        	filterData.filterValue = $("#filterValue").val();
        }

        filterData.andValue = $("#andValue").val();
        filterData.filterRelList = getChildFilterRelListData(node.name);
        filterData.segmentId = segment.segmentId;
        filterData.logicalCompId = segment.logicalCompId;
        filterData.groupFuncTypeCode = $.fn.ifvmIsNotEmpty($("#groupFuncTypeCode").val()) ? $("#groupFuncTypeCode").val() : "";
        /* filterData.groupFuncDtl = $.fn.ifvmIsNotEmpty($("#groupFuncDtl").val()) ? $("#groupFuncDtl").val() : ""; */

        //필터 노드 목록 좌표 추출
        var filterList = [];
        $.each(diagram.nodes(), function(index, node) {
            var fData = {};
            fData.segFilterId = node.name;
            fData.offSetX = node.offsetX;
            fData.offSetY = node.offsetY;

            filterList.push(fData);
        });

        filterData.filterList = filterList;

        $.ifvProgressControl(true);

        $.ifvPostJSON('<ifvm:action name="saveSegmentFilter"/>', filterData,
        function(result) {
            //필터 결과를 다시 받는다.
            filterData = JSON.parse(result.message);

          	//데이터 상태
            filterData.dataStatus = "N";

            var filterValue  = $.fn.ifvmIsNotEmpty(filterData.filterValue) ? filterData.filterValue : "";

            if(filterData.operatCode == "BETWEEN") {
            	filterValue += " AND " + filterData.andValue;
            }

            //필터 텍스트
            filterData.filterText = filterData.operatCodeName + " " + filterValue;

            if ($.fn.ifvmIsNotEmpty(filterData.groupFuncTypeCode)) {
                if ("COUNT(DISTINCT)" == filterData.groupFuncTypeCode) {
                	filterData.filterText = "COUNT(DISTINCT " + filterData.displayName + ") " + filterData.filterText;
                } else {
                    filterData.filterText = filterData.groupFuncTypeCode + " (" + filterData.displayName + ") " + filterData.filterText;
                }
            }

            //필터 건수 설정
            filterData.filterCount = $.fn.ifvmNumberWithCommas(filterData.filterCount);

            node.addInfo.data = filterData;

            //노드 업데이트
            diagram._updateNode(node.name, {templateId: "segmentNodeTemplate"});

            $.ifvProgressControl(false);

            //팝업 닫기
            segmentFilterSetPopupClose();
        },
        function(result) {
            filterData.filterCount = "0";

          	//데이터 상태
            filterData.dataStatus = "N";

            var filterValue = filterData.filterValue;

            if(filterData.operatCode == "BETWEEN") {
            	filterValue += " AND " + filterData.andValue;
            }

            //필터 텍스트
            filterData.filterText = filterData.operatCodeName + " " + filterValue;

            if ($.fn.ifvmIsNotEmpty(filterData.groupFuncTypeCode)) {
                if ("COUNT(DISTINCT)" == filterData.groupFuncTypeCode) {
                	filterData.filterText = "COUNT(DISTINCT " + filterData.displayName + ") " + filterData.filterText;
                } else {
                    filterData.filterText = filterData.groupFuncTypeCode + " (" + filterData.displayName + ") " + filterData.filterText;
                }
            }

            //노드 업데이트
            diagram._updateNode(node.name, {templateId: "segmentNodeTemplate"});

            $.ifvProgressControl(false);

            //메시지 확인
            segmentMessageCheckr(result.message);
        });
    }
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

//필터값 추가
function setFilterValueAdd(val) {

	filter = {filterValue: val};

	var temp = $("#filterValueTemp").tmpl(filter);
	$("#filterValueArea").append(temp);

	//validation
	filterSetPopValidation = $("#filterArea").ifvValidation();

	//+ 클릭
    $('.btnFilterValueAdd').off().bind('click', function(){
    	setFilterValueAdd('');
    });

	//- 클릭
    $('.btnFilterValueRemove').off().bind('click', function(){
    	setFilterValueRemove(this);
    });
}

//필터값 삭제
function setFilterValueRemove(_this) {
	_this.parentElement.parentElement.remove();
}

$(document).ready(function(){
    initSegmentFilterSetPop();

    //조건 변경시
    $("#operatCode").on("change", function(){
        changeoperatCode();
    })

    //선택 클릭시
    $('#selectField').on('click', function(){
        setSelectField();
    });

    //취소 클릭시
    $('#cancleField').on('click', function(){
        setCancleField();
    });

    //조회 클릭시
    $('#searchField').on('click', function(){
		var checkText = $("#searchInput").val();
		var checkType = $("#operatCode").val();
		if(checkText == false){
			//사용자 날짜 정의일 경우
			if(checkType== "CUSTDTDEF") {
				setSelectItemGrid();
			} else {
				setAttributeGroupColumnValueList();
			}
		} else {
			searchYn = 'Y';
			searchText = checkText;
			if(checkType== "CUSTDTDEF") {
				setSelectItemGrid();
			} else {
				setAttributeGroupColumnValueList();
			}
		}
    });

    //확인 클릭시
    $('#filterSetPopSaveBtn').on('click', function(){
        saveFilterSet();
    });

    //닫기 클릭시
    $('#filterSetPopCloseBtn').on('click', function(){
        segmentFilterSetPopupClose();
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

    //+ 클릭
    $('.btnFilterValueAdd').off().bind('click', function(){
    	setFilterValueAdd('');
    });

    //- 클릭
    $('.btnFilterValueRemove').off().bind('click', function(){
    	setFilterValueRemove(this);
    });
});
</script>

<script id="fieldsTemp" type="text/x-jquery-tmpl">
<option value="${'${'}columnName}">${'${'}displayName}</option>
</script>

<script id="filterValueTemp" type="text/x-jquery-tmpl">
<div class="row row_bottom filter_row">
	<div class="filter_btn">
		<button id="btnFilterValueAdd" class="btnFilterValueAdd" ><img src="/resources/images/marketing/common/btn_plus.png" alt=""></button>
		<button id="btnFilterValueRemove" class="btnFilterValueRemove" ><img src="/resources/images/marketing/common/btn_minus.gif" alt=""></button>
	</div>
	<label class="filter_label text-right"> ,</label>
	<input type="text" id="filterValue" name="filterValue" required="" class="filter_input" value="${'${'}filterValue}">
</div>
</script>


<div class="import_form_area pop_inner_wrap">
	<div class="pop_inner_wrap">
		<div class="row">
			<div class="col-xs-12">
				<div class="temp_title">
					<label class="radio-inline">
						<ifvm:input type="radio" names="filterTypeCode" values="DEFAULT" checked="true" id="filterTypeCode" />
						<spring:message code="M01478"/>
					</label>
					<label class="radio-inline">
						<ifvm:input type="radio" names="filterTypeCode" values="GROUP_FUNC" id="filterTypeCode" />
						<spring:message code="M01479"/>
					</label>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-xs-4 pr5">
				<div class="left-box-no-border" id="FormArea">
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

			                <div id="filterValueArea">
				                <div class="row row_bottom">
				                	<div class="filter_btn">
				                		<button id="btnFilterValueAdd" class="btnFilterValueAdd"><img src="<ifvm:image name='btn_plus'/>" alt="" /></button>
				                	</div>
				                    <label class="filter_label text-right"><spring:message code="M01233"/></label>
				                    <ifvm:input type="text" className="filter_input" required="true" id="filterValue" names="filterValue" />
				                </div>
			                </div>

							<div class="row between" id="between" style="display:none;">
			                    <label class="filter_label text-right"><spring:message code="M01234"/></label>
			                    <ifvm:input type="text" className="long_text" maxLength="50" id="andValue" names="andValue"/>
			                </div>
			            </div>
			        </div>
				</div>
			</div>

			<div class="col-xs-8 pl5">
				<div class="right-box-no-border3" >
					<!-- 목록 선택 -->
					<div class="temp_title">
						<spring:message code="M01476"/>
						<div class="pop_top_btn">
							<button class="btn_pop_white" id="selectField">
						        <img src="<ifvm:image name='ico_check' />" alt="">
						      	<spring:message code="M03082"/>
						    </button>
						    <button class="btn_pop_white" id="cancleField" hidden="true">
						        <img src="<ifvm:image name='btn_delete' />" alt="">
						      	<spring:message code="M00284"/>
						   </button>
<%--						   <button class="btn_pop_white" id="searchField">
			        			<i class="fa fa-search"></i>
			      				<spring:message code="M00135"/>
			   				</button>  --%>
						</div>
					</div>

					<br>
					<div class="col-xs-4 control_content">
						<ifvm:input type="text" id="searchInput" dto="objType" maxLength="50" />
					</div>
					<button class="ifv_search_box_search_btn search_fl" id="searchField">
						<spring:message code="D10049"/>
					</button>

					<div id="filterSetPopGrid" class="con_size"></div>
				</div>
			</div>
		</div>
	</div>

<!-- 	<div class="filter_left" id="FormArea"> -->
<!-- 	</div> -->
<!-- 	<div class="filter_right"> -->
<!-- 	</div> -->
</div>
<br>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="filterSetPopSaveBtn" objCode="filterSetPopSaveBtn_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00137"/>
	</button>
	<button class="btn btn-sm btn_lightGray2" id="filterSetPopCloseBtn" objCode="filterSetPopCloseBtn_OBJ">
		<spring:message code="M01322"/>
	</button>
</div>