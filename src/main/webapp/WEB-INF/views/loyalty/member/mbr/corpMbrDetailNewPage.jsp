<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<div class="page-title">
    <h1>
        <spring:message code="회원" />
        &gt; <spring:message code="조회" />
    </h1>
</div>
<div>
    <div class="page_btn_area" id="headForm">
        <div class="col-xs-2">
            <span><spring:message code="회원 상세" /></span>
        </div>

        <div class="col-xs-10 searchbtn_r">
<%--            <ifvm:inputNew type="button" btnFunc="custViewPopup" text="회원 360° 뷰" /> --%>
<%--   			<ifvm:inputNew type="button" btnFunc="aToDorBtn" text="휴면회원 전환" objCode="aToDorBtn_OBJ"/> --%>
  
<%--
            <ifvm:inputNew type="button" id='executivesViewPopup' btnFunc="executivesViewPopup" text="임직원 변경" objCode="executivesViewPopup_OBJ"/>
--%>
            <ifvm:inputNew type="button" btnFunc="editMbrDetailBtn" text="회원정보 수정" objCode="mbrDetailEditMbrDetailBtn_OBJ"/>
            <ifvm:inputNew type="button" btnFunc="mbrListPopup" text="타회원 조회" objCode="mbrDetailMbrListPopup_OBJ"/>
            <ifvm:inputNew type="button" btnFunc="getDropMbrPop" text="탈회" objCode="mbrDetailGetDropMbrPop_OBJ"/>
			<ifvm:inputNew type="button" btnFunc="btnList" text="목록" objCode="btnList_OBJ"/>
        </div>
    </div>
    
    <div class="form-horizontal underline top_well" id="mbrForm">
        <div class="row">
            <div class="half_wrap top_well">
                <div class="half_content half_left qt_border">
                    <div class="page_btn_area">
                        <div class="col-xs-2">
                            <span><spring:message code="기본정보" /></span>
                        </div>
                    </div>
                    <div class="form-horizontal top_well underline" id="reachInfo">
                        <div class="row">
                            <ifvm:inputNew type="text" id="pgmNo" dto="pgmNo" disabled="true" label="로열티프로그램" title="로열티프로그램 번호" labelClass="2" conClass="2" />
                            <ifvm:inputNew type="text" id="pgmNm" dto="pgmNm" disabled="true" conClass="2" title="로열티프로그램 이름" />
                            
                            <ifvm:inputNew type="text" id="mbrNo" dto="mbrNo" label="회원번호/상태" labelClass="2" title="회원번호" conClass="2" disabled="true" />
                            <ifvm:inputNew type="text" id="mbrStatCd" dto="mbrStatCd" title="상태" conClass="2" disabled="true" />
                        
                        </div>
                        <div class="row">
                            <ifvm:inputNew type="text" id="custTypeCdNm" dto="custTypeCdNm" label="회원유형" labelClass="2" title="회원유형" conClass="2" disabled="true" />
                            <ifvm:inputNew type="hidden" id="custTypeCd" dto="custTypeCd" label="회원유형" conClass="2" />
                            <ifvm:inputNew type="text" id="mbrTypeCdNm" names="mbrTypeCdNm" dto="mbrTypeCdNm" title="회원상세유형" conClass="2" disabled="true" />
                            
                            <ifvm:inputNew type="text" id="mcardNo" dto="mcardNo" label="카드번호" labelClass="2" title="회원상태" conClass="4" disabled="true" />
                        </div>
                    </div>
                </div>
                <div class="half_content half_right">
                    <div class="page_btn_area">
                        <div class="col-xs-2">
                            <span><spring:message code="가입정보" /></span>
                        </div>
                        <div class="col-xs-10 searchbtn_r"></div>
                    </div>
                    <div class="form-horizontal top_well underline" id="mktAgree">
                        <div class="row">
                            <ifvm:inputNew type="text" id="sbscChnlNm" dto="sbscChnlNm"  label="가입채널" labelClass="2" disabled="true" title="가입채널" conClass="2" />
                            <ifvm:inputNew type="text" id="sbscDate" dto="sbscDate" title="가입일" conClass="2" disabled="true" />
                            
                            <ifvm:inputNew type="text" id="sbscPathCdNm" dto="sbscPathCdNm" label="가입경로" title="가입경로" labelClass="2" conClass="2" disabled="true" />
                            <ifvm:inputNew type="text" id="sbscDeviceCdNm" dto="sbscDeviceCdNm" conClass="2" title="가입디바이스" disabled="true" />
                        </div>
                        <div class="row">
                            <ifvm:inputNew type="text" id="certTypeCd" names="certTypeCd" dto="certTypeCd"  label="인증유형" title="인증유형" labelClass="2" conClass="2" disabled="true" />
                            <ifvm:inputNew type="text" id="certDate" names="certDate" dto="certDate" conClass="2" title="인증일" disabled="true"/>
                            
                            <ifvm:inputNew type="text" id="sbscTypeCdNm" names="sbscTypeCdNm" dto="sbscTypeCdNm"  label="회원가입유형" title="회원가입유형" labelClass="2" conClass="4" disabled="true" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    
        <div class="row">
            <div class="half_wrap top_well">
                <div class="half_content half_left qt_border">
                    <div class="page_btn_area">
                        <div class="col-xs-2">
                            <span><spring:message code="고객정보" /></span>
                        </div>
                        <div class="col-xs-10 searchbtn_r"></div>
                    </div>
                    <div class="form-horizontal top_well underline" id="custDetailForm">
                        <div class="row">
                            <ifvm:inputNew type="text" id="cust_nm" dto="cust_nm" disabled="true" className="font-bold" label="고객명" title="고객명" labelClass="2" conClass="4" />
                            <ifvm:inputNew type="text" id="bizrNo" dto="bizrNo" disabled="true" label="사업자번호" title="사업자번호" labelClass="2" conClass="4" />
                        </div>
                        <div class="row">
                        
                            <ifvm:inputNew type="text" id="charger" dto="charger" label="담당자명" labelClass="2" conClass="4" title="담당자명" disabled="true" />
                            <ifvm:inputNew type="text" id="hhp" dto="hhp" label="휴대전화" labelClass="2" conClass="4" title= "휴대폰번호" disabled="true" />
                        </div>
                        <div class="row">
                           <ifvm:inputNew type="text" id="user_id" dto="user_id" label="웹아이디" title="웹아이디" className="font-bold" labelClass="2" conClass="4" disabled="true" />

                            <ifvm:inputNew type="text" id="email" dto="email" disabled="true" label="이메일" labelClass="2" title="이메일" conClass="4" />
