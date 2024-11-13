<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var pointStandardList;
var rid;

function getPointStandardSearch() {
    var ejGridOption = {
   		recordDoubleClick : function(args) {
      		var obj = args.data ;
      		rid = obj.rid;
      		pointStandardDtlFn();   // 상세 보기 이벤트
        },
        rowSelected : function (args) {
        	rid=args.data.rid;
        },
        serializeGridData : function(data) {
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
//         loadComplete : function(obj) {
//         },
        dataUrl : '<ifvm:action name="getStandardPointList"/>',
        columns:[
        	 {
	      		  field : 'typeCd', headerText : '<spring:message code="L00891"/>', headerTextAlign : 'center', width:'80px',
	      		  customAttributes : {
	      			  index : 'cc1.MARK_NAME' }/*기준유형 */
	      	  }, {
	      		  field : 'ascStnYn', headerText : '<spring:message code="L00892"/>', headerTextAlign : 'center', width:'60px',
	      		  customAttributes : {
	      			  index : 'lpba.ASC_STN_YN' }/*충전소여부 */
	      	  }, {
	      		  field : 'ruleCd', headerText : '<spring:message code="L00893"/>', headerTextAlign : 'center', width:'80px',
	      		  customAttributes : {
	      			  index : 'lpba.RULE_CD' }/*기준코드 */
	      	  }, {
	      		  field : 'ruleTypeCd', headerText : '<spring:message code="L00896"/>', headerTextAlign : 'center', width:'200px',
	      		  customAttributes : {
	      			  index : 'lpba.RULE_TYPE_CD' }/*기준설명 */
	      	  }, {
	      		  field : 'statusCd', headerText : '<spring:message code="L00894"/>', headerTextAlign : 'center', width:'80px',
	      		  customAttributes : {
	      			  index : 'cc2.MARK_NAME' }/*상태 */
	      	  }, {
	      		  field : 'rid', headerText : 'rid', visible :false ,
	      		  customAttributes : {
	      			  index : 'lpba.rid' }
	      	  }, {
	      		  field : 'createDate', headerText : 'createDate', visible :false ,
	      		  customAttributes : {
	      			  index : 'lpba.CREATE_DATE' }
	      	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'lpba.RULE_CD',
      	  sord : 'asc',
      	  _search : false
        },
        rowList : [10,25,50,100],
    };
    pointStandardList = $("#pointStandardListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function pointStandardListSearchInit() {
   $.fn.ifvmSetCommonCondList("pointStandardSearchList","PGM_L_097");
}

//공통 조회 호출
function pointStandardListSearchFn() {
    $.fn.ifvmSubmitSearchCondition("pointStandardSearchList", getPointStandardSearch);
}

function pointStandardDtlFn(){
 	var url = "<ifvm:url name='standardPointDetail'/>";
 	if(rid !=null){
 		url = url + '?rid=' +  escape(rid);
 	}
 	qtjs.href(url);
}

function pointStandardNewFn(){
	qtjs.href("<ifvm:url name='standardPointDetail'/>");
}

$(document).ready(function() {
    //공통 조회 조건 목록 설정
    pointStandardListSearchInit();

    pointStandardListSearchFn();
});
</script>

<div class="page-title">
    <h1>
   <spring:message code="L00895" />
    &gt;<spring:message code="L00081"/>
    </h1>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="search"  text="M00135"  id="pointStandardListSearchBtn" btnFunc="pointStandardListSearchFn"/>
            <ifvm:inputNew type="button"   text="M00278"  id="pointStandardSearchInitBtn" btnFunc="pointStandardListSearchInit"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="pointStandardSearchList" >
    </div>
</div>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
 		<%-- 	<ifvm:inputNew type="button" btnType="plus"  text="L00078"  id="newBtn" btnFunc="pointStandardNewFn"/> --%>
        </div>
    </div>
    <div id="pointStandardListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="transactionDetailDialog" class="popup_container"></div>
 <div id="pointDetailPopDiv" class="popup_container"></div>