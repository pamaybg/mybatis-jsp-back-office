<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var targetProductListGrid;
var gridIdtargetProductListGrid;
var targetProductInfoPopupOpenType;
var targetProductListDetail = '<ifvm:url name="targetProductListNew"/>';
var targetPromProductListGrid;
var rowData = null;

//대상상품 목록 그리드 설정
function setTargetProductListGrid() {
	var _promSubType = $("#promTypeCd").val();
	var _ruleProdType = $('#ruleProdType').val();

	var colNames = [];
    var colModel = [];
   /*  colNames.push("<spring:message code='L00198'/>");
	colModel.push({name:'prodTypeNm',index:'', width:'100px', align:'center', resizable : false}); */

	/* if (_ruleProdType == 'BRAND') {
	    colNames.push("<spring:message code='M00365'/>");
    	colModel.push({name:'brdId',index:'', width:'100px', align:'center', resizable : false});
	}
	else if (_ruleProdType == 'MODE_DI') {
        colNames.push("<spring:message code='L00199'/>");
    	colModel.push({name:'prodCate',index:'', width:'100px', align:'center', resizable : false});
    }
	else if (_ruleProdType == 'PROD_GP') {
        colNames.push("<spring:message code='M00365'/>");
        colNames.push("<spring:message code='L00199'/>");
    	colNames.push("<spring:message code='L00200'/>");
    	colModel.push({name:'brdId',index:'', width:'100px', align:'center', resizable : false});
    	colModel.push({name:'prodCate',index:'', width:'100px', align:'center', resizable : false});
    	colModel.push({name:'prodCd',index:'', width:'100px', align:'center', resizable : false});
    }
 */
   	//colNames.push("<spring:message code='M00365'/>");	//브랜드
   	//colNames.push("<spring:message code='L00218'/>");	//브랜드명
    //colNames.push("<spring:message code='M01966'/>");	//카테고리
   	//colNames.push("<spring:message code='L00200'/>");	//상품코드
   	//colNames.push("<spring:message code='L00232'/>");	//상품명
   	//colModel.push({name:'brdId',index:'', width:'100px', align:'center', resizable : false});
   	//colModel.push({name:'brdNm',index:'', width:'100px', align:'center', resizable : false});
   	//colModel.push({name:'prodCate',index:'', width:'100px', align:'center', resizable : false ,hidden :true});
   	//colModel.push({name:'prodCd',index:'', width:'100px', align:'center', resizable : false});
   	//colModel.push({name:'prodNm',index:'', width:'100px', align:'center', resizable : false});

	colNames.push("<spring:message code='L02492'/>");
	colNames.push("<spring:message code='L00188'/>");
	colNames.push("<spring:message code='L00215'/>");
	colNames.push("<spring:message code='L02493'/>");
	colNames.push('acrlType');
	colNames.push('rid');
	colNames.push('camRid');
	//colNames.push('prodType');
	colModel.push({name:'promoId',index:'promoId', width:'100px', align:'center', resizable : false});
	colModel.push({name:'acrlTypeNm',   index:'acrlTypeNm', width:'100px', align:'center',resizable : false});
	colModel.push({name:'acrlAmt',index:'acrlAmt', width:'100px', align:'center', resizable : false, formatter : 'integer'});
	colModel.push({name:'minSalesAmt',index:'minSalesAmt', width:'100px', align:'center', resizable : false, formatter : 'integer'});
	colModel.push({name:'acrlType',index:'acrlType', resizable : false, hidden : true,  searchable : false});
	colModel.push({name:'rid', index:'rid', resizable : false,  hidden : true,  searchable : false});
	colModel.push({name:'camRid', index:'camRid', resizable : false,  hidden : true,  searchable : false});
	//colModel.push({name:'prodType', index:'', resizable : false,  hidden : true,  searchable : false});

	var jqGridOption = {
 		loadComplete : function(obj) {
 			//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'dialog',
				contentsId : 'dialogPopupWrap'
			});
 		},
	    ondblClickRow : function (id) {
        },
        onSelectRow : function(args){
        	rowData = args.rid;
        	setTargetPromProductListGrid(rowData);
        },
	    data: ruleSetData.rulesetCondProdList,
	    datatype: 'clientSide',
	    colNames: colNames,
	    colModel: colModel,
	    rowList : [100000],
	    radio: true,
        tempId : 'ifvGridSimpleTemplete'
	};

    targetProductListGrid = $("#targetProductListGrid").ifvGrid2({ jqGridOption : jqGridOption });
	gridIdtargetProductListGrid = $("#gridIdtargetProductListGrid");
}

