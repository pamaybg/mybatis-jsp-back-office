<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<style>
   .helpBtn {
      background-image: url("/resources/images/icons/btn_help.png");
      background-repeat:no-repeat;
       background-position:center center;
       padding-left: 30px;
       vertical-align: middle;
       width: 17px;
       height: 17px;
       line-height: 17px;
   }
</style>

<script>
/* effStartDayCnt = null;
effStartDate = null;
effStartDayCnt = null; */
	/* 채널 조회 팝업  */
	function btnChnlPop(){
	    $.fn.ifvmPopupOpen('popupContainer', null,
	            '<ifvm:url name="chnlPop"/>',
	            '<spring:message code="L00126"/>', 860, true, true);
	}
    /* 오퍼 그룹 조회 팝업 */
    function btnOfrgrpPop(){
        /* $.fn.ifvmPopupOpen('popupContainer', null,
                '<ifvm:url name="ofrgrpPop"/>',
                '<spring:message code="O00005"/>', 860, true, true); */
    }
	var OfferDetail = function (rid) {
	    // 프로그램 RID
	    var _rid = rid;
	    var _formId = 'offerDetail';

	    this.setRid = function (rid) {
	        ifvGlobal["offerRid"] = rid;
	        _rid = rid;
	    },
	    this.getRid = function () {
	        return _rid;
	    },
	    // 파라미터에 rid 존재 유무에 따라 신규인지 아닌지 판별
	    this.isNew = !$.fn.ifvmIsNotEmpty(this.getRid()) || this.getRid() === 'null',
	    // 유효성 검사 초기화
	    this.validation = $("#"+ _formId ).ifvValidation(),
	    this.fields = $.ifvGetFields(_formId),
	    this.priceFields = ["feeAmt", "ofrCostAmt", "feeShareBaseAmt","ofrValAmt"],
	    this.optionFields = [
	        { fieldName: "statCd", commCode: "LOY_OFR_STAT_TYPE"},
	        { fieldName: "ofrCtg", commCode: "LOY_OFR_MST_TYPE"},
	        { fieldName: "ofrType", commCode: "LOY_OFR_TYPE" },
	        { fieldName: "ofrSubType", commCode: "LOY_OFR_SUB_TYPE", parField: "ofrType" },
	        { fieldName: "ofrValType", commCode: "LOY_OFR_VAL_TYPE", isFirstLowBlank: true },
	        { fieldName: "settleType", commCode: "LOY_OFR_SETTLE_TYPE" },
	        { fieldName: "expirType", commCode: "LOY_OFR_EXPIR_TYPE", isFirstLowBlank: true },
	        { fieldName: "maxLimitTypeCd", commCode: "LOY_OFR_MAX_LIMT_TYPE_CD", isFirstLowBlank: true },
	        { fieldName: "refCd", commCode: "LOY_OFR_REF_TYPE_CD",isFirstLowBlank: true},
	        { fieldName: "effDateType", commCode: "PACT_EFF_DATE_TYPE",isFirstLowBlank: true},
	    ],
	    /* Form 데이터 로드 */
	    this.formDataLoad = function () {
	        var _callback = function (result) {
	            if ($.fn.ifvmIsNotEmpty(result)) {
	  	                // 필드의 데이터 로드
	                $.ifvLoadFormData(result, this.fields, this.optionFields);
	                $("#ofrType option[value='P']").remove();
	                //$("#ofrSubType option[value='PP']").remove();
	                this.priceFields.forEach(function(vf) { 
						var vfVal = $('#' + vf).val();						
						$('#'+ vf).val($.fn.ifvmNumberWithCommas(vfVal));
						$('#' + vf).css("text-align", "right");
					});

	            }
	            /* if(result.effStartDayCnt == 'D'){
	        		$("input:radio[id='effStrtDirectYn']").attr("checked", true);
	        	} else if(result.effStartDayCnt == 'A') {
	        		$("input:radio[id='effStartDateCntYn']").attr("checked", true);
	        		$("#effStartDateCnt").val(result.effStartDayCnt);
	        	} else if(result.effStartDayCnt == 'P') {
	        		$("input:radio[id='effStartDateYn']").attr("checked", true);
	        		$("#effStartDate").val(result.effStartDate);
	        	} */
	        }

	        $.ifvSyncPostJSON('<ifvm:action name="getOfferDetail"/>', { rid: this.getRid() }, _callback.bind(this));
	        ofrValTypeChange();
	        cpnYnChange();
	        ofrTypeChange();
	        expirMmChange();
	        if($("#effDateType").val() == 'D'){
	        	$("#effStartDayCnt").attr("disabled",true);
	        	$("#effStartDate").attr("disabled",true);
	        	$("#effStartDate").val('');
	        	$("#effStartDayCnt").val('');
	    	} else if($("#effDateType").val() == 'A') {
	    		$("#effStartDayCnt").attr("disabled",false);
	    		$("#effStartDate").attr("disabled",true);
	    		$("#effStartDate").val('');
	    		/* $('#effStartDayCnt').attr("type", "number"); */
	    	} else if($("#effDateType").val() == 'P') {
	    		$("#effStartDayCnt").attr("disabled",true);
	    		$("#effStartDayCnt").val('');
	    		$("#effStartDate").attr("disabled",false);
	    		var effStartDate = $("#effStartDate");
	    		effStartDate.ifvDateChecker({ 
		    		
		    	});
	    		/* $('#effStartDayCnt').attr("type", "text");
	    		var effStartDayCnt = $("#effStartDayCnt");
	    		effStartDayCnt.ifvDateChecker({ 
		    		
		    	});*/
	    		
	    	}
	    },
	    /* 탭 초기화 */
	    this.setTabs = function () {
	        $("#tabArea").empty();
	        $("#tabArea").DrawTab({
	            item: items
	            /* [
	            {
	                label: '<spring:message code="O00110"/>',
	                href: '<ifvm:url name="offerCouponDetail"/>'
	            }
	            , {
	                label: '<spring:message code="O00003"/>',
	                href: '<ifvm:url name="offerJoinChnlList"/>'
	            }, {
	                label: '<spring:message code="O00004"/>',
	                href: '<ifvm:url name="offerJoinProdList"/>'
	            }
	            , {
                    label: '<spring:message code="O00161"/>',
                    href: '<ifvm:url name="offerJoinProdNotList"/>'
                }
	            ,{
                    label: '<spring:message code="O00001"/>',
                    href: '<ifvm:url name="offerJoinPgmList"/>'
                }
	            , {
	                label: '<spring:message code="O00113"/>',
	                href: '<ifvm:url name="offerCouponStatus"/>'
	            }

	             
	            ]*/
	        });
	    },

	    /* 버튼 세팅 */
	    this.setButtons = function () {
	        $("#btnSave").click(function () {
	            this.saveAction();
	        }.bind(this));
	
	        $("#btnList").click(function () {
	            qtjs.href('<ifvm:url name="offerList"/>');
	        });
			
	    },
	    /* 메뉴 세팅 */
	    this.setMenu = function () {
	        $.ifvmLnbSetting('offerList');
	    },
	    /* Form 데이터 제출 */
	    this.onSubmit = function () {
	        var resultRid = null ;
	        var _submitUrl = this.isNew ? '<ifvm:action name="addOffer"/>' : '<ifvm:action name="editOffer"/>';
	        
	        /* submit을 위한 Form 데이터 파라미터 세팅 */
	        var _setSubmitParams = function () {
	
	            var vObj = $.ifvGetFieldData(this.fields, this.optionFields);
	            $("#ofrType option[value='P']").remove();
	            //$("#ofrSubType option[value='PP']").remove();
	            if (!this.isNew) {
	                vObj['rid'] = this.getRid();
	                resultRid = this.getRid();
	            }
	            
				this.priceFields.forEach(function(vf) { 
					vObj[vf] = parseInt(vObj[vf].replace(/,/g,""));
				});
				/* vObj.effStartDayCnt = effStartDayCnt
				vObj.effStartDate = effStartDate;
				vObj.effStartDayCnt = effStartDayCnt; */
	            
	            return vObj;
	        }
	        
	        /* 제출 후 알럿창 */
	        var _afterSubmit = function (result) {
	            resultRid = result.message;
	            alert('<spring:message code="L00127"/>');
	            if (this.isNew)  {
	                qtjs.href('<ifvm:url name="offerDetail"/>'+ '?rid=' + resultRid  );
	            }
	        };
	        $.ifvSyncPostJSON(_submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));

	    },
	    this.getOfrCpnCnt = function(){ 
			$.ifvSyncPostJSON('<ifvm:action name="getOfrCpnCnt"/>',{rid : $.ifvGetParams().rid}, function(result){
				$("#cpnCnt").val(result);
			}.bind(this));
		},
	    /* 저장 버튼클릭 시 확인 */
	    this.saveAction = function () {
	   		if($("#statCd").val()=='A' && $("#cpnYn").is(":checked")) {
	   			this.getOfrCpnCnt();
	   			if($("#cpnCnt").val()=='0') {
	   				alert("활성된 쿠폰오퍼는 쿠폰정책 저장이 필요합니다.");
	   				return;
	   			}
	   		}
	    	
	    	
	    	if($("#cpnYn").is(":checked")){
		    	if($("#ofrSubType").val()=='DD' || $("#ofrSubType").val()=='D5' || $("#ofrSubType").val()=='D6') {
		    		if($("#ofrValType").val()=='' || $("#ofrValAmt").val()=='') {
		    			alert("쿠폰형(금액할인,무료배송)의 가치 수량 항목은 필수입니다.");
		    			return;
		    		}
		    	}
	    	}
	    	
	    	if($("#cpnYn").is(":checked")){
	        	/* if($("#ofrValType").val()==""){
	        		alert("쿠폰형일경우 오퍼 가치 수량은 필수입니다.");
	        		$("#ofrValType").focus();
	        		return;
	        	}else if($("#ofrValAmt").val()==""){
	        		alert("쿠폰형일경우 오퍼 가치 수량은 필수입니다.");
        			$("#ofrValAmt").focus();
        			return;	
	        	}         */			        	
	        }else{
	        	$("#ofrValAmt").attr("required",false);
	        }
	    	/* if($("#ofrType").val()=='P') {
	    		if($("#expirType").val()!='EOY' && $("#expirType").val()!='EOM') {
	    			alert("포인트일때는 End-Of-Year또는 End-Of-Month만 가능합니다.");
	    			return;
	    		} 
	    	}  */
	    	/* if($('input:radio[id="effStrtDirectYn"]').is(":checked") == true){
	    		effStartDayCnt = "D";
	    	} else if($('input:radio[id="effStartDateCntYn"]').is(":checked") == true) {
	    		effStartDayCnt = $("#effStartDateCnt").val();
	    		effStartDate = null;
	    		effStartDayCnt = "A";
	    	} else if($('input:radio[id="effStartDateYn"]').is(":checked") == true) {
	    		effStartDate = $("#effStartDate").val();
	    		effStartDayCnt = null;
	    		effStartDayCnt = "P";
	    	} */
	    	
	        if (this.validation.confirm()) this.onSubmit();
	    },
	    this.setCalendar = function(){
	    	var validStartDate = $("#validStartDate");
	    	var validEndDate = $("#validEndDate");
	    	validEndDate.val('2090-12-31');
	    	validStartDate.ifvDateChecker({
	    		maxDate : validEndDate
	    	});
	    	validEndDate.ifvDateChecker({
	    		minDate : validStartDate
	    	});
	    },
        this.setCommaKeyup = function () {
			this.priceFields.forEach(function(vf) { 
				$('#' + vf).keyup(function() {
					var vfVal = $('#' + vf).val();						
					$('#'+ vf).val($.fn.ifvmNumberWithCommas(vfVal));
					$('#' + vf).css("text-align", "right");
				});
			})
        },
	    /* 페이지 초기화 */
	    this.init = function () {
	
	        if (!this.isNew) {
	            this.formDataLoad();
	            this.setTabs();
	        } else {
	            $.ifvSetSelectOptions(this.optionFields);
			
	            $("#ofrType option[value='P']").remove();
	            //$("#ofrSubType option[value='PP']").remove();     
	            $("#ofrType").val('D');
	            $("#ofrType").trigger("change");
	            $("#statCd").attr('disabled',true);
	            $("#cpnYn").attr('checked',true);
	            this.setTabs();
	            $("#ofrCtg").val('M');
	        }
	        
	        this.setCommaKeyup();
			this.setCalendar();
	        this.setMenu();
	        this.setButtons();
	    }
	}
	

	function setCalendar() {
		 var startDate = $('#validStartDate');
		 var endDate = $('#validEndDate');
		 //오늘날짜
		 startDate.val($.ifvGetTodayDate());
		 //오늘부터 한달 뒤
		 endDate.val($.ifvGetNewDate('m', +99).newDateS);

		 startDate.ifvDateChecker({
		  maxDate : endDate
		 });

		 endDate.ifvDateChecker({
		  minDate : startDate
		 });
	}
	
	function ofrValTypeChange() {
		if($("#ofrValType").val()=='R') {
			$("#info").text("%");
			$("#ofrValAmt").attr("disabled",false);
		} else if($("#ofrValType").val()=='F') {
			$("#info").text("원");
			$("#ofrValAmt").attr("disabled",false);
		} else if($("#ofrValType").val()=='A') {
			$("#info").text("");
			$("#ofrValAmt").val("");
			$("#ofrValAmt").attr("disabled",true);
		} else if($("#ofrValType").val()=='B') {
			$("#info").text("원");
			$("#ofrValAmt").attr("disabled",false);
		} 
	}
	
	function effStartDateChange() {
		if($("#effDateType").val() == 'D'){
        	$("#effStartDayCnt").attr("disabled",true);
        	$("#effStartDate").attr("disabled",true);
        	$("#effStartDate").val('');
        	$("#effStartDayCnt").val('');
    	} else if($("#effDateType").val() == 'A') {
    		$("#effStartDayCnt").attr("disabled",false);
    		$("#effStartDate").attr("disabled",true);
    		$("#effStartDate").val('');
    		/* $('#effStartDayCnt').attr("type", "number"); */
    	} else if($("#effDateType").val() == 'P') {
    		$("#effStartDayCnt").attr("disabled",true);
    		$("#effStartDayCnt").val('');
    		$("#effStartDate").attr("disabled",false);
    		var effStartDate = $("#effStartDate");
    		effStartDate.ifvDateChecker({ 
	    		
	    	});
    		/* $('#effStartDayCnt').attr("type", "text");
    		var effStartDayCnt = $("#effStartDayCnt");
    		effStartDayCnt.ifvDateChecker({ 
	    		
	    	});*/
    		
    	}
	}
	
	function cpnYnChange() {
		if($("#cpnYn").prop("checked") == true){
			$("#expirType").val('');
			$("#expirType").attr("disabled",true);
			$("#expirMM").val('');
			$("#expirMM").attr("disabled",true);
			$("#effDateType").val('');
			$("#effDateType").attr("disabled",true);
// 			$($('.tab-list').children()[0]).show()
// 			$($('.tab-list').children()[5]).show()
		} else {
			$("#expirType").attr("disabled",false);
			$("#expirMM").attr("disabled",false);
			$("#effDateType").attr("disabled",false);
// 			$($('.tab-list').children()[0]).hide()
// 			$($('.tab-list').children()[5]).hide()
		}
	}
	
	function ofrTypeChange() {
		if($("#ofrType").val()=='P') {
	    	$("#ofrValType").val("");
    		$("#ofrValAmt").val("");
    		$("#ofrValType").attr("disabled",true);
    		$("#ofrValAmt").attr("disabled",true);
    		$("#cpnYn").attr("disabled",true);
    	} else {
    		$("#ofrValType").attr("disabled",false);
    		$("#ofrValAmt").attr("disabled",false);
    		$("#cpnYn").attr("disabled",false);
    	}	
	}
	
	function setChannelCalendar() {
	    var effStartDate = $("#effStartDate");

	    effStartDate.ifvDateChecker({});
	}
	
 	
	function checkOnlyOne(element){ // vocYn/empYn 체크박스 중 하나만 선택 처리 함수
		var checkedId = element.target.id;
	
		if((checkedId=='empYn') && ($("#empYn").is(":checked"))){
			if($("#vocYn").is(":checked")) {
				$('#vocYn').attr('checked', false);	
			}
		} else if((checkedId=='vocYn') && ($("#vocYn").is(":checked"))){
			if($("#empYn").is(":checked")) {
				$('#empYn').attr('checked', false);	
			}
		}
		// 일단 모두 체크 제거
		/* var checkBoxes = $('.vocAndEmpChk');
		var i;
		for(i=0; i<checkBoxes.length; i++) {
		    checkBoxes[i].checked = false;   
		}
		// checkedId것만 다시 체크
		if($(checkedId).is(":checked")) {
			$('#'+checkedId).attr('checked', true);
		} else {
			$('#'+checkedId).attr('checked', false);	
		} */
	}
	
	function ofrStatSaveValid() {
		if($("#statCd").val()!='W') {
			//오퍼 마스터
			$("#btnSave").attr('disabled',true);
			
			//쿠폰 정책
			$("#couponbtnSave").attr('disabled',true);
			$("#initCoupon").attr('disabled',true);
			
			//사용 가능 채널
			$("#btnAddOfferJoinChnl").attr('disabled',true);
			$("#btnRemoveOfferJoinChnl").attr('disabled',true);
			$("#btnRemoveOfferJoinAllChnl").attr('disabled',true);
			$("#btnUpload").attr('disabled',true);
			
			//사용 가능 상품
			$("#btnAddOfferJoinProd").attr('disabled',true);
			$("#btnRemoveOfferJoinProd").attr('disabled',true);
			$("#btnRemoveOfferJoinAllProd").attr('disabled',true);
			$("#btnUpload").attr('disabled',true);

			//사용 불가능 상품
			$("#btnAddOfferJoinProd").attr('disabled',true);
			$("#btnRemoveOfferJoinProd").attr('disabled',true);
			$("#btnRemoveOfferJoinAllProd").attr('disabled',true);
			$("#btnUpload").attr('disabled',true);
			
			//프로그램
			$("#btnAddOfferJoinPgm").attr('disabled',true);
			$("#btnRemoveOfferJoinPgm").attr('disabled',true);
			
		} 
	}
	
