<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="form-horizontal  top_well " id="mbrDetailForm">
<br>
	<div  class="form-horizontal  top_well"  id="custValidForm">
		<div class="page_btn_area"> <spring:message code="기본정보"/> </div>
		<div class="row qt_border">
			<ifvm:inputNew type="search" id="pgmNm" dto="pgmNm" label="프로그램" labelClass="1" conClass="3" required="true" disabled="true" /><%-- btnFunc="getPgmList" --%>
	 		<ifvm:inputNew type="hidden" id="pgmNo" dto="pgmNo" conClass="1" required="true" disabled="true"/>
	 		<ifvm:inputNew type="search" id="chnlNm" dto="chnlNm" label="V00132" labelClass="1" conClass="3" required="true" disabled="true" /><%-- btnFunc="getChnlList" --%>
	 		<ifvm:inputNew type="hidden" id="chnlNo" dto="chnlNo"  conClass="1" required="true" disabled="true"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="select" id="mbrTypeCd" names="mbrTypeCd" dto="mbrTypeCd"  label="회원유형" labelClass="1" conClass="3" required="true" disabled="true"/>
			<ifvm:inputNew type="select" id="certTypeCd" names="certTypeCd" dto="certTypeCd"  label="인증유형" labelClass="1" conClass="2" required="true" />
			<ifvm:inputNew type="hidden" id="certVal" names="certVal" dto="certVal"  conClass="1"/>
			<button class="btn btn-sm btn_gray"  id="getCert" objCode="getCert_OBJ">
				<spring:message code="본인인증" />
			</button> 
		</div>
		<div id="baseForm">
			<div class="row qt_border" id="rowArea1">
				<div id="cust_nmArea">
					<ifvm:inputNew type="text" id="cust_nm"  names="cust_nm" dto="cust_nm"  label="이름" labelClass="1" conClass="3"/>
				</div>
				<div id="cust_ceoArea">
					<ifvm:inputNew type="text" id="ceo"  names="ceo" dto="ceo" label="대표자명" labelClass="1" conClass="2" />
				</div>
				<div id="telArea">
                <label class="control-label col-xs-2">담당자 유선전화</label>
                    <ifvm:inputNew type="hidden" id="tel_no" names="tel_no" dto="tel_no"  conClass="1" maxLength="11" />                 
                    <div class="control_content col-xs-1">
                        <input type="text" id="telTop" name="telTop"  maxLength="3" onchange="checkTel()"/>                 
                    </div>
                    <div class="control_content col-xs-1">
                        <input type="text" id="telMid" name="telMid"  maxLength="4" onchange="checkTel()"/>                 
                    </div>
                    <div class="control_content col-xs-1">
                        <input type="text" id="telBot" name="telBot"  maxLength="4" onchange="checkTel()"/>                 
                    </div>
                </div>
<!-- 				<div id="gen_cdArea"> -->
<%-- 					<ifvm:inputNew type="select" id="gen_cd" names="gen_cd" dto="gen_cd" label="성별" labelClass="1" conClass="3" /> --%>
<!-- 				</div> -->
			</div>
			<div class="row qt_border" id="rowArea2">
			      	<ifvm:inputNew type="text" id="bizrNo" dto="bizrNo" disabled="true" label="사업자번호" title="사업자번호" labelClass="1" conClass="6" />
			        <ifvm:inputNew type="text" id="induty" dto="induty" label="업종/업태" labelClass="1"  conClass="2" title="업종" disabled="true" />
                    <ifvm:inputNew type="text" id="bizcnd" dto="bizcnd" disabled="true" title="업태" conClass="2"/>
                                 
			
<!-- 				<div id="birthdtArea"> -->
<%-- 					<ifvm:inputNew type="date" id="birthdt" names="birthdt" dto="birthdt" label="생년월일" labelClass="1" conClass="2"/> --%>
<!-- 				</div> -->
<!-- 				<div id="lunar_cdArea"> -->
<%-- 					<ifvm:inputNew type="select" id="lunar_cd" names="lunar_cd" dto="lunar_cd" conClass="1"/> --%>
<!-- 				</div> -->
                <ifvm:inputNew type="text" id="charger" dto="charger" label="담당자명" labelClass="1"  conClass="3" title="담당자명" disabled="true" />

				<div id="hhpArea">
				<label class="control-label col-xs-1">휴대전화</label>
					<ifvm:inputNew type="hidden" id="hhp" names="hhp" dto="hhp"  conClass="1" maxLength="11" />					
					<div class="control_content col-xs-1">
						<input type="text" id="hhpTop" name="hhpTop"  maxLength="3" onchange="checkHhp()"/>					
					</div>
					<div class="control_content col-xs-1">
						<input type="text" id="hhpMid" name="hhpMid"  maxLength="4" onchange="checkHhp()"/>					
					</div>
					<div class="control_content col-xs-1">
						<input type="text" id="hhpBot" name="hhpBot"  maxLength="4" onchange="checkHhp()"/>					
					</div>
				</div>				
				<div id="emailArea">
					<ifvm:inputNew type="text" id="email" names="email" dto="email" label="이메일" labelClass="1" conClass="2" />
					<div class="control_content col-xs-1">
						<select class="col-xs-12" id="emailBackSelet" onchange="selecterEmail(this)">
							<option>직접입력</option>
							<option>@naver.com</option>
							<option>@gmail.com</option>
							<option>@hanmail.net</option>
							<option>@nate.com</option>
						</select>				
					</div>
				</div>
			</div>
			<div class="row qt_border" id="rowArea3">
				<div id="zipArea">
					<ifvm:inputNew type="search" id="zip" dto="zip"  btnFunc="addrSearchBtn"  conClass="3" label="기본주소" labelClass="1"/>
				</div>
				<div id="adresArea">
					<ifvm:inputNew type="text" id="adres" dto="adres"  conClass="8" disabled="true" /> 
				</div>
			</div>
			<div class="row qt_border" id="rowArea4">
				<div id="bunjiArea">
					<ifvm:inputNew type="text" id="bunji" names="bunji" dto="bunji"  label="" labelClass="1" conClass="11" />
					<ifvm:inputNew type="hidden" id="bCode" names="bCode" dto="bCode" label="법정동" labelClass="1" conClass="3" readonly="true"/>
				</div>
			</div>
