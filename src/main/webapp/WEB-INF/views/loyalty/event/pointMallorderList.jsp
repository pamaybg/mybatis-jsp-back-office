<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="page-title">
    <h1>
     	주문이력
        <span>&gt; 주문 거래이력</span>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span><!-- 조회조건 -->
        </div>
        <div class="col-xs-5 searchbtn_r">
            <ifvm:inputNew type="button" btnType="search"  text="M00135"  id="pointMallSearch"/><!-- 조회 -->
            <button class="btn btn-sm" id="searchInitBtn">
                <spring:message code="M00278" /><!-- 초기화 -->
            </button>
        </div>
    </div>
     <div class="well form-horizontal well_bt5" id="pointMallSearchList" ></div>
</div>

<div>
    <div class="page_btn_area" id =''>

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span><!-- 조회결과 -->
        </div>
        <div class="col-xs-5 searchbtn_r">
         	<ifvm:inputNew type="button" text="L00326" id="clearMaskBtn" btnFunc="clearMaskAction"/><!-- 마스킹해제 -->
         	<ifvm:inputNew type="button" text="배송처리(단건)" nuc="true" id="deliverySingleBtn" btnFunc="deliverySingle"/>
         	<ifvm:inputNew type="button" text="배송처리(일괄)" nuc="true" id="deliveryBatchBtn" btnFunc="excelUploadPop"/>
         	<ifvm:inputNew type="button" text="템플릿다운로드" nuc="true" id="exceltBtn" btnFunc="excelTempDown"/><!-- 템플릿다운로드 -->
         	<ifvm:inputNew type="button" text="엑셀다운로드" nuc="true" id="excelExportBtn" btnFunc="ExcelExport"/><!-- 엑셀 다운로드 -->
        </div>
    </div>
</div>
<div>
<div class ="row white_bg">
    <div class="col-xs-10 control_content">
    	</div>
    	<div class="col-xs-2 control_content" style="text-align:right">
    		<span style="color:red;font-weight:bold;">미배송 :</span>
    		<input type="text" id="shipCnt" class="shipCnt" style="width: 80px; background-color:transparent; border:0; font-weight: bold; color: red; font-size: 12px;">
    	</div>
    </div>
	<div id="pointMallListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="popupContainer" class="popup_container"></div><!-- 팝업 -->

<script id="status" type="text/x-jquery-tmpl">
	{{if shipYn=="N" }}
		<div style="color:#FF0000";>{{:shipYn}}</div>
	{{else}}
		<div>{{:shipYn}}</div>
	{{/if}}
</script>
<script type="text/javascript">
var storeNm = null;
var pointMallList;

