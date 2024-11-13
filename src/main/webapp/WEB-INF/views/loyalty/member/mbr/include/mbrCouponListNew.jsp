<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L02932" /></span>
	</div>
<!-- 	<div class="col-xs-5 searchbtn_r"> -->
<%-- 		<ifvm:inputNew type="button" text="쿠폰 이력 보기" nuc="true" id="mbrCouponHistPopBtn"  btnFunc="mbrCouponHistPopFn"  objCode="mbrCouponHistPopBtn_OBJ" /> --%>
 			<%-- <ifvm:inputNew type="button" text="쿠폰 수동 발급" nuc="true" id="mbrCouponSavePopBtn"  btnFunc="mbrCouponSavePopFn"  objCode="mbrCouponSavePopBtn_OBJ"/>
 			<ifvm:inputNew type="button" text="쿠폰 재발급" nuc="true" id="mbrCouponReiSavePopBtn"  btnFunc="mbrCouponReiSavePopFn"  objCode="mbrCouponSavePopBtn_OBJ"/> --%>
<%-- 		<ifvm:inputNew type="button" text="쿠폰 사용" nuc="true" id="mbrCouponUsePopBtn"  btnFunc="mbrCouponUsePopFn" /> --%>
<%-- 		<ifvm:inputNew type="button" text="쿠폰 발급 취소" nuc="true" id="mbrCouponSaveCnclPopBtn"  btnFunc="mbrCouponSaveCnclPopFn" /> --%>
<%-- 		<ifvm:inputNew type="button" text="쿠폰 사용 취소" nuc="true" id="mbrCouponUseCnclPopBtn"  btnFunc="mbrCouponUseCnclPopFn" /> --%>

<!--      </div> -->
     <div class="col-xs-5 searchbtn_r">
       	<%--<ifvm:inputNew type="button" text="상세 이력" nuc="true" id="mbrCouponTxnListSearch"  btnFunc="mbrCouponTxnListSearch" objCode="mbrCouponTxnDetail_OBJ"/>--%>
       	<%-- <ifvm:inputNew type="button" text="(구)자사몰 쿠폰 조회" nuc="true" id="mbrCouponListSearch"  btnFunc="mbrCouponListSearchPop" objCode="mbrCouponTxnOldDetail_OBJ"/>
     	<ifvm:inputNew type="button" text="자사몰 쿠폰 조회" nuc="true" id="mbrNewCouponListSearch"  btnFunc="mbrNewCouponListSearchPop" objCode="mbrCouponTxnNewDetail_OBJ"/> --%>
     	<%--<ifvm:inputNew type="button" text="쿠폰 수동 발급" nuc="true" id="mbrCouponSavePopBtn"  btnFunc="mbrCouponSavePopFn"  objCode="mbrCouponTxnIssue_OBJ"/>--%>
<%--  		<ifvm:inputNew type="button" text="쿠폰 재발급" nuc="true" id="mbrCouponReiSavePopBtn"  btnFunc="mbrCouponReiSavePopFn"  objCode="mbrCouponSavePopBtn_OBJ"/>
 --%>       </div>
</div>
<div class="row">
            <br>
            <div class = "col-xs-12">
                <div class = "col-xs-3">
	                 <div class="col-xs-4">
		                 <select id="searchSelBox">
		                 	<option value="cpnNo">쿠폰번호</option>
		                 	 <option value="cponNm">쿠폰명</option>
<!-- 		                 	 <option value="ofrStatCd">상태</option> -->
		                   	 <!-- <option value="cpnExpiryState">상태</option> -->		                 	
		                 </select>
	                 </div>
