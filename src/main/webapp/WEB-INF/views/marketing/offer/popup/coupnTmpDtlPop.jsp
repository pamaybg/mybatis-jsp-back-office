<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>

#coupnWrap .cam_coupon_img { border: 1px solid #c6c6c6; width: 100%; min-height: 142px; text-align: center; }
#coupnWrap .half_left { width: 55% }
#coupnWrap .half_right { width: 45% }
#coupnWrap .desc_line { padding-top: 2px; padding-bottom: 2px; background-color: #EEEEEE; margin-top: 4px; }

</style>

<script>

var coupnlimiteByte = 100;
var isValid = false;
var coupnValidation;
var coupnListPopup;

var coupnDetail = false;

var campaignCoupon ;

/**
 * 초기 화면 설정
 */
function initCouponData() {

    campaignCoupon = {};

    if ($.fn.ifvmIsNotEmpty(offerData.coupnDtl)) {
        coupnDetail = true;
        if (offerData.coupnDtl.dataStatus != 'D') {
            campaignCoupon = offerData.coupnDtl;
        }
    }
    camCoupon_setDetil(false);
}

/**
 * 쿠폰 정보 setting
 */
function camCoupon_setDetil(copyFlag) {

    $('#removeCouponBtn').hide();

    var result = campaignCoupon;
    var data = {
            coupnUseGdnc1  : null,
            coupnUseGdnc2  : null,
            coupnUseGdnc3  : null,
            coupnUseGdnc4  : null,
            coupnUseGdnc5  : null,
            coupnUseGdnc6  : null,
            coupnUseGdnc7  : null,
            coupnUseGdnc8  : null,
            coupnUseGdnc9  : null,
            coupnUseGdnc10 : null,
    }

    if ($.fn.ifvmIsEmpty(result) == false) {
        $('#coupnWrap #rid').val(result.rid);
        $('#coupnWrap #coupnNo').val(result.coupnNo);
        $('#coupnWrap #coupnNm').val(result.coupnNm);

        if ($.fn.ifvmIsNotEmpty(result.useStartDt)) {
            $('#coupnWrap #useStartDt').val(result.useStartDt.split(' ', 1));
        }
        else {
            $('#coupnWrap #useStartDt').val('');
        }
        if ($.fn.ifvmIsNotEmpty(result.useEndDt)) {
            $('#coupnWrap #useEndDt').val(result.useEndDt.split(' ', 1));
        }
        else {
            $('#coupnWrap #useEndDt').val('');
        }
        $('#coupnWrap #coupnDesc').val(result.coupnDesc);
        $('#coupnWrap #coupnImgTypeCd').val(result.coupnImgTypeCd);

        data = result;
    }
    else {
        $('#coupnWrap #rid').val('');
        $('#coupnWrap #coupnNo').val('');
        $('#coupnWrap #coupnNm').val('');
        $('#coupnWrap #useStartDt').val('');
        $('#coupnWrap #useEndDt').val('');
        $('#coupnWrap #coupnDesc').val('');
        $('#coupnWrap #coupnImgTypeCd').val('');
    }

    coupn_setDesc(data);

    // 쿠폰 사용안내 TextBox Byte 체크
    for (var i = 1 ; i <= 10 ; i++) {
        var txtId = 'coupnUseGdnc' + i;
        $('#' + txtId + '_byte').val(getByteCheck(txtId));
        $('#' + txtId).keyup(function(a) {
            var getByte = getByteCheck($(this).attr('id'));
            if (getByte > coupnlimiteByte) {
                var k = cutMessage($(this).attr('id'), coupnlimiteByte);
                var cutMessageVal = $(this).val().substring(0, k);
                $(this).val(cutMessageVal);
                getByte = getByteCheck($(this).attr('id'));
            }
            $('#' + $(this).attr('id') + '_byte').val(getByte);
        });
    }

    // 쿠폰 이미지 표시
    setCoupnImg();

    if (coupnDetail == true
            && ($.fn.ifvmIsNotEmpty(offerData.coupnDtl) && offerData.coupnDtl.dataStatus != 'D')) {
        $('#removeCouponBtn').show();
    }
}

