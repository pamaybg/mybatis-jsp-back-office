<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
var giftCheck = false;
var offerRid = null;
	var PgmPntPlcyDetail = function () {
	    
		var _rid = null;
	    var _pgmRid = ifvGlobal["pgmRid"];
		// 변경이력 검사용
		var _loadedData = {};
		var _updatedData = {};
		var _formId = "pgmPntPlcyPopValid";

	    this.setRid = function (rid) {
	        _rid = rid;
	    },
        this.getRid = function () {
            return _rid;
        },
        this.getPgmRid = function () {
            return _pgmRid;
        },
        this.isNew = false,
		this.validation = $("#" + _formId).ifvValidation(),
        this.fields = $.ifvGetFields(_formId),
        this.optionFields = [
        	{ fieldName: "pntUseGiftRange", commCode: "LOY_PNT_GIFT_MEM_POL_CD", isFirstLowBlank: false },
        	{ fieldName: "pntUseRdmSeq", commCode: "LOY_RDM_SEQ_CD", isFirstLowBlank: true },
        	{ fieldName: "pntCalcType", commCode: "LOY_CALC_TYPE" },
        	{ fieldName: "pntRoundType", commCode: "LOY_ROUND_TYPE" },
        	{ fieldName: "giftEndTypeCd", commCode: "LOY_PNT_GIFT_END_DT_TYPE_CD", isFirstLowBlank: true },
        ],
        /* Form 데이터 로드 */
        this.formDataLoad = function () {
            var _callback = function (result) {
                if ($.fn.ifvmIsNotEmpty(result)) {
                    // 일단 조회해 본 후 결과가 있다면 rid 세팅
                    this.setRid(result.rid);
                    this.isNew = $.fn.ifvmIsNotEmpty(this.getRid()) ? false : true;

                    if(result.ofrNm != null) $("#ofrNm").val(result.ofrNm);
					
					// 필드의 데이터 로드
					_loadedData = $.extend(true, {}, result);
					offerRid = result.ofrRid;
					$.ifvLoadFormData(result, this.fields, this.optionFields);
					
					if($("#pntUseGiftRange").val()=='01' || $("#pntUseGiftRange").val()=='02') {
	       				 giftCheck = true;

	       			 	}  else {
	       				 giftCheck = false;
	 
	       			 	}
					
					this.fields.valueFields.forEach(function(vf) {
						var vfVal = $('#' + vf).val();						
						$('#'+ vf).val($.fn.ifvmNumberWithCommas(vfVal));
						$('#' + vf).css("text-align", "right");
					});
					$("#ofrNm").val(result.ofrNm);
                } else {
                    this.isNew = true;
                    $.ifvInitFields(this.fields, this.optionFields);
                    $("#useMinusYn").attr("checked",true);
                }
                this.textDisabledFn();
                ;
            };
            $.ifvSyncPostJSON('<ifvm:action name="getPgmPntPlcyDetail"/>', { pgmRid: this.getPgmRid() }, _callback.bind(this));
        },
        /* 버튼 클릭 시 액션 세팅 */
        this.setButtons = function () {
            $("#btnAddPntPlcy").click(function () {
                this.saveAction();
            }.bind(this));

            $("#btnRemovePntPlcy").click(function () {
                this.removeAction();
            }.bind(this));
            
            $("#pntUseGiftRange").change(function(){
            	this.textDisabledFn();
            }.bind(this));
        },
        this.textDisabledFn = function(){
        	if($("#pntUseGiftRange").val() == "00") {
        		$("#useGiftMaxAmt").attr("disabled",true);
        		$("#giftFeeCntAmt").attr("disabled",true);
        		$("#giftFeeMileageAmt").attr("disabled",true);
        		$("#giftEndTypeCd").attr("disabled",true);
        		$("#pgmPntPlcyPopValid #ofrNm").attr("required", false);
        	}
        	else {
        		$("#useGiftMaxAmt").attr("disabled",false);
        		$("#giftFeeCntAmt").attr("disabled",false);
        		$("#giftFeeMileageAmt").attr("disabled",false);
        		$("#giftEndTypeCd").attr("disabled",false);
        		$("#pgmPntPlcyPopValid #ofrNm").attr("required", true);
        	}
        },
        /* 삭제 액션 */
        this.removeAction = function () {

            var _success = function (result) {
                $.ifvProgressControl(false);
                setTimeout(`alert('<spring:message code="L00085"/>')`, 0);
                $.ifvInitFields(this.fields, this.optionFields);
            };

            var _fail = function (result) {
                $.ifvProgressControl(false);
                setTimeout(`alert(result.message)`, 0);
            };

            if ($.fn.ifvmIsNotEmpty(this.getRid())) {
                if (confirm('<spring:message code="L00086"/>')) {
                    $.ifvProgressControl(true);
                    $.ifvPostJSON('<ifvm:action name="removePgmPntPlcy"/>', { rid: this.getRid(), pgmRid: this.getPgmRid() }, _success.bind(this), _fail.bind(this));
                    this.isNew = true;
                }
            }
        },
        /* Form 데이터 제출 */
        this.onSubmit = function () {

            /* submit을 위한 Form 데이터 파라미터 세팅 */
            var _setSubmitParams = function () {
                
            	var vObj = {};
                
            	if($("#pntUseGiftRange").val() == "00") {
            		$("#useGiftMaxAmt").val(0);
            		$("#giftFeeCntAmt").val(0);
            		$("#giftFeeMileageAmt").val(0);
            		$("#giftEndTypeCd").val("");
            	}
            	
            	// 필드 데이터 가져오기
				var vObj = $.ifvGetFieldData(this.fields, this.optionFields);
				vObj.ofrRid = offerRid
				_updatedData = $.extend(true, {}, vObj);

				
                vObj["pgmRid"] = this.getPgmRid();
                
                
				this.fields.valueFields.forEach(function(vf) {
					if(vf != "giftFeeMileageAmt" && vf != "giftFeeCntAmt")
						vObj[vf] = parseInt(vObj[vf].replace(/,/g,""));
					else
						vObj[vf] = vObj[vf].replace(/,/g,"")
				});
				                
                if (!this.isNew) {
                    vObj['rid'] = this.getRid();
                }
                return vObj;
            }

            /* 제출 후 알럿창 */
            var _afterSubmit = function () {
                if (!this.isNew) calculateChanges(_loadedData, _updatedData, [], "PNT", "", this.optionFields, this.getPgmRid());
                alert('<spring:message code="L00127"/>');
                this.formDataLoad();
            }

            var submitUrl = (this.isNew) ? '<ifvm:action name="addPgmPntPlcy"/>' : '<ifvm:action name="editPgmPntPlcy"/>';

            $.ifvSyncPostJSON(submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));
            
        },
        /* 저장 버튼클릭 시 확인 */
        this.saveAction = function () {
            if ($("#pgmPntPlcyPopValid ").ifvValidation().confirm()) this.onSubmit();
        },
        this.setCommaKeyup = function () {
			this.fields.valueFields.forEach(function(vf) {
				$('#' + vf).keyup(function() {
					var vfVal = $('#' + vf).val();						
					$('#'+ vf).val($.fn.ifvmNumberWithCommas(vfVal));
					$('#' + vf).css("text-align", "right");
				});
			})
        },
        this.init = function () {
            this.setButtons();
            this.formDataLoad();
            this.setCommaKeyup();
        }
	};
	
	function btnGiftOftPop() {
		
		if(!giftCheck) {
			alert("선물가능범위가 무제한 혹은 가족단위 일때만 가능합니다.");
			return;
		}else{
			$("#giftOfrPop").ifvsfPopup({
				enableModal : true,
			    enableResize: false,
			    contentUrl: '<ifvm:url name="ofrPop"/>',
			    contentType: "ajax",
			    title: '오퍼 조회',
			    width: '1000px',
			    maxWidth : '1000px',
			    close : 'giftOfrClosePop',
			});
		}
		
	}

	function giftOfrClosePop() {
		giftOfrPop._destroy();
	}
	
	function isNemberKey(evt){
		var charCode = (evt.which) ? evt.which : event.keyCode;
        var _value = event.srcElement.value.replace(/,/g,""); 
		
        if (event.keyCode < 48 || event.keyCode > 57) { 
            if (event.keyCode != 46) { //숫자와 . 만 입력가능하도록함
                return false; 
            } 
        }
        
		var _feeValChk1 = /^\d*[.]\d*$/; // 현재 value값에 소수점(.) 이 있으면 . 입력불가
        if (_feeValChk1.test(_value)) {
            if (charCode == 46) {
                return false;
            }
        }
		
        var _feeValChk2 = /^\d*[.]\d{2}$/; // 현재 value값이 소수점 둘째짜리 숫자이면 더이상 입력 불가
        if (_feeValChk2.test(_value)) {
            alert("소수점 둘째자리까지만 입력가능합니다.");
            return false;
        }     
        return true;
	}
	
	$(document).ready(function () {
		var pgmPntPlcyGrid = new PgmPntPlcyDetail();
		pgmPntPlcyGrid.init();
		
		 $("#pntUseGiftRange").change(function(){
			 if($("#pntUseGiftRange").val()=='01' || $("#pntUseGiftRange").val()=='02') {
				 giftCheck = true;
			 }  else {
				 giftCheck = false;
				 
			 }
		 }); 
		 
		 $('.helpBtn').setupHelpMessage();
	});
