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
var unRgstCardUpldItemList;
var ridPar;
var uploadRslt="";
var testViewList_rid = '<%= cleanXss(request.getParameter("rid")) %>';
function unRgstCardUpldItemSearch(){
    var jqGridOption = {
        onSelectRow : function (data) {


        },
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
        url : '<ifvm:action name="getUnRgstCardUploadItem"/>',
        colNames:[
                   '<spring:message code="L01646" />',  /*성공/실패 */
                   '<spring:message code="L00414" />',  /*카드번호*/
                   '<spring:message code="L01899" />',  /*제품코드*/
                   '<spring:message code="L02092" />',  /*유효기간*/
                   '<spring:message code="L00700" />',  /*선 지급금액*/
                   '<spring:message code="L02093" />',  /*E1 카드번호*/
                   '<spring:message code="L02094" />',  /*E1 제품명*/
                   '<spring:message code="L01630" />',  /*처리상태*/
                   '<spring:message code="L02066" />',  /*업로드 실패 메세지*/
                  
                   'rid',
                   'ridPar',
                 ],
        colModel:[
             { name:'uploadRslt',   index:'luri.UPLOAD_RSLT',  	resizable : true, align:'center',  width:'60px'},
             { name:'cardNum',   	index:'luri.CARD_NUM',  	resizable : true, align:'center',  width:'90px' },
             { name:'prodId',   	index:'luri.PROD_ID',  	resizable : true, align:'center',   width:'80px'},
             { name:'expireDt',   	index:'luri.EXPIRE_DT',  		resizable : true, align:'center',  width:'90px', formatter:'date', formatoptions:{newformat:"Y-m-d"}  }, 
             { name:'preSavePoint',   		index:'luri.PRE_SAVE_POINT',  		resizable : true, align:'right',  width:'80px' ,formatter :'integer'},
             { name:'e1CardNum',   	index:'lcri.CARD_NUM',  		resizable : true, align:'center',  width:'90px' }, 
             { name:'prodNm',   	index:'lp.PROD_NM',  		resizable : true, align:'center',  width:'90px' }, 
             { name:'statusCd',   	index:'luri.STATUS_CD',  		resizable : true, align:'left',  width:'60px' },
             { name:'errMsg',   	index:'luri.ERR_MSG',  		resizable : true, align:'left',  width:'100px' },
             
             { name:'rid',    		index:'lui.RID',    	hidden : true},
             { name:'ridPar',    	index:'lui.RID_PAR',    hidden : true},
        ],
        sortname: 'luri.UPLOAD_RSLT',
		sortorder: "desc",
    };
    unRgstCardUpldItemList = $("#unRgstCardUpldItemListGrid").ifvGrid({ jqGridOption : jqGridOption });
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
	unRgstCardUpldItemSearch();
}
function sucesSearchFn(){
	uploadRslt ="S"
	unRgstCardUpldItemSearch();
}

function failSearchFn(){
	uploadRslt ="F"
	unRgstCardUpldItemSearch();
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
 			<ifvm:inputNew type="button"   btnType="search"  text="L01666"  id="allSearchBtn" btnFunc="allSearchFn" objCode="allSearchBtn_OBJ"/>
 			<ifvm:inputNew type="button"   btnType="search" text="L01667"  id="sucesSearchBtn" btnFunc="sucesSearchFn" objCode="sucesSearchBtn_OBJ"/>
 			<ifvm:inputNew type="button"   btnType="search" text="L01668"  id="failSearchBtn" btnFunc="failSearchFn" objCode="failSearchBtn_OBJ"/>
        </div>
    </div>
    <div id="unRgstCardUpldItemListGrid" class="white_bg grid_bd0"></div>
</div>
