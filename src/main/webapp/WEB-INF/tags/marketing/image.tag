<%@ tag body-content="empty" pageEncoding="UTF-8"  description="Image 경로 태그"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="name" required="true" type="java.lang.String" %>
<c:set var="nameValue" value="${name}"/>

<c:choose>
    <%--  --%>
    <c:when test="${nameValue == 'header_profile'}">${pageContext.request.contextPath}/resources/images/common/header/profile.png</c:when>
    <c:when test="${nameValue == 'header_changePwd'}">${pageContext.request.contextPath}/resources/images/common/header/profile_btn.png</c:when>
    <c:when test="${nameValue == 'btn_plus'}">${pageContext.request.contextPath}/resources/images/marketing/common/btn_plus.png</c:when>
    <c:when test="${nameValue == 'btn_minus'}">${pageContext.request.contextPath}/resources/images/marketing/common/btn_minus.gif</c:when>
    <c:when test="${nameValue == 'btn_delete'}">${pageContext.request.contextPath}/resources/images/marketing/common/btn_delete.png</c:when>
    <c:when test="${nameValue == 'file_upload'}">${pageContext.request.contextPath}/resources/images/marketing/common/file_upload.gif</c:when>
    <c:when test="${nameValue == 'image_upload'}">${pageContext.request.contextPath}/resources/images/marketing/common/image_upload.gif</c:when>
    <c:when test="${nameValue == 'img_phone'}">${pageContext.request.contextPath}/resources/images/marketing/common/img_phone.png</c:when>
    <c:when test="${nameValue == 'ico_search'}">${pageContext.request.contextPath}/resources/images/marketing/common/ico_search.png</c:when>
    <c:when test="${nameValue == 'ico_input'}">${pageContext.request.contextPath}/resources/images/marketing/common/ico_input.png</c:when>
    <c:when test="${nameValue == 'ico_upload'}">${pageContext.request.contextPath}/resources/images/marketing/common/ico_upload.png</c:when>
    <c:when test="${nameValue == 'ico_loading'}">${pageContext.request.contextPath}/resources/images/marketing/common/ico_loading.png</c:when>
    <c:when test="${nameValue == 'ico_download'}">${pageContext.request.contextPath}/resources/images/marketing/common/ico_download.png</c:when>
    <c:when test="${nameValue == 'ico_download2'}">${pageContext.request.contextPath}/resources/images/marketing/common/ico_download2.png</c:when>
    <c:when test="${nameValue == 'ico_check'}">${pageContext.request.contextPath}/resources/images/marketing/common/ico_check.png</c:when>
    
    <%-- 백상주 - 콘텐츠 --%>
    <c:when test="${nameValue == 'arrow_right_pop'}">${pageContext.request.contextPath}/resources/images/marketing/content/arrow_right_pop.png</c:when>
    <c:when test="${nameValue == 'photo_def'}">${pageContext.request.contextPath}/resources/images/marketing/content/photo_def.jpg</c:when>
    <c:when test="${nameValue == 'barcode_def'}">${pageContext.request.contextPath}/resources/images/marketing/content/barcode_def.jpg</c:when>
    <c:when test="${nameValue == 'barcode_def_en'}">${pageContext.request.contextPath}/resources/images/marketing/content/barcode_def_en.gif</c:when>
    
    <c:when test="${nameValue == 'barcode_sample2'}">${pageContext.request.contextPath}/resources/images/marketing/content/barcode_sample2.gif</c:when>
    <c:when test="${nameValue == 'barcode_sample2_en'}">${pageContext.request.contextPath}/resources/images/marketing/content/barcode_sample2_en.gif</c:when>
    <c:when test="${nameValue == 'qr_code_e1'}">${pageContext.request.contextPath}/resources/images/marketing/content/qr_code_e1.png</c:when>
    
    <c:when test="${nameValue == 'photo_close'}">${pageContext.request.contextPath}/resources/images/marketing/content/photo_close.png</c:when>    
    
    <c:when test="${nameValue == 'set_a'}">${pageContext.request.contextPath}/resources/images/marketing/targeting/set_a.png</c:when>
    <c:when test="${nameValue == 'set_b'}">${pageContext.request.contextPath}/resources/images/marketing/targeting/set_b.png</c:when>
    <c:when test="${nameValue == 'set_union'}">${pageContext.request.contextPath}/resources/images/marketing/targeting/set_union.png</c:when>
    <c:when test="${nameValue == 'set_intersection'}">${pageContext.request.contextPath}/resources/images/marketing/targeting/set_intersection.png</c:when>
    <c:when test="${nameValue == 'upload_red'}">${pageContext.request.contextPath}/resources/images/marketing/targeting/upload_red.png</c:when>
    <c:when test="${nameValue == 'upload_green'}">${pageContext.request.contextPath}/resources/images/marketing/targeting/upload_green.png</c:when>
    
    <c:when test="${nameValue == 'login_logo'}">${pageContext.request.contextPath}/resources/images/marketing/login/icignal_mkt_login_logo.png</c:when>
    <c:when test="${nameValue == 'ico_write'}">${pageContext.request.contextPath}/resources/images/marketing/campaign/ico_write.png</c:when>
    
    <%-- 바로실행 캠페인 --%>
    <c:when test="${nameValue == 'direct_ico_check'}">${pageContext.request.contextPath}/resources/images/marketing/directCampaign/ico_check.png</c:when>
    <c:when test="${nameValue == 'direct_ico_sms'}">${pageContext.request.contextPath}/resources/images/marketing/directCampaign/ico_sms.gif</c:when>
    <c:when test="${nameValue == 'direct_ico_push'}">${pageContext.request.contextPath}/resources/images/marketing/directCampaign/ico_push.gif</c:when>
    <c:when test="${nameValue == 'direct_img_arr'}">${pageContext.request.contextPath}/resources/images/marketing/directCampaign/img_arr.png</c:when>
    <c:when test="${nameValue == 'direct_ico_success'}">${pageContext.request.contextPath}/resources/images/marketing/directCampaign/ico_success.png</c:when>
    <c:when test="${nameValue == 'direct_ico_failed'}">${pageContext.request.contextPath}/resources/images/marketing/directCampaign/ico_failed.png</c:when>
    
    <%-- 타겟팅 사용자 --%>
    <c:when test="${nameValue == 'ico_close'}">${pageContext.request.contextPath}/resources/images/marketing/common/ico_close.png</c:when>
    <c:when test="${nameValue == 'ico_close_hover'}">${pageContext.request.contextPath}/resources/images/marketing/common/ico_close_hover.png</c:when>
    <c:when test="${nameValue == 'ico_check2'}">${pageContext.request.contextPath}/resources/images/marketing/common/ico_check2.png</c:when>
    <c:when test="${nameValue == 'ico_setting'}">${pageContext.request.contextPath}/resources/images/marketing/common/ico_setting.png</c:when>
    
    <%-- 오퍼 - 쿠폰 --%>
    <c:when test="${nameValue == 'coupon_bg'}">${pageContext.request.contextPath}/resources/images/beacon/coupon_bg.png</c:when>
    <c:when test="${nameValue == 'coupon_btn'}">${pageContext.request.contextPath}/resources/images/beacon/coupon_btn.png</c:when>
    <c:when test="${nameValue == 'select_img2'}">${pageContext.request.contextPath}/resources/images/beacon/img_camera.png</c:when>
    <c:when test="${nameValue == 'task_phone'}">${pageContext.request.contextPath}/resources/images/beacon/img_phone.png</c:when>
    <c:when test="${nameValue == 'barcode'}">${pageContext.request.contextPath}/resources/images/beacon/barcode.png</c:when>
    
    <%-- 분석 --%>
    <c:when test="${nameValue == 'chart_01'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/chart_01.png</c:when>
    <c:when test="${nameValue == 'chart_02'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/chart_02.png</c:when>
    <c:when test="${nameValue == 'chart_03'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/chart_03.png</c:when>
    <c:when test="${nameValue == 'chart_04'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/chart_04.png</c:when>
    <c:when test="${nameValue == 'chart_05'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/chart_05.png</c:when>
    <c:when test="${nameValue == 'chart_06'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/chart_06.png</c:when>
    <c:when test="${nameValue == 'chart_07'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/chart_07.png</c:when>
    <c:when test="${nameValue == 'chart_08'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/chart_08.png</c:when>
    <c:when test="${nameValue == 'chart_09'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/chart_09.png</c:when>
    <c:when test="${nameValue == 'chart_10'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/chart_10.png</c:when>
    <c:when test="${nameValue == 'chart_11'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/chart_11.png</c:when>
    <c:when test="${nameValue == 'chart_12'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/chart_12.png</c:when>
    <c:when test="${nameValue == 'chart_13'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/chart_13.png</c:when>
    <c:when test="${nameValue == 'chart_14'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/chart_14.png</c:when>
    <c:when test="${nameValue == 'chart_15'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/chart_15.png</c:when>
    <c:when test="${nameValue == 'chart_16'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/chart_16.png</c:when>
    <c:when test="${nameValue == 'chart_17'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/chart_17.png</c:when>
    <c:when test="${nameValue == 'chart_18'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/chart_18.png</c:when>
    <c:when test="${nameValue == 'layout_01'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/layout_01.png</c:when>
    <c:when test="${nameValue == 'layout_02'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/layout_02.png</c:when>
    <c:when test="${nameValue == 'layout_03'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/layout_03.png</c:when>
    <c:when test="${nameValue == 'layout_04'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/layout_04.png</c:when>
    <c:when test="${nameValue == 'layout_05'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/layout_05.png</c:when>
    <c:when test="${nameValue == 'layout_06'}">${pageContext.request.contextPath}/resources/images/kepler/analysis/layout_06.png</c:when>
    <c:when test="${nameValue == 'ico_hwp'}">${pageContext.request.contextPath}/resources/images/kepler/analytics/ico_kr_export.png</c:when>
    <c:when test="${nameValue == 'ico_html'}">${pageContext.request.contextPath}/resources/images/kepler/analytics/ico_html_export.png</c:when>    
    
    <%-- 로지컬 컴포넌트 --%>
    <c:when test="${nameValue == 'icon_bracket_left_gray'}">${pageContext.request.contextPath}/resources/images/kepler/logicalComponent/icon_bracket_left_gray.png</c:when>
	<c:when test="${nameValue == 'icon_bracket_left_white'}">${pageContext.request.contextPath}/resources/images/kepler/logicalComponent/icon_bracket_left_white.png</c:when>
	<c:when test="${nameValue == 'icon_bracket_right_gray'}">${pageContext.request.contextPath}/resources/images/kepler/logicalComponent/icon_bracket_right_gray.png</c:when>
	<c:when test="${nameValue == 'icon_bracket_right_white'}">${pageContext.request.contextPath}/resources/images/kepler/logicalComponent/icon_bracket_right_white.png</c:when>
	<c:when test="${nameValue == 'icon_division_gray'}">${pageContext.request.contextPath}/resources/images/kepler/logicalComponent/icon_division_gray.png</c:when>
	<c:when test="${nameValue == 'icon_division_white'}">${pageContext.request.contextPath}/resources/images/kepler/logicalComponent/icon_division_white.png</c:when>
	<c:when test="${nameValue == 'icon_minus_gray'}">${pageContext.request.contextPath}/resources/images/kepler/logicalComponent/icon_minus_gray.png</c:when>
	<c:when test="${nameValue == 'icon_minus_white'}">${pageContext.request.contextPath}/resources/images/kepler/logicalComponent/icon_minus_white.png</c:when>
	<c:when test="${nameValue == 'icon_multiply_gray'}">${pageContext.request.contextPath}/resources/images/kepler/logicalComponent/icon_multiply_gray.png</c:when>
	<c:when test="${nameValue == 'icon_multiply_white'}">${pageContext.request.contextPath}/resources/images/kepler/logicalComponent/icon_multiply_white.png</c:when>
	<c:when test="${nameValue == 'icon_plus_gray'}">${pageContext.request.contextPath}/resources/images/kepler/logicalComponent/icon_plus_gray.png</c:when>
	<c:when test="${nameValue == 'icon_plus_white'}">${pageContext.request.contextPath}/resources/images/kepler/logicalComponent/icon_plus_white.png</c:when>
    <c:when test="${nameValue == 'icon_c_gray'}">${pageContext.request.contextPath}/resources/images/kepler/logicalComponent/icon_c_gray.png</c:when>
	<c:when test="${nameValue == 'icon_c_white'}">${pageContext.request.contextPath}/resources/images/kepler/logicalComponent/icon_c_white.png</c:when>
    <c:when test="${nameValue == 'icon_backspace_gray'}">${pageContext.request.contextPath}/resources/images/kepler/logicalComponent/icon_backspace_gray.png</c:when>
	<c:when test="${nameValue == 'icon_backspace_white'}">${pageContext.request.contextPath}/resources/images/kepler/logicalComponent/icon_backspace_white.png</c:when>
    
    <%-- 캠페인 홈 --%>
	<c:when test="${nameValue == 'ico_group_home'}">${pageContext.request.contextPath}/resources/images/marketing/campaignHome/ico_group_home.png</c:when>
	
	<c:otherwise></c:otherwise>
</c:choose>