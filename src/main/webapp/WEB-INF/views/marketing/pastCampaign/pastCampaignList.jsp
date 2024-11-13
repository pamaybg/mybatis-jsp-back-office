<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var pastCampaignList;
var pastObj ={} ;

function getProductSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
      var obj = pastCampaignList.getRowData()[data-1];
      rid = obj.rid;
        },
        onSelectRow : function (data) {
        	pastObj = data;
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
        }
            return data;
        },
        loadComplete : function(obj){
        },
        url : '<ifvm:action name="getPastCampaignList"/>',
        colNames:[
                   '<spring:message code="M02508" />',  /*구분 */
                   '<spring:message code="M02509" />',  /*제목 */
                   '<spring:message code="M02510" />',  /*상태 */
                   '<spring:message code="M02511" />',  /*시작일 */
                   '<spring:message code="M02512" />',  /*종료일 */
                   '<spring:message code="M02513" />',  /*활성여부 */
                   'id',
                 ],
        colModel:[
             { name:'oldCamTypeNm',   index:'c1.mark_name',  resizable : true, align:'center',     width:'80px' },
             { name:'camNm',   index:'mcm.CAM_NM',  resizable : true, align:'center',     width:'80px' },
             { name:'camStatusNm',   index:'c2.mark_name',  resizable : true, align:'center',  width:'80px' },
             { name:'camStartDd',   index:'mcm.CAM_START_DD',  resizable : true, align:'center',    width:'80px' ,formatter:'date', formatoptions:{newformat:"Y-m-d"}},
             { name:'camEndDd',   index:'mcm.CAM_END_DD',  resizable : true, align:'center',    width:'80px',formatter:'date', formatoptions:{newformat:"Y-m-d"} },
             { name:'camActFlg',   index:'mcm.OLD_CAM_ACT_FLG',  resizable : true, align:'center',     width:'80px' },
             { name:'id',   index:'mcm.id', hidden : true },
        ],
        sortname: 'mcm.CAM_START_DD'
        , sortorder: "desc"
		, autowidth : true
		, radio :true
    };
    pastCampaignList = $("#pastCampaignListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//공통 조회 조건 목록 설정
function pastCampaignListSearchInit() {
   $.fn.ifvmSetCommonCondList("pastCampaignSearchList","pastCampaign");
}

//공통 조회 호출
function pastCampaignListSearch() {
    $.fn.ifvmSubmitSearchCondition("pastCampaignSearchList", getProductSearch);
}


function pointStandardNewFn(){
	qtjs.href("<ifvm:url name='productDetail'/>");
}

//상세 정보
function pastCampaignDtlInfoFn(){
	if(typeof (pastObj.oldCamTypeCd)=="undefined"){
		alert("데이터를 선택해주세요.");
	}else{
		if(pastObj.oldCamTypeCd=="CHNL"){
			channelSendDtlFn();
		}else if(pastObj.oldCamTypeCd=="PROM"){
			promotionDtlPopFn();
		}else if(pastObj.oldCamTypeCd=="CAM"){
			pastCampaignDtlFn();
		}
	}
}

function pastCampaignDtlFn(){
	pastCampaignDtlPop ={
		        id : "pastCampaignDtlPopDiv"
		    };
	pastCampaignDtlPop.popup = function (){
		 pastCampaignDtlPop.pop = $('#'+pastCampaignDtlPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="pastCampaignDtlPop"/>' +"?id="+pastObj.id,
		            contentType: "ajax",
		            title: '<spring:message code="M02518" />',
		            width: "1000px",
		            height: '700px',
		            maxHeight: null
		        });
		};
		pastCampaignDtlPop.beforeClose = function (obj) {
		};
		pastCampaignDtlPop.close = function (obj) {
	        this.beforeClose(obj);
	        this.pop.data('ejDialog')._destroy();
	 	};
	    pastCampaignDtlPop.popup();
}

function channelSendDtlFn(){
	channelSendDtlPop ={
		        id : "channelSendDtlPopDiv"
		    };
	channelSendDtlPop.popup = function (){
		channelSendDtlPop.pop = $('#'+channelSendDtlPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="channelSendDtlPop"/>' +"?id="+pastObj.id,
		            contentType: "ajax",
		            title: '<spring:message code="M02663" />',
		            width: "1200px",
		            height: '700px',
		            maxHeight: null
		        });
		};
		channelSendDtlPop.beforeClose = function (obj) {
		};
		channelSendDtlPop.close = function (obj) {
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		 };
		 channelSendDtlPop.popup();
}

