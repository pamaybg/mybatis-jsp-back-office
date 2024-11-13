<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var filterCombiPopGrid;
var filterData;

//init
function initSegmentFilterCombiPop() {
	
    //필터 데이터
    filterData = diagram._selectedObject.data;

    //필터 유형    
    $.fn.ifvmSetSelectOptionCommCode("filterTypeList", "ANL_SEG_FILTER_TYPE_CD");
    
    //필터 데이터 설정
    setFilterData();
}

//필터 데이터 설정
function setFilterData() {
    if ($.fn.ifvmIsNotEmpty(filterData)) {
	    //filter 유형 설정
        $('input:radio[name=filterTypeCode]:input[value=' + filterData.filterTypeCode + ']').attr("checked", true);
        setFilterTypeCode();
	    
        var combFilterText = getFilterCombiNodeText(filterData);
      	
        //조합필터일경우 텍스트 설정
        if (combFilterText.success) {
            $("#filterA").text(combFilterText.filterText);
            filterData.filterText = combFilterText.filterText;
            
            $("#filterB").text(combFilterText.filterText2);
            filterData.filterText2 = combFilterText.filterText2;
        }
    }
}

//필터 저장
function saveFilterSet() {
    var node = diagram.selectionList[0];
    filterData.offSetX = node.offsetX;
    filterData.offSetY = node.offsetY;
    filterData.logicalCompId = segment.logicalCompId;
    
    //필터 관계 목록
    filterData.filterRelList = getChildFilterRelListData(node.name);
    
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
    
    var filterText = filterData.filterText;
    var filterText2 = filterData.filterText2;
    
    $.ifvProgressControl(true);
    
    $.ifvPostJSON('<ifvm:action name="saveSegmentFilter"/>', filterData,
    function(result) {
        //필터 결과를 다시 받는다.
        filterData = JSON.parse(result.message);
        
        //표시명 설정
        filterData.displayName = $("#filterTypeList option:selected").text();
        
        //데이터 상태
        filterData.dataStatus = "N";
        
        filterData.filterText = filterText;
        filterData.filterText2 = filterText2;
        
        filterData.filterCount = $.fn.ifvmNumberWithCommas(filterData.filterCount);
        node.addInfo.data = filterData;
        
        //노드 업데이트
        diagram._updateNode(node.name, {templateId: "segmentNodeTemplate"});
        
        $.ifvProgressControl(false);
        
        //팝업 닫기
        segmentFilterCombiPopupClose();
    },
    function(result) {
        //결과 count 설정
        filterData.filterCount = "0";
        
        //표시명 설정
        filterData.displayName = $("#filterTypeList option:selected").text();
        
        //데이터 상태
        filterData.dataStatus = "N";
        
        //노드 업데이트
        diagram._updateNode(node.name, {templateId: "segmentNodeTemplate"});
        
        $.ifvProgressControl(false);
        
        segmentMessageCheckr(result.message);
    });
}

//필터 유형 변경시 설정
function setFilterTypeCode() {
    var filterTypeCode = $(":input:radio[name=filterTypeCode]:checked").val();
	$("#filterTypeList").val(filterTypeCode);    
}

$(document).ready(function(){
    
    initSegmentFilterCombiPop();
    
    //확인 클릭시
    $('#filterCombiPopSaveBtn').on('click', function(){
        saveFilterSet();
    });
    
    //닫기 클릭시
    $('#filterCombiPopCloseBtn').on('click', function(){
        segmentFilterCombiPopupClose();
    });
    
  	//유형 변경시
    $("input[name=filterTypeCode]").change(function() {
        setFilterTypeCode();
    });
});
</script>

<div id="segmentFilterCombiPop_wrap" class="popup_container">
    <div class="pop_inner_wrap filterSet_wrap">
        <div class="group_box_bg2">
            <div>
                <spring:message code="M01487"/> : <span id="filterA"></span>
            </div>
            <div>
                <spring:message code="M01488"/> : <span id="filterB"></span>
            </div>
        </div>
        
    	<div id="filterArea" class="filter_type">
            <div style="display:none;">
            <ifvm:input type="select" id="filterTypeList" names="filterTypeList"/>
            </div>
    		<label class="radio-inline">
    			<ifvm:input type="radio" names="filterTypeCode" values="UNION" checked="true" id="filterTypeCode" />
    			<spring:message code="M01483"/>
    		</label>
    		<label class="radio-inline">
    			<ifvm:input type="radio" names="filterTypeCode" values="INTERSECTION" id="filterTypeCode" />
    			<spring:message code="M01484"/>
    		</label>
    		<label class="radio-inline">
    			<ifvm:input type="radio" names="filterTypeCode" values="A_DIFF_SET" id="filterTypeCode" />
    			<spring:message code="M01485"/>
    		</label>
    		<label class="radio-inline">
    			<ifvm:input type="radio" names="filterTypeCode" values="B_DIFF_SET" id="filterTypeCode" />
    			<spring:message code="M01486"/>
    		</label>
        </div>
    </div>
	<br>
    <div class="pop_btn_area">
    	<button class="btn btn-sm btn_gray" id="filterCombiPopSaveBtn" objCode="filterCombiPopSaveBtn_OBJ">
    		<i class="glyphicon glyphicon-check"></i>
    		<spring:message code="M01320"/>
    	</button>
    	<button class="btn btn-sm btn_lightGray2" id="filterCombiPopCloseBtn" objCode="filterCombiPopCloseBtn_OBJ">
    		<spring:message code="M01322"/>
    	</button>
    </div>
</div>
