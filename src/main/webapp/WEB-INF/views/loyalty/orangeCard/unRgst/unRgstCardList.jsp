<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var cardList;
var unRgst_rid ;
var cardNum;
var regNumber = /[^0-9]/g;
function getCardSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
	      var obj = cardList.getRowData()[data-1];
	      unRgst_rid = obj.rid
	      cardNum = obj.cardNum;
	      cardDetailDtl();   // 상세 보기 이벤트
        },
        onSelectRow : function (data) {
        	unRgst_rid=data.rid;
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
        	for(var i=0; i < requestitem.length; i++){
        		if( requestitem[i].srcCol=="CARD_NUM" && requestitem[i].whereVal !=""){
        			//requestitem[i].whereVal= requestitem[i].whereVal.replaceAll("-","");
        			requestitem[i].whereVal= requestitem[i].whereVal.replaceAll(regNumber,"");
        		}
        	}
        	data.item = requestitem;
        }
            return data;
        },
        loadComplete : function(obj){
        },
        url : '<ifvm:action name="getUnRgstCardList"/>',
        colNames:[
                   '<spring:message code="L00414" />',  /*카드번호 */
                   '<spring:message code="L00192" />',  /*카드종류 */
                   '<spring:message code="M01139" />',  /*사용여부*/
                   /* '<spring:message code="L01678" />',  /*선지급금여부*/
                   '<spring:message code="L00700" />',  /*선지급금액 */
                   '<spring:message code="L00701" />',  /*선적립금유효기간 */
                   '<spring:message code="L00792" />',  /*제품코드 */
                   '<spring:message code="L00702" />', /*첫카드 사용일시 */
                   '<spring:message code="L00703" />', /*최종카드 사용일시*/
                   'rid'
                 ],
        colModel:[
             { name:'cardNum',   		index:'lcri.CARD_NUM',  			resizable : true, align:'center',   width:'140px' },
             { name:'cardTypeCd',   	index:'lcri.CARD_TYPE_CD',  		resizable : true, align:'center',  	width:'80px' },
             { name:'activeFlag',   	index:'lcri.ACTIVE_FLG',  			resizable : true, align:'center',   width:'70px' },
           /*   { name:'preSaveStatus',	index:'cc1.MARK_NAME',  			resizable : true, align:'center',   width:'70px' }, */
             { name:'preSavePoint', 	index:'lcri.PRE_SAVE_POINT',  		resizable : true, align:'right', 	formatter :'integer',    width:'120px' },
             { name:'preAcuEfctPeriod', index:'lcri.PRE_ACU_EFCT_PERIOD',  	resizable : true, align:'center',   width:'120px',formatter:'date',  formatoptions:{newformat:"Y-m-d"} },
             { name:'prodCd',   		index:'lcri.PROD_CD',  				resizable : true, align:'center',   width:'140px' },
             { name:'firstCardUseDt',   index:'lcri.FIRST_CARD_USE_DT',  	resizable : true, align:'center',  	formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"},    width:'130px' },
             { name:'lastCardUseDt',   	index:'lcri.LAST_CARD_USE_DT',  	resizable : true, align:'center',   width:'130px' , formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} },
             { name:'rid',    			index:'lcri.rid',    hidden : true}
        ],
        sortname: 'lastCardUseDt',
		autowidth : true , sortorder: "desc",

    };
    cardList = $("#cardListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

var jqGridOptionInit = {
		 colNames:[
                   '<spring:message code="L00414" />',  /*카드번호 */
                   '<spring:message code="L00192" />',  /*카드종류 */
                   '<spring:message code="M01139" />',  /*사용여부*/
                   '<spring:message code="L01678" />',  /*선지급금여부*/
                   '<spring:message code="L00700" />',  /*선지급금액 */
                   '<spring:message code="L00701" />',  /*선적립금유효기간 */
                   '<spring:message code="L00792" />',  /*제품코드 */
                   '<spring:message code="L00702" />', /*첫카드 사용일시 */
                   '<spring:message code="L00703" />', /*최종카드 사용일시*/
                   'rid'
                 ],
        colModel:[
             { name:'cardNum',   		index:'lcri.CARD_NUM',  			resizable : true, align:'center',   width:'140px' },
             { name:'cardTypeCd',   	index:'cardTypeCd',  				resizable : true, align:'center',  	width:'80px' },
             { name:'activeFlag',   	index:'lcri.ACTIVE_FLG',  			resizable : true, align:'center',   width:'70px' },
             { name:'preSaveStatus',   	index:'preSaveStatus',  			resizable : true, align:'center',   width:'70px' },
             { name:'preSavePoint',   	index:'lcri.PRE_SAVE_POINT',  		resizable : true, align:'right', 	width:'120px', formatter :'integer'   },
             { name:'preAcuEfctPeriod', index:'lcri.PRE_ACU_EFCT_PERIOD',  	resizable : true, align:'center',   width:'120px', formatter:'date',  formatoptions:{newformat:"Y-m-d"} },
             { name:'prodCd',   		index:'lcri.PROD_CD',  				resizable : true, align:'center',   width:'140px' },
             { name:'firstCardUseDt',   index:'lcri.FIRST_CARD_USE_DT',  	resizable : true, align:'center',  	width:'130px', formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"},     },
             { name:'lastCardUseDt',   	index:'lcri.LAST_CARD_USE_DT',  	resizable : true, align:'center',   width:'130px', formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} },
             { name:'rid',    			index:'lcri.rid',    hidden : true}
        ],
      dataType:"clientSide",
      data : {}
	}
/*
function oxFormatt(cellvalue, options, rowObjec){
	  var value = rowObjec.activeFlag;

	  if(value==1){
		value="Y" ;
	  }else{
		value="N";
	  }
	  return value;
} */

//공통 조회 조건 목록 설정
function cardListSearchInit() {
    $.fn.ifvmSetCommonCondList("cardListSearchList","PGM_L_072");
    searchInitialize();
}

function searchInitialize(){
	$(".SearchCondition .searchCondition option[value='LIKE']").remove();
	$(".SearchCondition .searchCondition option[value='NOT']").remove();
	$(".datepicker").val("");
}

//공통 조회 호출
function unRgstCardListSearch() {
	if(!searchBlankCheck()){
		alert('<spring:message code="L02009" />');
	    $("#cardListGrid").ifvGrid({ jqGridOption : jqGridOptionInit });
	}else{
	    $.fn.ifvmSubmitSearchCondition("cardListSearchList", getCardSearch);
	}
}

function searchBlankCheck(){
	var blankCheck=false;
	var searchCondSize= $('.changeTypeAreaCode').size();
	var displayRowNum=[];
	$($('.row.qt_border.SearchCondition')).each(function(index,item){
		if($("#rows"+index).css("display") !="none"){
			if($("#rows"+index).children(".changeTypeAreaCode").find('.smart-form').size()!=0){ //date
				if($("#rows"+index).children(".changeTypeAreaCode").children(".col-xs-2.cal_frt.start_date").children(".smart-form").children(".input").children("input").val() !=""
					&& $("#rows"+index).children(".changeTypeAreaCode").children(".col-xs-2.cal_scd.end_date").children(".smart-form").children(".input").children("input").val() !="" ){
					blankCheck=true;
				}
			}else if($("#rows"+index).children('.changeTypeAreaCode').find("select").size()!=0){  //select
				if($("#rows"+index).children(".changeTypeAreaCode").children(".col-xs-2").children("select").val()!=""       ){
					blankCheck=true;
				}
			}else if($("#rows"+index).children('.changeTypeAreaCode').find("input").size()!=0){  //input
				if($("#rows"+index).children(".changeTypeAreaCode").children(".col-xs-2").children("input").val()!=""){
					blankCheck=true
				}
			}
		}
	})
	return blankCheck;
}
function cardDetailDtl(){
	 cardDetailPop ={
		        id : "cardDetailPopDiv"
		    };
	 cardDetailPop.popup = function (){
		 cardDetailPop.pop = $('#'+cardDetailPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="cardDetailPop"/>'+"?cardNum="+cardNum,
		            contentType: "ajax",
		            title: '<spring:message code="L00991" />',
		            width : "1000px"
		        });
		};
		cardDetailPop.beforeClose = function (obj) {
		};
		cardDetailPop.close = function (obj) {
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		 };
		 cardDetailPop.popup();
}
function commSearchEventFn(){
     $('.itemPlusBtn').live('click', function(){
    	 searchInitialize();
     })
     $('.itemMinusBtn').live('click', function(){
    	 searchInitialize();
     })
     $('.searchTextVal').live('change', function(){
    	 searchInitialize();
     });
}

$(document).ready(function() {
    //공통 조회 조건 목록 설정
    cardListSearchInit();
    $("#cardListGrid").ifvGrid({ jqGridOption : jqGridOptionInit });
   // getCardSearch();
    commSearchEventFn();

});
</script>

<div class="page-title">
    <h1>
       	<spring:message code="L00704" />
        &gt;<spring:message code="L00081"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <ifvm:inputNew type="button" id="unRgstCardListSearchBtn"	btnFunc="unRgstCardListSearch" btnType="search" text="L00081" objCode="unRgstCardListSearchBtn_OBJ"/>
            <ifvm:inputNew type="button" id="unRgstCardListSearchInitBtn" btnFunc="cardListSearchInit" 	text="L00082" objCode="unRgstCardListSearchInitBtn_OBJ"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="cardListSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="L00033" /><spring:message code="L01258" /></span>
        </div>
    </div>
    <div id="cardListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="transactionDetailDialog" class="popup_container"></div>
<div id="cardDetailPopDiv" class="popup_container"></div>
