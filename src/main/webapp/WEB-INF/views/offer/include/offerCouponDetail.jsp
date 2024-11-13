<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%!
	public String cleanXss(String str){

		if(str != null){
			str = str.replaceAll("<","&lt;");
			str = str.replaceAll(">","&gt;");
		}
		return str;
	}
%>



<style>
	.tab-contents .page_btn_area .btn.disabled, .tab-contents .page_btn_area .btn[disabled] {
		display: inline;
	}
</style>
<style>
#issMaxCnt, #useMinPurAmt, #useExpirDayCnt, #useExpirDayCnt,#useMaxDcAmt, #usableMaxCnt
{
	text-align: right;
} 
</style>

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
		<span><spring:message code="O00126" /></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
			<!-- 저장 버튼 -->
			<ifvm:inputNew type="button" btnType="check" text="L00125" id="couponbtnSave" objCode="offerCouponDetailSave_OBJ"/>
			<!-- 초기화 버튼 -->
			<ifvm:inputNew type="button" text="초기화" id="initCoupon" objCode="offerCouponDetailInit_OBJ"/>
	</div>
</div>
	
	<div id="CouponDetail">
		<div class="form-horizontal underline top_well">
			<div class="row">
				<!-- 발급구분 + 중복발급 -->
				<div class="col-xs-7">
					<!-- 발급 구분  -->
					<div class="col-xs-6">
						<ifvm:inputNew type="select" id="issType" names="issType" label="O00127" labelClass="4" conClass="8"  required="true"/>
					</div>
					<!-- 중복 발급 -->
					<div class="col-xs-6">
						<ifvm:inputNew type="checkBox" id="issDupYn" names ="issDupYn" label="O00128" labelClass="3" conClass="1" />
					</div>
				</div>
				
				<!-- 발급채널  -->
				<div class="col-xs-5">
					<ifvm:inputNew type="search" id="issChnl" names="issChnl" label="O00167" labelClass="3" conClass="6" btnFunc="chnlPopOpen"/>
					<ifvm:inputNew type="hidden" id="issChnlRid" />
				</div>
			</div>
			<div class="row">
				<!-- 발급가능 기간 -->
				<div class="col-xs-7">
					<ifvm:inputNew type="date" id="issStartDate" label="O00129"  labelClass="2" conClass="2" />
					<ifvm:inputNew type="time" id="issStartTime" conClass="2" />
			
					<div style="float: left">~</div>
					<ifvm:inputNew type="date" id="issEndDate" conClass="2"/>
					<ifvm:inputNew type="time" id="issEndTime" conClass="2" />	
				</div>
				<!-- 최대 발급 수량 -->
				<div class="col-xs-5">
					<ifvm:inputNew type="text" id="issMaxCnt" names="issMaxCnt" label="O00130" labelClass="3" conClass="6" maxLength="10" />
				</div>
			</div>
			
			<%-- <div class="row ">
				<!-- ThumbnailImage URL(사용전) -->
				<div class="col-xs-12">
					<ifvm:inputNew type="text" id="thumbImgBefUrl" names="thumbImgBefUrl" label="O00131" labelClass="2" conClass="9" maxLength="300"/>
				</div>
		 	</div>
		 	
		 	<div class="row ">
				<!-- ThumbnailImage URL(사용후) -->
				<div class="col-xs-12">
					<ifvm:inputNew type="text" id="thumbImgAftUrl" names="thumbImgAftUrl" label="O00132" labelClass="2" conClass="9" maxLength="300"/>
				</div>
		 	</div>	 --%>
		 		
		 	<div class="row ">
		 		<!-- 비고 -->
				<div class="col-xs-12">
					<ifvm:inputNew type="text" id="cpndescText" dto="cpndescText" label="L01815" labelClass="1" conClass="10" maxLength="300"/>
				</div>
		 	</div>		
		 		
		 	<div class="page_btn_area">
				<div class="col-xs-7">
					<span><spring:message code="O00158"/></span>
				</div>
				
			</div>
		 		
		 	<div class="row">
		 	<br>
				<!-- 유효기간 구분 -->
				<div class="col-xs-7">
					<ifvm:inputNew type="select" id="useExpirType" names="useExpirType"  label="O00133" labelClass="2" conClass="4" required="true" />
					<ifvm:inputNew type="text" id="useExpirDayCnt" names="useExpirDayCnt"  conClass="2" maxLength="10" required="true"/><!-- (일) -->
					<lebel id="info2">발급일로부터 *일까지</lebel>
					 
				</div>
				<%-- <div class="col-xs-5">
					<ifvm:inputNew type="text" id="useExpirDayCnt" names="useExpirDayCnt" label="O00136" labelClass="2" conClass="5" maxLength="10"/>(일)
				</div> --%>
				<!-- 중복사용 가능여부 -->
				
			</div>
			
			<div class="row">
					<!-- 고정 유효 기간  -->
				<div class="col-xs-7" id="fixDatefield">
					<ifvm:inputNew type="date" id="useFixStartDate" label="O00135"  labelClass="2" conClass="4"/>
					<div style="float: left">~</div>
					<ifvm:inputNew type="date" id="useFixEndDate" conClass="4"/>
				</div>
				<div class="col-xs-5">
					<ifvm:inputNew type="checkBox" id="offYn" names="offYn" dto="offYn" label="오프라인 매장 전용" labelClass="3" conClass="2" />
					<ifvm:inputNew type="checkBox" id="useDupYn" names="useDupYn" label="타쿠폰중복" labelClass="2" conClass="1" />
					 <a>
					 	<i class="helpBtn" style="vertical-align: middle;">
							<div class="helptxt" style="display:none;"><spring:message code="상품쿠폰과 중복으로 사용이 가능합니다."/></div>
					    </i>
					 </a>
				</div>
				<!-- 유동 일자 -->
				
		</div>	
		
		<div class="row">
				<!-- 사용 가능 시간  -->
				<div class="col-xs-7">
						<ifvm:inputNew type="time" id="useFixStartTime"  label="O00123"  labelClass="2" conClass="4"/> 
							<div style="float: left">~</div>
						<ifvm:inputNew type="time" id="useFixEndTime" conClass="4"/>	
				</div>
				<!-- 사용 가능 횟수 -->
				<div class="col-xs-5">
				     <ifvm:inputNew type="text" id="usableMaxCnt" names="usableMaxCnt" label="O00124" labelClass="2" conClass="5" maxLength="10"/>(회)
				</div>
		</div>
		
		 		
		 		
		 	<div class="row">
				<!-- 최소구매금액 -->
				<%-- <div class="col-xs-7">
					<ifvm:inputNew type="text" id="useMinPurAmt" required="true" names="useMinPurAmt" label="O00137" labelClass="2" conClass="5" maxLength="14"/>(원)
				</div> --%>
				
				<div class="col-xs-7">
					<label class="control-label col-xs-2"><spring:message code="O00157"/></label>				
					<div class="control_content col-xs-1"> 
					<ifvm:inputNew type="checkBox" id="useWeekMon" label="O00139" labelClass="3" conClass="2" />
			        </div>
			        <div class="control_content col-xs-1"> 
					<ifvm:inputNew type="checkBox" id="useWeekTue" label="O00140" labelClass="3" conClass="2" />
			        </div>
			           <div class="control_content col-xs-1"> 
					<ifvm:inputNew type="checkBox" id="useWeekWed" label="O00141" labelClass="3" conClass="2" />
			        </div>
			           <div class="control_content col-xs-1"> 
					<ifvm:inputNew type="checkBox" id="useWeekThu" label="O00142" labelClass="3" conClass="2" />
			        </div>
			           <div class="control_content col-xs-1"> 
					<ifvm:inputNew type="checkBox" id="useWeekFri" label="O00143" labelClass="3" conClass="2" />
			        </div>
			          <div class="control_content col-xs-1"> 
					<ifvm:inputNew type="checkBox" id="useWeekSat" label="O00144" labelClass="3" conClass="2" />
			        </div>
			          <div class="control_content col-xs-1"> 
					<ifvm:inputNew type="checkBox" id="useWeekSun" label="O00145" labelClass="3" conClass="2" />
			        </div>
			     </div>
				<!-- 최대할인금액 -->
				<div class="col-xs-5">
					<ifvm:inputNew type="text" id="useMaxDcAmt" names="useMaxDcAmt" label="O00138" labelClass="2" conClass="2" maxLength="14"/><div style="float: left">(원)</div>
	
					<ifvm:inputNew type="text" id="useMinPurAmt" names="useMinPurAmt" label="O00137" labelClass="3" conClass="2" maxLength="14"/><div style="float: left">(원)</div>

				</div>
		  </div>
		  <br>
	  	 	<%-- <div class="row">
	  	 		<!-- 사용가능요일 -->
				<div class="col-xs-7">
					<label class="control-label col-xs-2"><spring:message code="O00157"/></label>				
					<div class="control_content col-xs-1"> 
					<ifvm:inputNew type="checkBox" id="useWeekMon" label="O00139" labelClass="3" conClass="2" />
			        </div>
			        <div class="control_content col-xs-1"> 
					<ifvm:inputNew type="checkBox" id="useWeekTue" label="O00140" labelClass="3" conClass="2" />
			        </div>
			           <div class="control_content col-xs-1"> 
					<ifvm:inputNew type="checkBox" id="useWeekWed" label="O00141" labelClass="3" conClass="2" />
			        </div>
			           <div class="control_content col-xs-1"> 
					<ifvm:inputNew type="checkBox" id="useWeekThu" label="O00142" labelClass="3" conClass="2" />
			        </div>
			           <div class="control_content col-xs-1"> 
					<ifvm:inputNew type="checkBox" id="useWeekFri" label="O00143" labelClass="3" conClass="2" />
			        </div>
			          <div class="control_content col-xs-1"> 
					<ifvm:inputNew type="checkBox" id="useWeekSat" label="O00144" labelClass="3" conClass="2" />
			        </div>
			          <div class="control_content col-xs-1"> 
					<ifvm:inputNew type="checkBox" id="useWeekSun" label="O00145" labelClass="3" conClass="2" />
			        </div>
			     </div>
				
		  </div> --%>
	</div>
	<br>