<!-- 	                 <div id="ofrStat" class="col-xs-7" style="margin-left:5px;"> -->
<!-- 			                         	<select id="ofrStatName"> -->
<!-- 				                        	<option value="A">사용가능</option> -->
<!-- 				                         	<option value="D">기간만료</option> -->
<!-- 				                         	<option value="U">사용완료</option> -->
<!-- 				                         	<option value="C">발급취소</option> -->
<!-- 				                        </select> -->
<!-- 			         </div> -->
	                 <div class="col-xs-7" id="searchFieldDiv" style="margin-left:5px;">
		                 <input type="text" id="searchVal" name="searchVal"/>
	                 </div>
                 </div>    
                 <div class = "col-xs-9">
			        <ifvm:inputNew type="dateTerm" startDto="startDt" endDto="endDt" startId="startDt" endId="endDt" required="false" label="발급일자" labelClass="1" conClass="4" /> 
		            <div class = "col-xs-3">
		            	 <ifvm:inputNew type="select" label="상태" labelClass="2" names="cponStCd" id="cponStCd" conClass="10"/>
<!-- 		            	     <option value="All">전체</option>		                 	 -->
<!-- 	                   	 	 <option value="A">사용가능</option>		                 	 -->
<!--                	  	     	 <option value="U">사용완료</option>		                 	 -->
<!-- 	                   	  	 <option value="AO">기간만료</option>		   -->
<!-- 	                   	  	 <option value="C">발급취소</option>		                 	 -->
		           	</div>
			        <div class="col-xs-2 control_content">
						<ifvm:inputNew type="button" id="searchCouponBtn"  text="검색" objCode="mbrCouponListNewSearchBtn_OBJ"/>
			        </div>
	 		     </div>
           </div>
         <br>
       <br>
</div>

    <div id="mbrcouponGridList" class="white_bg grid_bd0"></div>
    <div id="mbrCouponSavePopCon" class="popup_container"></div>
    <div id="mbrCouponReiSavePopCon" class="popup_container"></div>
    <div id="mbrCouponHistPop" class="popup_container"></div>
    <div id="mbrCouponUsePopCon" class="popup_container"></div>
    <div id="mbrCouponSaveCnclPopCon" class="popup_container"></div>
    <div id="mbrCouponUseCnclPopCon" class="popup_container"></div>
    <div id="mbrCouponhistCon" class="popup_container"></div>
    <div id="mbrNewCouponhistCon" class="popup_container"></div>
    <div id="mbrCouponTxnhistCon" class="popup_container"></div>




<script type="text/x-jsrender" id="cntTemplate">
{{if cpnMaxCnt == 0 }}
		{{:cpnAvlCnt}}/무제한
	{{else}}
		{{:cpnAvlCnt}}/{{:cpnMaxCnt}}
	{{/if}}
</script>

