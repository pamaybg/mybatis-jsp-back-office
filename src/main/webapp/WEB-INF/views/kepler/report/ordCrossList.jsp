<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="page-title">
    <h1>
    	정형 Report &gt; 교차쇼핑 현황
    </h1>
</div>

<%-- 조회조건 영역 --%>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="reportSearchBtn" objCode="ordCrossListSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="reportSearchInitBtn" objCode="ordCrossListSearchInit_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>


	</div>
	<div class="form-horizontal underline top_well"	id="reportSearchCondition">
		<div class="row qt_border">
			<label class="col-xs-1 control-label"  id="labelTab">년</label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="year" names="year" dto="year" />
			</div>
			<label class="col-xs-1 control-label"  id="labelTab">월</label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="month" names="month" dto="month" />
			</div>
			<label class="col-xs-1 control-label">통합회원유형</label>
			<div class="col-xs-3 control_content" id="tabtype">
				<ifvm:inputNew type="checkBox" id="custTypeI" 
					label="개인" labelClass="2" conClass="1"/>
			 	<ifvm:inputNew type="checkBox" id="custTypeC" 
					label="법인" labelClass="2" conClass="1"/>
	<%-- 			<ifvm:inputNew type="checkBox" id="custTypeOD" 
					label="기타" labelClass="2" conClass="1"/>	 --%>			
			</div>
			<label class="col-xs-1 control-label">회원등급</label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="checkBox" id="tierW" 
					label="VVIP" labelClass="2" conClass="1"/>
			 	<ifvm:inputNew type="checkBox" id="tierV" 
					label="VIP" labelClass="2" conClass="1"/>
				<ifvm:inputNew type="checkBox" id="tierL" 
					label="LL Member" labelClass="5" conClass="1"/>
			</div>
		</div>
	</div>
</div>

<%-- 그리드 영역 --%>
<div class ="well">
    <div class="page_btn_area" >

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="excelExportBtn" objCode="ordCrossListExcel_OBJ">
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    <div id="ordCrossListGrid" class="white_bg grid_bd0"></div>
</div>
   
<script  type="text/x-jsrender" id="setSalTypeCd">
{{if salTypeCd == "OFF"}} Offline Only
{{else salTypeCd == "ON"}} Online Only
{{else salTypeCd == "ALL"}} Offline && Online 
{{else salTypeCd == "Total"}} Total
{{else}} {{:salTypeCd}}
{{/if}}
</script>   

<script  type="text/x-jsrender" id="ordCntRate">
{{:ordCntRate}}%
</script>  
   
<script  type="text/x-jsrender" id="setTier">
{{if grdTypeCd=="W"}}VVIP
{{else grdTypeCd=="V"}}VIP
{{else grdTypeCd=="L"}}LL Member
{{else}} {{:grdTypeCd}}
{{/if}}
</script>   
  
 <style type="text/css">
#labelTab{
	width: 5%;
}
</style>
<script type="text/javascript">
var ordCrossListGrid;

function getOrdCrossList(){
    var ejGridOption = {
           serializeGridData : function(data) {
        	   if($('#month').val()=="ALLMonth"){
        		   data.monthValue="ALL";
        		   data.yyyy = $('#year').val();
        	   }else{
        		   data.monthValue="NOTALL";
        		   data.yyyymm = $('#year').val()+$('#month').val();
        	   }                data.chnlType = $('#chnlType').val();
                data.custTypeI = $("#custTypeI").is(':checked') ? 'I' : '';
                data.custTypeC = $("#custTypeC").is(':checked') ? 'C' : '';
                data.custTypeE = $("#custTypeE").is(':checked') ? 'E' : '';
/*                 data.custTypeO = $("#custTypeOD").is(':checked') ? 'O' : '';
                data.custTypeD = $("#custTypeOD").is(':checked') ? 'D' : '';   */
                
                data.tierW = $("#tierW").is(':checked') ? 'W' : '';;
                data.tierV = $("#tierV").is(':checked') ? 'V' : '';;
                data.tierL = $("#tierL").is(':checked') ? 'L' : '';;
                
                return data;
             },
          allowCellMerging: true,
          dataUrl : '<ifvm:action name="getOrdCrossList"/>',
          columns:[
          	    {
                   field : 'salTypeCd' ,headerText : '분류', headerTextAlign : 'center', textAlign: 'center',template:"#setSalTypeCd",
                   customAttributes : {
                      index : 'salTypeCd' , sortable: false}/*  */
                },{
                   field : 'grdTypeCd', headerText : '등급', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', template:"#setTier",
                   customAttributes : {
                      index : 'grdTypeCd' , sortable: false}/* */
                },{
                   field : 'ordCnt', headerText : '구매건수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                   customAttributes : {
                      index : 'ordCnt' , sortable: false}/*  */
                },{
                   field : 'ordCntRate', headerText : '비중', headerTextAlign : 'center', textAlign: 'right', template:"#ordCntRate",
                   customAttributes : {
                      index : 'ordCntRate' , sortable: false}/*  */
                },{
                    field : 'sellAmt', headerText : '판매금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', 
                    customAttributes : {
                       index : 'sellAmt' , sortable: false}/*  */
                },{
                     field : 'discntAmt', headerText : '할인금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', 
                     customAttributes : {
                        index : 'discntAmt' , sortable: false}/*  */
                },{
                    field : 'settleAmt', headerText : '실결제금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', 
                    customAttributes : {
                       index : 'settleAmt' , sortable: false}/*  */
               }
          ],
          mergeCellInfo: cellmerge,
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
         tempId : 'ifvGridSimpleTemplete2'
      };
      ordCrossListGrid = $("#ordCrossListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
}


