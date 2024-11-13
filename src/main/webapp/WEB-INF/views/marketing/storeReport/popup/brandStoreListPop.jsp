<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var brandStoreListPopGrid;

/* 매장 목록 */
function getBrandStoreListPopGrid(){
	if($.fn.ifvmIsNotEmpty(brandName)){
		$('#selectBrandName').val(brandName);
	}
	var ejGridOption = {
		serializeGridData : function(data) {
			return data;
		},rowSelected : function(args){

		},
		dataUrl : '<ifvm:action name="getReportBrandStoreList"/>',
		columns : [
			{
				field : 'storeName', headerText : '소속', headerTextAlign : 'center', textAlign : 'center',
				customAttributes : {
					index : 'cd.DIV_NM', searchable : true
				}
			},{
				field : 'employeeNo', headerText : '매장번호', headerTextAlign : 'center', textAlign : 'center',
				customAttributes : {
					index: 'e.EMP_NO', searchable : true
				}
			},{
				field : 'employeeName', headerText : '매장명', headerTextAlign : 'center', textAlign : 'center',
				customAttributes : {
					index: 'e.NAME', searchable : true
				}
			},{
				field : 'id', headerText : 'id', visible : false
			},
			{
				field : 'brandCode', headerText : 'brandCode', visible : false
			},
			{
				field : 'brandName', headerText : 'brandName', visible : false
			}
		],

		requestGridData : {
			nd   : new Date().getTime(),
			rows : 10,
			allFlag : 'Y',
			sidx : 'e.EMP_NO',
			sord : 'desc',
			_search : false,
			xBrandCd : brandCode
		},
		rowList : [10,25,50,100],
		//gridDataInit: true,
		radio: true,
	};

	brandStoreListPopGrid = $("#brandStoreListPopGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}



function brandStoreListPopupClose() {
	$.fn.ifvmPopupClose();
}

function brandStoreListRowSelected(obj) {
	$('#brandNameText').text(obj.brandName);
	$('#shopCodeText').text(obj.employeeNo);
	shopCode = obj.employeeNo;
	ridBrand = obj.id;
	brandCode = obj.brandCode;
	brandName = obj.brandName;
	storeName = obj.storeName;
	shopName = obj.employeeName;
	// setShopCnt();
}


$(document).ready(function(){
	getBrandStoreListPopGrid();

	// 매장 선택 버튼
	$("#brandStoreListSelectBtn").on("click", function(){
		var data = brandStoreListPopGrid.opt.gridControl.getSelectedRecords()[0];
		if($.fn.ifvmIsEmpty(data)){
    		alert('<spring:message code="M00285"/>');
    	}else {
			brandStoreListRowSelected(data);
			$.fn.ifvmPopupClose();
			switch(pageName) {
				case 'mbrCompare':
					pageObjectMbrCompare.mbrGridTitleSetting(data);
					break;
				case 'productCompare':
					pageObjectProductCompare.prdGridTitleSetting(data);
					break;
				case 'repeatBreakaway':
					break;
				case 'salesChange':
					reloadTier();
					break;
				case 'salesPerformance':
					break;

			}

    	}
	});


	// 매장 취소 버튼
	$("#brandStoreListCancelBtn").on("click", function(){
		brandStoreListPopupClose();
	});


	// 브랜드 팝업
	$('#findStoreBrand').on('click', function() {
		$("#popupContainer2").ifvsfPopup({
			enableModal : true,
			enableResize: false,
			contentUrl: '<ifvm:url name="brandListPop"/>',
			contentType: "ajax",
			title: '<spring:message code="L00296"/>',
			width: 700,
			close : 'brandListPopupClose'
		});
	});
});
</script>



<div id="brandStoreListPopCon">
		<div class="row">
			<label class="col-xs-1 control-label">브랜드</label>
			<div class="col-xs-4 control_content">
				<div class="input-group">
					<ifvm:input type="text" className="form-control" required="true" id="selectBrandName" dto="selectBrandName" disabled="true" />
					<span id="findStoreBrand" style="cursor: pointer" class="input-group-addon">
							<a><i class="fa fa-search"></i></a>
						</span>
				</div>
			</div>
		</div>
	<div class="pop_inner_wrap">
		<div id="brandStoreListPopGrid"></div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="brandStoreListSelectBtn" objCode="brandStoreListSelectBtn_OBJ">
			<i class="glyphicon glyphicon-check"></i>
			<spring:message code="M00282"/>
		</button>
		<button class="btn btn-sm btn_lightGray2" id="brandStoreListCancelBtn" objCode="brandStoreListCancelBtn_OBJ">
			<spring:message code="M00284"/>
		</button>
	</div>
</div>

<div id="popupContainer2" class="popup_container"></div>