<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var stampTxnList;
var gridIdstampTxnList;
var rid ;

//스탬프 거래리스트
function getstampTxnListSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
      var obj = stampTxnList.getRowData()[data-1];
      rid = obj.rid;
      console.log("rid = "+ rid);
      stampTxnDetailDtl();   // 상세 보기 이벤트
        },
        onSelectRow : function (data) {
        },
       serializeGridData : function( data ){
        	if ($.fn.ifvmIsNotEmpty(requestitem)) {
       			data.item = requestitem;
            }
            return data;
        },
        loadComplete : function(obj){
        	console.log(obj);
        },
        url : '<ifvm:action name="getStampTxnList"/>',
        colNames:[
                   '<spring:message code="L00554" />',  /*거래번호 */
                   '<spring:message code="L00555" />',  /*승인일시 */
                   '<spring:message code="L00556" />',  /*거래 상세유형*/
                   '<spring:message code="M00688" />',  /*회원번호 */
                   '<spring:message code="M00850" />',  /*회원명 */
                   '<spring:message code="L00557" />',  /*회원구분 */
                   '<spring:message code="L00180" />', /*회원등급 */
                   '<spring:message code="L00558" />', /*발생스탬프*/
                   '<spring:message code="L00559" />', /*사용스탬프 */
                   '<spring:message code="L00560" />', /*선물스탬프 */
                   '<spring:message code="L00561" />', /*가용스탬프 */
//                   '<spring:message code="L00562" />', /*선물회원번호 */
//                   '<spring:message code="L00563" />', /*선물회원명 */
                   '<spring:message code="L00564" />', /*가맹점코드 */
                   '<spring:message code="L00565" />', /*가맹점명 */
                   '<spring:message code="L00566" />', /*제품코드 */
                   '<spring:message code="L00567" />', /*제품명 */
                   '<spring:message code="L00568" />', /*스탬프금액 */
                   'rid',
                   'mbrRid',
                   'chnlRid',
                   'prodRid'
                 ],
        colModel:[
             { name:'txnNo',   index:'lst.txn_no',  resizable : true, align:'center',    width:'170px' ,sortable: false },
             { name:'apprDt',   index:'lst.appr_dt',  resizable : true, align:'center',  formatter:'date',  formatoptions:{newformat:"Y-m-d"} ,  width:'100px',sortable: false  },
             { name:'txnType2Cd',   index:'lst.txn_type_2_cd',  resizable : true, align:'center',    width:'100px',sortable: false  },
             { name:'mbrNo',   index:'lm.mbr_no', formatter: goGridRowMbrLink,  resizable : true, align:'center',    width:'120px',sortable: false  },
             { name:'custNm',   index:'cst.CUST_NM', /*formatter: goGridRowMbrLink,*/  resizable : true, align:'center',    width:'120px',sortable: false  },
             { name:'memDiv',   index:'cc2.MARK_NAME',  resizable : true, align:'center',    width:'120px' ,sortable: false },
             { name:'memGrade',   index:'cc3.MARK_NAME',  resizable : true, align:'center',    width:'120px' ,sortable: false },
             { name:'acrlStamp',   index:'lst.acrl_stamp',  resizable : true, align:'right', formatter:'integer',    width:'120px',sortable: false  },
             { name:'useStamp',   index:'lst.use_stamp',  resizable : true, align:'right',  formatter:'integer',   width:'120px',sortable: false  },
             { name:'giftStamp',   index:'lst.gift_stamp',  resizable : true, align:'right',  formatter:'integer',   width:'120px' ,sortable: false },
             { name:'avlStamp',   index:'lst.avl_stamp',  resizable : true, align:'right',  formatter:'integer',   width:'120px',sortable: false  },
           //  { name:'giftMbrNo',   index:'lm2.MBR_NO',  resizable : true, align:'center',    width:'120px' ,sortable: false },
            // { name:'giftCustNm',   index:'cst2.CUST_NM',  resizable : true, align:'center',    width:'120px' ,sortable: false },
             { name:'chnlNo',   index:'lc.CHNL_NO', /*  formatter: goGridRowChannelLink, */ resizable : true, align:'center',    width:'120px',sortable: false  },
             { name:'chnlNm',   index:'lc.CHNL_NM',  resizable : true, align:'center',    width:'120px', formatter : goGridRowChannelLink ,sortable: false },
             { name:'prodId',   index:'lp.PROD_ID',  resizable : true, align:'center',    width:'120px',sortable: false  },
             { name:'prodNm',   index:'lp.PROD_NM',  resizable : true, align:'center', formatter: goGridRowProdLink,   width:'120px' ,sortable: false },
             { name:'unitCost',   index:'lst.unit_cost',  resizable : true, align:'right', formatter:'integer',   width:'120px' ,sortable: false },

             { name:'rid',    index:'lst.rid',    hidden : true},
             { name:'chnlRid',    index:'lc.rid',    hidden : true},
             { name:'mbrRid',    index:'lm.rid',    hidden : true},
             { name:'ridProd',    index:'lpt.RID_PROD',    hidden : true}
        ],
        sortname: 'lst.TXN_NO',
		sortorder: "desc",
    };

    stampTxnList = $("#stampTxnListGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdstampTxnList = $("#gridIdstampTxnList");
}

