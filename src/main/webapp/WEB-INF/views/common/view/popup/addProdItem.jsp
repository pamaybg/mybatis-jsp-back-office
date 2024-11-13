<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="prodListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnProdPopSelect" objCode="addProdItemSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnProdPopCancel" objCode="addProdItemCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var prodListGrid = null;

function getProdList(){
	var ejGridOption = {
		rowSelected : function (args) {
			var data = args.data;
			
        },
		serializeGridData : function( data ){
			return data;
		},
		dataUrl : '<ifvm:action name="getProdListItemPop"/>',
       	columns: [
       	   {
               field : 'prodId', headerText : '<spring:message code="E00091"/>', textAlign : 'center', width: 100
               ,headerTextAlign : ej.TextAlign.Center,customAttributes : {index : 'prodId' }//자재코드 
           }                  
           ,{
               field : 'mmZzstdItemCd', headerText : '<spring:message code="E00100"/>', textAlign : 'center', width: 120
               ,headerTextAlign : ej.TextAlign.Center,customAttributes : {index : 'mmZzstdItemCd' }//표준아이템코드
           }
           ,{
               field : 'mmZzItemCd', headerText : '<spring:message code="E00101"/>', textAlign : 'center' , width: 120
               ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'mmZzItemCd' }//아이템코드
           
           }
           ,{
               field : 'mmZzRepCd1', headerText : '<spring:message code="E00102"/>', textAlign : 'center' , width: 120
               ,headerTextAlign : ej.TextAlign.Center,customAttributes : {index : 'mmZzRepCd1' }//수요할당코드
           }
           ,{
               field : 'mmZzRepCd2', headerText : '<spring:message code="E00103"/>', textAlign : 'center' , width: 100
               ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'mmZzRepCd2' }//대체코드
           }
           ,{
               field : 'mmSkuCd', headerText : '<spring:message code="E00104"/>', textAlign : 'center' , width: 120
               ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'mmSkuCd' }//SKU채널코드
           }
           ,{
               field : 'prodNm', headerText : '<spring:message code="E00105"/>', textAlign : ej.TextAlign.Left, width: 400
               ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'prodNm' }//자재이름
           }
           ,{
               field : 'shGoodsCode', headerText : '<spring:message code="E00107"/>', textAlign : 'center', width: 100
               ,headerTextAlign : ej.TextAlign.Center    ,customAttributes : {index : 'shGoodsCode' }//상품코드
           }
           ,{
               field : 'shGoodsName', headerText : '<spring:message code="E00108"/>', textAlign : 'left', width: 400
               ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'shGoodsName' }//상품명 제품명 코드
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
       		,{
       			field: 'rid', headerText: 'rid', visible: false,
       		}
       	],
        requestGridData : {
            sidx : '1',
            sord : 'desc'
          },
          rowList : [10,25,50,100],
          radio: true,
          tempId : 'ifvGridSimplePageTemplete',
          isHorizontalScroll : true,
          allowResizing: true
    };

    prodListGrid = $("#prodListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getProdList();
	
	$("#btnProdPopSelect").click(function(){
    		var add_rid = [];
    		var checkedList = prodListGrid.opt.gridControl.getSelectedRecords();
    		if (checkedList.length == 0) {
    			alert('<spring:message code="M00285"/>');
    		}else{
    			for(var i = 0; i < checkedList.length; i++){
    				var rowData = {
    						prodRid : checkedList[i].rid
    				};
    				add_rid.push(rowData);
    			}
    	          $.ifvSyncPostJSON('<ifvm:action name="addProdItem"/>', {
    	                prodGrpRid : prodGrp_Rid,
    	                ridList : add_rid
    	            }, function(result) {
    	                alert(result.message);
    	                $.fn.ifvmPopupClose();
    	                prodItemListGrid._doAjax();

    	            });
    		}
	});
	
	$("#btnProdPopCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
});
</script>