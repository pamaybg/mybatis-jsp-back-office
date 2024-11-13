<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="page-title">
    <h1>
    	정형 Report &gt; 전체회원현황
    </h1>
</div>

<%-- 조회조건 영역 --%>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="reportSearchBtn" objCode="totMbrListSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="reportSearchInitBtn" objCode="totMbrListSearchInit_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>


	</div>
	<div class="form-horizontal underline top_well"	id="reportSearchCondition">
		<div class="row qt_border">
			<label class="col-xs-1 control-label" id="labelTab">년</label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="year" names="year" dto="year" />
			</div>
			<label class="col-xs-1 control-label" id="labelTab">월</label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="month" names="month" dto="month" />
			</div>
			<label class="col-xs-1 control-label">통합회원유형</label>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="checkBox" id="custTypeI" 
					label="개인" labelClass="2" conClass="1"/>
			 	<ifvm:inputNew type="checkBox" id="custTypeC" 
					label="법인" labelClass="2" conClass="1"/>
				<ifvm:inputNew type="checkBox" id="custTypeE" 
					label="임직원" labelClass="2" conClass="1"/>
	<%-- 			<ifvm:inputNew type="checkBox" id="custTypeOD" 
					label="기타" labelClass="2" conClass="1"/> --%>
			</div>
			<label class="col-xs-1 control-label" id="chnlTypeTab"> 구분 </label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="chnlType" names="chnlType" dto="chnlType" />
			</div>
			
			<label class="col-xs-1 control-label" > 매장상태 </label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="chnlStat" names="chnlStat" dto="chnlStat" />
			</div>
			 
			
		<div class="row qt_border">
			<label class="col-xs-1 control-label" id="labelTab"><spring:message code="매장" /></label>
			<div class="col-xs-2 control_content">
				<div class="input-group">
					<ifvm:input type="text" disabled="true" maxLength="10" id="chnlNm" />
					<span class="input-group-addon" id="btnChnlListPop"> <a id="chnlListBtn"><i class="fa fa-search"></i></a>
					</span>
					<ifvm:input type="hidden" id="rid"/>
				</div>
			</div>
			
			
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
            <button class="btn btn-sm" id="excelExportBtn" objCode="totMbrListExcel_OBJ">
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    <div id="totMbrListGrid" class="white_bg grid_bd0"></div>

     <div class="page_btn_area" >
   		<div class="col-xs-7">
		 <span>용어설명</span>
    	</div>
    </div>
	<textarea id="desc" class = "descript" maxlength="100" rows="10" readonly = true>
• 총회원수 : 통합(전환+신규) 회원과 기존(온라인+오프라인) 회원과 휴면 회원의 합
• Active : 신규회원+전환회원+기존회원
• 통합회원 신규가입 회원수 : 해당일자에 락앤락 통합회원에 최초 신규 가입한 회원의 수
• 통합회원 전환가입 회원수 : 해당일자에 락앤락 통합회원으로 전환 가입한 회원의 수
• 기존회원 전환전 자사몰 수 : 해당일자에 전환하지 않은 기존 자사몰 회원의 수(합)
• 기존회원 전환전 오프라인 수 : 해당일자에 전환하지 않은 기존 오프라인 회원의 수(합)
• 휴면회원 수 : 1년 동안 락앤락몰에 로그인하지 않거나 구매를 하지 않은 회원이 해당일자에 휴면회원으로 변경된 수
• 탈회회원 수 : 해당일자에 탈회 처리된 회원의 수
	</textarea>
</div>
    
    
<div id="chnlListPopDialog" class="popup_container"></div>
   
   
<style type="text/css">
.descript{
	width : 98%;
	font-size: 13px;
	box-sizing: border-box;
	margin: 10px;
	padding: 10px;

}

#labelTab{
	width: 5%;
}
#chnlTypeTab{
	width: 6%;
}
</style>

   
<script type="text/javascript">
var totMbrListGrid;
var chnl_Type_Rid =null;
var chnl_SubType_Cd =null;
var sumobj  = {};

function getCustomSummary(){
	  sumobj = {};
	  var monthValue = null;
	   var custTypeI = $("#custTypeI").is(':checked') ? 'I' : '';
	   var custTypeC = $("#custTypeC").is(':checked') ? 'C' : '';
	   var custTypeE = $("#custTypeE").is(':checked') ? 'E' : '';
	  var yyyy =null;
	  var yyyymm = null;

	  if($('#month').val()=="ALLMonth"){
		   monthValue="ALL";
		   yyyy = $('#year').val();
	   }else{
		   monthValue ="NOTALL";
		   yyyymm = $('#year').val()+$('#month').val();
	   }
	  
	  $.ifvSyncPostJSON('<ifvm:action name="getTotMbrList2"/>',{
		   monthValue : monthValue
		   ,yyyy : yyyy
		   ,yyyymm :yyyymm
		   ,chnlType :  $('#chnlType').val()
		   ,chnlStat :  $('#chnlStat').val()
		   ,custTypeI : custTypeI
		   ,custTypeC : custTypeC
		   ,custTypeE : custTypeE
		   ,rid 		   :  $("#rid").val()
		},
		function(result) {
			sumobj = result.rows[0]; 
		});
}


function currency(args,data){
	return sumobj[args.displayColumn];
} 