/**
 * 달력
 *
 * - 시작일
 * - 종료일
 *
 * @returns
 */
function setChannelCalendar() {

    var startDate = $("#useStartDt");
    var endDate = $("#useEndDt");
    startDate.val($.ifvGetTodayDate());
    endDate.val($.ifvGetTodayDate());

    startDate.ifvDateChecker({});
    endDate.ifvDateChecker({});
}

/**
 * 시작일 종료일 체크
 */
function chkCalendarValidation() {
    var rtnFlag = true;
    var startDate = $("#useStartDt");
    var endDate = $("#useEndDt");
    startDate.removeClass('ifv_vali_wrong');
    if ($.fn.ifvmIsNotEmpty(startDate.val()) && $.fn.ifvmIsNotEmpty(endDate.val())) {
        if (startDate.val() > endDate.val()) {
            validFailMessage(startDate, '<spring:message code="C00043"/>');
            rtnFlag = false;
        }
    }
    return rtnFlag;
}

/**
 * 쿠폰 불러오기 팝업 호출
 */
function coupnListPopupOpen() {

    $("#coupnListPopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="camCouponListPop"/>',
        contentType: "ajax",
        title: "<spring:message code='M02383'/>",
        width: 500,
        close : 'camCouponListPopupClose'
    });
}

/**
 * 쿠폰 불러오기 팝업 닫기
 */
function camCouponListPopupClose() {
    coupnListPopup._destroy();
}

/**
 * 마케팅 쿠폰 등록 및 수정
 */
function saveCoupn() {

    var isValid = chkCalendarValidation() && coupnValidation.confirm();
    if (isValid == true) {

        var couponData = {
              coupnNo        : $('#coupnWrap #coupnNo').val()
            , coupnNm        : $('#coupnWrap #coupnNm').val()
            , coupnActYn     : $('#coupnWrap #coupnActYn').val()
            , useStartDt     : $('#coupnWrap #useStartDt').val()
            , useEndDt       : $('#coupnWrap #useEndDt').val()
            , coupnImgTypeCd : $('#coupnWrap #coupnImgTypeCd').val()
            , coupnDesc      : $('#coupnWrap #coupnDesc').val()
            , coupnUseGdnc1  : $('#coupnWrap #coupnUseGdnc1').val()
            , coupnUseGdnc2  : $('#coupnWrap #coupnUseGdnc2').val()
            , coupnUseGdnc3  : $('#coupnWrap #coupnUseGdnc3').val()
            , coupnUseGdnc4  : $('#coupnWrap #coupnUseGdnc4').val()
            , coupnUseGdnc5  : $('#coupnWrap #coupnUseGdnc5').val()
            , coupnUseGdnc6  : $('#coupnWrap #coupnUseGdnc6').val()
            , coupnUseGdnc7  : $('#coupnWrap #coupnUseGdnc7').val()
            , coupnUseGdnc8  : $('#coupnWrap #coupnUseGdnc8').val()
            , coupnUseGdnc9  : $('#coupnWrap #coupnUseGdnc9').val()
            , coupnUseGdnc10 : $('#coupnWrap #coupnUseGdnc10').val()
        };

        // 수정
        if (coupnDetail == true) {
            couponData.rid = offerData.coupnDtl.rid;
            couponData.dataStatus = 'U';
        }
        else {
            couponData.dataStatus = 'N';
        }
        offerData.coupnDtl = couponData;

        $('#ridCoupn').val(offerData.coupnDtl.rid);
        $('#coupnNm').val(offerData.coupnDtl.coupnNm);

        alert('저장되었습니다.');
        coupnTmpPopupClose();
    }
}

/**
 * 쿠폰 삭제
 */
function removeCoupn() {

    if (confirm('<spring:message code="M01053"/>') == true) {

        offerData.coupnDtl.dataStatus = 'D';

        alert('삭제되었습니다.');
        coupnTmpPopupClose();

        $('#ridCoupn').val('');
        $('#coupnNm').val('');

        //coupnDetail = false;
        //camCoupon_setDetil(false);
        /*
        $.ifvSyncPostJSON('<ifvm:action name="removeCoupon"/>', {
            rid : $('#coupnWrap #rid').val()
        },
        function(result) {
            if (result.success == true) {
                alert('<spring:message code="L00034"/>');

                campaignCoupon = {};
                offerData.coupnDtl = {};

                //coupnDetail = false;
                camCoupon_setDetil(false);
            }
        }); */
    }
}