var jqGridOptionInit = {
		   colNames:[
	                   '<spring:message code="L00554" />',  /*거래번호 */
	                   '<spring:message code="L00555" />',  /*승인일시 */
	                   '<spring:message code="L00556" />',  /*거래 상세유형*/
	                   '<spring:message code="M00688" />',  /*회원번호 */
	                   '<spring:message code="M00850" />',  /*회원명 */
	                   '<spring:message code="L00557" />',  /*회원구분 */
	                   '<spring:message code="L00180" />', /*회원등급 */
	                   '<spring:message code="L00558" />', /*발생스탬프*/
	                   '<spring:message code="L00559" />', /*사용스탬프 */
	                   '<spring:message code="L00560" />', /*선물스탬프 */
	                   '<spring:message code="L00561" />', /*가용스탬프 */
//	                   '<spring:message code="L00562" />', /*선물회원번호 */
//	                   '<spring:message code="L00563" />', /*선물회원명 */
	                   '<spring:message code="L00564" />', /*가맹점코드 */
	                   '<spring:message code="L00565" />', /*가맹점명 */
	                   '<spring:message code="L00566" />', /*제품코드 */
	                   '<spring:message code="L00567" />', /*제품명 */
	                   '<spring:message code="L00568" />', /*스탬프금액 */
	                   'rid',
	                   'memDivCd',
	                   'mbrRid',
	                   'chnlRid',
	                   'prodRid'
	                 ],
	        colModel:[
	             { name:'txnNo',   index:'lst.txn_no',  resizable : true, align:'center',    width:'170px' ,sortable: false },
	             { name:'apprDt',   index:'lst.appr_dt',  resizable : true, align:'center',  formatter:'date',  formatoptions:{newformat:"Y-m-d"} ,  width:'100px',sortable: false  },
	             { name:'txnType2Cd',   index:'lst.txn_type_2_cd',  resizable : true, align:'center',    width:'100px',sortable: false  },
	             { name:'mbrNo',   index:'lm.mbr_no', formatter: goGridRowMbrLink,  resizable : true, align:'center',    width:'120px',sortable: false  },
	             { name:'custNm',   index:'cst.CUST_NM',  resizable : true, align:'center',    width:'120px',sortable: false  },
	             { name:'memDiv',   index:'cc2.MARK_NAME',  resizable : true, align:'center',    width:'120px' ,sortable: false },
	             { name:'memGrade',   index:'cc3.MARK_NAME',  resizable : true, align:'center',    width:'120px' ,sortable: false },
	             { name:'acrlStamp',   index:'lst.acrl_stamp',  resizable : true, align:'right', formatter:'integer',    width:'120px',sortable: false  },
	             { name:'useStamp',   index:'lst.use_stamp',  resizable : true, align:'right',  formatter:'integer',   width:'120px',sortable: false  },
	             { name:'giftStamp',   index:'lst.gift_stamp',  resizable : true, align:'right',  formatter:'integer',   width:'120px' ,sortable: false },
	             { name:'avlStamp',   index:'lst.avl_stamp',  resizable : true, align:'right',  formatter:'integer',   width:'120px',sortable: false  },
	           //  { name:'giftMbrNo',   index:'lm2.MBR_NO',  resizable : true, align:'center',    width:'120px' ,sortable: false },
	            // { name:'giftCustNm',   index:'cst2.CUST_NM',  resizable : true, align:'center',    width:'120px' ,sortable: false },
	             { name:'chnlNo',   index:'lc.CHNL_NO', /*  formatter: goGridRowChannelLink, */ resizable : true, align:'center',    width:'120px',sortable: false  },
	             { name:'chnlNm',   index:'lc.CHNL_NM',  resizable : true, align:'center',    width:'120px', formatter : goGridRowChannelLink ,sortable: false },
	             { name:'prodId',   index:'lp.PROD_ID',  resizable : true, align:'center',    width:'120px',sortable: false  },
	             { name:'prodNm',   index:'lp.PROD_NM',  resizable : true, align:'center', formatter: goGridRowProdLink,   width:'120px' ,sortable: false },
	             { name:'unitCost',   index:'lst.unit_cost',  resizable : true, align:'right', formatter:'integer',   width:'120px' ,sortable: false },

	             { name:'rid',    index:'lst.rid',    hidden : true},
	             { name:'memDivCd',    index:'memDivCd',    hidden : true},
	             { name:'chnlRid',    index:'lc.rid',    hidden : true},
	             { name:'mbrRid',    index:'lm.rid',    hidden : true},
	             { name:'ridProd',    index:'lpt.RID_PROD',    hidden : true}
	        ],
        dataType:"clientSide",
        data : {}
}


