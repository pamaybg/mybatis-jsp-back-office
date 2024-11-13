<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var camCouponlimiteByte = 100;
var isValid = false;
var camCouponValidation;
var camCouponListPopup;

var campaignCoupon;

var detail = false;

/**
 * 팝업 설정
 */
function initMultiStagePopup() {
    cDialog.model.title = '<spring:message code="M02378"/>';
    $("#dialog_title").append('<spring:message code="M02378"/>');
    cDialog.model.width = "800";
    cDialog.model.close = "camCouponPopupClose";
}

/**
 * 쿠폰 팝업 종료 
 */
function camCouponPopupClose() {
    cDialog._destroy();
}

/**
 * 초기 화면 설정
 */
function initCamCouponData() {
    
    campaignCoupon = {};

    //캠페인 기본정보와 연결이 되어있는지 확인
    var campaignInfo = getNodesByNodeType(diagram.selectionList[0], "INFO");
    if (isNotEmpty(campaignInfo)) {
        //캠페인 ID
        campaign.id = campaignInfo[0].addInfo.actualTaskId;
    }
    else {
        alert('<spring:message code="C00148"/>');
        
        //close popup
        camCouponPopupClose();
        return false;
    }
    
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

    //node 유형설정
    diagram.selectionList[0].addInfo.taskType = "OFFER";
}

/**
 * 쿠폰 상세 조회
 */
