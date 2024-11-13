<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var campaignDetailGrid;
var sendCampaignDetailGrid;
   
function sendCampaignDetail(){
    var ejGridOption = {
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }
  			data.camId = camId;
            return data;
       	},
       	rowSelected : function(args){
       	},
       	dataUrl : '<ifvm:action name="getCampaignExeInfo"/>',
       	columns:[
            {
                 field : 'camNm', headerText : '캠페인 명', headerTextAlign : 'center', textAlign : 'left', width : '200px',
                 customAttributes : {
                    index : 'camNm' }
              }, {
                 field : 'camTerm', headerText : '캠페인 기간', headerTextAlign : 'center', textAlign : 'center', width : '130px',
                 customAttributes : {
                    index : 'camTerm' }
              }, {
                  field : 'pushYn', headerText : 'PUSH', headerTextAlign : 'center', textAlign : 'center',width : '50px',
                  customAttributes : {
                     index : 'pushYn' }
              }, {
                  field : 'emailYn', headerText : 'EMAIL', headerTextAlign : 'center', textAlign : 'center',width : '50px',
                  customAttributes : {
                     index : 'emailYn' }
              }, {
                  field : 'lmsYn', headerText : 'LMS', headerTextAlign : 'center', textAlign : 'center',width : '50px',
                  customAttributes : {
                     index : 'lmsYn' }
              }, {
                  field : 'smsYn', headerText : 'SMS', headerTextAlign : 'center', textAlign : 'center',width : '50px',
                  customAttributes : {
                     index : 'smsYn' }
              }, {
                  field : 'tgtAmt', headerText : '추출 대상자 수', headerTextAlign : 'center', textAlign : 'right',width : '100px', format: '{0:n0}',
                  customAttributes : {
                     index : 'tgtAmt' }
              }, {
                  field : 'camRid', headerText : '', headerTextAlign : 'center', textAlign : 'center', visible : false,
                  customAttributes : {
                	  searchable : false,
                     index : 'camRid' }
              }
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  _search : false
	    },
	    rowList : [10,25,50,100],
        tempId : 'ifvGridSimpleTemplete2'
    };
    
    sendCampaignDetailGrid = $("#sendCampaignDetailGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}



//캠페인 상세
function sendCampaignDetailInit(){
    var ejGridOption = {
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }
            return data;
       	},
       	rowSelected : function(args){
       	},
       	dataUrl : '<ifvm:action name="getCampaignExeInfo"/>',
       	columns:[
            {
                 field : 'camNm', headerText : '캠페인 명', headerTextAlign : 'center', textAlign : 'left', width : '200px',
                 customAttributes : {
                    index : 'camNm' }
              }, {
                 field : 'camTerm', headerText : '캠페인 기간', headerTextAlign : 'center', textAlign : 'center', width : '130px',
                 customAttributes : {
                    index : 'camTerm' }
              }, {
                  field : 'pushYn', headerText : 'PUSH', headerTextAlign : 'center', textAlign : 'center',width : '50px',
                  customAttributes : {
                     index : 'pushYn' }
              }, {
                  field : 'emailYn', headerText : 'EMAIL', headerTextAlign : 'center', textAlign : 'center',width : '50px',
                  customAttributes : {
                     index : 'emailYn' }
              }, {
                  field : 'lmsYn', headerText : 'LMS', headerTextAlign : 'center', textAlign : 'center',width : '50px',
                  customAttributes : {
                     index : 'lmsYn' }
              }, {
                  field : 'smsYn', headerText : 'SMS', headerTextAlign : 'center', textAlign : 'center',width : '50px',
                  customAttributes : {
                     index : 'smsYn' }
              }, {
                  field : 'tgtAmt', headerText : '추출 대상자 수', headerTextAlign : 'center', textAlign : 'right',width : '100px', format: '{0:n0}',
                  customAttributes : {
                     index : 'tgtAmt' }
              }, {
                  field : 'camRid', headerText : '', headerTextAlign : 'center', textAlign : 'center', visible : false,
                  customAttributes : {
                	  searchable : false,
                     index : 'camRid' }
              }
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  _search : false
	    },
	    rowList : [10,25,50,100],
        gridDataInit : false,
        tempId : 'ifvGridSimpleTemplete2'
    };
    
    sendCampaignDetailGrid = $("#sendCampaignDetailGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function sendCampaignInfo(){
    var ejGridOption = {
          rowSelected : function(args){
          },
          serializeGridData : function(data) {
              if ($.fn.ifvmIsNotEmpty(requestitem)) {
                   data.itme = requestitem;
               }
               data.yyyymm =$('#year').val()+$('#month').val();
               data.endyyyymm =$('#endyear').val()+$('#endmonth').val();
               data.chnlCd =$('#chnlCd').val();
               data.ageCd =$('#ageCd').val();
               data.genCd =$('#genCd').val();
               data.timeCd = $('#timeCd').val();
               data.camId = camId;
               return data;
           },
           loadComplete : function(obj){
        	   sendCampaignDetail();
           },
          showSummary:true,
          summaryRows: [
        	   {
              	 title: "평균:",
                   summaryColumns: [
                       { summaryType: ej.Grid.SummaryType.Average, displayColumn: "recvCnt", dataMember: "recvCnt", format: "{0:n0}" }
                      ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "pushCnt", dataMember: "pushCnt", format: "{0:n0}" }
                      ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "emailCnt", dataMember: "emailCnt", format: "{0:n0}" }
                   ]  
              },
              {
              	 title: "합계:",
                   summaryColumns: [
                      { summaryType: ej.Grid.SummaryType.Sum, displayColumn: "recvCnt"  	, dataMember: "recvCnt", format: "{0:n0}" }
                     ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "pushCnt"		, dataMember: "pushCnt", format: "{0:n0}" }
                     ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "emailCnt"	, dataMember: "emailCnt", format: "{0:n0}" }
                   ]   
              }
           ],
        dataUrl : '<ifvm:action name="getSendCampaignInfo"/>',
        columns:[ 
             {
                 field : 'recvDt' ,headerText : '반응(수인)일자', headerTextAlign : 'center', textAlign: 'center',
                 customAttributes : {
                    index : 'recvDt' , sortable: false}/*  */
              },{
                 field : 'recvCnt' ,headerText : '수신고객수', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'recvCnt' , sortable: false}/*  */
              },{
                 field : 'pushCnt', headerText : 'PUSH 열람 고객수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                 customAttributes : {
                    index : 'pushCnt' , sortable: false}/* */
              },{
                  field : 'emailCnt', headerText : 'EMAIL 열람 고객수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                  customAttributes : {
                     index : 'emailCnt' , sortable: false}/* */
               }
        ],
        requestGridData : {
              nd   : new Date().getTime(),
              rows : 10,
              _search : false
       },
        showStackedHeader:true,
        allowCellMerging : true,
        tempId : 'ifvGridSimpleTemplete2'
    };
    
    campaignDetailGrid = $("#campaignDetailGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}




//캠페인 상세 
function sendCampaignInfoInit(){
    var ejGridOption = {
          rowSelected : function(args){
          },
          serializeGridData : function(data) {
              if ($.fn.ifvmIsNotEmpty(requestitem)) {
                   data.itme = requestitem;
               }
               data.yyyymm =$('#year').val()+$('#month').val();
               data.endyyyymm =$('#endyear').val()+$('#endmonth').val();
               data.chnlCd =$('#chnlCd').val();
               data.ageCd =$('#ageCd').val();
               data.genCd =$('#genCd').val();
               data.timeCd = $('#timeCd').val();
               return data;
           },
          showSummary:true,
          summaryRows: [
             {
            	 title: "평균:",
                 summaryColumns: [
                     { summaryType: ej.Grid.SummaryType.Average, displayColumn: "recvCnt", dataMember: "recvCnt", format: "{0:n0}" }
                    ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "pushCnt", dataMember: "pushCnt", format: "{0:n0}" }
                    ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "emailCnt", dataMember: "emailCnt", format: "{0:n0}" }
                 ]  
            },
            {
            	 title: "합계:",
                 summaryColumns: [
                    { summaryType: ej.Grid.SummaryType.Sum, displayColumn: "recvCnt"  	, dataMember: "recvCnt", format: "{0:n0}" }
                   ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "pushCnt"		, dataMember: "pushCnt", format: "{0:n0}" }
                   ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "emailCnt"	, dataMember: "emailCnt", format: "{0:n0}" }
                 ]   
            }
           ],
        dataUrl : '<ifvm:action name="getSendCampaignInfo"/>',
        columns:[ 
             {
                 field : 'recvDt' ,headerText : '반응(수인)일자', headerTextAlign : 'center', textAlign: 'center',
                 customAttributes : {
                    index : 'recvDt' , sortable: false}/*  */
              },{
                 field : 'recvCnt' ,headerText : '수신고객수', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'recvCnt' , sortable: false}/*  */
              },{
                 field : 'pushCnt', headerText : 'PUSH 열람 고객수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                 customAttributes : {
                    index : 'pushCnt' , sortable: false}/* */
              },{
                  field : 'emailCnt', headerText : 'EMAIL 열람 고객수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                  customAttributes : {
                     index : 'emailCnt' , sortable: false}/* */
               }
        ],
        requestGridData : {
              nd   : new Date().getTime(),
              rows : 10,
              _search : false
       },
        showStackedHeader:true,
        gridDataInit : false,
        allowCellMerging : true,
        tempId : 'ifvGridSimpleTemplete2'
    };
    
    campaignDetailGrid = $("#campaignDetailGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회조건 필수값 체크
function validationCheck(table){
   var validationVal =  false;
   $(".SearchCondition .searchTextVal option:selected").filter(function(){
      if($(this).attr('jointgtclm') == table){
         if($(this).parents('.SearchCondition').css("display") !="none"){
            if($.fn.ifvmIsNotEmpty( $(this).parents('.SearchCondition').find('.changeTypeAreaCode  select').val())){
               validationVal = true;
            }
         }
      }
   })
   return validationVal;
}

//공통 조회 호출
function reqDataSearch() {
	//var reportSearchObj = $('#reportSearchCondition').getSubmitData();
	var reqObj = $("#reportSearchCondition").getSubmitData();
	sendCampaignInfo();
    //sendCampaignDetail();
} 

//엑셀 다운로드 
function excelExport() {
   $.ifvExcelDnMultiSheet('/kepler/report/getSendCampaignInfoExeDown.do',['sendCampaignDetailGrid','campaignDetailGrid']);
}

function commcodeSetting(){
   	$.fn.ifvmSetSelectOptionCommCode("genCd", "LOY_GEN_CD", null, null, false);
	$.fn.ifvmSetSelectOptionCommCode("timeCd", "IF_MNT_SMS_ST_END_TIME", null, null, false);
   	$("#chnlNm").val("");
   	$("#chnlCd").val("");
   	if($("#ageCd option").length==0){
	   
		$.ifvSyncPostJSON('<ifvm:action name="getSelectAgeCd"/>', {
	    	}, function(result) {
	        	 $("#ageCd").append("<option value=''></option>")
	         	for (var i = 0; i < result.ageList.length; i++) {
	            	var ageList = result.ageList;
	             	$("#ageCd").append("<option value="+ageList[i].ageCd+">"+ageList[i].ageNm+ "</option>");      
	             }
	   		});
  	 }else{
	   	$("#ageCd").val("");
  	}
}

   function addrSearchHelpBlur() {
   }
   function addrSearchHelpBtn() {
      searchCampPopInit();
   }
   function addrSearchHelpEnter() {
      searchCampPopInit();
   }
   function searchCampPopInit() {
      $("#searchCampPop").ifvsfPopup({
         enableModal : true,
         enableResize : false,
         contentUrl : '<ifvm:url name="successCampaignPop"/>',
         contentType : "ajax",
         title : "완료 캠페인 조회",
         width : '1000px',
         close : 'searchCampPopClose',
      });
   }
   function searchCampPopClose() {
      searchCampPop._destroy();
   }
	
 //엑셀 다운로드 (다중 시트)
   (function () {

       var syncfution  = {
           getHeads : function ( strGridId ) {
               var gridOption = $( "#gridId"+strGridId ).data("ejGrid").option();
               // MultiHeader
               var getStackedHeader = function (stackedHeaderRows) {
                   var headers = [];
                   if ( stackedHeaderRows && stackedHeaderRows.length > 0 ) {

                       $("#"+strGridId).find("thead .e-stackedHeaderRow").each(function (idx,item ) {
                           var stackedRow = [];
                           $(item).children().each(function (i, row) {
                               if ( gridOption.radio && i == 0 ){
                                  return true;
                               }
                               var $row = $(row);
                               var obj = {
                                   field: "",
                                   text: $row.hasClass("over vision") ? "" :$row.text(),
                                   width: $row[0].width ? $row[0].width : 200,
                                   align: "center",
                                   colspan: $row[0].colSpan,
                                   rowspan: 1
                               };
                               stackedRow.push(obj);
                           });
                           if ( stackedRow.length  > 0 ) {
                               headers.push(stackedRow);
                           }
                       });

                   }
                   return headers;
               };

               var getRowsHeader = function (columns) {
                   var row = [];
                   // 첫번째 컬럼 제외 ( Radio )
                   for ( var i=0 ;  i < columns.length ; i++ ) {
                       if ( gridOption.radio && i == 0) continue;
                       if ( columns[i].visible == true ) {
                           var obj = {
                               field : columns[i].field,
                               text : columns[i].headerText,
                               width : columns[i].width ? columns.width : 200,
                               align : columns[i].headerTextAlign,
                               colspan : 1,
                               rowspan : 1
                           };
                           row.push(obj);
                       }
                   }
                   return row;
               };

               var header = getStackedHeader(gridOption.stackedHeaderRows);
               header.push( getRowsHeader(gridOption.columns));
               return header;
           },
           getFooters : function( strGridId ) {
               //header key값 가져오기
               var headMapArr = []; 
               
               $('#' + strGridId).find('.e-gridheader .e-columnheader:not(.e-stackedHeaderRow)').children('th.e-headercell').each(function(idx, item) {
                 headMapArr.push($(this).children('div').attr('ej-mappingname'));
               });
               
               var fArr = [];
               $('#' + strGridId).find('.e-gridSummaryRows').each(function() {
                  var obj = {};
                  $(this).children('td').each(function(idx, item) {
                	  obj[headMapArr[idx]] = $(this).text();
                  });
                  fArr.push(obj);
               });
               return fArr;
            }
       };

       $.ifvExcelDnMultiSheet = function(targetUrl, strGridId , data) {
       	var reqData = [];
       	var footer =  syncfution.getFooters(strGridId[1]);
       	$.each(strGridId, function(i, e) {
   	        var header =  syncfution.getHeads(e);
   	        var gridOption = $( "#gridId" + e ).data("ejGrid").option();
   	
   	        var _reqData = gridOption.requestGridData;
   	        _reqData.rows = 9999999;
   	        _reqData.excelHeader = JSON.stringify(header);
   	        _reqData.excelFooter = JSON.stringify(footer);
   	        _reqData.item = requestitem;
   	        reqData.push(_reqData);
       	});

           //
           // var reqData = {
           //     item: requestitem,
           //     excelHeader : JSON.stringify(header),
           //     sidx : gridOption.requestGridData.sidx ? gridOption.requestGridData.sidx : "",
           //     sord : gridOption.requestGridData.sord ? gridOption.requestGridData.sord : "",
           //     rows : 9999999
           // };

           $.extend(reqData,data);

           $.ifvProgressControl(true)

           var xhr = new XMLHttpRequest();
           xhr.open( "POST", targetUrl );
           xhr.responseType = "arraybuffer";

           xhr.onload = function() {
               $.ifvProgressControl(false)
               if( this.status === 200 ) {

                   var fileName = "";
                   var disposition = xhr.getResponseHeader( "Content-Disposition" );

                   if ( disposition && disposition.indexOf( "attachment" ) !== -1 ) {
                       var fileNameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                       var matches = fileNameRegex.exec( disposition );

                       if( matches != null && matches[1] ) {
                           fileName = matches[1].replace( /['"]/g, "" );
                       }
                   }
                   var type = xhr.getResponseHeader( "Content-Type" );
                   var blob = new Blob( [this.response], { type: type } );

                   if ( typeof window.navigator.msSaveBlob !== "undefined" ) {
                       window.navigator.msSaveBlob( blob, fileName );
                   } else {
                       var URL = window.URL || window.webkitURL;
                       var downloadUrl = URL.createObjectURL( blob );

                       fileName = decodeURIComponent( fileName );
                       if ( fileName ){
                           var a = document.createElement( "a" );
                           if ( typeof a.download === "undefined" ) {
                               window.location = downloadUrl;
                           } else {
                               a.href = downloadUrl;
                               a.download = fileName;
                               document.body.appendChild( a );
                               a.click();
                           }
                       } else {
                           //window.location = "/login";
                           window.location = downloadUrl;
                       }

                       setTimeout(function() {
                           URL.revokeObjectURL( downloadUrl );
                       }, 100);
                   }
               }
           };

           //xhr.setRequestHeader( "Content-Type", "application/x-www-form-urlencoded" );
           xhr.setRequestHeader( "Content-Type", "application/json" );
           xhr.send( JSON.stringify(reqData) );
       }
   })();
   
	$(document).ready(function() {
	  commcodeSetting();
      //전체 그리드 조회
      sendCampaignDetailInit();
      sendCampaignInfoInit();

      //조회
      $('#reportSearchBtn').on('click', function() {
    	 if($.fn.ifvmIsNotEmpty($('#chnlNm').val()) ){
    		reqDataSearch();
    	 }else{
    	 	alert('캠페인명은 필수값입니다.');
    	 }
      });

      //초기화
      $("#reportSearchInitBtn").on('click', function() {
         commcodeSetting();
      });

      //엑셀 다운로드
      $("#excelExportBtn").on('click', function() {
         excelExport();
      });
   });
</script>

<div class="page-title">
    <h1>
        캠페인 리포트
        &gt; 캠페인 채널 일자별 반응
    </h1>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="reportSearchBtn" objCode="camChnlDtlReactionReportSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="reportSearchInitBtn" objCode="camChnlDtlReactionReportInitBtn_OBJ">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="form-horizontal underline top_well" id="reportSearchCondition">
       <div class="row qt_border">
            <label class="col-xs-1 control-label"><span class="asterisk">*</span>캠페인 명</label>
            <div class="col-xs-2 control_content">
            <ifvm:inputNew type="search" id="chnlNm" names="chnlNm"  dto="chnlNm" btnFunc="addrSearchHelpBtn" searchBlurEvent="addrSearchHelpBlur"
                        searchEnterEvent="addrSearchHelpEnter" />
            <ifvm:inputNew type="hidden"  id="chnlCd" names="chnlCd" dto="chnlCd" disabled="true" />
            </div>
            <label class="col-xs-1 control-label">반응시간대</label>
            <div class="col-xs-1 control_content">
               <ifvm:inputNew type="select"  id="timeCd" names="timeCd" dto="timeCd"/>
            </div>
            <label class="col-xs-1 control-label">성별</label>
            <div class="col-xs-1 control_content">
               <ifvm:inputNew type="select"  id="genCd" names="genCd" dto="genCd"/>
            </div>
            <label class="col-xs-1 control-label">연령별</label>
            <div class="col-xs-1 control_content">
               <ifvm:inputNew type="select"  id="ageCd" names="ageCd" dto="ageCd"/>
            </div>
      </div>
   </div>
<!--     <div class="well form-horizontal well_bt5" id="SearchList" > </div>-->
</div>

<div>
    <div class="page_btn_area" id =''>

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="excelExportBtn" objCode="camChnlDtlReactionExcelExportBtn_OBJ">
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    
	<div id="sendCampaignDetailGrid" class="white_bg grid_bd0"></div>
	<div id="campaignDetailGrid" class="white_bg grid_bd0"></div>   
</div>
<div id="searchCampPop" class="popup_container"></div>