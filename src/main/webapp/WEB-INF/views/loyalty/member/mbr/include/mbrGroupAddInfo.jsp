<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="save" text="L00074"  btnFunc="gMbrGroupAddInfo.save" objCode="mbrGroupaddSave_OBJ"/>
        </div>
    </div>
    <div class="form-horizontal underline top_well" id="mbrGroupAddInfoForm" >
    	<div class="row">
			<div class="col-xs-6">
				<ifvm:inputNew type="select" id="ouTypeCd"   dto="ouTypeCd"    disabled="true"
					label="L01487" labelClass="3" conClass="3" /><!-- 단체유형 -->
				<ifvm:inputNew type="text" id="chnlNm"   dto="chnlNm"
					label="L01481" labelClass="3" conClass="3" /><!-- 단체상호-->

	    	</div>
	    	<div class="col-xs-6">
				<ifvm:inputNew type="text" id="mbrbsCdadd"   dto="mbrbsCdadd"
					label="L01482" labelClass="3" conClass="3" /><!-- 단체약호 -->
				<ifvm:inputNew type="text" id="reprNm"   dto="reprNm"    disabled="true" className="clubEdit corpEdit"
					label="L01489" labelClass="3" conClass="3" /><!-- 대표자명 -->
	    	</div>
    	</div>

    	<div class="row">
			<div class="col-xs-6">
				<ifvm:inputNew type="search" id="zipCd|zipCdBtn" names="zipCd" hidId="zipCdTemp" hidDto="zipCdTemp" dto="zipCd"
				   btnFunc="addrSearchHelpBtn" searchBlurEvent="addrSearchHelpBlur" searchEnterEvent="addrSearchHelpEnter" label="L01483"
				   labelClass="3" conClass="3" className="clubEdit corpEdit" />

				<ifvm:inputNew type="text" id="email"   dto="email"    disabled="true" className="clubEdit corpEdit" valiItem="email"
					label="L01484" labelClass="3" conClass="3" /><!-- 이메일 -->
				<ifvm:inputNew type="hidden" id="parRid"   dto="parRid" className="dnatEdit afflEdit" /><!-- 적립기준코드 rid -->
	    	</div>
	    	<div class="col-xs-6">
				<ifvm:inputNew type="search" id="parChnlNo|parChnlNoBtn"   dto="parChnlNo" className="dnatEdit afflEdit"	btnFunc="channelSearchHelpPopOpen"
					label="L01488" labelClass="3" conClass="3" /><!-- 상위가맹점코드 -->
				<ifvm:inputNew type="text" id="parChnlNm"   dto="parChnlNm" className="dnatEdit afflEdit"	disabled="true"
					labelClass="3" conClass="6" /><!-- 상위가맹점명 -->
				<script>
					function channelSearchHelpPopOpen(){
						channelSearchHelpPop ={
						        id : "channelSearchPopDiv"
						    };
					channelSearchHelpPop.popup = function (){
						channelSearchHelpPop.pop = $('#'+channelSearchHelpPop.id).ifvsfPopup({
						            enableModal: true,
						            enableResize: false,
						            contentUrl: '<ifvm:url name="channelSearchHelp"/>'+ '?ouTypeCd=4',
						            contentType: "ajax",
						            title: "<spring:message code='L00987'/>",
						            width: '700px'
						        });
						};
						channelSearchHelpPop.beforeClose = function (obj) {
							console.log(obj);
							$("#mbrGroupAddInfoForm #parChnlNm").val(obj.chnlNm);
				        	$("#mbrGroupAddInfoForm #parChnlNo").val(obj.chnlNo);
				        	$("#mbrGroupAddInfoForm #parRid").val(obj.rid);
						};
						channelSearchHelpPop.close = function (obj) {
							 if(obj!=null || typeof obj!="undefined"){
								 this.beforeClose(obj);
							 }
						     channelSearchPopDiv._destroy();
						 };
						channelSearchHelpPop.popup();
					}

				</script>
	    	</div>
    	</div>

		<div class="row">
			<div class="col-xs-6">

				<ifvm:inputNew type="text" id="adrDtl"  dto="adrDtl"   	label="L01865" 	labelClass="3" conClass="9" disabled="true"/>
				<!-- 주소 -->
	    	</div>
	    	<div class="col-xs-6">
				<ifvm:inputNew type="text" id="bizrNo"   dto="bizrNo"    disabled="true" className="clubEdit corpEdit"
					label="L01491" labelClass="3" conClass="3" /><!-- 사업자번호 -->
				<ifvm:inputNew type="text" id="faxNo"   dto="faxNo"    disabled="true" className="clubEdit corpEdit"
					label="L01492" labelClass="3" conClass="3" /><!-- 팩스번호 -->
	    	</div>
    	</div>

		<div class="row">
			<div class="col-xs-6">
			    <ifvm:inputNew type="text" id="roadNmAdr"  dto="roadNmAdr"  label="L00640" 	labelClass="3" conClass="9" disabled="true"/>

	    	</div>
	    	<div class="col-xs-6">
				<ifvm:inputNew type="text" id="telNo"   dto="telNo"    disabled="true" className="clubEdit corpEdit"
					label="L01493" labelClass="3" conClass="3" /><!-- 전화번호 -->
				<ifvm:inputNew type="text" id="hpNo"   dto="hpNo"    disabled="true" className="clubEdit corpEdit"
					label="L01494" labelClass="3" conClass="3" /><!-- 핸드폰번호 -->
	    	</div>
    	</div>
    	<div class="half_wrap top_well">
			<div class="half_content half_left qt_border">
				<div class="page_btn_area">
					<div class="col-xs-12">
						<span><spring:message code="L01495"/></span><!-- 가입정보 -->
					</div>
				</div>
				<div class="form-horizontal top_well underline" id="" >
					<div class="row">
						<ifvm:inputNew type="text" id="sbscDd"   dto="sbscDd"    disabled="true"
							label="L01496" labelClass="3" conClass="3" /><!-- 가입일자 -->

						<ifvm:inputNew type="text" id="trmnDd"   dto="trmnDd"    disabled="true"
							label="L01498" labelClass="3" conClass="3" /><!-- 해지일자 -->
					</div>
					<div class="row">
						<ifvm:inputNew type="hidden" id="ridAcrlRule"   dto="ridAcrlRule"	className="clubEdit" /><!-- 적립기준코드 rid -->
						<ifvm:inputNew type="search" id="ruleCd|ruleCdBtn"   dto="ruleCd" className="clubEdit"	searchEnterEvent="acrlStandardSearchHelpEnter"	btnFunc="acrlStandardSearchHelpBtn"
							label="L01497" labelClass="3" conClass="3" /><!-- 적립기준코드 -->
						<ifvm:inputNew type="text" id="ruleTypeCd"   dto="ruleTypeCd"    disabled="true"
							labelClass="3" conClass="6" /><!-- 적립기준설명 -->
					</div>
					<script>
					function acrlStandardSearchHelpBtn() {
					    openAcrlStandardSearchHelp('<ifvm:url name="pointSearchHelp"/>?typeCd=A');
					}
					function acrlStandardSearchHelpEnter() {

					    if ($('#acrlRuleCd').val() == "") {
					        $('#ridAcrlRule').val("");
					        $('#acrlRuleTypeCd').val("");
					    }
					    else {
					        openAcrlStandardSearchHelp('<ifvm:url name="pointSearchHelp"/>?typeCd=A&ruleCd=' + encodeURI(encodeURIComponent($('#acrlRuleCd').val())));
					    }
					}
					function openAcrlStandardSearchHelp(url) {
					    pointSearchHelpPop = {
					        id : "chnlAddInfoPopupContainer"
					    };
					    pointSearchHelpPop.popup = function() {
					        pointSearchHelpPop.pop = $('#' + pointSearchHelpPop.id).ifvsfPopup({
					            enableModal : true,
					            enableResize : false,
					            contentUrl : url,
					            contentType : "ajax",
					            title : '<spring:message code="L00884"/>',
					            width : '700px',
					            close : pointSearchHelpPop.close
					        });
					    };
					    pointSearchHelpPop.beforeClose = function(obj) {
					    	$("#ruleCd").val(obj.ruleCd);
				            $("#ruleTypeCd").val(obj.ruleTypeCd);
				            $("#ridAcrlRule").val(obj.rid);
					    };
					    pointSearchHelpPop.close = function(obj) {
					        if (obj != null && obj.type != "close") {
					            pointSearchHelpPop.beforeClose(obj);
					        }
					        chnlAddInfoPopupContainer._destroy();
					    };
					    pointSearchHelpPop.popup();

					}
					</script>
					<div class="row">
						<ifvm:inputNew type="text" id="rmark"   dto="rmark"    disabled="true"	className="clubEdit"
							label="L01500" labelClass="3" conClass="9" /><!-- 비고 -->
					</div>
				</div>
			</div>
			<div class="half_content half_right">
				<div class="page_btn_area">
					<div class="col-xs-12">
						<span><spring:message code="L01501"/></span><!-- 기부단체정보 -->
					</div>
				</div>
				<div class="form-horizontal top_well underline" id="" >
					<div class="row">
						<ifvm:inputNew type="date" id="dnatStartDay"   dto="dnatStartDay"    disabled="true" className="dnatEdit"
							label="L00886" labelClass="3" conClass="3" /><!-- 기부시작일 -->
						<ifvm:inputNew type="date" id="dnatEndDay"   dto="dnatEndDay"    disabled="true" className="dnatEdit"
							label="L00887" labelClass="3" conClass="3" /><!-- 기부종료일 -->
					</div>
					<div class="row">
						<ifvm:inputNew type="date" id="fndDd"   dto="fndDd"    disabled="true" className="dnatEdit"
							label="L00888" labelClass="3" conClass="3" /><!-- 설립일자 -->
					</div>
					<div class="row">
						<ifvm:inputNew type="text" id="oprtPrps"   dto="oprtPrps"    disabled="true" className="dnatEdit"
							label="L00889" labelClass="3" conClass="9" /><!-- 운영목적 -->
					</div>
				</div>
			</div>
		</div>
		<div class="page_btn_area" >
	        <div class="col-xs-7">
	            <span><spring:message code="L01502" /></span><!-- 부정동호회 정보 -->
	        </div>
	    </div>
		<div class="row">
			<div class="col-xs-6">
				<ifvm:inputNew type="select" id="fraudDiv"   dto="fraudDiv"    disabled="true" className="clubEdit"
					label="L01579" labelClass="3" conClass="3" /><!-- 부정동호회 구분 -->
				<ifvm:inputNew type="select" id="fraudMbrbsActnDiv"   dto="fraudMbrbsActnDiv"    disabled="true"	className="clubEdit"
					label="L01580" labelClass="3" conClass="3" /><!-- 부정동호회 조치구분 -->
			</div>
			<div class="col-xs-6">
				<ifvm:inputNew type="text" id="fraudMbrbsActnDesc"   dto="fraudMbrbsActnDesc"    disabled="true" className="clubEdit"
					label="L01581" labelClass="3" conClass="9" /><!-- 부정동호회 조치설명 -->
			</div>

			<ifvm:inputNew type="hidden" id="rid"  dto="rid"    labelClass="0" conClass="9" />
		    <ifvm:inputNew type="hidden" id="sido"  dto="sido"    labelClass="0" conClass="9" />
		    <ifvm:inputNew type="hidden" id="gugun"  dto="gugun"    labelClass="0" conClass="9" />
		    <ifvm:inputNew type="hidden" id="roadNmAdrZipCd"  dto="roadNmAdrZipCd"    labelClass="0" conClass="9" />
		</div>
    </div>
