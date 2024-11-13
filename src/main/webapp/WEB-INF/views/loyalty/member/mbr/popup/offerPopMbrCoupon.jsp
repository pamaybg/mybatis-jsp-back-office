<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="offerListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnCommOfferPopSelect" objCode="offerPopMbrCouponSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnCommOfferPopCancel" objCode="offerPopMbrCouponCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script id="ofrValueTemplate" type="text/x-jquery-tmpl">
	{{if ofrValTypeNm != null}}
		{{if ofrValTypeNm == '정액' }}
			<div>{{:ofrValAmt}}원</div>
		{{/if}}
		{{if ofrValTypeNm == '정률' }}
			<div>{{:ofrValAmt}}%</div>
		{{/if}}
		{{if ofrValTypeNm == '고정가' }}
			<div>{{:ofrValAmt}}원</div>
		{{/if}}
	{{/if}}
</script>

<script id="useMinPurAmtTemplate" type="text/x-jquery-tmpl">
	{{if useMinPurAmt != null}}
		{{if useMinPurAmt == '0' }}
			<div></div>
		{{/if}}
	{{/if}}
</script>

<script id="useMaxDcAmtTemplate" type="text/x-jquery-tmpl">
	{{if useMaxDcAmt != null}}
		{{if useMaxDcAmt == '0' }}
			<div></div>
		{{/if}}
	{{/if}}
</script>

<script id="useProdLimitYnTemplate" type="text/x-jquery-tmpl">
	{{if useProdLimitYn != null}}
		{{if useProdLimitYn == 'N' }}
			<div>장바구니</div>
		{{/if}}
		{{if useProdLimitYn == 'Y' }}
			<div>(카테고리)상품</div>
		{{/if}}
	{{/if}}
</script>


<script type="text/javascript">
var offerNm;
var offerNo;
var ofrType;
var ofrSubType;
var ofrValAmt;
var ofrValType;

function offerListSetting(){
	var ejGridOption = {
		rowSelected : function (args) {
			var data = args.data;
			offerId = data.rid;
			offerNm = data.ofrNm;
			offerNo = data.ofrNo;
			cpnYn   = data.cpnYn;
			ofrType = data.ofrTypeCd;
			ofrSubType = data.ofrSubTypeCd;
			ofrValType = data.ofrValType;
			ofrValAmt = data.ofrValAmt;
        },
		serializeGridData : function( data ){
			if($("#tierBnftTypeCd").val()=='undefined') {
				data.issType='N';
			}
			return data;
		},
        dataUrl : '<ifvm:action name="getCpnIssueOfferList"/>',
        columns:[
        	{
        		  field : 'id', headerText : 'id', visible : false 
        	  }
        	,{
        		  field : 'ofrNm', headerText : '<spring:message code="E00005"/>', textAlign : 'left', width:'170px', customAttributes : {searchable : true}
        	  }
        	,{
        		  field : 'ofrNo', headerText : '<spring:message code="E00004"/>', width:'80px', textAlign : 'center', customAttributes : {searchable : true}
        	  }
        	  /* ,{
          		  field : 'ofrTypeCdNm', headerText : '대유형', width:'130px', textAlign : 'center', customAttributes : {index : 'ofrTypeCd'}
          	  } */
          	  ,{
          		  field : 'ofrSubTypeCdNm', headerText : '유형', width:'80px', textAlign : 'center', customAttributes : {index : 'ofrSubTypeCd'} //소유형
          	  },{
          		  field : 'ofrValTypeNm', headerText : '가치 유형', textAlign : 'center', customAttributes : {index : 'ofrValType'} , visible : false
          	  },{
          		  field : 'ofrValAmt', headerText : '할인액(률)', textAlign : 'right', customAttributes : {index : 'ofrValAmt'}, template: "#ofrValueTemplate", width:'60px'
          	  },{
          		  field : 'useMinPurAmt', headerText : '구매최소금액', textAlign : 'right', customAttributes : {searchable : true}, width:'60px', template: '#useMinPurAmtTemplate'
          	  },{
          		  field : 'useMaxDcAmt', headerText : '최대할인', textAlign : 'right', customAttributes : {searchable : true}, width:'60px', template: '#useMaxDcAmtTemplate'
          	  }/*,{
          		  field : 'useDupYn', headerText : '타쿠폰중복', textAlign : 'center', customAttributes : {searchable : true}, width:'50px'
          	  } ,{	
          		  field : 'useChnlLimitYn', headerText : '사용 가능 채널', textAlign : 'center', customAttributes : {searchable : true}, width:'40px'
          	  } */,{
          		  field : 'useProdLimitYn', headerText : '사용 유형', textAlign : 'center', customAttributes : {searchable : true}, width:'70px', template: '#useProdLimitYnTemplate'
          	  }
          		 ,{
         		  field : 'usableMaxCnt', headerText : '사용 횟수', textAlign : 'center', customAttributes : {searchable : true}, width:'60px'
         	  }  
          	  ,{
          		  field : 'offYn', headerText : '매장전용', textAlign : 'center', customAttributes : {searchable : true}, width:'50px'
          	  }
//           	   ,{
//           		  field : 'vocYn', headerText : 'VoC지급', textAlign : 'center', customAttributes : {searchable : true, index: 'vocYn'}, width:'60px'
//           	  },{
//           		  field : 'empYn', headerText : '임직원지급', textAlign : 'center', customAttributes : {searchable : true, index: 'empYn'}, width:'60px'
//           	  }
          	  ,{
        		  field : 'ofrValType', headerText : 'id', visible : false 
        	  },{
        		  field : 'ofrValAmt', headerText : 'id', visible : false 
        	  }
        ],  
        requestGridData : {
      	  sidx : 'ofrNm',
        },
        radio: true,
        isHorizontalScroll: true
      };
	$("#offerListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function(){
	offerListSetting();
	
	$("#btnCommOfferPopSelect").click(function(){
		if(offerId == ''){
    		alert('<spring:message code="M00285"/>');
    	} else {
            var targetFields = ifvGlobal.searchHelp.field;
            $('#' + targetFields.rid).val(offerId);
            $('#' + targetFields.name).val(offerNm);
            $('#' + targetFields.no).val(offerNo);
            $('#' + targetFields.ofrSubType).val(ofrSubType);
            if(ofrType=='P') {
    			$("#ofrValType").val("F");
    			$("#ofrValAmt").attr("disabled",false);
    			$("#qty").attr("disabled",true);
    	    	$("#qty").val("");
    	    	/* $("#textLabel").text("원"); */
    		} else {
    			$("#ofrValType").val(ofrValType);
    			$("#ofrValAmt").val(ofrValAmt);
    			$("#ofrValAmt").attr("disabled",true);
    			$("#qty").attr("disabled",false);
    			/* $("#textLabel").text("%"); */
    		}
            if(ofrValType=='R' ) {
            	$("#textLabel").text("%");
            } else if (ofrValType=='F' || ofrValType=='B') {
            	$("#textLabel").text("원");
            }
            
            if(cpnYn=='Y') {
    	    	/* $("#qty").attr("disabled",false); */
    	    	$("#cpnYn").val("쿠폰");
    	    	/* $("#textLabel").text("원"); */
    	    } else {
    	    	/* $("#qty").attr("disabled",true); */
    	    	/* $("#qty").val(""); */
    	    	$("#cpnYn").val("");
    	    	/* $("#textLabel").text("Point"); */
    	    }
        	$.fn.ifvmPopupClose();
    	}
	});
	
	$("#btnCommOfferPopCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
});
</script>