<!-- 발급채널 팝업창이 뜨게 되는 div 컨테이너 -->
<div id="chnlPop" class="popup_container"></div>

<script type="text/javascript">
var CouponDetail = function () {
    var _rid = null;
	var ofrRid= ifvGlobal["offerRid"]; // 오퍼RID (쿠폰 상위 RID)
	var issChnlRid= ifvGlobal["issChnlRid"]; // 오퍼RID (쿠폰 상위 RID)


    var _formId = "CouponDetail";
    this.setRid = function (rid) {
        _rid = rid;
    },
    this.getRid = function () {
       return _rid;
    },
    // 파라미터에 rid 존재 유무에 따라 신규인지 아닌지 판별
    this.isNew = false;
    // 유효성 검사 초기화
    this.validation = $("#" + _formId).ifvValidation(),
    this.fields = $.ifvGetFields(_formId),
    this.optionFields = [
        { fieldName: "issType", commCode: "LOY_CPN_ISS_TYPE"},
        { fieldName: "useExpirType", commCode: "LOY_CPN_EXPIR_TYPE" },
      ],
    /* Form 데이터 로드 */
    this.formDataLoad = function () {
    	  var _callback = function (result) {
            if ($.fn.ifvmIsNotEmpty(result)) {
                // 필드의 데이터 로드
                this.setRid(result.rid);
                this.isNew = $.fn.ifvmIsNotEmpty(this.getRid()) ? false : true;
 
                $.ifvLoadFormData(result, this.fields, this.optionFields);
                
                if(result.issStartDate != null) {
                	$("#issStartDate").val(result.issStartDate.substring(0,10));
                	$("#issStartTime").val(result.issStartDate.substring(11,16));
                }

                if(result.issEndDate != null) {
                	$("#issEndDate").val(result.issEndDate.substring(0,10));
                	$("#issEndTime").val(result.issEndDate.substring(11,16));
                }
                
        		
    	      
        		if(result.useFixStartDate!=null){
        			$("#useFixStartDate").val(result.useFixStartDate.substring(0,10));
        		}
        		
        		if(result.useFixEndDate!=null){
           			$("#useFixEndDate").val(result.useFixEndDate.substring(0,10));
        		}
        		
        		if(result.useFixStartTime!=null){
           			$("#useFixStartTime").val(result.useFixStartTime.substring(0,2)+":"+result.useFixStartTime.substring(2,4));
        		}

        		if(result.useFixEndTime!=null){
           			$("#useFixEndTime").val(result.useFixEndTime.substring(0,2)+":"+result.useFixEndTime.substring(2,4));
        		}
      		
        		
            	 $("#useMaxDcAmt").val($.ifvNumberFormat(result.useMaxDcAmt));
            	 $("#useMinPurAmt").val($.ifvNumberFormat(result.useMinPurAmt));
            	 
            	    if($("#useExpirType").val()=="FIX"){
            	    	/* 고정기간일 경우 고정유효기간 활성화  */
            	    	$("#useFixStartDate").attr("disabled",false);
            	    	$("#useFixEndDate").attr("disabled",false);            	    	
            	    	$("#useExpirDayCnt").attr("disabled",true);
            	        $("#useExpirDayCnt").val("");
            	        $("#useExpirDayCnt").attr("required",false);
            	        
            	    }else if($("#useExpirType").val()=="NA"){    
            	    	/*기간 제한 없을 경우 오른쪽 텍스트 */
            	    	$("#useExpirDayCnt").attr("disabled",true);
            	        $("#useExpirDayCnt").val("");
            	        $("#useExpirDayCnt").removeAttr("required",false);
            	        $("#useFixStartDate").attr("disabled",true);
            	    	$("#useFixEndDate").attr("disabled",true);            	        
            	        $("#useFixStartDate").val("");
            	    	$("#useFixEndDate").val("");
            	    }else{
            	    	$("#useFixStartDate").attr("disabled",true);
             	    	$("#useFixEndDate").attr("disabled",true);            	        
             	        $("#useFixStartDate").val("");
             	    	$("#useFixEndDate").val("");
             	        $("#useExpirDayCnt").attr("required",true);
            	    	$("#useExpirDayCnt").attr("disabled",false);
          	        
             	    }
	        		
            } else {
 				this.isNew = true;
                 // 필드 데이터 초기화
                $.ifvInitFields(this.fields);
                $("#issDupYn").attr("checked", true);
                $("#useDupYn").attr("checked", true);
            	$("#usableMaxCnt").val("1");
				$('#useWeekMon').attr('checked', true);
				$('#useWeekTue').attr('checked', true);
				$('#useWeekWed').attr('checked', true);
				$('#useWeekThu').attr('checked', true);
				$('#useWeekFri').attr('checked', true);
				$('#useWeekSat').attr('checked', true);
				$('#useWeekSun').attr('checked', true);
            }
        }
        
        $.ifvSyncPostJSON('<ifvm:action name="getCouponDetail"/>', { ridOfr:ofrRid , rid:_rid}, _callback.bind(this));
        if($("#useExpirType").val()=='DAY') {
        	if($("#useExpirDayCnt").val()=='0') {
			 		$("#info2").text("(발급일로부터 당일까지)");
			 	}
			 	else $("#info2").text("(발급일로부터 "+ $("#useExpirDayCnt").val()+"일 후 까지)");
			} else if($("#useExpirType").val()=='MONTH') {
				if($("#useExpirDayCnt").val()=='0') {
			 		$("#info2").text("(발급일로부터 당일까지)");
			 	}
				else $("#info2").text("(발급일로부터 "+$("#useExpirDayCnt").val()+"개월 후 까지)");
			} else if($("#useExpirType").val()=='YEAR') {
				if($("#useExpirDayCnt").val()=='0') {
			 		$("#info2").text("(발급일로부터 당일까지)");
			 	}
				else $("#info2").text("(발급일로부터 "+ $("#useExpirDayCnt").val()+"년 후 까지)");
			} else if($("#useExpirType").val()=='EOM') {
				if($("#useExpirDayCnt").val()=='0') {
			 		$("#info2").text("(발급일로부터 당월 말일까지)");
			 	}
				else $("#info2").text("(발급일로부터 "+ $("#useExpirDayCnt").val()+"개월 후 말일 까지)");
			} else if($("#useExpirType").val()=='EOY') {
				if($("#useExpirDayCnt").val()=='0') {
			 		$("#info2").text("(발급일로부터 금년 12월31일까지)");
			 	}
				else $("#info2").text("(발급일로부터 "+ $("#useExpirDayCnt").val()+"년 후 12월31일까지)");
			} else if($("#useExpirType").val()=='NA') {
				$("#info2").text('');
			} else if($("#useExpirType").val()=='FIX') {
				$("#info2").text('');
			} 
        if(this.isNew) { $("#issMaxCnt").val("0"); }
        issTypeChange();
    },
     /* 버튼 세팅 */
    this.setButtons = function () {
    	$("#couponbtnSave").click(function () {
            this.saveAction();
        }.bind(this));
    	
    	$("#initCoupon").click(function () {

            this.initOfrCouponDetail();
        }.bind(this));
    	
    	$('#issChnl').on('click', function () {
			$.fn.ifvmPopupOpen('popupContainer', null,
				'<ifvm:url name="chnlPop"/>',
				'<spring:message code="O00005"/>', 860, true, true);
		});
   },
    /* 메뉴 세팅 */
    this.setMenu = function () {
        $.ifvmLnbSetting('offerListNew');
    },
    /* Form 데이터 제출 */
    this.onSubmit = function () {
        var _submitUrl = this.isNew ? '<ifvm:action name="addCouponNew"/>' : '<ifvm:action name="editCouponNew"/>';
     
        /* submit을 위한 Form 데이터 파라미터 세팅 */
        var _setSubmitParams = function () {

	        var vObj = $.ifvGetFieldData(this.fields, this.optionFields);
            vObj['issStartDate'] = $("#issStartDate").val()+$("#issStartTime").val();
            vObj['issEndDate'] = $("#issEndDate").val()+$("#issEndTime").val();

            vObj['useFixStartTime']= $("#useFixStartTime").val().replace(":","");
            vObj['useFixEndTime'] =$("#useFixEndTime").val().replace(":","");
            vObj['useMaxDcAmt'] =  $("#useMaxDcAmt").val().replace(/,/g, '');
            vObj['useMinPurAmt'] = $("#useMinPurAmt").val().replace(/,/g, '');
            
            if (!this.isNew) vObj['rid'] = this.getRid();  /* 수정시 */
            if(this.isNew)  vObj['ridOfr'] =ifvGlobal["offerRid"]; /* 신규 */

            return vObj;
        }
        
        /* 제출 후 알럿창 */
        var _afterSubmit = function () {
        	alert('<spring:message code="L00127"/>');
        	   this.isNew = false;        
        	   this.formDataLoad();
        };
        $.ifvSyncPostJSON(_submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));
    },
    /* 저장 버튼클릭 시 확인 */
    this.saveAction = function () {
    	/* if($("#useExpirType").val()=='DAY') {
			if($("#useExpirDayCnt").val()=='0' || $("#useExpirDayCnt").val()=="") {
				alert("일(Day) 발급일은 1 이상 입력가능합니다.");
				return;
			}
		} else if($("#useExpirType").val()=='MONTH') {
			if($("#useExpirDayCnt").val()=='0' || $("#useExpirDayCnt").val()=="") {
				alert("월(Month) 발급일은 1 이상 입력가능합니다.");
				return;
			}
		} else if($("#useExpirType").val()=='YEAR') {
			if($("#useExpirDayCnt").val()=='0' || $("#useExpirDayCnt").val()=="") {
				alert("년(Year) 발급일은 1 이상 입력가능합니다.");
				return;
			}
		}  */
	   if($("#usableMaxCnt").val()=='0') {
		   alert("사용가능횟수는 0보다 커야합니다.");
		   return;
	   }	
		
       if (this.validation.confirm()) this.onSubmit();
    },
    this.initOfrCouponDetail = function(){  //데이터 삭제(초기화)
    	if(confirm('<spring:message code="기존 데이터를 초기화 하시겠습니까?"/>')){
    		$.ifvSyncPostJSON('<ifvm:action name="initOfrCouponDetail"/>', { 
    			ridOfr : ofrRid 
    			, rid : _rid
    		}, function(result){ //성공
    			if(result.message) alert(result.message);
    			else alert('초기화 되었습니다.');
    			qtjs.href('<ifvm:url name="offerDetail"/>'+ '?rid=' + ofrRid);
    		}, function(result){ //실패
    			if(result.message) alert(result.message);
    			else alert('초기화에 실패 하였습니다.');
    		}.bind(this));
    	}
    },
    this.setCalendar = function(){
    	var issStartDate = $("#issStartDate");
    	var issEndDate = $("#issEndDate");
    	var issStartTime= $("#issStartTime");
    	var issEndTime= $("#issEndTime");    	
    	
    	var useFixStartDate= $("#useFixStartDate");
     	var useFixEndDate=	$("#useFixEndDate");
    	var useFixStartTime= $("#useFixStartTime");
     	var useFixEndTime=	$("#useFixEndTime");    

    	issStartTime.timepicker({
		      defaultTime : '00:00',
		      timeFormat: 'H:i',
		      showMeridian : false
		   });
    	
    	issEndTime.timepicker({
		      defaultTime : '00:00',
		      timeFormat: 'H:i',
		      showMeridian : false
		   });
    	
     	useFixStartTime.timepicker({
		      defaultTime : '00:00',
		      timeFormat: 'H:i',
		      showMeridian : false
		   });
	
  	useFixEndTime.timepicker({
		      defaultTime : '00:00',
		      timeFormat: 'H:i',
		      showMeridian : false
		   });
    	if(this.isNew==true){
   			issStartDate.val($("#validStartDate").val());
    		issEndDate.val($("#validEndDate").val());
    		useFixStartTime.val("");
    		useFixEndTime.val("");
    	}   	
    	issStartDate.ifvDateChecker({
    		maxDate : issEndDate
    	});
    	issEndDate.ifvDateChecker({
    		minDate : issStartDate
    	});
    	
    	useFixStartDate.ifvDateChecker({
    		maxDate : useFixEndDate
    	});
    	useFixEndDate.ifvDateChecker({
    		minDate : useFixStartDate
    	});
    },this.setChange = function(){
    	$('#useExpirDayCnt').change(function(){
    		 if($("#useExpirType").val()=='DAY') {
    			 if($("#useExpirDayCnt").val()=='0') {
 			 		$("#info2").text("(발급일로부터 당일까지)");
 			 	}
    			 	else $("#info2").text("(발급일로부터 "+ $("#useExpirDayCnt").val()+"일 후 까지)");
    			} else if($("#useExpirType").val()=='MONTH') {
    				if($("#useExpirDayCnt").val()=='0') {
    			 		$("#info2").text("(발급일로부터 당일까지)");
    			 	}
    				else $("#info2").text("(발급일로부터 "+$("#useExpirDayCnt").val()+"개월 후 까지)");
    			} else if($("#useExpirType").val()=='YEAR') {
    				if($("#useExpirDayCnt").val()=='0') {
    			 		$("#info2").text("(발급일로부터 당일까지)");
    			 	}
    				else $("#info2").text("(발급일로부터 "+ $("#useExpirDayCnt").val()+"년 후 까지)");
    			} else if($("#useExpirType").val()=='EOM') {
    				if($("#useExpirDayCnt").val()=='0') {
    			 		$("#info2").text("(발급일로부터 당월 말일까지)");
    			 	}
    				else $("#info2").text("(발급일로부터 "+ $("#useExpirDayCnt").val()+"개월 후 말일 까지)");
    			} else if($("#useExpirType").val()=='EOY') {
    				if($("#useExpirDayCnt").val()=='0') {
    			 		$("#info2").text("(발급일로부터 금년 12월31일까지)");
    			 	}
    				else $("#info2").text("(발급일로부터 "+ $("#useExpirDayCnt").val()+"년 후 12월31일까지)");
    			} else if($("#useExpirType").val()=='NA') {
    				$("#info2").text('');
    			} else if($("#useExpirType").val()=='FIX') {
    				$("#info2").text('');
    			} 
    		 

		});
    	
    	$("#useExpirType").change(function(){
    		
    		$("#info2").text('');
    		$("#useExpirDayCnt").val('');
    		
    	});
    	
    	$('#issType').change(function(){
    		issTypeChange();
    	});
    }, this.setDataCalendarAfterLoad = function(){
    	
    	if(this.isNew==true){    		
    		$("#issStartDate").val($("#validStartDate").val());
    		$("#issEndDate").val($("#validEndDate").val());
    		$("#issStartTime").val("00:00");
    		$("#issEndTime").val("00:00");    
    	}
    },this.setEvent = function(){
    	
    $("#issMaxCnt, #useExpirDayCnt, #usableMaxCnt").on("keyup", function() {
    	    $(this).val($(this).val().replace(/[^0-9]/g,""));
    	}); 
    	
    	$("#useMaxDcAmt, #useMinPurAmt").keyup(function() {
            $(this).val($.fn.ifvmNumberWithCommas(this.value));
        });
    	
    	$("#useExpirType").change(function(){
    		 var expireType =  $(this).val();
    	   
    	    if(expireType=="FIX"){
    	    	/* 고정기간일 경우 고정유효기간 활성화  */
                $("#useFixStartDate").attr("disabled",false);
                $("#useFixEndDate").attr("disabled",false);
                $("#useExpirDayCnt").attr("disabled",true);
                $("#useExpirDayCnt").val("");
                $("#useExpirDayCnt").attr("required",false);
    	    }else if(expireType=="NA"){
    	    	/* 유효기간 구분 값이 기한 제한 없음일 경우 고정유효 기간 disabled */
    	    	$("#useExpirDayCnt").attr("disabled",true);
                $("#useExpirDayCnt").val("");
                $("#useExpirDayCnt").removeAttr("required",false);
                $("#useFixStartDate").attr("disabled",true);
                $("#useFixEndDate").attr("disabled",true);                      
                $("#useFixStartDate").val("");
                $("#useFixEndDate").val("");
    	    }else{
    	    	 $("#useFixStartDate").attr("disabled",true);
                 $("#useFixEndDate").attr("disabled",true);                      
                 $("#useFixStartDate").val("");
                 $("#useFixEndDate").val("");
                 $("#useExpirDayCnt").attr("disabled",false);
                 $("#useExpirDayCnt").attr("required",true);
    	    }
    	});


    },
    /* 페이지 초기화 */
    this.init = function () {
		$.ifvSetSelectOptions(this.optionFields);
		this.setCalendar();
		this.setEvent();
		this.setDataCalendarAfterLoad();
		this.formDataLoad();
		 this.setButtons();
		 this.setChange();
    }
}

