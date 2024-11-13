<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script type="text/javascript">
<% request.setCharacterEncoding("UTF-8");%>
var pointSearchHelpGrid;
var pointSearchHelpList;
var obj=null;
var typeCd = null;

	typeCd = '<%= cleanXss(request.getParameter("typeCd")) %>'


var ruleCd = decodeURIComponent('<%= cleanXss(request.getParameter("ruleCd")) %>');

function getPointStandardSearch(){
    var jqGridOption = {

        onSelectRow : function (data) {
        	obj=data;
        },
       serializeGridData : function( data ){

        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
        if(typeCd!=null){
        	data.typeCd = typeCd

        }
       		 return data;
        },
        loadComplete : function(obj){
        	defaultSearchClose();
        },
        url : '<ifvm:action name="pointSearchHelp"/>',
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
        sortname: 'createDate',
		autowidth : true , sortorder: "desc",
       	radio: true
    };

    pointSearchHelpList = $("#pointSearchHelpGrid").ifvGrid({ jqGridOption : jqGridOption });

    pointSearchHelpGrid = $("#pointSearchHelpGrid");
}

//공통 조회 조건 목록 설정
function pointStandardListSearchInit() {
   $.fn.ifvmSetCommonCondList("pointStandardSearchList","PGM_L_097");
}

//공통 조회 호출
function pointStandardListSearch() {
    $.fn.ifvmSubmitSearchCondition("pointStandardSearchList", getPointStandardSearch);
}

//선택

//저장
function savePointInfoFn(){
	if(obj!=null){
		pointSearchHelpPop.close(obj);
	}else{
		alert("<spring:message code='L00911'/>");
		return
	}
}

//닫기
function cancelPointInfoFn(){
	pointSearchHelpPop.close();
}




function defaultSearch(){


	 if(typeof ruleCd != "undefined" && ruleCd != "undefined"
		 && $.fn.ifvmIsNotEmpty(ruleCd) && ruleCd != "null") {

	$("#pop_main_div_point .SearchCondition .searchTextVal option:selected").filter(function(){
		if($(this).attr('joinsrcclm') == "RULE_CD"){ $(this).parents('.SearchCondition').find('.changeTypeAreaCode input').val(ruleCd)}
		})

	}


}
function defaultSearchClose(){

	 if(typeof ruleCd != "undefined" && ruleCd != "undefined"  && $.fn.ifvmIsNotEmpty(ruleCd) && ruleCd != "null") {
		if(pointSearchHelpList.getRowData().length==1){
			pointSearchHelpPop.close(pointSearchHelpList.getRowDatas(1));
		}
		ruleCd = "null";
	 }
}




$(document).ready(function() {
    //공통 조회 조건 목록 설정
    pointStandardListSearchInit();

    defaultSearch();
    pointStandardListSearch();



    //조회
    $('#pointStandardListSearchBtn').on('click', function(){
    	pointStandardListSearch();
    });

    //초기화
    $("#pointStandardSearchInitBtn").on('click', function(){
    	pointStandardListSearchInit();
    });

    $.ifvEnterSetting(["#pointStandardSearchList input"], function(){
    	pointStandardListSearch();
	});


});

</script>

<div id="pop_main_div_point">

	<div>
	    <div class="page_btn_area">
	        <div class="col-xs-7">
	            <span><spring:message code="L01838" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	            <button class="btn btn-sm" id="pointStandardListSearchBtn" objCode="pointSearchListSearchBtn_OBJ"><i class="fa fa-search"></i>
	                <spring:message code="M00135" />
	            </button>
	                        <button class="btn btn-sm" id="pointSearchStandardSearchInitBtn_OBJ">
	    <spring:message code="M00278" />
	            </button>
	        </div>
	    </div>
	    <div class="well form-horizontal well_bt5" id="pointStandardSearchList">
	    </div>
	</div>

	<div>
	    <div id="pointSearchHelpGrid" class="white_bg grid_bd0"></div>
			<div class="pop_btn_area">
				<ifvm:inputNew type="button" btnType="save"  text="M00282"  id="savePntInfoBtn" btnFunc="savePointInfoFn" objCode="savePntInfoBtn_OBJ"/>
	 			<ifvm:inputNew type="button"   text="L00913"  id="cancelPntInfoBtn" btnFunc="cancelPointInfoFn" objCode="cancelPntInfoBtn_OBJ"/>
			</div>

	</div>
</div>
