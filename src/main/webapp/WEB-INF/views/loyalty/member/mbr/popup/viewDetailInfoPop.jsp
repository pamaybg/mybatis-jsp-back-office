<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<div class="form-horizontal underline top_well clearfix" id="mbrDetailInfoWrap">
	<div class="half_content half_left qt_border">
		<!--추가정보  -->
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L01180"/></span><!-- 추가정보 -->
				<!-- 페이지 로드 시 첫번째 활성영역인 기념일 영역으로 focus 이벤트가 자동발생하므로 hidden input 추가. -->
				<input type="text" id="hiddenField" style="background:transparent; border:none; font-size:0px; height:1px; width: 1px; padding:0px; margin:0px;"/>
			</div>
		</div>
		<div class="form-horizontal top_well underline" id="reachInfo" >
			<!-- <div class="row"> -->
				<%--
				<ifvm:inputNew type="select" id="marryYn" dto="marryYn" disabled="false" 	className="blockTarget"
					label="L01181" labelClass="3" conClass="3" /><!-- 결혼여부-->
				 --%>
				<%-- <ifvm:inputNew type="date" id="marryAniv" dto="marryAniv" disabled="false"
					label="L01182" labelClass="3" conClass="3" /><!-- 결혼기념일 --> --%>
				<!-- 기념일-->
				<%-- <ifvm:inputNew type="date" id="anivDt" dto="anivDt" disabled="false" className="blockTarget" label="M02636" labelClass="3" conClass="3" /> --%>
			<!-- </div> -->

			<%-- <div class="row">
				<ifvm:inputNew type="hidden" id="ridChnlPrimary" dto="ridChnlPrimary"/><!-- 단골매장Id-->
				<ifvm:inputNew type="text" id="chnlPrimaryNm" dto="chnlPrimaryNm" label="L02306" labelClass="3" conClass="9" disabled ="true"/><!-- 단골매장-->
			</div> --%>

			<%-- <div class="row">
				<ifvm:inputNew type="singleCheckbox" id="wipointUserYn" label="위포인트사용자여부" nuc="true" values="wipointUserYn" disabled="false" dto="wipointUserYn" labelClass="3" conClass="1" />
				<ifvm:inputNew type="singleCheckbox" id="underForteenYn" label="14세미만여부" nuc="true" values="underForteenYn" disabled="false" dto="underForteenYn" labelClass="3" conClass="1" />
			</div> --%>
			<div class="row">
				<ifvm:inputNew type="singleCheckbox" id="pntAcrlYn" label="포인트적립가능여부" nuc="true" values="pntAcrlYn" disabled="false" dto="pntAcrlYn" labelClass="3" conClass="1" />
				<ifvm:inputNew type="singleCheckbox" id="pntUseYn" label="포인트사용가능여부" nuc="true" values="pntUseYn" disabled="false" dto="pntUseYn" labelClass="7" conClass="1" />
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="pntAcrlNMsg" dto="pntAcrlNMsg" label="포인트적립불가사유" nuc="true" labelClass="3" conClass="9" disabled ="true"/><!-- 단골매장-->
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="pntUserNMsg" dto="pntUserNMsg" label="포인트사용불가사유" nuc="true" labelClass="3" conClass="9" disabled ="true"/><!-- 단골매장-->
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="lastLoginDate" dto="lastLoginDate" label="마지막로그인일시" nuc="true" labelClass="3" conClass="3" disabled ="true"/><!-- 마지막로그인일시-->
				<ifvm:inputNew type="text" id="svrLastChnlNm" dto="svrLastChnlNm" label="마지막서비스채널" nuc="true" labelClass="3" conClass="3" disabled ="true"/><!-- 마지막서비스채널-->
				<%-- <ifvm:inputNew type="text" id="svrLastDt" dto="svrLastDt" label="최종서비스일시" nuc="true" labelClass="3" conClass="3" disabled ="true"/> --%><!-- 최종서비스일시-->
			</div>
			<div class="row">
				<%-- <ifvm:inputNew type="text" id="chnlLastStoreNm" dto="chnlLastStoreNm" label="최근이용한매장" nuc="true" labelClass="3" conClass="3" disabled ="true"/><!-- 최근이용한매장--> --%>
			</div>
			<%-- <div class="row">
				<ifvm:inputNew type="text" id="webIdRegDt" dto="webIdRegDt" label="멤버십 전환일" nuc="true" labelClass="3" conClass="3" disabled ="true"/><!-- 마지막서비스채널-->
			</div> --%>
			<%--
			<div class="row">
				<ifvm:inputNew type="text" id="divNm" dto="divNm" disabled="true" label="L01190" labelClass="3" conClass="3" /><!-- 충전소지사 -->
			</div>
			 --%>
		</div>

		<!-- <div class="row"><div class="col-xs-12">&nbsp;</div></div> -->
		<!-- <div class="row"><div class="col-xs-12">&nbsp;</div></div>
		<div class="row"><div class="col-xs-12">&nbsp;</div></div> -->

		<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L02307"/></span><!-- 가입방법 -->
			</div>
		</div>
		<div class="form-horizontal top_well underline" id="" >
			<div class="row">
				<!-- 가입인증방법 -->
				<ifvm:inputNew type="select" id="identiTypePopCd" names="identiTypePopCd" dto="identiTypePopCd" disabled="true" label="L01214" labelClass="3" conClass="3" />
				<!-- 비유효회원일시 -->
				<ifvm:inputNew type="text" id="realnmCertiDate" dto="realnmCertiDate" disabled="true" nuc="true" label="실명인증 일시" labelClass="3" conClass="3" />
				<!-- 실명인증 여부  -->
				<%-- <ifvm:inputNew type="singleCheckbox" id="realNmCertiPopYn" label="비유효회원 여부" nuc="true" disabled="true" dto="realNmCertiPopYn" labelClass="3" conClass="1" /> --%>
			</div>
			<div class="row">
				<!-- 가입채널 -->
