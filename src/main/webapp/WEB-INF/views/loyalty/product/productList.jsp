<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var productList;
var rid ;

function getProductSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
      var obj = productList.getRowData()[data-1];
      rid = obj.rid;
      pointStandardDtlFn();   // 상세 보기 이벤트
        },
        onSelectRow : function (data) {
        	rid=data.rid;
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
        }

            return data;
        },
        loadComplete : function(obj){
        },
        url : '<ifvm:action name="getProductList"/>',
        colNames:[
                   '<spring:message code="L01261" />',  /*가맹점코드 */
                   '<spring:message code="L01262" />',  /*가맹점명 */
                   '<spring:message code="L01263" />',  /*제품타입(대)*/
                   '<spring:message code="L01264" />',  /*제품타입(소) */
                   '<spring:message code="L01265" />',  /*제품코드 */
                   '<spring:message code="L01266" />',  /*제품명 */
                   '<spring:message code="L01267" />',  /*다수 가맹점사용여부 */
                   '<spring:message code="L01268" />',  /*설명 */
                   '<spring:message code="L01269" />',  /*상태 */
                   '<spring:message code="L01270" />',  /*ENIS정산방법 */
                   '<spring:message code="L01271" />',  /*과세분기 여부 */
                   '<spring:message code="L01272" />',  /*과세발생 금액 */
                   '<spring:message code="L01273" />',  /*과세비율 (소득제) */
                   '<spring:message code="L01274" />',  /*과세제품 코드 */
                   '<spring:message code="L01275" />',  /*과세제품명 */
                   '<spring:message code="L01276" />',  /*비과세제품코드 */
                   '<spring:message code="L01277" />',  /*비과세제품명 */
                   'rid',
                   'ridChnl',
                   'ridTaxtn',
                   'ridTaxfr',
                 ],
        colModel:[
             { name:'chnlNo',   index:'lc.CHNL_NO',  resizable : true, align:'center',     width:'80px' },
             { name:'chnlNm',   index:'lc.CHNL_NM',  resizable : true, align:'center', formatter :goGridRowChannelLink, width:'100px' },
             { name:'prodTypeLv1',   index:'cc1.MARK_NAME',  resizable : true, align:'center',     width:'80px' },
             { name:'prodTypeLv2',   index:'cc2.MARK_NAME',  resizable : true, align:'center',  width:'80px' },
             { name:'prodId',   index:'lp.PROD_ID',  resizable : true, align:'center',    width:'80px' },
             { name:'prodNm',   index:'lp.PROD_NM',  resizable : true, align:'center',    width:'80px' },
             { name:'compnUseYn',   index:'lp.COMPN_USE_YN',  resizable : true, align:'center',     width:'80px' },
             { name:'desc1',   index:'lp.DESC1',  resizable : true, align:'center',    width:'80px' },
             { name:'statusCd',   index:'cc3.MARK_NAME',  resizable : true, align:'center',    width:'80px' },
             { name:'enisSetlMeth',   index:'cc4.MARK_NAME',  resizable : true, align:'center',    width:'80px' },
             { name:'taxtnYn',   index:'lp.TAXTN_YN',  resizable : true, align:'center',   width:'80px' },
             { name:'taxtnOccAmt',   index:'lp.TAXTN_OCC_AMT',  resizable : true, align:'right', formatter :'integer' ,  width:'80px' },
             { name:'taxtnRate',   index:'lp.TAXTN_RATE',  resizable : true, align:'right', formatter :'integer' ,   width:'80px' },
             { name:'taxtnProdCd',   index:'lp.TAXTN_PROD_CD',  resizable : true, align:'center',    width:'80px' },
             { name:'taxtnProdNm',   index:'lp2.PROD_NM',  resizable : true, align:'center',    width:'80px' ,formatter : goGridRowTaxtnLink },
             { name:'taxfrProdCd',   index:'lp.TAXFR_PROD_CD',  resizable : true, align:'center',    width:'80px' },
             { name:'taxftProdNm',   index:'lp3.PROD_NM',  resizable : true, align:'center',    width:'80px'  ,formatter : goGridRowTaxfrLink },
             { name:'rid',    index:'lp.rid',    hidden : true},
             { name:'ridChnl',    index:'lc.rid',    hidden : true},
             { name:'ridTaxtn',    index:'lp.RID_TAXTN',    hidden : true},
             { name:'ridTaxfr',    index:'lp.RID_TAXFR',    hidden : true},
        ],
        sortname: 'lp.PROD_ID',
		autowidth : true , sortorder: "asc",
    };
    productList = $("#productListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function goGridRowChannelLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridChnl;
    if(id!=null){
    	 var url = '<ifvm:url name="channelDetail"/>?rid=' + id;
    	 var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    	 return tag;
    }else{
    	return "";
    }
}

function goGridRowTaxtnLink(cellvalue, options, rowObjec){
	var id = rowObjec.ridTaxtn;
    var url = '<ifvm:url name="productDetail"/>' + '?rid=' + id;
    var tag=null;
    if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
    return tag;
}

function goGridRowTaxfrLink(cellvalue, options, rowObjec){
	var id = rowObjec.ridTaxfr;
    var url = '<ifvm:url name="productDetail"/>' + '?rid=' + id;
    var tag=null;
    if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
    return tag;
}

//공통 조회 조건 목록 설정
function productListSearchInit() {
   $.fn.ifvmSetCommonCondList("productSearchList","PGM_L_101");
}

//공통 조회 호출
function productListSearch() {
    $.fn.ifvmSubmitSearchCondition("productSearchList", getProductSearch);
}

function pointStandardDtlFn(){
 	var url = "<ifvm:url name='productDetail'/>";
 	if(rid !=null){
 		url = url + '?rid=' +  escape(rid);
 	}
 	qtjs.href(url);
}

function pointStandardNewFn(){
	qtjs.href("<ifvm:url name='productDetail'/>");
}
function setAuthBtn(){
	//상담원권한(E10004, E10005)만 가지고 있을 경우 화면의 필드, 버튼 비활성화 (readOnly)
	var authList = $.ifvmGetAuthInfo().authList;
	var isAuth = false;

	for(var i = 0 ; i < authList.length ; i++){
		if(authList[i].authName == 'E10004' || authList[i].authName == 'E10005'){
			isAuth = true;
		}
	}
	if(isAuth){
		$("#newBtn").hide();
	}
}
$(document).ready(function() {
    //공통 조회 조건 목록 설정
    productListSearchInit();

    productListSearch();
    setAuthBtn();
});
</script>

<div class="page-title">
    <h1>
   		<spring:message code="L01282" />
		 &gt;<spring:message code="L00081"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="search"  text="M00135"  id="productListSearchBtn" btnFunc="productListSearch" objCode="productListSearchBtn_OBJ"/>
            <ifvm:inputNew type="button"   text="M00278"  id="productSearchInitBtn" btnFunc="productListSearchInit" objCode="productListSearchInitBtn_OBJ"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="productSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
 			<ifvm:inputNew type="button" btnType="plus"  text="L00078"  id="newBtn" btnFunc="pointStandardNewFn" objCode="pointStandardNewFn_OBJ"/>
 			
        </div>
    </div>
    <div id="productListGrid" class="white_bg grid_bd0"></div>

</div>

<div id="transactionDetailDialog" class="popup_container"></div>
 <div id="pointDetailPopDiv" class="popup_container"></div>