<%--                             <ifvm:inputNew type="text" id="birthdt" names="birthdt" dto="birthdt" label="생년월일" labelClass="2" title="생년월일" conClass="2" disabled="true"/> --%>
<%--                             <ifvm:inputNew type="text" id="gen_cd" names="gen_cd" dto="gen_cd" conClass="2" title="양음력" disabled="true" /> --%>
                            
<%--                             <ifvm:inputNew type="text" id="user_id" dto="user_id" label="웹아이디" title="웹아이디" className="font-bold" labelClass="2" conClass="4" disabled="true" /> --%>
                        </div>
                        <div class="row">
                            <ifvm:inputNew type="text" id="zips" names="zip" dto="zip"  label="기본주소" labelClass="2" title="우편번호" conClass="2" disabled="true"/>
                            <ifvm:inputNew type="text" id="adress" dto="adres" disabled="true" title="기본주소" conClass="4"/>
                                
                            <ifvm:inputNew type="text" id="bunjis" dto="bunji" disabled="true" conClass="4" title="상세주소" className="blockTarget" />
                        </div>
                    </div>
                </div>
                <div class="half_content half_right">
                    <div class="page_btn_area">
                        <div class="col-xs-2">
                            <span><spring:message code="부가정보" /></span>
                        </div>
                        <div class="col-xs-10 searchbtn_r"></div>
                    </div>
                    <div class="form-horizontal top_well underline" id="custDetailAddForm">
                        <div class="row">
                             <ifvm:inputNew type="text" id="ceo" dto="ceo" disabled="true" label="대표자명" title="대표자명" labelClass="2" conClass="4" />
                        
<%--                              <ifvm:inputNew type="text" id="deptNm" names="deptNm" dto="deptNm" label="직장명" title="직장명" labelClass="2" conClass="2" disabled="true"/> --%>
<%--                             <ifvm:inputNew type="text" id="wrcNm" names="wrcNm" dto="wrcNm"  conClass="2" disabled="true"/> --%>
<%--                            <ifvm:inputNew type="text" id="pstn" names="pstn" dto="pstn" label="사번" title="사번" labelClass="2" conClass="2" disabled="true"/> --%>
<%--                             <ifvm:inputNew type="text" id="empNo" names="empNo" dto="empNo" label="사번" title="사번"  labelClass="2" conClass="4" disabled="true"/> --%>
<%--                            <ifvm:inputNew type="text" id="nlty" names="nlty" dto="nlty" label="국적" title="국적" className="text-center" labelClass="2" conClass="2" disabled="true"/> --%>
<%--                            <ifvm:inputNew type="text" id="native_yn" names="native_yn" dto="native_yn" title="내국인여부" className="text-center" conClass="2" disabled="true" /> --%>
                            
                            <ifvm:inputNew type="text" id="prStoreNm" names="prStoreNm" dto="prStoreNm" label="주거래매장" title="주거래매장" labelClass="2" conClass="4" disabled="true"/>
                        </div>
                        <div class="row">
                                 <ifvm:inputNew type="text" id="lccTelNo" dto="lccTelNo" label="담당자 유선전화" labelClass="2" conClass="4" title="담당자 유선전화" disabled="true" />
                                 <ifvm:inputNew type="text" id="induty" dto="induty" label="업종/업태" labelClass="2"  conClass="2" title="업종" disabled="true" />
                                 <ifvm:inputNew type="text" id="bizcnd" dto="bizcnd" disabled="true" title="업태" conClass="2"/>
                                 
<%--                             
<ifvm:inputNew type="text" id="annvrsry_type_cd" names="annvrsry_type_cd" dto="annvrsry_type_cd" className="text-center" label="기념일" title="기념일유형" labelClass="2" conClass="2" disabled="true"/> --%>
<%--                             <ifvm:inputNew type="text" id="annvrsry" names="annvrsry" dto="annvrsry" className="text-center" conClass="2"  maxLength="4" disabled="true" title="기념일"/> --%>
                            