<%-- 			<ifvm:inputNew type="select" id="ridChnlJoin" dto="ridChnlJoin" disabled="true" label="L00859" labelClass="3" conClass="3" /> --%>
				<ifvm:inputNew type="text" id="chnlJoinNm" dto="chnlJoinNm" disabled="true" label="L00859" labelClass="3" conClass="3" />
			</div>
			<div class="row">
				<!-- 가입일시 -->
				<ifvm:inputNew type="text" id="joinDate" dto="joinDate" disabled="true" label="L01121" labelClass="3" conClass="3" />
			</div>
		</div>

		<%--
		<!--인증정보  -->
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L01232"/></span><!-- 인증정보 -->
			</div>
		</div>
		<div class="form-horizontal top_well underline" id="" >
			<div class="row">
				<ifvm:inputNew type="singleCheckbox" id="phCertiYn" label="L01194" values="phCertiYn"	disabled="true"
					dto="phCertiYn" 	labelClass="3" conClass="3" /><!-- 핸드폰인증 -->
				<ifvm:inputNew type="select" id="foreignCd" dto="foreignCd" disabled="true"
					label="L01234" labelClass="3" conClass="3" /><!-- 내외국인 구분-->
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="ipinNo" dto="ipinNo" disabled="true"
					label="L01235" labelClass="3" conClass="3" /><!-- I Pin 번호-->
				<ifvm:inputNew type="select" id="authReslt" dto="authReslt" disabled="true"
					label="L01238" labelClass="3" conClass="3" /><!-- 인증결과 -->
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="rqtNo" dto="rqtNo" disabled="true"
					label="L01239" labelClass="3" conClass="3" /><!-- 요청번호 -->
				<ifvm:inputNew type="text" id="ipadr" dto="ipadr" disabled="true"
					label="L01240" labelClass="3" conClass="3" /><!-- IP 주소-->
			</div>
			<div class="row">
				<ifvm:inputNew type="select" id="authAgegrd" dto="authAgegrd" disabled="true"
					label="L01237" labelClass="3" conClass="3" /><!-- 인증시 연령대-->
				<ifvm:inputNew type="text" id="altrVrfMsg" dto="altrVrfMsg" disabled="true"
					label="L01236" labelClass="3" conClass="3" /><!-- 위변조검증메세지 -->
			</div>
		</div>
		 --%>
	</div>

	<div class="half_content half_right">
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L01192"/></span><!-- 연락처 및 동의정보 -->
			</div>
		</div>
		<div class="form-horizontal top_well underline" id="mktAgree" >

            <div class="row">
                <!-- 이메일 주소-->
                <ifvm:inputNew type="text" id="emailAddrDec" dto="emailAddrDec" disabled="false" valiItem="email" className="blockTarget" label="L01202" labelClass="3" conClass="4" />
                <!--약관동의-->
                <ifvm:inputNew type="singleCheckbox" id="mbrTermsAgre" label="약관 동의" nuc="true" values="mbrTermsAgre" disabled="false" dto="mbrTermsAgre" labelClass="4" conClass="1" />
            </div>
            <div class="row">
                <!-- 이메일 변경일시-->
                <%-- <ifvm:inputNew type="text" id="emailChgDt" dto="emailChgDt" disabled="true" label="L01205" labelClass="3" conClass="4" /> --%>
                <!-- 마케팅정보 수신 동의-->
<%--                 <ifvm:inputNew type="singleCheckbox" id="mktAgrePrmEvt" label="L02098" values="mktAgrePrmEvt" disabled="false" dto="mktAgrePrmEvt" labelClass="4" conClass="1" /> --%>
				<!-- 개인정보 수집 및 이용동의-->
                <ifvm:inputNew type="singleCheckbox" id="mktAgrePrvInfo" label="개인정보 수집 및 이용 동의" nuc="true" values="mktAgrePrvInfo" disabled="false" dto="mktAgrePrvInfo" labelClass="11" conClass="1" />
            </div>
            <div class="row">
                <!-- 핸드폰변경일시-->
                <%-- <ifvm:inputNew type="text" id="hpChgDt" dto="hpChgDt" disabled="true" label="L01196" labelClass="3" conClass="4" /> --%>
                <!-- 마케팅 및 광고활용 동의 -->
                <ifvm:inputNew type="singleCheckbox" id="mktAgreUse" label="마케팅 및 광고활용 동의" nuc="true" values="mktAgreUse" disabled="false" dto="mktAgreUse" labelClass="11" conClass="1" />
                <!-- 위치정보 이용 동의 -->
                <%-- <ifvm:inputNew type="singleCheckbox" id="mktAgreLbsBiz" label="위치정보 이용동의" nuc="true" values="mktAgreLbsBiz" disabled="false" dto="mktAgreLbsBiz" labelClass="4" conClass="1" /> --%>
            </div>
            <div class="row">
                <!-- 주소변경일시 -->
                <%-- <ifvm:inputNew type="text" id="ownhomeAdrChgDt" dto="ownhomeAdrChgDt" disabled="true" label="L01186" labelClass="3" conClass="4" /> --%>
                 <!-- 개인정보 제3자 제공동의 -->
                <%-- <ifvm:inputNew type="singleCheckbox" id="mktAgreThirdSnd" dto="mktAgreThirdSnd" values="mktAgreThirdSnd" disabled="false" label="개인정보 제3자 제공 동의" nuc="true" labelClass="4" conClass="1" /> --%>
            </div>
            <div class="row">
                <!-- 핸드폰변경일시-->
                <%-- <ifvm:inputNew type="text" id="hpChgDt" dto="hpChgDt" disabled="true" label="L01196" labelClass="3" conClass="4" /> --%>
                 <!-- 개인정보 제3자 제공동의 주석처리 BAT-->