function setTargetPromProductListGrid(rowData) {
	
	var jqGridOption = {
		loadComplete : function(obj) {
		 	//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'dialog',
				contentsId : 'dialogPopupWrap'
			});
		 },
		serializeGridData : function(data){
       		data.ruleSetProdRid	= rowData;
        },		
 		url :'<ifvm:action name="getPromProdListNew"/>',
 		colNames : [
 					'상품분류코드'
 				   ,'상품분류명'
 				   ,'상품품번코드'
 				   ,'상품명'
 				   ,'판매가격'
 				   ,'rid'
 				   ,'ruleSetProd'
 		],
 		colModel : [
 			{name:'etcCod', index:'etcCod' , align:'center', resizable : false},
 			{name:'etcSnam',index:'etcSnam', align:'left',resizable : false},
 			{name:'gdsNum',	index:'gdsNum' , align:'center', resizable : false},
 			{name:'gdsNam',	index:'gdsNam' , align:'left', resizable : false},
 			{name:'salePrc',index:'salePrc', align:'right', resizable : false , formatter : 'integer'},
 			{name:'rid' ,   index:'rid'	   , hidden : true },
 			{name:'ruleSetProd' ,   index:'ruleSetProd'	   , hidden : true }
 		],
	    rowList : [100000],
	    radio: true,
        tempId : 'ifvGridSimpleTemplete'
	};
	targetPromProductListGrid = $("#targetPromProductListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//대상상품 정보 팝업 열기
function targetProductInfoPopupOpen(type) {
    targetProductInfoPopupOpenType = type;

	if (type == "E") {

        var len = targetProductListGrid.getRadioSelectedRowId().length;
        if (len > 0) {
            selTargetProductData = targetProductListGrid.getRowDatas();
        }
		else {
			alert("<spring:message code='L00204'/>");
			return false;
		}
	}
	else {
		//초기화
		selTargetProductData = {};
	}

    $("#targetProductInfoPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="targetProductInfoPop"/>',
        contentType: "ajax",
        title: "<spring:message code='L02494'/>",
        width: '500px',
        open: function (args) {
        	if (type == "E") {
        		initTargetProductInfoPopData(selTargetProductData);
        	}
        },
        close : 'targetProductInfoPopupClose'
    });
}

//프로모션 상품목록 팝업
function promProductInfoPopupOpen() {
	 var len = targetProductListGrid.getRadioSelectedRowId().length;
     if (len > 0) {
		//초기화
		$("#promProductInfoPopup").ifvsfPopup({
			enableModal : true,
		    enableResize: false,
		    contentUrl: '<ifvm:url name="promProductInfoPop"/>',
		    contentType: "ajax",
		    title: "<spring:message code='L02491'/>",
		    width: '800px',
		    close : 'promProductInfoPopClose'
		});
     }
	else {
		alert("<spring:message code='L00204'/>");
		return false;
	}
     
}

//프로모션 상품목록 팝업 닫기
function promProductInfoPopClose() {
	promProductInfoPopup._destroy();
}