<%--                             <ifvm:inputNew type="text" id="mrrg_yn" names="mrrg_yn" dto="mrrg_yn" label="결혼유무" title="결혼유무" labelClass="2" conClass="4" disabled="true"/> --%>
                        </div>
                        <div class="row">
                            <ifvm:inputNew type="text" id="zip_adds"  dto="lccZipAdd"  label="부가주소" title="우편번호" labelClass="2" conClass="2" disabled="true"/>
                            <ifvm:inputNew type="text" id="adres_adds" dto="lccAdresAdd" title="기본주소" disabled="true" conClass="4"/>
                            <ifvm:inputNew type="text" id="bunji_adds" dto="lccBunjiAdd" title="상세주소" disabled="true" conClass="4"    />
<%--                                                   <ifvm:inputNew type="text" id="prStoreNm" names="prStoreNm" dto="prStoreNm" label="주거래매장" title="주거래매장" labelClass="2" conClass="4" disabled="true"/> --%>
<%--                            <ifvm:inputNew type="text" id="deptNm" names="deptNm" dto="deptNm" label="직장명" title="직장명" labelClass="2" conClass="2" disabled="true"/> --%>
<%--                            <ifvm:inputNew type="text" id="wrcNm" names="wrcNm" dto="wrcNm"  conClass="2" disabled="true"/> --%>
<%--                            <ifvm:inputNew type="text" id="pstn" names="pstn" dto="pstn" label="사번" title="사번" labelClass="2" conClass="2" disabled="true"/> --%>
<%--                            <ifvm:inputNew type="text" id="empNo" names="empNo" dto="empNo" label="사번" title="사번"  labelClass="2" conClass="4" disabled="true"/> --%>
                        </div>
<!--                         <div class="row"> -->
<%--                             <ifvm:inputNew type="text" id="zip_add" names="zip_add" dto="zip_add"  label="직장주소" title="우편번호(추가)" labelClass="2" conClass="2" disabled="true"/> --%>
<%--                             <ifvm:inputNew type="text" id="adres_add" dto="adres_add" title="주소(추가)" disabled="true" conClass="4"/> --%>
                                
<%--                             <ifvm:inputNew type="text" id="bunji_add" dto="bunji_add" title="번지(추가)" disabled="true" conClass="4"    /> --%>
<!--                         </div> -->
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="half_wrap top_well">
                <div class="half_content half_left qt_border">
                    <div class="page_btn_area">
                        <div class="col-xs-2">
                            <span><spring:message code="혜택정보" /></span>
                        </div>
                        <div class="col-xs-10 searchbtn_r"></div>
                    </div>
            <div class="form-horizontal top_well underline" id="mktAgree">
						<div class="row">
						<label class="control-label col-xs-2">가용포인트</label> 						
  							<ifvm:inputNew type="text" id="avlPoint" dto="avlPoint" conClass="2"  className="text-right font-bold" disabled="true" />
 							<div class="control_content col-xs-2">
					     		<button class="btn btn-sm btn_gray" id="ofrPntSearch"  onclick="ofrPntListPop();" objcode="ofrPntSearch_OBJ" >상세</button>
							</div>					
						    <ifvm:inputNew type="text" id="extncPamPoint" dto="extncPamPoint" className="text-right font-bold" label="익월소멸예정" title="익월소멸예정" labelClass="2" conClass="2" disabled="true" />
							<div class="control_content col-xs-2">
					     		<button class="btn btn-sm btn_gray" id="extncPamSearch"  onclick="extncPamListPop();" objcode="extncPamSearch_OBJ" >상세</button>
							</div>	
						</div>
<!-- 						<div class="row">
 --><%-- 							<ifvm:inputNew type="text" id="preAcrlPoint" dto="preAcrlPoint" className="text-right font-bold" disabled="true" label="적립예정" title="적립예정" labelClass="2" conClass="4" />
 --%>						
<!-- 						</div>

 -->		<div class="row">
						      <div class="col-xs-12">
    						      <div class="col-xs-6">
	       						      <ifvm:inputNew type="text" id="coupon" dto="coupon"  values="0" className="text-right font-bold" label="보유쿠폰" title="보유쿠폰" labelClass="4" conClass="8" disabled="true" />
		      			          </div>
		      			          
		      			          <div class="col-xs-6">
	       						      <ifvm:inputNew type="text" id="accRate" dto="accRate"  values="0" className="text-right font-bold" label="구매할인" title="구매할인" labelClass="4" conClass="8" disabled="true" />
		      			          </div>