//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink(cellvalue, options, rowObjec){
	if( rowObjec.memDivCd == 'P' ||rowObjec.memDivCd == 'T' ){
	    var id = rowObjec.mbrRid;
	    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
	}else{
		 var id = rowObjec.mbrRid;
	    var url = '<ifvm:url name="mbrGroupDetail"/>' + '?rid=' + id;

	}

    if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
    return tag;
}
function goGridRowChannelLink(cellvalue, options, rowObjec){
    var id = rowObjec.chnlRid;
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
function goGridRowPgmLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridPgm;
    var url = '<ifvm:url name="pgmDetail"/>?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    return tag;
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

//공통 조회 조건 목록 설정
function stampTxnListSearchInit() {
    $.fn.ifvmSetCommonCondList("stampTxnListSearchList","PGM_L_063");
    searchInitialize();
}

//공통 조회 호출
function stampTxnListSearch() {
	var searchValidation = true;
	if(!searchBlankCheck()){
		alert('<spring:message code="L01859" />');
		searchValidation = false;
	}

	if(!dateCondUniqueCheck()){
		alert('<spring:message code="L02016" />');
		searchValidation = false;
	}

	var filedName = 'APPR_DT'
	if(!dateValid(filedName)){
		alert('<spring:message code="L01861" />');
		searchValidation = false;
	}

	filedName = 'TXN_DT'
	if(!dateValid(filedName)){
		alert('<spring:message code="L01862" />');
		searchValidation = false;
	}
	if(searchValidation){
	    $.fn.ifvmSubmitSearchCondition("stampTxnListSearchList", getstampTxnListSearch);
	}else{
		$("#stampTxnListGrid").ifvGrid({ jqGridOption : jqGridOptionInit });
	}

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
			if($("#rows"+index+ " .searchTextVal option:selected").attr('joinsrcclm')=="TXN_NO"){
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

function dateCondUniqueCheck(){
	var uniqueCheck = [];
	var uniqueValid=true;
	$(".SearchCondition .searchTextVal option:selected").filter(function(){
		if($(this).val()=="DATE" &&   $(this).parents('.SearchCondition').css("display")!="none"){
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


//팝업 닫기
function stampTxnDetailPopClose() {
 $('#stampTxnDetailDialog').ejDialog('destroy');
}

//고객 상세 이동
function stampTxnDetailDtl() {
 	var url = '<ifvm:url name="stampTxnDetail"/>';
 	if(rid !=null){
 		url = url + '?rid=' + rid;
 	}
 	qtjs.href(url);
}

$(document).ready(function() {
    //공통 조회 조건 목록 설정
    stampTxnListSearchInit();

    $("#stampTxnListGrid").ifvGrid({ jqGridOption : jqGridOptionInit });

    //공통 조회조건 추가 제어 기능
    commSearchEventFn();
});

</script>


<div class="page-title">
    <h1>
        <spring:message code="L00553" />
        &gt;<spring:message code="L00081"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>

        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="search"  text="M00135"  id="stampTxnListSearchBtn" btnFunc="stampTxnListSearch"/>
            <ifvm:inputNew type="button"   text="M00278"  id="stampTxnListSearchInitBtn" btnFunc="stampTxnListSearchInit"/>

        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="stampTxnListSearchList" >
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
    <div id="stampTxnListGrid" class="white_bg grid_bd0"></div>
</div>