<!-- 			<div class="row qt_border" id="rowArea5"> -->
<!-- 				<div id="wrc_nmArea"> -->
<%-- 					<ifvm:inputNew type="text" id="wrc_nm" names="wrc_nm" dto="wrc_nm" label="직장명" labelClass="1" conClass="5"  /> --%>
<!-- 				</div> -->
<!-- 				<div id="empNoArea"> -->
<%--                    <ifvm:inputNew type="text" id="empNo" names="empNo" dto="empNo" label="사번" labelClass="1" conClass="5" /> --%>
<!--                </div> -->
<!-- 				<div id="pstnArea"> -->
<%-- 					<ifvm:inputNew type="select" id="pstn" names="pstn" dto="pstn" label="직위" labelClass="1" conClass="3" /> --%>
<!-- 				</div> -->
<!-- 			</div> -->
			<div class="row qt_border" id="rowArea6">
				<div id="zip_addArea">
					<ifvm:inputNew type="search" id="zip_add" dto="zip_add"  btnFunc="addrSearchBtn2"  conClass="3" label="부가주소" labelClass="1"/>
				</div>
				<div id="adres_addArea">
					<ifvm:inputNew type="text" id="adres_add" dto="adres_add"  conClass="8" disabled="true" /> 
				</div>
			</div>
			<div class="row qt_border" id="rowArea7">
				<div id="bunji_addArea">
					<ifvm:inputNew type="text" id="bunji_add" names="bunji_add" dto="bunji_add"  label="" labelClass="1" conClass="11" />
<%-- 					<ifvm:inputNew type="hidden" id="bCodeAdd" names="bCodeAdd" dto="bCodeAdd" label="법정동(추가)" labelClass="1" conClass="3" readonly="true"/> --%>
				</div>
			</div>
<!-- 			<div class="row qt_border" id="rowArea8"> -->
<!-- 				<div id="mrrg_ynArea"> -->
<%-- 					<ifvm:inputNew type="select" id="mrrg_yn" names="mrrg_yn" dto="mrrg_yn" label="결혼여부" labelClass="1" conClass="3" /> --%>
<!-- 				</div> -->
<!-- 				                <div id="annvrsry_type_cdArea"> -->
<%--                     <ifvm:inputNew type="select" id="annvrsry_type_cd" names="annvrsry_type_cd" dto="annvrsry_type_cd" label="기념일유형" labelClass="1" conClass="3" /> --%>
<!--                 </div> -->
<!--                 <div id="annvrsryArea"> -->
<!--                     <label class="control-label col-xs-1">기념일</label> -->
<%--                     <ifvm:inputNew type="hidden" id="annvrsry" names="annvrsry" dto="annvrsry" conClass="1"  maxLength="4"/> --%>
<!--                     <div class="col-xs-3"> -->
<!--                         <div class="control_content col-xs-6"> -->
<!--                             <select class="col-xs-10" id="annvrsryMm" onchange="checkAnnvrsry()"> -->
<!--                                 <option></option><option>01</option><option>02</option><option>03</option><option>04</option><option>05</option><option>06</option> -->
<!--                                 <option>07</option><option>08</option><option>09</option><option>10</option><option>11</option><option>12</option> -->
<!--                             </select> -->
<!--                             <span>월</span> -->
<!--                         </div> -->
<!--                         <div class="control_content col-xs-6"> -->
<!--                             <select class="col-xs-10" id="annvrsryDd" onchange="checkAnnvrsry()"> -->
<!--                                 <option></option><option>01</option><option>02</option><option>03</option><option>04</option><option>05</option><option>06</option><option>07</option><option>08</option><option>09</option><option>10</option> -->
<!--                                 <option>11</option><option>12</option><option>13</option><option>14</option><option>15</option><option>16</option><option>17</option><option>18</option><option>19</option><option>20</option> -->
<!--                                 <option>21</option><option>22</option><option>23</option><option>24</option><option>25</option><option>26</option><option>27</option><option>28</option><option>29</option><option>30</option> -->
<!--                                 <option>31</option> -->
<!--                             </select> -->
<!--                             <span>일</span> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!-- 				<div id="native_ynArea"> -->
<%-- 					<ifvm:inputNew type="select" id="native_yn" names="native_yn" dto="native_yn" label="내국인여부" labelClass="1" conClass="3" /> --%>
<!-- 				</div> -->
<!-- 				<div id="nltyArea"> -->
<%-- 					<ifvm:inputNew type="select" id="nlty" names="nlty" dto="nlty" label="국가" labelClass="1" conClass="3" /> --%>
<!-- 				</div> -->
<!-- 			</div> -->
			<div class="row qt_border" id="rowArea9">
<!-- 				<div id="annvrsry_type_cdArea"> -->
<%-- 					<ifvm:inputNew type="select" id="annvrsry_type_cd" names="annvrsry_type_cd" dto="annvrsry_type_cd" label="기념일유형" labelClass="1" conClass="3" /> --%>
<!-- 				</div> -->
<!-- 				<div id="annvrsryArea"> -->
<!-- 					<label class="control-label col-xs-1">기념일</label> -->
<%-- 					<ifvm:inputNew type="hidden" id="annvrsry" names="annvrsry" dto="annvrsry" conClass="1"  maxLength="4"/> --%>
<!-- 					<div class="col-xs-3"> -->
<!-- 						<div class="control_content col-xs-6"> -->
<!-- 							<select class="col-xs-10" id="annvrsryMm" onchange="checkAnnvrsry()"> -->
<!-- 								<option></option><option>01</option><option>02</option><option>03</option><option>04</option><option>05</option><option>06</option> -->
<!-- 								<option>07</option><option>08</option><option>09</option><option>10</option><option>11</option><option>12</option> -->
<!-- 							</select> -->
<!-- 							<span>월</span> -->
<!-- 						</div> -->
<!-- 						<div class="control_content col-xs-6"> -->
<!-- 							<select class="col-xs-10" id="annvrsryDd" onchange="checkAnnvrsry()"> -->
<!-- 								<option></option><option>01</option><option>02</option><option>03</option><option>04</option><option>05</option><option>06</option><option>07</option><option>08</option><option>09</option><option>10</option> -->
<!-- 								<option>11</option><option>12</option><option>13</option><option>14</option><option>15</option><option>16</option><option>17</option><option>18</option><option>19</option><option>20</option> -->
<!-- 								<option>21</option><option>22</option><option>23</option><option>24</option><option>25</option><option>26</option><option>27</option><option>28</option><option>29</option><option>30</option> -->
<!-- 								<option>31</option> -->
<!-- 							</select> -->
<!-- 							<span>일</span> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
				<div id="drmncy_chng_unitArea">
                    <ifvm:inputNew type="select" id="drmncy_chng_unit" names="drmncy_chng_unit" dto="drmncy_chng_unit" label="휴면전환" labelClass="1" conClass="5" />
                    <ifvm:inputNew type="hidden" id="prStoreNo" names="prStoreNo" dto="prStoreNo"  conClass="1" maxLength="50" />                 
                    <ifvm:inputNew type="search" id="prStoreNm" names="prStoreNm" dto="prStoreNm" label="주거래매장" title="주거래매장" btnFunc="prStoreNmFun" labelClass="1" conClass="5" />
                </div>
				<%-- <div id="rcmmd_noArea">
					<ifvm:inputNew type="text" id="rcmmd_no" names="rcmmd_no" dto="rcmmd_no" label="" labelClass="1" conClass="2" />
					<button class="btn btn-sm btn_gray"  id="rcmmdNoChk" objCode="">
						<spring:message code="검증" />
					</button> 
					<input type="checkbox" id="rcmmdNoCheckBox">
				</div> --%>
			</div>
