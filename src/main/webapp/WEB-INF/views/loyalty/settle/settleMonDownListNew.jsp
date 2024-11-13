<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var settleMonthGrid;

//등급그룹 목록 조회
function getSettleMonDownList(){
    var ejGridOption = {
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }     
            return data;
       	},
       	rowSelected : function(args){
       		
       	},
       	dataUrl : '<ifvm:action name="getSettleMonDownList"/>',
        columns:[ 
        	  {
	      		  field : 'term', headerText : '<spring:message code="M00607"/>', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'am.YYYYMM' }/* 기간 */
	      	  },{
	      		  field : 'fileNm', headerText : '<spring:message code="M00443"/>', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'fileNm' }/* 파일명 */
	      	  },{
	      		  field : 'createDate', headerText : '<spring:message code="L00753"/>', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'am.create_date' }/* 생성일시 */
	      	  }
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'am.YYYYMM',
	      	  sord : 'desc',
	      	  _search : false
	    },
	    rowList : [10,25,50,100],
        autowidth : true ,
        radio : true,
        tempId : 'ifvGridSimpleTemplete'
    };
    
    settleMonthGrid = $("#settleMonthGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


//월정산 전용 엑셀 다운로드
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

    $.settleMonExcelDn = function(targetUrl, strGridId , data) {
        var header =  syncfution.getHeads(strGridId);
        var gridOption = $( "#gridId"+strGridId ).data("ejGrid").option();

        var reqData = gridOption.requestGridData;
        reqData.rows = 9999999;
        reqData.excelHeader = JSON.stringify(header);
        reqData.item = requestitem;
        reqData.fileNm = settleMonthGrid.opt.gridControl.getSelectedRecords()[0].fileNm;
        reqData.term = settleMonthGrid.opt.gridControl.getSelectedRecords()[0].term;

        $.extend(reqData,data);

        $.ifvProgressControl(true);

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

//공통 조회 조건 목록 설정
function settleDayAListSearchInit() {
    $.fn.ifvmSetCommonCondList("settleMonthSearchList","SETTLE_MONTH_DOWN_01");
}

//공통 조회 호출
function settleDayAListSearch() {
	$('.ifvm_comm_cond_text').val(new Date().getFullYear());
    $.fn.ifvmSubmitSearchCondition("settleMonthSearchList", getSettleMonDownList);
} 

//엑셀 다운로드 
function settleMonthListExcelExport() {
	if(settleMonthGrid.opt.gridControl.getSelectedRecords().length == 1) {
		$.settleMonExcelDn('<ifvm:action name = "settleMonExeDown"/>','settleMonthGrid' );
	}else{
		alert('<spring:message code = "M00004"/>');
	}
}

$(document).ready(function() {
    
    //공통 조회 조건 목록 설정
    settleDayAListSearchInit();
	
    settleDayAListSearch();
    
    //목록조회
// 	getSettleMonDownList();
	
    //조회
    $('#settleDayAListSearchBtn').on('click', function(){
    	settleDayAListSearch();
    });
    
    //초기화
    $("#settleDayAListSearchInitBtn").on('click', function(){
    	settleDayAListSearchInit();
    });
    
  	//엑셀 다운로드
    $("#settleMonthListExcelExportBtn").on('click', function(){
    	settleMonthListExcelExport();
    });
    
    
});

</script>

<div class="page-title">
    <h1>
         <spring:message code="M02827" /> 
        &gt; <spring:message code="M02892" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="settleDayAListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="settleDayAListSearchInitBtn">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="settleMonthSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="settleMonthListExcelExportBtn">
                <spring:message code="M01218" />
            </button> 
        </div>
    </div>
    <div id="settleMonthGrid" class="white_bg grid_bd0 grid_scroll5"></div>     
</div>
