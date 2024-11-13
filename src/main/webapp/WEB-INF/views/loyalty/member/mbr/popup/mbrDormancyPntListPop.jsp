<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var mbrDormancyPntList;

function getMbrDormancyPntList_init() {
	getMbrDormancyPntList();
}

// 목록
function getMbrDormancyPntList(page){

    var page = $.fn.ifvmIsNotEmpty(page) ? page : 1;

    var ejGridOption = {
        serializeGridData : function( data ){
        	if ($.fn.ifvmIsNotEmpty(mbr_rid)) {
                data.ridMbr = mbr_rid;
            }
        	//페이지 설정
        	data.page = page;
            return data;
        },
        dataUrl : '<ifvm:action name="getDormancyPntListByMbr"/>',
        columns:[
        	  {
         		  field : 'txnDt', headerText : '거래일시', headerTextAlign : 'center',
         		  customAttributes : {
         			  index : 'lpt.txn_dt' }
         	  },{
           		  field : 'txnAmt', headerText : '거래금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
           		  customAttributes : {
           			  index : 'lpt.txn_amt' }
         	  },{
           		  field : 'apprDt', headerText : '승인일시', headerTextAlign : 'center',
           		  customAttributes : {
           			  index : 'lpt.appr_dt' }
           	  },{
           		  field : 'pntAmt', headerText : '소멸포인트', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
           		  customAttributes : {
           			  index : 'lpt.pnt_amt' }
           	  },{
           		  field : 'modifyDate', headerText : '소멸일시', headerTextAlign : 'center',
           		  customAttributes : {
           			  index : 'lpt.modify_date' }
           	  },{
           		  field : 'validDate', headerText : '포인트 유효기간', headerTextAlign : 'center',
           		  customAttributes : {
           			  index : 'lpa.VALID_END_DATE' }
           	  },{
           		  field : 'chnlNm', headerText : '적립채널', headerTextAlign : 'center',
           		  customAttributes : {
           			  index : 'lc.chnl_nm' }
           	  },{
           		  field : 'camNm', headerText : '프로모션명', headerTextAlign : 'center',
           		  customAttributes : {
           			  index : 'mcm.cam_nm' }
           	  },{
           		  field : 'rid', headerText : 'rid',visible: false,
           		  customAttributes : {
           			  index : 'lpt.rid' }
           	  },
        ],
        requestGridData : {
        	  nd   : new Date().getTime(),
        	  rows : 10,
        	  sidx : 'lpt.modify_date',
        	  sord : 'desc',
        	  _search : false
          },
          rowList : [10,25,50,100],
          radio: true
    };

    mbrDormancyPntList = $("#mbrDormancyPntList").ifvsfGrid({ ejGridOption : ejGridOption  });
}


//팝업 close
function dormancyPntPopClose() {
	dormancyPntListPop.close();
}

$(document).ready(function(){
	getMbrDormancyPntList_init();
});

</script>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>
    <div id="mbrDormancyPntList" class="white_bg grid_bd0"></div>
    <div class="pop_btn_area">
		<ifvm:inputNew type="button"   text="L00913"  id="dormancyPntPopClose" btnFunc="dormancyPntPopClose"/>
	</div>
</div>