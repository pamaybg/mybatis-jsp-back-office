<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var mbrStnPntTxnList;
var gridIdmbrStnPntTxnList;
var mbrStnPntTxn_rid = null ;
var mbrStnPntTxnChnl_rid = null ;

//충전소 거래이력
function getmbrStnPntTxnListSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
      var data = mbrStnPntTxnList.getRowData()[data-1];
      rid = data.rid;

      //mbrStnPntTxnDetailDtlPop();   // 상세 보기 이벤트


        },
        onSelectRow : function (data) {

        	mbrStnPntTxn_rid = data.rid;
        	mbrStnPntTxnChnl_rid = data.ridChnl;

        	fnButtonStatus();
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
        data.mbrRid = mbr_rid;
            return data;
        },
        loadComplete : function(obj){
        	 $('#stnPointDetailButton').attr('disabled',true);
        	 window.top.setParentIframeHeight();
        },
        url : '<ifvm:action name="getMbrStnPntTxnList"/>',
        colNames:[
                   '<spring:message code="L01021" />',
                   '<spring:message code="L01022" />',
                   '<spring:message code="L01023" />',
                   '<spring:message code="L01024" />',

                   'rid',
                   'ridChnl'
                 ],
        colModel:[
             { name:'chnlNo',   index:'b.chnl_no ',  resizable : true, align:'center',    width:'100px' },
             { name:'chnlNm',   index:'b.chnl_nm',  resizable : true, align:'center',    width:'100px' },
             { name:'usablePoints',   index:'a.usable_points',  resizable : true, align:'right',  formatter:'integer',   width:'100px' },
             { name:'rmark',   index:'a.rmark',  resizable : true, align:'center',    width:'100px' },
             { name:'rid',    index:'a.rid',    hidden : true},
             { name:'ridChnl',    index:'a.rid_chnl',    hidden : true}
        ],
        sortname: 'a.rid',
        autowidth : true ,
        sortorder: "desc",

        radio : true
    };

    mbrStnPntTxnList = $("#mbrStnPntTxnListGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdmbrStnPntTxnList = $("#gridIdmbrStnPntTxnList");
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


//공통 조회 호출
function mbrStnPntTxnListSearch() {
    $.fn.ifvmSubmitSearchCondition("mbrStnPntTxnListSearchList", getmbrStnPntTxnListSearch);
}

// 상세 팝업 화면 호출
function mbrStnPntTxnDetailDtlPop(){

 $("#mbrStnPntTxnDetailDialog").ifvsfPopup({

  enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="mbrStnPntTxnDetailListPop"/>' + '?rid=' + mbrStnPntTxn_rid ,
        contentType: "ajax",
        title: '충전소 포인트 상세',
        width: '1000px',
        close : 'mbrStnPntTxnDetailPopClose'
    });
}

//팝업 닫기
function mbrStnPntTxnDetailPopClose() {
 mbrStnPntTxnDetailDialog._destroy();


}

//고객 상세 이동
function mbrStnPntTxnDetailDtl() {
    qtjs.href('<ifvm:url name="mbrStnPntTxnDetail"/>' + '?rid=' + rid);
}



function fnStnPointDetail(){
	if( mbrStnPntTxn_rid != null){
		mbrStnPntTxnDetailDtlPop();
	}
}


function fnButtonStatus(){
	mbrStnPntTxnChnl_rid!=null ? $('#stnPointDetailButton').attr('disabled',false) : $('#stnPointDetailButton').attr('disabled',true);


}


$(document).ready(function() {
    mbrStnPntTxnListSearch();
    window.top.setParentIframeHeight();
});

</script>


<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
       	 <ifvm:inputNew type="button" btnType="select" text="L01034" id="stnPointDetailButton"  btnFunc="fnStnPointDetail" />
        </div>
    </div>
    <div id="mbrStnPntTxnListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="mbrStnPntTxnDetailDialog" class="popup_container"></div>



