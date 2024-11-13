<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="page-title">
    <h1>
    	정형 Report &gt; 통합회원 유형별 회원현황
    </h1>
</div>

<%-- 조회조건 영역 --%>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="reportSearchBtn" objCode="mbrFlagListSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="reportSearchInitBtn" objCode="mbrFlagListSearchInit_OBJ">
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
			<%-- 	<ifvm:inputNew type="checkBox" id="custTypeOD" 
					label="기타" labelClass="2" conClass="1"/> --%>
			</div>
			<label class="col-xs-1 control-label"  id="chnlTypeTab"> 구분 </label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="chnlType" names="chnlType" dto="chnlType" />
			</div>
			
			<label class="col-xs-1 control-label" > 매장상태 </label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="chnlStat" names="chnlStat" dto="chnlStat" />
			</div>
			
		    
			
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

<%-- 그리드 영역 --%>
<div>
    <div class="page_btn_area" >

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="excelExportBtn" objCode="mbrFlagListExcel_OBJ">
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    <div id="mbrFlagListGrid" class="white_bg grid_bd0"></div>
    
     <div class="page_btn_area" >
   		<div class="col-xs-7">
		 <span>용어설명</span>
    	</div>
    </div>
	<textarea id="desc" class = "descript" maxlength="100" rows="10" readonly = true>
• 통합회원 수 : 신규로 통합회원에 가입하거나 기존 회원에서 통합회원으로 전환한 회원의 수 
• 휴면 : 1년 동안 락앤락몰에 로그인하지 않거나 구매를 하지 않은 회원
• 첫구매회원 : 통합회원 중 가입 후 첫 구매한 회원 또는 1년동안 구매이력이 없다가 기준일자에 첫구매한 회원
• 활성구매회원 : 통합회원 중 직전 3개월 내 구매이력이 있는 회원
• 활성가망회원 : 통합회원 중 직전 3개월 내 구매이력이 없는 회원(단, 직전 4~6개월 내 구매 이력 有)
• 휴면임박회원 : 통합회원 중 직전 6개월 내 구매이력이 없는 회원(단, 직전 7~12개월 내 구매이력 有)
• 미구매회원 : 통합회원 중 1년 내 구매이력이 없는 회원
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
var mbrFlagListGrid;
var chnl_Type_Rid =null;
var chnl_SubType_Cd =null;
var sumobj = {};
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
	  
	  $.ifvSyncPostJSON('<ifvm:action name="getMbrFlagList2"/>',{
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
function getMbrFlagList(){
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
         			{headerText: "첫구매고객수",textAlign : 'center',column: "firstTotCnt,firstCnt,first2Cnt"}
         			]
         		}],
          showSummary: true,
          summaryRows: [{
              title: "월 합계",
              summaryColumns: [
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "intgMbrCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "intgMbr2Cnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "drmncyCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "newCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "transCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "firstTotCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "firstCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "first2Cnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "lst1YCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "lst6MCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "lst1Mcnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "newCustCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "existingCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "lapedCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "goneCnt",  format: "{0:n0}"},
            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "inactiveCnt",  format: "{0:n0}"}
            	  
              ]
          }
          ],
          dataUrl : '<ifvm:action name="getMbrFlagList"/>',
          columns:[
          	    {
                   field : 'yyyymmdd' ,headerText : '일자', headerTextAlign : 'center', textAlign: 'center',width:'80',
                   customAttributes : {
                      index : 'yyyymmdd' , sortable: false}/*  */
                },{
                   field : 'chnlNm' ,headerText : '거래 매장', headerTextAlign : 'center', textAlign: 'center',width:'200px',
                   customAttributes : {
                      index : 'chnlNm' , sortable: false}/*  */
                },{
                   field : 'intgMbrCnt', headerText : '통합회원수(신규+전환)', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                   customAttributes : {
                      index : 'intgMbrCnt' , sortable: false}/* */
                },{
                    field : 'intgMbr2Cnt', headerText : '통합회원수 -휴면', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                    customAttributes : {
                       index : 'intgMbr2Cnt' , sortable: false}/* */
                 },{
                   field : 'drmncyCnt', headerText : '휴면', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                   customAttributes : {
                      index : 'drmncyCnt' , sortable: false}/*   */
                },{
                   field : 'newCnt', headerText : '신규가입  회원수', headerTextAlign : 'center', textAlign: 'right',  format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'newCnt' , sortable: false}/* */
                },{
                   field : 'transCnt', headerText : '전환 회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                   customAttributes : {
                      index : 'transCnt' , sortable: false}/*  */
                },{
                   field : 'firstTotCnt', headerText : '합계', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'firstTotCnt' , sortable: false}/*  */
                },{
                    field : 'first2Cnt', headerText : '기존가입구매', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'first2Cnt' , sortable: false}/*  */
                },{
                     field : 'firstCnt', headerText : '당일가입구매', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                     customAttributes : {
                        index : 'firstCnt' , sortable: false}/*  */
                },{
                    field : 'lst1YCnt', headerText : '최근1년 구매회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'lst1YCnt' , sortable: false}/*  */
               },{
                   field : 'lst6MCnt', headerText : '최근6개월 구매회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'70',
                   customAttributes : {
                      index : 'lst6MCnt' , sortable: false}/*  */
               },{
                  field : 'lst1Mcnt', headerText : '최근1개월 구매회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'70',
                  customAttributes : {
                     index : 'lst1Mcnt' , sortable: false}/*  */
               },{
                 field : 'newCustCnt', headerText : '첫구매회원', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                 customAttributes : {
                    index : 'newCustCnt' , sortable: false}/*  */
               },{
                   field : 'existingCnt', headerText : '활성구매회원', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'90',
                   customAttributes : {
                      index : 'existingCnt' , sortable: false}/*  */
               },{
                   field : 'lapedCnt', headerText : '활성가망회원', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'90',
                   customAttributes : {
                      index : 'lapedCnt' , sortable: false}/*  */
               },{
                   field : 'goneCnt', headerText : '휴면임박회원', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'90',
                   customAttributes : {
                      index : 'goneCnt' , sortable: false}/*  */
               },{
                   field : 'inactiveCnt', headerText : '미구매회원', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                   customAttributes : {
                      index : 'inactiveCnt' , sortable: false}/*   */
                }
          ],
          requestGridData : {
          	  nd   : new Date().getTime(),
          	  rows : 10,
          	  sidx : '1 desc ,2',
          	  sord : 'asc',
          	  _search : false,
         },
         isHorizontalScroll:true,
         rowList : [10,25,50,100],
         gridDataInit: true,
         radio: false,
         tempId : 'ifvGridSimplePageTemplete2'
      };
      mbrFlagListGrid = $("#mbrFlagListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
}


