<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script id="ifvGridChargeTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		{title}
		<div class="grid_con">
			{grid}
		</div>
		<div class="page">
			{page}
			<div class="total_area">{total}</div>
		<div>
	</div>
</script>
<div>
	<div class="pop_inner_wrap">
		<div class="page_btn_area">
	        <div class="col-xs-7">
	            <span><spring:message code="L00958"/></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	            <ifvm:inputNew type="button" text="L00962" btnFunc="caldealAmt" />
	            <script>
	            function caldealAmt(){
	            	var chargeVali = $("#addUnRePopWrap").ifvValidation();
	            	if(chargeVali.confirm() == true){
	            		var chargeData = $("#addUnRePopWrap").getSubmitData();
		            	console.log(chargeData);

		            	//통신 필요 : 충전소 코드로 충전소 명, 기준 단가 데이터 가져 온 후 충전량 계산
		            	var action = '<ifvm:action name="getChargeInfo"/>';
		        		$.ifvSyncPostJSON(action, chargeData, function(result) {

		        			if(result.rows.length != 1){
		        				alert('<spring:message code="L01127"/>'); return;
		        			}
		        			var rtnData = result.rows[0];
		        			gUnreceiveGrid.addLocalTr(rtnData);
		        			$("#addUnRePopWrap input").not('[disabled]').val("");
		        		})
	            	}

	            }
	            </script>
	        </div>
	    </div>
	    <div class="form-horizontal underline top_well" id="addUnRePopWrap" >
			<div class="row">
				<ifvm:inputNew type="text" id="searchYM" dto="searchYM"    label="L00959" labelClass="1" conClass="2" disabled="true" required="true"/>
				<ifvm:inputNew type="search" id="chnlNo|parChnlNoBtn"   dto="chnlNo" btnFunc="channelSearchHelpPopOpen"	required="true"
					label="L00960" labelClass="1" conClass="2" /><!-- 충전소 코드-->
				<ifvm:inputNew type="text" id="chnlNm" dto="chnlNm"    labelClass="2" conClass="3" disabled="true"/>
				<ifvm:inputNew type="hidden" id="chnlRid" dto="chnlRid"/>
				<script>
				function channelSearchHelpPopOpen(){
					channelSearchHelpPop ={
					        id : "channelSearchPopDiv"
					    };
					channelSearchHelpPop.popup = function (){
					channelSearchHelpPop.pop = $('#'+channelSearchHelpPop.id).ifvsfPopup({
					            enableModal: true,
					            enableResize: false,
					            contentUrl: '<ifvm:url name="channelSearchHelp"/>'+ '?ouTypeCd=2',
					            contentType: "ajax",
					            title: "<spring:message code='L00987'/>",
					            width: '700px'
					        });
					};
					channelSearchHelpPop.beforeClose = function (obj) {
						console.log(obj);
						$("#addUnRePopWrap #chnlNm").val(obj.chnlNm);
			        	$("#addUnRePopWrap #chnlNo").val(obj.chnlNo);
			        	$("#addUnRePopWrap #chnlRid").val(obj.rid);
					};
					channelSearchHelpPop.close = function (obj) {
						 if(obj!=null || typeof obj!="undefined"){
							 this.beforeClose(obj);
						 }
					     channelSearchPopDiv._destroy();
					 };
					channelSearchHelpPop.popup();
				}



				</script>
				<ifvm:inputNew type="text" id="dealAmount" dto="dealAmount"    label="L00961" labelClass="1" conClass="2" required="true" />
			</div>

		</div>
		<div class="page_btn_area" id=''>
	        <div class="col-xs-7">
	            <span><spring:message code="L00963"/></span>
	        </div>
	    </div>
	    <div id="unreceiveGrid" class="white_bg grid_bd0"></div>
	</div>
	<div class="pop_btn_area">
	    <ifvm:inputNew type="button" text="L00969" btnFunc="gAddUnreceivePop.insert" className="btn_lightGray2"/>
	    <script>
	    	gAddUnreceivePop.insert = function(){
	    		var tarList = gUnreceiveGrid.getRowData();
	    		if(tarList.length == 0){
	    			alert('<spring:message code="L01126"/>'); return;
	    		}else{
	    			gChargeSum.insert(tarList);
		    		gAddUnreceivePop.close();
	    		}
	    	}
	    </script>
	    <ifvm:inputNew type="button" text="L00970" btnFunc="gAddUnreceivePop.close" className="btn_lightGray2"/>
	</div>
</div>
<div id="channelSearchPopDiv" class="popup_container"></div><!--상위가맹점 조회  -->
<script>

gAddUnreceivePop.jqGridOption = {
		     serializeGridData : function( data ){
		     },
		     ondblClickRow : function (rowNo) {
		     },
		     loadComplete : function(result){
		     },
		     //url : '<ifvm:action name="getChargeList"/>',
		     data : [{searchYM: "", chnlNo: "", chaegePrice: ""}],
		     colNames:[
		               '<spring:message code="L00960"/>',
		               '<spring:message code="L00964"/>',
		               '<spring:message code="L00965"/>',
		               '<spring:message code="L00966"/>',
		               '<spring:message code="L00967"/>',
		               '<spring:message code="L00968"/>',
		             ],
		    colModel:[
		        { name:'chnlNo', 	    index:'chnlNo', 		width:'80px', 	align: 'center', 	resizable : true },
		        { name:'chnlNm', 		index:'chnlNm', 		width:'100px', 	align: 'center', 	resizable : true},
		        { name:'searchYM', 	    index:'searchYM', 		width:'100px', 	align: 'center', 	resizable : true},
		        { name:'prodUnitCost', 	index:'prodUnitCost', 	width:'80px', 	align: 'center', 	resizable : true },
		        { name:'chargePrice', 	index:'chaegePrice', 	width:'80px', 	align: 'left', 		resizable : true },
		        { name:'chargeAmt', 	index:'chargeAmt', 		width:'80px', 	align: 'center', 	resizable : true },
		    ],
		     dataType:'clientSide',
		     //sortname: 'chnlNo',
		     //autowidth : true , sortorder: "desc",
		     tempId : 'ifvGridChargeTemplete'
		}


function addUnreceiveList(){
	gUnreceiveGrid = $("#unreceiveGrid").ifvGrid({ jqGridOption : gAddUnreceivePop.jqGridOption });
}

$(document).ready(function() {
	$("#addUnRePopWrap #searchYM").val($("#searchFormPopArea #searchYM option:selected").text());
	addUnreceiveList();
	/*$.ifvGetCommCodeList('select', 'searchFormPopArea #searchDef', '<ifvm:action name="getCommCodeList2"/>', 'FILL_SEARCH_CD', 'loy', false, false, true);
	//$("#searchFormPopArea #searchDef").append('<option value ="txn">거래일시</option><option value ="appr">승인일시</option>');
	//년월 가져오기
	var action = '<ifvm:action name="getChargeYM"/>';
	$.ifvSyncPostJSON(action, {
			mbrNo: gMbrDetail.data.mbrNo
		}, function(result) {
			if ($.fn.ifvmIsNotEmpty(result)) {

				var atemp = $("#commCodeSelectTemplate").tmpl(result);
				$("#searchYn").append(atemp);
			}
		}) */

})
</script>