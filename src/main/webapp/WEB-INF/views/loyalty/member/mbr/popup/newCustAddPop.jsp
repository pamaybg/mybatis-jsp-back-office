<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="form-horizontal  top_well " id="newCustDetailForm">
<br>
	<div  class="form-horizontal  top_well"  id="custValidForm">
		<div class="page_btn_area"> <spring:message code="기본정보"/> </div>
		<div class="row qt_border">
			<ifvm:inputNew type="search" id="pgmNm" label="프로그램" labelClass="1" conClass="3" required="true" disabled="true" btnFunc="getPgmList" clearArgs="'pgmNm,pgmNo'"/>
			<ifvm:inputNew type="hidden" id="pgmNo" conClass="1" disabled="true" />
	 		<ifvm:inputNew type="search" id="chnlNm" label="V00132" labelClass="1" conClass="3" required="true" disabled="true" btnFunc="getChnlList"/>
	 		<ifvm:inputNew type="hidden" id="chnlNo"  conClass="1" required="true" disabled="true"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="select" id="mbrTypeCd" names="mbrTypeCd"  label="회원유형" labelClass="1" conClass="3" required="true" />
			<div class="control_content col-xs-4">
				<ifvm:inputNew type="select" id="certTypeCd" names="certTypeCd"  label="인증유형" labelClass="3" conClass="6" required="true" />
				<button class="btn btn-sm btn_gray"  id="getCert" objCode="">
					<spring:message code="본인인증" />
				</button> 
			</div>
			<div id="certValArea">
					<ifvm:inputNew type="text" id="certVal" names="certVal" label="인증값"  conClass="3" labelClass="1" />
			</div>
		</div>
		<div id="baseForm">
			<div class="row qt_border" id="rowArea1">
				<div id="cust_nmArea">
					<ifvm:inputNew type="text" id="cust_nm"  names="cust_nm"  label="" labelClass="1" conClass="3"/>
				</div>
				<div id="cust_nm_addArea">
					<ifvm:inputNew type="text" id="cust_nm_add"  names="cust_nm_add"  label="" labelClass="1" conClass="3" />
				</div>
				<div id="gen_cdArea">
					<ifvm:inputNew type="select" id="gen_cd" names="gen_cd"  label="" labelClass="1" conClass="3" />
				</div>
			</div>
			<div class="row qt_border" id="rowArea2">
				<div id="birthdtArea">
					<ifvm:inputNew type="date" id="birthdt" names="birthdt" label="" labelClass="1" conClass="2"/>
				</div>
				<div id="lunar_cdArea">
					<ifvm:inputNew type="select" id="lunar_cd" names="lunar_cd" conClass="1"/>
				</div>
				<div id="hhpArea">
					<label class="control-label col-xs-1"></label>
					<ifvm:inputNew type="hidden" id="hhp" names="hhp" label="" labelClass="1" conClass="1" maxLength="11" />					
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
					<ifvm:inputNew type="text" id="email" names="email" label="" labelClass="1" conClass="2" />
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
					<ifvm:inputNew type="search" id="zip" dto="zip"  btnFunc="addrSearchBtn" label="" labelClass="1" conClass="3" />
				</div>
				<div id="adresArea">
					<ifvm:inputNew type="text" id="adres" dto="adres"  conClass="8" disabled="true" /> 
				</div>
			</div>
			<div class="row qt_border" id="rowArea4">
				<div id="bunjiArea">
					<ifvm:inputNew type="text" id="bunji" names="bunji"  label="" labelClass="1" conClass="11" />
					<ifvm:inputNew type="hidden" id="bCode" names="bCode" label="법정동" labelClass="1" conClass="3" readonly="true"/>
				</div>
			</div>
			<div class="row qt_border" id="rowArea5">
				<div id="wrc_nmArea">
					<ifvm:inputNew type="text" id="wrc_nm" names="wrc_nm" label="" labelClass="1" conClass="3" />
				</div>
				<div id="pstnArea">
					<ifvm:inputNew type="select" id="pstn" names="pstn" label="" labelClass="1" conClass="3" />
				</div>
			</div>
			<div class="row qt_border" id="rowArea6">
				<div id="zip_addArea">
					<ifvm:inputNew type="search" id="zip_add" dto="zip_add"  btnFunc="addrSearchBtn2" label="" labelClass="1" conClass="3" />
				</div>
				<div id="adres_addArea">
					<ifvm:inputNew type="text" id="adres_add" dto="adres_add"  conClass="8" disabled="true" /> 
				</div>
			</div>
			<div class="row qt_border" id="rowArea7">
				<div id="bunji_addArea">
					<ifvm:inputNew type="text" id="bunji_add" names="bunji_add"  label="" labelClass="1" conClass="11" />
					<ifvm:inputNew type="hidden" id="bCodeAdd" names="bCodeAdd" label="법정동(추가)" labelClass="1" conClass="3" readonly="true"/>
				</div>
			</div>
			<div class="row qt_border" id="rowArea8">
				<div id="mrrg_ynArea">
					<ifvm:inputNew type="select" id="mrrg_yn" names="mrrg_yn" label="" labelClass="1" conClass="3" />
				</div>
				<div id="native_ynArea">
					<ifvm:inputNew type="select" id="native_yn" names="native_yn"  label="" labelClass="1" conClass="3" />
				</div>
				<div id="nltyArea">
					<ifvm:inputNew type="select" id="nlty" names="nlty"  label="" labelClass="1" conClass="3" />
				</div>
			</div>
			<div class="row qt_border" id="rowArea9">
				<div id="annvrsry_type_cdArea">
					<ifvm:inputNew type="select" id="annvrsry_type_cd" names="annvrsry_type_cd" label="" labelClass="1" conClass="3" />
				</div>
				<div id="annvrsryArea">
					<label class="control-label col-xs-1"></label>
					<ifvm:inputNew type="hidden" id="annvrsry" names="annvrsry" conClass="1" values="0101" maxLength="4" />
					<div class="col-xs-3">
						<div class="control_content col-xs-6">
							<select class="col-xs-10" id="annvrsryMm" onchange="checkAnnvrsry()">
								<option></option><option>01</option><option>02</option><option>03</option><option>04</option><option>05</option><option>06</option>
								<option>07</option><option>08</option><option>09</option><option>10</option><option>11</option><option>12</option>
							</select>
							<span>월</span>
						</div>
						<div class="control_content col-xs-6">
							<select class="col-xs-10" id="annvrsryDd" onchange="checkAnnvrsry()">
								<option></option><option>01</option><option>02</option><option>03</option><option>04</option><option>05</option><option>06</option><option>07</option><option>08</option><option>09</option><option>10</option>
								<option>11</option><option>12</option><option>13</option><option>14</option><option>15</option><option>16</option><option>17</option><option>18</option><option>19</option><option>20</option>
								<option>21</option><option>22</option><option>23</option><option>24</option><option>25</option><option>26</option><option>27</option><option>28</option><option>29</option><option>30</option>
								<option>31</option>
							</select>
							<span>일</span>
						</div>
					</div>
				</div>
				<div id="rcmmd_noArea">
					<ifvm:inputNew type="text" id="rcmmd_no" names="rcmmd_no"  label="" labelClass="1" conClass="2" />
					<button class="btn btn-sm btn_gray"  id="rcmmdNoChk" objCode="">
						<spring:message code="검증" />
					</button> 
					<input type="checkbox" id="rcmmdNoCheckBox">
				</div>
			</div>
			<div class="row qt_border" id="rowArea10">
				<div id="user_idArea" class="col-xs-4">
					<ifvm:inputNew type="text" id="user_id" names="user_id"  label="" labelClass="3" conClass="6"  />
					<button class="btn btn-sm btn_gray"  id="userIdChk" objCode="">
						<spring:message code="검증" />
					</button> 
					<input type="checkbox" id="userIdCheckBox">
				</div>
				<div id="user_pwdArea">
					<ifvm:inputNew type="text" id="user_pwd" names="user_pwd"  label="" labelClass="1" conClass="3" />
				</div>
				<div id="loginTypeCdArea">
					<ifvm:inputNew type="select" id="loginTypeCd" names="loginTypeCd"  conClass="2" disabled="true"/>
				</div>
				<div id="drmncy_chng_unitArea">
					<ifvm:inputNew type="select" id="drmncy_chng_unit" names="drmncy_chng_unit"  label="" labelClass="1" conClass="3" />
				</div>
			</div>
		</div>
		<div class="" id="hideArea"> <!-- 필요하지만 화면 보여줄 필요가 없는 것들 -->
				<ifvm:inputNew type="select" id="custtypecd" names="custtypecd"  label="M02630" labelClass="1" conClass="1"  disabled="true"/>
		 		<ifvm:inputNew type="select" id="sbscPathCd" names="sbscPathCd"  label="가입경로" labelClass="1" conClass="3" disabled="true"/>
				<ifvm:inputNew type="select" id="sbscDeviceCd" names="sbscDeviceCd"  label="가입디바이스" labelClass="1" conClass="3"  disabled="true" />
		</div>
	</div>
	<br>
	<div class="form-horizontal  top_well"  id="custAgreValidForm">
		<div class="page_btn_area"> <spring:message code="고객동의 정보"/> </div>
	</div>
	<br><br>
	<div class="form-horizontal  top_well"  id="custAgreMktValidForm">
		<div class="page_btn_area"> <spring:message code="마켓팅활용 동의 정보"/> </div>
	</div>
	<br>
	<div class="form-horizontal  top_well "  id="mbrCValidForm">
		<div class="page_btn_area"> <spring:message code="법인회원소속 가입"/> </div>
		<div class="row qt_border">
			<ifvm:inputNew type="search" id="mbrCNm" names="mbrCNm" dto="mbrCNm" btnFunc="searchMbrC" label="법인회원명" labelClass="1" conClass="3"/>
			<ifvm:inputNew type="hidden" id="mbrCNo" names="mbrCNo" dto="mbrCNo" conClass="1"/>
			<ifvm:inputNew type="hidden" id="mbrCRid" names="mbrCRid" dto="mbrCRid" conClass="1"/>
			<ifvm:inputNew type="search" id="mbrCBrNm" names="mbrCBrNm" dto="mbrCBrNm" btnFunc="searchBranch" label="브렌치" labelClass="1" conClass="3" />
			<ifvm:inputNew type="hidden" id="mbrCBrNo" names="mbrCBrNo" dto="mbrCBrNo" conClass="1" />
			<ifvm:inputNew type="number" id="mbrCCardNo" names="mbrCCardNo" dto="mbrCCardNo" label="카드번호" labelClass="1" conClass="2" />
			<button class="btn btn-sm btn_gray"  id="checkCardVal" objCode="">
				<spring:message code="검증" />
			</button> 
			<input type="checkbox" id="mbrCCardNoCheckBox">
		</div>
	</div>
	<br>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="addCustBtn" objCode="">
		<spring:message code="등록" />
	</button> 
	<button class="btn btn-sm btn_gray"  id="closePopBtn" objCode="">
		<spring:message code="L00941" />
	</button> 
