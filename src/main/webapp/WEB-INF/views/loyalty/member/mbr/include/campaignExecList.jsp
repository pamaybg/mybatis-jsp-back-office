<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
    <div class="col-xs-7">
        <span><spring:message code="캠페인 이력" /></span>
    </div>
</div>
    <div id="campaignExecListGrid" class="white_bg grid_bd0"></div>
 
<script type="text/javascript">
function getCampaignExecListGridList(){

    var ejGridOption = {
        serializeGridData : function(data) {
            data.mbrNo = mbr_no_cam;
            data.userId = user_id;
            return data;
        },
        dataUrl : '<ifvm:action name="getCampaignExecList"/>',

        columns : [
            {
              field : 'dispNo', headerText : '캠페인 번호', width: '60', headerTextAlign : 'center', textAlign : 'center', customAttributes : {index : 'disp_no',searchable : true}
            }
            ,{
              field : 'camNm', headerText : '캠페인명', width: '170', headerTextAlign : 'center', textAlign : 'left', customAttributes : {index : 'cam_nm',searchable : true}
            }
            ,{
                field : 'camTypeCdNm', headerText : '캠페인 구분', width: '70', headerTextAlign : 'center', textAlign : 'center', customAttributes : { searchable: true, index : 'cc.MARK_NAME'}
              }
            ,{
                field : 'camStatusCdNm', headerText : '상태', width: '80', headerTextAlign : 'center', textAlign : 'center', customAttributes : { searchable: true, index : 'cc2.MARK_NAME'}
              }
            ,{
                field : 'camStartDD', headerText : '시작일', width: '60', headerTextAlign : 'center', textAlign : 'center', customAttributes : {index : 'cam_start_dd'}
              }
            ,{
                field : 'camEndDD', headerText : '종료일', width: '60', headerTextAlign : 'center', textAlign : 'center', customAttributes : {index : 'cam_end_dd'}
              }
            ,{
                field : 'chnlTypeCdNm', headerText : '채널', width: '60', headerTextAlign : 'center', textAlign : 'center', customAttributes : {index : 'CAM_CHNL_CD'}
              }
            ,{
                field : 'batSendStatusNm', headerText : '전송결과', width: '60', headerTextAlign : 'center', textAlign : 'center', customAttributes : {index : 'batSendStatus'}
              }
            /*,{
                field : 'revSucesYn', headerText : '수신여부', width: '60', headerTextAlign : 'center', textAlign : 'center', customAttributes : {index : 'send_suces_yn'}
              }*/
            ,{
                field : 'openSucesYn', headerText : '오픈여부', width: '60', headerTextAlign : 'center', textAlign : 'center', customAttributes : {index : 'openSucesYn'}
              }
            ,{
                field : 'actAmt', headerText : '구매금액', width: '60', headerTextAlign : 'center', textAlign : 'center', customAttributes : {index : ''}
             }
            ,{
                field : 'rid', headerText : 'rid', headerTextAlign : '',visible: false
             }
        ],

        requestGridData : {
            nd   : new Date().getTime(),
          rows : 10,
          sidx : '1',
          sord : 'desc',
          _search : false
        },
        rowList : [10,25,50,100],
        ajaxGridOptions : {async : false},
        radio: true

    };

    campaignExecListGrid = $("#campaignExecListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
    getCampaignExecListGridList();

});

</script>