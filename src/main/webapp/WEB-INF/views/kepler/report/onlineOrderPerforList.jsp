<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="page-title">
    <h1>
    	정형 Report &gt; 락앤락몰 실적 데이터(I/F)
    </h1>
</div>

<%-- 조회조건 영역 --%>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="onlineOrderSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="onlineOrderSearchInitBtn">
                <spring:message code="M00278" />
            </button>
        </div>


	</div>
	<div class="well form-horizontal well_bt5" id="reportSearchCondition" >
		<div class="row qt_border">
			<label class="col-xs-1 control-label"> 인터페이스 날짜 </label>
			<ifvm:inputNew type="date" id="sellDate1" conClass="1" />
			<div style="float: left"> ~ </div>
			<ifvm:inputNew type="date" id="sellDate2" conClass="1" />	
			
			<label class="col-xs-1 control-label"> 주문번호 </label>
			<ifvm:inputNew type="text" id="orderSeq" conClass="2" />
			
			<label class="col-xs-1 control-label"> 회원상세유형 </label>
			<ifvm:inputNew type="select" id="mbrTypeCd" names="mbrTypeCd" conClass="1" />
			
		 </div>
		 
		 <div class="row qt_border">
		 	<label class="col-xs-1 control-label"> 주문접수일자 </label>
			<ifvm:inputNew type="date" id="registDate1" conClass="1" />
			<div style="float: left"> ~ </div>
			<ifvm:inputNew type="date" id="registDate2" conClass="1" />
	
		 	<label class="col-xs-1 control-label"> 가입유형 </label>
			<ifvm:inputNew type="select" id="sbscTypeCd" names="sbscTypeCd" conClass="1" />
			
		 	<label class="col-xs-2 control-label"> 회원상태 </label>
			<ifvm:inputNew type="select" id="mbrStatCd" names="mbrStatCd" conClass="1" /> 
			
			
		 </div>
		 
		 <div class="row qt_border">
		 	<label class="col-xs-1 control-label"> 입금일자 </label>
			<ifvm:inputNew type="date" id="depositDate1" conClass="1" />
			<div style="float: left"> ~ </div>
			<ifvm:inputNew type="date" id="depositDate2" conClass="1" />
			
			<label class="col-xs-1 control-label"> 주문상태 </label>
			<ifvm:inputNew type="select" id="step" names="step" conClass="1" />
			
			<label class="col-xs-2 control-label"> 고객유형 </label>
			<ifvm:inputNew type="select" id="custTypeCd" names="custTypeCd" conClass="1" />
		 </div>
    </div>
	</div>

<%-- 그리드 영역 --%>
<div>
    <div class="page_btn_area" >

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="onlineOrderDetailBtn">
                <spring:message code="상세보기" />
            </button>
            <button class="btn btn-sm" id="excelExportBtn">
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
   <div id="onlineOrderPerfomListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="onlineOrderDetailPop" class="popup_container"></div>

<script  type="text/x-jsrender" id="custTypeCdNm">
{{if custTypeCdNm == ""}} {{:custTypeCd}}
{{else}} {{:custTypeCdNm}}
{{/if}}
</script>   
<script  type="text/x-jsrender" id="mbrTypeCdNm">
{{if mbrTypeCdNm == ""}} {{:mbrTypeCd}}
{{else}} {{:mbrTypeCdNm}}
{{/if}}
</script>

<script  type="text/x-jsrender" id="sbscTypeCdNm">
{{if sbscTypeCdNm == ""}} {{:sbscTypeCd}}
{{else}} {{:sbscTypeCdNm}}
{{/if}}
</script>
<script  type="text/x-jsrender" id="mbrStatCdNm">
{{if mbrStatCdNm == ""}} {{:mbrStatCd}}
{{else}} {{:mbrStatCdNm}}
{{/if}}
</script>   