<!-- 			<div class="row qt_border" id="rowArea10"> -->
				<%-- <div id="user_idArea" class="col-xs-4">
					<ifvm:inputNew type="text" id="user_id" names="user_id" dto="user_id" label="" labelClass="3" conClass="6"  />
					<button class="btn btn-sm btn_gray"  id="userIdChk" objCode="">
						<spring:message code="검증" />
					</button> 
					<input type="checkbox" id="userIdCheckBox">
				</div>
				<div id="user_pwdArea">
					<ifvm:inputNew type="text" id="user_pwd" names="user_pwd" dto="user_pwd" label="" labelClass="1" conClass="3" />
				</div>
				<div id="loginTypeCdArea">
					<ifvm:inputNew type="select" id="loginTypeCd" names="loginTypeCd" dto="loginTypeCd" conClass="2" disabled="true"/>
				</div> --%>
<!-- 			</div> -->
		</div>
<!-- 	     <div class="row qt_border" id="rowArea7"> -->
<%-- 	                                           <ifvm:inputNew type="hidden" id="prStoreNo" names="prStoreNo" dto="prStoreNo"  conClass="1" maxLength="50" />                  --%>
<%-- 	                                           <ifvm:inputNew type="search" id="prStoreNm" names="prStoreNm" dto="prStoreNm" label="주거래매장" title="주거래매장" btnFunc="prStoreNmFun" labelClass="1" conClass="3" /> --%>
<%--                                                <ifvm:inputNew type="select" id="snsTypeCd" names="snsTypeCd" dto="snsTypeCd"   label="대표 SNS" title="대표SNSHEADER" labelClass="1" conClass="4"/> --%>
<%--                                                <ifvm:inputNew type="text" id="snsAddr" dto="snsAddr"  title="대표SNSLINK" conClass="7"/> --%>
<!--          </div> -->
		<div class="" id="hideArea"> <!-- 필요하지만 화면상 보여줄 필요가 없는 것들 -->
				<ifvm:inputNew type="select" id="custtypecd" names="custtypecd" dto="custtypecd" label="M02630" labelClass="1" conClass="1"  disabled="true"/>
		 		<ifvm:inputNew type="select" id="sbscPathCd" names="sbscPathCd" dto="sbscPathCd" label="가입경로" labelClass="1" conClass="3" disabled="true"/>
				<ifvm:inputNew type="select" id="sbscDeviceCd" names="sbscDeviceCd" dto="sbscDeviceCd" label="가입디바이스" labelClass="1" conClass="3"  disabled="true" />
		</div>
	</div>
	<br>
<!-- 	<div class="form-horizontal  top_well"  id="custAgreValidForm"> -->
<%-- 		<div class="page_btn_area"> <spring:message code="고객동의 정보"/> </div> --%>
<!-- 	</div> -->
	<br><br>
	<div class="form-horizontal  top_well"  id="custAgreMktValidForm">
		<div class="page_btn_area"> <spring:message code="마켓팅활용 동의 정보"/> </div>
	</div>
	<br>
<!-- 	<div class="form-horizontal  top_well "  id="mbrCValidForm"> -->
<%-- 		<div class="page_btn_area"> <spring:message code="법인회원소속 가입"/> </div> --%>
<!-- 		<div class="row qt_border"> -->
<%-- 			<ifvm:inputNew type="search" id="mbrCNm" names="mbrCNm" dto="mbrCNm" btnFunc="searchMbrC" label="법인회원명" labelClass="1" conClass="3"/> --%>
<%-- 			<ifvm:inputNew type="hidden" id="mbrCNo" names="mbrCNo" dto="mbrCNo" conClass="1"/> --%>
<%-- 			<ifvm:inputNew type="hidden" id="mbrCRid" names="mbrCRid" dto="mbrCRid" conClass="1"/> --%>
<%-- 			<ifvm:inputNew type="search" id="mbrCBrNm" names="mbrCBrNm" dto="mbrCBrNm" btnFunc="searchBranch" label="브렌치" labelClass="1" conClass="3" /> --%>
<%-- 			<ifvm:inputNew type="hidden" id="mbrCBrNo" names="mbrCBrNo" dto="mbrCBrNo" conClass="1" /> --%>
<%-- 			<ifvm:inputNew type="number" id="mbrCCardNo" names="mbrCCardNo" dto="mbrCCardNo" label="카드번호" labelClass="1" conClass="2" /> --%>
<!-- 			<button class="btn btn-sm btn_gray"  id="checkCardVal" objCode=""> -->
<%-- 				<spring:message code="검증" /> --%>
<!-- 			</button> -->
<!-- 			<input type="checkbox" id="mbrCCardNoCheckBox">  -->
<!-- 		</div> -->
<!-- 	</div> -->
	<br>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="addCustBtn" objCode="addCustBtn_OBJ">
		<spring:message code="저장" />
	</button> 
	<button class="btn btn-sm btn_gray"  id="closePopBtn" objCode="closePopBtn_OBJ">
		<spring:message code="L00941" />
	</button> 
</div>
<!-- <div id="pgmPopupContainer" class="popup_container"></div>
<div id="chnlPopupContainer" class="popup_container"></div> -->
<div id="adrDtlSearchPop" class="popup_container"></div>
<div id="mbrCSearchPop" class="popup_container"></div>
<div id="brachSearchPop" class="popup_container"></div>
<div id="prStoreNmPop" class="popup_container"></div>


<script id="asterisk" type="text/x-jquery-tmpl">
<span class="asterisk">*</span>\${fieldDesc}
</script>
<script id="nonasterisk" type="text/x-jquery-tmpl">
\${fieldDesc}
</script>

<script id="labelAsterisk" type="text/x-jquery-tmpl">
<label class="control-label col-xs-1"><span class="asterisk">*</span>\${fieldDesc}</label>
</script>
<script id="labelNonasterisk" type="text/x-jquery-tmpl">
<label class="control-label col-xs-1">\${fieldDesc}</label>
</script>

<script id="termsTemplate" type="text/x-jquery-tmpl">

{{if requiredYn == "Y"}}
<ifvm:inputNew type="checkBox" id="\${termsTypeSubCd}"  names="\${ver}"  label="\${termsNm}" labelClass="2" conClass="1" required="true"  disabled="true"/>
{{else}}
<ifvm:inputNew type="checkBox" id="\${termsTypeSubCd}"  names="\${ver}"  label="\${termsNm}" labelClass="2" conClass="1" required="false" />
{{/if}}

</script>

<script id="mktTermsTemplate" type="text/x-jquery-tmpl">

<div class="row">
	<ifvm:inputNew type="checkBox" id="\${termsTypeSubCd}"  names="\${ver}"  label="\${termsNm}" labelClass="2" conClass="1" readonly="true"/>
</div>
<div class="row" id="mktRcvForm">
</div>

