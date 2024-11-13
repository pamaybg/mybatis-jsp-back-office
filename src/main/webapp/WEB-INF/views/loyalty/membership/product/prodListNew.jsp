<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var prodListGrid;
// var prodSpecGrid;
// var prodSpecGridList;
// var prodSpecData;
// var prodPosGrid;
// var prodPosGridList;
// var prodPosData;
// var termsDetailListtermsDetailList;


//팝업 닫기
// function prodDtlPopClose() {
// 	prodDialog._destroy();
// 	init();
// }

    function numFormat( cellvalue, options, rowObject ){
        cellvalue = cellvalue.substr(0,19);
        return cellvalue;
    }

//상품 목록 조회
function getProdList(){
    var ejGridOption = {
   		recordDoubleClick : function(args){
       		var data = args.data;
       		rid = data.rid;
//        		prodDtlPop(data.rid);
       	},
        rowSelected : function (args) {
            rid = args.data.rid;
//        		getProdSpec(rid);
//             getProdPos(rid);
       	},
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
       	},
       	dataUrl : '<ifvm:action name="getProdList"/>',
       	columns: [
                {
                    field : 'prodId', headerText : '<spring:message code="E00091"/>', textAlign : 'center', width: 100
                    ,headerTextAlign : ej.TextAlign.Center,customAttributes : { searchable: true, index : 'T1.PROD_ID' }//자재코드 
                }                  
                ,{
                    field : 'mmzzStdItemCd', headerText : '<spring:message code="E00100"/>', textAlign : 'center', width: 120
                    ,headerTextAlign : ej.TextAlign.Center,customAttributes : { searchable: true, index : 'T2.MMZZSTDITEMCD' }//표준아이템코드
                }
                ,{
                    field : 'mmzzItemCd', headerText : '<spring:message code="E00101"/>', textAlign : 'center' , width: 120
                    ,headerTextAlign : ej.TextAlign.Center ,customAttributes : { searchable: true, index : 'T2.MMZZITEMCD' }//아이템코드
                
                }
                ,{
                    field : 'mmzzRepCd1', headerText : '<spring:message code="E00102"/>', textAlign : 'center' , width: 120
                    ,headerTextAlign : ej.TextAlign.Center,customAttributes : { index : 'T2.MMZZREPCD1' }//수요할당코드
                }
                ,{
                    field : 'mmzzRepCd2', headerText : '<spring:message code="E00103"/>', textAlign : 'center' , width: 100
                    ,headerTextAlign : ej.TextAlign.Center ,customAttributes : { index : 'T2.MMZZREPCD2' }//대체코드
                }
                ,{
                    field : 'mmSkucd', headerText : '<spring:message code="E00104"/>', textAlign : 'center' , width: 120
                    ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'mmSkucd' }//SKU채널코드
                }
                ,{
                    field : 'prodNm', headerText : '<spring:message code="E00105"/>', textAlign : ej.TextAlign.Left, width: 400
                    ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : { searchable: true, index : 'T1.PROD_NM' }//자재이름
                }
                ,{
                    field : 'shGoodsNo', headerText : '<spring:message code="E00106"/>', textAlign : 'center', width: 100
                    ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'shGoodsNo' }//자사몰구분
                }
                ,{
                    field : 'shGoodsCode', headerText : '<spring:message code="E00107"/>', textAlign : 'center', width: 100
                    ,headerTextAlign : ej.TextAlign.Center    ,customAttributes : {index : 'shGoodsCode' }//상품코드
                }
                ,{
                    field : 'shGoodsName', headerText : '<spring:message code="E00108"/>', textAlign : 'left', width: 400
                    ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'shGoodsName' }//상품명 제품명 코드
                }
                ,{
                    field : 'mmMtart', headerText : '<spring:message code="E00109"/>', textAlign : 'center', width: 100
                    ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'mmMtart' }//자재유형
                }
                ,{
                    field : 'lCtg', headerText : '<spring:message code="E00110"/>', textAlign : 'center', width: 140
                    ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'lCtg' }//카테고리(대)
                }
                ,{
                    field : 'mCtg', headerText : '<spring:message code="E00111"/>', textAlign : 'center', width: 140
                    ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'mCtg' }//카테고리(중)
                }
                ,{
                    field : 'sCtg', headerText : '<spring:message code="E00112"/>', textAlign : 'center', width: 140
                    ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'sCtg' }//카테고리(소)
                }
                ,{
                    field : 'mmPrdha', headerText : '<spring:message code="E00113"/>', textAlign : 'center', width: 100
                    ,headerTextAlign : ej.TextAlign.Center   ,customAttributes : {index : 'mmPrdha' }//카테고리 제품 계층구조
                }
                ,{
                    field : 'mmGroup', headerText : '<spring:message code="E00114"/>', textAlign : 'center', width: 160
                    ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'mmGroup' }//글로벌 카테고리
                }
                ,{
                    field : 'sdp1Price', headerText : '<spring:message code="E00115"/>', textAlign : 'right', width: 100
                    ,headerTextAlign : ej.TextAlign.Center, format : '{0:n0}',customAttributes : {index : 'sdp1Price' }//P1가격
                }
                ,{
                    field : 'sdp1Unit', headerText : '<spring:message code="E00116"/>', textAlign : 'center', width: 100
                    ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'sdp1Unit' }//P1기준통화
                }
                ,{
                    field : 'mmfStdate', headerText : '<spring:message code="E00117"/>', textAlign : 'center' , width: 100
                    ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'mmfStdate' }//최초 입고일
                }
                ,{
                    field : 'scmGrade', headerText : '<spring:message code="E00118"/>', textAlign : 'center', width: 100
                    ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'scmGrade' }//재고등급
                }
                ,{
                    field : 'goodsCode', headerText : '<spring:message code="E00107"/>', textAlign : 'center', width: 100
                    ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'goodsCode' }//상품코드
                }
                ,{
                    field : 'goodsName', headerText : '<spring:message code="O00089"/>', textAlign : 'left', width: 400
                    ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'goodsName' }//상품명
                }
                ,{
                    field : 'salesMall', headerText : '<spring:message code="E00119"/>', textAlign : 'center', width: 100
                    ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'salesMall' }//판매몰
                }
                ,{
                    field : 'goodsPack', headerText : '<spring:message code="E00142"/>', textAlign : 'center', width: 100
                    ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'goodsPack' }//단품/세트
                }
                ,{
                    field : 'oversea', headerText : '<spring:message code="E00121"/>', textAlign : 'center', width: 100
                    ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'oversea' }//해외배송
                }
                ,{
                    field : 'salesSdate', headerText : '<spring:message code="E00122"/>', textAlign : 'center', width: 100
                    ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'salesSdate' }//판매기간시작
                }
                ,{
                    field : 'salesEdate', headerText : '<spring:message code="E00123"/>', textAlign : 'center', width: 100
                    ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'salesEdate' }//판매기간끝
                }
                ,{
                    field : 'eprice', headerText : '<spring:message code="E00124"/>', textAlign : 'right', width: 100
                    ,headerTextAlign : ej.TextAlign.Center , format : '{0:n0}' ,customAttributes : {index : 'eprice' }//사원몰 가격
                }
               ,{
                    field : 'mallPrice', headerText : '<spring:message code="E00128"/>', textAlign : 'right', width: 100
                    ,headerTextAlign : ej.TextAlign.Center , format : '{0:n0}' ,customAttributes : {index : 'mallPrice' }//판매가
                }
               ,{
                    field : 'state', headerText : '<spring:message code="E00149"/>', textAlign : 'center', width: 100
                    ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'state' }//재고등급
                }
                ,{
                    field : 'offPrice', headerText : '<spring:message code="E00143"/>', textAlign : 'right', width: 130
                    ,headerTextAlign : ej.TextAlign.Center , format : '{0:n0}',customAttributes : {index : 'offPrice' }//오프라인 판매가
                }
                ,{
                    field : 'offPromPrice', headerText : '<spring:message code="E00144"/>', textAlign : 'right', width: 130
                    ,headerTextAlign : ej.TextAlign.Center , format : '{0:n0}',customAttributes : {index : 'offPromPrice' }//오프라인 행사가
                }
                ,{
                    field : 'offEvtSupPrice', headerText : '<spring:message code="E00145"/>', textAlign : 'right', width: 130
                    ,headerTextAlign : ej.TextAlign.Center , format : '{0:n0}',customAttributes : {index : 'offEvtSupPrice' }//오프라인 행사 공급가
                }
                ,{
                    field : 'offStrdSupPrice', headerText : '<spring:message code="E00146"/>', textAlign : 'right', width: 130
                    ,headerTextAlign : ej.TextAlign.Center , format : '{0:n0}',customAttributes : {index : 'offStrdSupPrice' }//오프라인 기준 공급가 
                }
       	],
        requestGridData : {
      	  sidx : 'prodId',
      	  sord : 'desc'
        },
        rowList : [10,25,50,100],
        radio: true,
        //tempId : 'ifvGridSimplePageTemplete',
        isHorizontalScroll : true,
        allowResizing: true
    };

    prodListGrid = $("#prodListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


//공통 조회 조건 목록 설정
function prodListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("prodSearchList","PRGO_PRODUCT",gridId);
}