<script type="text/javascript">
var mbrCouponRid=null;
var cpnNo = null;
var cpnStateCd = null;
var reqObj = {};
var issueDt= null;
var validStartDay =null
function getCouponHistList(startDt, endDt, searchVal){
	
    var ejGridOption = {
    	serializeGridData : function(data) {
			data.ridMbr = mbr_rid;
			//data.intRidMbr = mbr_rid;
			data.startDt = startDt;
			data.endDt = endDt;

			if( $('#searchSelBox').val() == 'cpnNo' ) {
				data.cpnNo = searchVal;
			} else if( $('#searchSelBox').val() == 'cponNm' ) {
				data.cponNm = searchVal;
			} /* else if( $('#searchSelBox').val() == 'ofrStatCd' ) {
				data.cponStCd = $("#ofrStatName").val();
			}*/

			if($('#cponStCd').val() != null){
				data.cponStCd = $('#cponStCd').val();
			}
		
			return data;
		},rowSelected : function(args) {
			//mbrCouponRid = args.data.rid;
			//cpnNo = args.data.usrCponSeq;
			//cpnStateCd = args.data.cpnStateCd;
			//reqObj = args.data;
			//issueDt=reqObj.cpnIssueDt;
			//validStartDay=reqObj.expiryDate.substring(0,10);
			
		},loadComplete : function(obj){
			//mbrCouponRid=null;
			//cpnNo = null;
			//cpnStateCd = null;
			reqObj = {};
			//mbrcouponGridList.opt.gridControl.selectRows(0);
		},
        dataUrl : '<ifvm:action name="getCouponHistList"/>',

        columns : [
        	{
                field : 'usrCponSeq', headerText : '쿠폰 번호', headerTextAlign : 'center', textAlign : 'center', width: '7%', customAttributes :{searchable : true}
            },
         	{
      		  field : 'cponNm', headerText : '쿠폰명', headerTextAlign : 'center', textAlign : 'left', width: '17%',customAttributes :{searchable : true}
      	  	}
           ,{
              field : 'cponTpCdNm', headerText : '상세', headerTextAlign : 'center', textAlign : 'center', width: '6%', customAttributes :{index : 'cponTpCd'}
         	}
            ,{
                field : 'fstRegDt', headerText : '발급일자', headerTextAlign : 'center', textAlign : 'center',width: '9%'
            }
            ,{
                field : 'discnt', headerText : '할인액(율)', headerTextAlign : 'center', textAlign : 'right',width: '6%', format : '{0:n0}'
            },
            {
                field : 'lmtPrc', headerText : '최소구매금액', headerTextAlign : 'center', textAlign : 'right',width: '6%', format : '{0:n0}'
            }
            ,{
                field : 'useValidDt', headerText : '사용기한', headerTextAlign : 'center', textAlign : 'center',width: '11%'
            }
			,{
                field : 'useDt', headerText : '사용일자', headerTextAlign : 'center', textAlign : 'center',width: '9%'
            }
			,{
                field : 'publEaCd', headerText : '무제한쿠폰 여부', headerTextAlign : 'center', textAlign : 'center',width: '6%'
            }
            ,{
            	field : 'cponStCdNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center',width: '6%', customAttributes :{  index : 'cponStCd'}
            }
//       	  ,{
//     		  field : 'ofrTypeNm', headerText : '유형', headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'ofrType'}

//     	  }
//     	  ,{
//     		  field : 'createDate', headerText : '등록일자', headerTextAlign : 'center', textAlign : 'center',width: '140px'

//     	  }
    	  /* ,{
              field : 'cpnAvlCnt', headerText : '사용 횟수', headerTextAlign : 'center',textAlign: 'right', format : '{0:n0}',
          },{
    		  field : 'acrlCnclNo', headerText : '적립 취소번호', headerTextAlign : 'center', textAlign : 'center',

    	  },{
    		  field : 'useCnclNo', headerText : '사용 취소번호', headerTextAlign : 'center', textAlign : 'center',

    	  }
    	  ,{
    		  field : 'rid', headerText : 'rid', headerTextAlign : '' ,visible: false,
    	  }
    	  ,{
    		  field : 'cpnStateCd', headerText : 'cpnStateCd', headerTextAlign : '' ,visible: false,
    	  }
    	  ,{
    		  field : 'ridUsedChnl', headerText : 'ridUsedChnl', headerTextAlign : '' ,visible: false,
    	  }
    	  ,{
    		  field : 'ridIssChnl', headerText : 'ridIssChnl', headerTextAlign : '' ,visible: false,
    	  }
    	  ,{
    		  field : 'usedChnlNo', headerText : 'usedChnlNo', headerTextAlign : '' ,visible: false,
    	  }
    	  ,{
    		  field : 'issChnlNo', headerText : 'issChnlNo', headerTextAlign : '' ,visible: false,
    	  }*/
        ],

        requestGridData : {
			  sidx : 'createDate',
        	  sord : 'desc'

          },
          gridDataInit: true,
          isHorizontalScroll : true,
          radio: true,
          tempId: 'ifvGridSimplePageTemplete5'
    };

    mbrcouponGridList = $("#mbrcouponGridList").ifvsfGrid({ ejGridOption : ejGridOption });
}

function searchChnlName(startDt,endDt){
    var searchVal = $('#searchVal').val();
    getCouponHistList(startDt, endDt, searchVal);
}


function mbrCouponListSearchPop(){
	$("#mbrCouponhistCon").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="mbrCouponSearchListPop"/>',
        contentType: "ajax",
        title: '(구)자사몰 쿠폰 조회',
        width: 1700,
        maxWidth : 1700,
        close : 'mbrCouponListSearchPopClose'
    });
}