</script>

<script id="mktRcvTemplate" type="text/x-jquery-tmpl">

<ifvm:inputNew type="checkBox" id="\${mktRcvChnlCd}"  names="\${mktRcvChnlCd}"  label="\${mktRcvChnlCdNm}" labelClass="2" conClass="1"  readonly="true"/>

</script>


<script type="text/javascript">
var _mbrRid = $.ifvGetParams().rid;
var newCustPop;
var custValidation;
// var custAgreValidation;
var mbrCValidation;
var termsRid = null; 

var editMbrDetialPop = function(mbrRid){
	var inputField = $("#mbrDetailForm input");
	var selectField =$("#mbrDetailForm select");
	var inputBaseField = $("#baseForm input");
	var selectBaseField =$("#baseForm select");
	var certIdList = ["NO_CERT", "CI"];
	var temsField = null;
	var temsRcvField = null;
	var custItemValCheck = null;
	//var removeValue = []; //필드 숨기기 위한 값의 배열
	var requiredArr = [], shArr = [], numArr = [], disArr = [];
	this.textField =[], // input 필드값
	this.selectField =[], // select 필드값
	this.baseField =[], // 기본정보 동적으로 뿌리기위한 필드값
	this.temsField =[],
	this.temsRcvField =[],
	this.custItemVal=[],
	this.termsVal=[],
	this.temsRcvVal=[],
	this.init = function(){
		//버튼
		this.action();
		//약관정보 불러오기
		this.getTermsList();
		// 필드값
		this.getField();
		//select box 초기화
		this.setSelectField();
		//날짜 box 초기화
		this.setDateField();
		//동적으로 (이름, 필수여부) 설정
		this.getCustItemValCk();
		//현재 날짜 설정
		//this.getTodayDate();
		
		numArr = ['hhp', 'hhpTop', 'hhpMid', 'hhpBot'];
		this.NumberOnly(numArr);
		
	    numTelArr = ['tel_no', 'telTop', 'telMid', 'telBot'];
	    this.NumberOnly(numTelArr);
		
		shArr = ['hideArea', 'mbrCCardNoCheckBox'];
		this.showNhide(shArr, false);
		
		disArr = ['getCert'];
		this.disabledId(disArr, true);
		
		allowArr = ['ceo','charger'];
		this.disabledId(allowArr, false);

		this.getMbrDetail();
		 
	},
	this.NumberOnly = function(array){	//콤마 없이 숫자만
		for(var i = 0; i<array.length; i++) $("#mbrDetailForm #"+array[i]).onlyNumber();
	},
	this.showNhide = function(array, check){ //hide처리(check : true - show, false - hide)
		for(var i = 0; i<array.length; i++) {
			if(check) $("#mbrDetailForm #"+array[i]).show(); 
			else $("#mbrDetailForm #"+array[i]).hide(); 
		}
	},
	this.disabledId = function(array, check){ //disabled 처리
		for(var i = 0; i<array.length; i++) $("#mbrDetailForm #"+array[i]).attr("disabled", check); 	
	},
	this.setRequired = function(array, check){ // required 처리
		for(var i =0; i<array.length; i++) $("#mbrDetailForm #"+array[i]).attr("required", check);
	},
	this.getMbrDetail = function(){
		$.ifvSyncPostJSON('<ifvm:action name="getCorpMbrDetailPop"/>',{rid : _mbrRid}, function(result){
			
			$("#mbrDetailForm").dataSetting(result);
// 			if(result.annvrsry != null){
// 				var annvrsryStr = result.annvrsry;
// 				$("#mbrDetailForm #annvrsryMm").val(annvrsryStr.substr(0,2));
// 				$("#mbrDetailForm #annvrsryDd").val(annvrsryStr.substr(2,2));
// 			}
			
// 			if(result.birthdt != null){
// 				var birthday = result.birthdt;
// 				$("#mbrDetailForm #birthdt").val(birthday.substr(0,4)+"-"+birthday.substr(4,2)+"-"+birthday.substr(6));
// 			}

	        $.fn.ifvmSetSelectOptionCommCode("custtypecd", "LOY_CUST_TYPE_CD", result.custtypecd, null, true);
	        $.fn.ifvmSetSelectOptionCommCode("mbrTypeCd", "LOY_MBR_TYPE_CD", result.mbrTypeCd, null, true);
	        $.fn.ifvmSetSelectListOptionCommCode("certTypeCd", "LOY_CERT_TYPE_CD", result.certTypeCd, certIdList, true);
	        $.fn.ifvmSetSelectOptionCommCode("certSubTypeCd", "LOY_CERT_SUB_TYPE_CD", result.certSubTypeCd, null, false);
// 	        $.fn.ifvmSetSelectOptionCommCode("lunar_cd", "LOY_LUNAR_CD", result.lunar_cd, null, true);
// 	        $.fn.ifvmSetSelectOptionCommCode("gen_cd", "LOY_GEN_CD", result.gen_cd, null, false);
// 	        $.fn.ifvmSetSelectOptionCommCode("pstn", "POSITION", result.pstn, null, false);	
// 	        $.fn.ifvmSetSelectOptionCommCode("nlty", "COUNTRY_TYPE_CD", result.nlty, null, true);	
// 	        $.fn.ifvmSetSelectOptionCommCode("native_yn", "YES_NO_FLAG", result.native_yn, null, true);	
	        $.fn.ifvmSetSelectOptionCommCode("sbscPathCd", "LOY_SBSC_PATH_CD", 'D1', null, true);	
	        $.fn.ifvmSetSelectOptionCommCode("sbscDeviceCd", "LOY_SBSC_DVICE_CD", result.sbscDeviceCd, null, true);	
// 	        $.fn.ifvmSetSelectOptionCommCode("mrrg_yn", "YES_NO_FLAG", result.mrrg_yn, null, false);	
// 	        $.fn.ifvmSetSelectOptionCommCode("annvrsry_type_cd", "LOY_ANNVRSRY_TYPE_CD", result.annvrsry_type_cd, null, false);	
	        //$.fn.ifvmSetSelectOptionCommCode("loginTypeCd", "LOY_LOGIN_TYPE_CD", result.loginTypeCd, null, false);
	        $.fn.ifvmSetSelectOptionCommCode("drmncy_chng_unit", "LOY_DRMNCY_CHNG_UNIT_CD", result.drmncyChngUnit, null, true);
// 	        $.fn.ifvmSetSelectOptionCommCode("snsTypeCd", "LOY_SNS_TYPE_CD", result.snsTypeCd, null, true);

			if($("#mbrDetailForm #certTypeCd").val() == "CI"){
				disArr = ['certTypeCd','certVal','getCert','cust_nm','email','emailBackSelet','hhp','hhpTop','hhpMid','hhpBot'];
				this.disabledId(disArr, true);
			}
			
            disArr = ['certTypeCd','certVal','getCert','cust_nm','hhp','hhpTop','hhpMid','hhpBot','empNo','drmncy_chng_unit'];
            this.disabledId(disArr, true);
            
            
			var strHhp = $("#mbrDetailForm #hhp").val();
			if(strHhp!="") {
				 strHhp = strHhp.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
		         var afterHhpStr = strHhp.split('-');
		    }
			if(strHhp  != ""){
				$("#mbrDetailForm #hhpTop").val(afterHhpStr[0]);
				$("#mbrDetailForm #hhpMid").val(afterHhpStr[1]);
				$("#mbrDetailForm #hhpBot").val(afterHhpStr[2]);
			}
			
	         var strTel = $("#mbrDetailForm #tel_no").val();
	         if(strTel!="") {
		         strTel = strTel.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
		         var afterStr = strTel.split('-');
	         }
	         if(strTel  != ""){
	             $("#mbrDetailForm #telTop").val(afterStr[0]);
	             $("#mbrDetailForm #telMid").val(afterStr[1]);
	             $("#mbrDetailForm #telBot").val(afterStr[2]);
	         }
			/* if($("#user_id").val() != "" && $("#user_pwd").val() != ""){
				$("#userIdCheckBox").prop("checked",true);
				$("#mbrDetailForm #user_id").attr("disabled", true);
				$("#mbrDetailForm #user_pwd").attr("disabled", true);
				$("#mbrDetailForm #userIdChk").attr("disabled", true);
			} */
			
			/* if($("#rcmmd_no").val() != ""){
				$("#rcmmdNoCheckBox").prop("checked",true);
				$("#mbrDetailForm #rcmmd_no").attr("disabled", true);
				$("#mbrDetailForm #rcmmdNoChk").attr("disabled", true);
			} */
			
			if($("#mbrCCardNo").val() != ""){
				$("#mbrCCardNoCheckBox").prop("checked",true);
			}
			
		}.bind(this));
		$.ifvSyncPostJSON('<ifvm:action name="getMbrTermsDetailList"/>',{rid : _mbrRid}, function(result){
			var agreList = result.rows;
			if(agreList.length >0){
				for(var i =0 ; i<agreList.length; i++){
					if(agreList[i].agreYn  == 'Y'){
						$("#"+agreList[i].agreTypeCd).prop("checked", true);
					}
				}
			}
		}.bind(this));
	},
	this.save = function(){
		if(custValidation.confirm()  && mbrCValidation.confirm()){
			if(this.certCheck() == true) {
				this.getMktCheckValid();  //마켓팅 수신동의 체크박스 자동 체크
    			//this.getLoginIdCheck();  // 로그인 유형 값 자동 매핑
    			
    			this.getField();
    			
				if(confirm('<spring:message code="수정하시겠습니까?"/>')){
					var url = '<ifvm:action name="saveCorpMbrDetailPop"/>';
					$.ifvSyncPostJSON(url,this.getFieldVal(),function(result){
						this.afterSave(result)
					}.bind(this), function(result){this.afterSave(result)}.bind(this));
				}
			}
		}
	},
	this.close = function(){
		corpMbrDetailPopup._destroy();
	},
	this.getField = function(){ //Field 값 배열변수에 집어넣기
		
		for(var i=0;i<inputField.length; i++){this.textField[i] = inputField[i].id;}
		for(var i=0;i<selectField.length; i++){this.selectField[i] = selectField[i].id;	}
		for(var i=0;i<temsField.length; i++){this.temsField[i] = temsField[i].termsTypeSubCd;	}
		if($.fn.ifvmIsNotEmpty(temsRcvField))for(var i=0;i<temsRcvField.length; i++){this.temsRcvField[i] = temsRcvField[i].mktRcvChnlCd;}
		
		//동적으로 뿌리기 위한 필드값
		for(var i=0;i<inputBaseField.length; i++){this.baseField[i] = inputBaseField[i].id;}
		for(var i=0; i <selectBaseField.length; i++){this.baseField[i+inputBaseField.length] = selectBaseField[i].id;}
	},
	this.setSelectField = function(values) { //select box 값 매핑
    	var custtypecd = ( values && values.custtypecd ) ? values.custtypecd : null;
    	var mbrTypeCd = ( values && values.mbrTypeCd ) ? values.mbrTypeCd : null;
    	var certTypeCd = ( values && values.certTypeCd ) ? values.certTypeCd : null;
    	var certSubTypeCd = ( values && values.certSubTypeCd ) ? values.certSubTypeCd : null;
//     	var lunarCd = ( values && values.lunarCd ) ? values.lunarCd : null;
//     	var gen = ( values && values.gen ) ? values.gen : null;
//     	var position = ( values && values.position ) ? values.position : null;
//     	var nlty = ( values && values.nlty ) ? values.nlty : null;
//     	var nativeYn = ( values && values.nativeYn ) ? values.nativeYn : null;
    	var sbscPathCd = ( values && values.sbscPathCd ) ? values.sbscPathCd : null;
    	var sbscDeviceCd = ( values && values.sbscDeviceCd ) ? values.sbscDeviceCd : null;
//     	var mrrgYn = ( values && values.mrrgYn ) ? values.mrrgYn : null;
//     	var annvrsryTypeCd = ( values && values.annvrsryTypeCd ) ? values.annvrsryTypeCd : null;
    	//var loginTypeCd = ( values && values.loginTypeCd ) ? values.loginTypeCd : null;
    	var drmncyChngUnit = ( values && values.drmncyChngUnit ) ? values.drmncyChngUnit : null;
//         var snsTypeCd = ( values && values.snsTypeCd ) ? values.snsTypeCd : null;

        $.fn.ifvmSetSelectOptionCommCode("custtypecd", "LOY_CUST_TYPE_CD", custtypecd, null, true);
        $.fn.ifvmSetSelectOptionCommCode("mbrTypeCd", "LOY_MBR_TYPE_CD", mbrTypeCd, null, true);
        $.fn.ifvmSetSelectListOptionCommCode("certTypeCd", "LOY_CERT_TYPE_CD", certTypeCd, certIdList, true);
        $.fn.ifvmSetSelectOptionCommCode("certSubTypeCd", "LOY_CERT_SUB_TYPE_CD", certSubTypeCd, null, false);
//         $.fn.ifvmSetSelectOptionCommCode("lunar_cd", "LOY_LUNAR_CD", lunarCd, null, true);
//         $.fn.ifvmSetSelectOptionCommCode("gen_cd", "LOY_GEN_CD", gen, null, false);
//         $.fn.ifvmSetSelectOptionCommCode("pstn", "POSITION", position, null, false);	
//         $.fn.ifvmSetSelectOptionCommCode("nlty", "COUNTRY_TYPE_CD", nlty, null, true);	
//         $.fn.ifvmSetSelectOptionCommCode("native_yn", "YES_NO_FLAG", nativeYn, null, true);	
        $.fn.ifvmSetSelectOptionCommCode("sbscPathCd", "LOY_SBSC_PATH_CD", 'D1', null, true);	
        $.fn.ifvmSetSelectOptionCommCode("sbscDeviceCd", "LOY_SBSC_DVICE_CD", sbscDeviceCd, null, true);	
//         $.fn.ifvmSetSelectOptionCommCode("mrrg_yn", "YES_NO_FLAG", mrrgYn, null, false);	
//         $.fn.ifvmSetSelectOptionCommCode("annvrsry_type_cd", "LOY_ANNVRSRY_TYPE_CD", annvrsryTypeCd, null, false);	
        //$.fn.ifvmSetSelectOptionCommCode("loginTypeCd", "LOY_LOGIN_TYPE_CD", 'WEB_ID', null, false);
        $.fn.ifvmSetSelectOptionCommCode("drmncy_chng_unit", "LOY_DRMNCY_CHNG_UNIT_CD", drmncyChngUnit, null, true);
//         $.fn.ifvmSetSelectOptionCommCode("snsTypeCd", "LOY_SNS_TYPE_CD", snsTypeCd, null, true);

    },
    this.getTodayDate = function(){ //오늘날짜 계산
    	var date = new Date();
    	
    	var year = date.getFullYear();
    	var month = date.getMonth()+1;
    	if(month<10) month = "0"+month;
    	var day = date.getDate();
    	var hours = date.getHours();	
    	var minutes = date.getMinutes(); 
    	
    	var seconds = date.getSeconds(); 
    	if(seconds<10) seconds = "0"+seconds; 
    	
    	return year +"-"+month+"-"+day+" "+hours+":"+minutes+":"+seconds;
    },
    this.setDateField = function(){ //Data 지정
    	var birthDate = $("#mbrDetailForm #birthdt");
    	birthDate.ifvDateChecker({});
    }
	this.getFieldVal = function(){ //입력 Field값 가져오기
		var data = {};
		var termsList= {};
		var termsRcvList= {};
		var terms= [];
		this.textField.forEach(function(a){ //text 항목
			if(a == 'email')  data[a] = $("#mbrDetailForm #"+a).val().toLowerCase().trim()
			else if(a == 'cust_nm')data[a] = $("#mbrDetailForm #"+a).val().toUpperCase()
			else data[a] = $("#mbrDetailForm #"+a).val()
		});
		this.selectField.forEach(function(b){ //select Box 항목
			data[b] = $("#mbrDetailForm #"+b).val()
		});
		for(var i =0; i<this.temsField.length; i++){ //약관동의 항목
			if(this.temsField[i] == 'C1'){
				
				termsList = {
						agreTypeCd : this.temsField[i],
						agreYn : $('#mbrDetailForm input[id=' + this.temsField[i] + ']').is(":checked") ? "Y" : "N" ,
						regDt : this.getTodayDate(),
						termsVerNo : temsField[i].ver /* $("#"+this.temsField[i]).attr('name') */
				}
			}
// 			else{
// 				termsList = {
// 						agreTypeCd : this.temsField[i],
// 						agreYn : $('#mbrDetailForm input[id=' + this.temsField[i] + ']').is(":checked") ? "Y" : "N" ,
// 						regDt : this.getTodayDate(),
// 						termsVerNo : temsField[i].ver
// 				}
// 			}
			
			terms[i] = termsList;
		}
		var temSize = terms.length;
		for(var i = 0; i<this.temsRcvField.length; i++){ //수신동의 항목
			termsRcvList = {
					agreTypeCd : this.temsRcvField[i],
					agreYn : $('#mbrDetailForm input[id=' + this.temsRcvField[i]+']').is(":checked") ? "Y" : "N" ,
					regDt : this.getTodayDate(),
					termsVerNo : ""
			}
			terms[ i +temSize ] = termsRcvList;
		}
		data['termsList'] = terms;
		data['mbrNo'] = mbrNo;
		
		return data;
	},
	this.getCustItemValCk = function(){ // 대표 프로그램의 고객식별항목
		$.ifvSyncPostJSON('<ifvm:action name="custItemConfVal"/>',{pgmNo : pgmNo  /* repYn : 'Y' */}, function(result){
			custItemValCheck = result.rows;
			var newList = custItemValCheck.filter(function(item){
			      return inputeRowField.includes(item.fieldNm.toLowerCase());
			})
			
			//고객 수집항목에 추가되있지 않은 필드를 뽑아내어 disable 처리하기 위한 로직
			this.disableToNoCustDi();

			for(var i=0;i <newList.length; i++) {
				var fieldId = newList[i].fieldNm.toLowerCase();
				var fieldNm = newList[i].fieldDesc
				$("#mbrDetailForm #"+fieldId).attr("title", fieldNm);
				if( fieldId != "bunji" && fieldId != "bunji_add"  && 
						fieldId != "zip" && fieldId != "zip_add" && fieldId != "user_id" && fieldId != "user_pwd"){ 
					
					if(newList[i].requiredYn =='Y'){
						requiredArr = [fieldId];
						this.setRequired(requiredArr, true);
						fieldNm = '<span class="asterisk">*</span>'+fieldNm;
					}
					
					if(fieldId == "adres" || fieldId == "adres_add" ){
						$("#mbrDetailForm #"+fieldId).closest("div").parents().prev().children()[0].innerHTML = fieldNm;
					}else if(fieldId == "annvrsry" || fieldId == "hhp" ){
						$("#mbrDetailForm #"+fieldId).closest("div").children()[0].innerHTML = fieldNm;
					}else if(fieldId == "birthdt"){
						$("#mbrDetailForm #"+fieldId).closest("div").parents().prev()[0].innerHTML = fieldNm;
					}else{
						$("#mbrDetailForm #"+fieldId).closest("div").prev()[0].innerHTML = fieldNm;
					}
				}				
			}
		}.bind(this));
		custValidation = $("#custValidForm").ifvValidation();
// 		custAgreValidation = $("#custAgreValidForm").ifvValidation();
		mbrCValidation = $("#mbrCValidForm").ifvValidation();
	},
	/* this.rowFieldChk = function(removeValue){ //기본정보에서 Row대한 필드 값이 한개도 존재하지 않으면 숨기기
		
		for(var index = 1; index < 11; index++){ 
			var inputeRowField = []
			
			for(var i=0;i < $("#rowArea"+index+" input").length; i++){inputeRowField[i] = $("#rowArea"+index+" input")[i].id;}
			for(var i=0; i < $("#rowArea"+index+" select").length; i++){inputeRowField[ i+inputeRowField.length ] = $("#rowArea"+index+" select")[i].id;}
			
			var newList = inputeRowField.filter(function(item){
			      return !removeValue.includes(item);
			})
			if(newList.length == 0 && newList.length != inputeRowField.legnth) $("#rowArea"+index).hide();
		}
		
	}, */
	this.getTermsList = function(){ //약관동의 목록 동적으로 만들기(template 사용)
		shArr = ['custAgreMktValidForm']
		this.showNhide(shArr, false);
	
		$.ifvSyncPostJSON('<ifvm:action name="termsListVal"/>',{statCd : 'A', pgmNo : pgmNo}, function(result){
			
			this.termsVal = result.rows;
			temsField = result.rows;
			if(temsField.length > 0){
// 				$("#custAgreValidForm").show();
				for(var i=0; i<this.termsVal.length; i++){
					if(temsField[i].termsTypeSubCd == 'C1'){ //마켓팅수신동의 : C1
						$("#custAgreMktValidForm").show();
						$("#mktTermsTemplate").tmpl(this.termsVal[i]).appendTo("#custAgreMktValidForm"); 
						$.ifvSyncPostJSON('<ifvm:action name="termsMktRcvListVal"/>',{rid : temsField[i].rid }, function(param){
							this.temsRcvVal = param.rows;
							temsRcvField = param.rows;
							for(var i =0; i<this.temsRcvVal.length; i++){
								$("#mktRcvTemplate").tmpl(this.temsRcvVal[i]).appendTo("#mktRcvForm");
							}
						});
					}else{
						
						$("#termsTemplate").tmpl(this.termsVal[i]).appendTo("#custAgreValidForm");
						if(this.termsVal[i].requiredYn == "Y") $("input:checkbox[id='"+this.termsVal[i].termsTypeSubCd+"']").prop("checked", true);
					}
				}
			}
		});
	},
	this.disableToNoCustDi = function(){
		//필드에 있는 모든 기존정보중 프로그램에 등록된 고객 식별 정보를 빼줍니다.
		for(var i=0;i<custItemValCheck.length; i++){
			for(var j = 0; j < this.baseField.length; j++){
				if(this.baseField[j] == custItemValCheck[i].fieldNm.toLowerCase()) {
					if(custItemValCheck[i].fieldNm.toLowerCase() == "hhp" ){
						this.baseField.splice(this.baseField.indexOf("hhpTop"),1)
						this.baseField.splice(this.baseField.indexOf("hhpMid"),1)
						this.baseField.splice(this.baseField.indexOf("hhpBot"),1)
					}else if(custItemValCheck[i].fieldNm.toLowerCase() == "annvrsry" ){
						this.baseField.splice(this.baseField.indexOf("annvrsryMm"),1)
						this.baseField.splice(this.baseField.indexOf("annvrsryDd"),1)
					}else if(custItemValCheck[i].fieldNm.toLowerCase() == "email" ){
						this.baseField.splice(this.baseField.indexOf("emailBackSelet"),1)
					}else if (custItemValCheck[i].fieldNm.toLowerCase() == "tel_no") {
                        this.baseField.splice(this.baseField.indexOf("telTop"),1)
                        this.baseField.splice(this.baseField.indexOf("telMid"),1)
                        this.baseField.splice(this.baseField.indexOf("telBot"),1)
                    }
					
					this.baseField.splice(this.baseField.indexOf(custItemValCheck[i].fieldNm.toLowerCase()),1)
				}
			}
		}
		
		shArr = ['zip_addArea .input-group-addon', 'zipArea .input-group-addon'];
		this.showNhide(shArr, true);
		
		//필요없는 식별정보들을 disabled 처리해줍니다.
		this.baseField.forEach(function(i){ 
// 			if(i == "zip_add") $("#mbrDetailForm #zip_addArea .input-group-addon").hide()
// 			else if(i == "zip") $("#mbrDetailForm #zipArea .input-group-addon").hide()
			
			$("#mbrDetailForm #"+i).attr("disabled", true) 
		});
		
	},
	this.afterSave = function(result){
		if(result.success){
			if(result.message) alert(result.message);
			else alert('<spring:message code="Q00031"/>');
			this.close();
			qtjs.href('<ifvm:url name="corpMbrDetailNewPage"/>'+'?rid='+_mbrRid);
		}else{
			if(result.message) alert(result.message);
			else alert('<spring:message code="Q00032"/>');
		}
	},
	this.getMktCheckValid = function(){ //마켓팅 수신동의 항목 checking 목록 확인
		
		if($.fn.ifvmIsNotEmpty(temsRcvField)){
			var CheckValue = [];
			for(var i=0;i<this.temsRcvField.length; i++){
				if($("#mbrDetailForm input:checkbox[id='"+this.temsRcvField[i]+"']").prop("checked") == true){
					$("#mbrDetailForm input:checkbox[id='C1']").prop("checked", true);
					
					CheckValue[i] = this.temsRcvField[i];
				}
				if(CheckValue.length == 0){
					$("#mbrDetailForm input:checkbox[id='C1']").prop("checked", false);
				}
			}
		}
	},
	/* this.getLoginIdCheck = function(){
		
		//아이디와 패스워드가 둘중하나라도 비어있으면 로그인 유형을 빈값으로 설정
		if($("#user_id").val() =="" || $("#user_pwd").val() ==""){
			$("#loginTypeCd").val("");
		}else{
			$.fn.ifvmSetSelectOptionCommCode("loginTypeCd", "LOY_LOGIN_TYPE_CD", 'WEB_ID', null, false);
		}
		//로그인 유형 이 빈값으로 되있으면 로그인 아이디와 패스워드 둘다 빈값으로 설정
		if($("#loginTypeCd").val() == ""){
			$("#user_id").val("")
			$("#user_pwd").val("")
		}
	}, */
	this.certCheck = function(){
		
		/* if($("#rcmmd_no").val() != "" && $("#rcmmdNoCheckBox").prop("checked") == false) {
			alert('<spring:message code="D10310"/>')
			return false;
		} *//* else if($("#user_id").val() != "" && $("#userIdCheckBox").prop("checked") == false) {
			alert('<spring:message code="D10311"/>')
			return false;
		} */
		if($.fn.ifvmIsNotEmpty($("#mbrDetailForm #mbrCCardNo").val())) {
			if($("#mbrDetailForm #mbrCCardNo").val().length != 16) {
				alert('<spring:message code="D10312"/>');
				return false;
			}else if($("#mbrCCardNoCheckBox").prop("checked") == false) {
				alert('<spring:message code="D10314"/>');
				return false;
			}
		}else{
			return true;
		}
	},
	this.checkMbrCCardNo = function(){
		if($.fn.ifvmIsEmpty($("#mbrDetailForm #mbrCCardNo").val())){
			alert('<spring:message code="D10313"/>');
		}else{
			if($("#mbrDetailForm #mbrCCardNo").val().length != 16 ){
        		alert('<spring:message code="D10314"/>');
        	}else{
        		$.ifvSyncPostJSON('<ifvm:action name="checkCardNumber"/>',{
        			  cardNo : $("#mbrCCardNo").val() 
        		}, function(result){
        			if(result.message) alert(result.message);
        			else alert('<spring:message code="D10315"/>');
        			$("#mbrCCardNoCheckBox").attr("checked",true);
        		}, function(result){
        			if(result.message) alert(result.message);
        			else alert('<spring:message code="D10316"/>');
        			$("#mbrCCardNoCheckBox").attr("checked",false);
        		}.bind(this));
        	}
		}
	},
	/* this.checkUserId = function() {
		 if($("#user_id").val() == ""){
			alert('<spring:message code="D10317"/>');
		}else{
       		$.ifvSyncPostJSON('<ifvm:action name="checkUserId"/>',{
       			loginTypeCd :$("#loginTypeCd").val() ,
       			userId : $("#user_id").val() 
       		}, function(result){
       			if(result.message) alert(result.message);
       			else alert('<spring:message code="D10318"/>');
       			$("#userIdCheckBox").attr("checked",true);
       		}, function(result){
       			if(result.message) alert(result.message);
       			else alert('<spring:message code="D10319"/>');
       			$("#userIdCheckBox").attr("checked",false);
       		});
		}
	}, */
	/* this.checkRcmmdNo = function() {
		if($("#rcmmd_no").val() == ""){
			alert('<spring:message code="D10320"/>');
		}else{
       		$.ifvSyncPostJSON('<ifvm:action name="checkRcmmdNo"/>',{
       			rcmmdNo :$("#rcmmd_no").val()
       		}, function(result){
       			if(result.message) alert(result.message);
       			else alert('<spring:message code="D10321"/>');
       			$("#rcmmdNoCheckBox").attr("checked",true);
       		}, function(result){
       			if(result.message) alert(result.message);
       			else alert('<spring:message code="D10322"/>');
       			$("#rcmmdNoCheckBox").attr("checked",false);
       		});
		}
	}, */
	//인증
	this.certChange = function(){
		var selectItem = $("#mbrDetailForm #certTypeCd").val();
		if(selectItem == 'NO_CERT'){
			$("#mbrDetailForm #getCert").attr("disabled", true);
			disArr = [ 'cust_nm', 'gen_cd', 'email', 'emailBackSelet', 'hhpTop', 'hhpMid', 'hhpBot', 'birthdt', 'lunar_cd','telTop','telMid','telBot'];
			this.disabledId(disArr, false);
			
		}else{
			$("#mbrDetailForm #getCert").attr("disabled", false);
			 
			disArr = [ 'cust_nm', 'gen_cd', 'email', 'emailBackSelet', 'hhpTop', 'hhpMid', 'hhpBot', 'birthdt', 'lunar_cd'];
			this.disabledId(disArr, true);
		}
	},
	this.action = function() { //버튼
        $("#addCustBtn").click(function() { this.save(); }.bind(this));

        $("#closePopBtn").click(function() { this.close(); }.bind(this));
        
    	$("#checkCardVal").click(function(){ this.checkMbrCCardNo(); }.bind(this));
    	
    	/* $("#userIdChk").click(function(){ this.checkUserId(); }.bind(this)); */
    	
    	/* $("#rcmmdNoChk").click(function(){ this.checkRcmmdNo(); }.bind(this)); */
        
    	$('#mbrDetailForm #certTypeCd').change(function(){ this.certChange(); }.bind(this));
    }
}

