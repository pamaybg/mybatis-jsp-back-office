<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

//grid
var benefitsListGrid;
var gridIdbenefitsListGrid;
//model
var campaignOffer;
var rowIdx;
//dialog
var benefitsOfferListPop;

//혜택 목록
function getBenefitsList(){
	var colNames = [];
	var colModel = [];
	
	if(strType == "LOY"){
		colNames = [
						'#',
						'<spring:message code="M00314"/>',
						'<spring:message code="M00315"/>',
						'<spring:message code="M00331"/>',
						'<spring:message code="M00319"/>',
						'<spring:message code="M00321"/>',
						'offerId',
						'id'
		            ];
		colModel = [
						{name:'offerNo',index:'', width:'100px', align:'center', resizable : false},
						{name:'offerName',index:'', width:'130px', resizable : false, cellattr: function(){ return 'style="text-overflow:ellipsis;"';}},
						{name:'commStatus',index:'', width:'80px', align:'center',resizable : false},
						{name:'mktOfferCostGbn',index:'', width:'100px', align:'center', resizable : false},
						{name:'offerTypeCd',index:'', width:'100px',align:'center', resizable : false},
						{name:'discountAmt',index:'', width:'100px', align:'right', resizable : false, formatter:numberFormat},
						{name:'offerId', index:'mof.id', resizable : false,  hidden : true,  searchable : false},
						{name:'id', index:'mof.id', resizable : false,  hidden : true,  searchable : false}
		           ];
	}else{
		colNames = [
	                   '#',
		               '<spring:message code="M00314"/>',
		               '<spring:message code="M00319"/>',
		               '<spring:message code="M01896"/>',
		               '<spring:message code="M02276"/>',
		               '<spring:message code="M02275"/>',
		               'offerId',
		               'id',
		           ];
		colModel = [
		            {name:'offerNo',index:'', width:'100px', align:'center', resizable : false},
		            {name:'offerName',index:'',  width:'300px', resizable : false, cellattr: function(){ return 'style="text-overflow:ellipsis;"';}},
		            {name:'offerTypeCd',index:'', width:'100px',align:'center', resizable : false},
		            {name:'offerSubTypeNm',index:'', width:'100px',align:'center', resizable : false},
		            {name:'offerEcnrsDivNm',index:'', width:'100px', resizable : false},
		            {name:'offerUseDeskDivNm',index:'', width:'100px', resizable : false},
		            {name:'offerId', index:'mof.id', resizable : false,  hidden : true,  searchable : false},
		            {name:'id', index:'mof.id', resizable : false,  hidden : true,  searchable : false}
			       ];
	}
    var jqGridOption = {
 		loadComplete : function(obj){
 			//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'dialog',
				contentsId : 'dialogPopupWrap'
			});
 		},
	    serializeGridData : function( data ){
	    	
	    },
	    ondblClickRow : function (id) {
	    	var offerRowid = benefitsListGrid.getRowData()[0].offerId;
    		//오퍼 수정
    		editOfferEnrollmentBtn(offerRowid);
        },
	    data: campaignOffer.offerList,
	    datatype: 'clientSide',
	    colNames:colNames,
	    colModel:colModel,
	    rowList : [100000],
	    radio: true,
	    gridview:true,
        tempId : 'benefitsPopTemplete',
	};
	benefitsListGrid = $("#benefitsListGrid").ifvGrid2({ jqGridOption : jqGridOption });
	gridIdbenefitsListGrid = $("#gridIdbenefitsListGrid");
}

//숫자 콤마표시
function numberFormat(cellvalue, options, rowObjec) {
    var value = "";
    if (isNotEmpty(cellvalue)) {
        value = $.ifvNumberFormat(cellvalue);
    }
    
    return value;
}

//dialog close
function closeBenefitsPop(args) {
	cDialog._destroy();
}