function expirMmChange() {
	if($("#expirType").val()=='DAY') {
			 if($("#expirMM").val()=='0') {
		 		$("#info3").text("(유효시작일로부터 당일까지)");
		 	}
			 	else $("#info3").text("(유효시작일로부터 "+ $("#expirMM").val()+"일 후 까지)");
			} else if($("#expirType").val()=='MONTH') {
				if($("#expirMM").val()=='0') {
			 		$("#info3").text("(유효시작일로부터 당월까지)");
			 	}
				else $("#info3").text("(유효시작일로부터 "+$("#expirMM").val()+"개월 후 까지)");
			} else if($("#expirType").val()=='YEAR') {
				if($("#expirMM").val()=='0') {
			 		$("#info3").text("(유효시작일로부터 당일까지)");
			 	}
				else $("#info3").text("(유효시작일로부터 "+ $("#expirMM").val()+"년 후 까지)");
			} else if($("#expirType").val()=='EOM') {
				if($("#expirMM").val()=='0') {
			 		$("#info3").text("(유효시작일로부터 당월 말일까지)");
			 	}
				else $("#info3").text("(유효시작일로부터 "+ $("#expirMM").val()+"개월 후 말일 까지)");
			} else if($("#expirType").val()=='EOY') {
				if($("#expirMM").val()=='0') {
			 		$("#info3").text("(유효시작일로부터 금년 12월31일까지)");
			 	}
				else $("#info3").text("(유효시작일로부터 "+ $("#expirMM").val()+"년 후 12월31일까지)");
			} else if($("#expirType").val()=='NA') {
				$("#info3").text('');
			} else if($("#expirType").val()=='FIX') {
				$("#info3").text('');
			} 
		 
	
}