//공통 조회 호출
function prodListSearch() {
    $.fn.ifvmSubmitSearchCondition("prodSearchList", getProdList);
}

// function prodDtlPop(rid){
// 	$("#prodDialog").ifvsfPopup({
// 		enableModal : true,
//         enableResize: false,
//         contentUrl: '<ifvm:url name="prodDtlPop"/>'+'?rid='+rid,
//         contentType: "ajax",
//         title: '<spring:message code="상품 등록" />',
//         width: '700px',
//         close : 'prodDtlPopClose'
//     });
// }

//코드 리스트 그리드를 그리는 함수
// function getProdSpec(rid) {
//   var ejGridOption = {
// 		  recordDoubleClick : function(args){
// 				prodSpecData = args.data;
// 				prodSpecDetailPopupOpen(prodSpecData.prodSpecRid);
// 			},
// 			serializeGridData : function( data ){
//                 data.ridProd = rid;
//                 return data;
//            	},
// 			dataUrl : '<ifvm:action name="getProdSpecList"/>',
// 			columns:[
// 			     {
//                       field : 'goodsCode', headerText : '<spring:message code="E00107"/>', textAlign : 'center'//상품코드
//                       ,customAttributes : {index : 'goodsCode' } 
//                  }
// 			     ,{
//                       field : 'goodsName', headerText : '<spring:message code="O00089"/>', textAlign : 'center'//상품명
//                  }
// 			     ,{
//                      field : 'salesMall', headerText : '<spring:message code="E00119"/>', textAlign : 'center'//판매몰
//                  }
// 			     ,{
//                      field : 'goodsPack', headerText : '<spring:message code="E00120"/>', textAlign : 'center'//단품/세트
//                  }
// 			     ,{
//                      field : 'overSea', headerText : '<spring:message code="E00121"/>', textAlign : 'center'//해외배송
//                  }
// 			     ,{
//                      field : 'salesSdate', headerText : '<spring:message code="E00122"/>', textAlign : 'center'//판매기간시작
//                  }
// 			     ,{
//                      field : 'salesEdate', headerText : '<spring:message code="E00123"/>', textAlign : 'center'//판매기간끝
//                  }
// 			     ,{
//                      field : 'epRice', headerText : '<spring:message code="E00124"/>', textAlign : 'center'//사원몰가격
//                  }
// 			     ,{
//                      field : 'opRice', headerText : '<spring:message code="E00125"/>', textAlign : 'center'//아울렛가격
//                  }
// 			     ,{
//                      field : 'bpRice', headerText : '<spring:message code="E00126"/>', textAlign : 'center'//대량몰가격
//                  }
// 			     ,{
//                      field : 'marketPrice', headerText : '<spring:message code="E00127"/>', textAlign : 'center'//시중판매가
//                  }
// 			     ,{
//                      field : 'pRice', headerText : '<spring:message code="E00128"/>', textAlign : 'center'//판매가
//                  }
// 			     ,{
//                      field : 'originalPrice', headerText : '<spring:message code="E00129"/>', textAlign : 'center'//공급가
//                  }
// 			     ,{
//                      field : 'marGin', headerText : '<spring:message code="E00130"/>', textAlign : 'center'//마진율
//                  }
// 			     ,{
//                      field : 'istaxFree', headerText : '<spring:message code="E00131"/>', textAlign : 'center'//연체여부
//                  }
// 			     ,{
//                      field : 'sTock', headerText : '<spring:message code="E00132"/>', textAlign : 'center'//재고구분
//                  }
// 			     ,{
//                      field : 'sTate', headerText : '<spring:message code="E00133"/>', textAlign : 'center'//상품상태
//                  }
// 			],
// 	        requestGridData : {
// 	            sidx : 'createDate',
// 	            sord : 'desc'
// 	          },
// 	          rowList : [10,25,50,100],
// 	          radio: true,
// 	          tempId : 'ifvGridSimplePageTemplete'
// 	      };

