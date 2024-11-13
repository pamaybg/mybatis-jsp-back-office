<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var adrSearchResultGrid;
var adrSearchResult = [];

/**
 * 주소 검색결과 그리드 set
 */
function getAdrSearchResultGrid() {
	var colNames = [];
	var colModel = [];

	colNames.push("우편번호");
	colNames.push("도로명주소");
	colNames.push("지번주소");
	colNames.push("longitute");
	colNames.push("latitude");
	colNames.push("법정코드");
	colNames.push("건물본번");

	colModel.push({name:'road_address.zone_no', 		index:'road_address.zone_no', 		searchable : false, resizable : false, align:'center'});
	colModel.push({name:'road_address.address_name', 	index:'road_address.address_name', 	searchable : false, resizable : false, align:'left'});
	colModel.push({name:'address.address_name', 		index:'address.address_name', 		searchable : false, resizable : false, align:'left'	});
	colModel.push({name:'x', 	index:'x', 		resizable : false, hidden : true, searchable : false});
	colModel.push({name:'y', 	index:'y', 		resizable : false, hidden : true, searchable : false});
	colModel.push({name:'address.b_code', 		index:'address.b_code', 	hidden : true,	searchable : false, resizable : false, align:'left' 	});
	colModel.push({name:'road_address.main_building_no', 		index:'road_address.main_building_no', 	hidden : true,	searchable : false, resizable : false, align:'left'});

	var jqGridOption = {
	    ondblClickRow : function (id) {
	    	adrSaveFn();
        },
	    data: adrSearchResult,
	    datatype: 'clientSide',
	    colNames: colNames,
	    colModel: colModel,
	    rowList : [10],
		sortorder: "desc",
	    radio: true,
        tempId : 'ifvGridSimplePageTemplete'
	};

	adrSearchResultGrid = $("#adrSearchResultGrid").ifvGrid({ jqGridOption : jqGridOption });
	adrSearchResultGrid.setWidth(821);
}

/**
 * 주소 검색결과 저장
 */
function adrSaveFn() {
    $("#bunji_add").val('');
    var len = adrSearchResultGrid.getRadioSelectedRowId().length;
    if (len > 0) {
    	var selectedRowData = adrSearchResultGrid.getSelectedRowData();
		//검색결과 세팅
		$('#mbrDetailForm #zip_add, #newCustDetailForm #zip_add').val(selectedRowData["road_address.zone_no"]); //주소 우편번호
    	$('#mbrDetailForm #adres_add, #newCustDetailForm #adres_add').val(selectedRowData["road_address.address_name"]); //주소
    	$('#mbrDetailForm #roadNmAdrZipCdAdd, #newCustDetailForm #roadNmAdrZipCdAdd').val(selectedRowData["address.zip_code"]); //도로명주소 우편번호
    	$('#mbrDetailForm #roadNmAdrAdd,#newCustDetailForm #roadNmAdrAdd').val(selectedRowData["address.address_name"]); //도로명주소
    	$('#mbrDetailForm #bCodeAdd, #newCustDetailForm #bCodeAdd').val(selectedRowData["address.b_code"]); //법정코드
    	$('#mbrDetailForm #bulidingCodeAdd, #newCustDetailForm #bulidingCodeAdd').val(selectedRowData["road_address.main_building_no"]); //건물번호
    	/* $('#chnlAddInfoDetailForm #latitude').val(selectedRowData.x);
    	$('#chnlAddInfoDetailForm #longitude').val(selectedRowData.y); */
    	$.ifvSyncPostJSON('<ifvm:action name="callGetSiGugun"/>', {
    		  latitude    :   selectedRowData.x
			, longitude    : selectedRowData.y
	        , page : 1
	        , size : 30
	    }, function(result) {
	        if ($.fn.ifvmIsNotEmpty(result)) {
	        	if(result.success) {
	        		$('#sido').val(result.documents[0].region_1depth_name); //도로명주소
	            	$('#gugun').val(result.documents[0].region_2depth_name); //도로명주소
	        	} else {
	        		if(result.message == 1 || result.message == 2 || result.message == 3) {
	        			$.ifvErrorPop(ifv.errorMessage.e_200400); //클라이언트 요청전문이 잘못되었습니다
	        		} else {
	        			$.ifvErrorPop(ifv.errorMessage.m_1001); //작업도중실패
	        		}
	        	}
	        }
    	});
    	
    	//팝업 닫기
    	adrCancelFn();
    } else {
    	alert('<spring:message code="M00004"/>');
    }
}

/**
 * 주소 검색결과 취소
 */
function adrCancelFn() {
	adrDtlSearchPop.destroy();
}

/**
 * 주소 검색 api 호출
 */
function callGetAddrApi() {
	if($.fn.ifvmIsEmpty($('#searchWord').val())) {
		alert('검색어를 입력해주세요.');
	} else {
		$.ifvSyncPostJSON('<ifvm:action name="callGetAddrApi"/>', {
	        query : $('#searchWord').val()
	        , page : 1
	        , size : 30
	    }, function(result) {
	        if ($.fn.ifvmIsNotEmpty(result)) {
	        	if(result.success) {
	        		adrSearchResult = [];
	        		//검색결과 0건
	        		if(result.meta.total_count === 0) {
	        			alert('<spring:message code="M00097"/>');
	        			return;
	        			
	        		} else {
	        			if(result.documents[0].road_address.zone_no != null)
		        		adrSearchResult = result.documents;
	        		}
	        	} else {
	        		if(result.message == 1 || result.message == 2 || result.message == 3) {
	        			$.ifvErrorPop(ifv.errorMessage.e_200400); //클라이언트 요청전문이 잘못되었습니다
	        		} else {
	        			alert('<spring:message code="명확한 주소를 입력해주세요."/>');
	        			return;
	        		}
	        	}
	        }
    	});
		
	}
	
	getAdrSearchResultGrid();
}

$(document).ready(function(){
	getAdrSearchResultGrid();
	
    $('#searchWord').keydown(function (key) {
        if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
        	callGetAddrApi();
        }
    });
    
    //조회
    $('#adrSearchBtn').on('click', function() {
    	callGetAddrApi();
    });
});

</script>
<div id="adrSearchPopArea">
	<div>
	    <div class="form-horizontal top_well">
	        <div class="col-xs-9">
	        <ifvm:inputNew type="text" id="searchWord" label="L02273" labelClass="2" conClass="10" />
	        </div>
	        <div class="col-xs-3 searchbtn_r">
	            <button class="btn btn-sm" id="adrSearchBtn"><i class="fa fa-search"></i>
	                <spring:message code="M00135" />
	            </button>
	        </div>
	    </div>
	<div class="row"></div>
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>
    <div id="adrSearchResultGrid" class="white_bg grid_bd0"></div>
</div>

<div class="pop_btn_area">
	<ifvm:inputNew type="button" btnType="save"  text="C00038"  id="adrSaveBtn" btnFunc="adrSaveFn" objCode="adrSaveBtn_OBJ"/>
	<ifvm:inputNew type="button"   text="M00441"  id="adrCancelBtn" btnFunc="adrCancelFn" objCode="adrCancelBtn_OBJ"/>
</div>