//benefitsPopInit
function benefitsPopInit() {
    cDialog.model.title = '<spring:message code="M02303"/>';
    $("#dialog_title").append('<spring:message code="M02303"/>');
    cDialog.model.width = "1024";
    cDialog.model.close = "closeBenefitsPop";

    setTimeout(function() {
        cDialog.refresh();
    }, 1000);
}

function benefitsPopInitData() {
    //node data get/reset
    campaignOffer = {offerList: []};
    /* if ($.fn.ifvmIsNotEmpty(diagram.selectionList[0].addInfo.data.campaignOffer) 
            && $.fn.ifvmIsNotEmpty(diagram.selectionList[0].addInfo.data.campaignOffer.offerList)) {
        $.each(diagram.selectionList[0].addInfo.data.campaignOffer.offerList, function(index, data){
        	campaignOffer.offerList.push(data);
        });
    } else {
        diagram.selectionList[0].addInfo.data.campaignOffer = { offerList: [] };
    } */
    
    //캠페인 기본정보와 연결이 되어있는지 확인
    var campaignInfo = getNodesByNodeType(diagram.selectionList[0], "INFO");
    if (isNotEmpty(campaignInfo)) {
    	//캠페인 ID
    	campaign.id = campaignInfo[0].addInfo.actualTaskId;
    } else {
    	alert('<spring:message code="C00148"/>');
    	
    	//close popup
    	closeBenefitsPop();
    	
    	return false;
    }
    
    //node 유형설정
    diagram.selectionList[0].addInfo.taskType = "OFFER";
    
    //call 캠페인 오퍼 조회
    $.ifvSyncPostJSON('<ifvm:action name="getCampaignOffer"/>', {
        campaignId: campaign.id
    },
    function(result) {
        if ($.fn.ifvmIsNotEmpty(result)) {
        	$.each(result.offerList, function(index, data){
                data.discountAmt = Math.ceil(data.discountAmt);
            });
        	
        	campaignOffer = result;
        }
    });
    
    //오퍼목록
    getBenefitsList();
}

//신규 오퍼 등록
function newOfferEnrollmentBtn() {
	if (benefitsListGrid.getRowData().length < 1) {
		
		var contentUrl = "";
		if (strType == "LOY") {
			contentUrl = '<ifvm:url name="loyOfferDetailLoad"/>';
		} else {
			contentUrl = '<ifvm:url name="MKTOfferDetailLoad"/>';
		}
		
	    $("#benefitsOfferListPop").ifvsfPopup({
	        enableModal : true,
	        enableResize: false,
	        contentUrl: contentUrl,
	        contentType: "ajax",
	        title: '<spring:message code="M00793"/>',
	        width: 1000,
	        close : 'benefitsOfferListPopClose',
	        beforeOpen : function (){
	            $("#benefitsOfferListPop .page-title").hide();
	        },
	        open: function (args) {
	        	//캠페인 기간으로 오퍼의 적용기간 설정
	        	var campaignInfo = getNodeDataByNodeType(diagram.selectionList[0], "INFO", "campaignDefaultInfo");
	        	if (isNotEmpty(campaignInfo)) {
		        	$("#applyStrDate").val(campaignInfo.campaignStartDate);
		            $("#applyEndDate").val(campaignInfo.campaignEndDate);
	            }
	        	
	        	//목록버튼 삭제
	        	$("#loyOfferListBtn").remove();
	        }
	    });
	}
	else {
        alert('<spring:message code="M00795"/>');
    }
}

