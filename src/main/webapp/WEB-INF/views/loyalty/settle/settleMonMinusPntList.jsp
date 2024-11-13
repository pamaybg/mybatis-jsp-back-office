<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var settleMonMinusPntGrid;
var settleMonMinusPntAGrid;

var settleMonMinusPntGridData = [];


var yyyy;
var mm;

//등급그룹 목록 조회
function getsettleMonMinusPntList(data){
    var ejGridOption = {
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }     
            return data;
       	},
       	rowSelected : function(args){
       	},
       	dataSource : data,
        datatype: 'clientSide',
        columns:[ 
	      	  {
	      		  field : 'totMinusPnt', headerText : '마이너스 발생 포인트', headerTextAlign : 'center', format : '{0:n0}', textAlign : 'right',
	      		  customAttributes : {
	      			  index : 'totMinusPnt' , sortable: false }/* 마이너스 포인트*/
	      	  },{
	      		  field : 'totRemainPnt', headerText : '마이너스 포인트 합계', headerTextAlign : 'center', format : '{0:n0}', textAlign : 'right',
	      		  customAttributes : {
	      			  index : 'totRemainPnt' , sortable: false}/* 거래 금액 */
	      	  },{
	      		  field : 'totCnt', headerText : '건수', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'totCnt' , sortable: false}/* 잔여 포인트 */
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
    
    settleMonMinusPntGrid = $("#settleMonMinusPntGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//등급그룹 목록 조회
function getsettleMonMinusPntAList(){
    var ejGridOption = {
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }     
            return data;
       	},
       	loadComplete : function(obj){
       		$.ifvSyncPostJSON('<ifvm:action name="getSettleMonMinusPntList"/>', {
       			item : requestitem,
       			yyyy : yyyy,
       	        mm : mm,
       	    }, function(result) {
       	        if ($.fn.ifvmIsNotEmpty(result.rows)) {
       	        	settleMonMinusPntGridData = [];
       	        	settleMonMinusPntGridData.push(result.rows[0])
       	        	getsettleMonMinusPntList(settleMonMinusPntGridData);
       	        }else{
       	        	settleMonMinusPntGridData = [];
       	        	getsettleMonMinusPntList(settleMonMinusPntGridData);
       	        }
       	    });
       	},
       	dataUrl : '<ifvm:action name="getSettleMonMinusPntList"/>',
        columns:[ 
        	  {
	      		  field : 'minusDate', headerText : '일자', headerTextAlign : 'center',  textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'minusDate' }/* # */
	      	  },
        	  {
	      		  field : 'minusPnt', headerText : '마이너스 발생 포인트', headerTextAlign : 'center',  textAlign : 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'minusPnt' }/* 회원번호 */
	      	  },{
	      		  field : 'minusCnt', headerText : '마이너스 발생 건수', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'minusCnt' }/* 마이너스 발생 시점*/
	      	  },{
	      		  field : 'remainPnt', headerText : '마이너스 포인트 합계', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'remainPnt'}/* 마이너스 포인트 */
	      	  }
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'seq',
	      	  sord : '',
	      	  _search : false
	    },
	    rowList : [10,25,50,100],
        gridDataInit : false,
        tempId : 'ifvGridSimplePageTemplete2'
    };
    
    settleMonMinusPntAGrid = $("#settleMonMinusPntAGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회조건 필수값 체크
function validationCheck(table){
	var validationVal =  false;
	if(table == "LOY_FAM_DAY"){
		validationVal =  true;
	}
	$(".SearchCondition .searchTextVal option:selected").filter(function(){
		if($(this).attr('grpcode') == table){
			if($(this).parents('.SearchCondition').css("display") !="none"){
				if($.fn.ifvmIsNotEmpty( $(this).parents('.SearchCondition').find('.changeTypeAreaCode  select').val())){
					validationVal = true;
					if(table == "SETTLE_YEAR"){
						yyyy = $(this).parents('.SearchCondition').find('.changeTypeAreaCode  select').val()
					}else if(table == "SETTLE_MONTH"){
						mm = $(this).parents('.SearchCondition').find('.changeTypeAreaCode  select').val()
					}
				}
			}
		}
	})
	return validationVal;
}


//공통 조회 조건 목록 설정
function settleMonMinusPntListSearchInit() {
    $.fn.ifvmSetCommonCondList("settleMonMinusPntSearchList","SETTLE_MON_MINUS_PNT");
    
    $(".searchTextVal option:selected").filter(function(){
        $(this).parents('.SearchCondition').find('.searchCondition option[value="NOT"]').remove();
        $(this).parents('.SearchCondition').find('option[value="ALL"]').remove();
    })
}

//공통 조회 호출
function searchsettleMonMinusPntAList() {
	if(validationCheck("SETTLE_YEAR") && validationCheck("SETTLE_MONTH")){
		$.fn.ifvmSubmitSearchCondition("settleMonMinusPntSearchList",function() {
			settleMonMinusPntAGrid.searchGrid({
				item:requestitem,
				yyyy : yyyy,
				mm : mm,
				});
		});
	}else{
		alert("년도와 월은 필수 조회조건입니다.");
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
function settleMonMinusPntListExcelExport() {
	$.ifvExcelDnMultiSheet('/loyalty/settle/getSettleMonMinusPntExeDown.do',['settleMonMinusPntGrid','settleMonMinusPntAGrid']);
}

$(document).ready(function() {
	
    //공통 조회 조건 목록 설정
    settleMonMinusPntListSearchInit();
    
    getsettleMonMinusPntList(settleMonMinusPntGridData);
    //전체 그리드 조회
    getsettleMonMinusPntAList();
    
    //조회
    $('#settleSolPayAListSearchBtn').on('click', function(){
    	searchsettleMonMinusPntAList();
    });
    
    //초기화
    $("#settleSolPayAListSearchInitBtn").on('click', function(){
    	settleMonMinusPntListSearchInit();
    });
    
  	//엑셀 다운로드
    $("#settleMonMinusPntListExcelExportBtn").on('click', function(){
    	settleMonMinusPntListExcelExport();
    });
});

</script>

<div class="page-title">
    <h1>
         <spring:message code="M02827" /> 
        &gt; 마이너스 포인트 조회(월기준)
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
    
    <div class="well form-horizontal well_bt5" id="settleMonMinusPntSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" id =''>

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="settleMonMinusPntListExcelExportBtn">
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    <div class="form-horizontal underline top_well">
   		<div class = "row">
   			<div class = "half_wrap top_well">
   				<div class = "half_content half_left qt_border">
   					<div id="settleMonMinusPntGrid" class="white_bg grid_bd0"></div>    
   				</div>
   			</div>
   		</div>
	</div>
    
    <div id="settleMonMinusPntAGrid" class="white_bg grid_bd0"></div> 
</div>
