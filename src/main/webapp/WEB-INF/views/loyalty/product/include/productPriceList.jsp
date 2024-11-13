<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var productPriceList;
var priceObj=null;

function getProductPriceList(){
    var jqGridOption = {
       ondblClickRow : function(data){
            var obj = productPriceList.getRowData()[data-1];
            rid = obj.rid;
            if(obj.aplyStartDd >$.ifvGetTodayDate() && obj.aplyEndDd> $.ifvGetTodayDate()){
                productPriceDtl();   // 상세 보기 이벤트
            }else{
            	alert('<spring:message code="L01591" />')
            }


        },
        onSelectRow : function (data) {
        	priceObj=data;
        },
       serializeGridData : function( data ){
    	   data.rid=testViewList_rid;
    	   return data;
        },
        loadComplete : function(obj){
        },
        url : '<ifvm:action name="getProductPriceList"/>',
        colNames:[
                   '<spring:message code="L01382" />',  /*포인트 적용가 */
                   '<spring:message code="L01383" />',  /*가맹점 공급가 */
                   '<spring:message code="L01384" />',  /*적용시작일자 */
                   '<spring:message code="L01385" />',  /*적용종료일자 */

                   'rid',  /*rid */
                   'ridProd'  /*ridProd */
                 ],
        colModel:[
             { name:'pointApplyPrice',   index:'lpp.POINT_APPLY_PRICE',  resizable : true, align:'right',    width:'80px' ,formatter : 'integer' },
             { name:'mbrbsSplPrice',   index:'lpp.MBRBS_SPL_PRICE',  resizable : true, align:'right',    width:'80px' ,formatter : 'integer'},
             { name:'aplyStartDd',   index:'lpp.APLY_START_DD',  resizable : true, align:'center',    width:'100px' ,formatter:'date',  formatoptions:{newformat:"Y-m-d"}},
             { name:'aplyEndDd',   index:'lpp.APLY_END_DD',  resizable : true, align:'center',    width:'100px',formatter:'date',  formatoptions:{newformat:"Y-m-d"} },

             { name:'rid',   index:'lpp.rid',  hidden:true },
             { name:'ridProd',   index:'lpp.RID_PROD',  hidden:true },
        ],
        sortname: 'lpp.APLY_START_DD',
        autowidth : true , sortorder: "desc",
        radio: true
    };
    productPriceList = $("#productPriceListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';

    return tag;
}
function goGridRowChnlLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridChnl;
    var url = '<ifvm:url name="chnlDetail"/>?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';

    return tag;
}
function goGridRowPgmLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridPgm;
    var url = '<ifvm:url name="pgmDetail"/>?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';

    return tag;
}

function newProductPriceFn(){
	if(testViewList_rid=="null"){
		alert('<spring:message code="L01433" />');
	}else{
		if($("#statusCd").val()=="00"){
			alert('<spring:message code="L01589"/>');
			return;
		}
		 productPriceInfoPop ={
			        id : "productPricePopDiv"
			    };
		 productPriceInfoPop.popup = function (){
			 productPriceInfoPop.pop = $('#'+productPriceInfoPop.id).ifvsfPopup({
			            enableModal: true,
			            enableResize: false,
			            contentUrl: '<ifvm:url name="productPriceInfoPop"/>',
			            contentType: "ajax",
			            title: '<spring:message code="L01373" />',
			            width: "1000px"
			        });
			};
			productPriceInfoPop.beforeClose = function (obj) {
			};
			productPriceInfoPop.close = function (obj) {
			        this.beforeClose(obj);
			        this.pop.data('ejDialog')._destroy();
			 };
			 productPriceInfoPop.popup();
	}
}

function delProductPriceListFn(){
	var curDate = new Date();
	var curTime = curDate.getFullYear()+""+(curDate.getMonth() + 1)+""+ curDate.getDate()
	 if(priceObj==null){
		alert('<spring:message code="L00914"/>');
		return;
	}else{
		$.ifvSyncPostJSON('<ifvm:action name="deleteProductPrice"/>',{
			rid:priceObj.rid
			},function(result) {
				alert('<spring:message code="L00034"/>');
				productPriceList.requestData();
			},function(result){
				alert(result.message);
			});
	}
}

function productPriceDtl(){
	productPriceInfoPop ={
	        id : "productPricePopDiv"
	    };
 productPriceInfoPop.popup = function (){
	 productPriceInfoPop.pop = $('#'+productPriceInfoPop.id).ifvsfPopup({
	            enableModal: true,
	            enableResize: false,
	            contentUrl: '<ifvm:url name="productPriceInfoPop"/>'+"?priceRid="+rid,
	            contentType: "ajax",
	            title: '<spring:message code="L01373" />',
	            width: "1000px"
	        });
	};
	productPriceInfoPop.beforeClose = function (obj) {
	};
	productPriceInfoPop.close = function (obj) {
	        this.beforeClose(obj);
	        this.pop.data('ejDialog')._destroy();
	 };
	 productPriceInfoPop.popup();
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
		$("#productPriceWrap button").hide();
	}
}
$(document).ready(function() {
	getProductPriceList();
	setAuthBtn();
});

</script>

<div id="productPriceWrap">
    <div class="page_btn_area" id=''>
       <div class="col-xs-7">
<%--            <span> <spring:message code="L01373"/></span> --%>
       </div>
        <div class="col-xs-5 searchbtn_r">
 			<ifvm:inputNew type="button" btnType="plus"  text="L00078"  id="newTabBtn" btnFunc="newProductPriceFn"/>
 			<ifvm:inputNew type="button" btnType="minus"  text="L00029"  id="delProductPriceListBtn" btnFunc="delProductPriceListFn"/>
        </div>
    </div>
    <div id="productPriceListGrid" class="white_bg grid_bd0"></div>
</div>
 <div id="productPricePopDiv" class="popup_container content_container"></div>