<%--                 <ifvm:inputNew type="singleCheckbox" id="mktAgreThirdSnd" dto="mktAgreThirdSnd" values="mktAgreThirdSnd" disabled="false" label="개인정보 제3자 제공 동의" nuc="true" labelClass="4" conClass="1" />
 --%>                <!-- 위치정보 이용 동의 -->
                <%-- <ifvm:inputNew type="singleCheckbox" id="mktAgreLbsBiz" label="위치정보 이용동의" nuc="true" values="mktAgreLbsBiz" disabled="false" dto="mktAgreLbsBiz" labelClass="4" conClass="1" /> --%>
            </div>
          
           <%--  <div class="row">
                	기념일변경일시
               <ifvm:inputNew type="text" id="anivUpdDt" dto="anivUpdDt" disabled="true" label="기념일변경일시" nuc="true" labelClass="3" conClass="4" />
                Push 혜택수신동의 
	                 <ifvm:inputNew type="singleCheckbox" id="" dto="f" disabled="false" label="L02310" labelClass="4" conClass="1" />
            </div> --%>
<%--             <div class="row">
                <!-- Push 기본수신동의 -->
                <ifvm:inputNew type="singleCheckbox" id="chnlAgrePush" dto="chnlAgrePush" values="chnlAgrePush" disabled="false" label="L02308" labelClass="11" conClass="1" />
            </div>
            <div class="row">
                <!-- 카카오톡 수신 동의 -->
                <ifvm:inputNew type="singleCheckbox" id="chnlAgreKakao" label="L02311" values="chnlAgreKakao" disabled="false" dto="chnlAgreKakao" labelClass="11" conClass="1" />
            </div>
            <div class="row">
                <!-- SMS 수신동의 -->
                <ifvm:inputNew type="singleCheckbox" id="chnlAgreSms" label="L01195" values="chnlAgreSms" disabled="false" dto="chnlAgreSms" labelClass="11" conClass="1" />
            </div>
            <div class="row">
                <!-- EMAIL 수신동의 -->
                <ifvm:inputNew type="singleCheckbox" id="chnlAgreEmail" label="L01198" values="chnlAgreEmail" disabled="false" dto="chnlAgreEmail" labelClass="11" conClass="1" />
            </div>
            <div class="row">
                <!-- 영수증 용지 발행 전환 여부 -->
                <ifvm:inputNew type="singleCheckbox" id="eReceiptUseYn" label="L02312" values="eReceiptUseYn" disabled="false" dto="eReceiptUseYn" labelClass="11" conClass="1" />
            </div> --%>

			<div class="row"><div class="col-xs-12">&nbsp;</div></div>
			<div class="row"><div class="col-xs-12">&nbsp;</div></div>
		</div>

		<!--직장정보  -->
		<%-- <div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L01219"/></span><!-- 직장정보-->
			</div>
		</div>
		<div class="form-horizontal top_well underline" id="mktAgree" >
			<div class="row">
				<ifvm:inputNew type="text" id="wkplcNm" dto="wkplcNm" disabled="true"
					label="L01220" labelClass="3" conClass="3" /><!-- 직장명-->
				<ifvm:inputNew type="text" id="deptNm" dto="deptNm" disabled="true"
					label="L01221" labelClass="3" conClass="3" /><!-- 부서명-->
			</div>
			<div class="row">
				<ifvm:inputNew type="search" id="addr2JiZip" dto="addr2JiZip" disabled="true"
					label="L01222" labelClass="3" conClass="3" /><!-- 직장우편번호-->
				<ifvm:inputNew type="text" id="wkplcAdrChgDt" dto="wkplcAdrChgDt" disabled="true"
					label="L01223" labelClass="3" conClass="3" /><!-- 주소변경일시-->
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="addr2JiDflt" dto="addr2JiDflt" disabled="true"
					label="L01224" labelClass="3" conClass="9" /><!-- [지번]주소-->
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="addr2JiDtl" dto="addr2JiDtl" disabled="true"
					label="L01225" labelClass="3" conClass="9" /><!-- [지번]주소상세-->
			</div>

			<div class="row">
				<ifvm:inputNew type="select" id="intrstFild1" dto="intrstFild1" disabled="true"
					label="L01226" labelClass="3" conClass="3" /><!-- 관심분야 #1-->
				<ifvm:inputNew type="select" id="intrstFild2" dto="intrstFild2" disabled="true"
					label="L01227" labelClass="3" conClass="3" /><!-- 관심분야 #2-->
			</div>

			<div class="row">
				<ifvm:inputNew type="search" id="addr2Zip" dto="addr2Zip" disabled="true"
					label="L01228" labelClass="3" conClass="3" /><!-- 직장우편번호-->
				<ifvm:inputNew type="text" id="wkplcAdrChgDt" dto="wkplcAdrChgDt" disabled="true"
					label="L01229" labelClass="3" conClass="3" /><!-- 주소변경일시-->
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="addr2Dflt" dto="addr2Dflt" disabled="true"
					label="L01230" labelClass="3" conClass="9" /><!-- [도로명]주소-->
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="addr2Dtl" dto="addr2Dtl" disabled="true"
					label="L01231" labelClass="3" conClass="9" /><!-- [도로명]주소상세-->
			</div>
		</div> --%>

	<!--오렌지 포인트 자동차감 정보  -->