//오퍼 수정
function editOfferEnrollmentBtn(id) {
	var offerRowid = '';
	if (isNotEmpty(id)) {
		offerRowid = id;
	}
	
	var contentUrl = "";
	if(strType == "LOY"){
		contentUrl = '<ifvm:url name="loyOfferDetailLoad"/>?id='+offerRowid;
	}else{
		contentUrl = '<ifvm:url name="MKTOfferDetailLoad"/>?id='+offerRowid;
	}
	
    $("#benefitsOfferListPop").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: contentUrl,
        contentType: "ajax",
        title: '<spring:message code="M00793"/>',
        width: 1000,
        close : 'benefitsOfferListPopClose',
        beforeOpen : function (){
            $("#benefitsOfferListPop .page-title").hide();
        },
        open: function (args) {
        	//권한 확인
        	if (!checkNodeUnauthrized(diagram._selectedObject.campaignId, diagram._selectedObject.nodeType)) {
        	    //비활성화
        	    setPopupFormAllDisabled("benefitsOfferListPop");
        	}
        	
        	//목록 버튼 삭제
        	$("#loyOfferListBtn").remove();
        }
    });
}

//신규 오퍼 등록 후 오퍼 목록에 추가
function addNewBenefitsOffer(obj) {
	//오퍼는 하나만 등록 가능
    var rowId = obj.id;
    var rowData = obj;
    
    rowData.offerId = rowData.id;
    
    delete rowData.id;
    
    if ($.fn.ifvmIsNotEmpty(rowId)) {
		//그리드 row 추가
		benefitsListGrid.addLocalTr(rowData);
		
		//전역변수에 값 매핑
		campaignOffer.offerList = benefitsListGrid.getAllRowData();
    }
}

//오퍼 수정 후 오퍼 목록에 변경
function editBenefitsOffer(obj) {
	//오퍼는 하나만 등록 가능
    var rowId = obj.id;
    var rowData = obj;
    
    rowData.offerId = rowData.id;
    
    if ($.fn.ifvmIsNotEmpty(rowId)) {
        //row Data 수정
        benefitsListGrid.setRowDatas(rowData);
        
		//전역변수에 값 매핑
		campaignOffer.offerList = benefitsListGrid.getAllRowData();
        
        //노드 text 수정
        diagram._selectedObject.text = rowData.offerName;
        diagram._selectedObject.update();
    }
    cDialog.refresh();
}

//오퍼 조회 팝업 닫기
function benefitsOfferListPopClose(){
	benefitsOfferListPop._destroy();
}

//오퍼 조회 팝업
function searchOfferBtn() {
	if (benefitsListGrid.getRowData().length < 1) {
	    $("#benefitsOfferListPop").ifvsfPopup({
	        enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="benefitsOfferListPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M00794"/>',
	        width: 1024,
	        close : 'benefitsOfferListPopClose',
	    });
	}
	else {
		alert('<spring:message code="M00795"/>');
	}
}

//
/**
 * 오퍼 조회 팝업 선택 
 * @edit 2017. 7. 12. jh.kim. 오퍼 목록에 존재하는 데이터인지 체크하는 로직 변경  
 */
function benefitsOfferListPopSelect() {
	var rowId = gridIdbenefitsOfferListPopGrid.getGridParam("selrow");
	var rowData = gridIdbenefitsOfferListPopGrid.getRowData(rowId);
	
	rowData.offerId = rowData.id;
	
	delete rowData.id;
	
	if ($.fn.ifvmIsNotEmpty(rowId)) {
    	//오퍼 목록에 선택 오퍼가 있는지 확인
    	if ($.fn.ifvmCheckJsonArrayValue(benefitsListGrid.getDataRows(), "offerId", rowData.offerId) == false) {
        	//오퍼 목록에 추가

        	//그리드 row 추가
    		rowData.radio = "";
			benefitsListGrid.addLocalTr(rowData);
    		
			//전역변수에 값 매핑
			campaignOffer.offerList = benefitsListGrid.getAllRowData();
            
            //팝업 닫기
            benefitsOfferListPopClose();
    	}
    	else {
    		alert("<spring:message code='M00796'/>");
    	}
	}
	else {
		alert( "<spring:message code='M01018' />" );
	}
}

//오퍼 삭제
function benefitsPopRemoveBtn() {
    var len = benefitsListGrid.getRadioSelectedRowId().length;
    
    //삭제
    if (len >= 0) {
    	//그리드 row 삭제
    	benefitsListGrid.delRowData();
    	
    	//전역변수에 값 매핑
		campaignOffer.offerList = benefitsListGrid.getAllRowData();
    }
    else {
    	alert( "<spring:message code='M00911' />" );
    }
}