<!-- 				    	          <div class="col-xs-6"> -->
<%-- 					                   <ifvm:inputNew type="text" id="ticket" dto="ticket" values="0" className="text-right font-bold" disabled="true" label="보유티켓" title="보유티켓" labelClass="2" conClass="4"/> --%>
<!-- 					       	      </div> -->
					       	   </div>
						</div>			
 				<div class="row">
					     	<div class="col-xs-12">
					     	  	<label class="control-label col-xs-2">포인트 사용적립여부</label>	
					     	  		<button class="btn btn-sm btn_gray" id="chngPntRdmYn"  onclick="chngPntRdmYnFn();" objcode="chngPntRdmYn_OBJ" >사용</button>
					     		    <button class="btn btn-sm btn_gray" id="chngAcrlYn" onclick="chngAcrlYnFn();" objcode="chngAcrlYn_OBJ" >적립</button>
					     			
					     		<%-- <div class="col-xs-6">
	       			      		<ifvm:inputNew type="text" id="pntRdmYn" values="0" className="text-right font-bold" label="포인트 사용" title="포인트 사용" labelClass="4" conClass="3" disabled="true" />
		      		       		<button class="btn btn-sm btn_gray" id="chngPntRdmYn"  onclick="chngPntRdmYnFn();" objcode="" >변경</button>
		      		       		<button class="btn btn-sm btn_gray" id="chngPntPwdYn"  onclick="chngPntPwdYnFn();" objcode="" >비밀번호</button>
		      		       	
		      		       	</div>
    				            <div class="col-xs-6">
	       			      		<ifvm:inputNew type="text" id="pntAcrlYn"  values="0" className="text-right font-bold" label="포인트 적립" title="포인트 적립" labelClass="4" conClass="5" disabled="true" />
		      		        	<button class="btn btn-sm btn_gray" id="chngAcrlYn" onclick="chngAcrlYnFn();" objcode="" >변경</button>
		      		        	</div> --%>
		      		     
<!-- 				    	          <div class="col-xs-6"> -->
<%-- 					                   <ifvm:inputNew type="text" id="ticket" dto="ticket" values="0" className="text-right font-bold" disabled="true" label="보유티켓" title="보유티켓" labelClass="2" conClass="4"/> --%>
<!-- 					       	      </div> -->
					       	   </div>
						</div>				
 		

					</div>
            </div>
            <div class="half_content half_right">
                <div class="page_btn_area">
                        <div class="col-xs-2">
                            <span><spring:message code="활동정보" /></span>
                        </div>
                        <div class="col-xs-10 searchbtn_r"></div>
                    </div>
                    <div class="form-horizontal top_well underline" id="reachInfo">
                        <div class="row">
                            <ifvm:inputNew type="text" id="tierNm" dto="tierNm" disabled="true" label="등급" title="등급" labelClass="2" conClass="2" />
                            <ifvm:inputNew type="text" id="validTierStartDt" dto="validTierStartDt" disabled="true" title="등급적용일" conClass="2" />
                            
<%--                            <ifvm:inputNew type="text" id="liftTierNm" dto="liftTierNm" disabled="true" label="평생등급" title="평생등급" labelClass="2" conClass="2" /> --%>
<%--                            <ifvm:inputNew type="text" id="validTierLiftTimeStartDt" dto="validTierLiftTimeStartDt" disabled="true" title="등급적용일" conClass="2" /> --%>
                            <ifvm:inputNew type="text" id="lastChnlNm" dto="lastPurChnlNm" label="최근구매" title="최근구매채널" labelClass="2" conClass="2" disabled="true" />
                            <ifvm:inputNew type="text" id="purSvrDt" dto="purSvrDt" disabled="true" title="최근구매일" conClass="2"/>
                        </div>
                        <div class="row">
                            <ifvm:inputNew type="text" id="lastChnlNm" dto="lastConChnlNm" label="최근접속" title="최근접속채널" labelClass="2" conClass="2" disabled="true" />
                            <ifvm:inputNew type="text" id="conSvrDt" dto="conSvrDt" disabled="true" title="최근접속일" conClass="2"/>
                            
                            <ifvm:inputNew type="text" id="drmncy_chng_unit" names="drmncy_chng_unit" dto="drmncy_chng_unit"  label="휴면전환" title="휴면전환단위" labelClass="2" conClass="2" disabled="true"/>
                            <ifvm:inputNew type="text" id="drmncy_chng_unitDt" names="drmncy_chng_unitDt" conClass="2" disabled="true" title="휴면전환예정일" />
                            
                        </div>
<!--                         <div class="row"> -->
<!--                                   <div class="col-xs-12"> -->
<%--                                                     <ifvm:inputNew type="text" id="snsTypeCdNm" dto="snsTypeCdNm"  disabled="true" label="대표 SNS" title="대표SNSHEADER" labelClass="2" conClass="4"/> --%>
<%--                                                     <ifvm:inputNew type="text" id="snsAddr" dto="snsAddr" disabled="true" title="대표SNSLINK" conClass="6"/> --%>
<!--                                   </div> -->
                        
<%--                            <ifvm:inputNew type="text" id="evtNm" dto="evtNm" label="이벤트참여" labelClass="2" title="이벤트명" conClass="2" disabled="true" /> --%>
<%--                            <ifvm:inputNew type="text" id="evtDt" dto="evtDt" conClass="2" disabled="true" title="참여일" /> --%>
                        
