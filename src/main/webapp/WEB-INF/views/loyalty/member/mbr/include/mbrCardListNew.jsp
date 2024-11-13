<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var mbrOrangeCardList;
var gridIdmbrOrangeCardList;
var orangeCardRid = null;
var orangeCardStatus = null;
var orangeCardMbrType = null;
var orangeCardCprtCardCd= null;

//E1 오렌지 카드
/**
 * 2018.11.11 hy.jun
 * 다이소 카드로 변경
 */
function getmbrOrangeCardListSearch() {
    var ejGridOption = {
    		serializeGridData : function(data) {
      			if(typeof(gMbrDetail) != "undefined") {
      				data.rid = gMbrDetail.data.rid;
      			}
      			else if(typeof(gGroupDetail) != "undefined") {
      				data.rid = gGroupDetail.data.rid
      			}
    	            return data;
    	},
    	recordDoubleClick : function(args) {
	   	 	var data = args.data.rid;
        },
        rowSelected : function (args) {
        	orangeCardRid = args.data.rid;
        	orangeCardStatus = args.data.statCd;
        	orangeCardMbrType = args.data.mbrType;
        	orangeCardCprtCardCd = args.data.cprtCardCd;
        	fnButtonStatus();
        },
        dataUrl : '<ifvm:action name="getMbrListCard"/>',
        columns : [
      	  {
      		  field : 'cardNo', headerText : '<spring:message code="L00917"/>', headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'b.card_no'}
      	  },{
      		  field : 'cardKndNm', headerText : '<spring:message code="L00918"/>', headerTextAlign : 'center',
      		  customAttributes : {
     			  index : 'c.card_knd_nm'}
      	  },{
      		  field : 'cprtCard', headerText : '<spring:message code="L00919"/>', headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'd.mark_name'}
      	  },{
      		  field : 'cprtCardItemCd', headerText : '<spring:message code="L00710"/>', headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'cc.mark_name',
      			  title : '{{:birthDt}}'}
      	  },{
      		  field : 'stat', headerText : '<spring:message code="L00921"/>',headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'e.mark_name',
      			  title : '{{:memDiv}}'}
      	  },{
      		  field : 'regChnlCd', headerText : '<spring:message code="L00922"/>',headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'f.mark_name',
      			  title : '{{:tierNm}}'}
      	  },{
      		  field : 'createDate', headerText : '<spring:message code="L00923"/>',headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'b.create_date',
      			  title : '{{:emailAddr}}'}
      	  },{
      		  field : 'createBy', headerText : '<spring:message code="L00924"/>',headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'i.name',
      			  title : '{{:wbMemId}}'}
      	  },{
      		  field : 'loseDt', headerText : '<spring:message code="L00925"/>',headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'b.lose_dt',
      			  title : '{{:wbMemId}}'}
      	  },{
      		  field : 'loseTrTr', headerText : '<spring:message code="L00926"/>',headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'j.name',
      			  title : '{{:wbMemId}}'}
      	  },{
      		  field : 'cardLeavDate', headerText : '<spring:message code="L00927"/>',headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'b.card_leav_date',
      			  title : '{{:wbMemId}}'}
      	  },{
      		  field : 'rid', headerText : 'rid' ,visible: false,
      		  customAttributes : {
      			  index : 'b.rid' }
      	  },{
      		  field : 'statCd', headerText : 'statCd' ,visible: false,
      		  customAttributes : {
      			  index : 'b.stat'}
      	  },{
      		  field : 'mbrType', headerText : 'mbrType' ,visible: false,
      		  customAttributes : {
      			  index : 'c.mbr_type'}
      	  },{
      		  field : 'cprtCardCd', headerText : 'cprtCardCd',visible: false,
      		  customAttributes : {
      			  index : 'b.cprt_card_cd' }
      	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'b.create_date',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true

    };

    mbrOrangeCardList = $("#mbrOrangeCardListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    gridIdmbrOrangeCardList = $("#gridIdmbrOrangeCardList");
}


function fnOrangeCardNew(){

	$("#mbrOrangeCardDetailDialog").ifvsfPopup({
	    enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="mbrOrangeCardDetail"/>',
        contentType: "ajax",
        title: '<spring:message code="L00861"/>', //E1 오렌지카드
        width: '900px',
        close : 'mbrOrangeCardDetailPopClose'
	});

}

