<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var pointChargeList;
var rid=null;
var cardCheckObj;

//공통 조회 조건 목록 설정
function pointChargeListSearchInit() {
    $.fn.ifvmSetCommonCondList("pointChargeListSearchList","PGM_L_060");
    searchInitialize();
}


function dateCondUniqueCheck(){
	var uniqueCheck = [];
	var uniqueValid=true;
	$(".SearchCondition .searchTextVal option:selected").filter(function(){
		if(  $(this).val()=="DATE" &&   $(this).parents('.SearchCondition').css("display")	!="none"){

			$(this).attr('joinsrcclm');
			uniqueCheck.push($(this).attr('joinsrcclm'));
		}
	})
	for(var i=0; i<uniqueCheck.length; i++){
		for(var j=0; j<i;j++){
			if(uniqueCheck[i]==uniqueCheck[j]){
				uniqueValid=false;
			}
		}
	}
	return uniqueValid;
}

function dateValid(filedName){  //날짜 한달 이상 조회 못하게 validation
	var betweenDay 	=  0
	var dateValid =true;
	$(".SearchCondition .searchTextVal option:selected").filter(function(){
		if($(this).attr('joinsrcclm') == filedName ){
			if($(this).parents('.SearchCondition').css("display")	!="none"){
				var startDt = $(this).parents('.SearchCondition').find('.changeTypeAreaCode .start_date input').val()
				var endDt = $(this).parents('.SearchCondition').find('.changeTypeAreaCode .end_date input').val();
				var dateArray = startDt.split("-");
				var startObj = new Date(dateArray[0], Number(dateArray[1])-1, dateArray[2]);
				dateArray = endDt.split("-");
				var endObj = new Date(dateArray[0], Number(dateArray[1])-1, dateArray[2]);
				betweenDay  =  (endObj.getTime() - startObj.getTime())/1000/60/60/24;
			}
		}
	})
	if(betweenDay>30){
		dateValid = false;
	}
	return dateValid;
}

function searchBlankCheck(){
	var blankCheck=false;
	var searchCondSize= $('.changeTypeAreaCode').size();
	var displayRowNum=[];
	var txnCheck=0;
	$($('.row.qt_border.SearchCondition')).each(function(index,item){
		if($("#rows"+index).css("display") !="none"){
			if($("#rows"+index).children(".changeTypeAreaCode").find('.smart-form').size()!=0){ //date
				if($("#rows"+index).children(".changeTypeAreaCode").children(".col-xs-2.cal_frt.start_date").children(".smart-form").children(".input").children("input").val() !=""
					&& $("#rows"+index).children(".changeTypeAreaCode").children(".col-xs-2.cal_scd.end_date").children(".smart-form").children(".input").children("input").val() !="" ){
					blankCheck=true;
				}
			}
			if($("#rows"+index+ " .searchTextVal option:selected").attr('joinsrcclm')=="TXN_NUM"){
				if($("#rows"+index+ " .changeTypeAreaCode input").val()!=""){
					txnCheck++;
				}
			}

		}
	})  //빈값 처리
	if(txnCheck>0){
		blankCheck=true;
	}
	return blankCheck;
}


