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
var id = '<%= cleanXss(request.getParameter("id")) %>';
function getPromoListSearch(){
    var jqGridOption = {
    		serializeGridData : function( data ){
    			data.id = id;
    			return data;
	        },
	        loadComplete : function(obj){
	        	console.log(obj);
	        },
	        url : '<ifvm:action name="getPastCamTgtList"/>',
	        colNames:[
	                   '<spring:message code="M02696" />',  /*회원번호 */
	                   '<spring:message code="M02697" />',  /*회원명 */
	                   '<spring:message code="M02698" />',  /*TM결과 코드명*/
	                   '<spring:message code="M02699" />',  /*실수령주소 */
	                   '<spring:message code="M02700" />',  /*응모일자 */
	                   '<spring:message code="M02701" />',  /*당첨일자 */
	                   '<spring:message code="M02702" />',  /*메시지유형 */
	                   '<spring:message code="M02703" />',  /*메세지발송일자 */
	                   '<spring:message code="M02704" />',  /*메세지반응 */
	                 ],
	        colModel:[
	            { name:'mbrNo',   		index:'t1.mbr_no',  			resizable : true, align:'center',    width:'100px' },
	            { name:'custNm',   		index:'lc.cust_nm',  			resizable : true, align:'center',    width:'100px' },
	            { name:'xCallResultNm', index:'t1.X_CALL_RESULT_NM ',  	resizable : true, align:'center',    width:'100px' },
	            { name:'xTakeHomeAddr1',index:'t1.X_TAKE_HOME_ADDR1',  	resizable : true, align:'right',    width:'120px'  },
	            { name:'applicationDt', index:'t1.APPLICATION_DT',  	resizable : true, align:'right',    width:'120px'  },
	            { name:'winningDt',   	index:'t1.WINNING_DT',  		resizable : true, align:'right',    width:'120px'  },
	            { name:'msgTypeNm',   	index:'t1.MSG_TYPE_NM',  		resizable : true, align:'right',    width:'120px'  },
	            { name:'smsSendDt',   	index:'t1.SMS_SEND_DT',  		resizable : true, align:'right',    width:'120px'  },
	            { name:'responseMsg',   index:'t1.RESPONSE_MSG',  		resizable : true, align:'right',    width:'120px'  },
	        ],
	    };

    pastCamTgtList = $("#pastCamTgtListGrid").ifvGrid({ jqGridOption : jqGridOption });
}


function targetEmailFn(){
	targetEmailPop ={
	        id : "targetEmailPopDiv"
	    };
	targetEmailPop.popup = function (){
		targetEmailPop.pop = $('#'+targetEmailPop.id).ifvsfPopup({
	            enableModal: true,
	            enableResize: false,
	            contentUrl: '<ifvm:url name="targetEmailPop"/>' ,
	            contentType: "ajax",
	            title: '<spring:message code="M02695" />',
	            width: "1000px"
	        });
	};
	targetEmailPop.beforeClose = function (obj) {
	};
	targetEmailPop.close = function (obj) {
	        this.beforeClose(obj);
	        this.pop.data('ejDialog')._destroy();
	 };
	 targetEmailPop.popup();
}
$(document).ready(function() {
	getPromoListSearch();

});

</script>

<div class="page_btn_area" >
    <div class="col-xs-7">
        <span><spring:message code="M02516" /></span>
    </div>
    <div class="col-xs-5 searchbtn_r">
    	<ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload('affiliateTransListGrid')" />
    	<ifvm:inputNew type="button" btnType="search" text="M02695" id="targetEmailBtn"  btnFunc="targetEmailFn" />
    </div>
</div>

<div>
    <div id="pastCamTgtListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="targetEmailPopDiv" class="popup_container"></div>


