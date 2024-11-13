<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="form-horizontal underline top_well underline" id="newCustDetailForm">
<br>
	<div  class="form-horizontal underline top_well underline"  id="baseValidForm">
		<div class="page_btn_area"> <spring:message code="쿠폰 정보"/> </div>
 		<div class="row qt_border">
			<ifvm:inputNew type="text" id="cpnMbrNo" label="회원번호" labelClass="2" conClass="3" required="true" disabled="true" nuc="true"/>
			<%-- <ifvm:inputNew type="text" id="chnlPrNm" label="채널명" labelClass="2" conClass="3" required="true" disabled="true" nuc="true"/> --%>
			<ifvm:inputNew type="search" id="chnlPrNm" names="chnlPrNm" dto="chnlPrNm" btnFunc="getChnlList" label="채널명"  labelClass="2"  disabled="true" conClass="3" required="true"/>
 	 		<ifvm:inputNew type="hidden" id="chnlNo" labelClass="1" conClass="1" required="true" disabled="true"/>
		<%--	<span class="input-group-addon" style="padding : 4px;"  id="chnlList">
				<a><i class="fa fa-search"></i></a>
			</span> --%>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="cpnNo" label="쿠폰번호" labelClass="2" conClass="3" required="true" disabled="true" nuc="true"/>
			<ifvm:inputNew type="search" id="prodNm" names="prodNm" dto="prodNm" btnFunc="getProdList" label="상품명"  labelClass="2"  disabled="true" conClass="3" required="true"/>
 	 		<ifvm:inputNew type="hidden" id="prodId" dto="prodId" labelClass="1" conClass="1" required="true" disabled="true"/>
		</div>
	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="saveCpnBtn" objCode="">
		쿠폰 사용
	</button>
	<button class="btn btn-sm btn_gray"  id="closePopBtn" objCode="">
		<spring:message code="L00941" />
	</button>
</div>
<div id="offerPopup" class="popup_container"></div>
<div id="chnlPopupContainer" class="popup_container"></div>
<div id="prodPopupContainer" class="popup_container"></div>


<script id="asterisk" type="text/x-jquery-tmpl">
<span class="asterisk">*</span>\${fieldDesc}
</script>
<script id="nonasterisk" type="text/x-jquery-tmpl">
\${fieldDesc}
</script>

<script type="text/javascript">
var mbrCouponUse;
var baseValidation;

var mbrCouponUsePop = function(){
	var inputField = $("#newCustDetailForm input");
	var selectField =$("#newCustDetailForm select");
	this.textField =[],
	this.selectField =[],
	this.init = function(){
		this.action();
		this.getField();
		this.setSelectField();
		this.setDateField();
	},
	this.save = function(){
		this.getField()
		if(baseValidation.confirm() ){
			var url = '<ifvm:action name="useMbrCoupon"/>';
			$.ifvSyncPostJSON(url,this.getFieldVal(),function(result){
				this.afterSave(result)
			}.bind(this), function(result){this.afterSave(result)}.bind(this));
		}
	},
	this.close = function(){
		mbrCouponUsePopCon._destroy();
	},
	this.pgmclose = function(){
		ofrPopupContainer._destroy();
	},
	this.chnlclose = function(){
		chnlPopupContainer._destroy();
	},
	this.getField = function(){
		for(var i=0;i<inputField.length; i++){this.textField[i] = inputField[i].id;}
		for(var i=0;i<selectField.length; i++){this.selectField[i] = selectField[i].id;	}

	},
	this.setSelectField = function(values) {

    },
    this.setDateField = function(){
    	$("#cpnMbrNo").val(mbrNo);
    	$("#cpnNo").val(cpnNo);
    }
	this.getFieldVal = function(){
		var data = {}
		this.textField.forEach(function(a){
			data[a] = $("#"+a).val()
		});
		this.selectField.forEach(function(b){
			data[b] = $("#"+b).val()
		});
		data.mbrNo = mbrNo;
		return data;
	},
	this.afterSave = function(result){
		if(result.success){
			alert('쿠폰 사용 되었습니다.');
			getCouponHistList();
			this.close();

		}else{
			if(result.message) alert(result.message);
			else alert('쿠폰 사용에 실패 하였습니다.');
		}
	},
	this.action = function() {
        $("#saveCpnBtn").click(function() {
            this.save();
        }.bind(this));
        baseValidation = $("#baseValidForm").ifvValidation();

        $("#closePopBtn").click(function() {
        	this.close();
        }.bind(this));


        $("#chnlList").click(function(){
        	$.fn.ifvmPopupOpen('chnlPopupContainer', null,
					'<ifvm:url name="chnlListPop"/>',
					'<spring:message code="L00172"/>', 700, true, false);
        });

        /* $("#ofrList").click(function(){
        	$.fn.ifvmPopupOpen('ofrPopupContainer', null,
					'<ifvm:url name="offerPop"/>',
					'<spring:message code="L00515"/>', 700, true, false);
        }); */

    }
}


function getChnlList(){
	 $.fn.ifvmSearchHelpOpen(null, null, 'chnlPopupContainer', '<ifvm:url name="chnlPop"/>', '<spring:message code="L00172"/>');
}
function getProdList(){
	 $.fn.ifvmSearchHelpOpen(null, null, 'prodPopupContainer', '<ifvm:url name="prodPop"/>', '<spring:message code="M02060"/>');
}

function offerPopupClose() {
	offerPopup._destroy();
}


function chnlPopupClose(){
	chnlPopupContainer._destroy();
}

function prodPopupClose(){
	prodPopupContainer._destroy();
}



$(document).ready(function(){
	mbrCouponUse = new mbrCouponUsePop();
	mbrCouponUse.init();
})
</script>