//대상상품 정보 팝업 저장
function targetProductInfoPopupSave() {
	targetProductInfoPopValidation = $("#targetProductInfoPop").ifvValidation();
	if (targetProductInfoPopValidation.confirm()) {
		var data = {};
		data.prodType = $.fn.ifvmIsEmpty($("#targetProductInfoPop #prodType").val()) ? null : $("#targetProductInfoPop #prodType").val();
		data.prodTypeNm = $.fn.ifvmIsEmpty($("#targetProductInfoPop #prodType option:selected").text()) ? null : $("#targetProductInfoPop #prodType option:selected").text();
		data.acrlType = $.fn.ifvmIsEmpty($("#targetProductInfoPop #acrlType").val()) ? null : $("#targetProductInfoPop #acrlType").val();
		data.acrlTypeNm = $.fn.ifvmIsEmpty($("#targetProductInfoPop #acrlType option:selected").text()) ? null : $("#targetProductInfoPop #acrlType option:selected").text();
		data.acrlAmt = $.fn.ifvmIsEmpty($("#targetProductInfoPop #acrlAmt").val()) ? null : $("#targetProductInfoPop #acrlAmt").val();
		data.prodCate = $.fn.ifvmIsEmpty($("#targetProductInfoPop #prodCate").val()) ? null : $("#targetProductInfoPop #prodCate").val();
		data.brdId = $.fn.ifvmIsEmpty($("#targetProductInfoPop #brdId").val()) ? null : $("#targetProductInfoPop #brdId").val();
		data.prodCd = $.fn.ifvmIsEmpty($("#targetProductInfoPop #prodCd").val()) ? null : $("#targetProductInfoPop #prodCd").val();
		data.prodNm = $.fn.ifvmIsEmpty($("#targetProductInfoPop #prodNm").val()) ? null : $("#targetProductInfoPop #prodNm").val();
		data.brdNm = $.fn.ifvmIsEmpty($("#targetProductInfoPop #brdNm").val()) ? null : $("#targetProductInfoPop #brdNm").val();
		data.minSalesAmt = $.fn.ifvmIsEmpty($("#targetProductInfoPop #minSalesAmt").val()) ? null : $("#targetProductInfoPop #minSalesAmt").val().replaceAll(',','');
		data.promoId = $.fn.ifvmIsEmpty($("#targetProductInfoPop #promoId").val()) ? null : $("#targetProductInfoPop #promoId").val();

		
        // 단건 등록 설정 일 경우 한건만 등록가능
        if (targetProductInfoPopupOpenType == "N"
                && chkGridFullCheck(targetProductListGrid.getRowData(), $("#promTypeCd").val(), 0)) {
            return false;
        }

        // 중복체크
        var popSave_strCheckedRid = targetProductInfoPopupOpenType == "E" ? targetProductListGrid.getCheckedGridData()[0].rid : null;
            popSave_strCheckedRid = $.fn.ifvmIsEmpty(popSave_strCheckedRid) ? null : popSave_strCheckedRid;

        var popSave_getGridArry = targetProductListGrid.getRowData();

       /*  for ( var i = 0 ; i < popSave_getGridArry.length ; i++ ) {

            var popSave_getGridArry_rid = $.fn.ifvmIsEmpty(popSave_getGridArry[i].rid) ? null : popSave_getGridArry[i].rid;

            // 신규이거나 수정이고 id가 다를 경우
            if ( targetProductInfoPopupOpenType == 'N'
                    || (targetProductInfoPopupOpenType == 'E' && popSave_strCheckedRid != popSave_getGridArry[i].rid) ) {

                // 브랜드, 카테고리, 상품이 모두 같은가?
                if ( popSave_getGridArry[i].brdId == data.brdId
                        && popSave_getGridArry[i].prodCate == data.prodCate
                        && popSave_getGridArry[i].prodCd == data.prodCd ) {
                    alert("<spring:message code='M02207'/>");
                    targetProductInfoPopupClose(); //close popup
                    return false;
                }
            }
        } */
		
		//수정 or 등록 여부 확인
		if ($.fn.ifvmIsNotEmpty(selTargetProductData)) {
			selTargetProductData.prodType = data.prodType;
			selTargetProductData.acrlType = data.acrlType;
			selTargetProductData.acrlTypeNm = data.acrlTypeNm;
			selTargetProductData.acrlAmt = data.acrlAmt;
			selTargetProductData.prodCate = data.prodCate;
			selTargetProductData.brdId = data.brdId;
			selTargetProductData.prodCd = data.prodCd;
			selTargetProductData.prodNm = data.prodNm;
			selTargetProductData.brdNm = data.brdNm;
			selTargetProductData.minSalesAmt = data.minSalesAmt;
			selTargetProductData.acrlAmt = data.acrlAmt;
			
			
            targetProductListGrid.setRowDatas(selTargetProductData);
		}
		else {
            targetProductListGrid.addLocalTr(data);
		}

        //전역변수에 값 매핑
        ruleSetData.rulesetCondProdList = targetProductListGrid.getRowData();
		
		//close popup
		targetProductInfoPopupClose();
	}
}

//대상상품 정보 팝업 닫기
function targetProductInfoPopupClose() {
	targetProductInfoPopup._destroy();
}

//삭제
function targetProductRemove() {
    var len = targetProductListGrid.getRadioSelectedRowId().length;
    if (len > 0) {
    	 
        var ruleSetProd;
        ruleSetProd = targetProductListGrid.getRowDatas().rid;
    	
      	//프로모션 상품 삭제
    	targetProductListGrid.delRowData();
		
        // 전역변수에 값 매핑
        ruleSetData.rulesetCondProdList = targetProductListGrid.getAllRowData();
		
    	$.ifvSyncPostJSON('<ifvm:action name="removeProductPromAll"/>', {
    		ruleSetProd : ruleSetProd ,
    		camRid		: camRid
    	},function(result) {
    		setTargetPromProductListGrid(ruleSetProd);
    	});
    }
    else {
    	alert('<spring:message code="L00249"/>');
    }
}

