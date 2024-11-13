<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var pointStandardList;
var rid;

function getPointStandardSearch() {
    var jqGridOption = {
        ondblClickRow : function(data) {
      var obj = pointStandardList.getRowData()[data-1];
      rid = obj.rid;
      pointStandardDtlFn();   // 상세 보기 이벤트
        },
        onSelectRow : function (data) {
        	rid=data.rid;
        },
       serializeGridData : function(data) {
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        loadComplete : function(obj) {
        },
        url : '<ifvm:action name="getStandardPointList"/>',
        colNames:[
                   '<spring:message code="L00891" />',  /*기준유형 */
                   '<spring:message code="L00892" />',  /*충전소여부 */
                   '<spring:message code="L00893" />',  /*기준코드*/
                   '<spring:message code="L00896" />',  /*기준설명 */
                   '<spring:message code="L00894" />',  /*상태 */
                   'rid',
                   'createDate'
                 ],
        colModel:[
             { name:'typeCd',   index:'cc1.MARK_NAME',  resizable : true, align:'center',    width:'80px' },
             { name:'ascStnYn',   index:'lpba.ASC_STN_YN',  resizable : true, align:'center',  width:'60px' },
             { name:'ruleCd',   index:'lpba.RULE_CD',  resizable : true, align:'center',     width:'80px' },
             { name:'ruleTypeCd',   index:'lpba.RULE_TYPE_CD',  resizable : true, align:'left',  width:'200px' },
             { name:'statusCd',   index:'cc2.MARK_NAME',  resizable : true, align:'center',    width:'80px' },
             { name:'rid',    index:'lpba.rid',    hidden : true},
             { name:'createDate',    index:'lpba.CREATE_DATE',    hidden : true}
        ],
        sortname: 'lpba.RULE_CD',
		autowidth : true , sortorder: "asc",
    };
    pointStandardList = $("#pointStandardListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//공통 조회 조건 목록 설정
function pointStandardListSearchInit() {
   $.fn.ifvmSetCommonCondList("pointStandardSearchList","PGM_L_097");
}

//공통 조회 호출
function pointStandardListSearchFn() {
    $.fn.ifvmSubmitSearchCondition("pointStandardSearchList", function(){
    	pointStandardList.searchGrid({item: requestitem});
    });
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

    getPointStandardSearch();
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
        	<ifvm:inputNew type="button" btnType="search"  text="M00135"  id="pointStandardListSearchBtn" btnFunc="pointStandardListSearchFn" objCode="pointStandardListSearchBtn_OBJ"/>
            <ifvm:inputNew type="button"   text="M00278"  id="pointStandardSearchInitBtn" btnFunc="pointStandardListSearchInit" objCode="pointStandardSearchInitBtn_OBJ"/>
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