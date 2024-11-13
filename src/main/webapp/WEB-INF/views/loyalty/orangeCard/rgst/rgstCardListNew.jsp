<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var cardList;
var rid=null;
var cardCheckObj;
var regNumber = /[^0-9]/g;
function getCardSearch(){
    var ejGridOption = {
    	recordDoubleClick : function(args){
      		var obj = args.data ;
      		rid = obj.rid;
        },
        rowSelected : function (args) {
        	rid=args.data.rid;
        	cardCheckObj = data;
        	rgstCardBtnStatus();
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
        	for(var i=0; i < requestitem.length; i++){
        		if(requestitem[i].srcCol=="CARD_NO"  && requestitem[i].whereVal !=""){
        			//requestitem[i].whereVal= requestitem[i].whereVal.replaceAll("-","");
        			requestitem[i].whereVal= requestitem[i].whereVal.replaceAll(regNumber,"");
        		      $.ifvSyncPostJSON('<ifvm:action name="getRgstEncryptCardNo"/>',{cardNo : requestitem[i].whereVal},
        		        function(result) {
        		        	requestitem[i].whereVal = result.cardNo
        		        })
        		}
        	}
                data.item = requestitem;
            }
            return data;
        },
        loadComplete : function(obj){
    		$("#btnPointSearch").attr("disabled",true);
    		$("#unMaskBtn").attr("disabled",true);
        	console.log(obj);
        	cardCheckObj ={};
        	//rgstCardBtnStatus();
        },
        dataUrl : '<ifvm:action name="getRgstCardList"/>',
        columns:[
        	{
	      		  field : 'cardNo', headerText : '<spring:message code="L00414"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'CARD_NO' }/*카드번호 */
	      	  },{
	      		  field : 'cardKindNo', headerText : '<spring:message code="L00192"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'cardKindNo' }/*카드종류 */
	      	  },{
	      		  field : 'custNm', headerText : '<spring:message code="L00435"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lm.MBR_HID_NM' }/*회원명 */
	      	  },{
	      		  field : 'memDiv', headerText : '<spring:message code="L00530"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lm.MEM_DIV' }/*회원구분 */
	      	  },{
	      		  field : 'mbrNo', headerText : '<spring:message code="M00688"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lm.MBR_NO' }/*회원번호 */
	      	  },{
	      		  field : 'cprtCardCd', headerText : '<spring:message code="L00919"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'cprtCardCd' }/*제휴사 */
	      	  },{
	      		  field : 'cprtCardItemCd', headerText : '<spring:message code="L00710"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'cprtCardItemCd' }/*제휴카드명 */
	      	  },{
	      		  field : 'stat', headerText : '<spring:message code="L00711"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'stat' }/*카드상태 */
	      	  },{
	      		  field : 'regDt', headerText : '<spring:message code="L00221"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmc.REG_DT' }/*등록일시 */
	      	  },{
	      		  field : 'apvSrvrTrmStatusCd', headerText : '<spring:message code="L00712"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'apvSrvrTrmStatusCd' }/*결과 */
	      	  },{
	      		  field : 'loseDt', headerText : '<spring:message code="L00713"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmc.LOSE_DT' }/*분실일시 */
	      	  },{
	      		  field : 'cardLeavDate', headerText : '<spring:message code="L00714"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmc.CARD_LEAV_DATE' }/*해제일시 */
	      	  },{
	      		  field : 'ridCardKind', headerText : 'ridCardKind', visible : false,
	      		  customAttributes : {
	      			  index : 'lmc.RID_CARD_KIND' }/* */
	      	  },{
	      		  field : 'ridMbr', headerText : 'ridMbr', visible : false,
	      		  customAttributes : {
	      			  index : 'lmc.RID_MBR' }/* */
	      	  },{
	      		  field : 'ridCust', headerText : 'ridCust', visible : false,
	      		  customAttributes : {
	      			  index : 'lm.RID_CUST' }/* */
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false,
	      		  customAttributes : {
	      			  index : 'lmc.rid' }/* */
	      	  },{
	      		  field : 'cardTypeCd', headerText : 'cardTypeCd', visible : false, 
	      		  customAttributes : {
	      			  index : 'cardTypeCd' }/* */
	      	  },{
	      		  field : 'cprtCardCdCode', headerText : 'cprtCardCdCode', visible : false,
	      		  customAttributes : {
	      			  index : 'lmcCPRT_CARD_CD' }/* */
	      	  },{
	      		  field : 'promoCnt', headerText : 'promoCnt', visible : false,
	      		  customAttributes : {
	      			  index : 'promoCnt' }/* */
	      	  }
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'regDt',
	      	  sord : 'desc',
	      	  _search : false
	        },
	        gridDataInit: false,
	        rowList : [10,25,50,100],
	        radio: true
    };
    cardList = $("#cardListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

// var jqGridOptionInit = {
// 		colNames:[
//                   '<spring:message code="L00414" />',  /*카드번호 */
//                   '<spring:message code="L00192" />',  /*카드종류 */
//                   '<spring:message code="L00435" />',  /*회원명*/
//                   '<spring:message code="L00530" />',  /*회원구분
//                   */
//                   '<spring:message code="M00688" />',  /*회원번호 */
//                   '<spring:message code="L00919" />',  /*제휴사 */
//                   '<spring:message code="L00710" />',  /*제휴카드명 */
//                   '<spring:message code="L00711" />', /*카드상태 */
//                   '<spring:message code="L00221" />', /*등록일시*/
//                   '<spring:message code="L00712" />', /*IF결과*/
//                   '<spring:message code="L00713" />', /*분실일시*/
//                   '<spring:message code="L00714" />', /*해제일시*/

//                   'ridCardKind',
//                   'ridMbr',
//                   'ridCust',
//                   'rid',
//                   'cardTypeCd',
//                   'cprtCardCdCode',
//                   'promoCnt'

//                 ],
//        colModel:[
//                  { name:'cardNo',   			index:'CARD_NO',  			resizable : true, align:'center',   width:'130px' },
//                  { name:'cardKindNo',   		index:'cardKindNo',  	resizable : true, align:'center',  	width:'100px' },
//                  { name:'custNm',   			index:'lm.MBR_HID_NM',  		resizable : true, align:'center',   width:'100px' },
//                  { name:'memDiv',   			index:'lm.MEM_DIV',  		resizable : true, align:'center',   width:'120px' },
//                  { name:'mbrNo',   				index:'lm.MBR_NO',  		resizable : true, align:'center',   width:'120px', formatter: goGridRowMbrLink },
//                  { name:'cprtCardCd',   		index:'cprtCardCd',  	resizable : true, align:'center',   width:'80px' },
//                  { name:'cprtCardItemCd',   	index:'cc6.MARK_NAME',  	resizable : true, align:'center',   width:'80px' },
//                  { name:'stat',   				index:'cc3.MARK_NAME',  	resizable : true, align:'center',   width:'80px' },
//                  { name:'regDt',   				index:'lmc.REG_DT',  		resizable : true, align:'center',   width:'150px', 	formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"}},
//                  { name:'apvSrvrTrmStatusCd',   index:'cc5.MARK_NAME',  	resizable : true, align:'center',   width:'80px' },
//                  { name:'loseDt',   			index:'lmc.LOSE_DT',  		resizable : true, align:'center', 	width:'150px', 	formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"}},
//                  { name:'cardLeavDate',   		index:'lmc.CARD_LEAV_DATE', resizable : true, align:'center', 	width:'150px', 	formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"}},

//                  { name:'ridCardKind',  	index:'lmc.RID_CARD_KIND',  hidden : true},
//                  { name:'ridMbr',    		index:'lmc.RID_MBR',    	hidden : true},
//                  { name:'ridCust',    		index:'lm.RID_CUST',    	hidden : true},
//                  { name:'rid',    			index:'lmc.rid ',    		hidden : true},
//                  { name:'cardTypeCd',   	index:'cardTypeCd ',    	hidden : true},
//                  { name:'cprtCardCdCode',   index:'lmc.CPRT_CARD_CD ',  hidden : true},
//                  { name:'promoCnt',    		index:'promoCnt ',    		hidden : true}
//             ],
//         dataType:"clientSide",
//         data : {}
// 	}

//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink(cellvalue, options, rowObjec){
	var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag=null;

    if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
    return tag;
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


function searchInitialize(){
	$(".SearchCondition .searchCondition option[value='LIKE']").remove();
	$(".SearchCondition .searchCondition option[value='NOT']").remove();
	$(".datepicker").val("");
}

//공통 조회 조건 목록 설정
function cardListSearchInit() {
    $.fn.ifvmSetCommonCondList("cardListSearchList","PGM_L_076");
    searchInitialize();
}

//공통 조회 호출
function cardListSearchFn() {
	if(!searchBlankCheck()){
		alert('<spring:message code="L02009" />');
		 $("#cardListGrid").ifvGrid({ jqGridOption : jqGridOptionInit });
		 return;
	}
    $.fn.ifvmSubmitSearchCondition("cardListSearchList", getCardSearch);
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

function fnPointSearch(){
 	if(rid==null) {
 		alert("<spring:message code='L01820'/>");
 		return;
 	}
	 cardDetailPop ={
		        id : "cardDetailPopDiv"
		    };
	 cardDetailPop.popup = function (){
		 cardDetailPop.pop = $('#'+cardDetailPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="rgstCardDetailPop"/>',
		            contentType: "ajax",
		            title: "<spring:message code='L00715'/>",
		            width: "1000px"
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

/* function buttonValid(){
	btnPointSearch
} */

function rgstCardBtnStatus(){
	if(cardCheckObj.promoCnt!=null){
		$("#btnPointSearch").attr("disabled",false)
	}else{
		$("#btnPointSearch").attr("disabled",true);
	}


/* 	rid!=null&&(cardCheckObj.cardTypeCd=='20'&& (cardCheckObj.cprtCardCd=='' || cardCheckObj.cprtCardCd==null) )
	? $('#unMaskBtn').attr('disabled',false) : $('#unMaskBtn').attr('disabled',true);
 */
 	if( rid!=null&&(cardCheckObj.cardTypeCd=='20'&& (cardCheckObj.cprtCardCd!='' && cardCheckObj.cprtCardCd!=null)) ){
 		$('#unMaskBtn').attr('disabled',false);
 	}else{
 		$('#unMaskBtn').attr('disabled',true);
 	}
/* 	rid!=null&&(cardCheckObj.cardTypeCd=='20'&& (cardCheckObj.cprtCardCd=='' || cardCheckObj.cprtCardCd==null))
	? $('#unMaskBtn').attr('disabled',false) : $('#unMaskBtn').attr('disabled',true);
 */


/*
	if(rid!=null&&(cardCheckObj.cardTypeCd=='20'&& (cardCheckObj.cprtCardCd=='' || cardCheckObj.cprtCardCd==null) ) ){
		$('#unMaskBtn').attr('disabled',false)
	}else{
		$('#unMaskBtn').attr('disabled',true);
	} */
}

function unMaskFn(){
	if ($.fn.ifvmIsNotEmpty(rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
            rid: rid ,
            type: 'card' ,
            field: 'cardNo'
        },
        function(result) {
        	var rowid = cardList.getRadioSelectedRowId();
        	if(result.message!=null){
        		cardList.opt.grid.setCell( rowid, 'cardNo' , result.message );
        	}
        });
	}
}
function checkButtnAuth(){
	var isAuth = false;
	var authArr = $.ifvmGetAuthInfo().authList;
	for(var i = 0 ; i < authArr.length ; i++){
		var authObj = authArr[i];
		var authName = authObj.authName;
		if(authName == 'E10010') isAuth = true;
	}
	if(!isAuth){
		$("#unMaskBtn").remove();
	}

}
$(document).ready(function() {
	//마스킹해제 권한 체크
	//checkButtnAuth();
    //공통 조회 조건 목록 설정
    cardListSearchInit();
    getCardSearch();
//     $("#cardListGrid").ifvGrid({ jqGridOption : jqGridOptionInit });
 	//공통 조회조건 추가 제어 기능
    commSearchEventFn();

});
</script>

<div class="page-title">
    <h1>
    	<spring:message code="L00709" />
        &gt;<spring:message code="L00081"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button"   btnType="search"  text="M00135"  id="cardListSearchBtn" btnFunc="cardListSearchFn"/>
 			<ifvm:inputNew type="button"   text="M00278"  id="cardListSearchInitBtn" btnFunc="cardListSearchInit"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="cardListSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
         <div class="col-xs-5 searchbtn_r">
            <ifvm:inputNew type="button"   text="L00326"  id="unMaskBtn" btnFunc="unMaskFn" disabled="true" objCode="LOY_MAS_009"/>
      		<ifvm:inputNew type="button"  btnType="search" text="L00715"  id="btnPointSearch" btnFunc="fnPointSearch"  disabled="true"/>
        </div>
    </div>
    <div id="cardListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="transactionDetailDialog" class="popup_container"></div>
 <div id="cardDetailPopDiv" class="popup_container content_container"></div>