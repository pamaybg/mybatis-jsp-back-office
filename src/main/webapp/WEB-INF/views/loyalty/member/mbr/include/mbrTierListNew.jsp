<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="등급 이력" /></span>
	</div>
	 <div class="col-xs-5 searchbtn_r">
		 	<ifvm:inputNew type="button" id="tierHistListPopBtn" text="등급변경이력"  objCode="tierHistListPopBtn_OBJ"/>
		 <%--<ifvm:inputNew type="button" id="tierBenefitHistPopBtn" text="등급혜택이력" objCode="tierBenefitHistListPopBtn_OBJ" />--%>
			<ifvm:inputNew type="button" id="modifyTierBtn" text="등급수동변경" objCode="modifyTierBtn_OBJ"/>
        </div>
</div>
    <div id="TierListGrid" class="white_bg grid_bd0"></div>
 

<div id="modifyTierPop" class="popup_container"></div>
<div id="tierHistListPop" class="popup_container"></div>
<div id="tierBenefitHistPop" class="popup_container"></div>

<script type="text/javascript">
var tierGrpRid = null;
var tierRid = null;
var tierNm = null
var tierGrpNm = null;
var upKeepMm = null;
var mbrTierCol = null;
var prevTierRid = null;
var prevTierNm = null;
var tierHistRid = null;
var seqNo = null;
// 이전페이지(mbrDetailNewPage.jsp)에서 얻어온 회원rid 값을 초기화 
var mbrRid = mbr_rid; 


function getTierList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = mbr_rid;
			return data;
		},rowSelected : function(args){
			tierGrpNm = args.data.tiersGrpNm;
			tierGrpRid = args.data.tierGrpRid;
			tierRid    = args.data.tierRid;
			prevTierRid = args.data.tierRid;
			prevTierNm  = args.data.tierNm;
			tierNm    = args.data.tierNm;
			upKeepMm = args.data.upKeepMm;
			mbrTierCol = args.data.mbrTierCol;
			tierHistRid = args.data.rid;
			seqNo	= args.data.seqNo;
       	},
        dataUrl : '<ifvm:action name="getMbrTierListNew"/>',

        columns : [
        	{
      		  field : 'tiersGrpNm', headerText : '등급그룹', headerTextAlign : 'center', width:'230px', textAlign : 'left', customAttributes :{searchable : true}
      	  },{
    		  field : 'tierNm', headerText : '등급', headerTextAlign : 'center', textAlign : 'center',width:'120px', customAttributes :{searchable : true}
    	  },{
    		  field : 'tierTypeCd', headerText : '등급코드', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
    	  },{
      		  field : 'tierCalcDate', headerText : '산정일', headerTextAlign : 'center', textAlign : 'center'
      	  },{
    		  field : 'vaildStartDt', headerText : '유효시작일', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'validEndDt', headerText : '유효종료일', headerTextAlign : 'center', textAlign : 'center'
    	  }/* ,{
    		  field : 'createBy', headerText : '등록자', headerTextAlign : 'center', textAlign : 'center'
    	  } */
    	  ,{
    		  field : 'tierChgTypeCdNm', headerText : '등급적용유형', headerTextAlign : 'center', textAlign : 'center', width:'130px', customAttributes :{ index : 'tierChgTypeCd'}
    	  },{
    		  field : 'createDate', headerText : '등록일', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'tierGrpRid', headerText : 'tierGrpRid',visible : false 
    	  },{
    		  field : 'tierRid', headerText : 'tierRid',visible : false 
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  },{
    		  field : 'upKeepMm', headerText : 'upKeepMm',visible : false 
    	  },{
    		  field : 'mbrTierCol', headerText : 'mbrTierCol',visible : false 
    	  },{
    		  field : 'seqNo', headerText : 'seqNo',visible : false 
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '1,2',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true,
    };

    TierListGrid = $("#TierListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function modifyTiers() {
	if (TierListGrid.opt.gridControl.getSelectedRecords().length == 0) {
		 alert('<spring:message code="목록을 선택해주세요."/>');
		 return;
    }
	$("#modifyTierPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="modifyTierPop"/>',
        contentType: "ajax",
        title: '등급 변경',
        width: 800,
        close : 'modifyTierClose'
	});
}

function modifyTierClose() {
	modifyTierPop._destroy();
}

function tierHistListPopup() {
	if ($.fn.ifvmIsEmpty(TierListGrid.opt.gridControl.getSelectedRecords()[0])) {
		 alert('<spring:message code="목록을 선택해주세요."/>');
		 return;
   }
	$("#tierHistListPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tierHistListPop"/>',
        contentType: "ajax",
        title: '등급 이력',
        width: 1000,
        close : 'tierHistListClosePop'
	});
}

function tierHistListClosePop() {
	tierHistListPop._destroy();
}

//  등급혜택이력 팝업 함수
function tierBenefitHistPopup() {
	$("#tierBenefitHistPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tierBenefitHistPop"/>',
        contentType: "ajax",
        title: '등급 혜택 이력',
        width: 1000,
        close : 'tierBenefitHistPopClose'
	});
}



$(document).ready(function(){
	getTierList();

	
	$("#modifyTierBtn").click(function() {
	
		modifyTiers();
	});
	
	$("#tierHistListPopBtn").click(function() {
		
		tierHistListPopup();
	});
	
	$("#tierBenefitHistPopBtn").click(function(){
		tierBenefitHistPopup();
	});
});

</script>