<!-- 		<div class="page_btn_area"> -->
<!-- 			<div class="col-xs-12"> -->
<%-- 				<span><spring:message code="L01208"/></span><!-- 오렌지 포인트 자동차감 정보 --> --%>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="form-horizontal top_well underline" id="" > -->
<!-- 			<div class="row"> -->
<%-- 				<ifvm:inputNew type="singleCheckbox" id="autordmAgreeYn" label="L01209" values="autordmAgreeYn"	disabled="true" --%>
<%-- 					dto="autordmAgreeYn" 	labelClass="3" conClass="3" /><!-- 자동차감동의--> --%>
<%-- 				<ifvm:inputNew type="text" id="autordmPoint" dto="autordmPoint" disabled="true" --%>
<%-- 					label="L01210" labelClass="3" conClass="3" /><!-- 자동차감포인트--> --%>
<!-- 			</div> -->
<!-- 			<div class="row"> -->
<%-- 				<ifvm:inputNew type="text" id="autordmChgDt" dto="autordmChgDt" disabled="true" --%>
<%-- 					label="L01211" labelClass="3" conClass="4" /><!-- 자동차감변경일시 --> --%>
<!-- 			</div> -->
<!-- 		</div> -->
		<!--기타정보  -->
		<%-- <div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L01241"/></span><!-- 기타정보-->
			</div>
		</div> --%>
		<%-- <div class="form-horizontal top_well underline" id="mktAgree" >

            <div class="row">
                <!-- 내외국인 구분 -->
                <ifvm:inputNew type="select" id="foreignCd" dto="foreignCd" disabled="true" label="L01242" labelClass="3" conClass="3" />
            </div>
            <div class="row">
                <!-- 내외국인 구분 -->
                <ifvm:inputNew type="select" id="mbrTypeCd" dto="fraudMemDiv" disabled="true" label="L01069" labelClass="3" conClass="3" />
                <!-- 조치구분 -->
                <ifvm:inputNew type="text" id="" dto="s" disabled="true" label="L01070" labelClass="3" conClass="3" />
            </div> --%>

		<%--
			<div class="row">
				<ifvm:inputNew type="select" id="mbrTypeCd" dto="mbrTypeCd" disabled="true"
					label="L01242" labelClass="3" conClass="3" /><!-- 회원유형-->
				<ifvm:inputNew type="select" id="mbrStatCd" dto="mbrStatCd" disabled="true"
					label="L01244" labelClass="3" conClass="3" /><!-- 회원상태-->
				<ifvm:inputNew type="text" id="carUsePurp" dto="carUsePurp" disabled="true"
					label="L01247" labelClass="3" conClass="3" /><!-- 차량사용용도-->

			</div>
			<div class="row">
				<ifvm:inputNew type="select" id="custValue" dto="custValue" disabled="true"
					label="L01243" labelClass="3" conClass="3" /><!-- 고객가치 -->
				<ifvm:inputNew type="select" id="memLcStage" dto="memLcStage" disabled="true"
					label="L01245" labelClass="3" conClass="3" /><!-- 회원생애단계-->
			</div>

			<div class="row">
				<ifvm:inputNew type="select" id="camTgtMem" dto="camTgtMem" disabled="true"
					label="L01246" labelClass="3" conClass="3" /><!-- 캠페인 대상회원-->
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="pmonChargAmt" dto="pmonChargAmt" disabled="true"
					label="L01248" labelClass="3" conClass="3" /><!-- 전월구매금액-->
				<ifvm:inputNew type="text" id="pmonChagrQnt" dto="pmonChagrQnt" disabled="true"
					label="L01249" labelClass="3" conClass="3" /><!-- 전월구매횟수-->
			</div>

			<div class="row">
				<ifvm:inputNew type="select" id="spousLunarGbnCd" dto="spousLunarGbnCd" disabled="true"
					label="L01250" labelClass="3" conClass="3" /><!-- 배우자생일구분-->
				<ifvm:inputNew type="text" id="spousBthday" dto="spousBthday" disabled="true"
					label="L01251" labelClass="3" conClass="3" /><!-- 배우자생년월일-->
			</div>

			<div class="row">
				<ifvm:inputNew type="checkbox" id="childFlg" text="L01252" values=""
					labelClass="2" conClass="3" /><!-- 자녀유무-->
				<ifvm:inputNew type="singleCheckbox" id="cmpnTelErrYn" label="L01255" values="cmpnTelErrYn"	disabled="false"
					dto="cmpnTelErrYn" 	labelClass="3" conClass="1" /><!-- 회사전화 오류-->
				<ifvm:inputNew type="singleCheckbox" id="ownhomeTelErrYn" label="L01253" values="ownhomeTelErrYn"	disabled="false"
				<ifvm:inputNew type="singleCheckbox" id="hpErrYn" label="L01197" values="hpErrYn"	disabled="false"
					dto="hpErrYn" 	labelClass="3" conClass="1" /><!-- 핸드폰 오류 -->
				<ifvm:inputNew type="singleCheckbox" id="emailErrYn" label="L01200" values="emailErrYn"	disabled="false"
					dto="emailErrYn" 	labelClass="3" conClass="1" /><!-- 이메일 오류 -->
			</div>
			<div class="row">
			<ifvm:inputNew type="singleCheckbox" id="indvTaxiConvRqt" label="L01233" values="indvTaxiConvRqt" disabled="true"
					dto="indvTaxiConvRqt" 	labelClass="3" conClass="3" /><!-- 개인택시 전환요청-->
			</div>
			<ifvm:inputNew type="hidden" id="hCity" dto="hCity" />
			<ifvm:inputNew type="hidden" id="hGu" dto="hGu" />
			 --%>
			 <%--
			<ifvm:inputNew type="hidden" id="addr1Dflt" dto="addr1Dflt" />
			<ifvm:inputNew type="hidden" id="addr1Dtl" dto="addr1Dtl" />
			<ifvm:inputNew type="hidden" id="addr1Zip" dto="addr1Zip" />
			 --%>
		</div>
	</div>
