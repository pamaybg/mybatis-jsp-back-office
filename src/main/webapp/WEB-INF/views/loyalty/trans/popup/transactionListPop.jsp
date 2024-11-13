<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>

<script type="text/javascript">
var transactionList;
var gridTransactionList;
var rid=null ;
var cardCheckObj={};
var defaultMbrRid  = '<%= cleanXss(request.getParameter("defaultMbrRid")) %>' ;
var defaultChnlRid = '<%= cleanXss(request.getParameter("defaultChnlRid")) %>';
var defaultArchive =  '<%= cleanXss(request.getParameter("defaultArchive")) %>';

console.log(defaultChnlRid);


function geTtransactionSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
	      var obj = transactionList.getRowData()[data-1];
	      rid = obj.rid;
	      transactionDetailDtl();   // 상세 보기 이벤트
        },

        onSelectRow : function (data) {
        	rid=data.rid;
        	cardCheckObj=data;
        	buttonStatus();
        },
        onSelectRow : function (data) {
        	rid=data.rid;
        	cardCheckObj=data;
        	buttonStatus();
        },
       serializeGridData : function( data ){

        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
                for(var i=0; i<requestitem.length; i++){
                	if(requestitem[i].baseTable=="loy_mbr"){
                		if(requestitem[i].whereVal!=""){
                    		data.isMbrYn="Y";
                		}
                	}
                	if(requestitem[i].baseTable=="loy_channel"){
                		if(requestitem[i].whereVal!=""){
                    		data.isChnlYn="Y";
                		}
                	}
                	if(requestitem[i].baseTable=="loy_prod"){
                		if(requestitem[i].whereVal!=""){
                    		data.isProdYn="Y";
                		}
                	}
                }
            }
        if(typeof defaultMbrRid != "undefined" && defaultMbrRid != "null" ){
        	data.defaultMbrRid = defaultMbrRid;
    	}
        if(typeof defaultChnlRid != "undefined" && defaultChnlRid != "null" ){
    		data.defaultChnlRid = defaultChnlRid;
    	}
        if(typeof defaultArchive != "undefined" && defaultArchive != "null" ){
        	data.defaultArchive = defaultArchive;
    	}


            return data;
        },
        loadComplete : function(obj){
        	cardCheckObj={};
        	buttonStatus();

        },
        url : '<ifvm:action name="getTransactionList"/>',
        colNames:[
                   '<spring:message code="L00554" />',  /*거래번호 */
	               '<spring:message code="L00604" />',  /*거래일시 */
	               '<spring:message code="L00555" />',  /*승인일시 */
	               //REQ_M103
	               '<spring:message code="L01405" />',  /*회원번호*/
                   '<spring:message code="L01406" />',  /*회원명*/
	               '<spring:message code="L00556" />',  /*거래 상세유형*/

	               '<spring:message code="L00414" />', /*카드번호 */
	               '<spring:message code="L00919" />', /*제휴사 */
	               '<spring:message code="L00582" />', /*발생포인트*/
	               '<spring:message code="L00583" />', /*사용포인트 */
	               '<spring:message code="L00584" />', /*선물포인트 */
	               '<spring:message code="L00971" />', /*프로모션 포인트 */
	               '<spring:message code="L00596" />', /*거래후가용포인트 */
	               '<spring:message code="L00567" />', /*제품명 */
	               '<spring:message code="L00355" />', /*거래금액 */
	               '<spring:message code="L00565" />', /*가맹점명 */
	               '<spring:message code="L00564" />', /*가맹점코드 */
	               '<spring:message code="L00918" />', /*카드종류 */
                   'rid',
                   'ridMbr',
                   'ridMbrCard',
                   'cprtCardCd',
                   'cardTypeCdCode'
                 ],
        colModel:[
            { name:'txnUniqNo',   	index:'lpt.TXN_NUM',  	resizable : true, 	align:'center',    	width:'180px',	sortable:false,		formatter:goGridRowTrDetail },
			{ name:'txnDt',   		index:'lpt.TXN_DT',  	resizable : true, 	align:'center',  	width:'135px',	sortable:false, 	formatter:'date',  	formatoptions:{newformat:"Y-m-d H:i:s"}  },
			{ name:'apprDate',   	index:'lpt.APPR_DATE',  resizable : true, 	align:'center',  	width:'135px',	sortable:false,		formatter:'date',  	formatoptions:{newformat:"Y-m-d H:i:s"}  },
			//REQ_M103
			{ name:'mbrNo',   		index:'c.mbr_no',  		resizable : true, 	align:'center',    	width:'100px',	sortable:false, 	formatter: goGridRowMbrLink },
            { name:'custNm',   		index:'d.cust_nm',  	resizable : true, 	align:'center',    	width:'100px',	sortable:false },
			{ name:'pntTxnType2Cd', index:'lpt.PNT_TXN_TYPE_2_CD',  resizable : true, align:'center',     width:'100px' ,sortable:false },

			{ name:'cardNoDecoding',index:'lpt.CARD_NUM',  	resizable : true, 	align:'center',    	width:'150px',	sortable:false },
			{ name:'cprtCard',   	index:'d.mark_name',  	resizable : true, 	align:'center',    	width:'100px',	sortable:false },
			{ name:'pntAmt',   		index:'lpt.PNT_AMT',  	resizable : true, 	align:'right',    	width:'80px',	sortable:false,		formatter:'integer'},
			{ name:'usePnt',   		index:'lpt.USE_PNT',  	resizable : true, 	align:'right',    	width:'80px',	sortable:false,		formatter:'integer'},
			{ name:'giftPnt',   	index:'lpt.GIFT_PNT',  	resizable : true,	align:'right',    	width:'80px',	sortable:false,		formatter:'integer'},
			{ name:'promoCnt',   	index:'promoCnt',  		resizable : true, 	align:'right',    	width:'120px',	sortable:false,		formatter: 'integer'},
			{ name:'totalPntAvl',   index:'totalPntAvl',  	resizable : true, 	align:'right',    	width:'120px',	sortable:false,		formatter: 'integer'},
			{ name:'prodNm',   		index:'lp.PROD_NM',  	resizable : true, 	align:'center',    	width:'100px',	sortable:false },
			{ name:'txnAmt',   		index:'lpt.TXN_AMT',  	resizable : true, 	align:'right',    	width:'80px',	sortable:false, 	formatter:'integer'},
			{ name:'chnlNm',   		index:'lc.CHNL_NM',  	resizable : true, 	align:'center',    	width:'120px',	sortable:false, 	formatter:goGridRowChnlDetail },
			{ name:'chnlNo',   		index:'lc.CHNL_NO',  	resizable : true, 	align:'center',    	width:'80px',	sortable:false },
			{ name:'cardKndNm',   	index:'cc4.mark_name',  resizable : true, 	align:'center',    	width:'100px',	sortable:false },

            { name:'rid',    		index:'lpt.rid',    hidden : true},
            { name:'ridMbr',    	index:'lm.rid',    	hidden : true},
            { name:'ridMbrCard',    index:'lmc.rid',    hidden : true},
            { name:'cprtCardCd',    index:'lmc.cprtCardCd',    	hidden : true},
            { name:'cardTypeCdCode',index:'lpt.CARD_TYPE_CD',   hidden : true}
        ],
        sortname: 'apprDate',
		sortorder: "desc",
       	radio: true
    };
    transactionList = $("#transactionListGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridTransactionList = $("#gridTransactionList");
}
//가맹점 상세 연결 formatter
function goGridRowChnlDetail(cellvalue, options, rowObjec){
    var tRidChnl = rowObjec.ridChnl;
    var url = '<ifvm:url name="channelDetail"/>' + '?rid=' + tRidChnl;
   	var tag = null;

   	if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }

   	return tag;
}