<%--                            <ifvm:inputNew type="text" id="drmncy_chng_unit" names="drmncy_chng_unit" dto="drmncy_chng_unit"  label="휴면전환" title="휴면전환단위" labelClass="2" conClass="2" disabled="true"/> --%>
<%--                            <ifvm:inputNew type="text" id="drmncy_chng_unitDt" names="drmncy_chng_unitDt" conClass="2" disabled="true" title="휴면전환일" /> --%>
<!--                         </div> -->
                    </div>
                </div>
            </div>
        </div>
        
    </div>
</div>

<!-- [주석제거예정] 탭 목록 영역부터 그 이후 영역 -->
<div id="mbrDetailNewTabArea"></div>
<!-- [주석제거예정] 회원 리스트 팝업 컨테이너 -->
<div id="mbrListPop" class="popup_container"></div>
<!-- [주석제거예정] 고객 뷰 팝업 컨테이너 -->
<div id="custViewPop" class="popup_container"></div>
<!-- [주석제거예정] 회원 상세 팝업 컨테이너 -->
<div id="corpMbrDetailPopup" class="popup_container"></div>
<!-- [주석제거예정] 회원탈퇴? 팝업 컨테이너 -->
<div id="dropMbrPopup" class="popup_container"></div>
<div id="pntArclYnPop"></div>
<div id="pntRdmYnPop"></div>
<div id="ofrPntListPopup"></div>
<div id="extncPamPopup"></div>


<style type="text/css">
#sbscDate, #certDate, #validTierStartDt, #conSvrDt, #purSvrDt, #drmncy_chng_unitDt, #pntRdmYn ,#pntAcrlYn {
  text-align : center !important;
}

#avlPoint{
	width :145%;
}

#extncPamPoint{
	width :145%;
}

#ofrPntSearch{
	margin-left : 40%;
	width :60%;
}

#extncPamSearch{
	margin-left : 40%;
	width :60%;
}

#chngPntRdmYn{
	min-width : 10%;
	margin-left : 0.5%;
}

#chngAcrlYn{
	min-width : 10%
}

#chngPntPwdYn{
	min-width : 10%;
}
</style>
<script type="text/javascript">

var mbr_rid = '<%=cleanXss(request.getParameter("rid"))%>';
var mbr_no = '<%=cleanXss(request.getParameter("mbr_no"))%>';
var mbr_no_cam;
var tabId =  '<%=cleanXss(request.getParameter("tabid"))%>';
tabId = tabId === 'null' ? null : tabId;
var tabIndex  = '<%=cleanXss(request.getParameter("tabIndex"))%>';
tabIndex = tabIndex === 'null' ? null : tabIndex;
mbr_no = mbr_no === 'null' ? null : mbr_no;
mbr_rid = mbr_rid === 'null' ? null : mbr_rid;
<%-- var mbr_no = '<%=request.getParameter("mbrNo")%>'; --%>
var isNew = true;  //신규 여부. 신규: true, 수정 : false
var pointFieldId = new Array(); //배열선언
pointFieldId = [ 'totalPoint','avlPoint', 'preAcrlPoint', 'extncPamPoint' ];
var pgmRid=null;
var pgmNo=null;
var mbrNo=null;
var custRid=null;
var custItemValCheck;
var inputeRowField = [];
var chnlNo = null;
var pntPwd = null;
var pntRdmYn = null;
var pntAcrlYn = null;
var mbrTypeCd = null; // 회원유형 mbrTypeCd 

var mbrDetailNewTabArea = $("#mbrDetailNewTabArea").DrawTab({
	item : items
        /*[
		{   label : '로그인정보', href : '<ifvm:url name="mbrWebLoginInf"/>'},
		{   label : '채널이용내역', href : '<ifvm:url name="custUseHistListNew"/>'},
		{	label : '동의', href : '<ifvm:url name="mbrAgreList"/>'},
		{   label : '특별회원', href : '<ifvm:url name="mbrMgtInfoList"/>'},
		{	label : '등급', href : '<ifvm:url name="mbrTierListNew"/>'},
		{   label : '모바일', href : '<ifvm:url name="mbrMobileLoginInf"/>'},
		{	label : '변경이력', href : '<ifvm:url name="mbrChangeHistListNewPage"/>'},
		{	label : '구매', href : '<ifvm:url name="mbrTxnHistListNew"/>'},
		{	label : '포인트', href : '<ifvm:url name="mbrPointListNew"/>'},
		{	label : '쿠폰', href : '<ifvm:url name="mbrCouponListNew"/>'},
	 	{   label : '캠페인', href : '<ifvm:url name="campaignExecList"/>'},
		{	label : '이벤트', href : '<ifvm:url name="mbrEventHistListNew"/>'},
		{   label : '상품평', href : '<ifvm:url name="prodCustList"/>' },
		{ 	label : '상담', href : '<ifvm:url name="mbrVocListNew"/>' },
		{	label : '알림이력', href : '<ifvm:url name="mbrAlterHistListNew"/>'},
	]*/
                }
            );