</script>

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

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L02718" /></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<ifvm:inputNew type="button" btnType="check" text="L00125" id="btnAddPntPlcy" objCode="btnAddPntPlcy_OBJ"/>
		<ifvm:inputNew type="button" btnType="minus" text="M01854" id="btnRemovePntPlcy" objCode="btnRemovePntPlcy_OBJ"/>
	</div>
</div>
<div id="pgmPntPlcyPopValid">
	<div class="half_wrap top_well">
		<div class="half_content half_left">
			<div class="page_btn_area">
				<div class="col-xs-7">
					<span> <spring:message code="L00047" /></span>
				</div>
			</div>
			<div class="form-horizontal top_well underline">
				<div class="row">
				    <!-- 사용 단위 -->
				    <ifvm:inputNew type="text" id="useUnit" label="L00050" labelClass="3" conClass="3" required="true" />
				    <!-- 사용 허들 -->
				    <ifvm:inputNew type="text" id="useHudl" label="L00049" labelClass="3" conClass="3" />
				</div>
				<div class="row">
				    <!-- 1회 최대 사용 금액 -->
				    <ifvm:inputNew type="text" id="usePerMax" label="L00052" labelClass="3" conClass="3"  />
				    <!-- 1일 최대 사용 금액 -->
				    <ifvm:inputNew type="text" id="use1DayMax" label="L00051" labelClass="3" conClass="3"  />
				</div>
				<div class="row">
				    <!-- 차감 순서 -->
				    <ifvm:inputNew type="select" id="pntUseRdmSeq" names="pntUseRdmSeq" label="L00099" labelClass="3" conClass="3" />
				    <!-- 비밀번호 사용 -->
				    <ifvm:inputNew type="checkBox" id="usePwYn" label="L00525" labelClass="3" conClass="3" />
				</div>
				<div class="row">
				    <!-- 선물 가능 범위 -->
				    <ifvm:inputNew type="select" id="pntUseGiftRange" names="pntUseGiftRange" label="L00054" labelClass="3" conClass="3" />
				    <!-- 선물 취소 여부 -->
				    <%-- <ifvm:inputNew type="checkBox" id="useGiftCancYn" label="L02777" labelClass="3" conClass="3" /> --%>
				    <!-- 선물 최대 금액 -->
				    <ifvm:inputNew type="text" id="useGiftMaxAmt" label="선물 최대 금액" labelClass="3" conClass="3" />
				</div>
				<!-- 1회당 선물(양도) 수수료 -->
				<!-- 1마일리지당 선물(양도) 수수료 -->
				<!-- <div class="row">
					<label class="control-label col-xs-3">1회당 수수료</label>
					<div class="control_content col-xs-3">
						<input type="text" id="giftFeeCntAmt" style="text-align: right;" onkeypress="return isNemberKey(event)">
					</div>
				    <label class="control-label col-xs-3">1마일리지당 수수료</label>
					<div class="control_content col-xs-3">
						<input type="text" id="giftFeeMileageAmt" style="text-align: right;"  onkeypress="return isNemberKey(event)">
					</div>
				</div> -->
				<div class="row">

				    <ifvm:inputNew type="search" id="ofrNm" dto="ofrNm" names="ofrNm" label="선물 오퍼" btnFunc="btnGiftOftPop" labelClass="3" conClass="3" />
					<!-- <span class="input-group-addon" style="padding: 6px;" id="btnGiftOftPop"> <a><i class="fa fa-search"></i></a>
					</span> -->
					<!-- 선물유효종료일유형 -->
				    <ifvm:inputNew type="select" id="giftEndTypeCd" names="giftEndTypeCd" label="선물유효종료일유형" labelClass="3" conClass="3" />
				    <a><i class="helpBtn" style="vertical-align: middle;">
							<div class="helptxt" style="display:none;"><spring:message code="D10309"/></div>
						</i></a>
				</div>
				
				<div class="row">
				    <!-- 마이너스 포인트 여부 -->
				    <ifvm:inputNew type="checkBox" id="useMinusYn" label="L02778" labelClass="3" conClass="3" />

				</div>
			</div>
		</div>
		<div class="half_content half_right">
			<div class="page_btn_area">
				<div class="col-xs-7">
					<span> <spring:message code="L00056" /></span>
				</div>
			</div>

				<div class="form-horizontal top_well underline">
					<div class="row">
						<!-- 계산 방식 -->
						<ifvm:inputNew type="select" id="pntCalcType" names="pntCalcType" label="M01918" labelClass="3" conClass="3" required="true" />
						<!-- 절삭 방식 -->
						<ifvm:inputNew type="select" id="pntRoundType" names="pntRoundType" label="L02779" labelClass="3" conClass="3" required="true" />
					</div>
					<div class="row">
						<!-- 사용취소적립건만료일연장일수 -->
						<ifvm:inputNew type="text" id="rdmCnclEtDay" label="사용취소적립건 만료일연장일수" labelClass="3" conClass="3" />
						<a><i class="helpBtn" style="vertical-align: middle;">
							<div class="helptxt" style="display:none;"><spring:message code="D10308"/></div>
						</i></a>
						<!-- 소수점 자리수 -->
						<%-- <ifvm:inputNew type="number" id="roundNum" label="L02733" labelClass="3" conClass="3" required="true" /> --%>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div id="giftOfrPop" class="popup_container"></div>
	