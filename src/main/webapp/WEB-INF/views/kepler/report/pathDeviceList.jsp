<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="page-title">
    <h1>
    	정형 Report &gt; 가입경로/가입 디바이스별 현황
    </h1>
</div>

<%-- 조회조건 영역 --%>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="reportSearchBtn" objCode="pathDeviceListSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="reportSearchInitBtn" objCode="pathDeviceListSearchInit_OBJ">
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
				<ifvm:inputNew type="checkBox" id="custTypeI" 
					label="개인" labelClass="2" conClass="1"/>
			 	<ifvm:inputNew type="checkBox" id="custTypeC" 
					label="법인" labelClass="2" conClass="1"/>
				<ifvm:inputNew type="checkBox" id="custTypeE" 
					label="임직원" labelClass="2" conClass="1"/>
<%-- 				<ifvm:inputNew type="checkBox" id="custTypeOD" 
					label="기타" labelClass="2" conClass="1"/>	 --%>
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
            <button class="btn btn-sm" id="excelExportBtn" objCode="pathDeviceListExcel_OBJ">
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    <div id="pathDeviceGrid" class="white_bg grid_bd0"></div>
</div>

<style type="text/css">
#labelTab{
	width: 5%;
}
</style>
<script type="text/javascript">
var pathDeviceGrid;

function getPathDevice(){
    var ejGridOption = {
           serializeGridData : function(data) {
         	   	data.sellDate1 = $('#sellDate1').val();
        	   	data.sellDate2 = $('#sellDate2').val();
        	   	
                data.custTypeI = $("#custTypeI").is(':checked') ? 'I' : '';
                data.custTypeC = $("#custTypeC").is(':checked') ? 'C' : '';
                data.custTypeE = $("#custTypeE").is(':checked') ? 'E' : '';
/*                 data.custTypeO = $("#custTypeOD").is(':checked') ? 'O' : '';
                data.custTypeD = $("#custTypeOD").is(':checked') ? 'D' : '';   */
                data.rid = $("#rid").val();
                return data;
             },
          showSummary: true,
          summaryRows: [{
              title: "월 합계",
              summaryColumns: [
            	  {summaryType: ej.Grid.SummaryType.Sum,  displayColumn: "newCnt", dataMember: "newCnt", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Sum, displayColumn: "new2Cnt", dataMember: "new2Cnt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Sum, displayColumn: "transCnt", dataMember: "transCnt", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Sum, displayColumn: "totMbrCnt", dataMember: "totMbrCnt", format: "{0:n0}" }
              
              ]
          }
          ],
          dataUrl : '<ifvm:action name="getPathDevice"/>',
          
          columns:[
          	    {
                   field : 'sbscPathCd' ,headerText : '가입경로', headerTextAlign : 'center', textAlign: 'center', width:'80',
                   customAttributes : {
                      index : 'sbscPathCd' , sortable: false}/*  */
                },{
                   field : 'sbscDeviceCd' ,headerText : '가입디바이스', headerTextAlign : 'center', textAlign: 'center', width:'80',
                   customAttributes : {
                      index : 'sbscDeviceCd' , sortable: false}/*  */
                },{
                   field : 'newCnt', headerText : '기존회원수(리뉴얼이전)', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'newCnt' , sortable: false}/* */
                },{
                   field : 'new2Cnt', headerText : '신규회원수(리뉴얼이후)', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                   customAttributes : {
                      index : 'new2Cnt' , sortable: false}/*   */
                },{
                   field : 'transCnt', headerText : '전환회원수', headerTextAlign : 'center', textAlign: 'right',  format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'transCnt' , sortable: false}/* */
                },{
                   field : 'totMbrCnt', headerText : '총회원수(리뉴얼이후 신규+전환)', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                   customAttributes : {
                      index : 'totMbrCnt' , sortable: false}/*  */
                }
          ],
          requestGridData : {
          	  nd   : new Date().getTime(),
          	  rows : 10,
          	  sidx : '1',
          	  sord : 'asc',
          	  _search : false,
         },
         isHorizontalScroll:true,
         rowList : [10,25,50,100],
         gridDataInit: true,
         radio: false,
         tempId : 'ifvGridSimplePageTemplete2'
      };
      pathDeviceGrid = $("#pathDeviceGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
}


//조회조건 set
function commcodeSetting(){
		//구분
	  
	   $("#custTypeI").prop('checked',true);
	   $.fn.ifvmSetSelectOptionCommCode("chnlType", "SRC_TYPE", null, null, true);
	   $("#chnlType").append("<option value='ALL'>전체</option>")
	   $("#chnlType").val("ALL");

	}
	
	
function searchCondInit(){
	
	
	var date01 = $('#sellDate1');
	var date02 = $('#sellDate2');
	date01.val($.ifvGetTodayDate());
	date02.val($.ifvGetTodayDate());
	
	$("#custTypeI").prop('checked',true);
	$("#custTypeC").prop('checked',false);
	$("#custTypeE").prop('checked',false);
//	$("#custTypeOD").prop('checked',false);
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

function searchCondInit(){
	
	var date01 = $('#sellDate1');
	var date02 = $('#sellDate2');
	date01.val($.ifvGetTodayDate());
	date02.val($.ifvGetTodayDate());
	$("#custTypeI").prop('checked',false);
	$("#custTypeC").prop('checked',false);
	$("#custTypeE").prop('checked',false);
//	$("#custTypeOD").prop('checked',false);
	
}
$(document).ready(function() {
	
	commcodeSetting();
	setDatePicker();
	getPathDevice();
	
	//조회
    $('#reportSearchBtn').on('click', function(){
    	getPathDevice();
    });

    //초기화
    $("#reportSearchInitBtn").on('click', function(){
    	searchCondInit();
    }); 
    
    
	//엑셀다운로드
    $("#excelExportBtn").on('click', function() {
      	$.ifvExcelDn('/kepler/report/pathDeviceExcelDown.do','pathDeviceGrid' );
    });
	
	
});
</script>