function expirTypeChange() {
	$("#info3").text('');
	$("#expirMM").val('');
}
	
	
	$(document).ready(function () {
		
		setChannelCalendar();
		$("#hqSettleRate").val("100");
		setCalendar();
	    var urlParams = $.ifvGetParams();
	    var _rid = urlParams.rid;
    	ifvGlobal["offerRid"] = _rid;offerGrid
   
	    var offerGrid = new OfferDetail(_rid);
     	ifvGlobal["offerGrid"]=offerGrid;
	    offerGrid.init();
	    
	    
	    //본사 100% -> 본사부담율 100% 처리
	    $("#settleType").change(function(){
	    	if($("#settleType").val() == 'A') {
		    	$("#hqSettleRate").val(100);
		    }else{
		    	$("#hqSettleRate").val(0);
		    }
	    });
	    
	    $('#ofrType').change(function(){
	    	ofrTypeChange();
	    	if($("#ofrType").val()=='D' || $("#ofrType").val()=='G') {
	    		$("#cpnYn").attr("checked",true);
	    	} else {
	    		$("#cpnYn").attr("checked",false);
	    	}
		});

	    $('#ofrValType').change(function(){
	    	ofrValTypeChange();

		});
	    
	    $('#effDateType').change(function(){
	    	effStartDateChange();

		});
	    $('#cpnYn').change(function(){
	    	cpnYnChange();

		});
	    
	    // Voc지급/임직원지급 checkBox 클릭 시 : 택1
	    $('.vocAndEmpChk').change(function(args){ // change로 할지 click 으로 할지 이따 판단 
			checkOnlyOne(args);	    	
	    });
	    
	    ofrStatSaveValid();
	    
	$("#expirMM").change(function(){
	   		
		expirMmChange();
	});
   	
   	$("#expirType").change(function(){
   		
   		expirTypeChange();
   	});
   	
   	$('.helpBtn').setupHelpMessage();
	    
	});