/**
 * 쿠폰 사용안내
 * (템플릿 사용 출력)
 */
function coupn_setDesc(data) {
    var descData = [];
    for (var i = 1 ; i <= 10 ; i++) {
        var key = 'coupnUseGdnc' + i;
        descData[i-1] = {
                cnt:i,
                value:data[key]
        };
    }
    var coupnUseGdncTemp = $("#coupnUseGdncTemp").tmpl(descData);
    $("#coupnUseGdncDiv").html(coupnUseGdncTemp);
}

/**
 * 쿠폰 이미지 표시
 */
function setCoupnImg() {
    var imgSrc = $('#coupnImgTypeCd option:selected').data('img');

    if ($.fn.ifvmIsEmpty(imgSrc) == false) {
        $('#coupnImg').html('<img src="' + imgSrc + '" alt="" />');
    }
    else {
        $('#coupnImg').html('');
    }
}

/**
 * byte 수 계산
 */
function getByteCheck(messageId) {
    var totalByte = 0;
    var message = $('#' + messageId).val();
    for (var i = 0; i < message.length; i++) {
        var currentByte = message.charCodeAt(i);
        if (currentByte > 128) {
            totalByte += 2;
        }
        else {
            totalByte += 1;
        }
    }
    return totalByte;
}

/**
 * 최대 용량 넘어갈 시 메세지 자르기
 */
function cutMessage(messageId, remainByte) {
    var totalByte = 0;
    var k = 0;
    var message = $('#' + messageId).val();
    for (var i = 0; i < message.length; i++) {
        var currentByte = message.charCodeAt(i);
        if (currentByte > 128){
            totalByte += 2;
        }
        else {
            totalByte++;
        }
        if (totalByte >= remainByte) {
            break;
        }
        k++;
    }
    return k;
}

$(document).ready(function() {

    // 달력 설정
    setChannelCalendar();

    // 초기 화면 설정
    initCouponData();

    coupnValidation = $('#coupnWrap').ifvValidation();

    // 이미지 코드
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
        groupCode : 'COUPN_IMG_TYPE_CD',
        enableNA : true
    }, function(result) {
        var size = result.rows.length;
        arrStore = {};
        arrStore.markName = '<spring:message code="M00436"/>';
        arrStore.attrib01 = '';
        for (var i = size; i >= 0; i--) {
            if (i != 0) {
                temp = result.rows[i - 1];
                result.rows[i] = temp;
            }
            else {
                result.rows[0] = {};
                result.rows[0] = arrStore;
            }
        }
        var temp = $("#coupnImgSelectBoxTemp").tmpl(result.rows);
        $("#coupnImgTypeCd").append(temp);
    });

    // 쿠폰 이미지 코드 변경시
    $('#coupnImgTypeCd').on('change', function() {
        setCoupnImg();
    });

    // 쿠폰 불러오기 버튼
    $('#coupnListPopupOpenBtn').on('click', function() {
        coupnListPopupOpen();
    });

    // 저장 버튼
    $('#coupnSaveBtn').on('click', function() {
        saveCoupn();
    });

    // 삭제 버튼
    $('#removeCouponBtn').on('click', function() {
        removeCoupn();
    });

    // 닫기 버튼
    $('#coupnPopCloseBtn').on('click', function() {
        coupnTmpPopupClose();
    });

});

</script>

<script id="coupnImgSelectBoxTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}" data-img="${'${'}attrib01}">${'${'}markName}</option>
</script>

<script id="coupnUseGdncTemp" type="text/x-jquery-tmpl">

<div class="row qt_border desc_line">
    <label class="col-xs-1 control-label">${'${'}cnt} Line</label>
    <div class="col-xs-9 control_content">
        <ifvm:input type="text" id="coupnUseGdnc${'${'}cnt}" names="coupnUseGdnc${'${'}cnt}" values="${'${'}value}"/>
    </div>
    <div class="col-xs-1 control_content">
        <ifvm:input type="text" id="coupnUseGdnc${'${'}cnt}_byte" readonly="readonly" />
    </div>
    <label class="col-xs-1 control-label" style="text-align: left">Byte</label>
