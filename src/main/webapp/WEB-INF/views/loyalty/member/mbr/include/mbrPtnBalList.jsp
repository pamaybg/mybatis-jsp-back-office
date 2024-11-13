<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var tabContent;



function mbrPtnBalList_init() {
	mbrPtnBalList();
}

function getPointBalanceList() {
	
	var pointBalanceList = [];
	
    //오퍼상세
    $.ifvSyncPostJSON('<ifvm:action name="getMbrPtnBalList"/>', {
       rid : mbr_rid
    	  
	  ,ridCust         :  $("#ridCust"         ).text()     
	  ,custTypeCd      :  $("#custTypeCd"      ).val()      
	  ,identiTypeCd    :  $("#identiTypeCd"    ).val()      
	  ,identiVal       :  $("#identiVal"       ).val()
	  ,mbrNo           :  $("#mbrNo"           ).val()           
	  ,mbrStatCd       :  $("#mbrStatCd"        ).val()      
	  ,mbrTypeCd       :  $("#mbrTypeCd"        ).val()      
	  ,joinDate        :  $("#joinDate"         ).val()     
	  ,ridTierCur      :  $("#ridTierCur"       ).text()      
	  ,curTierSelDate  :  $("#curTierSelDate"   ).val()      
	  ,ridChnlJoin     :  $("#ridChnlJoin"      ).text()     
	  ,ridPgm          :  $("#ridPgm"           ).text()     
			

			
		  
    },
    function(result) {
    	if ($.fn.ifvmIsNotEmpty(result)){
    		pointBalanceList = result;    		
    	}else{
    		pointBalanceList = [];
    	}
    });
    
    return pointBalanceList;
}


//목록
function mbrPtnBalList(page){
    
    var page = $.fn.ifvmIsNotEmpty(page) ? page : 1; 
    
    var mbrPtnBalList = getPointBalanceList();
    
    var jqGridOption = {
        data: mbrPtnBalList,
	    datatype: 'clientSide',
        
        colNames:[                   
                   // '프로그램 명' , '오퍼 대유형', '오퍼 소유형', '사용 가능 포인트',  '1개월 소멸예정 포인트' ,  '3개월 소멸예정 포인트',   '전체 적립 포인트',    '전체 사용 포인트',  '전체 적립 취소 포인트',   '전체 사용 취소 포인트',  '전체 소멸 포인트'   
                  // '<spring:message code="L00465"/>',
                   '<spring:message code="L00466"/>',
                   '<spring:message code="L00467"/>',
                   '<spring:message code="L00468"/>',
                   '<spring:message code="L00469"/>',
                   '<spring:message code="L00470"/>',
                   //'<spring:message code="L00471"/>',
                   '<spring:message code="L00472"/>',
                   '<spring:message code="L00473"/>'
                 //  '<spring:message code="L00474"/>',
                  // '<spring:message code="L00475"/>',
                  // '<spring:message code="L00476"/>'
                 ],
        colModel:[
           // { name:'pgmNm', 	index:'pgmNm', 	width:'120px', 	align: 'left', 	resizable : true },
            { name:'offerType', index:'offerType', 	width:'80px', 	align: 'left', 	resizable : true },
            { name:'offerSubType', index:'offerSubType',	width:'80px', 	align: 'left', 	resizable : true },
            { name:'usePnt', 	index:'usePnt', 		formatter:'integer', width:'80px', 	align: 'right', 	resizable : true },
            { name:'accrualPnt', 	index:'accrualPnt', 		formatter:'integer',width:'80px', 	align: 'right', 	resizable : true },
            { name:'expr1MonthPnt', 	index:'expr1MonthPnt', 		formatter:'integer',width:'100px', 	align: 'right', 	resizable : true },
           // { name:'expr3MonthPnt', 	index:'expr3MonthPnt', 		    width:'100px', 	align: 'right', 	resizable : true },            
            { name:'totalAcrlPnt', 	index:'totalAcrlPnt', 	formatter:'integer',	width:'80px', 	align: 'right', 	resizable : true },
            { name:'totalRdmPnt', 	index:'totalRdmPnt', 	formatter:'integer',	width:'80px', 	align: 'right', 	resizable : true }
          //  { name:'totalAcrlCancelPnt', 	index:'totalAcrlCancelPnt', 		width:'80px', 	align: 'right', 	resizable : true },
         //   { name:'totalRdmCancelPnt', index:'totalRdmCancelPnt', 	width:'100px', 	align: 'right', 	resizable : true },
           // { name:'totalExprPnt', 	index:'totalExprPnt', 		width:'80px', 	align: 'right', 	resizable : true }
        ],
        sortname: 'offerType , offerSubType',
        autowidth : true , sortorder: "desc",
        rowList : [100000],
        radio: true,
        tempId : 'ifvGridSimpleTemplete'
    };
    
    tabContent = $("#tabContent").ifvGrid({ jqGridOption : jqGridOption });
}


</script>

<div>
	
</div>