//포인트거래 상세 연결 formatter
function goGridRowTrDetail(cellvalue, options, rowObjec){
    var trRid = rowObjec.rid;
    if(typeof defaultArchive != "undefined" && defaultArchive != "null" ){
    	var url = '<ifvm:url name="transactionArchiveDetail"/>' + '?rid=' + trRid;
    }else{
    	var url = '<ifvm:url name="transactionDetail"/>' + '?rid=' + trRid;
    }

   	var tag = null;

   	if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }

   	return tag;
}
//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink(cellvalue, options, rowObjec){

    var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag=null;

    if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag=cellvalue;
    }
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

function goGridRowProdLink(cellvalue, options, rowObjec){
	//콜센터 사용자일 경우는 제픔 링크 걸지 않음
	var authList = $.ifvmGetAuthInfo().authList;
	var isAuth = true;

	for(var i = 0 ; i < authList.length ;i++){
		if(authList[i].authName == 'E10005'){
			isAuth = false;
		}
	}
	var id = rowObjec.ridProd;
    var url = '<ifvm:url name="productDetail"/>' + '?rid=' + id;
    var tag=null;
    if(cellvalue!=null && isAuth){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag=cellvalue;
    }
    return tag;
}

function promoIsYn(cellvalue, options, rowObjec){
	var isYn;
	var promoCnt=null
	promoCnt = rowObjec.promoCnt;

	if(promoCnt !=0  && promoCnt !=null){
		isYn="Y"
	}else{
		isYn="N";
	}
	return isYn;

}

