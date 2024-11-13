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
var promoList;
var defaultArchive =  '<%= cleanXss(request.getParameter("defaultArchive")) %>';

//스탬프 거래리스트
function getTransPromoList(){
    var ejGridOption = {

       serializeGridData : function( data ){
    	   data.rid=testViewList_rid;
    	   data.defaultArchive = defaultArchive
    	   return data;
        },
        dataUrl : '<ifvm:action name="getTransPromoList"/>',
        columns:[
        	  {
         		  field : 'tabDispNo', headerText : '적립정책 번호', headerTextAlign : 'center',textAlign : ej.TextAlign.Center , width:'100px',
         		  customAttributes : {
         			  index : 'mcm.disp_no' } //프로모션코드
         	  },
         	  {
          		  field : 'camNm', headerText : '적립정책명', headerTextAlign : 'center',  width:'150px',
          		  customAttributes : {
          			  index : 'mcm.cam_nm' } //프로모션명
          	  },
         	  {
          		  field : 'offerNm', headerText : '<spring:message code="L02196"/>', headerTextAlign : 'center',  width:'120px',
          		  customAttributes : {
          			  index : 'mom.offer_nm' } //오퍼명
          	  },
          	  {
          		  field : 'tabAcrlAmt', headerText : '<spring:message code="L00592"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Right, format : "{0:n0}",  width:'80px',
          		  customAttributes : {
          			  index : 'lpa.acrl_amt' } //적립포인트
          	  },
          	  {
          		  field : 'validEndDate', headerText : '<spring:message code="L02195"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,  width:'80px',  format: "{0:MM/dd/yyyy}",
          		  customAttributes : {
          			  index : 'lpa.valid_end_date' } //소멸예정일
          	  },
          	  {
          		  field : 'acrlDate', headerText : '<spring:message code="L00069"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,  width:'80px',   format: "{0:MM/dd/yyyy}",
          		  customAttributes : {
          			  index : 'lpa.acrl_date' } //등록일
          	  }
     	],
     	requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  _search : false
        },
        rowList : [10,25,50,100],
    };

    promoList = $("#transPromoListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function() {
	getTransPromoList();
});

</script>

<div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    <div id="transPromoListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="stampTxnDetailDialog" class="popup_container"></div>