//공통 조회 호출
function pointChargeListSearch() {
	var searchValidation=true ;
	if(!searchBlankCheck()){
		alert('<spring:message code="L01859" />');
		searchValidation=false;
	}

	if(!dateCondUniqueCheck()){
		aalert('<spring:message code="L02016" />');
		searchValidation=false;
	}

	var filedName = 'APPROVE_DT'
	if(!dateValid(filedName)){
		alert('<spring:message code="L01861" />');
		searchValidation=false;
	}
	filedName = 'TXN_DT'
	if(!dateValid(filedName)){
		alert('<spring:message code="L01862" />');
		searchValidation=false;
	}
	if(searchValidation){
	   $.fn.ifvmSubmitSearchCondition("pointChargeListSearchList", getPointChargeSearch);
	}else{
	   $("#pointChargeListGrid").ifvGrid({ jqGridOption : jqGridOptionInit });
	}
}
//스탬프 거래리스트
function getPointChargeSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
      var obj = pointChargeList.getRowData()[data-1];
      rid = obj.rid;
      pointChargeDtl();   // 상세 보기 이벤트
        },
        onSelectRow : function (data) {
        	rid=data.rid;
        	cardCheckObj = data;
        	maskingBtnStatusFn();
        },
       serializeGridData : function( data ){
       	if ($.fn.ifvmIsNotEmpty(requestitem)) {
   			data.item = requestitem;
        }
            return data;
        },
        loadComplete : function(obj){
        	cardCheckObj = {};
        	maskingBtnStatusFn();
        },
        url : '<ifvm:action name="getPointChargeList"/>',
        colNames:[
                   '<spring:message code="L00933" />',  /*거래번호 */
                   '<spring:message code="L00935" />',  /*승인일시 */
                   '<spring:message code="L00936" />',  /*거래상세유형*/
                   '<spring:message code="L00975" />',  /*회원번호 */
                   '<spring:message code="L00976" />',  /*회원명 */
                   '<spring:message code="L00414" />', /*카드번호 */
                   '<spring:message code="L01013" />', /*발생포인트*/
                   '<spring:message code="L01014" />', /*사용포인트 */
                   '<spring:message code="L01015" />', /*거래후 가용포인트 */
                   '<spring:message code="L01016" />', /*포인트교환 사은품 */
                   '<spring:message code="L01006" />', /*제품명 */
                   '<spring:message code="L01017" />', /*충전소 코드 */
                   '<spring:message code="L01018" />', /*충전소명 */
                   'rid',
                   'cardTypeCd',
                   'cprtCardCd',
                   'ridMbr',
                   'ridChnl',
                   'ridProd',
                   'ridCust'
                 ],
        colModel:[
             { name:'txtNum',   index:'lsp.TXN_NUM',  resizable : true, align:'center',    width:'200px',sortable: false  },
             { name:'approveDt',   index:'lsp.APPROVE_DT',  resizable : true, align:'center',  formatter:'date',formatoptions:{newformat:"Y-m-d H:i:s"} ,width:'160px',sortable: false  },
             { name:'subTypeCd',   index:'cc1.MARK_NAMETK',  resizable : true, align:'center',     width:'100px' ,sortable: false },
             { name:'mbrNo',   index:'lm.MBR_NO',  resizable : true, align:'center',    width:'120px',sortable: false, formatter : goGridRowMbrLink  },
             { name:'custNm',   index:'lct.CUST_NM',  resizable : true, align:'center',    width:'120px' ,sortable: false  },
             { name:'cardNum',   index:'lsp.CARD_NUM',  resizable : true, align:'center',    width:'120px' ,sortable: false },
             { name:'accPnts',   index:'lsp.ACC_POINTS',  resizable : true, align:'right',    width:'120px' ,formatter:'integer',sortable: false },
             { name:'usePnts',   index:'lsp.USE_POINTS',  resizable : true, align:'right',    width:'120px',formatter:'integer' ,sortable: false },
             { name:'totalUsablePnts',   index:'lsp.TOTAL_USABLE_POINTS',  resizable : true,align:'right',    width:'120px',formatter:'integer' ,sortable: false },
             { name:'stationGiftNm',   index:'lsp.STATION_GIFT_NM',  resizable : true, align:'left',    width:'120px' ,sortable: false },
             { name:'prodNm',   index:'lp.PROD_NM',  resizable : true, align:'center',    width:'120px', formatter : goGridRowProdLink,sortable: false },
             { name:'chnlNo',   index:'lc.CHNL_NO',  resizable : true, align:'center',    width:'120px' ,sortable: false },
             { name:'chnlNm',   index:'lc.CHNL_NM',  resizable : true, align:'center',    width:'120px'  ,formatter : goGridRowChannelLink,sortable: false  },

             { name:'rid',    index:'lsp.rid',    hidden : true},
             { name:'cardTypeCd',    index:'lsp.CARD_TYPE_cd',    hidden : true},
             { name:'cprtCardCd',    index:'lmc.cprt_card_cd',    hidden : true},
             { name:'ridMbr',    index:'lsp.RID_MBR',    hidden : true},
             { name:'ridChnl',    index:'lsp.RID_CHNL',    hidden : true},
             { name:'ridProd',    index:'lsp.RID_PROD',    hidden : true},
             { name:'ridCust',    index:'lm.RID_CUST',    hidden : true}
        ],
        sortname: 'rid',
		sortorder: "desc",
       	radio: true
    };
    pointChargeList = $("#pointChargeListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

var jqGridOptionInit = {
		  colNames:[
	                   '<spring:message code="L00933" />',  /*거래번호 */
	                   '<spring:message code="L00935" />',  /*승인일시 */
	                   '<spring:message code="L00936" />',  /*거래상세유형*/
	                   '<spring:message code="L00975" />',  /*회원번호 */
	                   '<spring:message code="L00976" />',  /*회원명 */
	                   '<spring:message code="L00414" />', /*카드번호 */
	                   '<spring:message code="L01013" />', /*발생포인트*/
	                   '<spring:message code="L01014" />', /*사용포인트 */
	                   '<spring:message code="L01015" />', /*거래후 가용포인트 */
	                   '<spring:message code="L01016" />', /*포인트교환 사은품 */
	                   '<spring:message code="L01006" />', /*제품명 */
	                   '<spring:message code="L01017" />', /*충전소 코드 */
	                   '<spring:message code="L01018" />', /*충전소명 */
	                   'rid',
	                   'cardTypeCd',
	                   'cprtCardCd',
	                   'ridMbr',
	                   'ridChnl',
	                   'ridProd',
	                   'ridCust'
	                 ],
	        colModel:[
	             { name:'txtNum',   index:'lsp.TXN_NUM',  resizable : true, align:'center',    width:'200px',sortable: false  },
	             { name:'approveDt',   index:'lsp.APPROVE_DT',  resizable : true, align:'center',  formatter:'date',formatoptions:{newformat:"Y-m-d H:i:s"} ,width:'160px',sortable: false  },
	             { name:'subTypeCd',   index:'cc1.MARK_NAMETK',  resizable : true, align:'center',     width:'100px' ,sortable: false },
	             { name:'mbrNo',   index:'lm.MBR_NO',  resizable : true, align:'center',    width:'120px',sortable: false , formatter : goGridRowMbrLink },
	             { name:'custNm',   index:'lct.CUST_NM',  resizable : true, align:'center',    width:'120px' ,sortable: false  },
	             { name:'cardNum',   index:'lsp.CARD_NUM',  resizable : true, align:'center',    width:'120px' ,sortable: false },
	             { name:'accPnts',   index:'lsp.ACC_POINTS',  resizable : true, align:'right',    width:'120px' ,formatter:'integer',sortable: false },
	             { name:'usePnts',   index:'lsp.USE_POINTS',  resizable : true, align:'right',    width:'120px',formatter:'integer' ,sortable: false },
	             { name:'totalUsablePnts',   index:'lsp.TOTAL_USABLE_POINTS',  resizable : true,align:'right',    width:'120px',formatter:'integer' ,sortable: false },
	             { name:'stationGiftNm',   index:'lsp.STATION_GIFT_NM',  resizable : true, align:'left',    width:'120px' ,sortable: false },
	             { name:'prodNm',   index:'lp.PROD_NM',  resizable : true, align:'center',    width:'120px', formatter : goGridRowProdLink,sortable: false },
	             { name:'chnlNo',   index:'lc.CHNL_NO',  resizable : true, align:'center',    width:'120px' ,sortable: false },
	             { name:'chnlNm',   index:'lc.CHNL_NM',  resizable : true, align:'center',    width:'120px'  ,formatter : goGridRowChannelLink,sortable: false  },

	             { name:'rid',    index:'lsp.rid',    hidden : true},
	             { name:'cardTypeCd',    index:'lsp.CARD_TYPE_cd',    hidden : true},
	             { name:'cprtCardCd',    index:'lmc.cprt_card_cd',    hidden : true},
	             { name:'ridMbr',    index:'lsp.RID_MBR',    hidden : true},
	             { name:'ridChnl',    index:'lsp.RID_CHNL',    hidden : true},
	             { name:'ridProd',    index:'lsp.RID_PROD',    hidden : true},
	             { name:'ridCust',    index:'lm.RID_CUST',    hidden : true}
	        ],
      dataType:"clientSide",
      data : {}
	}

function searchInitialize(){
	$(".SearchCondition .searchCondition option[value='LIKE']").remove();
	$(".SearchCondition .searchCondition option[value='NOT']").remove();
	$(".datepicker").val("");
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

function goGridRowMbrLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridMbr;
    var custId = rowObjec.ridCust
    if(custId!=null){
    	var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
		var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    	return tag;
    }else{
    	return "";
    }
}

function goGridRowChannelLink(cellvalue, options, rowObjec){
	var id = rowObjec.ridChnl;
	var tag=null;
	var url = '<ifvm:url name="channelDetail"/>?rid=' + id;
	if(cellvalue!=null){
		tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
	}else{
		tag="";
	}
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

function pointChargeDtl(){
	var url = '<ifvm:url name="pointChargeDetail"/>' ;
	if(rid!=null){
		url+= '?rid=' + rid;
	}
	qtjs.href(url);
}

function maskingBtnStatusFn(){

	if((cardCheckObj.cardNum!=null && cardCheckObj.cardNum!='') &&  (cardCheckObj.cardTypeCd=='20'&& (cardCheckObj.cprtCardCd=='' || cardCheckObj.cprtCardCd==null) ) ){
		$('#unMaskBtn').attr('disabled',false)
	}else{
		$('#unMaskBtn').attr('disabled',true);
	}
	/* rid!=null&& (cardCheckObj.cardNum!=null && cardCheckObj.cardNum!='') && (cardCheckObj.cardTypeCd=='20'&&(cardCheckObj.cprtCardCd!='' || cardCheckObj.cprtCardCd!=null) )||cardCheckObj.cardTypeCd=='30'
		? $('#unMaskBtn').attr('disabled',false) : $('#unMaskBtn').attr('disabled',true); */
}

function unMaskFn(){
	if ($.fn.ifvmIsNotEmpty(rid)) {
	        $.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	            rid: rid ,
	            type: 'lspt' ,
	            field: 'cardNum'
	        },
	        function(result) {
	        	var rowid = pointChargeList.getRadioSelectedRowId();
	        	if(result.message!=null){
		        	chnlTxnHistList.opt.grid.setCell( rowid, 'cardNum' , result.message );
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
	pointChargeListSearchInit();
    $("#pointChargeListGrid").ifvGrid({ jqGridOption : jqGridOptionInit });

    //공통 조회조건 추가 제어 기능
    commSearchEventFn();

});
</script>

<div class="page-title">
    <h1>
        <spring:message code="L01019" />
        &gt; <spring:message code="L00081"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="search"  text="L00030"  id="searchBtn" btnFunc="pointChargeListSearch"/>
            <ifvm:inputNew type="button"   text="L00031"  id="searchInitBtn" btnFunc="pointChargeListSearchInit"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="pointChargeListSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button"   text="L00326"  id="unMaskBtn" btnFunc="unMaskFn" disabled="true" objCode="LOY_MAS_010"/>
        </div>
    </div>
    <div id="pointChargeListGrid" class="white_bg grid_bd0"></div>
</div>
