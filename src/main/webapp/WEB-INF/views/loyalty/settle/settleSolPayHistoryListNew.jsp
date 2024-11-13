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
       	dataUrl : '<ifvm:action name="getSettleSolPayHistoryList"/>',
        columns:[ 
        	  {
	      		  field : 'ct', headerText : '<spring:message code="L01420"/>', headerTextAlign : 'center', 
	      		  customAttributes : {
	      			  index : 'ct' , sortable: false}/* 내용 */
	      	  },{
	      		  field : 'solPnt', headerText : '<spring:message code="L02390"/>', headerTextAlign : 'center', format : '{0:n0}', textAlign : 'right',
	      		  customAttributes : {
	      			  index : 'solpnt' , sortable: false }/* 발생 포인트 */
	      	  },{
	      		  field : 'cnt', headerText : '<spring:message code="L02391"/>', headerTextAlign : 'center', textAlign : 'right',
	      		  customAttributes : {
	      			  index : 'cnt' , sortable: false}/* 발생건수 */
	      	  },{
	      		  field : 'txnAmt', headerText : '<spring:message code="L02392"/>', headerTextAlign : 'center', format : '{0:n0}', textAlign : 'right',
	      		  customAttributes : {
	      			  index : 'txnamt' , sortable: false}/* 거래 금액 */
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
       	dataUrl : '<ifvm:action name="getSettleSolPayHistoryAList"/>',
        columns:[ 
        	  {
	      		  field : 'apprDt', headerText : '<spring:message code="L02396"/>', headerTextAlign : 'center',  textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'apprDt' }/* 승인일자 */
	      	  },{
	      		  field : 'fixDt', headerText : '<spring:message code="L02397"/>', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'fixDt' }/* 확정일자*/
	      	  },{
	      		  field : 'chnlNo', headerText : '<spring:message code="L02398"/>', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'chnlNo'}/* 매장코드 */
	      	  },{
	      		  field : 'chnlNm', headerText : '<spring:message code="L02399"/>', headerTextAlign : 'center', 
	      		  customAttributes : {
	      			  index : 'chnlNm'}/* 매장명 */
	      	  },{
	      		  field : 'rcptNo', headerText : '<spring:message code="L02400"/>', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'rcptNo'}/* 영수증번호 */
	      	  },{
	      		  field : 'originRcptNo', headerText : '<spring:message code="L02401"/>', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'originRcptNo'}/* 원거래 영수증 번호*/
	      	  },{
	      		  field : 'mbrNo', headerText : '<spring:message code="L02402"/>', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'mbrNo'}/* 회원번호 */
	      	  },{
	      		  field : 'txnAmt', headerText : '<spring:message code="L02403"/>', headerTextAlign : 'center', format : '{0:n0}', textAlign : 'right',
	      		  customAttributes : {
	      			  index : 'txnAmt'}/* 거래금액 */
	      	  },{
	      		  field : 'abTxnAmt', headerText : '<spring:message code="L02404"/>', headerTextAlign : 'center', format : '{0:n0}', textAlign : 'right',
	      		  customAttributes : {
	      			  index : 'abTxnAmt'}/* 반영 금액*/
	      	  },{
	      		  field : 'daisoPnt', headerText : '<spring:message code="L02405"/>', headerTextAlign : 'center', format : '{0:n0}', textAlign : 'right',
	      		  customAttributes : {
	      			  index : 'daisoPnt'}/* 발생포인트 */
	      	  },{
	      		  field : 'abSolPnt', headerText : '<spring:message code="L02406"/>', headerTextAlign : 'center', format : '{0:n0}', textAlign : 'right',
	      		  customAttributes : {
	      			  index : 'abSolPnt'}/* 반영포인트*/
	      	  },{
	      		  field : 'txnStat', headerText : '<spring:message code="L02407"/>', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'txnStat'}/* 포인트거래상태 */
	      	  }
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'YYYYMM',
	      	  sord : 'desc',
	      	  _search : false
	    },
	    rowList : [10,25,50,100],
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
    $.fn.ifvmSetCommonCondList("settleSolPayHistorySearchList","SETTLE_SOL_HIST_LIST");
    
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
	$.ifvExcelDnMultiSheet('/loyalty/settle/getSettleSolPayHistoryExeDown.do',['settleSolPayHistoryGrid','settleSolPayHistoryAListGrid']);
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
        &gt; <spring:message code="L02420" />
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