</div>

</script>
<div id="coupnWrap">
    <ifvm:input type="hidden" id="coupnActYn" names="coupnActYn" values="1"/>

    <div class="pop_inner_wrap form-horizontal">
        <div class="row qt_border group_box_bg">
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M02379"/></label>
            <div class="col-xs-2">
                <button class="btn_Load" id="coupnListPopupOpenBtn">
                    <img src="<ifvm:image name='ico_search'/>" alt="" />
                    <spring:message code="M00613"/>
                </button>
            </div>
        </div>
        <div class="row group_box_bg group_box_line popup_contents_height" >

            <div class="page_btn_area">
                <div class="col-xs-7">
                    <span><spring:message code="M02279"/></span>
                </div>
                <div class="col-xs-5 searchbtn_r">
                    <button class="btn btn-sm" id='removeCouponBtn'>
                        <i class="glyphicon glyphicon-check"></i>
                        <spring:message code="L00029"/>
                    </button>
                </div>
            </div>

            <div class="half_content half_left">
                <div class="well form-horizontal underline top_well">
                    <div class="row qt_border">

                        <%-- 쿠폰번호 --%>
                        <label class="col-xs-3 control-label"><spring:message code="M02380"/></label>
                        <div class="col-xs-9 control_content">
                            <ifvm:input type="text" id="coupnNo" names="coupnNo" readonly="readonly" />
                        </div>
                    </div>
                    <div class="row qt_border">

                        <%-- 쿠폰명  --%>
                        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00347"/></label>
                        <div class="col-xs-9 control_content">
                            <ifvm:input type="text" required="true" id="coupnNm" names="coupnNm"/>
                        </div>
                    </div>
                    <div class="row qt_border">

                        <%-- 사용기간  --%>
                        <label class="col-xs-3 control-label"><spring:message code="M01304"/></label>
                        <div class="col-xs-4 control_content start_date">
                            <ifvm:input type="date" id="useStartDt" names="useStartDt"/>
                        </div>
                        <label class="col-xs-1 control-label" style="text-align: center; padding-left: 0px; padding-right: 0px;"> ~ </label>
                        <div class="col-xs-4 control_content end_date">
                            <ifvm:input type="date" id="useEndDt" names="useEndDt"/>
                        </div>
                    </div>
                    <div class="row qt_border">

                        <%-- 설명 --%>
                        <label class="col-xs-3 control-label"><spring:message code="M00472"/></label>
                        <div class="col-xs-9 control_content">
                            <ifvm:input type="textarea" id="coupnDesc" names="coupnDesc" maxLength="50" rows="4"/>
                        </div>
                    </div>
                </div>
            </div>

            <div class="half_content half_right">
                <div class="well form-horizontal underline top_well">
                    <div class="row qt_border">

                        <label class="col-xs-3 control-label"><spring:message code="M02381"/></label>
                        <div class="col-xs-6 control_content">
                            <div class="cam_coupon_img" id="coupnImg"></div>
                        </div>
                    </div>
                    <div class="row qt_border">

                        <%-- 이미지 유형코드 --%>
                        <label class="col-xs-3 control-label">&nbsp;</label>
                        <div class="col-xs-6 control_content">
                            <div class="row qt_border">
                                <ifvm:input type="select" id="coupnImgTypeCd" names="coupnImgTypeCd"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div>
                <div class="form-horizontal underline top_well">
                    <div class="row qt_border">
                        <label class="col-xs-3 control-label label_txt"><spring:message code="M02382"/></label>
                    </div>
                    <div id="coupnUseGdncDiv"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="pop_btn_area">
    <button class="btn btn-sm btn_lightGray2" id="coupnSaveBtn">
        <spring:message code="M00137"/>
    </button>
    <button class="btn btn-sm btn_lightGray2" id="coupnPopCloseBtn">
        <spring:message code="M00441"/>
    </button>
</div>

<div id="coupnListPopup"></div>