//로열티 프로그램
/* function getPgmList(){
	openPop('<ifvm:url name="pgmListPop"/>', '<spring:message code="L02716"/>', 'pgmPopupContainer');
} */
//가입채널
/* function getChnlList(){
	openPop('<ifvm:url name="chnlListPop"/>', '<spring:message code="L00172"/>', 'chnlPopupContainer');
} */
//집주소
function addrSearchBtn() {
	openPop('<ifvm:url name="adrSearchPop"/>', '<spring:message code="D10298"/>', 'adrDtlSearchPop');
}
//직장주소
function addrSearchBtn2() {
	openPop('<ifvm:url name="adrSearchPop2"/>', '<spring:message code="직장주소 검색"/>', 'adrDtlSearchPop');
}
//법인회원번호
function searchMbrC(){
	openPop('<ifvm:url name="corpMbrListPop"/>', '<spring:message code="법인회원 조회"/>', 'mbrCSearchPop');
}
//브렌치
function searchBranch(){
	if(!$.fn.ifvmIsNotEmpty($("#mbrCNo").val())){
		alert("<spring:message code="법인회원을 먼저 선택하세요."/>")
	}else{
		openPop('<ifvm:url name="corpCustBranchListPop"/>', '<spring:message code="브렌치"/>', 'brachSearchPop');
	}
}
// 주거래매장
function prStoreNmFun() {
    openPop('<ifvm:url name="prStoreNmPopListPop"/>', '<spring:message code="주거래매장"/>', 'prStoreNmPop');
}

