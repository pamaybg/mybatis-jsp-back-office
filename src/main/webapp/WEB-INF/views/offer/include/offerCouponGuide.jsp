<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	
<!-- 탭 -->
<style>
#line1, #line2, #line3, #line4, #line5, #line6, #line7, #line8, #line9, #line10
{
	text-align: center;
	font-weight: bold;
} 

</style>
<div id="subTabArea"></div>
<div class="page_btn_area">
		<div class="col-xs-7">
			<span>&nbsp 라인 번호 &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp  메시지</span>
		</div>
		<div class="col-xs-5 searchbtn_r">
				<ifvm:inputNew type="button" btnType="check" text="L00125" id="couponbtnSave" objCode="offerCouponGuideSave_OBJ"/>
				<ifvm:inputNew type="button"  text="초기화" id="initGuideBtn" objCode="offerCouponGuideInit_OBJ"/>
		</div>
		
	</div>
	
	<div id="CouponGuideDetail">
		<div class="form-horizontal underline top_well">
			<div class="row">
				<div class="col-xs-12">
				 <ifvm:inputNew type="text" id="line1" conClass="1"  disabled="true"/>
				 <ifvm:inputNew type="text" id="line1Msg" names="line1Msg" conClass="11" maxLength="50" />
				</div>
			</div>
		</div>
				
		<div class="form-horizontal underline top_well">
			<div class="row">
			
				<div class="col-xs-12">
				 <ifvm:inputNew type="text" id="line2" conClass="1"  disabled="true"/>
				 <ifvm:inputNew type="text" id="line2Msg" names="line2Msg" conClass="11" maxLength="50" />
				</div>
		</div>
	</div>

		<div class="form-horizontal underline top_well">
			<div class="row">
				<div class="col-xs-12">
				 <ifvm:inputNew type="text" id="line3" conClass="1" disabled="true"/>
				 <ifvm:inputNew type="text" id="line3Msg" names="line3Msg"  conClass="11" maxLength="50"/>
				</div>
			</div>
		</div>
			
			<div class="form-horizontal underline top_well">
			<div class="row">
				<div class="col-xs-12">
				 <ifvm:inputNew type="text" id="line4" conClass="1"  disabled="true"/>
				 <ifvm:inputNew type="text" id="line4Msg" conClass="11" maxLength="50" />
				</div>
			</div>
			
		</div>
				<div class="form-horizontal underline top_well">
			<div class="row">
		
				<div class="col-xs-12">
				 <ifvm:inputNew type="text" id="line5" conClass="1" disabled="true"/>
				 <ifvm:inputNew type="text" id="line5Msg" conClass="11"  maxLength="50"/>
				</div>
			</div>
		</div>
		
		<div class="form-horizontal underline top_well">
			<div class="row">

				<div class="col-xs-12">
				 <ifvm:inputNew type="text" id="line6" conClass="1"  disabled="true"/>
				 <ifvm:inputNew type="text" id="line6Msg" conClass="11"  maxLength="50"/>
				</div>
			</div>
		</div>
		
		<div class="form-horizontal underline top_well">
			<div class="row">
	
				<div class="col-xs-12">
				 <ifvm:inputNew type="text" id="line7" conClass="1" disabled="true"/>
				 <ifvm:inputNew type="text" id="line7Msg" conClass="11"  maxLength="50"/>
				</div>
			</div>
		</div>
		
		<div class="form-horizontal underline top_well">
			<div class="row">
	
				<div class="col-xs-12">
				 <ifvm:inputNew type="text" id="line8" conClass="1" disabled="true"/>
				 <ifvm:inputNew type="text" id="line8Msg" conClass="11" maxLength="50"/>
				</div>
			</div>
		</div>
		
		<div class="form-horizontal underline top_well">
			<div class="row">
		
				<div class="col-xs-12">
				 <ifvm:inputNew type="text" id="line9" conClass="1" disabled="true"/>
				 <ifvm:inputNew type="text" id="line9Msg" conClass="11" maxLength="50"/>
				</div>
			</div>
		</div>
		
		<div class="form-horizontal underline top_well">
			<div class="row">

				<div class="col-xs-12">
				 <ifvm:inputNew type="text" id="line10" conClass="1" disabled="true"/>
				 <ifvm:inputNew type="text" id="line10Msg" conClass="11"  maxLength="50"/>
				</div>
			</div>
		</div>
	</div>