</div>
<script>

var zipCdTemp;

gMbrGroupAddInfo  = {
		data : {},
		dateTimeFieldId : ['trmnDd', 'sbscDd'],
		dateFieldId : ['dnatStartDay', 'dnatEndDay', 'sbscDd', 'fndDd'],
		phoneFieldId : ['faxNo', 'telNo', 'hpNo'],
		init : function(){
			$.ifvGetCommCodeList('select', 'mbrGroupAddInfoForm #ouTypeCd', '<ifvm:action name="getCommCodeList2"/>', 'PARTNER_TYPE', 'loy', false, false, true);

			$("#fraudDiv").change(function(){
				var statCd  = $(this).find('option:selected').val();
				if(statCd == 'BL41'){
					$("#fraudMbrbsActnDiv").prop('disabled',false);
					$.fn.ifvGetHierarchySelect("mbrGroupAddInfoForm #fraudMbrbsActnDiv", '<ifvm:action name="getHierarchyCommCodeList"/>', 'PARTNER_BL_RESULT', statCd, false);
				}else{
					$("#fraudMbrbsActnDiv").empty().prop('disabled',true);
				}
			})

			this.dateInit();
			this.loadData();
		},
		dateInit : function(){
			var dnatStartDay  = $('#dnatStartDay');
			dnatStartDay.val();
			dnatStartDay.ifvDateChecker({});

		    var dnatEndDay  = $('#dnatEndDay');
		    dnatEndDay.val();
		    dnatEndDay.ifvDateChecker({});

		    var fndDd  = $('#fndDd');
		    fndDd.val();
		    fndDd.ifvDateChecker({});

		},
		setDateTimeField : function(){
			for(var pi = 0 ; pi < this.dateTimeFieldId.length ; pi++){
				var _pval = $("#"+this.dateTimeFieldId[pi]).val();
				var _aval="";
				if(_pval){
					_aval = _pval.split('.')[0];
				}
				$("#mbrGroupAddInfoForm #"+this.dateTimeFieldId[pi]).val(_aval);
			}
		},
		setDateField : function(){
			for(var pi = 0 ; pi < this.dateFieldId.length ; pi++){
				var _pval = $("#"+this.dateFieldId[pi]).val();
				var _aval="";
				if(_pval){
					_aval = _pval.split(' ')[0].replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
				}
				$("#mbrGroupAddInfoForm #"+this.dateFieldId[pi]).val(_aval);
			}
		},
		setPhoneField : function(){
			for(var pi = 0 ; pi < this.phoneFieldId.length ; pi++){
				var _pval = $("#"+this.phoneFieldId[pi]).val();
				var _aval="";
				if(_pval){
					_aval = _pval.replaceAll("-","");
					if(_aval.length==11){
						_aval = _pval.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3')
					}
					if(_aval.length==10){
						_aval = _pval.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3')
					}
					if(_aval.length==9){
						_aval = _pval.replace(/(\d{2})(\d{3})(\d{4})/, '$1-$2-$3')
					}
					if(_aval.length==8){
						_aval = _pval.replace(/(\d{4})(\d{4})/, '$1-$2')
					}

				}
				$("#mbrGroupAddInfoForm #"+this.phoneFieldId[pi]).val(_aval);
			}
		},
		clearMasking : function(result){
			var targetField = [{
				type : 'chnl',
				field : 'phone',
				rid : $.ifvGetParam('rid'),
				target : 'hpNo'
			}]

			for (var i=0  ; i < targetField.length ; i++){
				$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>',
						targetField[i],
		        function(result) {
					$("#"+targetField[i].target).val(result.message);
					if(result.message){
						gMbrGroupAddInfo.data[targetField[i].target] = result.message.replaceAll('-','');
					}
			     })
			}
		},
		loadData : function(){
			fnFilter = function(){
				$(this).prop('disabled',false);
				$("#zipCd").prop('disabled',true);
				$("#parChnlNo").prop('disabled',true);
				$("#ruleCd").prop('disabled',true);


				$("#"+this.id+"Btn").show();
			}
			var action ='<ifvm:action name="getMbrGroupAddInfo"/>';
			$.ifvSyncPostJSON(action, {
				rid: $.ifvGetParam('rid')
			}, function(result) {

				if ($.fn.ifvmIsNotEmpty(result)) {
					gMbrGroupAddInfo.data = result;
					zipCdTemp = result.zipCd;
					gMbrGroupAddInfo.clearMasking(result);
					//edit field setting 6:동호회 7:법인택시 8:기부단체 9:제휴단체
					$(".input-group-addon").hide();
					switch(result.ouTypeCd){
						case "6":
							$("#mbrGroupAddInfoForm .clubEdit").filter(fnFilter)
							break;
						case "7":
							$("#mbrGroupAddInfoForm .corpEdit").filter(fnFilter)
							break;
						case "8":
							$("#mbrGroupAddInfoForm .dnatEdit").filter(fnFilter)
							break;
						case "9":
							$("#mbrGroupAddInfoForm .afflEdit").filter(fnFilter)
							break;
						default :
							break;
					}

					$.fn.ifvGetHierarchySelect("mbrGroupAddInfoForm #fraudDiv", '<ifvm:action name="getHierarchyCommCodeList"/>', 'PARTNER_BL_TYPE', '4', false);
		            $.fn.ifvGetHierarchySelect("mbrGroupAddInfoForm #fraudMbrbsActnDiv", '<ifvm:action name="getHierarchyCommCodeList"/>', 'PARTNER_BL_RESULT', result.fraudDiv, false);
		            if(result.fraudDiv == "BL41"){
		            	$("#mbrGroupAddInfoForm #fraudMbrbsActnDiv").prop('disabled',false);
		            }else{
		            	$("#mbrGroupAddInfoForm #fraudMbrbsActnDiv").prop('disabled',true);
		            }
		            $("#mbrGroupAddInfoForm").dataSetting(result);
		            gMbrGroupAddInfo.setDateTimeField();
					gMbrGroupAddInfo.setDateField();
					gMbrGroupAddInfo.setPhoneField();
		            /* $.ifvGetCommCodeList('select', 'mbrGroupAddInfoForm #fraudDiv', '<ifvm:action name="getCommCodeList2"/>', 'PARTNER_BL_TYPE', 'loy', false, false, true);
					$.ifvGetCommCodeList('select', 'mbrGroupAddInfoForm #fraudMbrbsActnDiv', '<ifvm:action name="getCommCodeList2"/>', 'PARTNER_BL_RESULT', 'loy', false, false, true); */

				}
			})
		},
		save : function(){

			fnFilter = function(){
				var param = $(this).attr('dtoparam');
				var val = $(this).val();
				data[param] = val;
				if(gMbrGroupAddInfo.phoneFieldId.indexOf(param)){
					if(val){
						data[param] = val.replaceAll("-","");
					}
				}
			}


			var validation = $("#mbrGroupAddInfoForm").ifvValidation();
			if(validation.confirm()){

				var tgtData = $("#mbrGroupAddInfoForm").getSubmitData();
				data = gMbrGroupAddInfo.data;
				data.chnlNm = tgtData.chnlNm;
				data.mbrbsCdadd = tgtData.mbrbsCdadd;
				data.sido = tgtData.sido;
				data.gugun = tgtData.gugun;
				data.roadNmAdrZipCd = tgtData.roadNmAdrZipCd;
				data.adrDtl = tgtData.adrDtl;
				data.roadNmAdr = tgtData.roadNmAdr;
				//변경 할 수 있는 데이터 update
				switch(gMbrGroupAddInfo.data.ouTypeCd){
					case "6":
						$("#mbrGroupAddInfoForm .clubEdit").filter(fnFilter)
						break;
					case "7":
						$("#mbrGroupAddInfoForm .corpEdit").filter(fnFilter)
						break;
					case "8":
						$("#mbrGroupAddInfoForm .dnatEdit").filter(fnFilter)
						break;
					case "9":
						$("#mbrGroupAddInfoForm .afflEdit").filter(fnFilter)
						break;
					default :
						break;
				}
				if(data.email){
					data.email = data.email.toLowerCase();//이메일은 소문자로만 저장...
				}
				if(data.hpNo){
					data.hpNo = data.hpNo.replaceAll('-','');
				}
				data.rid = $.ifvGetParam('rid');
				console.log(data);
				var action = '<ifvm:action name="editMbrGroupAddInfo"/>';
				$.ifvSyncPostJSON(action, data , function(result) {

					if (result.success) {
						alert('<spring:message code="L01260"/>');
						gMbrGroupAddInfo.loadData();
						gGroupDetail.loadData()
					}
				}, function(result){
					alert(result.message);
				})
			}
		}
	}