</div>
<div id="pgmPopupContainer" class="popup_container"></div>
<div id="chnlPopupContainer" class="popup_container"></div>
<div id="adrDtlSearchPop" class="popup_container"></div>
<div id="mbrCSearchPop" class="popup_container"></div>
<div id="brachSearchPop" class="popup_container"></div>


<script id="asterisk" type="text/x-jquery-tmpl">
<span class="asterisk">*</span>\${fieldDesc}
</script>
<script id="nonasterisk" type="text/x-jquery-tmpl">
\${fieldDesc}
</script>

<script id="custAgreFormTemp" type="text/x-jquery-tmpl">
<div id="custAgreForm"></div>
</script>
<script id="custAgreMktFormTemp" type="text/x-jquery-tmpl">
<div id="custAgreMktForm"></div>
</script>

<!-- 
{{if requiredYn == "Y"}}
<ifvm:inputNew type="checkBox" id="\${termsTypeSubCd}"  names="\${ver}" className="agreTerms" label="\${termsNm}" labelClass="2" conClass="1" required="true"  disabled="true"/>
{{else}}
<ifvm:inputNew type="checkBox" id="\${termsTypeSubCd}"  names="\${ver}" className="agreTerms" label="\${termsNm}" labelClass="2" conClass="1" required="false" />
{{/if}}
 -->
