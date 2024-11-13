<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page_btn_area">
    <div class="col-xs-7">
        <span><spring:message code="모바일 디바이스 이력" /></span>
    </div>
     <div class="col-xs-5 searchbtn_r">
            <%-- <ifvm:inputNew type="button"  text="설치이력" id="btnInstallHist"  objCode="btnInstallHist_OBJ"/> --%>
    </div>
</div>
<div>
    <div id="custMobileLoginInfoListGrid" class="white_bg grid_bd0"></div>
</div>
    <div id="mbrMobileLoginPopup" class="popup_container"></div>    
    


<script type="text/javascript">
var agreRid=null;
var agreTypeCd=null;
var v_rid = null;

/* function btnInstallHistFun() {
    if ($.fn.ifvmIsNotEmpty(custMobileLoginInfoListGrid.opt.gridControl.getSelectedRecords()[0])) {
        v_rid = custMobileLoginInfoListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M00004"/>');
    }
    if ($.fn.ifvmIsNotEmpty(v_rid)) {
            $("#mbrMobileLoginPopup").ifvsfPopup({
                enableModal : true,
                enableResize: false,
                contentUrl: '<ifvm:url name="mbrMobileLoginPop"/>',
                contentType: "ajax",
                title: '설치이력',
                width: 800,
                close : 'mbrMobileLoginPopClose'
            });
    }
} */

function mbrMobileLoginPopClose() {
    mbrMobileLoginPopup._destroy();
} 

function getMobileCustLoginInfo(){

    var ejGridOption = {
        serializeGridData : function(data) {
            data.rid = custRid;
            return data;
        },
        rowSelected : function(args) {
        },
        dataUrl : '<ifvm:action name="getMobileCustLoginInfo"/>',

        columns : [
       		{
              field : 'deviceUuid', headerText : '디바이스 아이디', headerTextAlign : 'center', textAlign : 'center', width: '80px'
          },
          {
              field : 'deviceTypeCdNm', headerText : '디바이스 유형', headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'deviceTypeCd'}, width: '60px'
          },
          {
              field : 'deviceAgreYn', headerText : '기기동의 여부', headerTextAlign : 'center', textAlign : 'center' , width: '50px'
          },
          {
              field : 'deviceArgeDate', headerText : '기기동의 변경일', headerTextAlign : 'center', textAlign : 'center', width: '80px'
          },
          {
              field : 'verNo', headerText : '앱버전', headerTextAlign : 'center', textAlign : 'center', width: '40px'
          }
          ,{
              field : 'regDate', headerText : '최근사용일', headerTextAlign : 'center', textAlign : 'center', width: '80px'
          },
          {
              field : 'token', headerText : '모바일 토큰 ', headerTextAlign : 'center', textAlign : 'left', width: '200px'
          },
          {
              field : 'createDate', headerText : '등록일', headerTextAlign : 'center', textAlign : 'center', width: '80px'
          }
          ,{
              field : 'rid', headerText : 'rid', visible : false
          }
        ],

        requestGridData : {
          nd   : new Date().getTime(),
          rows : 10,
          sidx : '1',
          sord : 'desc',
          _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true,
        tempId : 'ifvGridNoneLeftTemplete',
    };

    custMobileLoginInfoListGrid = $("#custMobileLoginInfoListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function(){
    getMobileCustLoginInfo();
    
    /* $("#btnInstallHist").click(function(){
        btnInstallHistFun();
    }); */
});

</script>