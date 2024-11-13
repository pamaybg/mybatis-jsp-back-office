<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var csPointAcrlTotalGrid;
var csPointAcrlListGrid;

//요약 목록 조회
function getCsPointAcrlTotal(){
    var ejGridOption = {
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }
            return data;
       	},
       	rowSelected : function(args){
       	},
       	dataUrl : '<ifvm:action name="getCSPointAcrlSum"/>',
        columns:[
        	  {
	      		  field : 'pntTxnType', headerText : '구분', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'pntTxnType' , sortable: false }/*구분 */
	      	  },{
	      		  field : 'count', headerText : '<spring:message code="L02391"/>', headerTextAlign : 'center', textAlign : 'right',
	      		  customAttributes : {
	      			  index : 'count' , sortable: false}/* 발생건수 */
	      	  },{
	      		  field : 'pntSum', headerText : '포인트 금액', headerTextAlign : 'center', format : '{0:n0}', textAlign : 'right',
	      		  customAttributes : {
	      			  index : 'pntSum' , sortable: false}/* 포인트 금액*/
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

    csPointAcrlTotalGrid = $("#csPointAcrlTotalGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//리스트 목록 조회
function getCsPointAcrlList(){
    var ejGridOption = {
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }
            return data;
       	},
       	rowSelected : function(args){
       	},
       	dataUrl : '<ifvm:action name="getCSPointAcrlList"/>',
        columns:[
        	  {
	      		  field : 'txnDt', headerText : '일자', headerTextAlign : 'center',textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'txnDt' }/* 일자 */
	      	  },{
	      		  field : 'pntTxnDtlType', headerText : '구분', headerTextAlign : 'center', textAlign : 'center',width : '80px',
	      		  customAttributes : {
	      			  index : 'pntTxnDtlType' }/* 구분 */
	      	  },{
	      		  field : 'camNm', headerText : '상세 구분', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'camNm'}/* 상세 구분 */
	      	  },{
	      		  field : 'empName', headerText : '지급자명', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'rdmAmt'}/* 지급자명 */
	      	  },{
	      		  field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'mbrNo'}/* 회원번호 */
	      	  },{
	      		  field : 'pntAmt', headerText : '포인트', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'pntAmt'}/* 포인트 */
	      	  },{
	      		  field : 'vocDesc', headerText : '사유', headerTextAlign : 'center', textAlign : 'left',
	      		  customAttributes : {
	      			  index : 'vocDesc'}/* 사유 */
	      	  }
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  _search : false
	    },
	    rowList : [10,25,50,100],
        gridDataInit : false,
        tempId : 'ifvGridSimplePageTemplete2'
    };

    csPointAcrlListGrid = $("#csPointAcrlListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회조건 필수값 체크
function validationCheck(table){
	var validationVal =  false;
	$(".SearchCondition .searchTextVal option:selected").filter(function(){
		if($(this).attr('jointgtclm') == table){
			if($(this).parents('.SearchCondition').css("display")	!="none"){
				if( $.fn.ifvmIsNotEmpty(  $(this).parents('.SearchCondition').find('.changeTypeAreaCode  select').val())) {
					validationVal=true;
				}
			}
		}
	})
	return validationVal;
}

//공통 조회 조건 목록 설정
function setCsPointAcrlListSearchInit() {
    $.fn.ifvmSetCommonCondList("csPointAcrlListSearchList","SETTLE_CS_POINT_ACRL_01");

    $(".searchTextVal option:selected").filter(function(){
        $(this).parents('.SearchCondition').find('.searchCondition option[value="NOT"]').remove();
    })
}

//공통 조회 호출
function csPointAcrlListSearch() {
	if(validationCheck("YYYY") && validationCheck("MM") ){
		$.fn.ifvmSubmitSearchCondition("csPointAcrlListSearchList",function() {
			csPointAcrlListGrid.searchGrid({item:requestitem});
			csPointAcrlTotalGrid.searchGrid({item:requestitem});
		});
	}else{
		alert("년도와 월을 모두 입력해주세요.");
	}

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
                        window.location = downloadUrl;
                    }

                    setTimeout(function() {
                        URL.revokeObjectURL( downloadUrl );
                    }, 100);
                }
            }
        };

        xhr.setRequestHeader( "Content-Type", "application/json" );
        xhr.send( JSON.stringify(reqData) );
    }
})();

//엑셀 다운로드
function csPointAcrlExcelExport() {
	 $.ifvExcelDnMultiSheet('/loyalty/settle/getCSPointAcrlListExcel.do',['csPointAcrlTotalGrid','csPointAcrlListGrid']);
}

$(document).ready(function() {

    //공통 조회 조건 목록 설정
    setCsPointAcrlListSearchInit();

  	//전체 그리드 조회
    getCsPointAcrlList();
	//요약그리드 조회
    getCsPointAcrlTotal();

    //조회
    $('#csPointAcrlListSearchBtn').on('click', function(){
    	csPointAcrlListSearch();
    });

    //초기화
    $("#csPointAcrlListSearchInitBtn").on('click', function(){

    	setCsPointAcrlListSearchInit();
    });

  	//엑셀 다운로드
    $("#csPointAcrlExcelExportBtn").on('click', function(){

    	csPointAcrlExcelExport();
    });
});

</script>

<div class="page-title">
    <h1>
    	<spring:message code="M02827" />
     	&gt; CS 포인트 지급 내역
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="csPointAcrlListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="csPointAcrlListSearchInitBtn">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>

    <div class="well form-horizontal well_bt5" id="csPointAcrlListSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" id =''>

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="csPointAcrlExcelExportBtn">
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    <div class="form-horizontal underline top_well">
   		<div class = "row">
   			<div class = "half_wrap top_well">
   				<div class = "half_content half_left qt_border">
   					<div id="csPointAcrlTotalGrid" class="white_bg grid_bd0"></div>
   				</div>
   			</div>
   		</div>
	</div>

    <div id="csPointAcrlListGrid" class="white_bg grid_bd0"></div>
</div>
