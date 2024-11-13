<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
<% request.setCharacterEncoding("UTF-8");%>
var channelSearchHelp;
var gridIdchannelSearchHelp;
var rid ;


var obj=null;

//가맹점 SearchHelp
function getchannelSearchHelpSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
      var data = channelSearchHelp.getRowData()[data-1];
      rid = data.rid;

      //retrunChannel();
        },
        onSelectRow : function (data) {

        },
        onSelectCell : function( data ){
         	obj	= data;
         	if(data.receiptPrintYn != 'Y') { //직영점이 아닌 경우 사후영수증 적립 불가
         		alert('매장영수증을 출력하지 않는 지점은 영수증 사후적립이 불가능합니다.');
         		obj = null;
         	} 
         	//매장 포인트 적립 가능여부 체크
         	else if($('#pntTxnType_1Cd').val() === '100') { //포인트거래유형:적립
         		if(data.acrlPsblYn != 'Y') {
		         	alert('포인트 적립 불가능 지점은 영수증 사후적립이 불가능합니다.');
		     		obj = null;
         		}
         	}/*  else if($('#pntTxnType_1Cd').val() === '200') { //포인트거래유형:사용
         		if(data.usePsblYn != 'Y') {
		         	alert('포인트 사용 불가능 지점은 영수증 사후적립이 불가능합니다.');
		     		obj = null;
         		}
         	} */
         },

       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }

