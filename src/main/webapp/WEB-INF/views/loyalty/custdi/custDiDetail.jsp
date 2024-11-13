<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page-title">
    <h1>
    	<spring:message code="L02745" />
        &gt; <spring:message code="M00169" />
    </h1>    
</div>
<div>
	<div class="page_btn_area">
	    <div class="col-xs-2">
	        <span><spring:message code="L02755"/></span>
	    </div>
	    <div class="col-xs-10 searchbtn_r">
	        <ifvm:inputNew type="button" id="saveDetail" text="I00745" objCode="custDiDetailSaveDetail_OBJ"/>
			<ifvm:inputNew type="button" id="goCustDiList"  text="L00824" objCode="custDiDetailListDetail_OBJ"/>
	    </div>
	</div>
	<div class="form-horizontal underline top_well underline" id="custDiDetailForm">
	<br>
		<div class="row">
			<ifvm:inputNew type="text" id="diNm" label="L02749" labelClass="1" conClass="5" required="true"/>
			<ifvm:inputNew type="text" id="parPgmNm" label="대표 프로그램" labelClass="1" conClass="2" required="true" disabled="true"/>
	 		<ifvm:inputNew type="hidden" id="parPgmRid" labelClass="1" conClass="1" required="true" disabled="true"/>
	 		<ifvm:inputNew type="hidden" id="repYn"  conClass="1" disabled="true"/>
			<span class="input-group-addon" style="padding : 3px;"  id="loyPgmList">
				<a><i class="fa fa-search"></i></a>
			</span>
		</div>
		<div class="row">
			<ifvm:inputNew type="select" id="custTypeCd" names="custTypeCd" dto="custTypeCd" label="M02328" labelClass="1" conClass="2"/>	
			<ifvm:inputNew type="select" id="certTypeCd" names="certTypeCd"  label="L02750" labelClass="1" conClass="2"/>
			<ifvm:inputNew type="select" id="actYn" names="actYn"  label="M01139" labelClass="1" conClass="2"/>
		</div>
		
		<br>
	</div>
</div>
<div id="custDiDetailTabArea"></div>
<div id="pgmPopupContainer" class="popup_container"></div>
<script type="text/javascript">
var custDiRid = $.ifvGetParam('rid');
var custDiDetailPage;
var realcustTypeCd = null;

var custDiDetail = function(custDiRid) {
		var rid = custDiRid;
		var validation = $("#custDiDetailForm").ifvValidation();
		var inputField = $("#custDiDetailForm input");
		var selectField =$("#custDiDetailForm select");
		// 숫자 콤마 처리
		$("#mergeScore").ifvNumberOnly();
		$("#suspendScore").ifvNumberOnly();
	 	this.isNew = !$.fn.ifvmIsNotEmpty(rid) || rid === 'null', 
		this.textField =[],
		this.selectField =[],
		this.init = function(rid){
			this.initTab();
			this.getCustDiDetail(this.isNew);
			this.action();
		},
		this.save = function(rid){
			var url = this.isNew ? '<ifvm:action name="saveCustDiDetail"/>' : '<ifvm:action name="modifyCustDiDetail"/>';
			if(validation.confirm()){
				$.ifvSyncPostJSON(url,this.getFieldVal(),function(result){
					this.afterSave(result)
				}.bind(this));
			}

		},
		this.goList = function(){
			qtjs.href('<ifvm:url name="custDiList"/>');
		},
		this.getField = function(){
			for(var i=0;i<inputField.length; i++){this.textField[i] = inputField[i].id;}
			for(var i=0;i<selectField.length; i++){this.selectField[i] = selectField[i].id;	}
		},
	    this.setSelectField = function(values) {
	    	var custTypeCd = ( values && values.custTypeCd ) ? values.custTypeCd : null;
	    	var certTypeCd = ( values && values.certTypeCd ) ? values.certTypeCd : null;
	    	var actYn = ( values && values.actYn ) ? values.actYn : null;
	    	
	    	$.fn.ifvmSetSelectOptionCommCode("custTypeCd", "LOY_CUST_TYPE_CD", custTypeCd, null, true);
	        $.fn.ifvmSetSelectOptionCommCode("certTypeCd", "LOY_CERT_TYPE_CD", certTypeCd, null, true);
	        $.fn.ifvmSetSelectOptionCommCode("actYn", "YES_NO_FLAG", actYn, null, true);
	    },
		this.getCustDiDetail = function (){
	    	if($.fn.ifvmIsNotEmpty(rid) ){
	    		$.ifvSyncPostJSON('<ifvm:action name="getCustDiDetail"/>', {rid : rid}, function(result){
		    		 if ($.fn.ifvmIsNotEmpty(result)) {
		    			var values = {};
		    			this.getField();
		    			this.textField.forEach( function(a) { 
		    				 $("#"+ a).val(result[a]); 
		    			});
						this.selectField.forEach(function (b) { 
							values[b] = result[b] 
						});
		 	    		this.setSelectField(values);
		    		 }
		    	}.bind(this));
	    		 realcustTypeCd = $("#custTypeCd").val();
	    	}else{
	    		//custDiDetailTab.disabledTab([0,1]);	
	    		this.getField();
	    		this.setSelectField();
	    	}
		},
		this.getFieldVal = function(){
			if(validation.confirm()){
				var data = {}
				this.textField.forEach(function(a){
					data[a] = $("#"+a).val().replaceAll(",", "")
				});
				this.selectField.forEach(function(b){
					data[b] = $("#"+b).val()
				});
				data['rid'] = rid;
				data['ridPgm'] = $("#parPgmRid").val();
				return data;
			}
		},
		this.afterSave = function(result){
			if(result.success){
				if(result.message) alert(result.message);
				else alert('<spring:message code="L00076"/>');
				rid = result.rid;
			}else{
				if(result.message) alert(result.message);
				else alert('<spring:message code="M02248"/>');
			}
			qtjs.href('<ifvm:url name="custDiDetail"/>'+'?rid='+rid);
		},
		this.initTab = function () {
			$("#custDiDetailTabArea").empty();
			custDiDetailTab = $("#custDiDetailTabArea").DrawTab(
		    {
		    	 item: items
		    	/* [
					{
		               label: '<spring:message code="L02767"/>',
		               href: '<ifvm:url name="custDiVal"/>'
					}
		        ] */
		    });
		},
		this.action = function() {
	        $("#saveDetail").click(function() {
	            this.save();
	        }.bind(this));
	
	        $("#goCustDiList").click(function() {
	        	this.goList();
	        }.bind(this));
	        
	    }
}


 function pgmPopup() {
	$("#repYn").val('Y');
    $("#pgmPopupContainer").ifvsfPopup({
       enableModal : true,
       enableResize : false,
       contentUrl : '<ifvm:url name="pgmListPop"/>',
       contentType : "ajax",
       title : "<spring:message code="L02716"/>",
       width : '860px',
       close : 'pgmPopupClose',
    });
 }

function pgmPopupClose(){
	pgmPopupContainer._destroy();
}


$(document).ready(function(){
	custDiDetailPage = new custDiDetail(custDiRid);
	custDiDetailPage.init();
	
	$("#loyPgmList").click(function(){
		pgmPopup();
	});
});
</script>