/* 발급채널 목록 팝업창 띄워주는 함수 chnlPopOpen */
function chnlPopOpen() {
	$("#chnlPop").ifvsfPopup({
		enableModal : true,
	    enableResize: false,
	    contentUrl: '<ifvm:url name="chnlPop"/>',
	    contentType: "ajax",
	    title: '발급 채널',
	    width: '600px',
	    close : 'chnlClosePop'//,
	});
}

function issTypeChange() {
	if($("#issType").val()=='N') {
		$("#issMaxCnt").attr("disabled",true);
		$("#issMaxCnt").val("");
		$("#issStartDate").attr("disabled",true);
		$("#issStartDate").val("");
		$("#issEndDate").attr("disabled",true);
		$("#issEndDate").val("");
		$("#issEndTime").attr("disabled",true);
		$("#issEndTime").val("");
		$("#issStartTime").attr("disabled",true);
		$("#issStartTime").val("");
	} else {
		$("#issMaxCnt").attr("disabled",false);
		$("#issStartDate").attr("disabled",false);
		$("#issEndDate").attr("disabled",false);
		$("#issEndTime").attr("disabled",false);
		$("#issStartTime").attr("disabled",false);
	}
}


$(document).ready(function(){
	
		var CouponDtl = new CouponDetail();
		CouponDtl.init();
		
		$('.helpBtn').setupHelpMessage();
		
		ofrStatSaveValid();
		
});

</script>