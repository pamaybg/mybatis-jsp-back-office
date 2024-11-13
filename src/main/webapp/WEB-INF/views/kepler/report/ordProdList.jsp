<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="page-title">
    <h1>
    	정형 Report &gt; 상품 아이템별 현황
    </h1>
</div>

<%-- 조회조건 영역 --%>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="reportSearchBtn" objCode="ordProdListSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="reportSearchInitBtn" objCode="ordProdListSearchInit_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>


	</div>
	<div class="form-horizontal underline top_well"	id="reportSearchCondition">
		<div class="row qt_border">
			<label class="col-xs-1 control-label"> 일자 </label>
			<ifvm:inputNew type="date" id="sellDate1" conClass="2" />
			<div style="float: left"> ~ </div>
			<ifvm:inputNew type="date" id="sellDate2" conClass="2" />
			<label class="col-xs-1 control-label">통합회원유형</label>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="checkBox" id="custTypeI" label="개인" labelClass="2" conClass="1"/>
			 	<ifvm:inputNew type="checkBox" id="custTypeC" label="법인" labelClass="2" conClass="1"/>
				<ifvm:inputNew type="checkBox" id="custTypeE" label="임직원" labelClass="2" conClass="1"/>
<%-- 				<ifvm:inputNew type="checkBox" id="custTypeOD" label="기타" labelClass="2" conClass="1"/>		
 --%>			</div>
		 </div>
		 <div class="row qt_border">
			<label class="col-xs-1 control-label"> 구분 </label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="chnlType" names="chnlType" dto="chnlType" />
			</div>
 			<label class="col-xs-1 control-label"> 회원 </label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="mbrType" names="mbrType" dto="mbrType" />
			</div> 
			<label class="col-xs-1 control-label"> 자재코드 </label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="text" id="prodId" names="prodId" dto="prodId" />
			</div>
			<label class="col-xs-1 control-label"> 아이템코드 </label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="text" id="itemCd" names="itemCd" dto="itemCd" />
			</div>
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
            <button class="btn btn-sm" id="excelExportBtn" objCode="ordProdListExcel_OBJ">
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
   <div id="ordProdListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="chnlListPopDialog" class="popup_container"></div>

<script type="text/javascript">
var ordProdListGrid;
var sumobj  = {};
var sumojb2 = {};
var summaryValue = {};

function getCustomSummary(){
	  sumobj = {};
	   var custTypeI = $("#custTypeI").is(':checked') ? 'I' : '';
	   var custTypeC = $("#custTypeC").is(':checked') ? 'C' : '';
	   var custTypeE = $("#custTypeE").is(':checked') ? 'E' : '';

	   $.ifvSyncPostJSON('<ifvm:action name="getOrdProdpurMbrCnt"/>',{
	    yyyymm : $('#year').val()+$('#month').val(),
        chnlType : $('#chnlType').val(),
        custTypeI : custTypeI,
        custTypeC : custTypeC,
        custTypeE : custTypeE,
        sellDate1 :  $('#sellDate1').val(),
        sellDate2 : $('#sellDate2').val(),
        prodId :$('#prodId').val(),
        itemCd :$('#itemCd').val(),
        mbrTypeCd :$('#mbrType').val(),
        rid : $("#rid").val()
		},
		function(result) {
			var putMbrCntTot=0;
			for(var i= 0; i< result.rows.length;i++){
			  if($("#chnlType").val()=="ALL"){  //채널 구분 전체일때
				       putMbrCntTot += result.rows[i].purMbrCnt;
			  }	else if($("#chnlType").val()=="M"){  //채널 구분 오프라인일때
					if( result.rows[i].chnlType=="MALL"){
						putMbrCntTot += result.rows[i].purMbrCnt;
					}
				}else if($("#chnlType").val()=="S"){ //채널 구분 온라인일때
					if(result.rows[i].chnlType=="POS"){
						putMbrCntTot += result.rows[i].purMbrCnt;
					}
				}
			} 
	        sumobj = {purMbrCnt: putMbrCntTot};
		});
}

 
 function currency(args,data){
	return sumobj[args.displayColumn];
} 

 function getCustomSummary2(){
	  sumobj2 = {};
	   var custTypeI = $("#custTypeI").is(':checked') ? 'I' : '';
	   var custTypeC = $("#custTypeC").is(':checked') ? 'C' : '';
	   var custTypeE = $("#custTypeE").is(':checked') ? 'E' : '';

	   $.ifvSyncPostJSON('<ifvm:action name="getOrdProdList2"/>',{
	    yyyymm : $('#year').val()+$('#month').val(),
       chnlType : $('#chnlType').val(),
       custTypeI : custTypeI,
       custTypeC : custTypeC,
       custTypeE : custTypeE,
       sellDate1 :  $('#sellDate1').val(),
       sellDate2 : $('#sellDate2').val(),
       prodId :$('#prodId').val(),
       itemCd :$('#itemCd').val(),
       mbrTypeCd :$('#mbrType').val(),
       rid : $("#rid").val()
		},
		function(result) {
			sumobj2 = result.rows[0]; 

		});
}
 function currency2(args,data){
		return sumobj2[args.displayColumn];
	} 