</div>
<div class="pop_btn_area">
   <ifvm:inputNew type="button" btnType="save"	text="L01462" id="saveBtn"	btnFunc="gMbrDetailInfo.save" className="btn_lightGray2" objCode="saveBtnViewDetail_obj"/>
   <ifvm:inputNew type="button" btnType="close"	text="L00913" btnFunc="mbrDetailInfo.close" className="btn_lightGray2" objCode="closeDetail_obj"/>
</div>

<!-- 주소 검색 -->
<div id="addrPopupContainer" class="popup_container"></div>

<script>
var ridMbr = '<%= cleanXss(request.getParameter("ridMbr")) %>';
var addr1ZipTempPop;

/*  주소 */
function addrSearchHelpPopBlur() {
	$('#mbrDetailInfoWrap #addr1Zip').val(addr1ZipTempPop);
}

function addrSearchHelpPopBtn(){
	fnAddrSearchHelpPop();
}
function addrSearchHelpPopEnter(){
	fnAddrSearchHelpPop();
}

function execDaumPostcodePop() {

    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
//	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                fullAddr = data.roadAddress;
//	            }
//	            else { // 사용자가 지번 주소를 선택했을 경우(J)
//	                fullAddr = data.jibunAddress;
//	            }

            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
//	            if(data.userSelectedType === 'R'){
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
//	            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
        //    document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
        //    document.getElementById('sample6_address').value = fullAddr;
            /*도로명  */
            $("#mbrDetailInfoWrap #addr1Zip").val(data.zonecode);

        	/*지번 */
//         	$("#mbrDetailInfoWrap #addr1JiDflt").val(data.jibunAddress);
//         	$("#mbrDetailInfoWrap #addr1JiDtl").focus();
//         	$("#mbrDetailInfoWrap #addr1JiZip").val(data.zonecode);

            // 커서를 상세주소 필드로 이동한다.
        //    document.getElementById('sample6_address2').focus();
        }
    }).open();
}

