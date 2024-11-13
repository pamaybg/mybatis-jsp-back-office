<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var mbrTermsHistList;

function getMbrTermsHistListNew_init() {
	getMbrTermsHistList();
}


// 목록
function getMbrTermsHistList(page){

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

        dataUrl : '<ifvm:action name="getMbrTermsHistList"/>',

        columns:[
        	  {
         		  field : 'agreNm', headerText : '유형', headerTextAlign : 'center', textAlign : 'center',
         		  customAttributes : {
         			  index : 'C1.MARK_NAME' }
         	  },{
           		  field : 'agreYn', headerText : '동의 여부', headerTextAlign : 'center', textAlign : 'center',
           		  customAttributes : {
           			  index : 'T1.AGRE_YN' }
           	  },{
           		  field : 'termsNm', headerText : '약관명', headerTextAlign : 'center', textAlign : 'center',
           		  customAttributes : {
           			  index : 'T2.TERMS_NM' }
           	  },{
         		  field : 'termsVer', headerText : '약관버전', headerTextAlign : 'center', textAlign : 'center',
         		  customAttributes : {
         			  index : 'T2.VER' }
         	  },{
           		  field : 'createDate', headerText : '변경 일시', headerTextAlign : 'center', textAlign : 'center',
           		  customAttributes : {
           			  index : 'T1.CREATE_DATE' }
           	  }
        ],
        requestGridData : {
        	  nd   : new Date().getTime(),
        	  rows : 10,
        	  sidx : 'T1.CREATE_DATE',
        	  sord : 'desc',
        	  _search : false
          },
          rowList : [10,25,50,100],
          radio: true
//         tempId : 'ifvGridOriginTemplete'
    };

    mbrTermsHistList = $("#mbrTermsHistList").ifvsfGrid({ ejGridOption : ejGridOption  });
}

$(document).ready(function(){
	getMbrTermsHistListNew_init();
});

</script>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>
    <div id="mbrTermsHistList" class="white_bg grid_bd0"></div>
</div>