//   prodSpecGridList = $("#prodSpecGrid").ifvsfGrid({ ejGridOption : ejGridOption });
// }

// function prodSpecDetailPopupOpen(prodSpecRid) {

// 	var contentUrl = '<ifvm:url name="prodSpecPop"/>';
// 	var title ='<spring:message code="E00096"/>';

// 	if(prodSpecRid != ''){
// 		contentUrl = '<ifvm:url name="prodSpecPop"/>?prodSpecRid='+prodSpecRid;
// 		title ='<spring:message code="E00097"/>';
// 	}

//     $("#popupContainer").ifvsfPopup({
// 		enableModal : true,
// 		enableResize: false,
// 		contentUrl: contentUrl,
// 		contentType: "ajax",
// 		title: title,
// 		width: '800',
// 		close : 'specPopupClos'
//     });
// }

// function specPopupClose() {
// 	popupContainer._destroy();
// }

// function addProdSpec(){
// 	prodSpecPop('');
// }

// function prodSpecPop(prodSpecRid){

// 	var contentUrl = '<ifvm:url name="prodSpecPop"/>';
// 	var title ='<spring:message code="E00096"/>';

//     //var pwid = options.width ? typeof options.width != "number" ? Number(options.width.replace('px', '')) : options.width : 600;
//     //var posx = Math.ceil((window.innerWidth - pwid)/2);
	