function pointMallListSearch(){
    var ejGridOption = {
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }
            return data;
       	},
       	loadComplete : function(obj){

       		if($.fn.ifvmIsNotEmpty(pointMallList.opt.gridControl.getRows())){
       			$("#excelExportBtn").prop('disabled',false);//엑셀 다운로드 버튼 활성화
       			if($.fn.ifvmIsEmpty(obj.getCurrentViewData()[0])){
       				$("#shipCnt").val('0');
       			}else{
       				$("#shipCnt").val(obj.getCurrentViewData()[0].shipCnt);
       			}
       		}

        },
       	dataUrl : '<ifvm:action name="getPointMallOrderList"/>',
        columns:[
        	  {
	      		  field : 'shipRid', headerText : '', headerTextAlign : 'center', textAlign: 'center', visible : false,
	      		  customAttributes : {
	      			  index : 'pps.rid'}
	      	  },{
	      		  field : 'txnRid', headerText : '' , headerTextAlign : 'center',  textAlign: 'center', visible : false,
	      		  customAttributes : {
	      			  index : 'ppt.rid'}
	      	  },{
	      		  field : 'ordNo', headerText : '주문번호', headerTextAlign : 'center', textAlign: 'center',width:'100px',
	      		  customAttributes : {
	      			  index : 'ppt.ORD_NO'} //주문번호
	      	  },{
	      		  field : 'txnDt', headerText : '주문일자', headerTextAlign : 'center', textAlign: 'center',width:'60px',
	      		  customAttributes : {
	      			  index : "TO_CHAR(ppt.TXN_DT,'YYYY-MM-DD')"}//주문일자
	      	  },{
	      		  field : 'createDate', headerText : '주문시간', headerTextAlign : 'center', textAlign: 'center',width:'60px',
	      		  customAttributes : {
	      			  index : 'pps.create_date'}//주문시간
	      	  },{
	      		  field : 'prodCd', headerText : '상품코드', headerTextAlign : 'center', textAlign: 'center',width:'50px',
	      		  customAttributes : {
	      			  index : 'lpp.PROD_CD'}//상품코드
	      	  },{
	      		  field : 'prodNm', headerText : '상품명', headerTextAlign : 'center', textAlign: 'left',width:'100px',
	      		  customAttributes : {
	      			  index : 'lpp.PROD_NM'}//상품명
	      	  },{
	      		  field : 'custNm', headerText : '수령인', headerTextAlign : 'center', textAlign: 'center',width:'50px',
	      		  customAttributes : {
	      			  index : 'pps.CUST_NM'}//수령인
	      	  },{
	      		  field : 'hhpNo', headerText : '전화번호', headerTextAlign : 'center', textAlign: 'center',width:'60px',
	      		  customAttributes : {
	      			  index : 'pps.HHP_NO'}//전화번호
	      	  },{
	      		  field : 'zipNo', headerText : '우편번호', headerTextAlign : 'center', textAlign: 'center',width:'30px',
	      		  customAttributes : {
	      			  index : 'pps.ZIP_NO'}//우편번호
	      	  },{
	      		  field : 'addr', headerText : '주소', headerTextAlign : 'center', textAlign: 'left',width:'150px',
	      		  customAttributes : {
	      			  index : 'pps.ADDR_1 || " " || pps.ADDR_2'}//주소
	      	  },{
	      		  field : 'shipYn', headerText : '배송여부', headerTextAlign : 'center', textAlign: 'center', width:'30px', template : "#status",
	      		  customAttributes : {
	      			  index : 'ppt.SHIP_YN'}//배송여부
	      	  },{
	      		  field : 'shipDt', headerText : '배송일시', headerTextAlign : 'center', textAlign: 'center',width:'60px',
	      		  customAttributes : {
	      			  index : 'ppt.SHIP_DT'}//배송일시
	      	  }
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
			  sidx : "decode(ppt.SHIP_YN, 'N', 1, 2),txn_dt",
			  sord : 'desc',
	      	  _search : false
	    },
	    rowList : [10,25,50,100],
	    radio : true
    };

    pointMallList = $("#pointMallListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//엑셀 다운로드
function ExcelExport() {
	$.ifvExcelDn('<ifvm:action name="pointMallOrderExcelDown"/>','pointMallListGrid');
}

//배송처리 단건
function deliverySingle(){
 var v_rid;

	 if ($.fn.ifvmIsNotEmpty(pointMallList.opt.gridControl.getSelectedRecords()[0])) {
	 	v_rid = pointMallList.opt.gridControl.getSelectedRecords()[0].txnRid;
	 }else {
	     alert('<spring:message code="L00066"/>');
	 }

	 if ($.fn.ifvmIsNotEmpty(v_rid)) {
		 shipYn = pointMallList.opt.gridControl.getSelectedRecords()[0].shipYn;
		 if(shipYn == 'N'){
			$.ifvSyncPostJSON('<ifvm:action name="deliverySingle"/>', {
				rid: v_rid
			},function(result) {
				pointMallListSearch();
			    alert('배송처리되었습니다.');
			});
		 }else{
			 alert('이미 배송처리된 상품입니다.');
		 }
	 }
}

//마스킹해제
function clearMaskAction() {
	 var v_rid;

	 if ($.fn.ifvmIsNotEmpty(pointMallList.opt.gridControl.getSelectedRecords()[0])) {
	 	v_rid = pointMallList.opt.gridControl.getSelectedRecords()[0].shipRid;
	 }else {
		 //마스킹을 해제할 목록을 선택하세요.
	     alert('<spring:message code="M02219"/>');
	 }

	 if ($.fn.ifvmIsNotEmpty(v_rid)) {
	     $.ifvSyncPostJSON('<ifvm:action name="clearPointMallMask"/>', {
	     	rid: v_rid
	     },
	     function(result) {
	     	var gridObj = pointMallList.opt.gridControl;
	     	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
	     	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.custNm);//이름
	     	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhpNo'), result.hhpNo);//전화번호
	     	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('addr'), result.addr);//주소
	     });
	 }
}

//엑셀 업로드
function excelUploadClose() {
	popupContainer._destroy();
}

//엑셀 업로드
function excelUploadPop() {
    $("#popupContainer").ifvsfPopup({
      enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="excelUploadOrderPop"/>',
        contentType: "ajax",
        title: '배송처리(일괄)',
        width: '600px',
        close : 'excelUploadClose'
    });
}

//공통 조회 조건 목록 설정
function pointMallAListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("pointMallSearchList","LOY_POINT_MALL_002",gridId);
    $("#pointMallSearchList #rows0 .changeTypeAreaCode select option[value='N']").attr("selected",true);
}

//공통 조회 호출
function pointMallAListSearch() {
	 $.fn.ifvmSubmitSearchCondition("pointMallSearchList", pointMallListSearch);
}

function excelTempDown(){
	var data = {};
	data.offerType = "POINT_MALL_ORDER";
	$.fn.ifvmBatchRgstExcelSampleDown2(data);
}

//샘플데이터 다운로드
$.fn.ifvmBatchRgstExcelSampleDown2 = function(data) {
	var inputs = "";
	var url = "/loyalty/batchRgst/excelSampleDown2.do";
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

$(document).ready(function() {
	pointMallAListSearchInit();

	pointMallAListSearch();

	//엑셀 다운로드 버튼 비활성화
	$("#excelExportBtn").prop('disabled',true);

	//pointMallListSearch();

	$("#searchInitBtn").on('click',function(){
		pointMallAListSearchInit('pointMallListGrid');
	});

	$("#pointMallSearch").on('click',function(){
		pointMallAListSearch();
	});

});


</script>