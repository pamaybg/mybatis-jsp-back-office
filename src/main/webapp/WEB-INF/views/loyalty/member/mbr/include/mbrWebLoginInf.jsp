<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page_btn_area">
    <div class="col-xs-7">
        <span><spring:message code="로그인계정" /></span>
    </div>
    <div class="col-xs-5 searchbtn_r">
		<ifvm:inputNew type="button" text="로그인 비밀번호 변경" id="loginChngPwdBtn"
			btnFunc="loginChngPwdFn" objCode="mbrWebLoginInfoPwdChg_OBJ" />
	</div>
</div>
<div>
    <div id="custLoginInfoListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="pwdChangePop2"></div>

<script type="text/javascript">
var agreRid=null;
var agreTypeCd=null;
var ridVal =null;

function getCustLoginInfo(){

    var ejGridOption = {
        serializeGridData : function(data) {
            data.rid = custRid;
            return data;
        },loadComplete : function(obj){
        	custLoginInfoListGrid.opt.gridControl.selectRows(0);
        },
        rowSelected : function(args) {
        },
        dataUrl : '<ifvm:action name="getCustLoginInfo"/>',

        columns : [
        	{
                field : 'repYn', headerText : '대표여부', headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'loginTypeCd'}
            },{
              field : 'loginTypeCdNm', headerText : '유형', headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'loginTypeCd'}
          },{
              field : 'userId', headerText : '로그인 계정', headerTextAlign : 'center', textAlign : 'left'
          },{
              field : 'createDate', headerText : '계정 등록일', headerTextAlign : 'center', textAlign : 'center',
          }
        ],

        requestGridData : {
          nd   : new Date().getTime(),
          rows : 10,
          sidx : '4',
          sord : 'desc',
          _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        tempId: 'ifvGridSimplePageTemplete',
        radio: true
    };

    custLoginInfoListGrid = $("#custLoginInfoListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//로그인 실패 초기화
function loginFailInitFn(){

	if(custLoginInfoListGrid.opt.gridControl.getSelectedRecords().length == 0){
		alert('<spring:message code="M00285"/>');
		return;
	}
	
	if(custLoginInfoListGrid.opt.gridControl.getSelectedRecords()[0].failCnt=="0"){
		alert('이미 초기화 상태입니다.');
		return;
	}
	
	var confirmYn = confirm("초기화하시겠습니까?");
	if(!confirmYn) {
		return;
	}	
	
	$.ifvSyncPostJSON(	'<ifvm:action name="loginFailCntInit"/>',
	{
		rid : custLoginInfoListGrid.opt.gridControl.getSelectedRecords()[0].rid
	},function(result) {
		alert("초기화 되었습니다.");
		custLoginInfoListGrid._doAjax();
	});
}

//로그인 패스워드 변경
function loginChngPwdFn(){
	
	if(custLoginInfoListGrid.opt.gridControl.getSelectedRecords().length == 0){
		alert('<spring:message code="M00285"/>');
		return;
	}
	
	if(custLoginInfoListGrid.opt.gridControl.getSelectedRecords()[0].loginTypeCd !="WEB_ID"){
		alert('웹아이디만 임시비밀번호 발급이 가능합니다.');
		return;
	}
	
	ridVal = custLoginInfoListGrid.opt.gridControl.getSelectedRecords()[0].rid;
	
	$("#pwdChangePop2").ifvsfPopup({
	        enableModal : true,
	        enableResize : false,
	        contentUrl : '<ifvm:url name="loginPwdChngPop"/>',
	        contentType : "ajax",
	        title : "<spring:message code="로그인 비밀번호 변경"/>",
	        width : '600px',
	        close : 'pwdChangePop2Close',
	     });
	}

function pwdChangePop2Close(){
	pwdChangePop2._destroy();
}
$(document).ready(function(){
    getCustLoginInfo();
});

</script>