<script type="text/javascript">
var onlineOrderPerfomListGrid;
var orderSeq=null;
function getOnlineOrderPerfomList(){
    var ejGridOption = {
           serializeGridData : function(data) {
        	   data.sellDate1 = $('#sellDate1').val();
       	   	   data.sellDate2 = $('#sellDate2').val();
       	   	   data.registDate1 = $('#registDate1').val();
       	   	   data.registDate2 = $('#registDate2').val();
       	   	   data.depositDate1 = $('#depositDate1').val();
       	   	   data.depositDate2 = $('#depositDate2').val();
       	   	   data.orderSeq = $('#orderSeq').val().trim();
       	   	   data.step = $('#step').val();
       	   	   data.custTypeCd = $('#custTypeCd').val();
       	   	   data.sbscTypeCd = $('#sbscTypeCd').val();
       	   	   data.mbrStatCd = $('#mbrStatCd').val();
       	       data.mbrTypeCd = $('#mbrTypeCd').val();
               return data;
             },rowSelected : function(args) {
            	 orderSeq = args.data.orderSeq;
             },
          dataUrl : '<ifvm:action name="getOnlineOrderPerfomList"/>',
          columns:[
          	    {
                   field : 'yyyymmdd' ,headerText : '인터페이스 날짜', headerTextAlign : 'center', textAlign: 'center', width :'100px',
                   customAttributes : {
                      index : 'yyyymmdd' , sortable: false}/*  */
                },{
                   field : 'registDate' ,headerText : '주문접수일자', headerTextAlign : 'center', textAlign: 'center', width :'100px',format : "{0:MM/dd/yyyy}",
                   customAttributes : {
                      index : 'registDate' , sortable: false}/*  */
                },{
                    field : 'depositDate' ,headerText : '입금일자', headerTextAlign : 'center', textAlign: 'center', width :'120px',format : "{0:MM/dd/yyyy}",
                    customAttributes : {
                       index : 'depositDate' , sortable: false}/*  */
                 },{
                   field : 'orderSeq', headerText : '주문번호', headerTextAlign : 'center', textAlign: 'center',width:'140px',
                   customAttributes : {
                      index : 'orderSeq' , sortable: false}/* */
                },{
                   field : 'step', headerText : '주문상태', headerTextAlign : 'center', textAlign: 'center', width :'80px',
                   customAttributes : {
                      index : 'stepCd' , sortable: false}/*   */
                },{
                    field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', textAlign: 'center', width :'80px',
                    customAttributes : {
                       index : 'mbrNo' , sortable: false}/*   */
                 },{
                   field : 'custTypeCdNm', headerText : '고객유형', headerTextAlign : 'center', textAlign: 'center', width :'60px',template:"#custTypeCdNm",
                   customAttributes : {
                      index : 'custTypeCd' , sortable: false}/* */
                },{
                    field : 'mbrTypeCdNm', headerText : '회원상세유형', headerTextAlign : 'center', textAlign: 'center', width :'80px',template:"#mbrTypeCdNm",
                    customAttributes : {
                       index : 'mbrTypeCd' , sortable: false}/*  */
                },{
                    field : 'sbscTypeCdNm', headerText : '가입유형', headerTextAlign : 'center', textAlign: 'center', width :'60px',template:"#sbscTypeCdNm",
                    customAttributes : {
                       index : 'sbscTypeCd' , sortable: false}/*  */
                },{
                    field : 'mbrStatCdNm', headerText : '회원상태', headerTextAlign : 'center', textAlign: 'center', width :'60px',template:"#mbrStatCdNm",
                    customAttributes : {
                       index : 'mbrStatCd' , sortable: false}/*  */
                },{
                    field : 'sellAmt', headerText : '판매금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width :'60px',
                    customAttributes : {
                       index : 'sellAmt' , sortable: false}/*  */
                },{
                    field : 'discntAmt', headerText : '할인금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width :'60px',
                    customAttributes : {
                       index : 'discntAmt' , sortable: false}/*  */
                },{
                    field : 'settleAmt', headerText : '실결제금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width :'60px',
                    customAttributes : {
                       index : 'sellAmt' , sortable: false}/*  */
                },{
                    field : 'shippingCost', headerText : '배송비', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width :'60px',
                    customAttributes : {
                       index : 'shippingCost' , sortable: false}/*  */
                },{
                    field : 'emoney', headerText : '사용적립금', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width :'60px',
                    customAttributes : {
                       index : 'emoney' , sortable: false}/*  */
                }
          ],
          requestGridData : {
          	  nd   : new Date().getTime(),
          	  rows : 10,
          	  sidx : '1 DESC , 4,5',
          	  _search : false,
         },
         rowList : [10,25,50,100],
         gridDataInit: true,
         radio: false,
         allowResizing: true,
         tempId : 'ifvGridNoneLeftTemplete'
      };
    onlineOrderPerfomListGrid = $("#onlineOrderPerfomListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
}

function onlineOrderDetail(){
    var v_rid = null;
    if ($.fn.ifvmIsNotEmpty(onlineOrderPerfomListGrid.opt.gridControl.getSelectedRecords()[0])) {
        v_rid = onlineOrderPerfomListGrid.opt.gridControl.getSelectedRecords()[0].orderSeq;
    }
    else {
        alert('<spring:message code="M00004"/>');
    }
    if ($.fn.ifvmIsNotEmpty(v_rid)) {
		    $("#onlineOrderDetailPop").ifvsfPopup({
		        enableModal : true,
		        enableResize: false,
		        contentUrl: '<ifvm:url name="onlineOrderDetailPop"/>',
		        contentType: "ajax",
		        title: '온라인몰 실적 상세 현황',
		        width: 1500,
		        maxWidth : 1500,
		        close : 'onlineOrderDetailPopClose'
		    });
    }
}

function onlineOrderDetailPopClose(){
	onlineOrderDetailPop._destroy();
}  

function searchCondInit(){
	
	
	var date01 = $('#sellDate1');
	var date02 = $('#sellDate2');
	date01.val($.ifvGetNewDate('d', -1).newDateS);
	date02.val($.ifvGetTodayDate());
	
	
	$("#step").val("ALL");
	$("#custTypeCd").val("ALL");
	$("#mbrTypeCd").val("ALL");
	$("#sbscTypeCd").val("ALL");
	$("#mbrTypeCd").val("ALL");
	
	
}

function setDatePicker() {
	
	var date1 = $('#sellDate1');
	var date2 = $('#sellDate2');
	date1.val($.ifvGetNewDate('d', -1).newDateS);
	date2.val($.ifvGetTodayDate());
	date1.ifvDateChecker({});
	date2.ifvDateChecker({});
	
	var date3 = $('#registDate1');
	var date4 = $('#registDate2');
	date3.ifvDateChecker({});
	date4.ifvDateChecker({});
	
	var date5 = $('#depositDate1');
	var date6 = $('#depositDate2');
	date5.ifvDateChecker({});
	date6.ifvDateChecker({});
}

//조회조건 set
function commcodeSetting(){
		//구분

	   $.fn.ifvmSetSelectOptionCommCode("step", "LOY_PUR_STAT_CD", null, null, true);
	   $("#step").append("<option value='ALL'>전체</option>")
	   $("#step").val("ALL");
	   
	   $.fn.ifvmSetSelectOptionCommCode("custTypeCd", "LOY_CUST_TYPE_CD", null, null, true);
	   $("#custTypeCd").append("<option value='ALL'>전체</option>")
	   $("#custTypeCd").val("ALL");
	   
	   $.fn.ifvmSetSelectOptionCommCode("mbrTypeCd", "LOY_MBR_TYPE_CD", null, null, true);
	   $("#mbrTypeCd").append("<option value='ALL'>전체</option>")
	   $("#mbrTypeCd").val("ALL");
	   
	   $.fn.ifvmSetSelectOptionCommCode("sbscTypeCd", "LOY_SBSC_TYPE_CD", null, null, true);
	   $("#sbscTypeCd").append("<option value='ALL'>전체</option>")
	   $("#sbscTypeCd").val("ALL");
	   
	   $.fn.ifvmSetSelectOptionCommCode("mbrStatCd", "LOY_MBR_STAT_CD", null, null, true);
	   $("#mbrStatCd").append("<option value='ALL'>전체</option>")
	   $("#mbrStatCd").val("ALL");

	}



$(document).ready(function() {
	commcodeSetting();
	setDatePicker();
	
	searchCondInit();
	
	getOnlineOrderPerfomList();

    //조회
    $('#onlineOrderSearchBtn').on('click', function(){
    	getOnlineOrderPerfomList();
    });

    //초기화
    $("#onlineOrderSearchInitBtn").on('click', function(){
    	searchCondInit();
    }); 
    
    
	//엑셀다운로드
    $("#excelExportBtn").on('click', function() {
      	$.ifvExcelDn('/kepler/report/onlineOrderPerfomListExcelDown.do','onlineOrderPerfomListGrid' );
    });
	
    //상세보기
    $("#onlineOrderDetailBtn").on('click', function(){
    	onlineOrderDetail();
    }); 
	
	
	
});
</script>