//공통 조회 조건 목록 설정
function transactionListSearchInit() {
    $.fn.ifvmSetCommonCondList("transactionSearchList","PGM_L_050");
    //날짜 디폴트 값 제거
    $("#transactionSearchList .datepicker").val("");

}


function dateValid(dateRow){
	var startDt = $("#rows"+dateRow).children(".changeTypeAreaCode").children(".col-xs-2.cal_frt.start_date").children(".smart-form").children(".input").children("input").val() ;
	var endDt = $("#rows"+dateRow).children(".changeTypeAreaCode").children(".col-xs-2.cal_scd.end_date").children(".smart-form").children(".input").children("input").val();

	var dateArray = startDt.split("-");

	var startObj = new Date(dateArray[0], Number(dateArray[1])-1, dateArray[2]);

	dateArray = endDt.split("-");

	var endObj = new Date(dateArray[0], Number(dateArray[1])-1, dateArray[2]);

	var betweenDay = (endObj.getTime() - startObj.getTime())/1000/60/60/24;

	return betweenDay;
}





//공통 조회 호출
function transactionListSearch() {


    $.fn.ifvmSubmitSearchCondition("transactionSearchList", geTtransactionSearch);
}

//고객 상세 이동
function transactionDetailDtl() {
 	var url = '<ifvm:url name="transactionDetail"/>';
 	if(rid !=null){
 		url = url + '?rid=' +  escape(rid);
 	}
 	qtjs.href(url);
}

function fnPointDetailPop(){
   	if(rid==null){
   		alert('<spring:message code="L01820" />');
   		return;
	}
	 pointDetailPop ={
		        id : "pointDetailPopDiv"
		    };
	 pointDetailPop.popup = function (){
	 	pointDetailPop.pop = $('#'+pointDetailPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="pointDetailPop"/>' +"?promoRid="+rid,
		            contentType: "ajax",
		            title: '<spring:message code="L02044" />',
		            width: "1000px"
		        });
		};
		pointDetailPop.beforeClose = function (obj) {
		};
		pointDetailPop.close = function (obj) {
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		};
		pointDetailPop.popup();
}

function buttonStatus(){
	var promoCnt=null
	promoCnt = cardCheckObj.promoCnt;

	if(promoCnt ==0 || promoCnt ==null){
		$("#pointDtlPopBtn").attr('disabled',true);
	}else{
		$("#pointDtlPopBtn").attr('disabled',false);
	}

	rid!=null&&(cardCheckObj.cardTypeCdCode=='20'&& (cardCheckObj.cprtCardCd!='' || cardCheckObj.cprtCardCd!=null))
		? $('#unMaskBtn').attr('disabled',false) : $('#unMaskBtn').attr('disabled',true);
}

function fnUnMak(){
	if ($.fn.ifvmIsNotEmpty(rid)) {
	        $.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	            rid: rid ,
	            type: 'txn' ,
	            field: 'cardNo'
	        },
	        function(result) {
	        	var rowid = transactionList.getRadioSelectedRowId();
	        	if(result.message!=null){
	        		transactionList.opt.grid.setCell( rowid, 'cardNoDecoding' , result.message );
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
    transactionListSearchInit();

    transactionListSearch();


    $.ifvEnterSetting(["#transactionSearchList input"], function(){
    	transactionListSearch();
	});


});

</script>


<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="search"  text="M00135"  id="pointListSearchBtn" btnFunc="transactionListSearch"/>
            <ifvm:inputNew type="button"   text="M00278"  id="pointListSearchInitBtn" btnFunc="transactionListSearchInit"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="transactionSearchList">
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
           <ifvm:inputNew type="button"   text="L00326"  id="unMaskBtn" btnFunc="fnUnMak" objCode="LOY_MAS_013"/>
           <ifvm:inputNew type="button" btnType="search"    text="L00588"  id="pointDtlPopBtn" btnFunc="fnPointDetailPop"/>
           <ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload2('transactionListGrid')" />
        </div>
    </div>
    <div id="transactionListGrid" class="white_bg grid_bd0"></div>

</div>

 <div id="pointDetailPopDiv" class="popup_container content_container"></div>