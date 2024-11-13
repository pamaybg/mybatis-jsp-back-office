<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var mbrChnlRelList;

function getMbrChnlRelList_init() {
	getMbrChnlRelList();
}


// 목록
function getMbrChnlRelList(page){
    
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
       
        url : '<ifvm:action name="getMbrChnlRelList"/>',
    
        colNames:[ // '채널번호', '채널명', '채널 관계 유형', '개인정보활용동의', '위치정보사업동의', '위치정보서비스활용동의','3자정보제공동의', '마케팅활용동의', '우편번호', '기본주소', '상세주소', 'rid'                   
                   '<spring:message code="L00408"/>',
                   '<spring:message code="L00129"/>',
                   '<spring:message code="L00406"/>',
                   '<spring:message code="L00349"/>', 
                   '<spring:message code="L00387"/>', 
                   '<spring:message code="L00388"/>', 
                   '<spring:message code="L00347"/>', 
                   '<spring:message code="L00328"/>', 
                   '<spring:message code="L00383"/>', 
                   '<spring:message code="L00363"/>', 
                   '<spring:message code="L00372"/>', 
                   'rid'                   
                 ],
        colModel:[
            { name:'chnlNo', 			index:'b.chnl_no', 				width:'70px', 	align: 'center', 	resizable : true },
            { name:'chnlNm', 			index:'b.chnl_nm', 				width:'90px', 	align: 'left', 	resizable : true },
            { name:'chnlRelTypeNm', 	index:'cd.mark_name', 			width:'80px', 	align: 'center', 	resizable : true },
            { name:'mktAgrePrvInfo', 	index:'a.mkt_agre_prv_info', 	width:'60px', 	align: 'center', 	resizable : true },
            { name:'mktAgreLbsBiz', 	index:'a.mkt_agre_lbs_biz', 	width:'60px', 	align: 'center', 	resizable : true },
            { name:'mktAgreLbsSvc', 	index:'a.mkt_agre_lbs_svc', 	width:'70px', 	align: 'center', 	resizable : true },
            { name:'mktAgreThirdSnd', 	index:'a.mkt_agre_third_snd', 	width:'60px', 	align: 'center', 	resizable : true },
            { name:'mktAgreUse', 		index:'a.mkt_agre_use', 		width:'60px', 	align: 'center', 	resizable : true },
            { name:'addr1Zip', 			index:'a.addr1_zip', 			width:'60px', 	align: 'center', 	resizable : true },
            { name:'addr1Dflt', 		index:'a.addr1_dflt', 			width:'150px', 	align: 'left', 	resizable : true },
            { name:'addr1Dtl', 			index:'a.addr1_dtl', 			width:'120px', 	align: 'left', 	resizable : true },
            { name:'rid', 				index:'a.rid', 					hidden : true } 
        ],
        sortname: 'a.create_date',
        autowidth : true , sortorder: "desc",
        radio: true,
//         tempId : 'ifvGridOriginTemplete'
    };
    
    mbrChnlRelList = $("#mbrChnlRelList").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function(){
	getMbrChnlRelList_init();
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