function addrSearchHelpBlur(){

	$('#zipCd').val(zipCdTemp);


}
function addrSearchHelpBtn(){

	addrSearchHelp();

}

function addrSearchHelpEnter(){
		addrSearchHelp();


}


function addrSearchHelp(){

		addrSearchHelpPop ={
			        id : "addrPopupContainer"
			    };
		addrSearchHelpPop.popup = function (){
			addrSearchHelpPop.pop = $('#'+addrSearchHelpPop.id).ifvsfPopup({
			            enableModal: true,
			            enableResize: false,
			            contentUrl: '<ifvm:url name="zipCodeListPop"/>',
			            contentType: "ajax",
			            title: '<spring:message code="L00442"/>',
			            width: '700px',
			            close: addrSearchHelpPop.close
			        });
			};
			addrSearchHelpPop.beforeClose = function (obj) {
			};
			addrSearchHelpPop.close = function (obj) {
				 if(obj!=null&&obj.type!="close"){
					 if(obj=="reset"){
						 zipCdTemp = null;
					 }else{
						 zipCdTemp = obj.zipNo;
					 }
			        	$("#zipCd").val(obj.zipNo);
			        	$("#roadNmAdrZipCd").val(obj.zipNo);
			        	$("#adrDtl").val(obj.jibunAddr +' ' + obj.dtlAddr);
			        	$("#roadNmAdr").val(obj.roadAddr +' ' + obj.dtlAddr);

			        	$("#sido").val(obj.siNm);
			        	$("#gugun").val(obj.sggNm);

				 }else{
					 $("#zipCd").val(zipCdTemp);
				 }
				 addrSearchHelpPop.beforeClose(obj);
				    addrPopupContainer._destroy();
			 };
			 addrSearchHelpPop.popup();


}




gMbrGroupAddInfo.init();
</script>
<div id="channelSearchPopDiv" class="popup_container"></div><!--상위가맹점 조회  -->
<div id="chnlAddInfoPopupContainer" class="popup_container"></div><!--적립기준코드  -->
<div id="addrPopupContainer" class="popup_container"></div><!-- 팝업 -->
