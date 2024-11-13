<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%-- 회원별 매장칭찬 --%>

<script type="text/javascript">

var storeSatisfactionListGrid;

$(document).ready(function() {
	getStoreSatisfactionList();

    //공통 조회 조건 목록 설정
    storeSatisfactionListSearchInit();

    //조회
    $('#storeSatisfactionListSearchBtn').on('click', function() {
    	storeSatisfactionListSearch();
    });

    //초기화
    $("#storeSatisfactionListSearchInitBtn").on('click', function() {
    	storeSatisfactionListSearchInit();
    });
});

//공통 조회 조건 목록 설정
function storeSatisfactionListSearchInit() {
 	$.fn.ifvmSetCommonCondList("storeSatisfactionSearchList", "LOY_5011");
}

//공통 조회 호출
function storeSatisfactionListSearch() {
	var rstdDate;
	var rendDate;
//   	$.fn.ifvmSubmitSearchCondition("storeSatisfactionSearchList", getStoreSatisfactionList);
  	$.fn.ifvmSubmitSearchCondition_NoAllSearch("storeSatisfactionSearchList", function() {
    	if ($.fn.ifvmIsNotEmpty(requestitem)) {
    		for(var i=0;i<requestitem.length;i++){
    			var getTrNo =requestitem[i].comTgCol
    			if(getTrNo=='create_date'){
    				rstdDate =requestitem[i].startDate;
    				rendDate =requestitem[i].endDate;
    			break;
    			}
    		}
    		var g=rstdDate.split(" ");
    		var d=g[0].split("-");
    		var t=g[1].split(":");
    		var sdate1 = new Date(d[0],(d[1]-1),d[2],t[0],t[1],t[2]);

    		var g1=rendDate.split(" ");
    		var d1=g1[0].split("-");
    		var t1=g1[1].split(":");
    		var sdate2 = new Date(d1[0],(d1[1]-1),d1[2],t1[0],t1[1],t1[2]);

    		var a = (sdate2.getTime()-sdate1.getTime())/(1000*60*60*24);
    		if(a>=31){
    			alert('31일 기간으로  조회 가능 합니다.');
    			return;
    		}
    		storeSatisfactionListGrid.searchGrid({item: requestitem});
    	} else {
    		alert('최소 1개의 조회조건을 입력해주세요.');
    	}
    });
}

/**
 * 매장만족도 설문결과 목록
 */
function getStoreSatisfactionList(){
    var ejGridOption = {
   		recordDoubleClick : function(args) {
       	},
      	serializeGridData : function(data) {
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
       	},
       	loadComplete : function(obj){
       	},
       	dataUrl : '<ifvm:action name="getStoreSatisfactionListByMbr"/>',
       	columns:[
        		{//참여일자
        		  field : 'createDate', headerText : '<spring:message code="L02292"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
        		  customAttributes : {
        			  index : 'lcs.create_date' }
        	  },{//매장코드
          		  field : 'chnlNo', headerText : '<spring:message code="D10173"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
          		  customAttributes : {
          			  index : 'lc.chnl_no' }
          	  },{//매장명
          		  field : 'chnlNm', headerText : '<spring:message code="L02275"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'lc.chnl_nm' }
          	  },{//회원ID
          		  field : 'webId', headerText : '<spring:message code="L01800"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'lcs.web_id' }
          	  },{//회원명
          		  field : 'custNm', headerText : '<spring:message code="L01844"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'lct.cust_nm' }
          	  },{//만족도유형
          		  field : 'satisDivCdNm', headerText : '<spring:message code="L02298"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'c1.mark_name' }
          	  },{//점수
          		  field : 'satisVal', headerText : '<spring:message code="L02227"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Right,
          		  customAttributes : {
          			  index : 'lcs.satis_val' }
          	  },{//의견
          		  field : 'satisComment', headerText : '<spring:message code="L02299"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'lcs.satis_comment' }
          	  },{
          		  field : 'rid', headerText : 'rid', visible : false ,
          		  customAttributes : {
          			  index : 'lcs.rid' }
          	  }
        ],
        requestGridData : {
        	  nd   : new Date().getTime(),
        	  rows : 10,
        	  sidx : 'lcs.create_date',
        	  sord : 'desc',
        	  _search : false
        },
        allowSorting: true,
        rowList : [10,25,50,100],
        radio: true,
        gridDataInit: false,
        tempId : 'ifvGridOriginTemplete'
    };

    storeSatisfactionListGrid = $("#storeSatisfactionListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function getSatisCommentDetail() {

    var v_rid;
    if ($.fn.ifvmIsNotEmpty(storeSatisfactionListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = storeSatisfactionListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M00004"/>');//목록을 선택해주세요.
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        commentDetailPop = {
			id : "commentDetailPopDiv",
			pop : function() {
				$("#" + this.id).ifvsfPopup({
					enableModal : true,
					enableResize : false,
					contentUrl : '<ifvm:url name="commentDetailPop"/>?rid=' + v_rid,
					contentType : "ajax",
					title : '<spring:message code="L02300"/>', //의견조회
					width : '400px'
				});
			},
			beforeClose: function(getObj) {
			},
			close : function(getObj) {
				if (getObj) {
					this.beforeClose(getObj);
				}
				var _popObj = eval(this.id);
				_popObj._destroy();
			}
		}
        commentDetailPop.pop();
    }
}

</script>

<div class="page-title">
    <h1>
    	<spring:message code="L02297" />
		&gt; <spring:message code="M00135" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="SatisfactionListSearchBtn" objCode="SatisfactionListMBRSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="SatisfactionListSearchInitBtn" objCode="SatisfactionListMBRSearchInitBtn_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="storeSatisfactionSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnFunc="getSatisCommentDetail" text="L02300" objCode="getSatisCommentDetail_OBJ"/>
        </div>
    </div>
    <div id="storeSatisfactionListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="commentDetailPopDiv" class="popup_container"></div>