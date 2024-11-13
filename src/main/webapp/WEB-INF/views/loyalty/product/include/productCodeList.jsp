<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var productCodeList;
var baseRid=null;

function getProductCodeList(){
    var jqGridOption = {
	   ondblClickRow : function(data){
	        var obj = productCodeList.getRowData()[data-1];
	        rid = obj.rid;
	          if(obj.startDd >$.ifvGetTodayDate() && obj.endDd> $.ifvGetTodayDate()){
	        	productCodeDtl();    // 상세 보기 이벤트
	         }else{
	            alert('<spring:message code="L01591" />')
	         }
        },
       onSelectRow : function (data) {
        	baseRid=data.rid;
        },

       serializeGridData : function( data ){
    	   data.rid=testViewList_rid;
    	   data.listType="USE";
    	   return data;
        },
        loadComplete : function(obj){
        },
        url : '<ifvm:action name="getProductCodeList"/>',
        colNames:[
                   '<spring:message code="L01096" />',  /*시작일자 */
                   '<spring:message code="L01097" />',  /*종료일자 */
                   '<spring:message code="L01179" />',  /*제품명 */
                   '<spring:message code="L01003" />',  /*가맹점코드 */
                   '<spring:message code="L01004" />',  /*가맹점명 */
                   '<spring:message code="L00885" />',  /*비고 */

                   'rid',  /*rid */
                   'ridChnl',  /*rid */
                   'ridProd',  /*rid */
                 ],
        colModel:[
             { name:'startDd',  index:'lpch.START_DD',  resizable : true, align:'center',    width:'120px', formatter:'date',  formatoptions:{newformat:"Y-m-d"}  },
             { name:'endDd',    index:'lpch.END_DD', resizable : true, align:'center',    width:'120px', formatter:'date',  formatoptions:{newformat:"Y-m-d"}  },
             { name:'prodNm',   index:'lpch.PROD_NM',resizable : true, align:'center',    width:'100'},
             { name:'chnlNo',   index:'lc.CHNL_NO',  resizable : true, align:'center',    width:'100px' },
             { name:'chnlNm',   index:'lc.CHNL_NM',  resizable : true, align:'center',    width:'100px' },
             { name:'desc1',   	index:'lpch.DESC1',  resizable : true, align:'left',    width:'130px' },

             { name:'rid',   index:'lpch.rid',  	 hidden:true },
             { name:'ridChnl',   index:'lpch.RID_CHNL',  hidden:true },
             { name:'ridProd',   index:'lpch.RID_PROD',  hidden:true }
        ],
        sortname: 'rid',
        autowidth : true , sortorder: "desc",
        radio: true
    };
    productCodeList = $("#productCodeListGrid").ifvGrid({ jqGridOption : jqGridOption });
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

function newProductCodeFn(){
	if(testViewList_rid=="null"){
		alert('<spring:message code="L01433" />');
	}else{
		if($("#statusCd").val()=="00"){
			alert('<spring:message code="L01589"/>');
			return;
		}
		productCodeInfoPop ={
			        id : "productCodeInfoPopDiv"
			    };
		productCodeInfoPop.popup = function (){
			productCodeInfoPop.pop = $('#'+productCodeInfoPop.id).ifvsfPopup({
			            enableModal: true,
			            enableResize: false,
			            contentUrl: '<ifvm:url name="productCodeInfoPop"/>',
			            contentType: "ajax",
			            title:'<spring:message code="L01374" />',
			            width: '800px'
			        });
			};
			productCodeInfoPop.beforeClose = function (obj) {
			};
			productCodeInfoPop.close = function (obj) {
			        this.beforeClose(obj);
			        this.pop.data('ejDialog')._destroy();
			};
			productCodeInfoPop.popup();
	}
}

function delProductCodeFn(){
	if(baseRid==null){
		alert('<spring:message code="L00914"/>');
		return;
	}else{
		$.ifvSyncPostJSON('<ifvm:action name="deleteProductCode"/>',{
			rid:baseRid
			},function(result) {
				alert('<spring:message code="L00034"/>');
				productCodeList.requestData();
			},function(result){
				alert(result.message);
			});
	}
}

function productCodeDtl(){
	productCodeInfoPop ={
	        id : "productCodeInfoPopDiv"
	    };
productCodeInfoPop.popup = function (){
	productCodeInfoPop.pop = $('#'+productCodeInfoPop.id).ifvsfPopup({
	            enableModal: true,
	            enableResize: false,
	            contentUrl: '<ifvm:url name="productCodeInfoPop"/>'+"?codeRid="+baseRid,
	            contentType: "ajax",
	            title:'<spring:message code="L01374" />',
	            width: "800px"
	        });
	};
	productCodeInfoPop.beforeClose = function (obj) {
	};
	productCodeInfoPop.close = function (obj) {
	        this.beforeClose(obj);
	        this.pop.data('ejDialog')._destroy();
	 };
	 productCodeInfoPop.popup();
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
		$("#productCodeWrap button").hide();
	}
}
$(document).ready(function() {
	getProductCodeList();
	setAuthBtn();
});

</script>

<div id="productCodeWrap">
    <div class="page_btn_area" id=''>
       <div class="col-xs-7">
   <%--         <span> <spring:message code="L01374"/></span> --%>
       </div>
        <div class="col-xs-5 searchbtn_r">
 			<ifvm:inputNew type="button" btnType="plus"  text="L00078"  id="newUsePointBtn" btnFunc="newProductCodeFn"/>
 			<ifvm:inputNew type="button" btnType="minus"  text="L00029"  id="delUsePointBtn" btnFunc="delProductCodeFn"/>
        </div>
    </div>
    <div id="productCodeListGrid" class="white_bg grid_bd0"></div>
</div>
 <div id="productCodeInfoPopDiv" class="popup_container content_container"></div>
