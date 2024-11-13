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
var upldItemList;
var ridPar;
var uploadRslt="";
var testViewList_rid = '<%=cleanXss(request.getParameter("rid"))%>';
function upldItemSearch(){
    var jqGridOption = {
       serializeGridData : function( data ){
    	   data.parRid = ridPar
        	   data.uploadRslt = uploadRslt
           return data;
        },
        loadComplete : function(obj){
        	if(obj.rows.length>0){
            	ridPar = obj.rows[0].ridPar
        	}
        	uploadRslt="";
        },
        url : '<ifvm:action name="getUpldItemList"/>',
        colNames:[
                   '<spring:message code="L01646" />',  /*성공/실패 */
                   '<spring:message code="L01647" />',  /*거래유형 */
                   '<spring:message code="L01649" />',  /*회원번호 */
                   '<spring:message code="L01650" />',  /*요청포인트 */
                   '<spring:message code="L01651" />',  /*E1회원번호*/
                   '<spring:message code="L01652" />',  /*회원명*/
                   '<spring:message code="L01653" />',  /*회원상태*/
                   '<spring:message code="L01654" />',  /*가맹점코드*/
                   '<spring:message code="L01655" />',  /*가맹점명*/
                   '<spring:message code="L01656" />',  /*처리상태*/
                   '<spring:message code="L01657" />',  /*요청일시*/
                   '<spring:message code="L01658" />',  /*요청자*/
                   '<spring:message code="L01659" />',  /*승인요청기관*/
                   '<spring:message code="L01660" />',  /*거래일시*/
                   '<spring:message code="L01661" />',  /*거래추적번호*/
                   '<spring:message code="L01662" />',  /*VAN 승인일자*/
                   '<spring:message code="L01663" />',  /*승인번호*/
                   '<spring:message code="L01664" />',  /*승인응답*/
                   '<spring:message code="L01665" />',  /*처리실패 메시지*/
                   'rid',
                   'ridPar',
                   'memDivCd'
                 ],
        colModel:[
             { name:'uploadRslt',   index:'lui.UPLOAD_RSLT',  	resizable : true, align:'center',  width:'80px'},
             { name:'typeCd',   	index:'cc1.MARK_NAME',  	resizable : true, align:'center',  width:'70px' },
             { name:'mbrNo',   		index:'lui.MBR_NO',  		resizable : true, align:'center',  width:'80px' },
             { name:'reqPoint',   	index:'lui.REQ_POINT',  	resizable : true, align:'right',   width:'80px',formatter :'integer' },
             { name:'e1MbrNo',   	index:'lm.MBR_NO',  		resizable : true, align:'center',  width:'90px', formatter: goGridRowMbrLink },
             { name:'mbrHidNm',   	index:'lm.MBR_HID_NM',  	resizable : true, align:'center',  width:'80px' },
             { name:'memStatus', 	index:'cc2.MARK_NAME',  	resizable : true, align:'center',  width:'80px' },
             { name:'chnlNo',   	index:'lc.CHNL_NO',  		resizable : true, align:'center',  width:'100px' },
             { name:'acntId',   	index:'lc.ACCNT_ID',  		resizable : true, align:'center',  width:'100px' },
             { name:'statusCd',   	index:'cc3.MARK_NAME',  	resizable : true, align:'center',  width:'80px' },
             { name:'requestDt',   	index:'lui.REQUEST_DT',  	resizable : true, align:'center',  width:'140px', formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"} },
             { name:'requestId',   	index:'lui.REQUEST_ID',  	resizable : true, align:'center',  width:'80px' },
             { name:'terminalCd',   index:'cc4.MARK_NAME',  	resizable : true, align:'center',  width:'100px'  },
             { name:'txnDt',   		index:'lui.TXN_DT',  		resizable : true, align:'center',  width:'130px', formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"}  },
             { name:'txnNum',   	index:'lui.TXN_NUM',  		resizable : true, align:'right',   width:'100px' },
             { name:'approvalDt',   index:'lui.APPROVAL_DT',  	resizable : true, align:'center',  width:'130px', formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"}  },
             { name:'approvalNum',  index:'lui.APPROVAL_NUM',  	resizable : true, align:'center',  width:'80px' },
             { name:'returnCd',   	index:'cc5.MARK_NAME',  	resizable : true, align:'center',  width:'80px' },
             { name:'returnText',   index:'lui.RETURN_TEXT',  	resizable : true, align:'center',  width:'100px' },
             { name:'rid',    		index:'lui.RID',    	hidden : true},
             { name:'ridPar',    	index:'lui.RID_PAR',    hidden : true},
             { name:'memDivCd',    	index:'memDivCd',    hidden : true}
        ],
        sortname: 'lui.UPLOAD_RSLT',
		sortorder: "desc",
    };
    upldItemList = $("#upldItemListGrid").ifvGrid({ jqGridOption : jqGridOption });
}
//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink(cellvalue, options, rowObjec){
	var id = rowObjec.ridMbr;
	
 	if( rowObjec.memDivCd == 'P' ||rowObjec.memDivCd == 'T' ){    	    
	    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
	    
	}else{    		 
	    var url = '<ifvm:url name="mbrGroupDetail"/>' + '?rid=' + id;
	    
	}
        
    var tag=null;

    if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
    return tag;
}


function pointStandardDtlFn(){
 	var url = "<ifvm:url name='standardPointDetail'/>";
 	if(rid !=null){
 		url = url + '?rid=' +  escape(rid);
 	}
 	qtjs.href(url);
}

function pointStandardNewFn(){
	qtjs.href("<ifvm:url name='standardPointDetail'/>");
}

function tabContent(){
	var testTab = $('#tabContent').DrawTab({
		item: [
			{label:'<spring:message code="L01645"/>' , href: '<ifvm:url name="pointSaveListInfo"/>'},
		]
	});
}

function allSearchFn(){
	uploadRslt =""
	upldItemSearch();
}
function sucesSearchFn(){
	uploadRslt ="S"
	upldItemSearch();
}

function failSearchFn(){
	uploadRslt ="F"
	upldItemSearch();
}
$(document).ready(function() {
	allSearchFn();
    //공통 조회 조건 목록 설정
});
</script>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
 			<ifvm:inputNew type="button"   btnType="search"  text="L01666"  id="allSearchBtn" btnFunc="allSearchFn"/>
 			<ifvm:inputNew type="button"   btnType="search" text="L01667"  id="sucesSearchBtn" btnFunc="sucesSearchFn"/>
 			<ifvm:inputNew type="button"   btnType="search" text="L01668"  id="failSearchBtn" btnFunc="failSearchFn"/>
        </div>
    </div>
    <div id="upldItemListGrid" class="white_bg grid_bd0"></div>
</div>