function mbrDetail(){
        $.ifvSyncPostJSON('<ifvm:action name="getMmbrDetailNewPage"/>',{
            rid : mbr_rid,
            intRidMbr : mbr_rid,
            mbrNo : mbr_no
        },
        function(result) {
        	
    		
			if(result.pntRdmYn=='Y'){
				pntRdmYn="가능";
				$("#chngPntRdmYn")[0].innerHTML="사용 가능";

			}else if(result.pntRdmYn=='N'){
				pntRdmYn="불가능";
				$("#chngPntRdmYn")[0].innerHTML="사용 불가";
			}

			if(result.pntAcrlYn=='Y'){
				pntAcrlYn="가능";
				$("#chngAcrlYn")[0].innerHTML="적립 가능";

			}else if(result.pntAcrlYn=='N'){
				pntAcrlYn="불가능"
				$("#chngAcrlYn")[0].innerHTML="적립 불가";
			}
			$("#custTypeCd").val(result.custTypeCd);
            //개인정보 조회 이력 남기기
            var backPage = backPage === 'null' ? null : $.fn.ifvmPersonalCondLogPageId("", false);
            if(backPage != null) $.fn.ifvmComCondLogging( backPage , result.custRid);
            $("#mbrForm").dataSetting(result);
            if(result.hhp != null && result.hhp != ''){
            	var hhp = result.hhp.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
            	$("#hhp").val(hhp);
            }
            if(result.telNo != null && result.telNo != ''){
            	var telNo = result.telNo.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
            	$("#telNo").val(telNo);
            }
            if(result.lccTelNo != null && result.lccTelNo != ''){
            	var lccTelNo = result.lccTelNo.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
            	$("#lccTelNo").val(lccTelNo);
            }
            //우편번호
            if(result.zip != null) $("#zip").val(result.zip);
            //우편번호(추가)
            if(result.zip_add != null) $("#zip_add").val(result.zip_add);
            //휴면전환단위
            if(result.drmncy_chng_unit != null && result.drmncy_chng_unit != "") {
                if(result.drmmcyChngUnitCd == '99'){
                    $("#drmncy_chng_unit").val(result.drmncy_chng_unit);
                }else{
                    $("#drmncy_chng_unit").val(result.drmncy_chng_unit);
                   // if(result.conSvrDt != null || result.conSvrDt != undefined) {
                	   if(result.drmmcyExpDate != null && result.drmmcyExpDate != "") {
						 $("#drmncy_chng_unitDt").val(result.drmmcyExpDate.substr(0,4)+'-'+result.drmmcyExpDate.substr(4,2)+'-'+result.drmmcyExpDate.substr(6,2)); //가입일
                	   }
   //             	   $("#drmncy_chng_unitDt").val(getDrmncyDate(result.conSvrDt, result.drmncy_chng_unit)); //접속일
      //              }else{
         //               $("#drmncy_chng_unitDt").val(getDrmncyDate(result.sbscDate, result.drmncy_chng_unit)); //가입일
            //        }
                }
            }
            //기념일
            if(result.annvrsry != null) $("#annvrsry").val(result.annvrsry.substr(0,2)+"월"+result.annvrsry.substr(2,2)+"일");
            //생일
            if(result.birthdt != null){
                var birthday = result.birthdt;
                if(result.lunar_cdNm != null && result.lunar_cdNm != "" ){
                    $("#birthdt").val(birthday.substr(0,4)+"-"+birthday.substr(4,2)+"-"+birthday.substr(6)+"  ("+result.lunar_cdNm+")");
                }
                else $("#birthdt").val(birthday.substr(0,4)+"-"+birthday.substr(4,2)+"-"+birthday.substr(6));
            }
            //대표등급
            if(result.validTierStartDt != null) $("#validTierStartDt").val(result.validTierStartDt.substr(0,4)+"-"+result.validTierStartDt.substr(4,2)+"-"+result.validTierStartDt.substr(6));
            //등급이 없을때 부여일자도 나오지 않게 한다.
            if(result.tierNm == null) $("#validTierStartDt").val("");
            
            //평생등급
//          if(result.validTierLiftTimeStartDt != null) $("#validTierLiftTimeStartDt").val(result.validTierLiftTimeStartDt.substr(0,4)+"-"+result.validTierLiftTimeStartDt.substr(4,2)+"-"+result.validTierLiftTimeStartDt.substr(6));
            //내국인여부
            if(result.native_yn != null){
                if(result.native_yn == 'Y') $("#native_yn").val("내국인");
                else $("#native_yn").val("외국인");
            }
            //결혼여부
            if(result.mrrg_yn != null){
                if(result.mrrg_yn == 'Y') $("#mrrg_yn").val("기혼");
                else $("#mrrg_yn").val("미혼");
            }
            
            pgmRid = result.pgmRid;
            pgmNo = result.pgmNo;
            custRid = result.custRid;
            mbr_rid = result.rid;
            mbr_no_cam = result.mbrNo;
            mbrNo = result.mbrNo;
            custNm = result.cust_nm;
            chnlNo = result.chnlNo;
            pntPwd = result.pntPwd;
            pointComma();
         	// 현재 회원의 유형에 대한 데이터 mbrTypeCd를 가져온 것을 전역변수 mbrTypeCd에 초기화
			mbrTypeCd = result.mbrTypeCd;
            //보유쿠폰
            $("#coupon").val($("#coupon").val()+"장");
			$("#accRate").val($("#accRate").val()+"%");

            //보유티켓
//          $("#ticket").val($("#ticket").val()+"장");
            //글자스타일 굵게
            $(".font-bold").attr('style', 'font-weight: bold;');
            //고객수집항목에대한 이름설정
            labelCheck();
            
			if($('#mbrStatCd').val() == "탈퇴" ){
				$('#mbrStatCd').val("탈퇴("+result.reSbscResn+")")
			}
			
        });
};

