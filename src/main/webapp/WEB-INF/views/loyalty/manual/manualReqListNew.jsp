<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/x-jsrender" id="manualReqListTemplate">
	{{if ridMbr != null}}
		{{if memDivCd == "P" || memDivCd == "T" }}
			<a href="<ifvm:url name="mbrDetail"/>?rid={{:ridMbr}}" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>
		{{else}}
			<a href="<ifvm:url name="mbrGroupDetail"/>?rid={{:ridMbr}}" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>
		{{/if}}		
	{{/if}}
</script>
<script type="text/x-jsrender" id="channelTemplate">
	<a href="<ifvm:url name="channelDetail"/>?rid={{:ridChnl}}" style="color:#1266FF; text-decoration:underline;" >{{:chnlNm}}</a>
</script>


<script type="text/javascript">
var manualList;
var rid ;

var doubleSubmitFlag = false;
//스탬프 거래리스트
function getManualSearch(){
    var ejGridOption = {
    	  recordDoubleClick : function(args){
	      var obj = args.data ;
	      rid = obj.rid;
	      manualDetailDtl();   // 상세 보기 이벤트
        },
        rowSelected : function (args) {
        	rid=args.data.rid;
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        dataUrl : '<ifvm:action name="getManualReqList"/>',
        columns:[
        	 {
	      		  field : 'rqtType', headerText : '<spring:message code="L00607"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lvr.RQT_TYPE' }/* */
	      	  }, {
	      		  field : 'createDate', headerText : '<spring:message code="L00753"/>', headerTextAlign : 'center',width :'150px',
	      		  customAttributes : {
	      			  index : 'lvr.CREATE_DATE' }/*생성일시 */
	      	  }, {
	      		  field : 'pointName', headerText : '<spring:message code="L00667"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'cc.MARK_NAME' }/*포인트 유형 */
	      	  }, {
	      		  field : 'dtlPointType', headerText : '포인트 유형 코드값', headerTextAlign : '',visible: false,
	      		  customAttributes : {
	      			  index : 'lvr.POINT_TYPE' }/*포인트 유형 */
	      	  }, {
	      		  field : 'dtlRqtType', headerText : 'RQT_TYPE', headerTextAlign : '',visible: false,
	      		  customAttributes : {
	      			  index : 'lvr.RQT_TYPE' }/* */
	      	  }, {
	      		  field : 'hndopAcuStblRsnCd', headerText : 'hndopAcuStblRsnCd', headerTextAlign : '',visible: false,
	      		  customAttributes : {
	      			  index : 'lvr.RQT_TYPE' }/* */
	      	  }, {
	      		  field : 'trtStatusCd', headerText : 'trtStatusCd', headerTextAlign : '',visible: false,
	      		  customAttributes : {
	      			  index : 'lvr.RQT_TYPE' }/* */
	      	  }, {
	      		  field : 'trtStatus', headerText : '<spring:message code="L00666"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lvr.TRT_STATUS' }/*처리상태 */
	      	  }, {
	      		  field : 'mbrNo', headerText : '<spring:message code="M00688"/>', headerTextAlign : 'center',  template : "#manualReqListTemplate" ,
	      		  customAttributes : {
	      			  index : 'lm.MBR_NO' }/*회원번호 */
	      	  }, {
	      		  field : 'custNm', headerText : '<spring:message code="M00850"/>', headerTextAlign : 'center', 
	      		  //template : if,
	      		  customAttributes : {
	      			  index : 'lm.MBR_HID_NM' }/*회원명 */
	      	  },{
	      		  field : 'rqtPoint', headerText : '<spring:message code="L00754"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lvr.RQT_POINT' }/*요청 포인트/스탬프 */
	      	  },{
	      		  field : 'hndopAcuStblRsn', headerText : '<spring:message code="L00755"/>', headerTextAlign : 'center',  
	      		  customAttributes : {
	      			  index : 'lvr.HNDOP_ACU_STBL_RSN' }/*적립/차감 사유 */
	      	  },
// 	      	  {
// 	      		  field : 'hndopAcuStblDesc', headerText : '<spring:message code="L00756"/>', headerTextAlign : 'center', width :'180px',
// 	      		  customAttributes : {
// 	      			  index : 'lvr.HNDOP_ACU_STBL_DESC' }/*적립/차감 설명 */
// 	      	  },
	      	  {
	      		  field : 'actcName', headerText : '<spring:message code="L00677"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'e2.name' }/*검수자 */
	      	  },{
	      		  field : 'apvName', headerText : '<spring:message code="L00678"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'e1.name' }/*승인자 */
	      	  },{
	      		  field : 'dealDt', headerText : '<spring:message code="L00604"/>', headerTextAlign : 'center',
	      		  customAttributes : {
                      sortable: false,
	      			  index : 'lvr.DEAL_DT' }/*거래일시 */
	      	  },{
	      		  field : 'chnlNo', headerText : '<spring:message code="L00564"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lc.CHNL_NO' }/*가맹점코드 */
	      	  },
