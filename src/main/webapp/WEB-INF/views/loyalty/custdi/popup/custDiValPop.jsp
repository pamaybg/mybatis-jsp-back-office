<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="form-horizontal underline top_well underline" id="custDiValDetailForm">
<br>
	<div class="row">
		<!-- 식별항목 -->
		<ifvm:inputNew type="select" id="fieldCd"  names="fieldCd"  label="L02757" labelClass="3" conClass="6" />
	</div>
	<div class="row">
		<!-- 순번 -->
		<ifvm:inputNew type="text" id="seq" names="seq"  label="M00478" labelClass="3" conClass="6"/>
	</div>
	
	<br>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="saveDiValBtn" objCode="custDiValPopSave_OBJ">
		<spring:message code="L01695" />
	</button> 
	<button class="btn btn-sm btn_gray"  id="closeDiValBtn" objCode="custDiValPopClose_OBJ">
		<spring:message code="L00941" />
	</button> 
</div>
<script type="text/javascript">
var custDiValPop;

var custDiValDetailPop = function(){
	var validation = $("#custDiValDetailForm").ifvValidation();
	var inputField = $("#custDiValDetailForm input");
	var selectField =$("#custDiValDetailForm select");
	 $("#score").ifvNumberOnly();
 	this.isNew = !$.fn.ifvmIsNotEmpty(diValRid) || diValRid === 'null', 
	this.textField =[],
	this.selectField =[],
	this.init = function(){
 		this.getCustDiValDetail(this.isNew);
		this.action();
	},
	this.save = function(){
		this.getField()
		var url = this.isNew ? '<ifvm:action name="saveCustDiValDetail"/>' : '<ifvm:action name="modifyCustDiValDetail"/>';
		$.ifvSyncPostJSON(url,this.getFieldVal(),function(result){
			this.afterSave(result)
		}.bind(this), function(result){this.afterSave(result)}.bind(this));

	},
	this.close = function(){
		custDiValDetailPopupContainer._destroy();
	},
	this.getField = function(){
		for(var i=0;i<inputField.length; i++){this.textField[i] = inputField[i].id;}
		for(var i=0;i<selectField.length; i++){this.selectField[i] = selectField[i].id;	}
	},
	this.setSelectField = function(values) {
    	var fieldCd = ( values && values.fieldCd ) ? values.fieldCd : null;
        $.fn.ifvmSetSelectOptionCommCodeSync("fieldCd", "LOY_CUST_DI_TYPE_CD", fieldCd, "certTypeCd", true);
    },
	this.getCustDiValDetail = function (){
    	if(!this.isNew){
    		$.ifvSyncPostJSON('<ifvm:action name="getCustDiValDetail"/>', {rid : diValRid, ridCustDi : custDiRid}, function(result){
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
        	}.bind(this), function(result){this.afterSave(result)}.bind(this));
    	}else{
    		this.setSelectField();
    		$.ifvSyncPostJSON('<ifvm:action name="getMaxSeq"/>', {ridCustDi : custDiRid}, function(result){
    			$("#seq").val(result.seq + 1)
    		});
    	}
	},
	this.getFieldVal = function(){
		if(validation.confirm()){
			var data = {}
			this.textField.forEach(function(a){
				if(a == "seq"){ 
					if($("#"+a).val() == "") {
						data[a] = '1' 
					}else{
						data[a] = $("#"+a).val()
					}
				} else if(a == "score"){
					var score = parseInt($("#score").val().replace(/,/g,""));
					data[a] = score
				}
				else data[a] = $("#"+a).val()
			});
			this.selectField.forEach(function(b){
				data[b] = $("#"+b).val()
			});
			data['rid'] = diValRid;
			data['ridCustDi'] = custDiRid;
			return data;
		}
	},
	this.afterSave = function(result){
		if(result.success){
			if(result.message) alert(result.message);
			else alert('<spring:message code="L00076"/>');
			this.close();
			custDiValList._doAjax();
		}else{
			if(result.message) alert(result.message);
			else alert('<spring:message code="M02248"/>');
		}
	},
	this.action = function() {
        $("#saveDiValBtn").click(function() {
            this.save();
        }.bind(this));

        $("#closeDiValBtn").click(function() {
        	this.close();
        }.bind(this));
    }
}

$(document).ready(function(){
	custDiValPop = new custDiValDetailPop();
	custDiValPop.init();

});

</script>