function pointComma() {

    for (var pi = 0; pi < pointFieldId.length; pi++) {
        var _pval = $("#" + pointFieldId[pi]).val();
        var _aval = "";
        if (_pval) {
            _aval = (_pval.split(".")[0]).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
        $("#" + pointFieldId[pi]).val(_aval+"P");
    }
}
//오늘날짜 계산
function getTodayDate(dt){ 
    if(dt == null || dt == undefined) dt = 0;
    var date = new Date();
    
    var year = date.getFullYear();
    year = parseInt (year) + parseInt (dt);
    var month = date.getMonth()+1;
    if(month<10) month = "0"+month;
    var day = date.getDate();
    if(day < 10) day = "0"+day;
    return year +"-"+month+"-"+day;
}

//휴먼예정일 계산
function getDrmncyDate(startDt, dt){ 
    if(dt == null || dt == undefined) dt = 0;
    var date = new Date(startDt);
    
    var year = date.getFullYear();
    year = parseInt (year) + parseInt (dt);
    var month = date.getMonth()+1;
    if(month<10) month = "0"+month;
    var day = date.getDate();
    if(day < 10) day = "0"+day;
    
    return year +"-"+month+"-"+day;
}


function btnList() {
 
    checkBackPage = '<%=cleanXss(request.getParameter("checkBackPage"))%>';	
	//공통으로 수정하기...

	if(checkBackPage=='custDormantList'){
		//휴면회원일 경우 목록 클릭시 휴면회원페이지로 조회되도록 추가
		qtjs.href('<ifvm:url name="custDormantList"/>');
		checkBackPage=null;
	}else if(checkBackPage=='dropMbrListNew'){
		//탈회회원일 경우 목록 클릭시 탈회회원페이지로 조회되도록 추가
		qtjs.href('<ifvm:url name="dropMbrListNew"/>');		
		checkBackPage=null;
	}else if(checkBackPage=='negativeAcc'){
		//부정적립 회원일 경우 목록 클릭시 부정적립페이지로 조회되도록 추가
		qtjs.href('<ifvm:url name="negativeAcc"/>');	
		checkBackPage=null;
	}else if(checkBackPage=='custBeforeDormantList'){
		qtjs.href('<ifvm:url name="custBeforeDormantList"/>');	
		checkBackPage=null;
	}else if(checkBackPage=='transactionList'){
		qtjs.href('<ifvm:url name="transactionList"/>');	
		checkBackPage=null;
	}else if(checkBackPage=='loyCouponList'){
		qtjs.href('<ifvm:url name="loyCouponList"/>');	
		checkBackPage=null;
	}else if(checkBackPage=='consultListNew'){
		qtjs.href('<ifvm:url name="consultListNew"/>');	
		checkBackPage=null;
	}else{
		qtjs.href('<ifvm:url name="mbrListNewPage"/>');
		checkBackPage=null;
	}
    
    
}

function mbrListPopup() {
    $("#mbrListPop").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="mbrListPopNew"/>',
        contentType: "ajax",
        title: '타회원조회',
        width: 1200,
        close : 'mbrClosePop'
    });
};

function mbrClosePop() {
    mbrListPop._destroy();
}

//회원정보수정
function editMbrDetailBtn() {
    $("#corpMbrDetailPopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="corpMbrDetailPop"/>'+'?mbr_rid='+mbr_rid,
        contentType: "ajax",
        title: '회원정보 수정',
        width: 1000,
        close : 'corpMbrDetailClosePop'
    });
};
function corpMbrDetailClosePop() {
    corpMbrDetailPopup._destroy();
}

//회원탈퇴
function getDropMbrPop() {
    if($.fn.ifvmIsNotEmpty(mbrNo) && $.fn.ifvmIsNotEmpty(pgmNo)){
        /* if(confirm('<spring:message code="탈퇴하시겠습니까?"/>')){ */
            $("#dropMbrPopup").ifvsfPopup({
                enableModal : true,
                enableResize: false,
                contentUrl: '<ifvm:url name="dropMbrPop"/>',
                contentType: "ajax",
                title: '회원 탈회',
                width: 800,
                close : 'dropMbrPoplClose'
            });
        /* } */
    }else{
        if(!$.fn.ifvmIsNotEmpty(mbr_rid)) alert("회원이 아닙니다");
        else alert("프로그램이 존재하지 않습니다.")
    }
}
function dropMbrPoplClose() {
    dropMbrPopup._destroy();
}

//고객정보, 부가정보 id 체크
function getFieldId(){
    var inputSize = 0;
    for(var i=0;i < $("#custDetailForm input").length; i++){inputeRowField[i] = $("#custDetailForm input")[i].id;}
    inputSize = inputeRowField.length;
    for(var j=0; j < $("#custDetailAddForm input").length; j++){inputeRowField[ j+inputSize] = $("#custDetailAddForm input")[j].id;}
}