// 	      	  {
// 	      		  field : 'chnlNm', headerText : '<spring:message code="L00565"/>', headerTextAlign : 'center',template : "#channelTemplate" ,
// 	      		  customAttributes : {
// 	      			  index : 'lc.CHNL_NM' }/*가맹점명 */
// 	      	  },
	      	  {
	      		  field : 'ridActc', headerText : '검수자 rid', headerTextAlign : '',visible: false,
	      		  customAttributes : {
	      			  index : 'lvr.RID_ACTC' }
	      	  },{
	      		  field : 'ridApv', headerText : '승인자 rid', headerTextAlign : '',visible: false,
	      		  customAttributes : {
	      			  index : 'lvr.RID_APV' }/* */
	      	  },{
	      		  field : 'ridMbr', headerText : '회원rid', headerTextAlign : '',visible: false,
	      		  customAttributes : {
	      			  index : 'lvr.RID_APV' }/* */
	      	  },{
	      		  field : 'ridCust', headerText : '고객rid', headerTextAlign : '',visible: false,
	      		  customAttributes : {
	      			  index : 'lm.RID_CUST' }/* */
	      	  },{
	      		  field : 'ridChnl', headerText : '가맹점rid', headerTextAlign : '',visible: false,
	      		  customAttributes : {
	      			  index : 'lvr.RID_CHNL' }/* */
	      	  },{
	      		  field : 'rid', headerText : 'rid', headerTextAlign : '',visible: false,
	      		  customAttributes : {
	      			  index : 'lvr.rid' }/* */
	      	  },{
	      		  field : 'memDivCd', headerText : 'memDivCd', headerTextAlign : '',visible: false,
	      		  customAttributes : {
	      			  index : 'memDivCd' }/* */
	      	  },

        ], 
        requestGridData : {
    	  nd   : new Date().getTime(),
    	  rows : 10,
    	  sidx : 'createDate',
    	  sord : 'desc',
    	  _search : false
      },
//       allowScrolling: true,
      rowList : [10,25,50,100],
      radio: true,
//       gridDataInit: false
// 	  multiselect: true
    };
	
    manualList = $("#manualListGrid").ifvsfGrid({ ejGridOption  : ejGridOption  });
}

function goGridRowMbrLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridMbr;

    if( id !=null){
    	if( rowObjec.memDivCd == 'P' ||rowObjec.memDivCd == 'T' ){
    	    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;

    	}else{
    	    var url = '<ifvm:url name="mbrGroupDetail"/>' + '?rid=' + id;

    	}


    	 var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    	 return tag;
    }else{
    	return "";
    }
}

function goGridRowChannelLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridChnl;
    var tag=null;
    var url = '<ifvm:url name="channelDetail"/>?rid=' + id;
    if(cellvalue!=null){
    	 tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
    return tag;
}

function goGridRowPgmLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridPgm;
    var url = '<ifvm:url name="pgmDetail"/>?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    return tag;
}

//공통 조회 조건 목록 설정
function manualReqListSearchInit() {
    $.fn.ifvmSetCommonCondList("manualReqListSearchList","PGM_L_052");
}

//공통 조회 호출
function manualReqListSearch() {
    $.fn.ifvmSubmitSearchCondition("manualReqListSearchList", function (){
    	manualList.searchGrid({item: requestitem});
    });
}

//고객 상세 이동
function manualDetailDtl() {
 	var url = '<ifvm:url name="manualDetail"/>';
 	if(rid !=null){
 		url = url + '?rid=' + rid;
 	}
 	qtjs.href(url);
}

function fnManualDetailPop(){
	 manualDetailPop ={
		        id : "manualDetailPopDiv"
		    };
	 manualDetailPop.popup = function (){
		 manualDetailPop.pop = $('#'+manualDetailPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="manualDetailPop"/>',
		            contentType: "ajax",
		            title: '<spring:message code="L00665"/>',
		            width: '1000px'
		        });
		};
		manualDetailPop.beforeClose = function (obj) {
		};
		manualDetailPop.close = function (obj) {
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		};
		manualDetailPop.popup();
}