function getTotMbrList(){
    var ejGridOption = {
           serializeGridData : function(data) {
        	   if($('#month').val()=="ALLMonth"){
        		   data.monthValue="ALL";
        		   data.yyyy = $('#year').val();
        	   }else{
        		   data.monthValue="NOTALL";
        		   data.yyyymm = $('#year').val()+$('#month').val();
        	   }
                data.chnlType = $('#chnlType').val();
                data.chnlStat = $('#chnlStat').val();
                data.custTypeI = $("#custTypeI").is(':checked') ? 'I' : '';
                data.custTypeC = $("#custTypeC").is(':checked') ? 'C' : '';
                data.custTypeE = $("#custTypeE").is(':checked') ? 'E' : '';
              
                data.rid = $("#rid").val();
    			return data;
             },
          showStackedHeader: true,
          stackedHeaderRows: [{ stackedHeaderColumns: 
         		[
         			{headerText: "통합회원",textAlign : 'center',column: "newCnt,transCnt,onlineCnt"},
         			{headerText: "기존회원",textAlign : 'center',column: "onlineCnt,offlineCnt"}
         			]
         		}],
          showSummary: true,
          summaryRows: [{
              title: "월 합계",
              summaryColumns: [
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "totCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "activeCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "newCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "transCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "drmncyCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "sescnCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "onlineCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "offlineCnt",  format: "{0:n0}"}

            	  ]
          }],
          dataUrl : '<ifvm:action name="getTotMbrList"/>',
          columns:[
          	    {
                   field : 'yyyymmdd' ,headerText : '일자', headerTextAlign : 'center', textAlign: 'center',
                   customAttributes : {
                      index : 'yyyymmdd' , sortable: false}/*  */
                },{
                   field : 'chnlNm' ,headerText : '주거래 매장', headerTextAlign : 'center', textAlign: 'center', width:'200px',
                   customAttributes : {
                      index : 'chnlNm' , sortable: false}/*  */
                },{
                   field : 'totCnt', headerText : 'ACTIVE+휴면', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                   customAttributes : {
                      index : 'totCnt' , sortable: false}/* */
                },{
                   field : 'activeCnt', headerText : 'Active', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                   customAttributes : {
                      index : 'activeCnt' , sortable: false}/*   */
                },{
                   field : 'newCnt', headerText : '신규가입 회원수', headerTextAlign : 'center', textAlign: 'right',  format : '{0:n0}', 
                   customAttributes : {
                      index : 'newCnt' , sortable: false}/* */
                },{
                   field : 'transCnt', headerText : '전환 회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                   customAttributes : {
                      index : 'transCnt' , sortable: false}/*  */
                },{
                   field : 'onlineCnt', headerText : '전환전 자사몰 수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', 
                   customAttributes : {
                      index : 'onlineCnt' , sortable: false}/*  */
                },{
                    field : 'offlineCnt', headerText : '전환전 오프라인 수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', 
                    customAttributes : {
                       index : 'offlineCnt' , sortable: false}/*  */
                },{
                     field : 'drmncyCnt', headerText : '휴면회원 수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', 
                     customAttributes : {
                        index : 'drmncyCnt' , sortable: false}/*  */
                },{
                    field : 'sescnCnt', headerText : '탈회회원 수 ', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', 
                    customAttributes : {
                       index : 'sescnCnt' , sortable: false}/*  */
               }
          ],
          requestGridData : {
          	  nd   : new Date().getTime(),
          	  rows : 10,
          	  sidx : '1 desc ,2',
          	  sord : 'asc',
          	  _search : false,
         },
         rowList : [10,25,50,100],
         gridDataInit: true,
         radio: false,
         tempId : 'ifvGridSimplePageTemplete2'
      };
      totMbrListGrid = $("#totMbrListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
}


//조회조건 set
function commcodeSetting(){
		//년
	   $.fn.ifvmSetSelectOptionCommCode("year", "REPORT_YEAR", null, null, true);
		//월
	   $.fn.ifvmSetSelectOptionCommCode("month", "SETTLE_MONTH", null, null, true);
	   $("#month").append("<option value='ALLMonth'>전체</option>")

	   //구분
	  $("#custTypeI").prop('checked',true);
		
	   $.fn.ifvmSetSelectOptionCommCode("chnlType", "LOY_CHNL_TYPE_CD", null, null, true);
	   $("#chnlType").append("<option value='ALL'>전체</option>")
	   $("#chnlType").val("ALL");
	   
	   $.fn.ifvmSetSelectOptionCommCode("chnlStat", "LOY_CHNL_STAT_CD", null, null, true);
	   $("#chnlStat").append("<option value='ALL'>전체</option>")

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

function chnlListPop(){

	chnl_Type_Rid = $("#rid").val();
	chnl_SubType_Cd = $("#chnlType").val();

	$("#chnlListPopDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="KprChnlListPop"/>',
        contentType: "ajax",
        title: '매장',
        width: 650,
        close : 'chnlListPopClose'
    });
	
}
function chnlListPopClose(){
	
	chnlListPopDialog._destroy();
}

function searchCondInit(){
	
	sysdateSet();
	$("#custTypeI").prop('checked',false);
	$("#custTypeC").prop('checked',false);
	$("#custTypeE").prop('checked',false);
	//$("#custTypeOD").prop('checked',false);

	$("#chnlNm").val("");
	$("#rid").val("");
	$("#chnlType").val("ALL");
	
}
$(document).ready(function() {
	
	commcodeSetting();
	sysdateSet();
	getTotMbrList();
	
	$('#chnlType').find('[value=P]').hide();
	$('#chnlType').find('[value=E]').hide();

	
	//조회
    $('#reportSearchBtn').on('click', function(){
    	getCustomSummary();
    	getTotMbrList();
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
      	$.ifvExcelDn('/kepler/report/totMbrExcelDown.do','totMbrListGrid' );
    });
	
	
});
</script>