// 	if(prodSpecRid != ''){
// 		contentUrl = '<ifvm:url name="prodSpecPop"/>?prodSpecRid='+prodSpecRid;
// 		title ='<spring:message code="E00097"/>';
// 	}

//     $("#popupContainer").ifvsfPopup({
// 		enableModal : true,
// 		enableResize: false,
// 		contentUrl: contentUrl,
// 		contentType: "ajax",
// 		title: title,
// 		width: '600',
//         position : {X: 650, Y: 300},
// 		close : 'specPopupClose'
//     });
// }

//그룹코드 리스트 그리드 그리는 함수(자사몰 상품)
// function prodSpecInit() {
// 	getProdSpec();
// }

// function delProdSpec(){
// 	if($.fn.ifvmIsNotEmpty(prodSpecGridList)) {
// 		var delList = prodSpecGridList.opt.gridControl.getSelectedRecords();

// 		if($.fn.ifvmIsNotEmpty(delList)) {

// 			var rids = [];
// 			for(var idx = 0; idx < delList.length; idx++) {
// 				rids.push(delList[idx].prodSpecRid);
// 			}

// 			if(!confirm('<spring:message code="C00079" />')) return;

// 			$.ifvSyncPostJSON('<ifvm:action name="deleteProdSpec"/>', {
// 				rids: rids
// 			}, function(result) {
// 				alert('<spring:message code="M01266" />');
// 				prodSpecGridList._doAjax();
// 			});
// 		} else {
// 			alert('<spring:message code="E00099" />')
// 		}
// 	}
// }
function init(){
	rid = null;
	getProdList();
// 	getProdSpec();
// 	getProdPos();
}

// function removeProd(){
// 	if(confirm('삭제 하시겠습니까?')){
// 		$.ifvSyncPostJSON('<ifvm:action name="removeProduct"/>',{rid : rid}, function(result){
// 			alert('삭제 되었습니다.');
// 			rid = null;
// 			prodListGrid._doAjax();
// 		});
// 	}
// }
function setProdExcelExport(){
    $.ifvExcelDn('<ifvm:action name="getProdListExport"/>','prodListGrid');
}

//코드 리스트 그리드를 그리는 함수(POS)
// function getProdPos(rid) {
//   var ejGridOption = {
// 	          serializeGridData : function( data ){
// 	              data.ridProd = rid;
// 	              return data;
// 	          },
//             dataUrl : '<ifvm:action name="getProdPosList"/>',
//             columns:[
//                  {
//                       field : 'msNo', headerText : '<spring:message code="D10173"/>', textAlign : 'center'//매장코드
//                       ,customAttributes : {index : 'msNo' } 
//                  }
//                  ,{
//                       field : 'msNm', headerText : '<spring:message code="L02275"/>', textAlign : 'center'//매장명
//                  }
//                  ,{
//                      field : 'goodsCd', headerText : '<spring:message code="M01968"/>', textAlign : 'center'//상품코드
//                  }
//                  ,{
//                      field : 'goodsPriceFg', headerText : '<spring:message code="E00136"/>', textAlign : 'center'//가격구분
//                  }
//                  ,{
//                      field : 'startDate', headerText : '<spring:message code="E00137"/>', textAlign : 'center'//변경예정시작일
//                  }
//                  ,{
//                      field : 'endDate', headerText : '<spring:message code="E00138"/>', textAlign : 'center'//변경예정종료일
//                  }
//                  ,{
//                      field : 'prePrice', headerText : '<spring:message code="E00139"/>', textAlign : 'center'//변경전 가격
//                  }
//                  ,{
//                      field : 'aftPrice', headerText : '<spring:message code="E00140"/>', textAlign : 'center'//변경후 가격
//                  }
//                  ,{
//                      field : 'goodsControlFg', headerText : '<spring:message code="E00141"/>', textAlign : 'center'//가격통제구분
//                  }
//             ],
//             requestGridData : {
//                 sidx : 'createDate',
//                 sord : 'desc'
//               },
//               rowList : [10,25,50,100],
//               radio: true,
//               tempId : 'ifvGridSimplePageTemplete'
//           };

