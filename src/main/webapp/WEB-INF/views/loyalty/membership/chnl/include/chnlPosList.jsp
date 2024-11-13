<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var tabContent;

var objChnlPosPop;

var page;

function chnlPosList_init() {
	 getChnlPosList();
}


//고객 상세 이동
function goChnlPosDetail(id) {

	objChnlPosPop = $("#chnlPosDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="chnlPosPop"/>?' + 'chnl_rid=' + chnl_rid + '&chnlPos_rid='+ id ,
        contentType: "ajax",
        title: '<spring:message code="L00348"/>',
        width: '400px',
        close : 'chnlPosPopClose'
    });
}




function chnlPosPopClose(closeFlag) {

	if(closeFlag == true) {
		
		getChnlPosList(page);
	}

	objChnlPosPop._destroy();
	
}


//프로그램 목록
function getChnlPosList(page){
    
    var page = $.fn.ifvmIsNotEmpty(page) ? page : 1; 
    
    var jqGridOption = {
        serializeGridData : function( data ){
        	
        	if ($.fn.ifvmIsNotEmpty(chnl_rid)) {
                data.ridChnl = chnl_rid;
            }
        	
        	//페이지 설정
        	data.page = page;
        	
            return data;
        },
        ondblClickRow : function (rowNo) {
        	var data = tabContent.getRowData()[rowNo-1];
        	
        	goChnlPosDetail(data.rid);
        },
       
        url : '<ifvm:action name="getChnlPosList"/>',
    
        colNames:[ //  '단말기 번호',  '활성', '설명', '생성자', '생성일', '수정일', 'rid'
                   '<spring:message code="L00322"/>',
                   '<spring:message code="L00430"/>',
                   '<spring:message code="L00340"/>',
                   '<spring:message code="L00093"/>',
                   '<spring:message code="L00092"/>',            
                   '<spring:message code="L00094"/>',
                   'rid'                   
                 ],
        colModel:[
            { name:'posNo', 		index:'a.pos_no', 			width:'120px', 	align: 'center', 	resizable : false },
            { name:'activeYn', 		index:'a.active_yn', 		width:'60px', 	align: 'center', 		resizable : true  },
            { name:'desctxt', 	    index:'a.desctxt ', 		width:'200px', 	align: 'left', 		resizable : true  },
            { name:'createBy', 	    index:'em.name', 		    width:'120px', 	align: 'left', 	    resizable : false },
            { name:'createDate',    index:'a.create_date',      width:'90px', 	align: 'center', 	resizable : false },
            { name:'modifyDate', 	index:'a.modify_date', 		width:'90px', 	align: 'center', 	resizable : false },
            { name:'rid', 			index:'a.rid', 				hidden : true } 
        ],
        sortname: 'a.modify_date',
        autowidth : true , sortorder: "desc",
        radio: true,
        tempId : 'ifvGridOriginTemplete'
    };
    
    tabContent = $("#tabContent").ifvGrid({ jqGridOption : jqGridOption });
}


</script>

<div>
	
</div>