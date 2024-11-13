<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
var manualList;
var rid ;
var doubleSubmitFlag = false;
//스탬프 거래리스트
function getManualSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
	      var obj = manualList.getRowData()[data-1];
	      rid = obj.rid;
	      manualDetailDtl();   // 상세 보기 이벤트
        },
        onSelectRow : function (data) {
        	rid=data.rid;
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        loadComplete : function(obj){
        },
        url : '<ifvm:action name="getManualReqList"/>',
        colNames:[
                   '<spring:message code="L00607" />',  /*요청 유형 */
                   '<spring:message code="L00753" />',  /*생성일시 */
                   '<spring:message code="L00667" />',  /*포인트 유형*/
                   '포인트 유형 코드값',  /*포인트 유형*/
                   'RQT_TYPE ',  /*포인트 유형*/
                   'hndopAcuStblRsnCd',
                   'trtStatusCd',
                   '<spring:message code="L00666" />',  /*처리상태 */
                   '<spring:message code="M00688" />',  /*회원번호 */
                   '<spring:message code="M00850" />',  /*회원명 */

                   '<spring:message code="L00754" />', /*요청 포인트/스탬프 */
                   '<spring:message code="L00755" />', /*적립/차감 사유 */
                   '<spring:message code="L00756" />', /*적립/차감 설명 */
                   '<spring:message code="L00677" />', /*검수자 */
                   '<spring:message code="L00678" />', /*승인자 */
                   '<spring:message code="L00604" />', /*거래일시 */

                   '<spring:message code="L00564" />', /*가맹점코드 */
                   '<spring:message code="L00565" />', /*가맹점명*/

                   '검수자 rid',
                   '승인자 rid',
                   '회원 rid',
                   '고객 rid',
                   '가맹점 rid',
                   'rid',
                   'memDivCd'
                 ],
        colModel:[
             { name:'rqtType',   		index:'lvr.RQT_TYPE',  		resizable : true, align:'center',    width:'60px' },
             { name:'createDate',   	index:'lvr.CREATE_DATE',  	resizable : true, align:'center',  formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"} ,width:'150px' },
             { name:'pointName',   		index:'cc.MARK_NAME',  		resizable : true, align:'center',     width:'80px' },
             { name:'dtlPointType', 	index:'lvr.POINT_TYPE',  	hidden: true },
             { name:'dtlRqtType',   	index:'lvr.RQT_TYPE',  		hidden: true },
             { name:'hndopAcuStblRsnCd',index:'lvr.RQT_TYPE',  		hidden: true },
             { name:'trtStatusCd',   	index:'lvr.RQT_TYPE',  		hidden: true },

             { name:'trtStatus',   		index:'lvr.TRT_STATUS',  	resizable : true, align:'center',    width:'100px' },
             { name:'mbrNo',   			index:'lm.MBR_NO',  		resizable : true, align:'center',    width:'100px',formatter : goGridRowMbrLink },
             { name:'custNm',   		index:'lm.MBR_HID_NM',  	resizable : true, align:'center',    width:'100px' },

             { name:'rqtPoint',   		index:'lvr.RQT_POINT',  	resizable : true, align:'right',    width:'120px',formatter:'integer' },
             { name:'hndopAcuStblRsn',  index:'lvr.HNDOP_ACU_STBL_RSN',  resizable : true,align:'center',    width:'120px' },
             { name:'hndopAcuStblDesc', index:'lvr.HNDOP_ACU_STBL_DESC', resizable : true, align:'left',    width:'180px' },
             { name:'actcName',   		index:'e2.name',  			resizable : true, align:'center',    width:'100px' },
             { name:'apvName',   		index:'e1.name',  			resizable : true, align:'center',    width:'100px'},
             { name:'dealDt',   		index:'lvr.DEAL_DT',  		resizable : true, align:'center',   formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"} ,  width:'150px' },

             { name:'chnlNo',   		index:'lc.CHNL_NO',  		resizable : true, align:'center',    width:'120px' },
             { name:'chnlNm',   		index:'lc.CHNL_NM',  		resizable : true, align:'center',    width:'120px',formatter : goGridRowChannelLink},

             { name:'ridActc',	index:'lvr.RID_ACTC',	hidden : true},
             { name:'ridApv',   index:'lvr.RID_APV',    hidden : true},
             { name:'ridMbr',   index:'lvr.RID_MBR',    hidden : true},
             { name:'ridCust',  index:'lm.RID_CUST',    hidden : true},
             { name:'ridChnl',  index:'lvr.RID_CHNL',   hidden : true},
             { name:'rid',    	index:'lvr.rid',    	hidden : true},
             { name:'memDivCd', index:'memDivCd',    	hidden : true}
        ],
        sortname: 'createDate',
		sortorder: "desc",
		multiselect: true
    };

    manualList = $("#manualListGrid").ifvGrid({ jqGridOption : jqGridOption });
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
    $.fn.ifvmSubmitSearchCondition("manualReqListSearchList", getManualSearch);
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
	var changeRow = manualList.getRowData();
	var list = manualList.getAllRowIds();
	var checkedList = manualList.getCheckedRowIds();
	var err = 0 ;
	var suc = 0;

	if(checkedList.length >0){
		for( var i = 0; i < checkedList.length; i++ ){
			var row = manualList.getRowDatas(checkedList[i]);
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