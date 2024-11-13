<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style type="text/css">

    #sbscDate, #certDate, #validTierStartDt, #conSvrDt, #purSvrDt, #drmncy_chng_unitDt, #pntRdmYn, #pntAcrlYn {
        text-align: center !important;
    }

    /*#avlPoint {
        width: 145%;
    }*/

    #extncPamPoint {
        width: 145%;
    }

    #ofrPntSearch {
        margin-left: 40%;
        width: 60%;
    }

    #extncPamSearch {
        margin-left: 40%;
        width: 60%;
    }

    #chngPntRdmYn {
        min-width: 10%;
        margin-left: 0.5%;
    }

    #chngAcrlYn {
        min-width: 10%
    }

    #chngPntPwdYn {
        min-width: 10%;
    }

    .mouse-curser {
        cursor:pointer;
    }

</style>
<div class="page-title">
    <h1>
        <spring:message code="회원"/>
        &gt; <spring:message code="조회"/>
    </h1>
</div>
<div>
    <div class="page_btn_area" id="headForm">
        <div class="col-xs-2">
            <span><spring:message code="회원 상세"/></span>
        </div>

        <div class="col-xs-10 searchbtn_r">
            <%-- <ifvm:inputNew type="button" btnFunc="custViewPopup" text="회원 360° 뷰" /> --%>
            <%-- <ifvm:inputNew type="button" btnFunc="aToDorBtn" text="휴면회원 전환" objCode="aToDorBtn_OBJ"/> --%>

            <%-- <ifvm:inputNew type="button" id='executivesViewPopup' btnFunc="executivesViewPopup" text="임직원 변경" objCode="executivesViewPopup_OBJ" />--%>
            <ifvm:inputNew type="button" btnFunc="editMbrDetailBtn" text="회원정보 수정"  /><%--objCode="mbrDetailEditMbrDetailBtn_OBJ"--%>
            <ifvm:inputNew type="button" btnFunc="mbrListPopup" text="타회원 조회" objCode="mbrDetailMbrListPopup_OBJ"/>
            <ifvm:inputNew type="button" btnFunc="getDropMbrPop" text="탈회"  /><%-- objCode="mbrDetailGetDropMbrPop_OBJ" --%>
            <ifvm:inputNew type="button" btnFunc="btnList" text="목록" objCode="btnList_OBJ"/>
        </div>
    </div>

    <div class="form-horizontal underline top_well" id="mbrForm">
        <div class="row">
            <div class="half_wrap top_well">
                <div class="half_content half_left qt_border">
                    <div class="page_btn_area">
                        <div class="col-xs-2">
                            <span><spring:message code="기본정보"/></span>
                        </div>
                    </div>
                    <div class="form-horizontal top_well underline" id="reachInfo">
                        <div class="row">
                            <ifvm:inputNew type="text" id="pgmNo" dto="pgmNo" disabled="true" label="로열티프로그램" title="로열티프로그램 번호" labelClass="2" conClass="2"/>
                            <ifvm:inputNew type="text" id="pgmNm" dto="pgmNm" disabled="true" conClass="2" title="로열티프로그램 이름"/>

                            <ifvm:inputNew type="text" id="mbrNo" dto="mbrNo" label="회원번호" labelClass="2" title="회원번호" conClass="4" disabled="true"/>
                        </div>
                        <div class="row">
                            <ifvm:inputNew type="text" id="custTypeCdNm" dto="custTypeCdNm" label="회원유형" labelClass="2" title="회원유형" conClass="2" disabled="true"/>
                            <ifvm:inputNew type="hidden" id="custTypeCd" dto="custTypeCd" label="회원유형" conClass="2"/>
                            <ifvm:inputNew type="text" id="mbrTypeCdNm" names="mbrTypeCdNm" dto="mbrTypeCdNm" title="회원상세유형" conClass="2" disabled="true"/>
                            <ifvm:inputNew type="hidden" id="mbrTypeCd" dto="mbrTypeCd" label="회원유형" conClass="2"/>

                            <ifvm:inputNew type="text" id="sbscTypeCdNm" dto="sbscTypeCdNm" label="회원상태" labelClass="2" title="회원상태" conClass="2" disabled="true"/>
                            <ifvm:inputNew type="text" id="mbrStatCd" dto="mbrStatCd" title="상태" conClass="2" disabled="true"/>
                            <%--<ifvm:inputNew type="text" id="mcardNo" dto="mcardNo" label="카드번호" labelClass="2" title="회원상태" conClass="4" disabled="true"/>--%>
                        </div>
                    </div>
                </div>
                <div class="half_content half_right">
                    <div class="page_btn_area">
                        <div class="col-xs-2">
                            <span><spring:message code="가입정보"/></span>
                        </div>
                        <div class="col-xs-10 searchbtn_r"></div>
                    </div>
                    <div class="form-horizontal top_well underline" id="joinInfo">
                        <div class="row">
                            <ifvm:inputNew type="text" id="sbscDate" dto="sbscDates" label="가입일자" labelClass="2" title="가입일" conClass="4" disabled="true"/>

                            <ifvm:inputNew type="text" id="sbscPathCdNm" dto="sbscPathCdNm" label="가입경로" title="가입경로" labelClass="2" conClass="2" disabled="true"/>
                            <ifvm:inputNew type="text" id="sbscDeviceCdNm" dto="sbscDeviceCdNm" conClass="2" title="가입디바이스" disabled="true"/>
                        </div>
                        <div class="row">
                            <ifvm:inputNew type="text" id="certTypeCd" names="certTypeCd" dto="certTypeCd" label="인증유형" title="인증유형" labelClass="2" conClass="2" disabled="true"/>
                            <ifvm:inputNew type="text" id="certDate" names="certDate" dto="certDate" conClass="2" title="인증일" disabled="true"/>

                            <ifvm:inputNew type="text" id="chnlNo" dto="chnlNo" label="가입매장" labelClass="2" disabled="true" title="가입채널코드" conClass="2"/>
                            <ifvm:inputNew type="text" id="sbscChnlNm" dto="sbscChnlNm"  disabled="true" title="가입채널" conClass="2"/>
                            <%--<ifvm:inputNew type="text" id="sbscStoreNm" dto="sbscStoreNm" disabled="true" title="가입매장" conClass="2"/>--%>
                            <%--<ifvm:inputNew type="text" id="sbscTypeCdNm" names="sbscTypeCdNm" dto="sbscTypeCdNm" label="회원가입유형" title="회원가입유형" labelClass="2" conClass="4" disabled="true"/>--%>
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
                            <span><spring:message code="고객정보"/></span>
                        </div>
                        <div class="col-xs-10 searchbtn_r"></div>
                    </div>
                    <div class="form-horizontal top_well underline" id="custDetailForm">
                        <div class="row">
                            <ifvm:inputNew type="text" id="cust_nm" dto="cust_nm" label="고객명" title="고객명" className="font-bold" labelClass="2" conClass="4" disabled="true"/>
                            <ifvm:inputNew type="checkBox" id="native_yn" label="L02928" title="L02928" labelClass="2" conClass="4" disabled="true"/>
                            <%--<ifvm:inputNew type="text" id="cust_nm_add" dto="cust_nm_add" disabled="true" label="고객명(별칭)" title="고객명(별칭)" labelClass="2" conClass="4" />--%>
                        </div>
                        <div class="row">
                            <ifvm:inputNew type="text" id="hhp" dto="hhp" label="휴대전화번호" labelClass="2" className="font-bold" conClass="4" title="휴대폰번호" disabled="true"/>
                            <%--<ifvm:inputNew type="text" id="telNo" dto="telNo"  title="집전화번호" conClass="2"  disabled="true" />--%>
                            <ifvm:inputNew type="text" id="email" dto="email" disabled="true" label="이메일" labelClass="2" title="이메일" conClass="4"/>
                        </div>
                        <div class="row">
                            <ifvm:inputNew type="text" id="birthdt" names="birthdt" dto="birthdt" label="생년월일" labelClass="2" title="생년월일" conClass="2" disabled="true"/>
                            <ifvm:inputNew type="text" id="gen_cd" names="gen_cd" dto="gen_cd" conClass="2" title="성별" disabled="true"/>

                            <ifvm:inputNew type="text" id="user_id" dto="user_id" label="웹아이디" title="웹아이디" className="font-bold" labelClass="2" conClass="4" disabled="true"/>
                        </div>
                        <div class="row">
                            <ifvm:inputNew type="text" id="zip" names="zip" dto="zip" label="최근 배송지 주소" labelClass="2" title="우편번호" conClass="2" disabled="true"/>
                            <ifvm:inputNew type="text" id="adres" dto="adres" disabled="true" title="기본주소" conClass="4"/>

                            <ifvm:inputNew type="text" id="bunji" dto="bunji" disabled="true" conClass="4" title="상세주소" className="blockTarget"/>
                        </div>
                    </div>
                </div>
                <div class="half_content half_right">
                    <div class="page_btn_area">
                        <div class="col-xs-2">
                            <span><spring:message code="부가정보"/></span>
                        </div>
                        <div class="col-xs-10 searchbtn_r"></div>
                    </div>
                    <div class="form-horizontal top_well underline" id="custDetailAddForm">
                        <div class="row">
                            <%--<ifvm:inputNew type="text" id="wrcNm" names="wrcNm" dto="wrcNm" label="직장명" title="직장명" labelClass="2" conClass="2" disabled="true"/>--%>
                            <%--<ifvm:inputNew type="text" id="deptNm" names="deptNm" dto="deptNm"  title="부서명" conClass="2" disabled="true"/>--%>
                            <%--<ifvm:inputNew type="text" id="pstn" names="pstn" dto="pstn" label="사번" title="사번" labelClass="2" conClass="2" disabled="true"/> --%>
                            <%--<ifvm:inputNew type="text" id="empNo" names="empNo" dto="empNo" label="사번" title="사번"  labelClass="2" conClass="4" disabled="true"/>--%>
                            <%--<ifvm:inputNew type="text" id="nlty" names="nlty" dto="nlty" label="국적" title="국적" className="text-center" labelClass="2" conClass="2" disabled="true"/> --%>
                            <%--<ifvm:inputNew type="text" id="native_yn" names="native_yn" dto="native_yn" title="내국인여부" className="text-center" conClass="2" disabled="true" /> --%>
                            <ifvm:inputNew type="text" id="age" dto="age" label="나이/연령대" title="나이" className="text-center" labelClass="2" conClass="2" disabled="true"/>
                            <ifvm:inputNew type="text" id="ageGroup" dto="ageGroup" title="연령대" className="text-center" conClass="2" disabled="true"/>
                            <ifvm:inputNew type="text" id="prStoreNm" names="prStoreNm" dto="prStoreNm" label="주거래매장" title="주거래매장" labelClass="2" conClass="4" disabled="true"/>
                        </div>
                        <div class="row">
                            <ifvm:inputNew type="text" id="annvrsry_type_cd" names="annvrsry_type_cd"
                                           dto="annvrsry_type_cd" className="text-center" label="기념일" title="기념일유형"
                                           labelClass="2" conClass="2" disabled="true"/>
                            <ifvm:inputNew type="text" id="annvrsry" names="annvrsry" dto="annvrsry"
                                           className="text-center" conClass="2" maxLength="4" disabled="true"
                                           title="기념일"/>

                            <%--<ifvm:inputNew type="text" id="mrrgYn" names="mrrgYn" dto="mrrgYn" label="결혼여부" title="결혼여부" labelClass="2" conClass="4" disabled="true"/>--%>
                        </div>
                        <%--<div class="row">
                                        <ifvm:inputNew type="text" id="prStoreNm" names="prStoreNm" dto="prStoreNm" label="주거래매장" title="주거래매장" labelClass="2" conClass="4" disabled="true"/>
                                        <ifvm:inputNew type="checkBox" id="childYn" names="childYn" dto="childYn" label="자녀여부" title="자녀여부" labelClass="2" conClass="4" disabled="true"/>

                        &lt;%&ndash; 	<ifvm:inputNew type="text" id="deptNm" names="deptNm" dto="deptNm" label="직장명" title="직장명" labelClass="2" conClass="2" disabled="true"/> &ndash;%&gt;
                        &lt;%&ndash; 	<ifvm:inputNew type="text" id="wrcNm" names="wrcNm" dto="wrcNm"  conClass="2" disabled="true"/> &ndash;%&gt;
                        &lt;%&ndash; 	<ifvm:inputNew type="text" id="pstn" names="pstn" dto="pstn" label="사번" title="사번" labelClass="2" conClass="2" disabled="true"/> &ndash;%&gt;
                        &lt;%&ndash; 	<ifvm:inputNew type="text" id="empNo" names="empNo" dto="empNo" label="사번" title="사번"  labelClass="2" conClass="4" disabled="true"/> &ndash;%&gt;
                        </div>
                        <div class="row">
                            <ifvm:inputNew type="text" id="zip_adds" names="zip_add" dto="zip_add"  label="직장주소" title="우편번호" labelClass="2" conClass="2" disabled="true"/>
                            <ifvm:inputNew type="text" id="adres_adds" dto="adres_add" title="기본주소" disabled="true" conClass="4"/>

                            <ifvm:inputNew type="text" id="bunji_adds" dto="bunji_add" title="상세주소" disabled="true" conClass="4" />
                        </div>--%>
                    </div>
                    <div class="page_btn_area">
                        <div class="col-xs-2">
                            <span><spring:message code="혜택정보"/></span>
                        </div>
                        <div class="col-xs-10 searchbtn_r"></div>
                    </div>
                    <div class="form-horizontal top_well underline" id="mktAgree">
                        <div class="row">
                            <%--<label class="control-label col-xs-2">가용 포인트</label>--%>
                            <ifvm:inputNew type="text" id="avlPoint" dto="avlPoint" label="가용 포인트" labelClass="2" conClass="4" className="text-right font-bold" disabled="true"/>
                            <%--<div class="control_content col-xs-2">
                                <button class="btn btn-sm btn_gray" id="ofrPntSearch" onclick="ofrPntListPop();"
                                        objcode="ofrPntSearch_OBJ">상세
                                </button>
                            </div>--%>
                            <ifvm:inputNew type="text" id="coupon" dto="coupon" values="0" className="text-right font-bold mouse-curser" label="보유쿠폰" title="보유 쿠폰" labelClass="2" conClass="4" readonly="true"/>
                            <%--<ifvm:inputNew type="text" id="extncPamPoint" dto="extncPamPoint"
                                           className="text-right font-bold" label="익월소멸예정" title="익월소멸예정" labelClass="2"
                                           conClass="2" disabled="true"/>
                            <div class="control_content col-xs-2">
                                <button class="btn btn-sm btn_gray" id="extncPamSearch" onclick="extncPamListPop();"
                                        objcode="extncPamSearch_OBJ">상세
                                </button>
                            </div>--%>
                        </div>
                        <%--<div class="row">
                            <ifvm:inputNew type="text" id="preAcrlPoint" dto="preAcrlPoint" className="text-right font-bold" disabled="true" label="적립예정" title="적립예정" labelClass="2" conClass="4" />
                        </div>--%>
                        <%--<div class="row">
                            <div class="col-xs-12">
                                &lt;%&ndash;<div class="col-xs-6">
                                    <ifvm:inputNew type="text" id="accRate" dto="accRate" values="0"
                                                   className="text-right font-bold" label="구매할인" title="구매할인"
                                                   labelClass="4" conClass="8" disabled="true"/>
                                </div>&ndash;%&gt;
                                &lt;%&ndash;<div class="col-xs-6">
                                    <ifvm:inputNew type="text" id="ticket" dto="ticket" values="0" className="text-right font-bold" disabled="true" label="보유티켓" title="보유티켓" labelClass="2" conClass="4"/>
                                </div>&ndash;%&gt;
                            </div>
                        </div>--%>
                        <%--<div class="row">
                            <div class="col-xs-12">
                                <label class="control-label col-xs-2">포인트 사용적립여부</label>
                                <button class="btn btn-sm btn_gray" id="chngPntRdmYn" onclick="chngPntRdmYnFn();"
                                        objcode="chngPntRdmYn_OBJ">사용
                                </button>
                                <button class="btn btn-sm btn_gray" id="chngAcrlYn" onclick="chngAcrlYnFn();"
                                        objcode="chngAcrlYn_OBJ">적립
                                </button>

                                &lt;%&ndash; <div class="col-xs-6">
                                    <ifvm:inputNew type="text" id="pntRdmYn" values="0" className="text-right font-bold" label="포인트 사용" title="포인트 사용" labelClass="4" conClass="3" disabled="true" />
                                    <button class="btn btn-sm btn_gray" id="chngPntRdmYn"  onclick="chngPntRdmYnFn();" objcode="" >변경</button>
                                    <button class="btn btn-sm btn_gray" id="chngPntPwdYn"  onclick="chngPntPwdYnFn();" objcode="" >비밀번호</button>

                                </div>
                               <div class="col-xs-6">
                                    <ifvm:inputNew type="text" id="pntAcrlYn"  values="0" className="text-right font-bold" label="포인트 적립" title="포인트 적립" labelClass="4" conClass="5" disabled="true" />
                                 <button class="btn btn-sm btn_gray" id="chngAcrlYn" onclick="chngAcrlYnFn();" objcode="" >변경</button>
                                 </div> &ndash;%&gt;

                                <div class="col-xs-6">
                                    <ifvm:inputNew type="text" id="ticket" dto="ticket" values="0" className="text-right font-bold" disabled="true" label="보유티켓" title="보유티켓" labelClass="2" conClass="4"/>
                                </div>
                            </div>
                        </div>--%>
                    </div>
                    <br>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="half_wrap top_well">
                <div class="half_content half_left qt_border">
                    <div class="page_btn_area">
                        <div class="col-xs-6">
                            <span><spring:message code="등급정보"/></span>
                        </div>
                        <div class="col-xs-6 searchbtn_r"></div>
                    </div>
                    <div class="form-horizontal top_well underline" id="brdTierInfo">
                        <div class="row">
                            <ifvm:inputNew type="text" id="tierDSTNm" dto="tierDSTNm" label="DST" labelClass="1" conClass="3" disabled="true" title="데상트"/>
                            <ifvm:inputNew type="text" id="tierLCSNm" dto="tierLCSNm" label="LCS" labelClass="1" conClass="3" disabled="true" title="르꼬끄 스포르티브"/>
                            <ifvm:inputNew type="text" id="tierUMBNm" dto="tierUMBNm" label="UMB" labelClass="1" conClass="3" disabled="true" title="엄브로"/>
                        </div>
                        <div class="row">
                            <ifvm:inputNew type="text" id="tierDSGNm" dto="tierDSGNm" label="DSG" labelClass="1" conClass="3" disabled="true" title="데상트 골프"/>
                            <ifvm:inputNew type="text" id="tierLCGNm" dto="tierLCGNm" label="LCG" labelClass="1" conClass="3" disabled="true" title="르꼬끄 골프"/>
                            <ifvm:inputNew type="text" id="tierMSWNm" dto="tierMSWNm" label="MSW" labelClass="1" conClass="3" disabled="true" title="먼싱웨어"/>
                        </div>
                        <%--<div class="row">
                            <ifvm:inputNew type="checkBox" id="proGolfYn" label="프로골퍼" title="프로골퍼 여부" labelClass="2" conClass="1" disabled="true"/>
                            <ifvm:inputNew type="checkBox" id="drcYn" label="DRC" title="DRC 여부" labelClass="1" conClass="1" disabled="true"/>
                        </div>--%>
                    </div>
                </div>
                <div class="half_content half_right">
                    <div class="page_btn_area">
                        <div class="col-xs-2">
                            <span><spring:message code="활동정보"/></span>
                        </div>
                        <div class="col-xs-10 searchbtn_r"></div>
                    </div>
                    <div class="form-horizontal top_well underline" id="">
                        <div class="row">
                            <%--<ifvm:inputNew type="text" id="tierNm" dto="tierNm" disabled="true" label="등급" title="등급" labelClass="2" conClass="2"/>
                            <ifvm:inputNew type="text" id="validTierStartDt" dto="validTierStartDt" disabled="true" title="등급적용일" conClass="2"/>--%>

                            <%-- <ifvm:inputNew type="text" id="liftTierNm" dto="liftTierNm" disabled="true" label="평생등급" title="평생등급" labelClass="2" conClass="2" /> --%>
                            <%-- <ifvm:inputNew type="text" id="validTierLiftTimeStartDt" dto="validTierLiftTimeStartDt" disabled="true" title="등급적용일" conClass="2" /> --%>
                            <ifvm:inputNew type="text" id="lastChnlNm" dto="lastConChnlNm" label="최근접속" title="최근접속채널" labelClass="2" conClass="2" disabled="true"/>
                            <ifvm:inputNew type="text" id="conSvrDt" dto="conSvrDt" disabled="true" title="최근접속일" conClass="2"/>

                            <ifvm:inputNew type="text" id="lastChnlNm" dto="lastPurChnlNm" label="최근구매" title="최근구매채널" labelClass="2" conClass="2" disabled="true"/>
                            <ifvm:inputNew type="text" id="purSvrDt" dto="purSvrDt" disabled="true" title="최근구매일" conClass="2"/>
                        </div>
                        <div class="row">
                            <ifvm:inputNew type="text" id="drmncy_chng_unit" names="drmncy_chng_unit" dto="drmncy_chng_unit" label="휴면예정" title="휴면전환단위" labelClass="2" conClass="2" disabled="true"/>
                            <ifvm:inputNew type="text" id="drmncy_chng_unitDt" names="drmncy_chng_unitDt" conClass="2" disabled="true" title="휴면전환예정일"/>

                        </div>
                        <div class="row">
                            <ifvm:inputNew type="text" id="surveyJoinCnt" dto="surveyJoinCnt" title="설문참여" label="설문참여" className="mouse-curser" labelClass="2" conClass="4" readonly="true"/>
                            <ifvm:inputNew type="text" id="vocSvcReqCnt" dto="vocSvcReqCnt" title="고객문의" label="고객문의" className="mouse-curser" labelClass="2" conClass="4" readonly="true"/>
                            <%--<div class="col-xs-12">
                                <ifvm:inputNew type="text" id="snsTypeCdNm" dto="snsTypeCdNm" disabled="true" label="SNS" title="SNS 유형" labelClass="2" conClass="4"/>
                                <ifvm:inputNew type="text" id="snsAddr" dto="snsAddr" disabled="true" title="SNS URL" conClass="6"/>
                            </div>--%>
                            <%-- <ifvm:inputNew type="text" id="evtNm" dto="evtNm" label="이벤트참여" labelClass="2" title="이벤트명" conClass="2" disabled="true" /> --%>
                            <%-- <ifvm:inputNew type="text" id="evtDt" dto="evtDt" conClass="2" disabled="true" title="참여일" /> --%>

                            <%-- <ifvm:inputNew type="text" id="drmncy_chng_unit" names="drmncy_chng_unit" dto="drmncy_chng_unit"  label="휴면전환" title="휴면전환단위" labelClass="2" conClass="2" disabled="true"/> --%>
                            <%-- <ifvm:inputNew type="text" id="drmncy_chng_unitDt" names="drmncy_chng_unitDt" conClass="2" disabled="true" title="휴면전환일" /> --%>
                        </div>
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
<div id="mbrDetailPopup" class="popup_container"></div>
<!-- [주석제거예정] 회원탈퇴? 팝업 컨테이너 -->
<div id="dropMbrPopup" class="popup_container"></div>
<div id="pntArclYnPop"></div>
<div id="pntRdmYnPop"></div>
<div id="ofrPntListPopup"></div>
<div id="extncPamPopup"></div>