function promotionDtlPopFn(){
	promotionDtlPop ={
		        id : "promotionDtlPopDiv"
		    };
	promotionDtlPop.popup = function (){
		promotionDtlPop.pop = $('#'+promotionDtlPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="promotionDtlPop"/>' +"?id="+pastObj.id,
		            contentType: "ajax",
		            title: '<spring:message code="M02613" />',
		            width: "1200px",
		            height: '700px',
		            maxHeight: null
		        });
		};
		promotionDtlPop.beforeClose = function (obj) {
		};
		promotionDtlPop.close = function (obj) {
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		};
		promotionDtlPop.popup();
}
//대상자 목록
function pastCampaignTargetFn(){

	if(typeof (pastObj.oldCamTypeCd)=="undefined"){
		alert("데이터를 선택해주세요.");
	}else{
		pastCampaignTargetListPop ={
		        id : "pastCampaignTargetListPopDiv"
		    };
		pastCampaignTargetListPop.popup = function (){
			pastCampaignTargetListPop.pop = $('#'+pastCampaignTargetListPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="pastCampaignTargetListPop"/>' +"?id="+pastObj.id,
		            contentType: "ajax",
		            title: '<spring:message code="M02516" />',//대상자 목록
		            width: "1000px",
		            height: '700px',
		            maxHeight: null
		        });
		};
		pastCampaignTargetListPop.beforeClose = function (obj) {
		};
		pastCampaignTargetListPop.close = function (obj) {
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		 };
		 pastCampaignTargetListPop.popup();
	}

}

//메세지
function pastCampaignMsgFn(){
	if(typeof (pastObj.oldCamTypeCd)=="undefined"){
		alert("데이터를 선택해주세요.");
	}else{
		pastCamMsg = {
			id : "pastCamMsgPop",
			pop : function(){
				$("#"+this.id).ifvsfPopup({
		            enableModal : true,
		            enableResize : false,
		            contentUrl : '<ifvm:url name="pastCamMsgListPop"/>' +"?id="+pastObj.id,
		            contentType : "ajax",
		            title : '<spring:message code="M02517"/>', // 메세지
		            width : '800px',
		            height: '700px',
		            maxHeight: null
		        });
			},
			beforeClose : function(obj){

			},
			close: function(obj){
				if(obj){
					this.beforeClose(obj)
				}
				var _popObj = eval(this.id)
				_popObj._destroy();
			}
		}
		pastCamMsg.pop();
	}
}

$(document).ready(function() {
    //공통 조회 조건 목록 설정
    pastCampaignListSearchInit();

    pastCampaignListSearch();
});
</script>

<div class="page-title">
    <h1>
   		<spring:message code="M02514" />
   		 &gt;<spring:message code="L00081"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M00276" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
         	<ifvm:inputNew type="button" btnType="search"  text="M00135"  id="pastCampaignListSearchBtn" btnFunc="pastCampaignListSearch" objCode="pastCampaignListSearchBtn_OBJ"/>
            <ifvm:inputNew type="button"  text="M00278"  id="productSearchInitBtn" btnFunc="pastCampaignListSearchInit" objCode="productSearchInitBtn_OBJ" />
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="pastCampaignSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M01805" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
 			<ifvm:inputNew type="button" btnType="search"  text="M02515"  id="pastCampaignDtlInfoBtn" btnFunc="pastCampaignDtlInfoFn" objCode="pastCampaignDtlInfoBtn_OBJ"/>
            <ifvm:inputNew type="button" btnType="search"  text="M02516"  id="pastCampaignTargetBtn" btnFunc="pastCampaignTargetFn" objCode="pastCampaignTargetBtn_OBJ"/>
            <ifvm:inputNew type="button" btnType="search"  text="M02517"  id="pastCampaignMsgBtn" btnFunc="pastCampaignMsgFn" objCode="pastCampaignMsgBtn_OBJ"/>
        </div>
    </div>
    <div id="pastCampaignListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="pastCampaignDtlPopDiv" class="popup_container"></div>
<div id="channelSendDtlPopDiv" class="popup_container"></div>
<div id="promotionDtlPopDiv" class="popup_container"></div>
<div id="pastCamMsgPop" class="popup_container"></div>
<div id="pastCampaignTargetListPopDiv" class="popup_container"></div>