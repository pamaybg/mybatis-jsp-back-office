<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var settleSolPayHistoryGrid;
var settleSolPayHistoryAListGrid;

//등급그룹 목록 조회
function getSettleSolPayDownList(){
    var ejGridOption = {
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }     
            return data;
       	},
       	rowSelected : function(args){
       	},
       	dataUrl : '<ifvm:action name="getSettleSolPayChnlMonthHistorySum"/>',
        columns:[ 
        	  {
	      		  field : 'ct', headerText : '<spring:message code="L01420"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'ct' , sortable: false}/* 내용 */
	      	  },{
	      		  field : 'totalPnt', headerText : '<spring:message code="L02390"/>', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'totalPnt' , sortable: false }/* 발생 포인트 */
	      	  },{
	      		  field : 'totalCnt', headerText : '<spring:message code="L02391"/>', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'totalCnt' , sortable: false}/* 발생건수 */
	      	  },{
	      		  field : 'totalAmt', headerText : '<spring:message code="L02392"/>', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'totalAmt' , sortable: false}/* 거래 금액 */
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
    
    settleSolPayHistoryGrid = $("#settleSolPayHistoryGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//등급그룹 목록 조회
function getSettleSolPayHistoryAList(){
    var ejGridOption = {
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }     
            return data;
       	},
       	rowSelected : function(args){
       	},
       	dataUrl : '<ifvm:action name="getSettleSolPayChnlMonthHistoryList"/>',
        columns:[ 
        	  {
	      		  field : 'fixDt', headerText : '일자', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'fixDt' }/* 일자 */
	      	  },{
	      		  field : 'chnlNo', headerText : '매장코드', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'chnlNo' }/* 매장코드*/
	      	  },{
	      		  field : 'chnlNm', headerText : '매장명', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'chnlNm'}/* 매장명 */
	      	  },{
	      		  field : 'acrlPnt', headerText : '적립', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'acrlPnt'}/* 적립 */
	      	  },{
	      		  field : 'cnclPnt', headerText : '취소', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'cnclPnt'}/* 취소 */
	      	  },{
	      		  field : 'totalPnt', headerText : '총', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'totalPnt'}/* 총*/
	      	  },{
	      		  field : 'acrlCnt', headerText : '적립', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'acrlCnt'}/* 적립*/
	      	  },{
	      		  field : 'cnclCnt', headerText : '취소', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'cnclCnt'}/* 취소*/
	      	  },{
	      		  field : 'totalCnt', headerText : '총', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'totalCnt'}/* 총*/
	      	  },{
	      		  field : 'acrlAmt', headerText : '적립', headerTextAlign : 'center',textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'acrlAmt'}/* 적립 */
	      	  },{
	      		  field : 'cnclAmt', headerText : '취소', headerTextAlign : 'center',textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'cnclAmt'}/* 취소*/
	      	  },{
	      		  field : 'totalAmt', headerText : '총', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'totalAmt'}/* 총 */
	      	  }
        ],
        stackedHeaderRows: [{ 
            stackedHeaderColumns:[
            	{ headerText: "", column: "fixDt, chnlNo, chnlNm",  headerTextAlign : "center"},
                { headerText: "발생 포인트", column: "acrlPnt, cnclPnt, totalPnt", headerTextAlign : "center" },
                { headerText: "발생 건수", column: "acrlCnt, cnclCnt, totalCnt", headerTextAlign : "center" },
                { headerText: "거래 금액", column: "acrlAmt, cnclAmt, totalAmt", headerTextAlign : "center" },
            ] 
        }],
        actionComplete: function (args) { 
        	$(this.getHeaderContent().find(".e-stackedHeaderCell")[1]).css("text-align", "center");
        	$(this.getHeaderContent().find(".e-stackedHeaderCell")[2]).css("text-align", "center");
        	$(this.getHeaderContent().find(".e-stackedHeaderCell")[3]).css("text-align", "center");
        },
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'fixDt, chnlNo',
	      	  sord : 'asc',
	      	  _search : false
	    },
	    rowList : [10,25,50,100],
	    showStackedHeader:true,
        gridDataInit : false,
        tempId : 'ifvGridSimplePageTemplete2'
    };
    
    settleSolPayHistoryAListGrid = $("#settleSolPayHistoryAListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
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


//공통 조회 조건 목록 설정
function settleSolPayListSearchInit() {
    $.fn.ifvmSetCommonCondList("settleSolPayHistorySearchList","SETTLE_SOL__CHNL_MONTH_HIST_LIST");
    
    $(".searchTextVal option:selected").filter(function(){
        $(this).parents('.SearchCondition').find('.searchCondition option[value="NOT"]').remove();
    })
}

//공통 조회 호출
function settleDayAListSearch() {
	if(validationCheck("YYYY") && validationCheck("MM")){
		$.fn.ifvmSubmitSearchCondition("settleSolPayHistorySearchList",function() {
			settleSolPayHistoryGrid.searchGrid({item : requestitem});
			settleSolPayHistoryAListGrid.searchGrid({item:requestitem});
		});
	}else{
		alert("년도와 월을 모두 입력해주세요");
	}
} 

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
        }
    };

    $.ifvExcelDnMultiSheet = function(targetUrl, strGridId , data) {
    	var reqData = [];
    	$.each(strGridId, function(i, e) {
	        var header =  syncfution.getHeads(e);
	        var gridOption = $( "#gridId" + e ).data("ejGrid").option();
	
	        var _reqData = gridOption.requestGridData;
	        _reqData.rows = 9999999;
	        _reqData.excelHeader = JSON.stringify(header)
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

//엑셀 다운로드 
function settleSolPayHistoryListExcelExport() {
	$.ifvExcelDnMultiSheet('/loyalty/settle/getSettleSolPayChnlMonthHistoryExcel.do',['settleSolPayHistoryGrid','settleSolPayHistoryAListGrid']);
}

$(document).ready(function() {
	
    //공통 조회 조건 목록 설정
    settleSolPayListSearchInit();
    
	//요약그리드 조회
    getSettleSolPayDownList();
    //전체 그리드 조회
    getSettleSolPayHistoryAList();
    
    //조회
    $('#settleSolPayAListSearchBtn').on('click', function(){
    	settleDayAListSearch();
    });
    
    //초기화
    $("#settleSolPayAListSearchInitBtn").on('click', function(){
    	settleSolPayListSearchInit();
    });
    
  	//엑셀 다운로드
    $("#settleSolPayHistoryListExcelExportBtn").on('click', function(){
    	settleSolPayHistoryListExcelExport();
    });
});

</script>

<div class="page-title">
    <h1>
         <spring:message code="M02827" /> 
        &gt; SOL페이 내역 조회(매장+월기준)
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="settleSolPayAListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="settleSolPayAListSearchInitBtn">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    
    <div class="well form-horizontal well_bt5" id="settleSolPayHistorySearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" id =''>

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="settleSolPayHistoryListExcelExportBtn">
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    <div class="form-horizontal underline top_well">
   		<div class = "row">
   			<div class = "half_wrap top_well">
   				<div class = "half_content half_left qt_border">
   					<div id="settleSolPayHistoryGrid" class="white_bg grid_bd0"></div>    
   				</div>
   			</div>
   		</div>
	</div>
    
    <div id="settleSolPayHistoryAListGrid" class="white_bg grid_bd0"></div> 
</div>