//팝업
function openPop(url, title, id){
	$("#"+id).ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : url,
        contentType : "ajax",
        title : title,
        width : '900px',
        close : 'closePop',
     });
}
function closePop(){
	$.fn.ifvmPopupClose();
}

function checkAnnvrsry(){
	var month = $("#mbrDetailForm #annvrsryMm").val();
	var day = $("#mbrDetailForm #annvrsryDd").val();
	
	$("#mbrDetailForm #annvrsry").val(month +""+day);
}

function checkHhp(){
	var top = $("#mbrDetailForm #hhpTop").val();
	var mid = $("#mbrDetailForm #hhpMid").val();
	var bottom = $("#mbrDetailForm #hhpBot").val();
	
	$("#mbrDetailForm #hhp").val(top+mid+bottom);
}

function checkTel(){
    var top = $("#mbrDetailForm #telTop").val();
    var mid = $("#mbrDetailForm #telMid").val();
    var bottom = $("#mbrDetailForm #telBot").val();
    
    $("#mbrDetailForm #tel_no").val(top+mid+bottom);
}

function selecterEmail(obj){
	 var setStr = $("#mbrDetailForm #email").val().split('@');
	
	 if(obj.value != "직접입력"){
		 $("#mbrDetailForm #email").val(setStr[0]+obj.value);
	 }else{
		 $("#mbrDetailForm #email").val(setStr[0]);
	 }
}  


$(document).ready(function(){
	mbrDetialPop = new editMbrDetialPop();
	mbrDetialPop.init();
	
	$('#C1').attr("disabled", true);

	// [마켓팅 활용 동의 정보]
	$('#mktRcvForm').change(function(){ 
		if ( $('input:checkbox[id="C3"]').is(":checked") == true
			|| $('input:checkbox[id="C6"]').is(":checked") == true
			|| $('input:checkbox[id="C7"]').is(":checked") == true ) 
		{
			$("input:checkbox[id='C1']").attr("checked", true);
		} else {
			$("input:checkbox[id='C1']").attr("checked", false);
		}
	});
	
	$('#C1').change(function(){ 
		if ($('input:checkbox[id="C1"]').is(":checked") == false) 
		{
			$("input:checkbox[id='C3']").attr("checked", false);
			$("input:checkbox[id='C6']").attr("checked", false);
			$("input:checkbox[id='C7']").attr("checked", false);
		}
	});
})
</script>