function fnAddrSearchHelpPop() {
	execDaumPostcodePop();
// 		addrSearchHelpPop ={
// 			        id : "addrPopupContainer"
// 			    };
// 		addrSearchHelpPop.popup = function (){
// 			addrSearchHelpPop.pop = $('#'+addrSearchHelpPop.id).ifvsfPopup({
// 			            enableModal: true,
// 			            enableResize: false,
// 			            contentUrl: '<ifvm:url name="zipCodeListPop"/>',
// 			            contentType: "ajax",
// 			            title: '<spring:message code="L00442"/>',
// 			            width: '700px',
// 			            close: addrSearchHelpPop.close
// 			        });
// 			};
// 			addrSearchHelpPop.beforeClose = function (obj) {
// 			};
// 			addrSearchHelpPop.close = function (obj) {
// 				 if(obj!=null&&obj.type!="close"){
// 					 if(obj=="reset"){
// 						 addr1ZipTempPop = null;
// 					 }else{
// 						 addr1ZipTempPop = obj.zipNo;
// 					 }
// 					 $("#mbrDetailInfoWrap #addr1Zip").val(obj.zipNo);
// 		        	/*도로명  */
// 		        	$("#mbrDetailInfoWrap #addr1Dflt").val(obj.roadAddr );
// 		        	$("#mbrDetailInfoWrap #addr1Dtl").val(obj.dtlAddr);
// 		        	/*지번 */
// 		        	$("#mbrDetailInfoWrap #addr1JiDflt").val(obj.jibunAddr );
// 		        	$("#mbrDetailInfoWrap #addr1JiDtl").val(obj.dtlAddr);
// 		        	$("#mbrDetailInfoWrap #addr1JiZip").val(obj.zipNo);

// 		        	$("#mbrDetailInfoWrap #hCity").val(obj.siNm);
// 		        	$("#mbrDetailInfoWrap #hGu").val(obj.sggNm);

// 				 }else{
// 					 $("#mbrDetailInfoWrap #addr1Zip").val(addr1ZipTempPop);
// 				 }
// 				 addrSearchHelpPop.beforeClose(obj);
// 				    addrPopupContainer._destroy();
// 			 };
// 			 addrSearchHelpPop.popup();
}

	gMbrDetailInfo= {
		data : {},
		checkBoxIds : [
		    'chnlAgreSms', 'chnlAgreEmail', 'indvTaxiConvRqt', 'mktAgrePrvInfo', 'chnlAgreKakao', 'eReceiptUseYn', 'chnlAgrePush'
		    , /* 'wipointUserYn', */ 'underForteenYn', 'pntAcrlYn', 'pntUseYn', 'mktAgreThirdSnd', 'mktAgreLbsBiz', 'mktAgreUse', 'mbrTermsAgre'
		],
		//checkBoxIds : [/* 'phCertiYn', */ , /* 'hpErrYn', */ , /* 'emailErrYn', 'smartphPssnYn', 'iparkInfoPrvAgreeYn', 'autordmAgreeYn', */, /* 'cmpnTelErrYn', 'ownhomeTelErrYn', 'chnlAgreDm', 'chnlAgreTel','appBenefitYn', 'appNewsYn' ,'mktAgrePrmEvt', *//*, 'kkatlkRcvYn', 'appDownlYn' */],
		//pointFieldId : ['pmonChargAmt', 'pmonChagrQnt'],
		dateFieldId : ['anivDt'],
		dateTimeFieldId : ['ownhomeAdrChgDt', 'hpChgDt', 'emailChgDt'], //'autordmChgDt', 'wbSbscDt', 'calCentrSbscDt'
		setCheckBox : function(result){
			for (i in gMbrDetailInfo.checkBoxIds) {
				if (result[gMbrDetailInfo.checkBoxIds[i]] != ""
				        && result[gMbrDetailInfo.checkBoxIds[i]] != null
				        && (result[gMbrDetailInfo.checkBoxIds[i]]).toUpperCase() == "Y") {
					$("#mbrDetailInfoWrap input[type='checkbox'][value='" + gMbrDetailInfo.checkBoxIds[i] + "']").prop('checked', true);
				}
			}
		},/*
		setPointField : function(){
			for(var pi = 0 ; pi < this.pointFieldId.length ; pi++){
				var _pval = $("#"+this.pointFieldId[pi]).val();
				var _aval="";
				if(_pval){
					_aval = (_pval.split(".")[0]).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				}
				$("#mbrDetailInfoWrap #"+this.pointFieldId[pi]).css("text-align","right").val(_aval);
			}
		}, */
		setDateField : function(){
			for(var pi = 0 ; pi < this.dateFieldId.length ; pi++){
				var _pval = $("#"+this.dateFieldId[pi]).val();
				var _aval="";
				if(_pval){
					_aval = _pval.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
				}
				$("#mbrDetailInfoWrap #" + this.dateFieldId[pi]).val(_aval);
			}
		},
		setDateTimeField : function(){
			for(var pi = 0 ; pi < this.dateTimeFieldId.length ; pi++){
				var _pval = $("#"+this.dateTimeFieldId[pi]).val();
				var _aval="";
				if(_pval){
					_aval = _pval.split('.')[0];
				}
				$("#mbrDetailInfoWrap #"+this.dateTimeFieldId[pi]).val(_aval);
			}
		},
		clearMasking : function(result){
			var targetField = [{
				type : 'mbr',
				field : 'email',
				rid : $.ifvGetParam('rid'),
				target : 'emailAddr'
			}]
			for (var i=0  ; i < targetField.length ; i++){
				$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>',
						targetField[i],
		        function(result) {
					$("#"+targetField[i].target).val(result.message);
					if(result.message){
						gMbrDetail.data[targetField[i].target] = result.message;
					}
			     })
			}
		},
		init : function (){
			//$.ifvGetCommCodeList('select', 'job', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_JOB', 'loy', false, false, true);
			$.ifvGetCommCodeList('select', 'genGbnCd', '<ifvm:action name="getCommCodeList2"/>', 'LOY_GEN_CD', 'loy', false, false, true);
			//$.ifvGetCommCodeList('select', 'pstmatrRecvDesk', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_POST_LOC', 'loy', false, false, true);
// 			$.ifvGetCommCodeList('select', 'identiTypePopCd', '<ifvm:action name="getCommCodeList2"/>', 'CERTIFICATION_METHOD', 'loy', false, false, true);
			//$.ifvGetCommCodeList('select', 'identiTypePopCd', '<ifvm:action name="getCommCodeList2"/>', 'MEM_IDENTI_TYPE', 'loy', false, false, true);
			$.ifvGetCommCodeList('select', 'identiTypePopCd', '<ifvm:action name="getCommCodeList2"/>', 'LOY_IDENTI_TYPE_CD', 'loy', false, false, true);
			$.ifvGetCommCodeList('select', 'fraudMemDiv', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_CLAIM_CD', 'loy', false, false, true);
			//$.ifvGetCommCodeList('select', 'actnDiv', '<ifvm:action name="getCommCodeList2"/>', 'CLAIM_MANAGE_TYPE', 'loy', false, false, true);
			$.ifvGetCommCodeList('select', 'intrstFild1', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_HOBBY', 'loy', false, false, true);
			$.ifvGetCommCodeList('select', 'intrstFild2', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_HOBBY', 'loy', false, false, true);
			$.ifvGetCommCodeList('select', 'mbrTypeCd', '<ifvm:action name="getCommCodeList2"/>', 'LOY_MEM_TYPE_CD', 'loy', false, false, true);
			$.ifvGetCommCodeList('select', 'mbrStatCd', '<ifvm:action name="getCommCodeList2"/>', 'LOY_MEM_STAT_CD', 'loy', false, false, true);
			//$.ifvGetCommCodeList('select', 'spousLunarGbnCd', '<ifvm:action name="getCommCodeList2"/>', 'BIRTHDAY_CD', 'loy', false, false, true);
			$.ifvGetCommCodeList('select', 'foreignCd', '<ifvm:action name="getCommCodeList2"/>', 'FOREIGN_CD', 'loy', false, false, true);
			//$.ifvGetCommCodeList('select', 'authAgegrd', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_AGE', 'loy', false, false, true);
			//$.ifvGetCommCodeList('select', 'authReslt', '<ifvm:action name="getCommCodeList2"/>', 'CERTIFICATION_RESULT', 'loy', false, false, true);
			//$.ifvGetCommCodeList('select', 'camTgtMem', '<ifvm:action name="getCommCodeList2"/>', 'CAMP_CON_TYPE', 'loy', false, false, true);
			//$.ifvGetCommCodeList('select', 'marryYn', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_MARRIED_CD', 'loy', false, false, true);
			//this.dateInit();
			this.loadData();

			$("#mbrDetailInfoWrap #mktAgrePrvInfo").click(function() {
				if ($(this).is(':checked')) {
					$("#mbrDetailInfoWrap .blockTarget").prop("disabled", false);
				} else {
					$("#mbrDetailInfoWrap .blockTarget").prop("disabled", true);
				}
			});

			//마케팅정보 수신 동의 => Uncheck 될 경우 화면에서 Confirm Message
			//  => 채널 수신 동의 가 전부 해지 처리가 됩니다 .계속 진행하시겠습니까?
			//  => Yes 할경우 화면에 SMS/ Email/ Push 수신동의 / 알림톡/친구톡 수신동의 값을 Uncheck 처리
			$("#mbrDetailInfoWrap #mktAgrePrmEvt").click(function() {
				if ($(this).is(":checked") == false) {
				  	//채널 수신 동의 가 전부 해지 처리가 됩니다 .\\n계속 진행하시겠습니까?
					if (confirm('<spring:message code="L02190"/>')) {
						$("#chnlAgreSms, #chnlAgreEmail, #chnlAgrePush, #chnlAgreKakao, #eReceiptUseYn").prop('checked',false);
					}
					else {
						$(this).prop('checked',true);
					}
				}
				else if (confirm('<spring:message code="L02190"/>')) {
					$("#chnlAgreSms, #chnlAgreEmail, #chnlAgrePush, #chnlAgreKakao, #eReceiptUseYn").prop('checked', true);
				}
			})

			/**
			 * 2018.12.04 hy.jun
			 * 저장 버튼 주석처리 & 모든 영역 disabled 처리 (다이소는 관리자가 회원정보 수정할 수 없다.)
			 */
			var exceptList = ['pntAcrlYn','pntUseYn','pntAcrlNMsg','pntUserNMsg']; //disabled 제외할 input id
			$('#mbrDetailInfoPop input').each(function(i, e) {
				var isTarget = true;

				$.each(exceptList, function(i2, e2) {
					if(e2 == $(e).attr('id')) {
						isTarget = false;
					}
				});

				if(isTarget) {
					$(e).attr('disabled', true);
				} else {
					$(e).attr('disabled', false);
				}
			});

			/**
			 * 2018.12.11 hy.jun
			 * 포인트 적립/사용 가능여부 체크 해제 시 사유 입력 필수
			 */
			$('#pntAcrlYn').on('change', function(data) {
				if(!$('#pntAcrlYn').is(':checked')) {
					$('#pntAcrlNMsg').attr('required', true);
				} else {
					$('#pntAcrlNMsg').attr('required', false);
				}
			});

			$('#pntUseYn').on('change', function(data) {
				if(!$('#pntUseYn').is(':checked')) {
					$('#pntUserNMsg').attr('required', true);
				} else {
					$('#pntUserNMsg').attr('required', false);
				}
			});
		},
		dateInit : function(){
			var anivDt  = $('#mbrDetailInfoWrap #anivDt');
			anivDt.val();
			anivDt.ifvDateChecker({});
		},
		loadData : function(){
			var action = '<ifvm:action name="getMbrDetailInfo"/>';
			$.ifvSyncPostJSON(action, {
				rid: ridMbr
			}, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					gMbrDetailInfo.data = result;
					$("#mbrDetailInfoWrap").dataSetting(result);
					gMbrDetailInfo.setDateTimeField();
					gMbrDetailInfo.setDateField();
					//gMbrDetailInfo.setPointField();
					gMbrDetailInfo.setCheckBox(result);
					//gMbrDetail.clearMasking(result);
					addr1ZipTempPop = result.addr1Zip;
					$("#identiTypePopCd").val(result.identiTypeCd);
				
					//자택전화 오류, 핸드폰 오류, 이메일 오류 체크박스는 값이 있을 때 체크 가능
					//if(!gMbrDetail.data.homeTelNo) $("#ownhomeTelErrYn").prop('disabled',true).prop('checked',false);
					//if(!gMbrDetail.data.hhpNo) $("#hpErrYn").prop('disabled',true).prop('checked',false);
					//if(!result.emailAddr) $("#emailErrYn").prop('disabled',true).prop('checked',false);

					//탈회회원 저장버튼 비활성화
					if (gMbrDetail.data.mbrStatCd == "20") {
						$("#saveBtn").prop("disabled",true);
					}

					//탈회회원 저장버튼 비활성화(BAT)
					if(result.mbrStatCd=="C"){
						$("#saveBtn").hide();
					}
					
					//개인정보 수집 및 동의 N일시 필드 비활성화
					if (gMbrDetailInfo.data.mktAgrePrvInfo == "Y") {
						$("#mbrDetailInfoWrap .blockTarget").prop("disabled", false);
					} else {
						$("#mbrDetailInfoWrap .blockTarget").prop("disabled", true);
					}

					if($.fn.ifvmIsNotEmpty(result.anivDt)) {
						$('#mbrDetailInfoWrap #anivDt').ifvDateChecker({});
					}
					
					if(result.smokingYn == 'N'){
						$("#smokingPopYn").prop("checked",false);
					}else{
						$("#smokingPopYn").prop("checked",true);
					}
				}
			})
		},
		checkDateVali : function(_date) {
			var date = _date + "";
			date = date.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');

			var dateType = new Date(date);
			console.log(dateType);
			dateType += "";

			if (dateType.indexOf('Invalid') > -1) {
				return false;
			} else {
				return true;
			}
		},
		save : function() {
			var validation = $("#mbrDetailInfoWrap").ifvValidation();
			if (validation.confirm()) {
				var tgtData = $("#mbrDetailInfoWrap").getSubmitData();

				if (tgtData.anivDt) {
					if (!gMbrDetailInfo.checkDateVali(tgtData.anivDt)) {
						alert('기념일이 날짜형식에 맞지 않습니다.');
						return;
					}
				}

				data = gMbrDetailInfo.data;
// 				if (gMbrDetail.data.homeTelNo) {
// 					data.homeTelNo = gMbrDetail.data.homeTelNo.replaceAll("-", "");
// 				}
				//data.marryYn = tgtData.marryYn
//				data.anivDt = tgtData.anivDt.replaceAll("-", "");//-없애기
//				data.anivDt = data.anivDt.substring(4,8);
				//data.pstmatrRecvDesk = tgtData.pstmatrRecvDesk;
// 				data.addr1JiZip = tgtData.addr1JiZip;
// 				data.addr1JiDflt = tgtData.addr1JiDflt;
// 				data.addr1JiDtl = tgtData.addr1JiDtl;
// 				data.hCity = tgtData.hCity;
// 				data.hGu = tgtData.hGu;
//				data.addr1Dtl = tgtData.addr1Dtl;
				data.mktAgrePrvInfo = tgtData.mktAgrePrvInfo;
				data.mktAgreUse = tgtData.mktAgreUse;
				data.mktAgreLbsBiz = tgtData.mktAgreLbsBiz;
				data.mktAgreThirdSnd = tgtData.mktAgreThirdSnd;
				data.pntAcrlNMsg = tgtData.pntAcrlNMsg;
				data.pntUserNMsg = tgtData.pntUserNMsg;

				data.emailAddr = tgtData.emailAddrDec.toLowerCase(); //이메일은 소문자로만 저장...

				for(var i = 0 ; i < gMbrDetailInfo.checkBoxIds.length ; i++){
					var id = gMbrDetailInfo.checkBoxIds[i];

					if (tgtData[id]) data[id] = "Y"
					else             data[id] = "N"
				}
				data.rid = ridMbr;
				data.mbrNo = gMbrDetail.data.mbrNo;

				//'개인정보 수집 및 이용 동의(mktAgrePrvInfo)'가 선택되어 있지 않으면 이메일,주소 정보 수집 불가능
				if (!tgtData.mktAgrePrvInfo
						&& ( data.emailAddr != ""
						        || data.marryAniv != "" )) {//data.marryYn != "" || data.addr1JiDflt != "" || data.addr1JiDtl != "" || data.addr1JiZip != ""
					if (confirm('<spring:message code="L02188"/>')) {//개인정보 수집 및 이용동의를 하지 않아 주소 및 이메일, 결혼, 자택전화번호 정보를 제거합니다. \\n계속하시겠습니까?
						data.emailAddr = "";
						data.marryAniv = "";
						//data.marryYn = "";
						//data.addr1JiDflt = "";
						//data.addr1JiDtl = "";
						//data.addr1JiZip = "";
					} else {
						return;
					}
					/* if(tgtData.homeTelNo != ""){
						alert('<spring:message code="L02113"/>');//개인정보 수집 및 이용 동의를 받으셔야 주소 및 이메일,결혼,자택전화번호 정보 수집이 가능 합니다.
						return;
					} */
				}

				// SMS(chnlAgreSms), E-Mail(chnlAgreEmail), Push기본수신동의(appBenefitYn), 알림톡/친구톡 수신동의(chnlAgreKakao)
				// 하나라도 체크가 되어있다면 "마케팅정보 수신 동의(mktAgrePrmEvt)"가 체크
				if (tgtData.chnlAgreSms || tgtData.chnlAgreEmail || tgtData.chnlAgreKakao || tgtData.chnlAgrePush) {
					data.mktAgrePrmEvt = "Y"
				}

				console.log(data);

// 				var saveData = {};
// 				if($('#pntAcrlYn').is(':checked')) {
// 					saveData.pntAcrlYn = 'Y'
// 				} else {
// 					saveData.pntAcrlYn = 'N'
// 				}
// 				if($('#pntUseYn').is(':checked')) {
// 					saveData.pntUseYn = 'Y'
// 				} else {
// 					saveData.pntUseYn = 'N'
// 				}

// 				saveData.pntAcrlNMsg = $('#pntAcrlNMsg').val();
// 				saveData.pntUserNMsg = $('#pntUserNMsg').val();

				var action = '<ifvm:action name="editMbrDetailInfo"/>';
				$.ifvSyncPostJSON(action, data , function(result) {
// 				$.ifvSyncPostJSON(action, saveData , function(result) {

					if (result.success) {
						alert('<spring:message code="L01260"/>');
						mbrDetailInfo.close();
					}
				})
			}
		}
	}
	gMbrDetailInfo.init()
</script>