<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var purHistList;

function mbrPurHistList_init() {
	mbrPurHistList();
}


// 목록
function mbrPurHistList(page){
    
    var page = $.fn.ifvmIsNotEmpty(page) ? page : 1; 
    
    var jqGridOption = {
        serializeGridData : function( data ){
        	
        	
        	if ($.fn.ifvmIsNotEmpty(mbr_rid)) {
                data.ridMbr = mbr_rid;
            }
        	
        	//페이지 설정
        	data.page = page;
        	
            return data;
        },
       
        url : '<ifvm:action name="getMbrPurHistList"/>',
        colNames:[  // '발생일자', '채널명', '영수증번호', '결제수단', '금액', '구매상태', '결제완료일자', '배송수단', '배송 완료일자', '원 영수증번호', '취소일자', '적립 완료일자', '적립 예외 사유',  'rid'       
                    '<spring:message code="L00369"/>',
                    '<spring:message code="L00129"/>',
                    '<spring:message code="L00381"/>',
                    '<spring:message code="L00358"/>',
                    '<spring:message code="L00362"/>',
                    '<spring:message code="L00359"/>',
                    '<spring:message code="L00357"/>',
                    '<spring:message code="L00371"/>',
                    '<spring:message code="L00370"/>',
                    '<spring:message code="L00386"/>',
                    '<spring:message code="L00411"/>',
                    '<spring:message code="L00398"/>',
                    '<spring:message code="L00397"/>',
                    'rid'                        
                 ],
        colModel:[
            { name:'occuDate', 			index:'a.occu_date', 		width:'100px', 	align: 'center', 	resizable : true },
            { name:'chnlNm', 			index:'b.chnl_nm', 			width:'120px', 	align: 'center', 	resizable : true },
            { name:'rcptNo', 			index:'a.rcpt_no', 			width:'120px', 	align: 'center', 	resizable : true },
            { name:'payMethdCd', 		index:'a.pay_methd_cd', 	width:'80px', 	align: 'center', 	resizable : true },
            { name:'amt', 			    index:'a.amt', 				width:'80px', 	align: 'right', 	resizable : true },
            { name:'purStatNm', 		index:'cd3.mark_name', 		width:'80px', 	align: 'center', 	resizable : true },
            { name:'payCmpltDate', 		index:'a.pay_cmplt_date', 	width:'100px', 	align: 'center', 	resizable : true },
            { name:'delvMethdNm', 		index:'cd2.mark_name', 		width:'80px', 	align: 'center', 	resizable : true },
            { name:'delvCmpltDate', 	index:'a.delv_cmplt_date', 	width:'100px', 	align: 'center', 	resizable : true },
            { name:'orgnRcptNo', 		index:'a.orgn_rcpt_no', 	width:'120px', 	align: 'center', 	resizable : true },
            { name:'cancDate', 			index:'a.canc_date', 		width:'100px', 	align: 'center', 	resizable : true },
            { name:'acrlCmpltDate', 	index:'a.acrl_cmplt_date', 	width:'100px', 	align: 'center', 	resizable : true },
            { name:'acrlExcptReasNm', 	index:'cd.mark_name', 		width:'120px', 	align: 'center', 	resizable : true },
            { name:'rid', 				index:'a.rid', 				hidden : true } 
        ],
        sortname: 'a.occu_date',
        autowidth : true , sortorder: "desc",
        radio: true
    };
    
    purHistList = $("#purHistList").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function(){
	mbrPurHistList_init();
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