function getCouponDetail() {

    $.ifvSyncPostJSON('<ifvm:action name="getCouponDtl"/>', {
        ridMktCamMst : campaign.id
    }, function(result) {
        if ($.fn.ifvmIsNotEmpty(result)) {
            campaignCoupon = result;
            campaignCoupon.ridMktCamMst = campaign.id;
            
            detail = true;
        }
    });

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
    
    if ($.fn.ifvmIsNotEmpty(result)) {
        
        $('#camCouponWrap #rid').val(result.rid);
        $('#camCouponWrap #coupnNo').val(result.coupnNo);
        $('#camCouponWrap #coupnNm').val(result.coupnNm);

        if ($.fn.ifvmIsNotEmpty(result.useStartDt)) {
            $('#camCouponWrap #useStartDt').val(result.useStartDt.split(' ', 1));
        }
        else {
            $('#camCouponWrap #useStartDt').val('');
        }
        
        if ($.fn.ifvmIsNotEmpty(result.useEndDt)) {
            $('#camCouponWrap #useEndDt').val(result.useEndDt.split(' ', 1));
        }
        else {
            $('#camCouponWrap #useEndDt').val('');
        }
        $('#camCouponWrap #coupnDesc').val(result.coupnDesc);
        $('#camCouponWrap #coupnImgTypeCd').val(result.coupnImgTypeCd);
        
        data = result;
    }
    else {
        $('#camCouponWrap #rid').val('');
        $('#camCouponWrap #coupnNo').val('');
        $('#camCouponWrap #coupnNm').val('');
        $('#camCouponWrap #useStartDt').val('');
        $('#camCouponWrap #useEndDt').val('');
        $('#camCouponWrap #coupnDesc').val('');
        $('#camCouponWrap #coupnImgTypeCd').val('');
    }
    
    camCoupon_setDesc(data);
    
    // 쿠폰 사용안내 TextBox Byte 체크 
    for (var i = 1 ; i <= 10 ; i++) {
        var txtId = 'coupnUseGdnc' + i;
        $('#' + txtId + '_byte').val(getByteCheck(txtId));
        $('#' + txtId).keyup(function(a) {
            var getByte = getByteCheck($(this).attr('id'));
            if (getByte > camCouponlimiteByte) {
                var k = cutMessage($(this).attr('id'), camCouponlimiteByte);
                var cutMessageVal = $(this).val().substring(0, k);
                $(this).val(cutMessageVal);
                getByte = getByteCheck($(this).attr('id'));
            }
            $('#' + $(this).attr('id') + '_byte').val(getByte);
        });
    }

    // 쿠폰 이미지 표시
    setCoupnImg();
    
    if (detail == true) {
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

    var startDate = $(".start_date").find('input');
    var endDate = $(".end_date").find('input');
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
    var startDate = $(".start_date").find('input');
    var endDate = $(".end_date").find('input');
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
function camCouponListPopupOpen() {
    
    camCouponListPopup = $("#camCouponListPopup").ifvsfPopup({
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
    camCouponListPopup.ejDialog('destroy');
}

/**
 * 마케팅 쿠폰 등록 및 수정
 */
function saveCamCoupon() {
    
    var isValid = chkCalendarValidation() && camCouponValidation.confirm();
    if (isValid == true) {

        var couponData = {
              ridMktCamMst   : campaign.id
            , coupnNo        : $('#camCouponWrap #coupnNo').val()
            , coupnNm        : $('#camCouponWrap #coupnNm').val()
            , coupnActYn     : $('#camCouponWrap #coupnActYn').val()
            , useStartDt     : $('#camCouponWrap #useStartDt').val()
            , useEndDt       : $('#camCouponWrap #useEndDt').val()
            , coupnImgTypeCd : $('#camCouponWrap #coupnImgTypeCd').val()
            , coupnDesc      : $('#camCouponWrap #coupnDesc').val()
            , coupnUseGdnc1  : $('#camCouponWrap #coupnUseGdnc1').val()
            , coupnUseGdnc2  : $('#camCouponWrap #coupnUseGdnc2').val()
            , coupnUseGdnc3  : $('#camCouponWrap #coupnUseGdnc3').val()
            , coupnUseGdnc4  : $('#camCouponWrap #coupnUseGdnc4').val()
            , coupnUseGdnc5  : $('#camCouponWrap #coupnUseGdnc5').val()
            , coupnUseGdnc6  : $('#camCouponWrap #coupnUseGdnc6').val()
            , coupnUseGdnc7  : $('#camCouponWrap #coupnUseGdnc7').val()
            , coupnUseGdnc8  : $('#camCouponWrap #coupnUseGdnc8').val()
            , coupnUseGdnc9  : $('#camCouponWrap #coupnUseGdnc9').val()
            , coupnUseGdnc10 : $('#camCouponWrap #coupnUseGdnc10').val()
        };
        
        // 수정
        if (detail == true) {

            couponData.rid = $('#camCouponWrap #rid').val();
            
            $.ifvSyncPostJSON('<ifvm:action name="editCoupon"/>', couponData, 
            function(result) {
                if (result.success == true) {
                    alert('<spring:message code="M01026"/>');
                    getCouponDetail();
                }
            });
        }
        // 등록 
        else {
            $.ifvSyncPostJSON('<ifvm:action name="addCoupon"/>', couponData, 
            function(result) {
                if (result.success == true) {
                    alert('<spring:message code="M01026"/>');
                    getCouponDetail();
                }
            });
        }
        
        campaignCoupon = couponData;

        campaignCoupon.ridMktCamMst = campaign.id;
        campaignCoupon.dataStatus = getTaskStatusCode(campaignCoupon);
        
        diagram._selectedObject.data.campaignCoupon = campaignCoupon;
        diagram._selectedObject.taskDataStatus = getTaskStatusCode(campaignCoupon);
        
        // 팝업 종료
        camCouponPopupClose();
    }
}

/**
 * 쿠폰 삭제
 */
function removeCamCoupon() {
    
    if (confirm('<spring:message code="M01053"/>') == true) {
        
        $.ifvSyncPostJSON('<ifvm:action name="removeCoupon"/>', {
            rid : $('#camCouponWrap #rid').val()
        }, 
        function(result) {
            if (result.success == true) {
                alert('<spring:message code="L00034"/>');

                campaignCoupon.ridMktCamMst = campaign.id;
                campaignCoupon.dataStatus = 'D';
                
                diagram._selectedObject.data.campaignCoupon = campaignCoupon;
                diagram._selectedObject.taskDataStatus = getTaskStatusCode(campaignCoupon);
                
                campaignCoupon = {};
                detail = false;
                camCoupon_setDetil(false);
            }
        });
    }
}

/**
 * 쿠폰 사용안내 
 * (템플릿 사용 출력)
 */
function camCoupon_setDesc(data) {
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

    // 팝업 설정
    initMultiStagePopup();

    // 달력 설정 
    setChannelCalendar();
    
    // 초기 화면 설정
    initCamCouponData();
    
    //쿠폰 상세 조회
    getCouponDetail();
    
    camCouponValidation = $('#camCouponWrap').ifvValidation();
    
    // 쿠폰 이미지 코드 변경시 
    $('#coupnImgTypeCd').on('change', function() {
        setCoupnImg();
    });
    
    // 쿠폰 불러오기 버튼
    $('#camCouponListPopupOpenBtn').on('click', function() {
        camCouponListPopupOpen();
    });
    
    // 저장 버튼
    $('#camCouponSaveBtn').on('click', function() {
        saveCamCoupon();
    });
    
    // 삭제 버튼
    $('#removeCouponBtn').on('click', function() {
        removeCamCoupon();
    });
    
    // 닫기 버튼
    $('#camCouponPopCloseBtn').on('click', function() {
        camCouponPopupClose();
    });
    
    //쿠폰 제목을 30byte 이내로 제한 
    $('#coupnNm').keyup(function(a) {
    	var coupnNameLimitByte = 30;
        var getByte = getByteCheck('coupnNm');
        if (getByte > coupnNameLimitByte) {
            var k = cutMessage('coupnNm', coupnNameLimitByte);
            var cutMessageVal = $('#coupnNm').val().substring(0, k);
            $('#coupnNm').val(cutMessageVal);
            getByte = getByteCheck('coupnNm');
        }
    });
    
    setTimeout(function() {
        //popup 높이 맞추기
        new ifvm.PopupHeight({
            popupDivId : 'dialog',
            contentsId : 'dialogPopupWrap'
        });
        cDialog.refresh();
    }, 500);
    
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

<div id="camCouponWrap">

    <ifvm:input type="hidden" id="rid" names="rid" />
    <ifvm:input type="hidden" id="coupnActYn" names="coupnActYn" values="1"/>
    
    <div class="pop_inner_wrap form-horizontal">
        <div class="row qt_border group_box_bg">
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M02379"/></label>
            <div class="col-xs-2">
                <button class="btn_Load" id="camCouponListPopupOpenBtn">
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
	<%-- 저장버튼 --%>
    <button class="btn btn-sm btn_lightGray2" id="camCouponSaveBtn">
        <spring:message code="M00137"/>
    </button>
	<%-- 삭제버튼 --%>
    <button class="btn btn-sm btn_lightGray2" id='removeCouponBtn'>
        <i class="glyphicon glyphicon-check"></i>
        <spring:message code="L00029"/>
    </button>
    <%-- 닫기버튼 --%>
    <button class="btn btn-sm btn_lightGray2" id="camCouponPopCloseBtn">
        <spring:message code="M00441"/>
    </button>
</div>

<div id="camCouponListPopup"></div>