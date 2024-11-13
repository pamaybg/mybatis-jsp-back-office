<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var contentTypePopGrid; 
var chnlCode;


function contentTypePopGridList(){
	var jqGridOption = {
			loadComplete : function(obj){
				//popup 높이 맞추기
				new ifvm.PopupHeight({
					popupDivId : 'contentPopupCon',
					contentsId : 'contentTypeArea'
				});
			},
			onSelectCell : function (data) {
				var dataPath = data.path; 
				var jbSplit = dataPath.split( '.jsp' );
				
			    locationUrl(jbSplit[0] + '?type=' + data.typeCd);
			},
			url:'<ifvm:action name="getChannelStore"/>',
		    colNames:['<spring:message code="M00478"/>',
		              '<spring:message code="M00475"/>',
		              '<spring:message code="M00476"/>', 
		              '<spring:message code="M00477"/>', 
		              '<spring:message code="M00472"/>', 
		              '<spring:message code="M00473"/>',
		              '<spring:message code="M00474"/>',
		              'id'
		    ],
		    colModel:[
		        {name:'seq',index:'mc.seq', resizable : false, width: 5},
		        {name:'periodType',index:'c1.mark_name', resizable : false, width: 10},
		        {name:'maxVol',index:'mc.max_vol', resizable : false, width: 10},
		        {name:'reserveVol',index:'mc.RSRV_VOL', resizable : false, width: 10}, 
		        {name:'description',index:'mc.CHNL_DTL_DESC', resizable : false, width: 10},
		        {name:'modifyBy',index:'c2.name', resizable : false, width: 10}, 
		        {name:'modifyDate',index:'mc.modify_date', resizable : false, width: 10},
		        {name:'id', index:'mc.id', resizable : false,  hidden : true,  searchable : false}
		    ],
		    autowidth:true,
		    sortname: 'mc.seq',
			sortorder: "ASC",
		    tempId : 'ifvGridOriginTemplete',
		    emptyRows : true
		};
	contentTypePopGrid = $("#contentTypePopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//채널 용량 다시 그리기
function ReGrid(){
	var id = $("#chmlName option:selected").val();
	if(id == null) id ='1';
	// contentTypePopGrid.requestData( { mktChlId : $("#chmlName option:selected").val() } );
}

//채널 시스템 세팅
function chnlSystem(){
	var chnlId = null;
	//채널 시스템
	$.ifvSyncPostJSON('<ifvm:action name="getChnnl"/>',{
		id : $("#runChannel option:selected").val()

	},function(result) {
		if(result.length > 0){
			chnlId = result[0].id
			chnlCode = result[0].codeName;
		}
		var temp = $("#conChanneltemp").tmpl(result);
		
		$("#chmlName").empty();
		$("#chmlName").append(temp);
		var cost = $("#chmlName option:selected").attr('cost');
		$("#cost").val(cost);
		// contentTypePopGrid.requestData( { mktChlId : $("#chmlName option:selected").val() } );
		//ReGrid();
	});
	
	//채널 시스템
	$.ifvSyncPostJSON('<ifvm:action name="getchnlCodeName"/>',{
		id : chnlId
	},function(result) {
		if(result != '' && result != null){
			chnlCode = String(result.markName);				
		}else{
			chnlCode = '';
		}
	});
}

//다음 버튼 누를 시 채널 시스템에 따른 이동
function locationUrl(url){
var runchannel = $("#runChannel").val();
var chnl = $("#runChannel option:selected").val();
var chmlName = $("#chmlName").val();

	if(runchannel != null  && chmlName != null){
		qtjs.href(url  + "?chnl="+chnl+'&type='+'MKT');
		popupClose();
	}
	else{   
		alert('<spring:message code="M00503"/>')
	}
}  


$(document).ready(function(){
	$('#chmlName').hide();

    $.fn.ifvmSetSelectOptionCommCode("contsTypeCd", "COM_CONTS_TYPE_CD", null, null, true);

	// contentTypePopGridList();
	
	$("#contentTypeConfirmBtn").on("click", function(){
		popupClose();
	});
	//채널 유형.
	$.ifvSyncPostJSON('<ifvm:action name="getChannelType"/>',{
	},function(result) {
		var temp = $("#runChanneltemp").tmpl(result);
		$("#runChannel").append(temp);
		$("#runChannel option[value='LMS']").hide();
	});
	
	$("#runChannel").change(function(){
		$("#cost").empty();
		chnlSystem();
	});
	
	$("#chmlName").change(function(){
		$("#cost").empty();
		var cost = $("#chmlName option:selected").attr('cost');
		$("#cost").val(cost);
		// contentTypePopGrid.requestData( { mktChlId : $("#chmlName option:selected").val() } );
	});
	
	$("#getContent").on('click', function(){
		var string = $("#runChannel option:selected").attr('path');
		var strArray = string.split('.jsp');
		locationUrl(strArray[0]);
	});
	
	chnlSystem();
	// setTimeout(function(){	contentTypePopGrid.requestData( { mktChlId : $("#chmlName option:selected").val() } ), 100 });
    // $("#runChannel option[value='KAKAONOTI']").hide();

	$("#contsTypeCd").change(function(){
		// if($('#contsTypeCd').val() == "mkt" || $('#contsTypeCd').val() == "prom"){
        //         $("#runChannel option:eq(0)").prop("selected", true);
		// 	     chnlSystem();
		//         $("#runChannel option[value='KAKAONOTI']").hide();
		// } else {
        //         $("#runChannel option:eq(0)").prop("selected", true);
	    //           chnlSystem();
	    //         $("#runChannel option[value='KAKAONOTI']").show();
		// }
	});
	
});


</script>

<script id="contentTypePopGridTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		<div class="grid_con">
			{grid}
		</div>
		<div class="page">
			<div class="total_area">{total}</div>	
		<div>
	</div>
</script>

<script id="runChanneltemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}" path="${'${'}path}" codeid="${'${'}typeid} codeName="${'${'}codeName}" >${'${'}typeCd}</option>
</script>

<script id="conChanneltemp" type="text/x-jquery-tmpl">
<option value="${'${'}id}" codeName="${'${'}codeName}" cost="${'${'}cost}">${'${'}markName}</option>
</script>