</script>

<div class="page-title">
	<h1>
		<spring:message code="O00014" />
		&gt; <spring:message code="오퍼&쿠폰 상세" />
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7"> <!-- 기본정보 및 유형 -->
			<span><spring:message code="O00041"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="check" text="L00125" id="btnSave" objCode="offerDetailSave_OBJ"/>
			<button class="btn btn-sm" id="btnList" objCode="offerDetailList_OBJ">
				<spring:message code="M00002" />
			</button>
		</div>
	</div>
	<div id="offerDetail">
		<div class="form-horizontal underline top_well">
			<div class="col-xs-12">
				<!-- 오퍼 번호 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="select" label="분류/번호" labelClass="2" names="ofrCtg" id="ofrCtg" conClass="4" disabled="true" />
					<ifvm:inputNew type="text" id="ofrNo"  conClass="4" disabled="true" />
				</div>
				<!-- 오퍼 명 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="ofrNm" label="O00007" labelClass="2" conClass="8" required="true"/>
				</div>
			</div>
			<div class="row ">
				<!-- 생성일 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="createDate" label="O00013" labelClass="2" conClass="8" disabled="true" />
				</div>
				<!-- 생성자 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="createBy" label="O00012" labelClass="2" conClass="8" disabled="true" />
				</div>
			</div>
			<div class="row ">
				<!-- 오퍼적용가능기간 -->
				<div class="col-xs-6">
				    <ifvm:inputNew type="dateTerm" startDto="validStartDate" endDto="validEndDate" startId="validStartDate" endId="validEndDate" required="true" label="O00017" labelClass="2" conClass="8" />
				</div>
				<!-- 상태 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="select" id="statCd" names="statCd" label="O00018" labelClass="2" conClass="8" required="true"/>
				</div>
			</div>
			<div class="row ">
				<div class="col-xs-6">
                     <!-- 대유형 -->
					<ifvm:inputNew type="select" id="ofrType" names="ofrType" label="O00019" labelClass="2" conClass="8" required="true"/>
			   </div>
			         <!-- 관리/연계 코드 -->
               <div class="col-xs-6">
                    <ifvm:inputNew type="select" id="refCd" disabled="true" names="refCd" label="관리코드" labelClass="2" conClass="8" />
               </div>
			   <div class="col-xs-6">
				     <!-- 소유형 -->
				    <ifvm:inputNew type="select" id="ofrSubType" names="ofrSubType" label="O00020" labelClass="2" conClass="8" required="true"/>
				</div>
				<div class="col-xs-6">
				      <div class="col-xs-12">
				<!-- 쿠폰형 -->
                           <div class="col-xs-6">
                                <ifvm:inputNew type="checkBox" id="cpnYn" label="O00023" labelClass="4" conClass="3" />
                                <ifvm:inputNew type="hidden" id="cpnCnt" />
                            </div>
                <!-- 유료판매가능 -->
                            <div class="col-xs-6">
				                <ifvm:inputNew type="checkBox" id="feeYn" label="유료판매가능"  labelClass="3" conClass="4"  />
				            </div>
				       </div>
				</div>
			</div>
			<div class="row">
				<!-- 공급자 -->
				<div class="col-xs-6">
				        <ifvm:inputNew type="search" id="chnlNm" hidId="ridChnl" hidDto="ridChnl" btnFunc="btnChnlPop" dto="chnlNm" names="chnlNm" label="O00021" labelClass="2" conClass="8" />
				</div>
                <!-- 유료판매가격 -->
				<div class="col-xs-6">
	<%--                     <div style="float: left;padding-top: 5px;padding-left: 2px;padding-right: 3px; font-size: 13px;"><spring:message code="O00159" /></div> --%>
                    <div class="col-xs-12">
                        <div class="col-xs-6">
    	                    <ifvm:inputNew type="text" id="feeAmt" label="유료판매가격"  labelClass="4" conClass="4" /> 
    	                    <div style="float: left; padding-top: 5px;">(원)</div>
                                </div>

	                <!-- 유료매출할당기준액 -->
	<%--                    <div style="float: left; padding-top: 5px; padding-left: 52px; font-size: 13px;"><spring:message code="O00025" /></div> --%>
			                    <div class="col-xs-6">
				                   <ifvm:inputNew type="text" id="feeShareBaseAmt" label="유료판매매출"  labelClass="3" conClass="4"/>
				                   <div style="float: left; padding-top: 5px;">(원)</div>
				                </div>
	                </div>
				</div>
			</div>
			<!-- 설명 -->
			<div class="rows">
			        <%-- <div class="col-xs-2">
                <div style="float: left;padding-top: 5px;padding-left: 73px;padding-right: 6px; font-size: 13px;"><spring:message code="O00016" /></div>
                            <label class="col-xs-1 control-label"><spring:message code="O00016"/></label>
                    </div> --%>
					<div class="col-xs-12">
							       <ifvm:inputNew type="textarea" id="descText"  conClass="10" label="O00016" labelClass="1"  rows="4" maxLength="2000"/>
					</div>
	   		  </div>
		</div>
		<div class="half_wrap top_well">
			<!-- 가치 -->
			<div class="half_content half_left">
				<div class="page_btn_area">
					<div class="col-xs-6">
						<span> <spring:message code="O00042" /></span>
					</div>
				</div>
				<div class="form-horizontal top_well underline">
					<div class="row">
					    <div class="col-xs-12">
						<!-- 수량 -->
						<ifvm:inputNew type="select" id="ofrValType" names="ofrValType" label="O00026" labelClass="2"  conClass="3" />
						<ifvm:inputNew type="text" id="ofrValAmt" conClass="5" /><lebel id="info"></lebel> 
					   </div>
					</div>
					<div class="row">
					   <div class="col-xs-12">
						<!-- 오퍼 비용 -->
						<ifvm:inputNew type="text" id="ofrCostAmt" label="O00027" disabled="true" labelClass="2" conClass="3" /><div style="float: left; padding-top: 5px;padding-left: 3px;">(원)</div>
                        </div>
					</div>
					<%-- <div class="row">
						<!-- 선택형 오퍼 그룹 -->
                       <ifvm:inputNew type="search" id="ofrgrpNm" hidId="ridOfrgrp" label="O00028" labelClass="2" hidDto="ridOfrgrp" btnFunc="btnOfrgrpPop" dto="ofrgrpNm" names="ofrgrpNm"  conClass="8" />
					</div> --%>
				</div>
			</div>
			<!-- 정산 -->
			<div class="half_content half_right">
				<div class="page_btn_area">
					<div class="col-xs-6">
						<span> <spring:message code="O00043" /></span>
					</div>
				</div>
				<div class="form-horizontal top_well underline">
					<div class="row">
					    <div class="col-xs-12">
					          <div class="col-xs-5">
						<!-- 비용 정산 구분 -->
                    			     <ifvm:inputNew type="select" id="settleType" names="settleType" label="O00029" labelClass="5" conClass="7" required="true" />
                              </div>
                        <!-- 비용계정코드 -->
                              <div class="col-xs-7">
            					    <ifvm:inputNew type="text" id="settleRefCd" label="비용계정코드" labelClass="5" conClass="4" />
		                      </div>
					    </div>
					</div>
					<div class="row">
					     <div class="col-xs-12">
					             <div class="col-xs-5">
							<!-- 본사 비용부담율 -->
        							<ifvm:inputNew type="number" id="hqSettleRate" label="O00030" labelClass="5" conClass="6" required="true"/>
			         				<div style="float: left; padding-top: 5px;"> % </div>
		  			             </div>
		  			             <div class="col-xs-7">
		  					<!-- 유료구매매출할당(사용처) -->
        							<ifvm:inputNew type="number" id="feeSettleUseRate" label="유료판매매출 분담율" labelClass="5"  conClass="4" />
		          					<div style="float: left; padding-top: 5px;"> % </div>
					             </div>
						  </div>
					</div>
				</div>
			</div>
		</div>
		<div class="half_wrap top_well">
			<!-- Earn -->
			<div class="half_content half_left">
				<div class="page_btn_area">
					<div class="col-xs-7">
						<span> <spring:message code="O00044" /></span>
					</div>
				</div>
				<div class="form-horizontal top_well underline">
					<div class="row">
						<!-- voc대응 지급 가능 -->
						<ifvm:inputNew type="checkBox" id="vocYn" className="vocAndEmpChk" label="O00033" labelClass="2" conClass="1" />
						<ifvm:inputNew type="checkBox" id="empYn" className="vocAndEmpChk" label="임직원지급" labelClass="2" conClass="1" />
					</div>
					<div class="row">
						<!-- 유효 만료 기간 -->
						<ifvm:inputNew type="select" id="expirType" names="expirType" label="유효종료일" labelClass="2" conClass="3" />
						<ifvm:inputNew type="number" id="expirMM" conClass="3" />
						<lebel id="info3">유효시작일로부터 *일까지</lebel>
						
					</div>
					
					<div class="row" id="pactEffRow">
						<ifvm:inputNew type="select" dto="effDateType" id="effDateType" names="effDateType" label="유효시작일" labelClass="2" conClass="3" />
						<ifvm:inputNew type="number" dto="effStartDayCnt" disabled="true" id="effStartDayCnt" conClass="3" /><div id="effLabel" style="float: left; padding-top: 5px;"></div>
						<ifvm:inputNew type="date" dto="effStartDate" disabled="true" id="effStartDate" conClass="3" /><div id="effLabel" style="float: left; padding-top: 5px;"></div>
						<a>
					 	<i class="helpBtn" style="vertical-align: middle;">
							<div class="helptxt" style="display:none;"><spring:message code="프로모션 산출 오퍼의 경우에는 적용안됨(예: 구매적립). defualt : 즉시"/></div>
					    </i>
					 	</a>
						<%-- <label class="col-xs-2 control-label"><spring:message code="유효시작일"/></label>
	        			<div class="col-xs-2 control_content">
	            			<ifvm:input type="radio" names="eff"  id="effStrtDirectYn"/>즉시
	        			</div>
	        <div class="col-xs-3 control_content">
  				<div class="col-xs-2 control_content">
    				<ifvm:input type="radio" id="effStartDateCntYn" names="eff"/>
		  		</div>
		  		<label class="col-xs-7 control_label">지급일로부터</label>
			  <div class="col-xs-10 control_content">
			    <div class="col-xs-5 control_content">
			      <ifvm:input type="number" id="effStartDateCnt" names="effStartDateCnt" />
			    </div>
			    <label class="col-xs-6 control_label">일 이후</label>
			  </div>    
			</div>
	        
		 	<div class="col-xs-4 control_content">
  				<div class="col-xs-1 control_content">
    				<ifvm:input type="radio" id="effStartDateYn" names="eff"/>
		  		</div>
		  		<label class="col-xs-4 control_label">특정일</label>
			  <div class="col-xs-13 control_content">
			    <div class="col-xs-9 control_content">
			      <ifvm:input type="date" id="effStartDate" names="effStartDate"/>
			    </div>
			    <!-- <label class="col-xs-6 control_label">특정일 지정</label> -->
			    <div style="float: left; padding-top: 5px;">이후</div>
			  </div>    
			</div>  --%>
					</div>
					
				</div>
			</div>
			<!-- Use -->
			<div class="half_content half_right">
				<div class="page_btn_area">
					<div class="col-xs-7">
						<span> <spring:message code="O00045" /></span>
					</div>
				</div>
				<div class="form-horizontal top_well underline">
					<div class="row">
					    <div class="col-xs-4">
						<!--  양도/선물 가능 여부 -->
						      <ifvm:inputNew type="checkBox" id="giftYn" disabled="true" label="O00035" labelClass="4" conClass="1" />
                        </div>
                         <div class="col-xs-4">
						<!-- 사용 가능 채널 제한 -->
						      <ifvm:inputNew type="checkBox" id="useChnlLimitYn" disabled="true" label="O00036" title="사용 가능 채널 탭에 등록된 채널만 적용됩니다."  labelClass="6" conClass="1" />
                         </div>
                         <div class="col-xs-4">
						<!-- 사용 가능 상품 제한 -->
             				   <ifvm:inputNew type="checkBox" id="useProdLimitYn" disabled="true" label="O00037" title="사용 가능 상품 탭에 등록된 상품만 적용됩니다."   labelClass="6"  conClass="1" />
				         </div>
					</div>
					
					<div class="row">
					           <div class="col-xs-12">
					                  <div class="col-xs-5"> 
						                      <ifvm:inputNew type="number" id="maxAmt" nuc="true" disabled="true" label="거래당 사용한도" labelClass="5"  conClass="7" />
					                  </div>
					           </div>
					</div>
					<div class="row">
					           <div class="col-xs-12">
					                 <div class="col-xs-5"> 
						                  <ifvm:inputNew type="select" id="maxLimitTypeCd" disabled="true" names="maxLimitTypeCd" label="기간내 사용한도 " nuc="true" labelClass="5" conClass="7" />
                                     </div>
                                     <div class="col-xs-7">
						                  <ifvm:inputNew type="number" id="maxLimitAmt" disabled="true" conClass="9" />
					                 </div>
					           </div>
					</div>
				</div>
			</div>
			
	</div>

</div>

<!-- 탭 -->
<div id="tabArea"></div>

<!-- 팝업 -->
<div id="popupContainer" class="popup_container"></div>

