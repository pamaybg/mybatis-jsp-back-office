<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="excelDetailExportBtn">
                <spring:message code="M01218" />
            </button>
        </div>
        <%-- <div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="agreHistbtn" text="이력" btnFunc="" objCode=""/>
        </div> --%>
    </div>
    <div id="onlineOrderDetailGrid" class="white_bg grid_bd0"></div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="closePopBtn" objCode="">
		<spring:message code="L00941" />
	</button>
</div>

<script>
var onlineOrderDetailGrid=null;
	function onlineOrderDetailList(){
	    var ejGridOption = {
	        serializeGridData : function(data) {
	        	data.orderSeq = orderSeq;
	            return data;
	        },
	        dataUrl : '<ifvm:action name="getOnlineOrderDetail"/>',
	        columns : [
	        	{
		             field : 'goodsName', headerText : '<spring:message code="상품명"/>', headerTextAlign: 'center', width: '300px' ,textAlign : 'left', customAttributes : {index : 'goodsName',sortable: false}
		        },{
	                field : 'optionCode1', headerText : '자재코드', headerTextAlign: 'center', textAlign : 'center',width: '80px', customAttributes :{index : 'optionCode1',sortable: false}
	            },{
	                field : 'goodsCode', headerText : '상품코드',  headerTextAlign: 'center', textAlign : 'center', width: '100px',customAttributes :{index : 'goodsCode',sortable: false}
	            },{
	                field : 'price', headerText : '상품단가', format : '{0:n0}', headerTextAlign: 'center',width: '100px', textAlign : 'right', customAttributes :{index : 'price',sortable: false}
	            },{
	                field : 'ea', headerText : '수량', format : '{0:n0}', headerTextAlign: 'center',width: '100px', textAlign : 'right', customAttributes :{index : 'ea',sortable: false}
	            },{
	                field : 'memberSale', headerText : '단품회원할인', format : '{0:n0}', headerTextAlign: 'center',width: '100px', textAlign : 'right', customAttributes :{index : 'memberSale',sortable: false}
	            },{
	                field : 'memberSaleRest', headerText : '등급할인보충', format : '{0:n0}', headerTextAlign: 'center',width: '100px', textAlign : 'right', customAttributes :{index : 'memberSaleRest',sortable: false}
	            },{
	                field : 'eventSale', headerText : '이벤트할인', format : '{0:n0}', headerTextAlign: 'center',width: '100px', textAlign : 'right', customAttributes :{index : 'eventSale',sortable: false}
	            },{
	                field : 'couponSaleUnit', headerText : '쿠폰할인(개당)', format : '{0:n0}', headerTextAlign: 'center',width: '100px', textAlign : 'right', customAttributes :{index : 'couponSaleUnit',sortable: false}
	            },{
	                field : 'couponSaleRest', headerText : '쿠폰할인보충', format : '{0:n0}', headerTextAlign: 'center',width: '100px', textAlign : 'right', customAttributes :{index : 'couponSaleRest',sortable: false}
	            }
	           ],
	        requestGridData : {
	          sidx : 'T1.ITEM_SEQ',
	          sord : 'desc'
	        },
	        gridDataInit: true,
	        //radio: true,
	        tempId : 'ifvGridSimplePageTemplete'
	    };
	
	    onlineOrderDetailGrid = $("#onlineOrderDetailGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	    
	}
	
	$(document).ready(function(){
		onlineOrderDetailList();
	    $("#closePopBtn").click(function(){
	    	onlineOrderDetailPopClose();
	    });
	    
	  //엑셀다운로드
	    $("#excelDetailExportBtn").on('click', function() {
	      	$.ifvExcelDn('/kepler/report/onlineOrderPerfomDetailExcelDown.do','onlineOrderDetailGrid' );
	    });

	    
	    
	});
</script>