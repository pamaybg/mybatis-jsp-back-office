<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var brandListPopGrid;

/* 매장용 브랜드 목록 */
function brandListPopGrid(){
	var ejGridOption = {
		serializeGridData : function(data) {
			return data;
		},rowSelected : function(args){

		},
		dataUrl : '<ifvm:action name="getReportBrandList"/>',
		columns : [
			{
				field : 'codeName', headerText : '코드값', headerTextAlign : 'center', textAlign : 'center',
				customAttributes : { index : 'cc.code_name', searchable : true
				}
			},{
				field : 'markName', headerText : '표시명', headerTextAlign : 'center', textAlign : 'center',
				customAttributes : { index: 'cc.mark_name', searchable : true
				}
			},{
				field : 'markCode', headerText : '표시코드값', headerTextAlign : 'center', textAlign : 'center',
				customAttributes : { index: 'cc.mark_code', searchable : true
				}
			},{
				field : 'id', headerText : 'id', visible : false,
			}
		],
		requestGridData : {
			nd   : new Date().getTime(),
			rows : 10,
			allFlag : 'Y',
			sidx : 'cc.code_name',
			sord : 'asc',
			_search : false,
		},
		rowList : [10,25,50,100],
		//gridDataInit: true,
		radio: true,
	};
	brandListPopGrid = $("#brandListPopGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function brandListPopupClose() {
	$.fn.ifvmPopupClose();
}
function brandListRowSelected(obj) {
	$('#brandNameText').text(obj.markName);
	brandName = obj.markName;
	brandCode = obj.codeName;
	ridBrand = obj.id;
}

$(document).ready(function(){
	brandListPopGrid();
	
	$("#brandListSelectBtn").on("click", function(){
		if($.fn.ifvmIsEmpty(brandListPopGrid.opt.gridControl.getSelectedRecords()[0])){
    		alert('<spring:message code="M00285"/>');
    	}else {
			brandListRowSelected(brandListPopGrid.opt.gridControl.getSelectedRecords()[0])
			$.fn.ifvmPopupClose();
			$('.first_btn').click();
			getBrandStoreListPopGrid();
    	}
	});
	
	$("#brandListCancelBtn").on("click", function(){
		$.fn.ifvmPopupClose();
	});

});
</script>

<div id="brandListPopCon">
	<div class="pop_inner_wrap">
		<div id="brandListPopGrid"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="brandListSelectBtn" objCode="brandListSelectBtn_OBJ">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="brandListCancelBtn" objCode="brandListCancelBtn_OBJ">
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>