<div id="contentTypeArea">
		<div class="temp_title_bb">
			<spring:message code="M00505"/>
		</div>
		    <div class="row qt_border">
<%--                   <ifvm:inputNew type="select" id="contsTypeCd" names="contsTypeCd" dto="contsTypeCd"   label="컨텐츠 타입"  labelClass="4" conClass="8" required="true"/>--%>
		    </div>
			<div class="row qt_border">
					<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00375"/></label>
					<div class="col-xs-8 control_content">
						<div class="input-group">
							<ifvm:input type="select" id="runChannel"/>
						</div>
					</div>
			</div>
			<div class="row qt_border">
<%--					<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M00460"/></label>--%>
					<div class="col-xs-8 control_content">
						<div class="input-group">
							<ifvm:input type="select" id="chmlName"/>
						</div>
				</div>
	<%-- 			<div class="col-xs-6">
					<label class="col-xs-4 control-label"><spring:message code="M00450"/></label>
					<div class="col-xs-7 control_content">
						<div class="input-group">
							<ifvm:input type="text" disabled="true" id="cost"/>
						</div>
					</div>
					<div class="col-xs-1 control-label">
						<span><spring:message code="M00155"/></span>  
					</div>				
				</div> --%>
			</div>
	<%-- 	<div class="temp_title">
			<spring:message code="M00461"/>  
		</div>
		<div id="contentTypePopGrid" class = "con_size_2"></div> --%>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="getContent" objCode="getContent_OBJ"><img src="<ifvm:image name='arrow_right_pop'/>"/>     
			<spring:message code="C00051"/>  
		</button> 
	</div>