//       		data.ouTypeCd = ouTypeCd;
            return data;
        },
        loadComplete : function(data){
         	if(data.rows.length==1){
        		obj = data.rows[0];
//         		choiceChannelFn();
        	}
//         	defaultSearchClose();
        },
        url : '<ifvm:action name="getChannelSearchHelp"/>',
        colNames:[
                   '<spring:message code="L00564" />',
                   '<spring:message code="L00565" />',
                   '<spring:message code="L00383" />',
                   '<spring:message code="M01801" />',
//                    '<spring:message code="L00400" />',
                   '<spring:message code="M01797" />',
                   '매장영수증출력여부',
                   '적립가능여부',
//                    '사용가능여부',
                   'rid',
                   'apvRqtInstn',
                   'bizrNo',

                 ],
        colModel:[
             { name:'chnlNo',   index:'a.chnl_no',  resizable : true, align:'center',    width:'100px' },
             { name:'chnlNm',   index:'a.chnl_nm',  resizable : true, align:'center',    width:'100px' },
             { name:'zipCd',   index:'a.zip_cd',  resizable : true, align:'center',    width:'100px' },
             { name:'adrDtl',   index:'a.adr_Dtl',  resizable : true, align:'center',    width:'200px' },
//              { name:'hpNo',   index:'a.hp_no',  resizable : true, align:'center',    width:'100px', sortable:false },
             { name:'reprNm',   index:'a.repr_nm',  resizable : true, align:'center',    width:'100px' },
             { name:'receiptPrintYn',   index:'a.receipt_print_yn',  resizable : true, align:'center',    width:'100px' },
             { name:'acrlPsblYn',   index:'a.acrl_psbl_yn',  resizable : true, align:'center',    width:'100px' },
//              { name:'usePsblYn',   index:'a.use_psbl_yn',  resizable : true, align:'center',    width:'100px' },
             { name:'rid',    index:'a.rid',    hidden : true},
             { name:'apvRqtInstn',    index:'lvr.APV_RQT_INSTN',    hidden : true},
             { name:'bizrNo',    index:'a.bizr_no',    hidden : true},
        ],
        sortname: 'a.rid',
        sortorder: "desc",
        radio : true
    };

    channelSearchHelp = $("#channelSearchHelpGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdchannelSearchHelp = $("#gridIdchannelSearchHelp");
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


//공통 조회 조건 목록 설정
function channelSearchHelpSearchInit() {
    $.fn.ifvmSetCommonCondList("channelSearchHelpSearchList","PGM_L_108");
}

//공통 조회 호출
function channelSearchHelpSearch() {
    $.fn.ifvmSubmitSearchCondition("channelSearchHelpSearchList", getchannelSearchHelpSearch);
}

// 상세 팝업 화면 호출
function emptyDtlPop(){

 $("#emptyDialog").ifvsfPopup({
  enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="empty"/>',
        contentType: "ajax",
        title: 'empty',
        width: '1000px',
        close : 'emptyPopClose'
    });
}

function retrunChannel(){

	gChannelSearchHelp.close();
}

//팝업 닫기
function emptyPopClose() {
	emptyDialog._destroy();
}

//고객 상세 이동
function emptyDtl() {
    qtjs.href('<ifvm:url name="empty"/>' + '?rid=' + rid);
}

function defaultSearch(){


	 if(typeof chnlNo != "undefined" && chnlNo != "undefined"
		 && $.fn.ifvmIsNotEmpty(chnlNo) && chnlNo != "null") {

	$("#pop_main_div_chnl .SearchCondition .searchTextVal option:selected").filter(function(){
		if($(this).attr('joinsrcclm') == "CHNL_NO"){ $(this).parents('.SearchCondition').find('.changeTypeAreaCode input').val(chnlNo)}
		})

	}
	 if(typeof chnlNm != "undefined" && chnlNo != "undefined"
		 && $.fn.ifvmIsNotEmpty(chnlNm) && chnlNm != "null") {

	$("#pop_main_div_chnl .SearchCondition .searchTextVal option:selected").filter(function(){
		if($(this).attr('joinsrcclm') == "CHNL_NM"){ $(this).parents('.SearchCondition').find('.changeTypeAreaCode input').val(chnlNm)}
		})

	}


}
function defaultSearchClose(){
	 if(typeof chnlNo != "undefined" && chnlNo != "undefined"  && $.fn.ifvmIsNotEmpty(chnlNo) && chnlNo != "null") {
		if(channelSearchHelp.getRowData().length==1){
			channelSearchHelpPop.close(channelSearchHelp.getRowDatas(1));
		}
		chnlNo = "null";
	 }
}

//선택
function choiceChannelFn(){
 	if(obj!=null){
// 		channelSearchHelpPop.close(obj);
 		$('#shop_cod').val(obj.chnlNo);
 		$('#chnlNm').val(obj.chnlNm);
 		$('#ridChnl').val(obj.rid);
 		
 		channelSearchHelpPopupClose();
	}else{
		alert('<spring:message code="L01393" />');
	}
}

$(document).ready(function(){
	//페이지 최초 로드 시 공통조회조건값 초기화한다.
	requestitem = null;
	
    //공통 조회 조건 목록 설정
    channelSearchHelpSearchInit();
//     defaultSearch();
    channelSearchHelpSearch();
    //조회
    $('#channelSearchHelpSearchBtn').on('click', function(){
     channelSearchHelpSearch();
    });

    //초기화
    $("#channelSearchHelpSearchInitBtn").on('click', function(){
     channelSearchHelpSearchInit();
    });




    $.ifvEnterSetting(["#channelSearchHelpSearchList input"], function(){
    	 channelSearchHelpSearch();
	});

});

</script>
<div id="pop_main_div_chnl">
	<div>
	    <div class="page_btn_area">
	        <div class="col-xs-7">
	            <span><spring:message code="L01838" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	            <button class="btn btn-sm" id="channelSearchHelpSearchBtn"><i class="fa fa-search"></i>
	                <spring:message code="M00135" />
	            </button>
	            <button class="btn btn-sm" id="channelSearchHelpSearchInitBtn">
	                <spring:message code="M00278" />
	            </button>
	        </div>
	    </div>
	    <div class="well form-horizontal well_bt5" id="channelSearchHelpSearchList" >
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
	    <div id="channelSearchHelpGrid" class="white_bg grid_bd0"></div>
	</div>

	<div id="emptyDialog" class="popup_container"></div>
	<div class="pop_btn_area">
		<ifvm:inputNew type="button" btnType="save"  text="C00038"  id="choiceChannelBtn" btnFunc="choiceChannelFn"/>
 		<ifvm:inputNew type="button"   text="M00441"  id="cancelChnnelSearchHelpBtn" btnFunc="channelSearchHelpPopupClose"/>
	</div>
</div>