//조회조건 set
function commcodeSetting(){
		//년
	   $.fn.ifvmSetSelectOptionCommCode("year", "REPORT_YEAR", null, null, true);
		//월
	   $.fn.ifvmSetSelectOptionCommCode("month", "SETTLE_MONTH", null, null, true);
		//구분
	   $("#month").append("<option value='ALLMonth'>전체</option>")

		
		$("#custTypeI").prop('checked',true);
	  
	   $.fn.ifvmSetSelectOptionCommCode("chnlType", "LOY_CHNL_TYPE_CD", null, null, true);
	   $("#chnlType").append("<option value='ALL'>전체</option>")
	   $("#chnlType").val("ALL");
	   
	   $.fn.ifvmSetSelectOptionCommCode("chnlStat", "LOY_CHNL_STAT_CD", null, null, true);
	   $("#chnlStat").append("<option value='ALL'>전체</option>")
// 	   $("#chnlStat").val("ALL");

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
	chnl_Type_Rid=$("#rid").val();
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
	$("#chnlStat").val("ALL");
	
}
$(document).ready(function() {
	
	commcodeSetting();
	sysdateSet();
	getMbrFlagList();
	
	
	
	$('#chnlType').find('[value=P]').hide();
	$('#chnlType').find('[value=E]').hide();
	

	//조회
    $('#reportSearchBtn').on('click', function(){
    	getMbrFlagList();
    	getCustomSummary();
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
      	$.ifvExcelDn('/kepler/report/mbrFlagExelDown.do','mbrFlagListGrid' );
    });
	
	
});
</script>