<%!
    public String cleanXss(String str) {

        if (str != null) {
            str = str.replaceAll("<", "&lt;");
            str = str.replaceAll(">", "&gt;");
        }
        return str;
    }
%>
<script type="text/javascript">
    var checkBackPage = null;
    var mbr_rid = '<%=cleanXss(request.getParameter("rid"))%>';
    var mbr_no = '<%=cleanXss(request.getParameter("mbr_no"))%>';
    var user_id = '<%=cleanXss(request.getParameter("user_id"))%>';
    var mbr_no_cam= '<%=cleanXss(request.getParameter("mbr_no_cam"))%>';
    var tabId = '<%=cleanXss(request.getParameter("tabid"))%>';
    tabId = tabId === 'null' ? null : tabId;
    var tabIndex = '<%=cleanXss(request.getParameter("tabIndex"))%>';
    tabIndex = tabIndex === 'null' ? null : tabIndex;
    mbr_no = mbr_no === 'null' ? null : mbr_no;
    mbr_rid = mbr_rid === 'null' ? null : mbr_rid;
    user_id = user_id === 'null' ? null : user_id;
    <%-- var mbr_no = '<%=request.getParameter("mbrNo")%>'; --%>
    var isNew = true; //신규 여부. 신규: true, 수정 : false
    var pointFieldId = new Array(); //배열선언
    pointFieldId = ['totalPoint', 'avlPoint', 'preAcrlPoint', 'extncPamPoint'];
    var pgmRid = '<%=cleanXss(request.getParameter("pgmRid"))%>';
    var pgmNo = '<%=cleanXss(request.getParameter("pgmNo"))%>';
    var mbrNo = '<%=cleanXss(request.getParameter("mbrNo"))%>';
    var custRid = '<%=cleanXss(request.getParameter("custRid"))%>';
    var custItemValCheck = '<%=cleanXss(request.getParameter("custItemValCheck"))%>';
    var inputeRowField = [];
    var chnlNo = '<%=cleanXss(request.getParameter("chnlNo"))%>';
    var pntPwd = '<%=cleanXss(request.getParameter("pntPwd"))%>';
    var pntRdmYn = '<%=cleanXss(request.getParameter("pntRdmYn"))%>';
    var pntAcrlYn = '<%=cleanXss(request.getParameter("pntAcrlYn"))%>';
    var mbrTypeCd = '<%=cleanXss(request.getParameter("mbrTypeCd"))%>'; // 회원유형 mbrTypeCd

    var mbrDetailNewTabArea = $("#mbrDetailNewTabArea").DrawTab({
            item: items
            /* [
            {   label : '로그인계정', href : '<ifvm:url name="mbrWebLoginInf"/>'},
	            		{   label : '채널이용내역', href : '<ifvm:url name="custUseHistListNew"/>'}, 
	            		{	label : '동의', href : '<ifvm:url name="mbrAgreList"/>'},	
	            		{   label : '특별회원', href : '<ifvm:url name="mbrMgtInfoList"/>'}, 
	            		{	label : '등급', href : '<ifvm:url name="mbrTierListNew"/>'}, 
	            		{	label : '추천인', href : '<ifvm:url name="mbrRecommendHistListNew"/>'}, 
	            		{   label : '모바일', href : '<ifvm:url name="mbrMobileLoginInf"/>'},
	            		{	label : '변경이력', href : '<ifvm:url name="mbrChangeHistListNewPage"/>'}, 
	            		{	label : '통합회원', href : '<ifvm:url name="mbrIntList"/>'},  
	            		{	label : '구매', href : '<ifvm:url name="mbrTxnHistListNew"/>'},	
	            		{	label : '포인트', href : '<ifvm:url name="mbrPointListNew"/>'},	
	            		{	label : '쿠폰', href : '<ifvm:url name="mbrCouponListNew"/>'},
            		 	{   label : '캠페인', href : '<ifvm:url name="campaignExecList"/>'}, 
	            		{	label : '이벤트', href : '<ifvm:url name="mbrEventHistListNew"/>'},
	            		{   label : '상품평', href : '<ifvm:url name="prodCustList"/>' }, 
	            		{ 	label : '상담', href : '<ifvm:url name="mbrVocListNew"/>' }, 
	            		{	label : '알림이력', href : '<ifvm:url name="mbrAlterHistListNew"/>'}, 
	            		{	label : '멤버십카드', href : '<ifvm:url name="mbrMemberCardListNew"/>'},
	            		{	label : '부정이력', href : '<ifvm:url name="mbrBlackHistListNew"/>'},
	            		{	label : '패밀리', href : '<ifvm:url name="mbrFamilyList"/>'}, 
	            		{	label : '세분화이력', href : '<ifvm:url name="mbrCustSegmentHistListNew"/>'},
	            	] */
        }
    );

    function mbrDetail() {
        $.ifvSyncPostJSON('<ifvm:action name="getMmbrDetailNewPage"/>', {
                rid: mbr_rid,
                intRidMbr: mbr_rid,
                intMbrNo: mbr_no,
                mbrNo: mbr_no
            },
            function (result) {
                // if (result.pntRdmYn == 'Y') {
                //     pntRdmYn = "가능";
                //     $("#chngPntRdmYn")[0].innerHTML = "사용 가능";
                //
                // } else if (result.pntRdmYn == 'N') {
                //     pntRdmYn = "불가능";
                //     $("#chngPntRdmYn")[0].innerHTML = "사용 불가";
                // }

                // if (result.pntAcrlYn == 'Y') {
                //     pntAcrlYn = "가능";
                //     $("#chngAcrlYn")[0].innerHTML = "적립 가능";
                //
                // } else if (result.pntAcrlYn == 'N') {
                //     pntAcrlYn = "불가능"
                //     $("#chngAcrlYn")[0].innerHTML = "적립 불가";
                // }

                if (result.childYn == 'Y') {
                    $('input:checkbox[id="childYn"]').attr("checked", true);
                } else if (result.childYn == 'N') {
                    $('input:checkbox[id="childYn"]').attr("checked", false);
                }

                $("#custTypeCd").val(result.custTypeCd);
                $("#mbrTypeCd").val(result.mbrTypeCd);
                //개인정보 조회 이력 남기기
                var backPage = backPage === 'null' ? null : $.fn.ifvmPersonalCondLogPageId("", false);
                if (backPage != null) $.fn.ifvmComCondLogging(backPage, result.custRid);
                $("#mbrForm").dataSetting(result);
                var hhp = null;
                if (result.hhp != null) {
                    var hhp = result.hhp.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/, "$1-$2-$3");
                    $("#hhp").val(hhp);
                }
                var telNo = null;
                if (result.telNo != null) {
                    telNo = result.telNo.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/, "$1-$2-$3");
                    $("#telNo").val(telNo);
                }
                //우편번호
                if (result.zip != null) $("#zip").val(result.zip);
                //우편번호(추가)
                if (result.zip_add != null) $("#zip_add").val(result.zip_add);
                //휴면전환단위
                if (result.drmncy_chng_unit != null && result.drmncy_chng_unit != "") {
                    if (result.drmmcyChngUnitCd == '99') {
                        $("#drmncy_chng_unit").val(result.drmncy_chng_unit);
                    } else {
                        $("#drmncy_chng_unit").val(result.drmncy_chng_unit);
                        //if(result.conSvrDt != null || result.conSvrDt != undefined) {
                        //$("#drmncy_chng_unitDt").val(''); //접속일
                        // if (result.drmmcyExpDate != null && result.drmmcyExpDate != "") {
                        //     $("#drmncy_chng_unitDt").val(result.drmmcyExpDate.substr(0, 4) + '-' + result.drmmcyExpDate.substr(4, 2) + '-' + result.drmmcyExpDate.substr(6, 2)); //가입일
                        // }
                        if (result.drmmcyExpDate != null && result.drmmcyExpDate != "") {
                            $("#drmncy_chng_unitDt").val(result.drmmcyExpDate);
                        }

                        //}else{
                        //$("#drmncy_chng_unitDt").val(''); //접속일
                        //}
                    }
                }
                //기념일
                if (result.annvrsry != null) $("#annvrsry").val(result.annvrsry.substr(0, 2) + "월" + result.annvrsry.substr(2, 2) + "일");
                //생일
                if (result.birthdt != null) {
                    var birthday = result.birthdt;
                    if (result.lunar_cdNm != null && result.lunar_cdNm != "") {
                        $("#birthdt").val(birthday.substr(0, 4) + "-" + birthday.substr(4, 2) + "-" + birthday.substr(6) + "  (" + result.lunar_cdNm + ")");
                    } else $("#birthdt").val(birthday.substr(0, 4) + "-" + birthday.substr(4, 2) + "-" + birthday.substr(6));
                }
                //대표등급
                //if (result.validTierStartDt != null) $("#validTierStartDt").val(result.validTierStartDt.substr(0, 4) + "-" + result.validTierStartDt.substr(4, 2) + "-" + result.validTierStartDt.substr(6));
                //등급이 없을때 부여일자도 나오지 않게 한다.
                //if (result.tierNm == null) $("#validTierStartDt").val("");

                //평생등급
// 			if(result.validTierLiftTimeStartDt != null) $("#validTierLiftTimeStartDt").val(result.validTierLiftTimeStartDt.substr(0,4)+"-"+result.validTierLiftTimeStartDt.substr(4,2)+"-"+result.validTierLiftTimeStartDt.substr(6));
                //내국인여부
                if (result.native_yn != null) {
                    if (result.native_yn == 'Y') $("#native_yn").val("내국인");
                    else $("#native_yn").val("외국인");
                }

                //결혼여부
                if (result.mrrgYn != null) {
                    if (result.mrrgYn == 'Y') {
                        $("#mrrgYn").val("기혼");
                    } else if (result.mrrgYn == 'N') {
                        $("#mrrgYn").val("미혼");
                    } else { // 빈칸일 경우 '선택안함'
                        $("#mrrgYn").val("선택안함");
                    }
                } else { // null이었을 경우 '선택안함'
                    $("#mrrgYn").val("선택안함");
                }

                pgmRid = result.pgmRid;
                pgmNo = result.pgmNo;
                custRid = result.custRid;
                mbr_rid = result.rid;
                mbr_no_cam = result.mbrNo;
                user_id = result.user_id;
                mbrNo = result.mbrNo;
                custNm = result.cust_nm;
                chnlNo = result.chnlNo;
                pntPwd = result.pntPwd;
                pointComma();
                // 현재 회원의 유형에 대한 데이터 mbrTypeCd를 가져온 것을 전역변수 mbrTypeCd에 초기화
                mbrTypeCd = result.mbrTypeCd;

                //보유쿠폰
                $("#coupon").val($("#coupon").val() + "장");
                $("#accRate").val($("#accRate").val() + "%");
                //보유티켓
// 			$("#ticket").val($("#ticket").val()+"장");
                //글자스타일 굵게
                $(".font-bold").attr('style', 'font-weight: bold;');
                //고객수집항목에대한 이름설정
                labelCheck();

                if ($('#mbrStatCd').val() == "탈퇴") {
                    $('#mbrStatCd').val("탈퇴(" + result.reSbscResn + ")")
                }

                //나이
                var ageValue = result.age;
                if($.fn.ifvmIsNotEmpty(ageValue)){
                    $("#age").val(ageValue+"세");
                    //ageGroup
                    var ageGroupValue;
                    switch (true) {
                        case (ageValue < 20) :
                            ageGroupValue = "19세 이하";
                            break;
                        case (ageValue < 25) :
                            ageGroupValue = "20 ~ 24세";
                            break;
                        case (ageValue < 30) :
                            ageGroupValue = "25 ~ 29세";
                            break;
                        case (ageValue < 35) :
                            ageGroupValue = "30 ~ 34세";
                            break;
                        case (ageValue < 40) :
                            ageGroupValue = "35 ~ 39세";
                            break;
                        case (ageValue < 45) :
                            ageGroupValue = "40 ~ 44세";
                            break;
                        case (ageValue < 50) :
                            ageGroupValue = "45 ~ 49세";
                            break;
                        case (ageValue < 55) :
                            ageGroupValue = "50 ~ 54세";
                            break;
                        case (ageValue < 60) :
                            ageGroupValue = "55 ~ 59세";
                            break;
                        case (ageValue >= 60) :
                            ageGroupValue = "60세이상";
                            break;
                        default :
                            break;
                    }
                    $("#ageGroup").val(ageGroupValue);
                }
                //프로골퍼 여부
                // if(result.proGolfYn == "Y"){
                //     $("#proGolfYn").prop('checked', true)
                // }
                //DRC여부
                // if(result.drcYn == "Y"){
                //     $("#drcYn").prop('checked', true)
                // }

                //설문참여건수
                $("#surveyJoinCnt").val(result.surveyJoinCnt+"회/"+result.surveyTgtCnt+"회")

                //고객문의
                if($.fn.ifvmIsNotEmpty(result.vocReqCnt)){
                    if($.fn.ifvmIsEmpty(result.vocReqCnt))  result.vocReqCnt = 0;

                    $("#vocSvcReqCnt").val(result.closedCnt+"건/"+result.vocReqCnt + "건")
                }

                //등급 Level
                if($.fn.ifvmIsNotEmpty(result.tierDST)){
                    $("#tierDSTNm").val(result.tierDSTNm+" ("+result.tierDSTLvl+"/"+result.tierDSTMaxLvl+")")
                }
                if($.fn.ifvmIsNotEmpty(result.tierLCS)){
                    $("#tierLCSNm").val(result.tierLCSNm+" ("+result.tierLCSLvl+"/"+result.tierLCSMaxLvl+")")
                }
                if($.fn.ifvmIsNotEmpty(result.tierUMB)){
                    $("#tierUMBNm").val(result.tierUMBNm+" ("+result.tierUMBLvl+"/"+result.tierUMBMaxLvl+")")
                }
                if($.fn.ifvmIsNotEmpty(result.tierDSG)){
                    $("#tierDSGNm").val(result.tierDSGNm+" ("+result.tierDSGLvl+"/"+result.tierDSGMaxLvl+")")
                }
                if($.fn.ifvmIsNotEmpty(result.tierLCG)){
                    $("#tierLCGNm").val(result.tierLCGNm+" ("+result.tierLCGLvl+"/"+result.tierLCGMaxLvl+")")
                }
                if($.fn.ifvmIsNotEmpty(result.tierMSW)){
                    $("#tierMSWNm").val(result.tierMSWNm+" ("+result.tierMSWLvl+"/"+result.tierMSWMaxLvl+")")
                }

                if($.fn.ifvmIsNotEmpty(result.prStoreCd)){
                    $("#prStoreNm").val(result.prStoreNm + "("+result.prStoreCd+")");
                }
            });
    };

    function ofrPntListPop() {
        $("#ofrPntListPopup").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="ofrPntPop"/>',
            contentType: "ajax",
            title: "<spring:message code="가용포인트 상세"/>",
            width: 1300,
            maxWidth: 1300,
            close: 'ofrPntPopFnClose',
        });
    }

    function ofrPntPopFnClose() {
        ofrPntListPopup._destroy();
    }

    function extncPamListPop() {
        $("#extncPamPopup").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="extncPamPop"/>',
            contentType: "ajax",
            title: "<spring:message code="익월소멸예정포인트 상세"/>",
            width: '1000px',
            close: 'extncPamListPopClose',
        });
    }

    function extncPamListPopClose() {
        extncPamPopup._destroy();
    }

    function chngAcrlYnFn() {

        $("#pntArclYnPop").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="pntArclYnPop"/>',
            contentType: "ajax",
            title: "<spring:message code="포인트 적립 변경"/>",
            width: '800px',
            close: 'chngAcrlYnFnClose',
        });
    }

    function chngPntRdmYnFn() {
        $("#pntRdmYnPop").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="pntRdmYnPop"/>',
            contentType: "ajax",
            title: "<spring:message code="포인트 사용 변경"/>",
            width: '800px',
            close: 'chngPntRdmYnFnClose',
        });
    }


    function chngPntRdmYnFnClose() {
        pntRdmYnPop._destroy();
    }

    function chngAcrlYnFnClose() {
        pntArclYnPop._destroy();
    }

    function pointComma() {

        for (var pi = 0; pi < pointFieldId.length; pi++) {
            var _pval = $("#" + pointFieldId[pi]).val();
            var _aval = "";
            if (_pval) {
                _aval = (_pval.split(".")[0]).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            }
            $("#" + pointFieldId[pi]).val(_aval + "P");
        }
    }

    //오늘날짜 계산
    function getTodayDate(dt) {
        if (dt == null || dt == undefined) dt = 0;
        var date = new Date();

        var year = date.getFullYear();
        year = parseInt(year) + parseInt(dt);
        var month = date.getMonth() + 1;
        if (month < 10) month = "0" + month;
        var day = date.getDate();
        if (day < 10) day = "0" + day;
        return year + "-" + month + "-" + day;
    }

    //휴면예정일 계산
    function getDrmncyDate(startDt, dt) {
        if (dt == null || dt == undefined) dt = 0;
        var date = new Date(startDt);

        var year = date.getFullYear();
        year = parseInt(year) + parseInt(dt);
        var month = date.getMonth() + 1;
        if (month < 10) month = "0" + month;
        var day = date.getDate();
        if (day < 10) day = "0" + day;

        return year + "-" + month + "-" + day;
    }


    function btnList() {

        checkBackPage = '<%=cleanXss(request.getParameter("checkBackPage"))%>';
        //공통으로 수정하기...
        if (checkBackPage == 'custDormantList') {
            //휴면회원일 경우 목록 클릭시 휴면회원페이지로 조회되도록 추가
            qtjs.href('<ifvm:url name="custDormantList"/>');
            checkBackPage = null;
        } else if (checkBackPage == 'dropMbrListNew') {
            //탈회회원일 경우 목록 클릭시 탈회회원페이지로 조회되도록 추가
            qtjs.href('<ifvm:url name="dropMbrListNew"/>');
            checkBackPage = null;
        } else if (checkBackPage == 'negativeAcc') {
            //부정적립 회원일 경우 목록 클릭시 부정적립페이지로 조회되도록 추가
            qtjs.href('<ifvm:url name="negativeAcc"/>');
            checkBackPage = null;
        } else if (checkBackPage == 'custBeforeDormantList') {
            qtjs.href('<ifvm:url name="custBeforeDormantList"/>');
            checkBackPage = null;
        } else if (checkBackPage == 'transactionList') {
            qtjs.href('<ifvm:url name="transactionList"/>');
            checkBackPage = null;
        } else if (checkBackPage == 'loyCouponList') {
            qtjs.href('<ifvm:url name="loyCouponList"/>');
            checkBackPage = null;
        } else if (checkBackPage == 'consultListNew') {
            qtjs.href('<ifvm:url name="consultListNew"/>');
            checkBackPage = null;
        } else if (checkBackPage == 'loyPurHistList') {
            qtjs.href('<ifvm:url name="loyPurHistList"/>');
            checkBackPage = null;
        } else if (checkBackPage == 'loyProdRevwHistList') {
            qtjs.href('<ifvm:url name="loyProdRevwHistList"/>');
            checkBackPage = null;
        } else {
            qtjs.href('<ifvm:url name="mbrListNewPage"/>');
            checkBackPage = null;
        }
    }

    function mbrListPopup() {
        $("#mbrListPop").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="mbrListPopNew"/>',
            contentType: "ajax",
            title: '타회원조회',
            width: 1200,
            close: 'mbrClosePop'
        });
    };

    function mbrClosePop() {
        mbrListPop._destroy();
    }

    //회원정보수정
    function editMbrDetailBtn() {
        $("#mbrDetailPopup").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="mbrDetailPop"/>' + '?mbr_rid=' + mbr_rid,
            contentType: "ajax",
            title: '회원정보 수정',
            width: 1000,
            close: 'mbrDetailClosePop'
        });
    };

    function mbrDetailClosePop() {
        mbrDetailPopup._destroy();
    }

    //회원탈퇴
    function getDropMbrPop() {
        if ($.fn.ifvmIsNotEmpty(mbrNo) && $.fn.ifvmIsNotEmpty(pgmNo)) {
            /* if(confirm('
            <spring:message code="탈퇴하시겠습니까?"/>')){ */
            $("#dropMbrPopup").ifvsfPopup({
                enableModal: true,
                enableResize: false,
                contentUrl: '<ifvm:url name="dropMbrPop"/>',
                contentType: "ajax",
                title: '회원 탈회',
                width: 800,
                close: 'dropMbrPoplClose'
            });
            /* } */
        } else {
            if (!$.fn.ifvmIsNotEmpty(mbr_rid)) alert("회원이 아닙니다");
            else alert("프로그램이 존재하지 않습니다.")
        }
    }

    function dropMbrPoplClose() {
        dropMbrPopup._destroy();
    }

    //고객정보, 부가정보 id 체크
    function getFieldId() {
        var inputSize = 0;
        for (var i = 0; i < $("#custDetailForm input").length; i++) {
            inputeRowField[i] = $("#custDetailForm input")[i].id;
        }
        inputSize = inputeRowField.length;
        for (var j = 0; j < $("#custDetailAddForm input").length; j++) {
            inputeRowField[j + inputSize] = $("#custDetailAddForm input")[j].id;
        }
    }

    //custDetailForm  custDetailAddForm 고객수집정보에 저장이 되있는 항목은 그항목 이름에 맞게 바꾸어준다.
    function labelCheck() {
        getFieldId();

        $.ifvSyncPostJSON('<ifvm:action name="custItemConfVal"/>', {pgmNo: pgmNo}, function (result) {
            custItemValCheck = result.rows;

            var newList = custItemValCheck.filter(function (item) {
                return inputeRowField.includes(item.fieldNm.toLowerCase());
            })

            for (var i = 0; i < newList.length; i++) {
                var fieldId = newList[i].fieldNm.toLowerCase();
                var fieldNm = newList[i].fieldDesc
                $("#" + fieldId).attr("label", fieldNm);
                if (fieldId != "bunji" && fieldId != "bunji_add" && fieldId != "lunar_cd" && fieldId != "native_yn" && fieldId != "annvrsry" && fieldId != "zip" && fieldId != "zip_add" && fieldId != "gen_cd") {
                    if (fieldId != "adres" && fieldId != "adres_add") {
                        $("#" + fieldId).closest("div").prev()[0].innerHTML = fieldNm;
                    } else {
                        $("#" + fieldId).closest("div").prev().prev()[0].innerHTML = fieldNm;
                    }
                }
            }
        });
    }


    // function custViewPopup() {
    // 	$("#custViewPop").ifvsfPopup({
    // 		enableModal : true,
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
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="executivesViewPop"/>',
            contentType: "ajax",
            title: '임직원 변경',
            width: 450,
            close: 'executivesViewClosePop'
        });
    };

    function executivesViewClosePop() {
        custViewPop._destroy();
    }

    function custViewClosePop() {
        custViewPop._destroy();
    }

    function aToDorBtn() {
        if (confirm('<spring:message code="L02924" />')) {
            $.ifvSyncPostJSON('<ifvm:action name="setCustDorChange"/>', {
                mbrRid: mbr_rid
            }, function (result) {
                alert('<spring:message code="L02925"/>');
            }, function (result) {
                alert('<spring:message code="L02926"/>');
            });
            //location.reload();
            history.back();
        }
    }

    $(document).ready(function () {

        mbrDetail();

        if ($.fn.ifvmIsNotEmpty(tabIndex)) {
            mbrDetailNewTabArea.moveTabIndex(tabIndex);
            tabIndex = null;
        }
        if ($.fn.ifvmIsNotEmpty(tabId)) {
            mbrDetailNewTabArea.moveTabByTabId(tabId)
            tabId = null;
        }

        //보유쿠폰
        $("#coupon").click(function(){
            mbrDetailNewTabArea.moveTabIndex(5);
        });

        //설문 참여 건수
        $("#surveyJoinCnt").click(function(){
            mbrDetailNewTabArea.moveTabIndex(7);
        });

        //고객 문의
        $("#vocSvcReqCnt").click(function(){
            mbrDetailNewTabArea.moveTabIndex(6);
        });

        // if ($('#custTypeCdNm').val() == '임직원') {
        //     $('#executivesViewPopup').attr("disabled", false);
        // } else {
        //     $('#executivesViewPopup').attr("disabled", true);
        // }

        // if ($("#custTypeCd").val() == "I") {
        //     // I 개인
        //     $("#chngAcrlYn").prop('disabled', false); //적립 수정 가능
        //
        //     if (mbrTypeCd == "M1") {
        //
        //         $("#chngPntRdmYn").prop('disabled', true); //사용 수정 불가능
        //
        //     } else if (mbrTypeCd == "M2") {
        //         $("#chngPntRdmYn").prop('disabled', true);//사용 수정 불가능
        //
        //     } else if (mbrTypeCd == "M3") {
        //         $("#chngPntRdmYn").prop('disabled', false);//사용 수정 가능
        //
        //     }
        //
        // } else if ($("#custTypeCd").val() == "C" || $("#custTypeCd").val() == "E") {
        //     // C 법인 , E 임직원
        //     $("#chngPntRdmYn").prop('disabled', false); //사용 수정 가능
        //     $("#chngAcrlYn").prop('disabled', false); 		//적립 수정 가능
        //
        // } else if ($("#custTypeCd").val() == "D" || $("#custTypeCd").val() == "O" || $("#custTypeCd").val() == "X") {
        //     //D 백화점 , O 회사(오피스), (구)임직원
        //     $("#chngPntRdmYn").prop('disabled', true); 	//사용 수정 불가
        //     $("#chngAcrlYn").prop('disabled', true);	 	//적립 수정 불가
        // }

    });
</script>