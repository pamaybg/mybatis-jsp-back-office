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
function getmbrOrangeCardListSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
	     var data = mbrOrangeCardList.getRowData()[data-1];
	     rid = data.rid;
        },
        onSelectRow : function (data) {
        	orangeCardRid=data.rid;
        	orangeCardStatus = data.statCd;
        	orangeCardMbrType = data.mbrType;
        	orangeCardCprtCardCd = data.cprtCardCd;
        	fnButtonStatus();
        },
       serializeGridData : function( data ){

    	   if(typeof(gMbrDetail) != "undefined"){
 				data.rid = gMbrDetail.data.rid;
 			}else if(typeof(gGroupDetail) != "undefined"){
 				data.rid = gGroupDetail.data.rid
 			}
            return data;
        },
        loadComplete : function(obj){
        	console.log(obj);
        	$('#orangeCardUnmaskingBtn').attr('disabled',true);
        	$('#orangeCardLoseBtn').attr('disabled',true);
        	if(typeof(gGroupDetail) != "undefined"){ //단체카드 리스트 일때, 제휴단체, 법인택시일경우에만 신규 등록이 가능
				if(gGroupDetail.data.memDiv != "A" &&  gGroupDetail.data.memDiv != "C"){
					$("#orangeCardNewBtn").prop('disabled',true);
				}
        	}
        	if(typeof(gMbrDetail) != "undefined"){
        		if(gMbrDetail.data.mbrStatCd == "20"){
        			$(".dropHidBtn").prop("disabled",true);
        		}
        	}
        	window.top.setParentIframeHeight();
        },
        url : '<ifvm:action name="getMbrOrangeCardList"/>',
        colNames:[
                   '<spring:message code="L00917" />',
                   '<spring:message code="L00918" />',
                   '<spring:message code="L00919" />',
                   '<spring:message code="L00710" />',
                   '<spring:message code="L00921" />',
                   '<spring:message code="L00922" />',
                   '<spring:message code="L00923" />',
                   '<spring:message code="L00924" />',
                   '<spring:message code="L00925" />',
                   '<spring:message code="L00926" />',
                   '<spring:message code="L00927" />',

                   'rid',
                   'statCd',
                   'mbrType',
                   'cprtCardCd'
                 ],
        colModel:[
             { name:'cardNo',   		index:'b.card_no',  		resizable : true, align:'center',  	width:'150px' },
             { name:'cardKndNm',   		index:'c.card_knd_nm',  	resizable : true, align:'center',   width:'100px' },
             { name:'cprtCard',   		index:'d.mark_name',  		resizable : true, align:'center',   width:'100px' },
             { name:'cprtCardItemCd',   index:'cc.mark_name',  		resizable : true, align:'center',   width:'100px' },

             { name:'stat',   			index:'e.mark_name',  		resizable : true, align:'center',   width:'100px' },
             { name:'regChnlCd',   		index:'f.mark_name',  		resizable : true, align:'center',   width:'100px' },
             { name:'createDate',   	index:'b.create_date',  	resizable : true, align:'center',  	formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} ,  width:'150px' },
             { name:'createBy',   		index:'i.name',  			resizable : true, align:'center',   width:'100px' },
             { name:'loseDt',   		index:'b.lose_dt',  		resizable : true, align:'center',  	formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} ,  width:'150px' },
             { name:'loseTrTr',   		index:'j.name',  			resizable : true, align:'center',   width:'100px' },
             { name:'cardLeavDate',   	index:'b.card_leav_date',  	resizable : true, align:'center',  	formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} ,  width:'150px' },

             { name:'rid',    			index:'b.rid',    		hidden : true},
             { name:'statCd',    		index:'b.stat',    		hidden : true},
             { name:'mbrType',    		index:'c.mbr_type',    	hidden : true},
             { name:'cprtCardCd',    	index:'b.cprt_card_cd', hidden : true}
        ],
        sortname: 'b.create_date',
        autowidth : true ,
        sortorder: "desc",

        radio : true
    };

    mbrOrangeCardList = $("#mbrOrangeCardListGrid").ifvGrid({ jqGridOption : jqGridOption });
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
function fnOrangeCardLose(){

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
	if ($.fn.ifvmIsNotEmpty(mbrOrangeCardList.getCheckedGridData()[0])) {
		v_rid = mbrOrangeCardList.getCheckedGridData()[0].rid;
	}

	if ($.fn.ifvmIsNotEmpty(v_rid)) {
	        $.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	            rid: v_rid ,
	            type: 'card' ,
	            field: 'cardNo'

	        },
	        function(result) {
	        	if(result.message!=null){
		        	var rowid = mbrOrangeCardList.getRadioSelectedRowId();
		        	mbrOrangeCardList.opt.grid.setCell( rowid, 'cardNo' , result.message );
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
        	<ifvm:inputNew type="button" btnType="select" text="L00326" id="orangeCardUnmaskingBtn"  btnFunc="fnOrangeCardUnmaskingBtn" objCode="orangeCardUnmaskingBtn_OBJ"/>
        	<ifvm:inputNew type="button" btnType="select" text="L00078" id="orangeCardNewBtn"  btnFunc="fnOrangeCardNew"	className="dropHidBtn" objCode="orangeCardNewBtn_OBJ"/>
        	<ifvm:inputNew type="button" btnType="select" text="L00928" id="orangeCardLoseBtn"  btnFunc="fnOrangeCardLose" className="dropHidBtn" objCode="orangeCardLoseBtn_OBJ"/>
        </div>
    </div>
    <div id="mbrOrangeCardListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="mbrOrangeCardDetailDialog" class="popup_container"></div>