//카드 분실
function fnOrangeCardLose() {

	if(orangeCardMbrType=='20'&&orangeCardCprtCardCd!=''){

		var cardNum4 = prompt('<spring:message code="L01829"/>');
			var submitData = {rid: orangeCardRid  , cardNum4: cardNum4};
			 $.ifvSyncPostJSON('<ifvm:action name="loseOrangeCard"/>'
					 , submitData
			 , function(result) {
					   alert('<spring:message code="L00127"/>');
					   getmbrOrangeCardListSearch();
			 }, function(result) {
				   alert(result.message);
		 	} );

	}else{
		if(orangeCardRid!=null){
	     if(confirm('<spring:message code="L01830"/>')){
	    	 var submitData = {rid: orangeCardRid };
			 $.ifvSyncPostJSON('<ifvm:action name="loseOrangeCard"/>'
					 , submitData
			 , function(result) {
					   alert('<spring:message code="L00127"/>');
					   getmbrOrangeCardListSearch();
			 }, function(result) {
				   alert(result.message);
		 	} );


		   }
		}
	}
}

function fnButtonStatus(){

	orangeCardRid!=null&&(orangeCardMbrType=='20'&&orangeCardCprtCardCd!='' )
	? $('#orangeCardUnmaskingBtn').attr('disabled',false) : $('#orangeCardUnmaskingBtn').attr('disabled',true);

	orangeCardStatus!='20' ?$ ('#orangeCardLoseBtn').attr('disabled',true) :$('#orangeCardLoseBtn').attr('disabled',false);


}

//공통 조회 호출
function mbrOrangeCardListSearch() {
    $.fn.ifvmSubmitSearchCondition("mbrOrangeCardListSearchList", getmbrOrangeCardListSearch);
}

// 상세 팝업 화면 호출
function mbrOrangeCardDetailDtlPop(){

 $("#mbrOrangeCardDetailDialog").ifvsfPopup({
  enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="mbrOrangeCardDetail"/>?rid='+orangeCardRid,
        contentType: "ajax",
        title: '<spring:message code="L00652"/>',
        width: '1000px',
        close : 'mbrOrangeCardDetailPopClose'
    });
}

//팝업 닫기
function mbrOrangeCardDetailPopClose() {
	mbrOrangeCardDetailDialog._destroy();
}

//고객 상세 이동
function mbrOrangeCardDetailDtl() {
    qtjs.href('<ifvm:url name="mbrOrangeCardDetail"/>' + '?rid=' + rid);
}

function fnOrangeCardUnmaskingBtn() {
	var v_rid;
	if ($.fn.ifvmIsNotEmpty(mbrOrangeCardList.opt.gridControl.getSelectedRecords()[0])) {
		v_rid = mbrOrangeCardList.opt.gridControl.getSelectedRecords()[0].rid;
	}

	if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
            rid: v_rid ,
            type: 'card' ,
            field: 'cardNo'

        },
        function(result) {
        	if(result.message!=null){
        		var gridObj = mbrOrangeCardList.opt.gridControl;
            	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
            	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('cardNo'), result.message);
        	}
        });
	}

}
function checkButtnAuth(){
	var isAuth = false;
	var authArr = $.ifvmGetAuthInfo().authList;
	for(var i = 0 ; i < authArr.length ; i++){
		var authObj = authArr[i];
		var authName = authObj.authName;
		if(authName == 'E10010') isAuth = true;
	}
	if(!isAuth){
		$("#orangeCardUnmaskingBtn").remove();
	}
}
$(document).ready(function() {
	//마스킹해제 권한 체크
	//checkButtnAuth();
    mbrOrangeCardListSearch();
    window.top.setParentIframeHeight();

});

</script>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
        	
        	<ifvm:inputNew type="button" btnType="select" text="L00326" id="orangeCardUnmaskingBtn"  btnFunc="fnOrangeCardUnmaskingBtn" objCode="orangeCardUnmaskingBtn_obj"/>
        	<ifvm:inputNew type="button" btnType="select" text="L00078" id="orangeCardNewBtn"  btnFunc="fnOrangeCardNew"	className="dropHidBtn" objCode="orangeCardNewBtn_obj"/>
        	<ifvm:inputNew type="button" btnType="select" text="L00928" id="orangeCardLoseBtn"  btnFunc="fnOrangeCardLose" className="dropHidBtn" objCode="orangeCardLoseBtn_obj"/>
        	 
        </div>
    </div>
    <div id="mbrOrangeCardListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="mbrOrangeCardDetailDialog" class="popup_container"></div>

