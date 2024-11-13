<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" id="taxiPntDetailBtn"	btnFunc="mbrTaxiPntDetailPopup.pop" text="L01337" />
        </div>
        <script>
	        mbrTaxiPntDetailPopup = {
	        		id  : "mbrTaxiPntDetailPop",
	        		pop : function(obj){
	        			if(mbrTaxiPntHistList.getCheckedList().length != 1){
	        				alert('<spring:message code="L01393" />');
	        				return false;
	        			}
	        			$("#"+this.id).ifvsfPopup({
	           	            enableModal : true,
	           	            enableResize : false,
	           	            contentUrl : '<ifvm:url name="viewMbrTaxiPntDetailPop"/>',
	           	            contentType : "ajax",
	           	         	backgroundScroll: false,
	           	            open : function(args) {
	           	            	mbrTaxiPntPopList = $("#viewMbrTaxiPtnPopGrid").ifvGrid({ jqGridOption : gViewMbrTaxiPntPop.jqGridOption });
	           	            },
	           	            title : '<spring:message code="L01337"/>', // 택시전환 포인트 상세,
	           	            width : '1024px'
	           	        });
	        		},
	        		beforeClose : function(obj){
	        			if(obj != null){
	        			}

	        		},
	        		close : function(obj){
	        			if(obj){
	        				this.beforeClose(obj)
	        			}
	        			var _popObj = eval(this.id)
	        			_popObj._destroy();
	        		}
	        }
        </script>
    </div>

    <div id="mbrTaxiPtnHistListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="mbrTaxiPntDetailPop" class="popup_container"></div>
<script>
gMbrTaxiPtnHistList  = {
		checkedData : null,
		jqGridOption : 	{
		     serializeGridData : function( data ){
		    	 data.rid = gMbrDetail.data.rid;
		    	 return data;
		     },
		     ondblClickRow : function (rowNo) {
		     },
		     onSelectRow : function (data) {
		    	 $("#taxiPntDetailBtn").prop("disabled",false);
	        },
		     loadComplete : function(result){

				$("#taxiPntDetailBtn").prop("disabled",true);
				window.top.setParentIframeHeight();
		     },
		     url : '<ifvm:action name="getMbrTaxiPntHistList"/>',
		     colNames:[
		               '<spring:message code="L01338"/>',//택시전환포인트
		               '<spring:message code="L01339"/>',//충전소분담포인트
		               '<spring:message code="L01340"/>',//추가포인트
		               '<spring:message code="L01341"/>',//지급방식
		               '<spring:message code="L01342"/>',//실충전금액
		               '<spring:message code="L01343"/>',//지급계산금액
		               '<spring:message code="L01344"/>',//충전금액
		               '<spring:message code="L01345"/>',//충전횟수
		               '<spring:message code="L01346"/>',//승인일
		               '<spring:message code="L01347"/>',//승인번호
		               '<spring:message code="L01348"/>',//전송상태
		               '<spring:message code="L01392"/>',//전송번호
		               '<spring:message code="L01376"/>',//전송요청일
		               '<spring:message code="L01377"/>',//전송요청시간
		               '<spring:message code="L01378"/>',//추가 P 전송상태
		               '<spring:message code="L01379"/>',//추가 P 승인일
		               '<spring:message code="L01380"/>',//추가 P 승인번호
		               'rid',
		               'confNcst'
		             ],
		    colModel:[
		        { name:'taxiConvPoint', 	    index:'tcp.taxi_conv_point', 		width:'100px', 	align: 'center', 	resizable : true, formatter:'integer' },
		        { name:'stnPartakePoint', 	    index:'tcp.stn_partake_point', 		width:'100px', 	align: 'center', 	resizable : true, formatter:'integer' },
		        { name:'apdPoint', 				index:'tcp.apd_point', 				width:'80px', 	align: 'center', 	resizable : true, formatter:'integer' },
		        { name:'prvdForml', 	    	index:'cc1.mark_name', 				width:'80px', 	align: 'center', 	resizable : true },
		        { name:'realChargAmt', 			index:'tcp.real_charg_amt', 		width:'100px', 	align: 'center', 	resizable : true, formatter:'integer' },
		        { name:'prvdCalcuAmt', 			index:'tcp.prvd_calcu_amt', 		width:'80px', 	align: 'center', 	resizable : true, formatter:'integer' },
		        { name:'chargAmt', 	    		index:'tcp.charg_amt', 				width:'80px', 	align: 'center', 	resizable : true, formatter:'integer' },
		        { name:'chargTmscnt', 			index:'tcp.charg_tmscnt', 			width:'100px', 	align: 'center', 	resizable : true, formatter:'integer' },
		        { name:'apvDay', 	    		index:'tcp.apv_day', 				width:'100px', 	align: 'center', 	resizable : true , formatter : dateSeq },
		        { name:'apvNo', 				index:'tcp.apv_no', 				width:'80px', 	align: 'center', 	resizable : true },
		        { name:'trmStatus', 	    	index:'cc2.mark_name', 				width:'80px', 	align: 'center', 	resizable : true },
		        { name:'trmNo', 	    		index:'tcp.trm_no', 				width:'80px', 	align: 'center', 	resizable : true },
		        { name:'trmRqtDay', 	    	index:'tcp.trm_rqt_day', 			width:'80px', 	align: 'center', 	resizable : true , formatter : dateSeq},
		        { name:'trmRqtTime', 	    	index:'tcp.trm_rqt_time', 			width:'80px', 	align: 'center', 	resizable : true ,  formatter:'date',  formatoptions:{newformat:"H:i:s"}},
		        { name:'apdPointTrmStatus', 	index:'cc3.mark_name', 				width:'100px', 	align: 'center', 	resizable : true },
		        { name:'apdPointApvDay', 	    index:'tcp.apd_point_apv_day', 		width:'80px', 	align: 'center', 	resizable : true, formatter : dateSeq },
		        { name:'apdPointApvNo', 	    index:'tcp.apd_point_apv_no', 		width:'100px', 	align: 'center', 	resizable : true },
		        { name:'rid', 	   				index:'lbh.rid', 					hidden:true },
		        { name:'confNcst', 	   			index:'lbh.rid', 					hidden:true },

		    ],
		     sortname: 'tcp.modify_date',
		     autowidth : true ,
		     sortorder: "desc",

		     radio : true
		}
}
mbrTaxiPntHistList = $("#mbrTaxiPtnHistListGrid").ifvGrid({ jqGridOption : gMbrTaxiPtnHistList.jqGridOption });
function dateSeq(cellvalue, options, rowObject){
	if(cellvalue){
		return cellvalue.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
	}
	else{
		return "";
	}
}
$(document).ready(function(){
	window.top.setParentIframeHeight();
});
</script>