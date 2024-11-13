<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="O00112" /></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<ifvm:inputNew type="button" btnType="check" text="L00125" id="couponbtnSave" objCode="offerCouponExtAttrSave_OBJ"/>
	</div>
</div>
	<div id="CouponExtAttrDetail">
		<div class="form-horizontal underline top_well">
			<div class="row">
				<div class="col-xs-12">
					<ifvm:inputNew type="text" id="callApiUrl" label="O00149" labelClass="1" conClass="9" maxLength="300"/>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-6">
					<ifvm:inputNew type="select" id="callMethod" names="callMethod" label="O00150" labelClass="2" conClass="6" text="get|post" values="get|post" checkIndex="1"/>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="authKey" label="O00151" labelClass="2" conClass="6" maxLength="100"/>
				</div>
			</div>	
			
			<div class="row">
				<div class="col-xs-12">
					<ifvm:inputNew type="text" id="par1Name" label="O00152" labelClass="1" conClass="3" maxLength="30"/>
					<div style="float: left">=</div>
					<ifvm:inputNew type="select" id="par1ValType" names="par1ValType" conClass="3"/>
					<div style="display:none;" id="par1Valselect"><ifvm:inputNew type="select" id="par1Val" names="par1Val" conClass="3"/></div>
					<div style="display:none;" id="par1Valtext"><ifvm:inputNew type="text" id="par1ValText" conClass="3"/></div>
					<div style="display:none;" id="par1ValselectBlank"><ifvm:inputNew type="select" id="par1selectBlank" names="par1selectBlank" conClass="3"/></div>
					</div>	
			</div>
			
			<div class="row">
				<div class="col-xs-12">
					<ifvm:inputNew type="text" id="par2Name" label="O00153" labelClass="1" conClass="3" maxLength="30"/>
					<div style="float: left">=</div>
					<ifvm:inputNew type="select" id="par2ValType" names="par2ValType" conClass="3"/>
					<div style="display:none;" id="par2Valselect"><ifvm:inputNew type="select" id="par2Val" names="par2Val" conClass="3"/></div>
					<div style="display:none;" id="par2Valtext"><ifvm:inputNew type="text" id="par2ValText" conClass="3"/></div>
					<div style="display:none;" id="par2ValselectBlank"><ifvm:inputNew type="select" id="par2selectBlank" names="par2selectBlank" conClass="3"/></div>
				</div>
			</div>	
			
			<div class="row">
				<div class="col-xs-12">
					<ifvm:inputNew type="text" id="par3Name" label="O00154" labelClass="1" conClass="3" maxLength="30"/>
					<div style="float: left">=</div>
					<ifvm:inputNew type="select" id="par3ValType" names="par3ValType" conClass="3"/>
					<div style="display:none;" id="par3Valselect"><ifvm:inputNew type="select" id="par3Val" names="par3Val" conClass="3"/></div>
					<div style="display:none;" id="par3Valtext"><ifvm:inputNew type="text" id="par3ValText" conClass="3"/></div>
			    	<div style="display:none;" id="par3ValselectBlank"><ifvm:inputNew type="select" id="par3selectBlank" names="par3selectBlank" conClass="3"/></div>
				</div>	
			</div>
			
			<div class="row">
				<div class="col-xs-12">
					<ifvm:inputNew type="text" id="par4Name" label="O00155" labelClass="1" conClass="3" maxLength="30"/>
					<div style="float: left">=</div>
					<ifvm:inputNew type="select" id="par4ValType" names="par4ValType" conClass="3"/>
				
					<div style="display:none;" id="par4Valselect"><ifvm:inputNew type="select" id="par4Val" names="par4Val" conClass="3"/></div>
					<div style="display:none;" id="par4Valtext"><ifvm:inputNew type="text" id="par4ValText" conClass="3"/></div>
					<div style="display:none;" id="par4ValselectBlank"><ifvm:inputNew type="select" id="par4selectBlank" names="par4selectBlank" conClass="3"/></div>
					</div>
			</div>
				
			<div class="row">
				<div class="col-xs-12">
					<ifvm:inputNew type="text" id="par5Name" label="O00156" labelClass="1" conClass="3" maxLength="30"/>
					<div style="float: left">=</div>
					<ifvm:inputNew type="select" id="par5ValType" names="par5ValType" conClass="3"/>
					<div style="display:none;" id="par5Valselect"><ifvm:inputNew type="select" id="par5Val" names="par5Val" conClass="3"/></div>
					<div style="display:none;" id="par5Valtext"><ifvm:inputNew type="text" id="par5ValText" conClass="3"/></div>
					<div style="display:none;" id="par5ValselectBlank"><ifvm:inputNew type="select" id="par5selectBlank" names="par5selectBlank" conClass="3"/></div>
				</div>				
			</div>			
			</div>	
		</div>	
			
