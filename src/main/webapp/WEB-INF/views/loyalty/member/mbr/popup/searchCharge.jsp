<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script id="ifvGridTotalTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		{title}
		<div class="grid_con">
			{grid}
		</div>
	</div>
</script>
<style>
</style>
<div>
	<div class="pop_inner_wrap" id="searchChargeWrap">
		<div class="page_btn_area">
	        <div class="col-xs-7">
	            <span><spring:message code="L01838"/></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	            <ifvm:inputNew type="button" id="searchCondBtn" btnType="search" text="L00081" btnFunc="gSearchCharge.searchChargeList" />
	        </div>
	    </div>
	    <div class="form-horizontal underline top_well" id="searchFormPopArea" >
			<div class="row">
				<ifvm:inputNew type="text" id="mbrNo" maxLength="50"  dto="mbrNo"    label="L00787" labelClass="2" conClass="2" disabled="true"/>
				<ifvm:inputNew type="select" id="searchYM" dto="searchYM"    label="L00931" labelClass="1" conClass="2" />
				<ifvm:inputNew type="select" id="searchDef"  dto="searchDef"    label="L00932" labelClass="1" conClass="2"	required="true" />
			</div>

		</div>
		<div class="page_btn_area" id=''>
	        <div class="col-xs-7">
	            <span><spring:message code="L00930"/></span>
	        </div>
	    </div>
	    <div id="chargeListGrid" class="white_bg grid_bd0"></div>
	    <script>

	    </script>
	    <div class="page_btn_area none" id='sumLabel'>
	        <div class="col-xs-7">
	            <span><spring:message code="L01009"/></span>
	        </div>
	    </div>
	    <div id="chargeSumGrid" class="white_bg grid_bd0"></div>
		<script>
		gChargeSum = {
				isGridShowing : false
				, jqGridOption : 	{
				     serializeGridData : function( data ){
				     },
				     ondblClickRow : function (rowNo) {
				     },
					 loadComplete : function(result) {
					 },
				     //data : [],
				     colNames:[
				               '<spring:message code="L00933"/>',
				               '<spring:message code="L00934"/>',
				               '<spring:message code="L00935"/>',
				               '<spring:message code="L00936"/>',
				               '<spring:message code="L00937"/>',
				               '<spring:message code="L00938"/>',
				               '<spring:message code="L00939"/>',
				             ],
				    colModel:[
				        { name:'mbrNo', 	    index:'mbrNo', 			width:'80px', 	align: 'center', 	resizable : true },
				        { name:'txnDate', 		index:'txnDate', 		width:'100px', 	align: 'center', 	resizable : true },
				        { name:'apprDate', 	    index:'apprDate', 		width:'100px', 	align: 'center', 	resizable : true },
				        { name:'pntTxnType1Cd', index:'pntTxnType1Cd', 	width:'80px', 	align: 'center', 	resizable : true },
				        { name:'chnlNo', 		index:'chnlNo', 		width:'80px', 	align: 'left', 		resizable : true },
				        { name:'chnlNm', 		index:'chnlNm', 		width:'200px', 	align: 'center', 	resizable : true },
				        { name:'chargeAmt', 	index:'chargeAmt', 		width:'80px', 	align: 'center', 	resizable : true },

				    ],
				    dataType : 'clientSide',
				    tempId : 'ifvGridTotalTemplete',
				    loadonce : true,
					footerrow: true,
					userDataOnFooter : true,
				},
				insert: function(_list){
					if(!gChargeSum.isGridShowing && _list.length != 0) {
						gChargeSum.isGridShowing = true;
	 	 		     	gChargeSumGrid = $("#chargeSumGrid").ifvGrid({ jqGridOption : gChargeSum.jqGridOption });
	 	 		     	$("#chargeSumGrid .ui-jqgrid-hdiv").css({"height":"1px"});
					}

					if(_list.length != 0){
						for (var i = 0 ; i < _list.length ; i++){
							gChargeSumGrid.addLocalTr(_list[i]);
						}
					}
					this.setChargeSumTotal();
				},
				setChargeSumTotal : function(){
					var totalPnt = gSearchCharge.total;
					totalPnt += Number(gChargeSumGrid.getSum('chargeAmt', "Sum"));
					gChargeSumGrid.setFooter({"mbrNo" : "Total", "chargeAmt" : totalPnt});
				}
		}
		</script>
	</div>
	<div class="pop_btn_area">
	    <ifvm:inputNew type="button" text="L00940" btnFunc="gAddUnreceivePop.beforePop" className="btn_lightGray2"/>
	    <ifvm:inputNew type="button" text="L00941" btnFunc="gMbrDetail.searchCharge.close" className="btn_lightGray2"/>
	    <script>
	    	gAddUnreceivePop = {
	    			id : "addUnreceivePopDiv",
	    			beforePop : function(){
	    				if($("#chargeListGrid div").length > 0){
	    					this.pop();
	    				}else{
	    					alert('<spring:message code="L00986"/>');
	    					return true;
	    				}
	    			},
	    			pop : function(){
    					$("#"+this.id).ifvsfPopup({
	    		            enableModal : true,
	    		            enableResize : false,
	    		            contentUrl : '<ifvm:url name="addUnreceive"/>',
	    		            contentType : "ajax",
	    		            title : '<spring:message code="L00940"/>', // 미승인 거래 추가 ,
	    		            width : '900px'
	    		        });
	    			},
	    			beforeClose : function(){

	    			},
	    			close: function(obj){
	    				if(obj){
	    					this.beforeClose(obj)
	    				}
	    				var _popObj = eval(this.id)
	    				_popObj._destroy();
	    			}
	    	}
	    </script>

	</div>
