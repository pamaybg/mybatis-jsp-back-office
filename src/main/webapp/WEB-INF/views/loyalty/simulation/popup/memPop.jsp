<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var validation;
var popSelectlId;

/* 팝업 닫기 */
function popupClose(){
	popupContainer._destroy();
}


$(function(){
	
	//고객유형코드
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'LOY_CUST_TYPE_CD'		
		, enableNA : true
	},function(result) {
		var temp = $("#custTypeCdTemp").tmpl(result.rows);
		$("#custTypeCd").append(temp);
	});
	
	//고객식별유형
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'LOY_IDENTI_TYPE_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#identiTypeCdTemp").tmpl(result.rows);
		$("#identiTypeCd").append(temp);
	});
	
	
	//회원상태
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'LOY_MEM_STAT_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#mbrStatCdTemp").tmpl(result.rows);
		$("#mbrStatCd").append(temp);
	});
	
	
	
	//회원유형	
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'LOY_MEM_TYPE_CD'		
		, enableNA : true
	},function(result) {
		var temp = $("#mbrTypeCdTemp").tmpl(result.rows);
		$("#mbrTypeCd").append(temp);
	});
	
	
	//if($.fn.ifvmIsNotEmpty(mbr_rid) && mbr_rid != "null") dataLoad(mbr_rid); //수정 시
	
});


//등급목록 저장
 function setMember(){
	var obj = {};
	var value = false;
	prodChk = true;
	validation = $("#memNewFormArea").ifvValidation();

	if(validation.confirm()){
		obj.ridBrdCat 		= $("#brdNm").text();
		obj.ridCust 		=  $("#ridCust").text();     
		obj.custTypeCd 		=  $("#custTypeCd").val();      
		obj.identiTypeCd 	=  $("#identiTypeCd").val();      
		obj.identiVal 		=  $("#identiVal").val();
		obj.mbrNo 			=  $("#mbrNo").val();           
		obj.mbrStatCd 		=  $("mbrStatCd").val();      
		obj.mbrTypeCd 		=  $("mbrTypeCd").val();      
		obj.joinDate 		=  $("joinDate").val();     
		obj.ridTierCur 		=  $("ridTierCur").text();      
		obj.curTierSelDate 	=  $("curTierSelDate").val();      
		obj.ridChnlJoin 	=  $("ridChnlJoin").text();     
		obj.ridPgm 			=  $("ridPgm").text();     
		
		obj.hhpNo 			=  $("#hhpNo").val(); 
		obj.homeTelNo 		=  $("#homeTelNo").val();
		obj.emailAddr 		=  $("#emailAddr").val();
		obj.grpCustEmpName 	=  $("#grpCustEmpName").val();
		obj.addr1Zip 		=  $("#addr1Zip").val();		
		obj.addr1Dflt 		= $("#addr1Dflt").val();
		obj.addr1Dtl 		=  $("#addr1Dtl").val();
		
		obj.mktAgrePrvInfo 	=  $.fn.ifvmGetChekBoxValue("#realnmCertiYn");
		obj.mktAgreUse     	=  $.fn.ifvmGetChekBoxValue("#mktAgreUse");
		obj.mktAgreThirdSnd =  $.fn.ifvmGetChekBoxValue("#mktAgreThirdSnd");
		obj.chnlAgreSms     =  $.fn.ifvmGetChekBoxValue("#chnlAgreSms");
		obj.chnlAgreEmail   =  $.fn.ifvmGetChekBoxValue("#chnlAgreEmail");
		obj.chnlAgreTel     =  $.fn.ifvmGetChekBoxValue("#chnlAgreTel");
		obj.chnlAgreDm      =  $.fn.ifvmGetChekBoxValue("#chnlAgreDm");
		obj.chnlAgrePush    =  $.fn.ifvmGetChekBoxValue("#chnlAgrePush");
		$.ifvSyncPostJSON('<ifvm:action name="addMbr"/>',obj
		,function(result) {
			alert('<spring:message code="M00623"/>');
			memList();
			memPopupClose();
		});
	}
} 
 
