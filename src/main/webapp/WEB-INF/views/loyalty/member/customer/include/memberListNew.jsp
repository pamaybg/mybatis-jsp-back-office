<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L00856" /></span>
	</div>
</div>
<div id="custMemGrid"></div>

<script>
var custMemGrid;


//프로그램 목록
function getMemberList(){
	var page = $.fn.ifvmIsNotEmpty(page) ? page : 1; 
    var ejGridOption = {

        serializeGridData : function( args ){
        	
        	if ($.fn.ifvmIsNotEmpty(cust_rid)) {
                args.rid = cust_rid;
            }
        	args.page = page;

            return args;
        },
       
        dataUrl : '<ifvm:action name="getMemberList"/>',
    
        columns : [
      	  {
      		  field : 'mbrNo', headerText : '<spring:message code="L00690"/>', headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'a.mbr_no',
      			  title : '{{:mbrNo}}' }
      	  },{
      		  field : 'chnlNm', headerText : '<spring:message code="L00312"/>', headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'c.chnl_nm',
      			  title : '{{:custNm}}'
      		  }
      	  },{
      		  field : 'joinDate', headerText : '<spring:message code="L00311"/>', headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'a.join_date',
      			  title : '{{:joinDate}}'
      		  }
//       	  },{
//       		  field : 'mbrTypeNm', headerText : '<spring:message code="L00434"/>', headerTextAlign : 'center',
//       		  customAttributes : {
//       			  index : 'cd.mark_name',
//       			  title : '{{:mbrTypeCd}}'
//       		  }
      	  },{
      		  field : 'mbrStatNm', headerText : '<spring:message code="L00090"/>',headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'a.mbr_stat_cd',
      			  title : '{{:mbrStatNm}}'
      		  }
      	  },{
      		  field : 'tierNm', headerText : '<spring:message code="L00324"/>',headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'd.tier_nm',
      			  title : '{{:tierNm}}'
      		  }
      	  },{
      		  field : 'rid', headerText : 'rid',headerTextAlign : '',visible: false,
      		  customAttributes : {
      			  index : '',
      			  title : '{{:rid}}'
      		  }
      	  }
      	  
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'a.join_date',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true
        
    };
    
    custMemGrid = $("#custMemGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function() {
	getMemberList();
});

</script>