//프로모션 상품목록삭제
function promProductRemove() {
    var len = targetPromProductListGrid.getRadioSelectedRowId().length;
    if (len > 0) {
    	var dataObj = {};
    	dataObj.rulesetPromProductList = [];
    	dataObj.rulesetPromProductList = targetPromProductListGrid.getCheckedList();
    	
    	$.ifvSyncPostJSON('<ifvm:action name="removeProductPromValid"/>', dataObj ,
    		function(result) {
    			alert('<spring:message code="M00003"/>')
    			setTargetPromProductListGrid(rowData);
    		});
    }
    else {
    	alert('<spring:message code="L00249"/>');
    }
}

//전체 	
/* function targetProductAllRemove() {
    var len = targetProductListGrid.getAllRowData().length;
    if (len > 0) {
    	var ruleSetProd;
        ruleSetProd = targetProductListGrid.getRowDatas().rid;
        
        targetProductListGrid.removeAll();
        
        // 전역변수에 값 매핑
        ruleSetData.rulesetCondProdList = targetProductListGrid.getAllRowData();
        
    	$.ifvSyncPostJSON('<ifvm:action name="removeProductPromAll"/>', {
    		ruleSetProd : ruleSetProd
    	},function(result) {
    	});
    }
} */

/**
 * 대상상품 초기화
 */
/* function resetrulesetCondProdList() {
	
    if (targetProductListGrid.opt.data != null
            && targetProductListGrid.opt.data.rows.length > 0 ) {
    	var ruleSetProd = targetProductListGrid.getRowData()[0];
        
        //targetProductListGrid.removeAll();
        
        //전역변수에 값 매핑
        //ruleSetData.rulesetCondProdList = targetProductListGrid.getAllRowData();
        ruleSetData.rulesetCondProdList = targetProductListGrid.removeAll();
        
    	$.ifvSyncPostJSON('<ifvm:action name="removeProductPromAll"/>', {
    		ruleSetProd : ruleSetProd.rid
    	},function(result) {
    	});
    }
} */

$(document).ready(function() {
	setTargetProductListGrid();
    
    ruleSetData.promProductPopList = [];
    
    setFormAllDisabled();
    
    //저장
    $('#targetProductNewBtn').on('click', function() {
    	targetProductInfoPopupOpen('N');
    });

    //수정
    $("#targetProductEditBtn").on('click', function() {
    	targetProductInfoPopupOpen('E');
    });

    //삭제
    $("#targetProductRemoveBtn").on('click', function() {
    	targetProductRemove();
    });
    
  	//프로모션 상품 신규 
    $('#promProductNewBtn').on('click', function() {
    	
    	if( $.fn.ifvmIsEmpty(targetProductListGrid.getSelRadioData())){
    		alert('대상상품을 선택해주세요');
    		return;
    	}else{
       		if($.fn.ifvmIsEmpty( targetProductListGrid.getSelRadioData().promoId)){
       			alert('프로모션을 저장후 등록해주세요.');
       			return;
       		}
    	}
    	promProductInfoPopupOpen();
    	
    });
   
    //프로모션 상품 삭제
    $("#promProductRemoveBtn").on('click', function() {
    	promProductRemove();
    });
    
});
</script>

<div id="targetProductWrap" style="height:170px;overflow-x:hidden;">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="targetProductNewBtn"><i class="fa fa-plus"></i>
                <spring:message code="M01852"/>
            </button>
            <button class="btn btn-sm" id='targetProductEditBtn'>
                <spring:message code="M01853"/>
            </button>
            <button class="btn btn-sm" id='targetProductRemoveBtn'>
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
		<div id="targetProductListGrid" class="white_bg grid_bd0"></div>
</div>

<!-- 프로모션 상품목록  -->
<div class="page_btn_area">
	<div class="col-xs-7">
		<span id='titleProm' style="color:white;"><spring:message code="L02491"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="promProductNewBtn"><i class="fa fa-plus"></i>
       		<spring:message code="M01852"/>
       	</button>
       	<button class="btn btn-sm" id='promProductRemoveBtn'>
       		<spring:message code="M01854"/>
       	</button>
	</div>
</div>
<div id="promList" style="height:180px;overflow-x:hidden;">
	<div id ="targetPromProductListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="targetProductInfoPopup"></div>
<div id="promProductInfoPopup"></div>