function setCalendar() {
	 var startDate = $('#startDt');
	 var endDate = $('#endDt');
	 //오늘날짜
	 startDate.val($.ifvGetTodayDate());
	 startDate.val($.ifvGetNewDate('y01', -1).newDateS);
	 //오늘부터 한달 뒤
	 endDate.val($.ifvGetTodayDate());
	  
	 startDate.ifvDateChecker({
	  maxDate : endDate
	 });

	 endDate.ifvDateChecker({
	  minDate : startDate
	 });
}
function mbrCouponTxnListSearch(){
	
	if(mbrCouponRid==null) {
		alert("목록을 선택해주세요.");
		return;
	}
	$("#mbrCouponTxnhistCon").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="mbrCouponTxnHistPop"/>',
        contentType: "ajax",
        title: '상세이력',
        width: 1300,
        maxWidth : 1300,
        close : 'mbrCouponTxnListPopClose'
    });
}

function mbrNewCouponListSearchPop(){

	
	$("#mbrNewCouponhistCon").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="mbrNewMallCouponListPop"/>',
        contentType: "ajax",
        title: '자사몰 쿠폰 조회',
        width: 1700,
        maxWidth : 1700,
        close : 'mbrNewCouponListSearchPopClose'
    });
}


function mbrCouponTxnListPopClose(){
	mbrCouponTxnhistCon._destroy();
}
function mbrNewCouponListSearchPopClose() {
	mbrNewCouponhistCon._destroy();
}


function mbrCouponUsePopFn(){
	if(mbrCouponRid==null) {
		alert("목록을 선택해주세요.");
		return;
	}
	if(cpnStateCd=='U'){
		alert("이미 사용된 쿠폰 입니다.");
		return;
	}
	if(cpnStateCd=='C'){
		alert("발급 취소된 쿠폰 입니다.");
		return;
	}
	$("#mbrCouponUsePopCon").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="mbrCouponUsePop"/>',
        contentType: "ajax",
        title: '쿠폰 사용',
        width: 1000,
        close : 'mbrCouponUseClosePop'
    });

}


function mbrCouponSaveCnclPopFn(){
	if(mbrCouponRid==null) {
		alert("목록을 선택해주세요.");
		return;
	}
	if(cpnStateCd=='U'){
		alert("이미 사용된 쿠폰 입니다.");
		return;
	}
	if(cpnStateCd=='C'){
		alert("발급 취소된 쿠폰 입니다.");
		return;
	}
	var url = '<ifvm:action name="saveCnclMbrCoupon"/>';
	reqObj.chnlNo = reqObj.issChnlNo;
	$.ifvSyncPostJSON(url,reqObj,function(result){
		if(result.success){
			alert('쿠폰 발급 취소 되었습니다.');
			getCouponHistList();
		}else{
			if(result.message) alert(result.message);
			else alert('쿠폰 발급 취소에 실패 하였습니다.');
		}
	},function(result){
		alert('쿠폰 발급 취소에 실패 하였습니다.');
	});
}


function mbrCouponUseCnclPopFn(){
	if(mbrCouponRid==null) {
		alert("목록을 선택해주세요.");
		return;
	}
	if(cpnStateCd=='A'){
		alert("사용 되지 않은 쿠폰 입니다.");
		return;
	}
	if(cpnStateCd=='C'){
		alert("발급 취소된 쿠폰 입니다.");
		return;
	}

	reqObj.chnlNo = reqObj.usedChnlNo;
	var url = '<ifvm:action name="useCnclMbrCoupon"/>';
	$.ifvSyncPostJSON(url,reqObj,function(result){
		if(result.success){
			alert('쿠폰 사용 취소 되었습니다.');
			getCouponHistList();
		}else{
			if(result.message) alert(result.message);
			else alert('쿠폰 사용 취소에 실패 하였습니다.');
		}
	},function(result){
		alert('쿠폰 사용 취소에 실패 하였습니다.');
	});
}


