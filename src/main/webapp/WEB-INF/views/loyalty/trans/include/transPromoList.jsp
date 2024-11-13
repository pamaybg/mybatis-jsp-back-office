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
    var jqGridOption = {

        onSelectRow : function (data) {
        },
       serializeGridData : function( data ){
    	   data.rid=testViewList_rid;
    	   data.defaultArchive = defaultArchive
    	   return data;
        },
        loadComplete : function(obj){
        },
        url : '<ifvm:action name="getTransPromoList"/>',
        colNames:[
					'<spring:message code="L00590" />',  /*프로모션 코드 */
                    '<spring:message code="L00589" />',  /*프로모션 유형 */
                    '<spring:message code="L00591" />',  /*프로모션 명*/
                    '<spring:message code="L00592" />',  /*적립포인트 */
                 ],
        colModel:[
             { name:'tabDispNo',   index:'mcm.DISP_NO',  resizable : true, align:'center',    width:'100px' },
             { name:'name',   index:'mcm.DISP_NO',  resizable : true, align:'center',    width:'100px' },
             { name:'camNm',       index:'mcm.CAM_NM',   resizable : true, align:'center',    width:'100px' },
             { name:'tabAcrlAmt',  index:'lpa.ACRL_AMT', resizable : true, align:'right',     width:'120px', formatter:'integer'  },
       		],
    };

    promoList = $("#transPromoListGrid").ifvGrid({ jqGridOption : jqGridOption });
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