//오퍼 저장
function benefitsPopSaveBtn() {
	campaignOffer.campaignId = campaign.id;
	campaignOffer.dataStatus = getTaskStatusCode(campaignOffer.offerList);
	
	diagram._selectedObject.data.campaignOffer = campaignOffer;
	diagram._selectedObject.taskDataStatus = getTaskStatusCode(campaignOffer.offerList);
	
	//call 캠페인 오퍼 저장
    $.ifvSyncPostJSON('<ifvm:action name="saveCampaignOfferRel"/>', campaignOffer,
    function(result) {
    	//set actual task ID
    	diagram._selectedObject.actualTaskId = campaign.id;
    	
    	//set campaign ID
    	diagram._selectedObject.campaignId = campaign.id;
    	
    	//set old campaign ID
    	diagram._selectedObject.oldCampaignId = campaign.id;
    	
    	//save workflow
        saveWorkflow();
    	
    	//close popup
    	closeBenefitsPop();
    });
}

$(function () {
    
	benefitsPopInit();
	benefitsPopInitData();
	
	$("#gridIdbenefitsListGrid").bind('onSelectRow', function(event){
		rowIdx = event.args.rowindex;
	});
	
	//신규 오퍼 등록
	$('#newOfferEnrollmentBtn').on('click', function(){
		newOfferEnrollmentBtn();
    });
	
    //오퍼 검색
    $('#searchOfferBtn').on('click', function(){
    	searchOfferBtn();
    });
	
	//삭제 클릭시
	$('#benefitsPopRemoveBtn').on('click', function(){
		benefitsPopRemoveBtn();
    });
	
	//저장 클릭시
    $('#benefitsPopSaveBtn').on('click', function(){
    	benefitsPopSaveBtn();
    });
	
    //draft 클릭시
    $('#benefitsPopDraftBtn').on('click', function(){
    	benefitsPopSaveBtn();
    });
	   
    //취소 클릭시
    $('#benefitsPopCancelBtn').on('click', function(){
    	closeBenefitsPop();
    });
    
});
</script>

<script id="benefitsPopTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		{title}
		<div class="grid_con">
			{grid}
		</div>
		<div class="page">
			<div class="total_area">{total}</div>	
		<div>
	</div>
</script>

<style>
.benefits_size{width:975px;}
</style>

<div id="">
	<div class="pop_inner_wrap form-horizontal">
        <div class="row qt_border">
       		<label class="col-xs-1 control-label"><spring:message code="M00791"/></label>
            <div class="col-xs-3 half_bottom">
            	<div class="input-group">
	                <ifvm:input type="text" disabled="true" />
	   				<span class="input-group-addon" id="searchOfferBtn">
						<a><i class="fa fa-search"></i></a>
					</span>
				</div>
            </div>
        </div>
        
        <header class="temp_title_bb">
			<spring:message code="M00338"/>
			<button class="btn_pop_white pop_top_btn" id="benefitsPopRemoveBtn">
				<img src="<ifvm:image name='btn_delete'/>" alt="" />
				<spring:message code="M00275"/>
			</button>
		</header>
        <div id="benefitsListGrid" class="benefits_size"></div>
	</div>
	<div class="pop_btn_area">
        <%-- 신규오퍼등록 --%>
		<button class="btn btn-sm btn_gray" id="newOfferEnrollmentBtn">
			<spring:message code="M00793"/>
	    </button>
        <%-- 저장 --%>
	    <button class="btn btn-sm btn_gray" id="benefitsPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00280"/>
	    </button>
        <%-- 취소 --%>
	    <button class="btn btn-sm btn_lightGray2 cancel" id="benefitsPopCancelBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>

<div id="benefitsOfferListPop" class="popup_container"></div>