<script id="termsTemplate" type="text/x-jquery-tmpl">

{{if requiredYn == "Y"}}
<ifvm:inputNew type="checkBox" id="\${termsTypeSubCd}"  names="\${ver}" className="agreTerms" label="\${termsNm}" labelClass="2" conClass="1" required="true"/>
{{else}}
<ifvm:inputNew type="checkBox" id="\${termsTypeSubCd}"  names="\${ver}" className="agreTerms" label="\${termsNm}" labelClass="2" conClass="1" required="false"/>
{{/if}}

</script>

<script id="mktTermsTemplate" type="text/x-jquery-tmpl">

<div class="row">
	<ifvm:inputNew type="checkBox" id="\${termsTypeSubCd}" className="agreTerms" names="\${ver}"  label="\${termsNm}" labelClass="2" conClass="1" readonly="true"/>
</div>
<div class="row" id="mktRcvForm">
</div>

</script>

<script id="mktRcvTemplate" type="text/x-jquery-tmpl">

<ifvm:inputNew type="checkBox" id="\${mktRcvChnlCd}" className="agreTerms"  names="\${mktRcvChnlCd}"  label="\${mktRcvChnlCdNm}" labelClass="2" conClass="1"  readonly="true"/>

</script>

<script type="text/javascript">
var newCustPop;
var custValidation;
var custAgreValidation;
var mbrCValidation;
var termsRid = null; 
var pastPgm = null;