//   prodPosGridList = $("#prodPosGrid").ifvsfGrid({ ejGridOption : ejGridOption });
// }

$(document).ready(function() {
	init();
    //공통 조회 조건 목록 설정
    prodListSearchInit();
    //조회
    $('#prodListSearchBtn').on('click', function(){
    	prodListSearch();
//     	rid = null;
//     	getProdSpec();
    });

    //초기화
    $("#prodListSearchInitBtn").on('click', function(){
    	prodListSearchInit("prodListGrid");
    });

    //신규 클릭시
//     $('#prodNewBtn').on('click', function(){
//     	rid = null;
//     	prodDtlPop();
//     	getProdSpec();
//     });
    
//     $("#delProdBtn").on('click', function(){
// 		if(!$.fn.ifvmIsNotEmpty(rid)) {
// 			alert('<spring:message code="E00098" />');
// 			return;
// 		}
// 		removeProd();
// 		rid = null;
// 		getProdSpec();
//     });

    //상품 스펙 생성
//     $('#addProdSpec').on('click', function(){

// 		if(!$.fn.ifvmIsNotEmpty(rid)) {
// 			alert('<spring:message code="E00098" />');
// 			return;
// 		}
//     	addProdSpec();
//     });

    //상품 스펙 삭제
//     $("#delProdSpec").on('click', function(){
// 		if(!$.fn.ifvmIsNotEmpty(rid)) {
// 			alert('<spring:message code="E00098" />');
// 			return;
// 		}
// 		delProdSpec();
//     });
    //엑셀다운로드
    $("#prodListExcelExportBtn").on('click', function(){
        setProdExcelExport();
    });    
});

</script>

<div class="page-title">
    <h1>
    <spring:message code="O00181" /> &gt; <spring:message code="M00168" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="prodListSearchBtn" objCode="prodListprodListSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="prodListSearchInitBtn" objCode="prodListSearchInitBtn_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="prodSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
<!--             <button class="btn btn-sm" id="prodNewBtn" objCode="prodListprodNew_OBJ"><i class="fa fa-plus"></i> -->
<%--                 <spring:message code="M00136" /> --%>
<!--             </button> -->
<!--             <button class="btn btn-sm" id='delProdBtn' objCode="prodListDelProdBtn_OBJ"><i class="fa fa-minus"></i> -->
<%-- 				<spring:message code="M00165"/> --%>
<!-- 			</button> -->
			 <!--             엑셀다운로드 -->
            <button class="btn btn-sm" id="prodListExcelExportBtn" objCode="prodListExcelExportBtn_OBJ">
                <spring:message code="M00838" />
            </button>
        </div>
    </div>
    <div id="prodListGrid" class="white_bg grid_bd0"></div>
</div>
<!-- <div> -->
<!-- 	<div class="page_btn_area"> -->
<!-- 		<div class="col-xs-7"> -->
<%-- 			<span><spring:message code="E00134"/></span> --%>
<!-- 		</div> -->
<!-- 		<div class="col-xs-5 searchbtn_r"> -->
<!-- 			<button class="btn btn-sm" id='addProdSpec' objCode="prodListAddProdSpec_OBJ"> -->
<!-- 				<i class="fa fa-plus"></i> -->
<%-- 				<spring:message code="M00163"/> --%>
<!-- 			</button> -->
<!-- 			<button class="btn btn-sm" id='delProdSpec' objCode="prodListDelProdSpec_OBJ"> -->
<!-- 				<i class="fa fa-minus"></i> -->
<%-- 				<spring:message code="M00165"/> --%>
<!-- 			</button> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- 	<div id="prodSpecGrid" class="white_bg grid_bd0"></div> -->
<!-- </div> -->
<!-- <div> -->
<!--     <div class="page_btn_area"> -->
<!--         <div class="col-xs-7"> -->
<%--             <span><spring:message code="E00135"/></span> --%>
<!--         </div> -->
<!--         <div class="col-xs-5 searchbtn_r"> -->
<!--         </div> -->
<!--     </div> -->
<!-- <!--     <div id="prodPosGrid" class="white_bg grid_bd0"></div> -->
<!-- </div> -->
<!-- <div id="prodDialog" class="popup_container"></div> -->
<!-- <div id="popupContainer" class="popup_container"></div>팝업 -->