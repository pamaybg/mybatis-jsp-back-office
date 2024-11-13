<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var purHistList;

function mbrPurHistListNew_init() {
	mbrPurHistList();
}


// 목록
function mbrPurHistList(page){
    
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
       
        dataUrl : '<ifvm:action name="getMbrPurHistList"/>',
        columns:[  
        	  {
        		  field : 'occuDate', headerText : '<spring:message code="L00369"/>', headerTextAlign : 'center',
        		  customAttributes : {
        			  index : 'a.occu_date' }
        	  },{
        		  field : 'chnlNm', headerText : '<spring:message code="L00129"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'b.chnl_nm' }
          	  },{
          		  field : 'rcptNo', headerText : '<spring:message code="L00381"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'a.rcpt_no' }
          	  },{
          		  field : 'payMethdCd', headerText : '<spring:message code="L00358"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'a.pay_methd_cd' }
          	  },{
          		  field : 'amt', headerText : '<spring:message code="L00362"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'a.amt' }
          	  },{
          		  field : 'purStatNm', headerText : '<spring:message code="L00359"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'cd3.mark_name' }
          	  },{
          		  field : 'payCmpltDate', headerText : '<spring:message code="L00357"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'a.pay_cmplt_date' }
          	  },{
          		  field : 'delvMethdNm', headerText : '<spring:message code="L00371"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'cd2.mark_name' }
          	  },{
          		  field : 'delvCmpltDate', headerText : '<spring:message code="L00370"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'a.delv_cmplt_date' }
          	  },{
          		  field : 'orgnRcptNo', headerText : '<spring:message code="L00386"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'a.orgn_rcpt_no' }
          	  },{
          		  field : 'cancDate', headerText : '<spring:message code="L00411"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'a.canc_date' }
          	  },{
          		  field : 'acrlCmpltDate', headerText : '<spring:message code="L00398"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'a.acrl_cmplt_date' }
          	  },{
          		  field : 'acrlExcptReasNm', headerText : '<spring:message code="L00397"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'cd.mark_name' }
          	  },{
          		  field : 'rid', headerText : 'rid', headerTextAlign : '',visible: false,
          		  customAttributes : {
          			  index : 'a.rid'}
          	  }
        ],
        requestGridData : {
        	  nd   : new Date().getTime(),
        	  rows : 10,
        	  sidx : 'a.occu_date',
        	  sord : 'desc',
        	  _search : false
          },
          rowList : [10,25,50,100],
          radio: true
    };
    
    purHistList = $("#purHistList").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function(){
	mbrPurHistListNew_init();

});

</script>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>
    <div id="purHistList" class="white_bg grid_bd0"></div>
</div>