</div>

<div id="addUnreceivePopDiv" class="popup_container"></div>


<script>

gSearchCharge = {
		total : "",
		jqGridOption : 	{
		     serializeGridData : function( data ){
		    	 data = $("#searchFormPopArea").getSubmitData()
		    	 return data;
		     },
		     ondblClickRow : function (rowNo) {
		     	var data = gChargeListGrid.getRowData()[rowNo-1];
		     },
		     loadComplete : function(result){
				isSearchGridLoaded = true;
				gSearchCharge.setSearchGridTotal();
				$("#sumLabel").show();
				gChargeSumGrid = $("#chargeSumGrid").ifvGrid({ jqGridOption : {}});


		     },
		     url : '<ifvm:action name="getChargeList"/>',
		     colNames:[
		               '<spring:message code="L00933"/>',
		               '<spring:message code="L00934"/>',
		               '<spring:message code="L00935"/>',
		               '<spring:message code="L00936"/>',
		               '<spring:message code="L00937"/>',
		               '<spring:message code="L00938"/>',
		               '<spring:message code="L00939"/>',
		             ],
		    colModel:[
		        { name:'txUniqNo', 	    index:'lpt.txn_num', 			width:'80px', 	align: 'center', 	resizable : true },
		        { name:'txnDate', 		index:'lpt.txn_date', 			width:'100px', 	align: 'center', 	resizable : true,  formatter:insertDash},
		        { name:'apprDate', 	    index:'lpt.appr_date', 			width:'100px', 	align: 'center', 	resizable : true , formatter:insertDash},
		        { name:'pntTxnType1Cd', index:'cc.mark_name', 			width:'80px', 	align: 'center', 	resizable : true },
		        { name:'txnChannelCd', 	index:'lpt.txn_channel_cd', 	width:'80px', 	align: 'left', 		resizable : true },
		        { name:'chnlNm', 		index:'lc.chnl_nm', 			width:'200px', 	align: 'center', 	resizable : true },
		        { name:'chargeAmt', 	index:'', 						width:'80px', 	align: 'center', 	resizable : true, 	sortable: false }

		    ],
		     sortname: 'lpt.APPR_DATE',
		     autowidth : true , sortorder: "desc",
		     footerrow: true,
		     userDataOnFooter : true,


		},
		searchChargeList : function(){
			var vali = $("#searchFormPopArea").ifvValidation();
			if(vali.confirm()){
				gChargeListGrid = $("#chargeListGrid").ifvGrid({ jqGridOption : gSearchCharge.jqGridOption });
			}
		},
		setSearchGridTotal : function(){
			var data = $("#searchFormPopArea").getSubmitData()
			 	$.ifvPostJSON('<ifvm:action name="getChargeSum"/>', data, function(result) {

			 		gSearchCharge.total = Number(result);
			 		gChargeListGrid.setFooter({"mbrNo" : "Total", "chargeAmt" : gSearchCharge.total});
			 	});
		}
}
//일시 구분자 추가
function insertDash(cellvalue, options, rowObject){
	if(cellvalue){
		return cellvalue.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');;
	}
	else{
		return "";
	}
}



$(document).ready(function() {
	$("#searchFormPopArea #mbrNo").val(gMbrDetail.data.mbrNo);
	$.ifvGetCommCodeList('select', 'searchFormPopArea #searchDef', '<ifvm:action name="getCommCodeList"/>', 'FILL_SEARCH_CD', 'loy', false, false, true);

	$("#searchFormPopArea #searchDef").val("T");

	//년월 가져오기
	var action = '<ifvm:action name="getChargeYM"/>';
	$.ifvSyncPostJSON(action, {
			mbrNo: gMbrDetail.data.mbrNo
		}, function(result) {

			if ($.fn.ifvmIsNotEmpty(result)) {
				var atemp = $("#commCodeSelectTemplate").tmpl(result);
				$("#searchYM").append(atemp);
				$("#sumLabel").hide();
			}else{//조회기록이 없을떄
				$("#searchChargeWrap #searchCondBtn").prop('disabled',true)

			}
		})
})
</script>