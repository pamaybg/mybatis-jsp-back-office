<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var mbrChnlRelList;

function getMbrChnlRelListNew_init() {
	getMbrChnlRelList();
}


// 목록
function getMbrChnlRelList(page){

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

        dataUrl : '<ifvm:action name="getMbrChnlRelList"/>',

        columns:[
            // '채널번호', '채널명', '채널 관계 유형',  'rid'
            // 2018.10.25.삭제: '개인정보활용동의', '위치정보사업동의', '위치정보서비스활용동의','3자정보제공동의', '마케팅활용동의', '우편번호', '기본주소', '상세주소',
        	  {
         		  field : 'chnlNo', headerText : '<spring:message code="L00408"/>', headerTextAlign : 'center',
         		  customAttributes : {
         			  index : 'b.chnl_no' }
         	  },{
           		  field : 'chnlNm', headerText : '<spring:message code="L00129"/>', headerTextAlign : 'center',
           		  customAttributes : {
           			  index : 'b.chnl_nm' }
           	  },{
           		  field : 'chnlRelTypeNm', headerText : '<spring:message code="L00406"/>', headerTextAlign : 'center',
           		  customAttributes : {
           			  index : 'cd.mark_name' }
           	  },{
           		  field : 'regDt', headerText : '등록일시', headerTextAlign : 'center',
           		  customAttributes : {
           			  index : 'a.reg_dt' }
           	  },
           	  /* {
           		  field : 'mktAgrePrvInfo', headerText : '<spring:message code="L00349"/>', headerTextAlign : 'center',
           		  customAttributes : {
           			  index : 'a.mkt_agre_prv_info' }
           	  },{
           		  field : 'mktAgreLbsBiz', headerText : '<spring:message code="L00387"/>', headerTextAlign : 'center',
           		  customAttributes : {
           			  index : 'a.mkt_agre_lbs_biz' }
           	  },{
           		  field : 'mktAgreLbsSvc', headerText : '<spring:message code="L00388"/>', headerTextAlign : 'center',
           		  customAttributes : {
           			  index : 'a.mkt_agre_lbs_svc' }
           	  },{
           		  field : 'mktAgreThirdSnd', headerText : '<spring:message code="L00347"/>', headerTextAlign : 'center',
           		  customAttributes : {
           			  index : 'a.mkt_agre_third_snd' }
           	  },{
           		  field : 'mktAgreUse', headerText : '<spring:message code="L00328"/>', headerTextAlign : 'center',
           		  customAttributes : {
           			  index : 'a.mkt_agre_use' }
           	  },{
           		  field : 'addr1Zip', headerText : '<spring:message code="L00383"/>', headerTextAlign : 'center',
           		  customAttributes : {
           			  index : 'a.addr1_zip' }
           	  },{
           		  field : 'addr1Dflt', headerText : '<spring:message code="L00363"/>', headerTextAlign : 'center',
           		  customAttributes : {
           			  index : 'a.addr1_dflt' }
           	  },{
           		  field : 'addr1Dtl', headerText : '<spring:message code="L00372"/>', headerTextAlign : 'center',
           		  customAttributes : {
           			  index : 'a.addr1_dtl' }
           	  }, */
           	  {
           		  field : 'rid', headerText : 'rid',visible: false,
           		  customAttributes : {
           			  index : 'a.rid' }
           	  },

        ],
        requestGridData : {
        	  nd   : new Date().getTime(),
        	  rows : 10,
        	  sidx : 'a.create_date',
        	  sord : 'desc',
        	  _search : false
          },
          rowList : [10,25,50,100],
          radio: true
//         tempId : 'ifvGridOriginTemplete'
    };

    mbrChnlRelList = $("#mbrChnlRelList").ifvsfGrid({ ejGridOption : ejGridOption  });
}

$(document).ready(function(){
	getMbrChnlRelListNew_init();
});

</script>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>
    <div id="mbrChnlRelList" class="white_bg grid_bd0"></div>
</div>