function mbrCouponSavePopFn(){
	

	
	$("#mbrCouponSavePopCon").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="mbrCouponSavePop"/>',
        contentType: "ajax",
        title: '쿠폰 발급',
        width: 1000,
        close : 'mbrCouponSaveClosePop'
    });

}
/* 
function mbrCouponReiSavePopFn(){
	if(mbrCouponRid==null) {
		alert("목록을 선택해주세요.");
		return;
	}
	if(issueDt ==null) {
		alert("발급일자가 없는 쿠폰입니다.");
		return;
	}
	
	if(validStartDay ==null) {
		alert("사용기한이 없는 쿠폰입니다.");
		return;
	}
	$("#mbrCouponReiSavePopCon").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="mbrCouponReiSavePop"/>',
        contentType: "ajax",
        title: '쿠폰 재발급',
        width: 1000,
        close : 'mbrCouponReiSaveClosePop'
    });

} */

function mbrCouponHistPopFn(){
		if(mbrCouponRid==null) {
			alert("목록을 선택해주세요.");
			return;
		}
		$("#mbrCouponHistPop").ifvsfPopup({
			enableModal : true,
	        enableResize: true,
	        contentUrl: '<ifvm:url name="mbrCouponHistPop"/>',
	        contentType: "ajax",
	        title: '쿠폰 이력 상세 조회',
	        width: 1000,
	        close : 'mbrCouponHistClosePop'
	    });

}

function mbrCouponListSearchPopClose(){
	mbrCouponhistCon._destroy();
}

function mbrCouponSaveClosePop() {
	mbrCouponSavePopCon._destroy();
}

function mbrCouponReiSaveClosePop() {
	mbrCouponReiSavePopCon._destroy();
}

function mbrCouponUseClosePop(){
	mbrCouponUsePopCon._destroy();
}


function mbrCouponHistClosePop() {
	mbrCouponHistPop._destroy();
}


function searchDate(){
    var startDt = $('#startDt').val();
	var endDt = $('#endDt').val();
	if(startDt != "" && endDt != ""){
	    searchChnlName(startDt, endDt)
	}else{
		alert('<spring:message code="L01859"/>');
	}
}

function searchSelBoxChange() {
	if($('#searchSelBox').val() == 'cpnNo') { // 검색셀렉트박스가 '채널명'일 경우
		$('#cpnNo').show();
		$('#searchFieldDiv').show();
		$('#searchVal').show();
		$('#ofrStat').hide(); // 구분필드값은 없는 상태이므로 null로 초기화)
		$('#ofrStatName').val(null); // 구분필드값은 없는 상태이므로 null로 초기화)
	} else if($('#searchSelBox').val() == 'ofrNm') {// 검색셀렉트박스가 '구분'일 경우
		$('#ofrNm').show();
		$('#cpnNo').val(null);
		$('#cpnNo').hide();
		$('#searchFieldDiv').show();
		$('#searchVal').show();
		$('#ofrStat').hide(); // 구분필드값은 없는 상태이므로 null로 초기화)
		$('#ofrStatName').val(null); // 구분필드값은 없는 상태이므로 null로 초기화)
	} else if($('#searchSelBox').val() == 'ofrStatCd') {// 검색셀렉트박스가 '구분'일 경우
		$('#ofrStat').show();
		$('#ofrStatName').val('사용가능');
		$('#cpnNo').hide();
		$('#ofrNm').hide();
		$('#searchFieldDiv').hide();
		$('#searchVal').hide();
		$('#cpnNo').val(null);
		$('#ofrNm').val(null);
	} 
}

$(document).ready(function(){ 
	$.fn.ifvmSetSelectOptionCommCode("cponStCd", "X_DK_CPN_STATUS", null, null, true);

	//searchSelBoxChange();
	getCouponHistList();
	setCalendar();
	
	$("#searchCouponBtn").click(function(){
		 searchDate();
	});
	
	$('#searchSelBox').change(function(){
		searchSelBoxChange();
	});

});

</script>