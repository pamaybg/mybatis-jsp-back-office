<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        <span><spring:message code="상품목록"/></span>
        </div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="addProdItemBtn" text="신규" objCode="prodGrpItemAdd_OBJ"/>
			<ifvm:inputNew type="button" id="removeProdItemBtn" text="삭제" objCode="prodGrpItemRemove_OBJ"/>
			<ifvm:inputNew type="button" id="removeAllTProdItemBtn" text="전체 삭제" objCode="prodGrpItemRemoveAll_OBJ"/>
			<ifvm:inputNew type="button" id="excelUploadProdItemBtn" text="업로드" objCode="prodGrpItemUpload_OBJ"/>
			<ifvm:inputNew type="button" id="excelDownProdItemBtn" text="다운로드" objCode="prodGrpItemDown_OBJ"/>
			<ifvm:inputNew type="button" id="excelSampleProdItemBtn" text="업로드 양식" objCode="prodGrpItemSampleUpld_OBJ"/>
        </div>
    </div>
    <div id="prodItemListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="prodExcelUploadPop" class="popup_container"></div>
<div id="addProdItemPop" class="popup_container"></div>

<script type="text/javascript">
var rid;
var prodItemListGrid=null;
function getProdItemList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
    		data.prodGrpRid = prodGrp_Rid;
			return data;
		},
		rowSelected : function(args){
        	rid = args.data.rid;
       	},
        dataUrl : '<ifvm:action name="getProdItemList"/>',

        columns : [
            
            {
                field : 'prodId', headerText : '<spring:message code="E00091"/>', textAlign : 'center', width: 100
                ,headerTextAlign : ej.TextAlign.Center,customAttributes : {index : 'prodId' ,searchable : true}//자재코드 
            }                  
            ,{
                field : 'mmZzstdItemCd', headerText : '<spring:message code="E00100"/>', textAlign : 'center', width: 120
                ,headerTextAlign : ej.TextAlign.Center,customAttributes : {index : 'mmZzstdItemCd',searchable : true }//표준아이템코드
            }
            ,{
                field : 'mmZzItemCd', headerText : '<spring:message code="E00101"/>', textAlign : 'center' , width: 120
                ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'mmZzItemCd',searchable : true }//아이템코드
            
            }
            ,{
                field : 'mmZzRepCd1', headerText : '<spring:message code="E00102"/>', textAlign : 'center' , width: 120
                ,headerTextAlign : ej.TextAlign.Center,customAttributes : {index : 'mmZzRepCd1' }//수요할당코드
            }
            ,{
                field : 'mmZzRepCd2', headerText : '<spring:message code="E00103"/>', textAlign : 'center' , width: 100
                ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'mmZzRepCd2',searchable : true }//대체코드
            }
            ,{
                field : 'mmSkuCd', headerText : '<spring:message code="E00104"/>', textAlign : 'center' , width: 120
                ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'mmSkuCd' }//SKU채널코드
            }
            ,{
                field : 'prodNm', headerText : '<spring:message code="E00105"/>', textAlign : ej.TextAlign.Left, width: 400
                ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'prodNm',searchable : true }//자재이름
            }
            ,{
                field : 'shGoodsCode', headerText : '<spring:message code="E00107"/>', textAlign : 'center', width: 100
                ,headerTextAlign : ej.TextAlign.Center    ,customAttributes : {index : 'shGoodsCode' ,searchable : true}//상품코드
            }
            ,{
                field : 'shGoodsName', headerText : '<spring:message code="E00108"/>', textAlign : 'left', width: 400
                ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'shGoodsName',searchable : true }//상품명 제품명 코드
            }
            ,{
                field : 'mmCate1', headerText : '<spring:message code="E00110"/>', textAlign : 'center', width: 140
                ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'mmCate1' }//카테고리(대)
            }
            ,{
                field : 'mmCate2', headerText : '<spring:message code="E00111"/>', textAlign : 'center', width: 140
                ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'mmCate2' }//카테고리(중)
            }
            ,{
                field : 'mmCate3', headerText : '<spring:message code="E00112"/>', textAlign : 'center', width: 140
                ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'mmCate3' }//카테고리(소)
            }
        ],

        requestGridData : {
      	  sidx : '1',
      	  sord : 'desc',

        },
        rowList : [10,25,50,100],
        radio: true,
        isHorizontalScroll : true,
        allowResizing: true
    };

    prodItemListGrid = $("#prodItemListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

/**
 * 회원샘플다운로드
 */
function excelSampleProdItem(){
	var data = {};
	data.offerType = "PROD_GRP";
	$.fn.ifvmBatchRgstExcelSampleDown2(data);
}

//샘플데이터 다운로드
$.fn.ifvmBatchRgstExcelSampleDown2 = function(data) {
	var inputs = "";
	var url = "/system/batchRgst/excelSampleDown2.do";
	var method = "post"
		//data를 입력받음
		if( data ){
			if ($.fn.ifvmIsNotEmpty(data.offerType)) {
				inputs += '<input type="hidden" name="offerType" value="'+ data.offerType +'" />';

				// request를 보낸다.
				jQuery('<form action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>')
				.appendTo('body').submit().remove();
			}
		};
};

function excelUploadProdItem() {
	$("#prodExcelUploadPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="prodExcelUploadPop"/>',
        contentType: "ajax",
        title: '상품 업로드',
        width: 600,
        close : 'prodExcelUploadClosePop'
	});
}