//custDetailForm  custDetailAddForm 고객수집정보에 저장이 되있는 항목은 그항목 이름에 맞게 바꾸어준다.
function labelCheck(){
    getFieldId();
    
    $.ifvSyncPostJSON('<ifvm:action name="custItemConfVal"/>',{pgmNo : pgmNo }, function(result){
        custItemValCheck = result.rows;
        
        var newList = custItemValCheck.filter(function(item){
              return inputeRowField.includes(item.fieldNm.toLowerCase());
        })
        
        for(var i=0;i <newList.length; i++) {
            var fieldId = newList[i].fieldNm.toLowerCase();
            var fieldNm = newList[i].fieldDesc
            $("#"+fieldId).attr("title", fieldNm);
            if( fieldId != "bunji" && fieldId != "bunji_add" && fieldId != "lunar_cd" && fieldId != "native_yn" && fieldId != "annvrsry" && fieldId != "zip" && fieldId != "zip_add" && fieldId != "gen_cd"){ 
                if(fieldId != "adres" && fieldId != "adres_add" ){
                    $("#"+fieldId).closest("div").prev()[0].innerHTML = fieldNm;
                }else{
                    $("#"+fieldId).closest("div").prev().prev()[0].innerHTML = fieldNm;
                }
            } 
        }
    });
}


// function custViewPopup() {
//  $("#custViewPop").ifvsfPopup({
//      enableModal : true,
//         enableResize: false,
//         contentUrl: '<ifvm:url name="custViewPop"/>',
//         contentType: "ajax",
//         title: '고객 360° VIEW',
//         width: 1000,
//         close : 'custViewClosePop'
//     });
// };

function executivesViewPopup() {
 $("#custViewPop").ifvsfPopup({
     enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="executivesViewPop"/>',
        contentType: "ajax",
        title: '임직원 변경',
        width: 450,
        close : 'executivesViewClosePop'
    });
};

function executivesViewClosePop() {
    custViewPop._destroy();
}

function custViewClosePop() {
    custViewPop._destroy();
}

function chngAcrlYnFn(){
	
	$("#pntArclYnPop").ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : '<ifvm:url name="pntArclYnPop"/>',
        contentType : "ajax",
        title : "<spring:message code="포인트 적립 변경"/>",
        width : '800px',
        close : 'chngAcrlYnFnClose',
     });
} 

function chngPntRdmYnFn(){
	$("#pntRdmYnPop").ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : '<ifvm:url name="pntRdmYnPop"/>',
        contentType : "ajax",
        title : "<spring:message code="포인트 사용 변경"/>",
        width : '800px',
        close : 'chngPntRdmYnFnClose',
     });
}

function ofrPntListPop(){
	$("#ofrPntListPopup").ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : '<ifvm:url name="ofrPntPop"/>',
        contentType : "ajax",
        title : "<spring:message code="가용포인트 상세"/>",
        width : '1000px',
        close : 'ofrPntPopFnClose',
     });
}

function ofrPntPopFnClose(){
	ofrPntListPopup._destroy();
}

function extncPamListPop(){
	$("#extncPamPopup").ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : '<ifvm:url name="extncPamPop"/>',
        contentType : "ajax",
        title : "<spring:message code="익월소멸예정포인트 상세"/>",
        width : '1000px',
        close : 'extncPamListPopClose',
     });
}

function extncPamListPopClose(){
	extncPamPopup._destroy();
}

function chngPntRdmYnFnClose(){
	pntRdmYnPop._destroy();
}
function chngAcrlYnFnClose(){
	pntArclYnPop._destroy();
}

function aToDorBtn(){
	if (confirm('<spring:message code="L02924" />')) {
		$.ifvSyncPostJSON('<ifvm:action name="setCustDorChange"/>', {
			mbrRid : mbr_rid
		}, function(result) {
				alert('<spring:message code="L02925"/>');
		}, function(result) {
				alert('<spring:message code="L02926"/>');
		});
		location.reload();
	}
}

$(document).ready(function() {
    
    mbrDetail();
    
    if($.fn.ifvmIsNotEmpty(tabIndex)) {
        mbrDetailNewTabArea.moveTabIndex(tabIndex);
        tabIndex = null;
    }
    if($.fn.ifvmIsNotEmpty(tabId)) {
        mbrDetailNewTabArea.moveTabByTabId(tabId)
        tabId = null;
    }
	if($('#custTypeCdNm').val() == '임직원'){
	    $('#executivesViewPopup').attr("disabled", false);
	} else {
	    $('#executivesViewPopup').attr("disabled", true);
	}
    
	if($("#custTypeCd").val()=="C" || $("#custTypeCd").val()=="E"){
		// C 법인 , E 임직원  
		$("#chngPntRdmYn").prop('disabled', false); //사용 수정 가능
		$("#chngAcrlYn").prop('disabled', false); 		//적립 수정 가능
		
	}else if($("#custTypeCd").val()=="D" || $("#custTypeCd").val()=="O"||$("#custTypeCd").val()=="X"){
		//D 백화점 , O 회사(오피스), (구)임직원
		$("#chngPntRdmYn").prop('disabled', true); 	//사용 수정 불가
		$("#chngAcrlYn").prop('disabled', true);	 	//적립 수정 불가
	}
	
});
</script>