function cellmerge(args){
	 if (args.column.field == "salTypeCd" && !$(args.cell).hasClass("e-merged")){
		 
		 
		   var rowInx = this.getIndexByRow(args.cell.closest("tr")); 
           var merInx = rowInx; 
           var pageSize = this.model.currentViewData.length; 
           var prevRow = null, nexRow = null; 
           var data = ej.DataManager(this.model.currentViewData).executeLocal(new ej.Query().where("salTypeCd", "equal", args.data["salTypeCd"])); 
           for (var inx = 0; inx < data.length; inx++) { 
               var currentdata = this.model.currentViewData; 
               if (currentdata.indexOf(data[inx]) == merInx) 
                   continue; 
               else if (merInx + 1 == currentdata.indexOf(data[inx])) 
                   merInx++; 
               else break; 
           } 
           if (rowInx != merInx){
               args.rowMerge(merInx - rowInx + 1); 
           }
		 
	 }
	
	
}


//조회조건 set
function commcodeSetting(){
		//년
	   $.fn.ifvmSetSelectOptionCommCode("year", "REPORT_YEAR", null, null, true);
		//월
	   $.fn.ifvmSetSelectOptionCommCode("month", "SETTLE_MONTH", null, null, true);
		//구분
	  $("#custTypeI").prop('checked',true);
		
	  $("#tierW").prop('checked',true);
	  $("#tierV").prop('checked',true);
	  $("#tierL").prop('checked',true);
	  $("#month").append("<option value='ALLMonth'>전체</option>")

	   $.fn.ifvmSetSelectOptionCommCode("chnlType", "LOY_CHNL_TYPE_CD", null, null, true);
	   $("#chnlType").append("<option value='ALL'>전체</option>")
	   $("#chnlType").val("ALL");

	}
//현재날짜 조회
function sysdateSet(){
	   var d= new Date();
	   var reqYear =String(d.getFullYear());
	   var reqMonth =d.getMonth()+1;
	   reqMonth=reqMonth>=10?reqMonth:'0'+reqMonth;
	   $('#year').val(reqYear);
	   $('#month').val(reqMonth);
   }


function searchCondInit(){
	
	sysdateSet();
	$("#custTypeI").prop('checked',true);
	$("#custTypeC").prop('checked',false);
	$("#custTypeE").prop('checked',false);
/* 	$("#custTypeOD").prop('checked',false);
 */	$("#chnlNm").val("");
	$("#rid").val("");
	$("#chnlType").val("ALL");
	
}
$(document).ready(function() {
	
	commcodeSetting();
	sysdateSet();
	getOrdCrossList();
	
	
	//조회
    $('#reportSearchBtn').on('click', function(){
    	getOrdCrossList();
    });

    //초기화
    $("#reportSearchInitBtn").on('click', function(){
    	searchCondInit();
    }); 
    
    
    $('#btnChnlListPop').on('click',function(){
    	chnlListPop();
    });
    
    
	//엑셀다운로드
    $("#excelExportBtn").on('click', function() {
      	$.ifvExcelDn('/kepler/report/ordCrossExcelDown.do','ordCrossListGrid' );
    });
	
	
});
</script>