function manualNewFn(){
	var url = '<ifvm:url name="manualDetail"/>';
		qtjs.href(url);
}


function vanApprovalListFn() {
	if(doubleSubmitCheck()) return;
	var changeRow = manualList.opt.gridControl.model.currentViewData;
	var list = manualList.opt.gridControl.model.selectedRowIndex;
	var checkedList = manualList.opt.gridControl.model.currentViewData ; 
	var err = 0 ;
	var suc = 0;

	if(list+1 >0){
		for( var i = 0; i < list+1 ; i++ ){
			var row = checkedList[i];
			if(row.rqtType == null || row.rqtType == "" ||
				row.pointName == null || row.pointName == "" ||
				row.ridChnl == null || row.ridChnl == "" ||
				row.ridCust == null || row.ridCust == "" ||
				row.rqtPoint == null || row.rqtPoint == "" || row.rqtPoint == "0"  ||
				row.hndopAcuStblRsn == null || row.hndopAcuStblRsn == "" ||
				(row.trtStatusCd != "20"  && row.trtStatusCd != "40" ) ||
				 $.ifvmGetUserInfo().empId != row.ridActc
			){
				err = err + 1;

			}else{

				var submitData = {
						ridChnl : row.ridChnl ,
						dtlRqtPoint : row.rqtPoint.replace(/[^\d]+/g,''),
						ridMbr : row.ridMbr,
						rid : row.rid ,
						hndopAcuStblRsn : row.hndopAcuStblRsnCd,
						dtlRqtType : row.dtlRqtType,
						dtlPointType : row.dtlPointType,
						dtlMbrNo : row.mbrNo,
						dtlTrtStatus : row.trtStatusCd
				}

				$.ifvSyncPostJSON('<ifvm:action name="vanApprovalReq"/>',
						submitData,
						   function(result) {
							if(result.errorType === 0){
								suc = suc + 1;
							}else{
								err = err + 1;
							}


						}, function(result) {
							err = err + 1;
						});
			}



		}
		var msg = "";
		msg += '<spring:message code="L02028"/>' + suc + '<spring:message code="L02029"/>' + ", ";
		msg += '<spring:message code="L02030"/>' + err + '<spring:message code="L02029"/>' + " ";
		msg += '<spring:message code="L02031"/>';
		alert( msg );
		getManualSearch();
	}

	doubleSubmitFlag=false;

}


function doubleSubmitCheck(){
    if(doubleSubmitFlag){
        return doubleSubmitFlag;
    }else{
        doubleSubmitFlag = true;
        return false;
    }
}




$(document).ready(function() {
    //공통 조회 조건 목록 설정
    manualReqListSearchInit();

    getManualSearch();


});
</script>


<div class="page-title">
	<h1>
        <spring:message code="L00664" />
        &gt;<spring:message code="L00081"/>
	</h1>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="search"  text="M00135"  id="manualReqListSearchBtn" btnFunc="manualReqListSearch"/>
            <ifvm:inputNew type="button"   text="M00278"  id="manualReqListSearchInitBtn" btnFunc="manualReqListSearchInit"/>
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="manualReqListSearchList">
	</div>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00277" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
		<%--
			<ifvm:inputNew type="button"   btnType="search"  text="L01835"  id="stampSearchBtn" btnFunc="stampSearchFn"/>
 			<ifvm:inputNew type="button"   btnType="search" text="L01836"  id="pntSearchBtn" btnFunc="pntSearchFn"/>
 			<ifvm:inputNew type="button"   btnType="search" text="L01837"  id="allSearchBtn" btnFunc="allSearchFn"/> --%>
 			<ifvm:inputNew type="button" text="L01259" id="vanApprovalListBtn" btnFunc="vanApprovalListFn" objCode="LOY_VAN_003"/>
			<ifvm:inputNew type="button"   btnType="plus"  text="M00136"  id="manualNewBtn" btnFunc="manualNewFn"/>
			<%-- <ifvm:inputNew type="button"   btnType="download"  text="M01218"  btnFunc="fnIfvExcelDownload2('manualListGrid')"/> --%>
		</div>
	</div>
	<div id="manualListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="manualDetailPopDiv" class="popup_container content_container"></div>