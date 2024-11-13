<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
	.total_area{
    	padding-bottom: 4px;
	}
	.ifv_search_box_search_btn.search_fl {margin-left: 5px; height: 27px;}
	.ui-jqgrid .ui-jqgrid-bdiv {
		position: relative;
		margin: 0em;
		padding: 0;
		overflow: hidden;
		text-align: left;
	}
</style>
<script>
	var filterSetPopGrid = null;
	var filterData = null;
	var filterSetPopValidation = null;
	var filterOperatCode = "";
	var clickInputTextBox = "";
	var atributeId;
	var columnData;
	var filterTextData;
	var sumYnData;
	var sumUseData;
	var searchYn = "";
	var searchText = "";

	function sumYnCheckBoxControlFilterFun(sumYnData) {
			if(sumYnData == 'Y'){
				$("#operatCode option[value='LIKE']").attr('disabled','disabled').hide();
				$("#operatCode option[value='BETWEEN']").attr('disabled','disabled').hide();
				$("#operatCode option[value='IN']").attr('disabled','disabled').hide();
				$("#operatCode option[value='NOT IN']").attr('disabled','disabled').hide();
				$("#operatCode option[value='IS NULL']").attr('disabled','disabled').hide();
				$("#operatCode option[value='IS NOT NULL']").attr('disabled','disabled').hide();
				$("#operatCode option[value='CUSTDTDEF']").attr('disabled','disabled').hide();
				$("#operatCode option:eq(2)").prop("selected", true);
			} else if(sumYnData == 'PY') {
				$("#operatCode option[value='LIKE']").attr('disabled','disabled').hide();
				$("#operatCode option[value='BETWEEN']").attr('disabled','disabled').hide();
				$("#operatCode option[value='IN']").attr('disabled','disabled').hide();
				$("#operatCode option[value='NOT IN']").attr('disabled','disabled').hide();
				$("#operatCode option[value='IS NULL']").attr('disabled','disabled').hide();
				$("#operatCode option[value='IS NOT NULL']").attr('disabled','disabled').hide();
				$("#operatCode option[value='CUSTDTDEF']").attr('disabled','disabled').hide();
				$("#operatCode option:eq(2)").prop("selected", true);
			} else if(sumYnData == 'PN') {
				$("#operatCode option[value='LIKE']").removeAttr('disabled').show();
				$("#operatCode option[value='BETWEEN']").removeAttr('disabled').show();
				$("#operatCode option[value='IN']").removeAttr('disabled').show();
				$("#operatCode option[value='NOT IN']").removeAttr('disabled').show();
				$("#operatCode option[value='IS NULL']").removeAttr('disabled').show();
				$("#operatCode option[value='IS NOT NULL']").removeAttr('disabled').show();
				$("#operatCode option[value='CUSTDTDEF']").removeAttr('disabled').show();
				$("#operatCode option:eq(4)").prop("selected", true);
			} else {
				$("#operatCode option[value='LIKE']").removeAttr('disabled').show();
				$("#operatCode option[value='BETWEEN']").removeAttr('disabled').show();
				$("#operatCode option[value='IN']").removeAttr('disabled').show();
				$("#operatCode option[value='NOT IN']").removeAttr('disabled').show();
				$("#operatCode option[value='IS NULL']").removeAttr('disabled').show();
				$("#operatCode option[value='IS NOT NULL']").removeAttr('disabled').show();
				$("#operatCode option[value='CUSTDTDEF']").removeAttr('disabled').show();
				$("#operatCode option:eq(4)").prop("selected", true);
			}

		var args = {};
		args.value = $("#operatCode").val();
		changeoperatCode(args)
	}
	
 	function initFilterSetPop(atri,colu,filD,sumD,sumF) {
 		atributeId = atri;
 		columnData = colu;
 		filterTextData = filD;
		sumYnData = sumD;
		sumUseData = sumF;

	    //조건
	    $.fn.ifvmSetSelectOptionCommCode("operatCode", "MKT_TARGET_SERC_OPRT_TYPE");
		// $("#operatCode option[value='CUSTDTDEF']").remove()
		$("#operatCode option[value='=']").remove()
		$("#operatCode option[value='!=']").remove()
		$("#operatCode option[value='LIKE']").remove()
		$("#operatCode option[value='>']").remove()
		$("#operatCode option[value='<']").remove()
		$("#operatCode option[value='IS NULL']").remove()
		$("#operatCode option[value='IS NOT NULL']").remove()


		if(sumYnData == 'Y'){
			$('#filterSumYn').prop('checked',true);
		} else {
			$('#filterSumYn').prop('checked',false);
		}

		if(sumUseData == false){
			$('#filterSumYn').prop('disabled',true);
		} else {
			$('#filterSumYn').prop('disabled',false);
		}

		sumYnCheckBoxControlFilterFun(sumYnData);
	    
	    //조건 상세 설정
	    $("#groupFuncDtl").attr("onSELECT", "storeCaret(this);");
	    $("#groupFuncDtl").attr("onCLICK", "storeCaret(this);");
	    $("#groupFuncDtl").attr("onKEYUP", "storeCaret(this);");
		
	    
 		if (columnData == "CUSTDTDEF") {
		    //사용자날짜정의 항목선택 그리드 설정
			setSelectItemGrid();
		} else { 
		  	//항목 선택 목록 설정
			setAttributeGroupColumnValueListEmpty();
		}
		
		filterOperatCode = columnData;
	    
	  	setFilterData();
	    
	   	setFilterAreaDiv("");
	}

	//필터 데이터 설정
	function setFilterData(){	        
		
	        //연산자
	        $("#operatCode").val(columnData);
	        //값
	        var value = filterTextData;

	        if (columnData == "BETWEEN"){
	            $("#between").show();
	            if ($.fn.ifvmIsNotEmpty(value)) {
	                var idx = value.indexOf('AND');
	                var fValue = value.substring(0, idx-1);
	                var andValue = value.substring(idx+4, value.length);
	                
	                fValue = fValue.replace(/\'/g,"");
	                fValue = fValue.replace(/\%/g,"");
/* 	                fValue = fValue.replace(/\(/g,"");
	                fValue = fValue.replace(/\)/g,""); */
	                andValue = andValue.replace(/\'/g,"");
	                
	                $("#filterValue").val(fValue);
	                $("#andValue").val(andValue);
	            }
	            
	        } else {
	            var filterValue = filterTextData;
	            if ($.fn.ifvmIsNotEmpty(filterValue)) {
	                filterValue = filterValue.replace(/\'/g,"");
	                filterValue = filterValue.replace(/\%/g,"");
/* 	                filterValue = filterValue.replace(/\(/g,"");
	                filterValue = filterValue.replace(/\)/g,""); */
	                $("#filterValue").val(filterValue);
	            }
	        }
	}
	
	//항목 선택 목록 설정
	function setAttributeGroupColumnValueList() {
		// var 주거래매장;

		var mainShopCd = $.ifvmGetUserInfo().empNo;
		var atribGroupColId = atributeId;	
	    var jqGridOption = {
	    		serializeGridData : function( data ){
	    			data.atribGroupColId = atribGroupColId;
					data.simpleCheck = 'true';
					data.searchYn = searchYn;
					data.searchText = searchText;
					data.mainShop = mainShopCd;
	    		},
	            url : '<ifvm:action name="getAttributeGroupColumnValueList"/>',
	            colNames:[ '<spring:message code="M01233"/>',
	            		   '설명',
	                     ],
	            colModel:[
	                { name:'COL_VALUE', index:'COL_VALUE', align: 'center', formatter : colValueSet},
	                { name:'COL_VALUE', 		index:'COL_NM', 	 hidden : true , hiddensrch : true},
	            ],
	            multiselect : true,
	            sortname: '1',
	            sortorder: "desc",
	            tempId : 'ifvGridOriginTemplete5'
	        };

	    filterSetPopGrid = $("#filterSetPopGrid").ifvGrid({ jqGridOption : jqGridOption });
	}

	//항목 선택 목록 설정 빈값
	function setAttributeGroupColumnValueListEmpty() {
		var atribGroupColId = atributeId;
		var jqGridOption = {
			serializeGridData : function( data ){
			},
			colNames:[ '<spring:message code="M01233"/>'
			],
			colModel:[
				{name:'', index:'', width:'', align: 'center', resizable : false}
			],
			data:[],
			datatype : 'clientSide',
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
	        
	    filterSetPopGrid = $("#filterSetPopGrid").ifvGrid({ jqGridOption : jqGridOptions });
	}

	//조건 변경시
	function changeoperatCode(args) {

		//그리드 초기화
		setAttributeGroupColumnValueListEmpty();

/*	    if (args.value != "CUSTDTDEF" && filterOperatCode == "CUSTDTDEF") {
	        setAttributeGroupColumnValueList();
	    }*/
	    
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
	        
	        /*setSelectItemGrid();*/
	    } else {
	        $("#between").hide();
	        $("#andValue").val("");
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
	    
	    $('#filterValue').val("");
	}

	//필터 저장
	function saveFilterSet() {
	    	var searchDataQ = ".searchPopOpen_"+atributeId+" #filter";
	    	var operatDataQ = ".colPopOpen_"+atributeId+" #simpleTypeCode";
			var sumYnFlagId = ".sumYn_"+atributeId +" #sumYn";

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
	    		$(operatDataQ).val(operatCode);
	    		$(searchDataQ).val(filterValue);
				if($('#filterSumYn').is(':checked')){
					$(sumYnFlagId).prop('checked',true);
				} else {
					$(sumYnFlagId).prop('checked',false);
				}
	        }	    
	    	simpleFilterSetPopupClose();
	}

	function getfilterValue() {
	    //필터 값
	    var filterValue = $("#filterValue").val();
	    filterValue = filterValue.replace(/\'/g,"");
	    filterValue = filterValue.replace(/\%/g,"");
/* 	    filterValue = filterValue.replace(/\(/g,"");
	    filterValue = filterValue.replace(/\)/g,""); */
	    
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
/* 	    filterValue = filterValue.replace(/\(/g,"");
	    filterValue = filterValue.replace(/\)/g,""); */
	    
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
	    var logicalCompId = atributeId;
	    
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

	    //조건 변경시
	    $("#operatCode").on("change", function(){
	        changeoperatCode(this);
	    })
	    
	    //선택 클릭시
	    $('#selectField').on('click', function(){
	        setSelectField();
	    });

		//조회 클릭시
		$('#searchField').on('click', function(){
			var checkText = $("#searchInput").val();
			var checkType = $("#operatCode").val();
			if(checkText == false){
				if(checkType== "CUSTDTDEF") {
					setSelectItemGrid();
				} else{
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
	    	simpleFilterSetPopupClose();
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

		$('#filterSumYn').on('change',function(){
			var rtnData = '';
			if($('#filterSumYn').is(':checked')) {
				rtnData = 'PY';
			} else {
				rtnData = 'PN';
			}
			sumYnCheckBoxControlFilterFun(rtnData);
		})
	});
</script>
<!-- 필드목록의 내용을 내포하는 템플릿 -->
<script id="fieldsTemp" type="text/x-jquery-tmpl">
<option value="${'${'}columnName}">${'${'}displayName}</option>
</script>

<div id="simpleFilterSetPop_wrap" class="popup_container">
 <div>
  <div class="pop_inner_wrap filterSet_wrap">
	<header class="">
		<label class="radio-inline" style="display: none;">
			<ifvm:input type="radio" names="filterTypeCode" values="DEFAULT" checked="true" id="filterTypeCode"/>
			<spring:message code="M01478"/>
		</label>
		<label class="radio-inline" style="display: none;">
			<ifvm:input type="radio" names="filterTypeCode" values="GROUP_FUNC" id="filterTypeCode" />
			<spring:message code="M01479"/>
		</label>
		<label class="radio-inline">
			<spring:message code="M03090"/>
			<div id = "sumYn" style="border: 1px solid white;  float: right; position: relative; top: 1.1px; left: 7px;">
				<ifvm:input type="checkbox" id="filterSumYn" names="filterSumYn" title="합계(SUM)"/>
			</div>
		</label>
	</header>
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
                    <ifvm:input type="select" className="filter_input" required="false" id="groupFuncTypeCode" names="groupFuncTypeCode" />
                </div>
                <div class="row row_bottom" style="display:none;">
                    <label class="filter_label text-right"><spring:message code="M01480"/></label>
                    <ifvm:input type="textarea" className="filter_textarea" id="groupFuncDtl" names="groupFuncDtl" maxLength="300" rows="3" />
					<div style="position: relative; left:65px; top:-35px;"><ifvm:input type="select" className="filter_input" id="fields" names="fields"/></div>	
                </div>
                <div class="row row_bottom">
                    <label class="filter_label text-right"><spring:message code="M01463"/></label>
                    <ifvm:input type="select" className="filter_input" required="false" id="operatCode" names="operatCode"/>
                </div>
                <div class="row row_bottom">
                    <label class="filter_label text-right"><spring:message code="M01233"/></label>
                    <ifvm:input type="text" className="long_text" required="false" maxLength="150" id="filterValue" names="filterValue" />
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
		<div class="right-box-no-border2" >
					<!-- 목록 선택 -->
			<div class="temp_title">
				<spring:message code="M01476"/>
				<div class="pop_top_btn">
					<button class="btn_pop_white" id="selectField">
				        <img src="<ifvm:image name='ico_check' />" alt="">
				      	<spring:message code="M03082"/>
				    </button>
<%--				    <button class="btn_pop_white" id="cancleField">
				        <img src="<ifvm:image name='btn_delete' />" alt="">
				      	<spring:message code="M00284"/>
				   </button>--%>
<%--				   <button class="btn_pop_white" id="searchField">
	        			<i class="fa fa-search"></i>
	      				<spring:message code="M00135"/>
	   				</button>  --%>
				</div>
			</div>

				<br>
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
	</div>
	
	<div class="pop_btn_area bd_top0" style ="padding : 10px;">
		<button class="btn btn-sm btn_gray" style ="color : white;" id="filterSetPopSaveBtn" objCode="filterSetPopSaveBtn_OBJ">  
			<i class="glyphicon glyphicon-check"></i>       
			<spring:message code="C00039"/>
		</button> 
		<button class="btn btn-sm btn_lightGray2" style ="color : white;" id="filterSetPopCloseBtn" objCode="filterSetPopCloseBtn_OBJ">         
			<spring:message code="M01322"/>
		</button>
	</div> 
</div>
