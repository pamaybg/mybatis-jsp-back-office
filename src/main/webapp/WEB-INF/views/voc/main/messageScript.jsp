<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
/* 2017.12.19 jun.lee 소프트폰 OCX */
MESSAGE = MESSAGE || {};
MESSAGE.SoftphoneOCX = {};
MESSAGE.SoftphoneOCX.url = {};
MESSAGE.SoftphoneOCX.action = {};
MESSAGE.SoftphoneOCX.url.modifyCallTransferPop = '<ifvm:url name="modifyCallTransferPop"/>';
MESSAGE.SoftphoneOCX.url.setAlliTypePop = '<ifvm:url name="setAlliTypePop"/>';
MESSAGE.SoftphoneOCX.url.mbrList = '<ifvm:url name="mbrList"/>';
MESSAGE.SoftphoneOCX.url.voiceMailBoxList = '<ifvm:url name="voiceMailBoxList"/>';
MESSAGE.SoftphoneOCX.url.consultList = '<ifvm:url name="consultList"/>';
MESSAGE.SoftphoneOCX.url.callbackList = '<ifvm:url name="callbackList"/>';

MESSAGE.SoftphoneOCX.action.outboundCallHst = '<ifvm:action name="outboundCallHst"/>';
MESSAGE.SoftphoneOCX.action.callScreenPopup = '<ifvm:action name="callScreenPopup"/>';
MESSAGE.SoftphoneOCX.action.callEnd = '<ifvm:action name="callEnd"/>';
MESSAGE.SoftphoneOCX.action.getExtension = '<ifvm:action name="getExtension"/>';

MESSAGE.SoftphoneOCX.action.getCallTransferList = '<ifvm:action name="getCallTransferList"/>';
MESSAGE.SoftphoneOCX.action.callTransferHst = '<ifvm:action name="callTransferHst"/>';

MESSAGE.SoftphoneOCX.title_MSG_V00144 = '<spring:message code="V00144"/>';
MESSAGE.SoftphoneOCX.title_MSG_V00143 = '<spring:message code="V00143"/>';
MESSAGE.SoftphoneOCX.title_MSG_V00147 = '<spring:message code="V00147"/>';
MESSAGE.SoftphoneOCX.title_MSG_V00148 = '<spring:message code="V00148"/>';
MESSAGE.SoftphoneOCX.title_MSG_V00149 = '<spring:message code="V00149"/>';
MESSAGE.SoftphoneOCX.title_MSG_V00150 = '<spring:message code="V00150"/>';
MESSAGE.SoftphoneOCX.title_MSG_V00151 = '<spring:message code="V00151"/>';
MESSAGE.SoftphoneOCX.title_MSG_V00219 = '<spring:message code="V00219"/>';
MESSAGE.SoftphoneOCX.title_MSG_V00222 = '<spring:message code="V00222"/>';
MESSAGE.SoftphoneOCX.title_MSG_V00223 = '<spring:message code="V00223"/>';
MESSAGE.SoftphoneOCX.title_MSG_V00224 = '<spring:message code="V00224"/>';
MESSAGE.SoftphoneOCX.title_MSG_V00225 = '<spring:message code="V00225"/>';
MESSAGE.SoftphoneOCX.title_MSG_V00252 = '<spring:message code="V00252"/>';
MESSAGE.SoftphoneOCX.title_MSG_V00253 = '<spring:message code="V00253"/>';
MESSAGE.SoftphoneOCX.title_MSG_V00254 = '<spring:message code="V00254"/>';
MESSAGE.SoftphoneOCX.title_MSG_V00291 = '<spring:message code="V00291"/>';
</script>