var newCustAddPop = function(){
	var inputField = $("#newCustDetailForm input");
	var selectField =$("#newCustDetailForm select");
	var inputBaseField = $("#baseForm input");
	var selectBaseField =$("#baseForm select");
	var temsField = null, temsRcvField = null;
	var removeValue = []; //필드 숨기기 위한 값의 배열
	var custItemList = [];
	var requiredArr = [], shArr = [], numArr = [], disArr = [], requiredTerms = [];
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
		//this.getField();
		//select box 초기화
		this.setSelectField();
		//날짜 box 초기화
		this.setDateField();
		//현재 날짜 설정
		this.getTodayDate();
		
		numArr = ['hhp', 'hhpTop', 'hhpMid', 'hhpBot'];
		this.NumberOnly(numArr);
		
		shArr = ['hideArea', 'loginTypeCd', 'rcmmdNoCheckBox', 'userIdCheckBox', 
			'mbrCCardNoCheckBox', 'baseForm', 'custAgreValidForm',
			'custAgreMktValidForm', 'mbrCValidForm', 'certValArea'];
		this.showNhide(shArr, false);
		
		disArr = ['getCert'];
		this.disabledId(disArr, true);
	},
	this.save = function(){ //저장
		if( custValidation.confirm() == true && custAgreValidation.confirm() == true && mbrCValidation.confirm() == true ){
			if(this.certCheck() == true) {
    			this.getMktCheckValid();  //마켓팅 수신동의 체크박스 자동 체크
    			this.getLoginIdCheck();  // 로그인 유형 값 자동 매핑
    			
    			this.getField(); // 필드값 가져오기
    			
    			var url = '<ifvm:action name="saveJoinCustAll"/>';
    			$.ifvSyncPostJSON(url,this.getFieldVal(),function(result){
    				this.afterSave(result)
    			}.bind(this), function(result){this.afterSave(result)}.bind(this));
    		}
		}
	},
	this.close = function(){  //닫기
		addNewCumstContainer._destroy();
	},
	this.NumberOnly = function(array){	//콤마 없이 숫자만
		for(var i = 0; i<array.length; i++) $("#"+array[i]).onlyNumber();
	},
	this.showNhide = function(array, check){ //hide처리(check : true - show, false - hide)
		for(var i = 0; i<array.length; i++) {
			if(check) $("#"+array[i]).show(); 
			else $("#"+array[i]).hide(); 
		}
	},
	this.disabledId = function(array, check){ //disabled 처리
		for(var i = 0; i<array.length; i++) $("#"+array[i]).attr("disabled", check); 	
	},
	this.setRequired = function(array, check){ // required 처리
		for(var i =0; i<array.length; i++) $("#"+array[i]).attr("required", check);
	},
	this.getField = function(){ //Field id 배열변수에 집어넣기
		
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
    	var certIdList = ["NO_CERT", "CI"];	//공통코드 selecter에 강제로 원하는 값만 넣어준다
    	var certTypeCd = ( values && values.certTypeCd ) ? values.certTypeCd : null;
    	var certSubTypeCd = ( values && values.certSubTypeCd ) ? values.certSubTypeCd : null;
    	var lunarCd = ( values && values.lunarCd ) ? values.lunarCd : null;
    	var gen = ( values && values.gen ) ? values.gen : null;
    	var position = ( values && values.position ) ? values.position : null;
    	var nlty = ( values && values.nlty ) ? values.nlty : null;
    	var nativeYn = ( values && values.nativeYn ) ? values.nativeYn : null;
    	var sbscPathCd = ( values && values.sbscPathCd ) ? values.sbscPathCd : null;
    	var sbscDeviceCd = ( values && values.sbscDeviceCd ) ? values.sbscDeviceCd : null;
    	var mrrgYn = ( values && values.mrrgYn ) ? values.mrrgYn : null;
    	var annvrsryTypeCd = ( values && values.annvrsryTypeCd ) ? values.annvrsryTypeCd : null;
    	var loginTypeCd = ( values && values.loginTypeCd ) ? values.loginTypeCd : null;
    	var drmncyChngUnit = ( values && values.drmncyChngUnit ) ? values.drmncyChngUnit : null;
    	
        $.fn.ifvmSetSelectOptionCommCode("custtypecd", "LOY_CUST_TYPE_CD", custtypecd, null, true);
        $.fn.ifvmSetSelectOptionCommCode("mbrTypeCd", "LOY_MBR_TYPE_CD", mbrTypeCd, null, true);
        $.fn.ifvmSetSelectListOptionCommCode("certTypeCd", "LOY_CERT_TYPE_CD", certTypeCd, certIdList, true);
        $.fn.ifvmSetSelectOptionCommCode("certSubTypeCd", "LOY_CERT_SUB_TYPE_CD", certSubTypeCd, null, false);
        $.fn.ifvmSetSelectOptionCommCode("lunar_cd", "LOY_LUNAR_CD", lunarCd, null, true);
        $.fn.ifvmSetSelectOptionCommCode("gen_cd", "LOY_GEN_CD", gen, null, false);
        $.fn.ifvmSetSelectOptionCommCode("pstn", "POSITION", position, null, false);	
        $.fn.ifvmSetSelectOptionCommCode("nlty", "COUNTRY_TYPE_CD", nlty, null, true);	
        $.fn.ifvmSetSelectOptionCommCode("native_yn", "YES_NO_FLAG", nativeYn, null, true);	
        $.fn.ifvmSetSelectOptionCommCode("sbscPathCd", "LOY_SBSC_PATH_CD", 'D1', null, true);	
        $.fn.ifvmSetSelectOptionCommCode("sbscDeviceCd", "LOY_SBSC_DVICE_CD", sbscDeviceCd, null, true);	
        $.fn.ifvmSetSelectOptionCommCode("mrrg_yn", "YES_NO_FLAG", mrrgYn, null, false);	
        $.fn.ifvmSetSelectOptionCommCode("annvrsry_type_cd", "LOY_ANNVRSRY_TYPE_CD", annvrsryTypeCd, null, false);	
        $.fn.ifvmSetSelectOptionCommCode("loginTypeCd", "LOY_LOGIN_TYPE_CD", 'WEB_ID', null, false);
        $.fn.ifvmSetSelectOptionCommCode("drmncy_chng_unit", "LOY_DRMNCY_CHNG_UNIT_CD", drmncyChngUnit, null, true);
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
    	var birthDate = $("#birthdt");
    	birthDate.ifvDateChecker({});
    },
	this.getFieldVal = function(){ //입력 Field값 가져오기
		var _data = {}, _termsList= {},  _termsRcvList= {};
		var terms= [];
		
		this.textField.forEach(function(a){ //text 항목
			if(a == 'email')  _data[a] = $("#"+a).val().toLowerCase().trim()
			else if(a == 'cust_nm') _data[a] = $(" #"+a).val().toUpperCase()
			else _data[a] = $("#"+a).val()
		});
		
		this.selectField.forEach(function(b){ //select Box 항목
			_data[b] = $("#"+b).val()
		});
		
		for(var i =0; i<this.temsField.length; i++){ //약관동의 항목
			_termsList = {
				agreTypeCd : this.temsField[i],
				agreYn : $('input[id=' + this.temsField[i] + ']').is(":checked") ? "Y" : "N" ,
				regDt : this.getTodayDate(),
				termsVerNo : $("#"+this.temsField[i]).attr('name')
			}
			terms[i] = _termsList;
		}
		
		var temSize = terms.length;
		for(var i = 0; i<this.temsRcvField.length; i++){ //수신동의 항목
			_termsRcvList = {
					agreTypeCd : this.temsRcvField[i],
					agreYn : $('input[id=' + this.temsRcvField[i]+']').is(":checked") ? "Y" : "N" ,
					regDt : this.getTodayDate(),
					termsVerNo : ""
			}
			terms[ i +temSize ] = _termsRcvList;
		}
		_data['termsList'] = terms;
		
		return _data;
	},
	this.getCustItemValCk = function(){ // 대표 프로그램의 고객식별항목을 동적으로 required ,label 뿌리기(대표 프로그램에 등록된것만)
		$.ifvSyncPostJSON('<ifvm:action name="custItemConfVal"/>',{ pgmNo : $("#pgmNo").val()}, function(result){
			$("#baseForm").show();
			
			// 필드값
			this.getField();
			//baseForm의 모든 input required 초기화
			this.setRequired(this.baseField, false);
			
			this.custItemVal = result.rows;
			custItemList = [];
			removeValue = this.baseField;
			
			for(var i=0;i <this.custItemVal.length; i++) {
				var _fieldId = this.custItemVal[i].fieldNm.toLowerCase()
				
				removeValue.forEach(function(item){ //BASE 필드에서 추가된항목을 빼고 removeValue에 넣어준다.
					if(item == _fieldId) { 
						$("#"+item+"Area").hide();
						removeValue.splice(removeValue.indexOf( _fieldId), 1)
					}
				}); 
				
				if( _fieldId != "bunji" && _fieldId != "bunji_add" && _fieldId != "lunar_cd" ){ // 주소,상세주소,양음력은 label생략
					if(this.custItemVal[i].requiredYn =='Y'){
						$("#"+_fieldId).prop("required", true);
						if( _fieldId == "birthdt" ){
							$("#asterisk").tmpl(this.custItemVal[i]).prependTo($("#"+_fieldId).closest("div").parents("div").prev()[0]);
						}else if(_fieldId == "annvrsry" || _fieldId == "hhp"){
							if(_fieldId == "hhp"){
								requiredArr = ['hhpTop', 'hhpMid', 'hhpBot'];
								this.setRequired(requiredArr, true);
								requiredArr = ['hhp']
								this.setRequired(requiredArr, false);
							}else if(_fieldId == "annvrsry"){
								requiredArr = ['annvrsryMm', 'annvrsryDd'];
								this.setRequired(requiredArr, true);
								requiredArr = ['annvrsry'];
								this.setRequired(requiredArr, false);
							}
							$("#asterisk").tmpl(this.custItemVal[i]).prependTo($("#"+_fieldId).prev()[0]);
						}else if( _fieldId == "adres_add" ||  _fieldId == "adres"){
							$("#asterisk").tmpl(this.custItemVal[i]).prependTo($("#"+_fieldId).closest("div").parents("div").prev().children()[0]);
						}else{
							$("#asterisk").tmpl(this.custItemVal[i]).prependTo($("#"+_fieldId).closest("div").prev()[0]);
						}
					}else if(this.custItemVal[i].requiredYn =='N'){
						$("#"+_fieldId).prop("required", false);
						if(  _fieldId == "birthdt" ){
							$("#nonasterisk").tmpl(this.custItemVal[i]).prependTo($("#"+_fieldId).closest("div").parents("div").prev()[0]);
						}else if(_fieldId == "annvrsry" || _fieldId == "hhp"){
							if(_fieldId == "hhp"){
								requiredArr = ['hhpTop', 'hhpMid', 'hhpBot'];
								this.setRequired(requiredArr, false);
							}else if(_fieldId == "annvrsry"){
								requiredArr = ['annvrsryMm', 'annvrsryDd'];
								this.setRequired(requiredArr, false);
							}
							$("#nonasterisk").tmpl(this.custItemVal[i]).prependTo($("#"+_fieldId).prev()[0]);
						}else if( _fieldId == "adres_add" || _fieldId == "adres"){
							$("#nonasterisk").tmpl(this.custItemVal[i]).prependTo($("#"+_fieldId).closest("div").parents("div").prev().children()[0]);
						}else{
							$("#nonasterisk").tmpl(this.custItemVal[i]).prependTo($("#"+_fieldId).closest("div").prev()[0]);
						}
					}
				}
					
				custItemList[i] = this.custItemVal[i].fieldNm.toLowerCase()
			}
			this.rowFieldChk(custItemList);
			/* removeValue.forEach(function(a){
				$("#"+a+"Area").hide();
			}) */
		}.bind(this));
		custValidation = $("#custValidForm").ifvValidation();
		custAgreValidation = $("#custAgreValidForm").ifvValidation();
		mbrCValidation = $("#mbrCValidForm").ifvValidation();
	},
	this.rowFieldChk = function(custItemList){ //기본정보에서 Row대한 필드 값이 한개도 존재하지 않으면 숨기기
	
		for(var index = 1; index <= $("#baseForm").children().size(); index++){
			var _inputRowField = [];
			
			for(var i=0;i < $("#rowArea"+index+" input").length; i++){_inputRowField[i] = $("#rowArea"+index+" input")[i].id;}
			for(var i=0; i < $("#rowArea"+index+" select").length; i++){_inputRowField[ i+_inputRowField.length ] = $("#rowArea"+index+" select")[i].id;}
			
			var newList = [];
			_inputRowField.filter(function(item, i){
				
				if(custItemList.indexOf(item) != -1){
					$("#"+item+"Area").show();
					return newList[i] = item
				}else{
					$("#"+item+"Area").hide();
				}
			})
			if(newList.length == 0 && newList.length != _inputRowField.legnth) $("#rowArea"+index).hide();
			else $("#rowArea"+index).show();
		}
		
	},
	this.getTermsList = function(){ //약관동의 목록 동적으로 만들기(template 사용)
		shArr = ['custAgreValidForm', 'custAgreMktValidForm']
		this.showNhide(shArr, false);
		requiredTerms = [];
		temsRcvField = null;
		
		$.ifvSyncPostJSON('<ifvm:action name="termsListVal"/>',{statCd : 'A', pgmNo : $("#pgmNo").val()}, function(result){
			
			$("#custAgreValidForm").append($("#custAgreFormTemp").tmpl());
			$("#custAgreMktValidForm").append($("#custAgreMktFormTemp").tmpl());

			this.termsVal = result.rows;
			temsField = result.rows;
			
			if(temsField.length > 0){
				$("#custAgreValidForm").show();
				for(var i=0; i<this.termsVal.length; i++){
					if(temsField[i].termsTypeSubCd == 'C1'){ //마켓팅수신동의 : C1
						$("#custAgreMktValidForm").show();
						$("#mktTermsTemplate").tmpl(this.termsVal[i]).appendTo("#custAgreMktForm"); 
						$.ifvSyncPostJSON('<ifvm:action name="termsMktRcvListVal"/>',{rid : temsField[i].rid }, function(param){
							this.temsRcvVal = param.rows;
							temsRcvField = param.rows;
							for(var i =0; i<this.temsRcvVal.length; i++){
								$("#mktRcvTemplate").tmpl(this.temsRcvVal[i]).appendTo("#mktRcvForm");
							}
						});
					}else{
						$("#termsTemplate").tmpl(this.termsVal[i]).appendTo("#custAgreForm");
						if(this.termsVal[i].requiredYn == "Y") {
							//$("input:checkbox[id='"+this.termsVal[i].termsTypeSubCd+"']").prop("checked", true);
							requiredTerms[requiredTerms.length] = {
									id : this.termsVal[i].termsTypeSubCd,
									name : this.termsVal[i].termsNm
							}
						}
					}
				}
			}
		});
		//법인회원가입 정책여부
		if($.fn.ifvmIsNotEmpty($("#pgmNo").val())) this.getPgmMgtPlcy();
	},
	this.getPgmMgtPlcy = function(){ //법인회원등록 로직(로열티프로그램 운영정책에서 확인)
		$.ifvSyncPostJSON('<ifvm:action name="getPgmMgtPlcy"/>',{pgmNo : $("#pgmNo").val(), cateSubCd : '10' /* 법인회원가입 : 10 */}, function(result){
			if(result == 0) $("#mbrCValidForm").hide();
			else $("#mbrCValidForm").show();
		}.bind(this));
	},
	this.afterSave = function(result){  //저장후
		if(result.success){
			if(result.message) alert(result.message);
			else alert('<spring:message code="Q00030"/>');
			this.close();
			//회원 조회조건 3번쨰 input 조회는 회원번호가 되어야한다.
			if($("#commSearchList #rows2 input").val() != undefined && result.mbrNo != null){
				   $("#commSearchList #rows2 input").val(result.mbrNo);
				   $("#searchCondBtn").trigger("click");
			}
		}else{
			if(result.message) alert(result.message);
			else alert('<spring:message code="D10299"/>');
		}
	},
	this.getMktCheckValid = function(){ //마켓팅 수신동의 항목 checking 목록 확인
		if($.fn.ifvmIsNotEmpty(temsRcvField)){
			var CheckValue = [];
			for(var i=0;i<temsRcvField.length; i++){
				if($("input:checkbox[id='"+temsRcvField[i].mktRcvChnlCd+"']").prop("checked") == true){
					$("input:checkbox[id='C1']").prop("checked", true);
					CheckValue[i] = temsRcvField[i];
				}
				
				if(CheckValue.length == 0) $("input:checkbox[id='C1']").prop("checked", false);
			}
		}
	},
	this.getLoginIdCheck = function(){
		
		//아이디와 패스워드가 둘중하나라도 비어있으면 로그인 유형을 빈값으로 설정
		if($.fn.ifvmIsEmpty($("#user_id").val()) || $.fn.ifvmIsEmpty($("#user_pwd").val())){
			$("#loginTypeCd").val("");
		}else{
			$.fn.ifvmSetSelectOptionCommCode("loginTypeCd", "LOY_LOGIN_TYPE_CD", 'WEB_ID', null, false);
		}
		//로그인 유형 이 빈값으로 되있으면 로그인 아이디와 패스워드 둘다 빈값으로 설정
		if($.fn.ifvmIsEmpty($("#loginTypeCd").val())){
			$("#user_id").val("")
			$("#user_pwd").val("")
		}
	},
	this.certCheck = function(){
		var check = true;
		
		if($.fn.ifvmIsNotEmpty($("#rcmmd_no").val()) && $("#rcmmdNoCheckBox").prop("checked") == false) {
			alert('<spring:message code="D10310"/>')
			check = false;
			return false;
		}else if($.fn.ifvmIsNotEmpty($("#user_id").val()) && $("#userIdCheckBox").prop("checked") == false) {
			alert('<spring:message code="D10311"/>')
			check = false;
			return false;
		}else if($.fn.ifvmIsNotEmpty($("#mbrCCardNo").val())) {
			if($("#mbrCCardNo").val().length != 16) {
				alert('<spring:message code="D10312"/>');
				check = false;
				return false;
			}else if($("#mbrCCardNoCheckBox").prop("checked") == false) {
				alert('<spring:message code="D10314"/>');
				check = false;
				return false;
			}
		} else if(requiredTerms.length > 0){
			for(var i = 0; i<requiredTerms.length; i++){
				if(!$("#"+requiredTerms[i].id).prop("checked")){
					alert(requiredTerms[i].name+"를 하셔야 합니다.")
					$('input[id='+requiredTerms[i].id+']').focus()
					check = false;
					return false;
				}
			}
		} else{
			check = true;
		}
		
		return check;
	},
	this.checkMbrCCardNo = function(){
		if($.fn.ifvmIsEmpty($("#mbrCCardNo").val())){
			alert('<spring:message code="D10313"/>');
		}else{
			if($("#mbrCCardNo").val().length != 16 ){
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
	this.checkUserId = function() {
		if($.fn.ifvmIsEmpty($("#user_id").val())){
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
       		}.bind(this));
		}
	},
	this.checkRcmmdNo = function() {
		if($.fn.ifvmIsEmpty($("#rcmmd_no").val())){
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
       		}.bind(this));
		}
	},
	this.certChange = function(){
		var selectItem = $("#certTypeCd").val();
		if(selectItem == 'NO_CERT'){
			$("#getCert").attr("disabled", true);
			 
			/* disArr = [ 'cust_nm', 'gen_cd', 'email', 'emailBackSelet', 'hhpTop', 'hhpMid', 'hhpBot', 'birthdt', 'lunar_cd'];
			this.disabledId(disArr, false); */
			shArr = ['certValArea'];
			this.showNhide(shArr, false);
			requiredArr = ['certVal']
			this.setRequired(requiredArr, false);
			
		}else{
			$("#getCert").attr("disabled", false);
			 
			/* disArr = [ 'cust_nm', 'gen_cd', 'email', 'emailBackSelet', 'hhpTop', 'hhpMid', 'hhpBot', 'birthdt', 'lunar_cd'];
			this.disabledId(disArr, true); */
			shArr = ['certValArea'];
			this.showNhide(shArr, true);
			requiredArr = ['certVal']
			this.setRequired(requiredArr, true);
		}
	},
	this.getPgmCustItemValue = function(){ //프로그램에따른 고객수집항목 다르게 보이기(약관)
		if(pastPgm != null && pastPgm != $("#pgmNo").val()) {
			$('#custAgreForm').remove();
			$('#custAgreMktForm').remove();
			for(var i=0; i<$("#baseForm label").length; i++){ $("#baseForm label")[i].innerHTML = "" }
			
			//동적으로 (이름, 필수여부) 설정
			this.getCustItemValCk();
			this.getTermsList();
		}
	},
	this.action = function() { //버튼
		
        $("#addCustBtn").click(function() { this.save() }.bind(this));

        $("#closePopBtn").click(function() { this.close() }.bind(this));
        
    	$("#checkCardVal").click(function(){ this.checkMbrCCardNo() }.bind(this));
    	
    	$("#userIdChk").click(function(){ this.checkUserId() }.bind(this));
    	
    	$("#rcmmdNoChk").click(function(){ this.checkRcmmdNo() }.bind(this));
        
    	$('#certTypeCd').change(function(){ this.certChange() }.bind(this));
    	
    	$('#pgmNo').change(function(){ this.getPgmCustItemValue() }.bind(this));
    }
}

//로열티 프로그램
function getPgmList(){
	openPop('<ifvm:url name="pgmListPop"/>', '<spring:message code="L02716"/>', 'pgmPopupContainer');
}
//가입채널
function getChnlList(){
	openPop('<ifvm:url name="chnlListPop"/>', '<spring:message code="L00172"/>', 'chnlPopupContainer');
}
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
		alert("<spring:message code="D10323"/>")
	}else{
		openPop('<ifvm:url name="corpCustBranchListPop"/>', '<spring:message code="브렌치"/>', 'brachSearchPop');
	}
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
	var month = $("#annvrsryMm").val();
	var day = $("#annvrsryDd").val();
	
	$("#annvrsry").val(month +""+day);
}

function checkHhp(){
	var top = $("#hhpTop").val();
	var mid = $("#hhpMid").val();
	var bottom = $("#hhpBot").val();
	
	$("#hhp").val(top+mid+bottom);
}

function selecterEmail(obj){
	 var setStr = $("#email").val().split('@');
	
	 if(obj.value != "직접입력") $("#email").val(setStr[0]+obj.value);
	 else $("#email").val(setStr[0]);
} 

$(document).ready(function(){
	newCustPop = new newCustAddPop();
	newCustPop.init();
})
</script>