<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/x-jsrender" id="mbrLinkTemplate">
		<a href="<ifvm:url name="mbrDetailNew"/>?rid={{:ridMbr}}" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>
</script>

<script type="text/javascript">
var cardList;
var rid=null;
var cardCheckObj;
var regNumber = /[^0-9]/g;
function getCardSearch(){
    var ejGridOption = {

        rowSelected : function (args) {
        	rid=args.data.rid;
        	cardCheckObj = data;
        	cardBtnStatus();
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {

                data.item = requestitem;
            }
            return data;
        },
         loadComplete : function(obj){

    		$("#unMaskBtn").attr("disabled",true);
        	 cardCheckObj ={};

        },
        dataUrl : '<ifvm:action name="getCardList"/>',
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
	      			  index : 'lc.cust_nm' }/*회원명 */
	      	  },{
	      		  field : 'mbrNo', headerText : '<spring:message code="M00688"/>', headerTextAlign : 'center',template: "#mbrLinkTemplate",
	      		  customAttributes : {
	      			  index : 'lm.MBR_NO' }/*회원번호 */
	      	  },{
	      		  field : 'ecommMbrNo', headerText : '<spring:message code="L02512"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lm.ECOMM_MBR_NO' }/*회원번호 */
	      	  },{
	      		  field : 'regDt', headerText : '<spring:message code="L00221"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmc.ISSUE_DATE' }/*등록일시 */
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
	        rowList : [10,25,50,100],
	        radio: true
    };
    cardList = $("#cardListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

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
    $.fn.ifvmSetCommonCondList("cardListSearchList","D_CARD_001");
    searchInitialize();
}

//공통 조회 호출
function cardListSearchFn() {
	if(!searchBlankCheck()){
		alert('<spring:message code="L02009" />');
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

function cardBtnStatus(){
	if(cardCheckObj.promoCnt!=null){
		$("#btnPointSearch").attr("disabled",false)
	}else{
		$("#btnPointSearch").attr("disabled",true);
	}

 	if( rid!=null&&(cardCheckObj.cardTypeCd=='20'&& (cardCheckObj.cprtCardCd!='' && cardCheckObj.cprtCardCd!=null)) ){
 		$('#unMaskBtn').attr('disabled',false);
 	}else{
 		$('#unMaskBtn').attr('disabled',true);
 	}
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

    //공통 조회 조건 목록 설정
    cardListSearchInit();
    getCardSearch();
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
        	<ifvm:inputNew type="button"   btnType="search"  text="M00135"  id="cardListSearchBtn" btnFunc="cardListSearchFn" objCode="cardListSearchBtn_OBJ"/>
 			<ifvm:inputNew type="button"   text="M00278"  id="cardListSearchInitBtn" btnFunc="cardListSearchInit" objCode="cardListSearchInitBtn_OBJ"/>
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
        </div>
    </div>
    <div id="cardListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="transactionDetailDialog" class="popup_container"></div>
 <div id="cardDetailPopDiv" class="popup_container content_container"></div>