<script type="text/javascript">

var CouponExtAttrDetail = function () {
    var _rid = null;
	var ofrRid= ifvGlobal["offerRid"];
	var cpnRid= null;
	// 변경이력 검사용
	var _loadedData = {};

    var _formId = "CouponExtAttrDetail";
	
    this.setRid = function (rid) {
    	 // ifvGlobal["couponRid"] = rid;
        _rid = rid;
    },
    this.getRid = function () {
    	
        return _rid;
    },
    // 파라미터에 rid 존재 유무에 따라 신규인지 아닌지 판별
    this.isNew = false,
    // 유효성 검사 초기화
    this.validation = $("#" + _formId).ifvValidation(),
    this.fields = $.ifvGetFields(_formId),
    this.paramValueFields = ["par1Val", "par2Val", "par3Val","par4Val","par5Val"],
    this.optionFields = [
        { fieldName: "callMethod", commCode: "LOY_CPN_CALL_METHOD_TYPE"},
        { fieldName: "par1ValType", commCode: "LOY_CPN_API_PAR_TYPE", isFirstLowBlank: true},
        { fieldName: "par1Val", commCode: "LOY_CPN_API_VAL_TYPE", isFirstLowBlank: true},
        { fieldName: "par2ValType", commCode: "LOY_CPN_API_PAR_TYPE", isFirstLowBlank: true },
        { fieldName: "par2Val", commCode: "LOY_CPN_API_VAL_TYPE", isFirstLowBlank: true},
        { fieldName: "par3Val", commCode: "LOY_CPN_API_VAL_TYPE", isFirstLowBlank: true},
        { fieldName: "par4Val", commCode: "LOY_CPN_API_VAL_TYPE", isFirstLowBlank: true},
        { fieldName: "par5Val", commCode: "LOY_CPN_API_VAL_TYPE", isFirstLowBlank: true},
        { fieldName: "par3ValType", commCode: "LOY_CPN_API_PAR_TYPE", isFirstLowBlank: true },
        { fieldName: "par4ValType", commCode: "LOY_CPN_API_PAR_TYPE", isFirstLowBlank: true },
        { fieldName: "par5ValType", commCode: "LOY_CPN_API_PAR_TYPE", isFirstLowBlank: true },
    ],
    /* Form 데이터 로드 */
    this.formDataLoad = function () {
    	
        var _callback = function (result) {
        	
            if ($.fn.ifvmIsNotEmpty(result)) {
                this.setRid(result.rid);
                this.isNew = $.fn.ifvmIsNotEmpty(this.getRid()) ? false : true;
                
             	// 필드의 데이터 로드
				_loadedData = $.extend(true, {}, result);
							
                $.ifvLoadFormData(result, this.fields, this.optionFields);
             
                if($("#par1ValType").val()=="FIX"){
		           	$("#par1ValText").val(_loadedData.par1Val);
		         }
                
                if($("#par2ValType").val()=="FIX"){
		           	$("#par2ValText").val(_loadedData.par2Val);
		         }
                
                if($("#par3ValType").val()=="FIX"){
		           	$("#par3ValText").val(_loadedData.par3Val);
		         }
                
                if($("#par4ValType").val()=="FIX"){
		           	$("#par4ValText").val(_loadedData.par4Val);
		         }
                
                if($("#par5ValType").val()=="FIX"){
		           	$("#par5ValText").val(_loadedData.par5Val);
		         }
           }else {
                this.isNew = true;
                // 필드 데이터 초기화
                $.ifvInitFields(this.fields);
            }
        }
        
        $.ifvSyncPostJSON('<ifvm:action name="getCouponExtAttr"/>', {ridCpn:cpnRid,ridOfr:ofrRid}, _callback.bind(this));
    },
     /* 버튼 세팅 */
    this.setButtons = function () {
    	
        $("#couponbtnSave").click(function () {
        	if(cpnRid==null){
        		alert("쿠폰 정책 입력 후 저장 가능합니다.");
        	}else{
            	this.saveAction();
        	}
        }.bind(this));
       
   },
    /* 메뉴 세팅 */
    this.setMenu = function () {
        $.ifvmLnbSetting('offerListNew');
    },
    /* Form 데이터 제출 */
    this.onSubmit = function () {

        var _submitUrl = this.isNew ? '<ifvm:action name="insertCpnAttr"/>' : '<ifvm:action name="updateCpnAttr"/>';
        
        /* submit을 위한 Form 데이터 파라미터 세팅 */
        var _setSubmitParams = function () {
        	var vObj = {};

            var vObj = $.ifvGetFieldData(this.fields, this.optionFields);
            
    		this.paramValueFields.forEach(function(vf) {
    			var vfVal = $('#' + vf+"Type").val();					
    				if(vfVal=="FIX"){
   						vObj[vf] = $('#' + vf+"Text").val();
   					}else{
   						vObj[vf] = $('#' + vf).val();
   					}
    		});

            if (!this.isNew) vObj['rid'] = this.getRid(); 
            						
           
            if (this.isNew)  vObj['ridCpn'] = cpnRid;
          							vObj['ridOfr'] = ofrRid;
            
            return vObj;
        }
        
        /* 제출 후 알럿창 */
        var _afterSubmit = function () {
           
        	alert('<spring:message code="L00127"/>');
        	  this.isNew=false;
        };
        
        $.ifvSyncPostJSON(_submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));
    },
    /* 저장 버튼클릭 시 확인 */
    this.saveAction = function () {
        if (this.validation.confirm()) this.onSubmit();
    },this.initField=function(){
 		/* 초기 세팅 */   	
     	this.paramValueFields.forEach(function(vf) {
    			var vfVal = $('#' + vf+"Type").val();					
    				if(vfVal=="FIX"){
    					$('#' + vf+"text").show();
    			  		$('#' + vf+"select").hide();
    			  		$('#' + vf+"selectBlank").hide();
   					}else if(vfVal==""){
   						$('#' + vf+"text").hide();
   						$('#' + vf+"select").hide();
   						$('#' + vf+"selectBlank").show();
   					}else{
   						$('#' + vf+"select").show();
   						$('#' + vf+"text").hide();
   						$('#' + vf+"selectBlank").hide();
   					}
    		});
    	

       },this.initFieldEvt = function (){
    		/* 동적 change */   
    	   $.each(this.paramValueFields, function(i,vf) {
    	 
    	      	$('#'+vf+'Type').on('change', function() {
    	      		var vfVal = $('#' + vf+"Type").val();
    	      		if(vfVal=="FIX"){
    	                  $('#' + vf+"text").show();
    	                  $('#' + vf+"select").hide();
    	                  $('#' + vf+"selectBlank").hide();
    				}else if (vfVal==""){
    					$('#' + vf+"text").hide();
  	                  	$('#' + vf+"select").hide();
  	                  	$('#' + vf+"selectBlank").show();
    				}else{
    			     	$('#' + vf+"select").show();
    					$('#' + vf+"text").hide();
  	                   	$('#' + vf+"selectBlank").hide();
    				}
    	      });
    	});
    		

    	
    },this.couponChk= function(){
    	/* 쿠폰 발행된 상태인지 체크 */   
    	$.ifvSyncPostJSON('<ifvm:action name="getCouponChk"/>',{
    		ridOfr : ofrRid
    	},function(result) {
    		if(($.fn.ifvmIsNotEmpty(result))){
    			cpnRid=result.ridCpn;
    		}
     	},function(result){
    		
    	});
    	
    },
    	/* 페이지 초기화 */
    this.init = function () {
		
		$.ifvSetSelectOptions(this.optionFields);
		this.couponChk();
		this.initFieldEvt();
		this.formDataLoad();
		this.initField();
	     this.setMenu();
        this.setButtons();
    }
}

$(document).ready(function(){
		var CouponAttrDtl = new CouponExtAttrDetail();
		CouponAttrDtl.init();
});


</script>