function prodExcelUploadClosePop() {
	prodExcelUploadPop._destroy();
}

function addProdItem() {
	$("#addProdItemPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="addProdItem"/>',
        contentType: "ajax",
        title: '상품 신규',
        width: 1000,
        close : 'addProdItemClosePop'
	});
}

function addProdItemClosePop() {
	addProdItemPop._destroy();
}


function removeProdItem() {
	var v_rid;
    if ($.fn.ifvmIsNotEmpty(prodItemListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = prodItemListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="삭제할 목록을 클릭해주세요."/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
    	if( confirm('<spring:message code="I01500"/>') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeProdItem"/>', {
            rid: v_rid
        },
        function(result) {
        	prodItemListGrid._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }
  }
}

function removeAllTProdItem() {

    	if( confirm('전체 삭제 하시겠습니까?') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeAllTProdItem"/>', {
            prodGrpRid : prodGrp_Rid
        },
        function(result) {
        	prodItemListGrid._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }

}

function excelDownProdItem() {
	$.ifvExcelDn('/loyalty/prodgrp/prodGrpXmExcelList.do','prodItemListGrid');
}

$(document).ready(function(){
	
	getProdItemList();
	
	$("#addProdItemBtn").click(function() {
		if(statCd!='W') {
			alert("작성중일때만 등록할 수 있습니다.");
			return;
		}
		if(tgtTypeCd=='C') {
			alert("카테고리 유형은 등록할 수 없습니다.");
			return;
		}
		
		addProdItem();
	});
	
	$("#removeProdItemBtn").click(function() {
		if(statCd!='W') {
			alert("작성중일때만 삭제할 수 있습니다.");
			return;
		}
		
		removeProdItem();
	});
	
	$("#removeAllTProdItemBtn").click(function() {
		if(statCd!='W') {
			alert("작성중일때만 삭제할 수 있습니다.");
			return;
		}
		
		removeAllTProdItem();
	});
	
	$("#excelUploadProdItemBtn").click(function() {
		if(statCd!='W') {
			alert("작성중일때만 업로드할 수 있습니다.");
			return;
		}
		
		excelUploadProdItem();
	});
	
	$("#excelDownProdItemBtn").click(function() {
		excelDownProdItem();
	});
	
	$("#excelSampleProdItemBtn").click(function() {
		excelSampleProdItem();
	});

});

</script>