$(document).ready(function(){
	$("#memNewFormArea").ifvValidation();
	
	
	// 취소 버튼
	$("#memNewPopCancel").on("click", memPopupClose);
	
	// 저장 버튼
 	$("#memNewSaveBtn").on("click", function(){
		setMember();
	}); 
	
 	/* 채널 조회 팝업  */
	$('#btnFundRidChnlJoinPop').on('click',function(){
		popSelectlId = "ridChnlJoin";
		$("#popupContainer").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="chnlPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="L00075"/>',
	        width: '700px',
	        close : 'popupClose'
	    });   
    });
	
	/* 고객 팝업  */
	$('#btnFundRidCustPop').on('click',function(){
		popSelectlId = "ridCust";
		$("#popupContainer").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="custPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="L00439"/>',
	        width: '700px',
	        close : 'popupClose'
	    });   
    });
		
	
	
	/* 프로그램 조회 팝업  */
	$('#btnFundRidPgmPop').on('click',function(){
		/* popSelectlId = "ridPgm";
		$("#popupContainer").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="pgmPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="L00077"/>',
	        width: '700px',
	        close : 'popupClose'
	    });   */   
		var targetFields = { rid: "ridPgm" };
        //var searchCond = { repYn: "Y" };
        $.fn.ifvmSearchHelpOpen(targetFields, null, 'popupContainer', '<ifvm:url name="pgmPop"/>', '<spring:message code="L00077"/>', 700);
    });
	
	
	$('#btnAddrZip1Pop').on('click',function(){
		execDaumPostcode('addr1Zip', 'addr1Dflt', 'addr1Dtl');
	});
	
	

});

function execDaumPostcode(zipcode, addr1, addr2) {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                fullAddr = data.roadAddress;

            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                fullAddr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
            if(data.userSelectedType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
        //    document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
        //    document.getElementById('sample6_address').value = fullAddr;
            $("#"+zipcode).val(data.zonecode);
            $("#"+addr1).val(fullAddr);
            $("#"+addr2).focus();
          	

            // 커서를 상세주소 필드로 이동한다.
        //    document.getElementById('sample6_address2').focus();
        }
    }).open();
}
	
</script>


<!-- 고객유형 -->
<script id="custTypeCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<!--식별 유형 코드  -->
<script id="identiTypeCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<!-- 회원유형 -->
<script id="mbrTypeCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<!-- 회원상태  -->
<script id="mbrStatCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>


