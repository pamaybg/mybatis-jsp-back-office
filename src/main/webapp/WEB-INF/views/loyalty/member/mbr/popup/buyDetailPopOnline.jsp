<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style type="text/css">
.descript{
	width : 98%;
	height: 10%;
	font-size: 13px;
	box-sizing: border-box;
	margin: 10px;
	padding: 10px;

}
#mbrTxnHist {
 min-height : 0px;
 
}


 #buyDetailPopupOnline_title {
	width : 1620px;
 	max-width: 1620px;
}


 


</style>

<div class ="row white_bg">
    <div id="buyDetailSelectGrid" class="white_bg grid_bd0"></div>
</div>  
<div id="mbrTxnHist" class="white_bg grid_bd0"></div>
         <div class="page_btn_area" >
   		<div class="col-xs-9">
		 <span>용어설명</span>
    	</div>
    </div>
<textarea id="desc" class = "descript" maxlength="100" rows="6" readonly = true>
• 정상가총액 : 정상가 * 수량
• 실결제금액 : 정상가총액  - 총할인금액
• 총할인금액 : 1.오프라인 : 오프라인할인 + 사용적립금 
                     2.온라인     : 온라인할인(회원+이벤트+쿠폰) + 사용적립금
</textarea>
<div id="contsListPopWrap">
    <div class="pop_btn_area">
        <!-- 닫기 --> 
        <button class="btn btn-sm btn_lightGray2" id="cancelBtn" objCode="buyDetailPopCancel_OBJ">         
            <spring:message code="M00441"/>
        </button> 
    </div>
</div>

<script>
	function buyDetailSelect(){
	    var ejGridOption = {
	        serializeGridData : function(data) {
	            data.rid = rid;
                data.srcType=srcType;
	            return data;
	        },
	        dataUrl : '<ifvm:action name="buyDetailSelectOnline"/>',
	        columns : [
	        	{
	                field : 'cancelYn', headerText : '구분',  headerTextAlign: 'center', textAlign : 'center', width: '50px',customAttributes :{index : 'goodsCd',sortable: false}
	            },
	        	{
		             field : 'goodNm', headerText : '<spring:message code="상품명"/>', headerTextAlign: 'center', width: '220px' ,textAlign : 'left', customAttributes : {index : 'prodNm',sortable: false}
		        },
	            {
	                 field : 'uPrice', headerText : '<spring:message code="정상가"/>', format : '{0:n0}',width: '80px' ,  headerTextAlign: 'center',  textAlign : 'right', customAttributes : {index : 'uPrice',sortable: false}
	            }
	            ,{
	                field : 'saleQty', headerText : '<spring:message code="수량"/>', headerTextAlign: 'center', width: '40px',textAlign : 'right', customAttributes : {index : 'saleQty',sortable: false}
	            } 
	            ,{
	                field : 'saleTot', headerText : '<spring:message code="정상가총액"/>', format : '{0:n0}',width: '80px' , headerTextAlign: 'center', textAlign : 'right', customAttributes : {index : 'saleTot',sortable: false}
	            },{
	                field : 'settleAmt', headerText : '<spring:message code="실결제금액"/>', format : '{0:n0}',width: '80px', headerTextAlign: 'center', textAlign : 'right', customAttributes : {index : 'dcAmt',sortable: false}
	            }
	            ,{
	                field : 'discntAmt', headerText : '<spring:message code="총할인금액"/>', format : '{0:n0}',width: '80px', headerTextAlign: 'center', textAlign : 'right', customAttributes : {index : 'dcAmt',sortable: false}
	            }
	            ,{
	                field : 'offlineDC', headerText : '오프라인할인', format : '{0:n0}', headerTextAlign: 'center', width: '100px',textAlign : 'right', customAttributes :{index : 'saleAmt',sortable: false}
	              }
	            ,{
	                field : 'mbrSale', headerText : '온라인회원할인', format : '{0:n0}', headerTextAlign: 'center',width: '100px', textAlign : 'right', customAttributes :{index : 'saleAmt',sortable: false}
	              }
	            ,{
	                field : 'eventSale', headerText : '온라인이벤트할인', format : '{0:n0}', headerTextAlign: 'center',width: '110px', textAlign : 'right', customAttributes :{index : 'saleAmt',sortable: false}
	              }
	            ,{
	                field : 'couponSale', headerText : '온라인쿠폰할인', format : '{0:n0}', headerTextAlign: 'center',width: '100px', textAlign : 'right', customAttributes :{index : 'saleAmt',sortable: false}
	              }
	            ,{
	                field : 'pointAmt', headerText : '사용적립금', format : '{0:n0}', headerTextAlign: 'center',width: '80px', textAlign : 'right', customAttributes :{index : 'saleAmt',sortable: false}
	              }
	            ,{
	                field : 'salePoint', headerText : '발생적립금', format : '{0:n0}', headerTextAlign: 'center', width: '80px',textAlign : 'right', customAttributes :{index : 'saleAmt',sortable: false}
	              }
	            ,{
	                field : 'prodId', headerText : '자재코드', headerTextAlign: 'center', textAlign : 'center',width: '80px', customAttributes :{index : 'prodId',sortable: false}
	              }       
	            ,{
	                field : 'mmZzItemCd', headerText : '아이템코드', headerTextAlign: 'center', textAlign : 'center',width: '100px', customAttributes :{index : 'mmZzItemCd',sortable: false}
	              } 
	            ,{
	                field : 'goodsCd', headerText : '상품코드',  headerTextAlign: 'center', textAlign : 'center', width: '100px',customAttributes :{index : 'goodsCd',sortable: false}
	              }
	           ],
	        requestGridData : {
	          sidx : 'T2.SELL_TYPE_CD,T2.ITEM_SEQ',
	          sord : 'asc'
	        },
	        gridDataInit: true,
	        //radio: true,
	        tempId : 'ifvGridSimplePageTemplete'
	    };
	
	    buyDetailSelectGrid = $("#buyDetailSelectGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	    
	}
	
	$(document).ready(function(){
	    buyDetailSelect();
	    $("#cancelBtn").click(function(){
	    	buyDetailPopCloseOnline();
	    });

	    
	    
	});
</script>