function getOrdProdList(){
    var ejGridOption = {
           serializeGridData : function(data) {
        	   	data.sellDate1 = $('#sellDate1').val();
        	   	data.sellDate2 = $('#sellDate2').val();
        	   	
                data.chnlType = $('#chnlType').val();

                data.custTypeI = $("#custTypeI").is(':checked') ? 'I' : '';
                data.custTypeC = $("#custTypeC").is(':checked') ? 'C' : '';
                data.custTypeE = $("#custTypeE").is(':checked') ? 'E' : '';
            	data.chnlType = $("#chnlType").val();

   	
                data.prodId = $('#prodId').val();
                data.itemCd = $('#itemCd').val();
                
                data.mbrTypeCd = $('#mbrType').val();
                
                return data;
             },
          showSummary: true,
          summaryRows: [{
              title: "합계",
              summaryColumns: [
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "purMbrCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency2, displayColumn: "ordCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency2, displayColumn: "settleAmt",  format: "{0:n0}"}
                           ]
          }],
          dataUrl : '<ifvm:action name="getOrdProdList"/>',
          columns:[
          	    {
                   field : 'prodId' ,headerText : '자재코드', headerTextAlign : 'center', textAlign: 'center', width :'200px',
                   customAttributes : {
                      index : 'prodId' , sortable: false}/*  */
                },{
                   field : 'itemCd' ,headerText : '아이템코드', headerTextAlign : 'center', textAlign: 'center', width :'200px',
                   customAttributes : {
                      index : 'itemCd' , sortable: false}/*  */
                },{
                   field : 'prodNm', headerText : '상품명', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                   customAttributes : {
                      index : 'totCnt' , sortable: false}/* */
                },{
                   field : 'purMbrCnt', headerText : '구매회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width :'140px',
                   customAttributes : {
                      index : 'purMbrCnt' , sortable: false}/*   */
                },{
                   field : 'ordCnt', headerText : '판매수량', headerTextAlign : 'center', textAlign: 'right',  format : '{0:n0}', width :'140px',
                   customAttributes : {
                      index : 'ordCnt' , sortable: false}/* */
                },{
                    field : 'settleAmt', headerText : '실결제금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width :'170px',
                    customAttributes : {
                       index : 'settleAmt' , sortable: false}/*  */
                }
          ],
          requestGridData : {
          	  nd   : new Date().getTime(),
          	  rows : 10,
          	  sidx : '1',
          	  sord : 'asc',
          	  _search : false,
         },
         rowList : [10,25,50,100],
         gridDataInit: true,
         radio: false,
         tempId : 'ifvGridSimplePageTemplete2'
      };
      ordProdListGrid = $("#ordProdListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
}


//조회조건 set
function commcodeSetting(){

	  $("#custTypeI").prop('checked',true);
	  
	   $.fn.ifvmSetSelectOptionCommCode("chnlType", "LOY_CHNL_TYPE_CD", null, null, true);
	   $("#chnlType").append("<option value='ALL'>전체</option>")
	   $("#chnlType").val("ALL");

 	   $("#mbrType").append("<option value='ALL'>전체</option>")
	   $("#mbrType").append("<option value='MEMBER'>회원</option>")
	   $("#mbrType").append("<option value='NOMEMBER'>비회원</option>") 
	   
	   
	}

function searchCondInit(){
	
	
	var date01 = $('#sellDate1');
	var date02 = $('#sellDate2');
	date01.val($.ifvGetTodayDate());
	date02.val($.ifvGetTodayDate());
	
	$("#custTypeI").prop('checked',true);
	$("#custTypeC").prop('checked',false);
	$("#custTypeE").prop('checked',false);
/* 	$("#custTypeOD").prop('checked',false); */

	$("#prodId").val("");
	$("#itemCd").val("");
	$("#chnlType").val("ALL");
	$("#mbrType").val("ALL");
	
}


function setDatePicker() {
	
	var date1 = $('#sellDate1');
	var date2 = $('#sellDate2');
	date1.val($.ifvGetTodayDate());
	date2.val($.ifvGetTodayDate());
	date1.ifvDateChecker({});
	date2.ifvDateChecker({});
}


$(document).ready(function() {
	
	commcodeSetting();
	setDatePicker();
	getOrdProdList();
	
	
	$('#chnlType').find('[value=P]').hide();
	$('#chnlType').find('[value=E]').hide();
	//조회
    $('#reportSearchBtn').on('click', function(){
    	if($("#mbrType").val() !="NOMEMBER"){
    		getCustomSummary();
    		getCustomSummary2();
    	}else{
    		 sumobj ={purMbrCnt: 0};
    	}
    	getOrdProdList();
    });

    //초기화
    $("#reportSearchInitBtn").on('click', function(){
    	searchCondInit();
    }); 
    
   
    $('#mbrType').on('change',function(){
    	
    	if($('#mbrType').val() == 'NOMEMBER'){
    		$("#custTypeI").prop('checked',false);
		 	$("#custTypeC").prop('checked',false);
		 	$("#custTypeE").prop('checked',false);
		 	//$("#custTypeOD").prop('checked',false);
    		 //$("#custTypeI").prop('disabled',true);
    		 //$("#custTypeC").prop('disabled',true);
    		 //$("#custTypeE").prop('disabled',true);
    	}else if($('#mbrType').val() == 'MEMBER'){
   		 	$("#custTypeI").prop('checked',true);
		 	$("#custTypeC").prop('checked',true);
		 	$("#custTypeE").prop('checked',true);
		 	//$("#custTypeOD").prop('checked',true);

    	}
    	else{
    		$("#custTypeI").prop('checked',true);
		 	$("#custTypeC").prop('checked',false);
		 	$("#custTypeE").prop('checked',false);
		 	//$("#custTypeOD").prop('checked',false);

    		 //$("#custTypeI").prop('disabled',false);
    		//$("#custTypeC").prop('disabled',false);
    		 //$("#custTypeE").prop('disabled',false);
    	}
    	
    });
    
	//엑셀다운로드
    $("#excelExportBtn").on('click', function() {
      	$.ifvExcelDn('/kepler/report/ordProdListExcelDown.do','ordProdListGrid' );
    });
	
	
});
</script>