<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script id="mbrNoTemplate" type="text/x-jsrender">
	<span><a href="javascript:void(0);" onclick="goMbrDetail('{{:ridMbr}}');" style="color:#1266FF; text-decoration:underline;">{{:mbrNo}}</a></span>   
</script>

<script id="custNmTemplate" type="text/x-jsrender">
	{{if custStatCdNm != null}}
		{{if custStatCdNm == '활성'}}
			{{:custNm}}		
		{{/if}}
		{{if custStatCdNm != '활성'}}
			{{:custStatCdNm}}
		{{/if}}	
	{{/if}}
</script>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="추천인 이력" /></span>
	</div>
</div>
    <div id="mbrRecommendHistListGrid" class="white_bg grid_bd0"></div>




<script type="text/javascript">

function getRecommendHistList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = mbr_rid;
			return data;
		},
        dataUrl : '<ifvm:action name="getRecommendHistList"/>',

        columns : [
        	{
      		  field : 'rcmmHist', headerText : '구분', headerTextAlign : 'center', textAlign : 'center'
      	  },{
    		  field : 'remmdTypeCdNm', headerText : '추천유형', headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'rcmmdTypeCd'}
    	  },{
    		  field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', textAlign : 'center', customAttributes : {index: 'mbrNo'}, template: '#mbrNoTemplate'
    	  },{
    		  field : 'custNm', headerText : '회원명', headerTextAlign : 'center', textAlign : 'center' , template: '#custNmTemplate'
    	  },{
    		  field : 'regDate', headerText : '등록일자', headerTextAlign : 'center', textAlign : 'center',
    	  },{ // 추천으로 가입한 회원의 rid
    		  field : 'ridMbr', headerText : 'ridMbr', visible: false
    	  },{ 
    		  field : 'custStatCd', headerText : 'custStatCd', visible: false
    	  },{ 
    		  field : 'custStatCdNm', headerText : 'custStatCdNm', visible: false
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '4',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true,
        tempId : 'ifvGridNotSearchTemplete'
    };

    mbrRecommendHistListGrid = $("#mbrRecommendHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//고객 상세 이동
function goMbrDetail(id) {
	//개인정보 조회 이력남기기
	$.fn.ifvmPersonalCondLogPageId("LOY_PUR_LIST", true);
     $.ifvSyncPostJSON('<ifvm:action name="getMbrCustTypeCd"/>',{
     rid : id,
     mbrNo : ''
    }, function(result){
    	returnPage="loyPurHistList";
     if(result.custTypeCd != null){
      if(result.custTypeCd == 'C'){
          //개인정보 조회 이력남기기(법인)
               qtjs.href('<ifvm:url name="corpMbrDetailNewPage"/>' + '?rid=' + result.mbRid+'&checkBackPage='+returnPage);
        } else if(result.custTypeCd == 'I' || result.custTypeCd == 'E'|| result.custTypeCd == 'D'|| result.custTypeCd == 'O'|| result.custTypeCd == 'X') {
          //개인정보 조회 이력남기기(개인/임직원)
               qtjs.href('<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + result.mbRid+'&checkBackPage='+returnPage); 
        }
     }
    });
}


$(document).ready(function(){
	getRecommendHistList();

});

</script>