<div id='memNewFormArea'>
	<div class="pop_inner_wrap form-horizontal">
		<div class="row  qt_border">
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00320"/></label>	
			<div class="col-xs-4 control_content">
				<div class="input-group">
				<ifvm:input type="text" disabled="true" required="true" id="ridCust"/>
				<span class="input-group-addon" id="btnFundRidCustPop">
						<a><i class="fa fa-search"></i></a>
				</span>
			   </div>
			</div>
			
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00318"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="select" disabled="true" required="true" id="custTypeCd"/>
			</div>
		
		</div> 
		<div class="row  qt_border">	
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00343"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="select" disabled="true" required="true" id="identiTypeCd" />
			</div>
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00342"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" disabled="true" required="true"  id="identiVal"/>
			</div>
		</div>	
	
		<div class="page_btn_area" id="headForm">
			<div class="col-xs-7">
				<span><spring:message code="M00939"/></span>
			</div>	
		</div>
		<div class="row qt_border"></div>
		<div class="row qt_border">
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00688"/></label>
			<div class="col-xs-4 control_content">
					<ifvm:input type="text" disabled="true" required="true" id="mbrNo"/>
			</div>
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M02096" /></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="select" disabled="true" required="true" id="mbrStatCd" />
			</div>
		</div>
		
		<div class="row qt_border">		
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00434"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="select" required="true" id="mbrTypeCd"/>				
			</div>
			<label class="col-xs-2 control-label"><spring:message code="L00311"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" disabled="true" id="joinDate" />
			</div>
		</div>
	
		<div class="row qt_border">		
			<label class="col-xs-2 control-label"><spring:message code="L00429"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" disabled="true" id="ridTierCur"/>				
			</div>
			<label class="col-xs-2 control-label"><spring:message code="L00460"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" id="curTierSelDate" disabled="true" />
			</div>
		</div>
	
		<div class="row qt_border">		
			<label class="col-xs-2 control-label"><spring:message code="L00312"/></label>
			<div class="col-xs-4 control_content">
				<div class="input-group">
				<ifvm:input type="text"  id="ridChnlJoin" disabled="true" />	
				<span class="input-group-addon" id="btnFundRidChnlJoinPop">
						<a><i class="fa fa-search"></i></a>
				</span>
			   </div>			
			</div>
			<label class="col-xs-2 control-label"><spring:message code="L00119"/></label>
			<div class="col-xs-4 control_content">
				<div class="input-group">
				<ifvm:input type="text"  id="ridPgm" disabled="true" />
				<span class="input-group-addon" id="btnFundRidPgmPop">
						<a><i class="fa fa-search"></i></a>
				</span>
			   </div>
			</div>
		</div>
	
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L00380"/></span>
			</div>
		</div>
		<div class="row  qt_border"></div>
		<div class="row  qt_border">
			<label class="col-xs-2 control-label"><spring:message code="L00436"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" id="hhpNo" />
			</div>
			<label class="col-xs-2 control-label"><spring:message code="L00404"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" id="homeTelNo" />
			</div>
		</div> 
		<div class="row qt_border">
			<label class="col-xs-2 control-label"><spring:message code="M00583"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" id="emailAddr" />
			</div>
			<label class="col-xs-2 control-label"><spring:message code="L00323"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" id="grpCustEmpName" />
			</div>
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-2 control-label"><spring:message code="L00383"/></label>
			<div class="col-xs-3 control_content">
				<div class="input-group">
					<ifvm:input type="text" id="addr1Zip" />				
					<span class="input-group-addon" id="btnAddrZip1Pop">
					   <a><i class="fa fa-search"></i></a>
					</span>
				</div>						
			</div>
			<div class="col-xs-7 control_content">
				<ifvm:input type="text" readonly="true" id="addr1Dflt" />
			</div>
	   </div>
		<div class="row qt_border">
			<label class="col-xs-2 control-label"><spring:message code="L00372"/></label>
			<div class="col-xs-10 control_content">
				<ifvm:input type="text" id="addr1Dtl" />
			</div>
	   </div>
		
		<div class="page_btn_area">
			<div class="col-xs-7">
				<span><spring:message code="L00327"/></span>
			</div>
		</div>
		<div class="row  qt_border"></div>
		<div class="row  qt_border">
			<label class="col-xs-3 control-label"><spring:message code="L00315"/></label>				
			<div class="col-xs-1 control_content">
				<label class="checkbox-inline">
				<ifvm:input type="checkbox" id="mktAgrePrvInfo" />
				</label>
			</div>
			<label class="col-xs-3 control-label"><spring:message code="L00328"/></label>
			<div class="col-xs-1 control_content">
				<label class="checkbox-inline">
				<ifvm:input type="checkbox" id="mktAgreUse" />
				</label>
			</div>
			<label class="col-xs-3 control-label"><spring:message code="L00401"/></label>
			<div class="col-xs-1 control_content">
			<label class="checkbox-inline">
		        <ifvm:input type="checkbox" id="mktAgreThirdSnd" />
    			</label>					
			</div>
		</div>
		<div class="row  qt_border">	
			<label class="col-xs-3 control-label"><spring:message code="L00330"/></label>
			<div class="col-xs-1 control_content">
				<label class="checkbox-inline">
				<ifvm:input type="checkbox" id="chnlAgreSms" />
				</label>
			</div>
			<label class="col-xs-3 control-label"><spring:message code="L00307"/></label>
			<div class="col-xs-1 control_content">
				<label class="checkbox-inline">
				<ifvm:input type="checkbox" id="chnlAgreEmail" />
				</label>
			</div>
			<label class="col-xs-3 control-label"><spring:message code="L00308"/></label>
			<div class="col-xs-1 control_content">
				<label class="checkbox-inline">
				<ifvm:input type="checkbox" id="chnlAgreTel" />
				</label>
			</div>
		</div>
		<div class="row">
			<label class="col-xs-3 control-label"><spring:message code="L00306"/></label>
			<div class="col-xs-1 control_content">
				<label class="checkbox-inline">
				<ifvm:input type="checkbox" id="chnlAgreDm" />
				</label>
			</div>
			<label class="col-xs-3 control-label"><spring:message code="L00346"/></label>
			<div class="col-xs-1 control_content">
				<label class="checkbox-inline">
				<ifvm:input type="checkbox" id="chnlAgrePush" />
				</label>
			</div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="memNewSaveBtn">       
		<i class="glyphicon glyphicon-check"></i>  
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="memNewPopCancel">         
		<spring:message code="M00284"/>
	</button>  
</div>
<div id="popupContainer" class="popup_container"></div><!-- 팝업 -->
