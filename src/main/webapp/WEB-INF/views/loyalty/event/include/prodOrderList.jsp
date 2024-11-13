<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script type="text/x-jsrender" id="mbrLinkTemplate">
		<a href="<ifvm:url name="mbrDetailNew"/>?rid={{:mbrRid}}&tabid=mbrPointMallListNew" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>
</script>

<div id="evtApplicantForm">
    <div class="page_btn_area" id=''>
    	<div class="col-sm-7">
    		<span><spring:message code = "L02615"/></span>
			<input type="text" id="orderQty" style="width: 70px; text-align: right;" value="0" readonly/>
    	</div>
        <div class="col-sm-5 searchbtn_r">

    		<button class="btn btn-sm" id="ProdOrderListSearchBtn"><i class="fa fa-search"></i>
	        	<spring:message code="M00135" />
	        </button>
	        <button class="btn btn-sm" id="ProdOrderListClearBtn">
                <spring:message code="M00278" />
            </button> 
        	<button class="btn btn-sm" id="orderMaskBtn">
            	<spring:message code ="L00326"/>
            </button>
            <button class="btn btn-sm" id="orderDownBtn">
            	<spring:message code="L02536"/>
            </button>

        </div>
    </div>
</div>
<!-- 공통 조회 조건 -->
<!-- <div class ="row white_bg">
    <div class = "col-xs-9 control_content">
		<div class="form-horizontal well_bt5" id="prodOrderList"></div>
	</div>
</div> -->

<div id="prodOrderGrid" class="white_bg grid_bd0"></div>

<script type="text/javascript">
var prodOrderGrid;
function getProdOrderList(){
	var ejGridOption = {
	      	serializeGridData : function( data ){
	      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
	      			data.item = requestitem;
	            }
	      		data.rid = pointMallRid;
	            return data;
	       	},
	       	rowSelected : function(args){
	       		
	       	},
	       	dataUrl : '<ifvm:action name="getProdOrderList"/>',
	        columns:[
	        	  {
		      		  field : 'rid', headerText : 'rid', visible : false,
		      		  customAttributes : {
		      			  index : 'ppt.RID'
		      			}/* rid */
		      	  },{
		      		  field : 'mbrRid', headerText : 'mbrRid', visible: false,
		      		  customAttributes : {
		      			  index : 'lm.RID' }/* */
		      	  },{
		      		  field : 'ordNo', headerText : '주문번호', headerTextAlign : 'center', textAlign : 'center', 
		      		  customAttributes : {
		      			  index : 'ppt.ORD_NO'
		      			} /* 주문번호 */
		      	  },{
		      		  field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', textAlign : 'center',template: "#mbrLinkTemplate",
		      		  customAttributes : {
		      			  index : 'lm.MBR_NO'
		      			} /* 회원번호 */
		      	  },{
		      		  field : 'custNm', headerText : '회원명', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 'lc.CUST_NM'
		      			,encColFlag : true} /* 회원명 */
		      	  },{
		      		  field : 'recvCustNm', headerText : '수령인', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 'lpps.CUST_NM'
		      			,encColFlag : true} /* 수령인 */
		      	  },{
		      		  field : 'recvHhpNo', headerText : '수령인 전화번호', headerTextAlign : 'center', textAlign : 'center', 
		      		  customAttributes : {
		      			  index : ' lpps.HHP_NO'
		      			,encColFlag : true}/* 수령인 전화번호 */
		      	  },{
		      		  field : 'orderDate', headerText : '주문일시', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : "TO_CHAR(ppt.CREATE_DATE,'YYYY-MM-DD HH24:MI')" 
		      				}/* 주문일시 */
		      	  },{
		      		  field : 'shipDt', headerText : '배송일시', headerTextAlign : 'center', textAlign: 'center',
		      		  customAttributes : {
		      			  index : 'ppt.SHIP_DT'
		      				}//배송일시
		      	  },{
		      		  field : 'orderStatus', headerText : '거래상태', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : "cc1.MARK_NAME" 
		      			,encColFlag : false}/* 거래상태 */
		      	  }
	        ],
	        requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : "TO_CHAR(ppt.CREATE_DATE,'YYYY-MM-DD HH24:MI')",
		      	  sord : 'desc',
		      	  _search : false
		    },
		    rowList : [10,25,50,100],
	        autowidth : true ,
	        radio : true
	    };
	prodOrderGrid = $("#prodOrderGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


//마스킹해제
function clearMaskAction() {
	var v_rid;
    if ($.fn.ifvmIsNotEmpty(prodOrderGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = prodOrderGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="getprodOrderMaskList"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = prodOrderGrid.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.custNm);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('recvCustNm'), result.recvCustNm);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('recvHhpNo'), result.recvHhpNo);
        });
    }
}

function getOrderQty(){
	var prid;
    $.ifvSyncPostJSON('<ifvm:action name="getProdOrderList"/>', {
			rid : pointMallRid
	    }, function(result) {
	    	if ($.fn.ifvmIsNotEmpty(result.rows)) {
				if (result.rows[0].tranSactionCnt == 0 || result.rows[0].tranSactionCnt == "") {
					$('#orderQty').val(0);
				} else{
					$('#orderQty').val(result.rows[0].tranSactionCnt);
				}
	    	}
		},function(result){
			alert('<spring:message code="L02632"/>');
		});
}

//공통 조회 조건 목록 설정
function searchProdOrderListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("prodOrderList","LOY_POINT_MALL_POL",gridId);
}

//공통 조회 호출
function searchProdOrderListSearch() {
    $.fn.ifvmSubmitSearchCondition("prodOrderList", getProdOrderList);
    getOrderQty();
}


$(document).ready(function() {
	getProdOrderList();
	
	getOrderQty();
	
	/* 공통 조건 조회 */
/* 	searchProdOrderListSearchInit();
	searchProdOrderListSearch();
	
    $('#ProdOrderListSearchBtn').on('click', function(){
    	searchProdOrderListSearch();
    });
    
    $("#ProdOrderListClearBtn").on('click', function(){
    	searchProdOrderListSearchInit("prodOrderGrid");
    }); */
	
	$('#orderMaskBtn').on('click',function(){
		clearMaskAction();
	});

	$('#orderDownBtn').on('click',function(){
		$.ifvExcelDn('<ifvm:action name="getOrderExcelDown"/>','prodOrderGrid');
	});
});

</script>