<script type="text/javascript">
var lineMsg=[];
var lineNum=[];

function lineNumsetting(){
	for(var i=1;i<=10;i++){
		$("#line"+i).val(i);
	}
}

var CouponGuideDetail = function () {
	
    var _rid = null;
	var ofrRid= ifvGlobal["offerRid"];
	var cpnRid= null;
	
	var _formId = 'CouponGuideDetail';
	
	this.setRid = function (rid) {
    	_rid = rid;
    },
    this.getRid = function () {
        return _rid;
    },
    this.isNew = false,
    // 유효성 검사 초기화
    this.validation = $("#" + _formId).ifvValidation(),
    this.fields = $.ifvGetFields(_formId),
    /* Form 데이터 로드 */
    this.formDataLoad = function () {
    	
        var _callback = function (result) {
     
        	lineNumsetting();
     
            if ($.fn.ifvmIsNotEmpty(result.msgInfo[0])) {
          
                this.setRid(result.msgInfo[0].rid);  //rid_ofr rid 세팅
   
                this.isNew = $.fn.ifvmIsNotEmpty(this.getRid()) ? false : true;
        
                $.ifvLoadFormData(result, this.fields);
          
                 for(var i=0;i<10;i++){
                       	 $("#line"+result.msgInfo[i].lineNo+"Msg").val(result.msgInfo[i].msgText);
                	}
               
                
           } else {
                this.isNew = true;
                // 필드 데이터 초기화
                $.ifvInitFields(this.fields);
            }
        }
        $.ifvSyncPostJSON('<ifvm:action name="getCouponGuide"/>', {ridOfr:ofrRid, ridCpn:cpnRid}, _callback.bind(this));
    },
     /* 버튼 세팅 */
    this.setButtons = function () {
        $("#couponbtnSave").click(function () {
        	if(cpnRid==null){
        		alert("쿠폰 정책 입력 후 저장 가능합니다.");
        	} else {
            	this.saveAction();
        	}
        }.bind(this));
        
        $("#initGuideBtn").click(function () {
            this.initOfrCouponGuide();
        }.bind(this));
       
   },
   this.initOfrCouponGuide = function(){  //데이터 삭제(초기화)
	   	if(confirm('<spring:message code="기존 데이터를 초기화 하시겠습니까?"/>')){
	   		$.ifvSyncPostJSON('<ifvm:action name="initOfrCouponGuide"/>', { 
	   			ridOfr : ofrRid 
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
    /* 메뉴 세팅 */
    this.setMenu = function () {
        $.ifvmLnbSetting('offerListNew');
    },
    /* Form 데이터 제출 */
    this.onSubmit = function () {

        var _submitUrl = this.isNew ? '<ifvm:action name="addCouponGuide"/>' : '<ifvm:action name="updateCouponGuide"/>';
        
        /* submit을 위한 Form 데이터 파라미터 세팅 */
        var _setSubmitParams = function () {
        	var vObj = {};

            var vObj = $.ifvGetFieldData(this.fields);

            /* 가이드 수정일 경우  */
            if (!this.isNew) vObj['ridOfr'] = ofrRid;
            					  
            /* 가이드 신규일 경우  */
            if (this.isNew) {
                vObj['ridCpn'] = cpnRid;
                vObj['ridOfr'] = ofrRid;
            }
          							            
            return vObj;
        }
        
        /* 제출 후 알럿창 */
        var _afterSubmit = function () {
           
        	alert('<spring:message code="L00127"/>');
        	this.isNew = false;
        };
        
        $.ifvSyncPostJSON(_submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));
    },
    /* 저장 버튼클릭 시 확인 */
    this.saveAction = function () {
        if (this.validation.confirm()) this.onSubmit();
    },  	
    this.couponChk= function(){
    	$.ifvSyncPostJSON('<ifvm:action name="getCouponChk"/>',{
    		ridOfr : ofrRid
    	},function(result) {
    		if(($.fn.ifvmIsNotEmpty(result))){
    			cpnRid=result.ridCpn; //쿠폰 번호 있으면 세팅
    		}
    	},function(result){
    		
    	});
    	
    },
    /* 페이지 초기화 */
    this.init = function () {

		this.couponChk();
		this.formDataLoad();
	    this.setMenu();
        this.setButtons();
    }
}

$(document).ready(function(){
    var CouponGuide = new CouponGuideDetail();
    CouponGuide.init();
    lineNumsetting();
});
</script>
