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
var empSearchHelp;
var gridIdempSearchHelp;
var rid ;
var authNm = '<%= cleanXss(request.getParameter("authNm")) %>';
var obj=null;
var name = decodeURIComponent('<%= cleanXss(request.getParameter("name")) %>');

//직원 팝업
function getempSearchHelpSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
      var data = empSearchHelp.getRowData()[data-1];
      rid = data.rid;

      //emptyDtlPop();   // 상세 보기 이벤트


        },
        onSelectRow : function (data) {
        	obj = data;

        },
        serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
        }
       	data.authNm = authNm;

        return data;
        },
        loadComplete : function(data){
        	if(data.rows.length==1){
        		obj = data.rows[0];
        		saveEmpInfoFn();
        	}

        	defaultSearchClose();
        },
        url : '<ifvm:action name="getEmpSearchHelp"/>',
        colNames:[
                   '<spring:message code="M00983" />',
                   '<spring:message code="M01248" />',
                   '<spring:message code="M01250" />',

                   'rid'
                 ],
        colModel:[
             { name:'name',   index:'e.name',  resizable : true, align:'center',    width:'100px' },
             { name:'userId',   index:'f.user_id',  resizable : true, align:'center',    width:'100px' },
             { name:'divNm',   index:'g.div_nm',  resizable : true, align:'center',    width:'100px' },

             { name:'rid',    index:'e.id',    hidden : true}
        ],
        radio:true,
        sortname: 'e.id',

        sortorder: "desc",
    };

    empSearchHelp = $("#empSearchHelpGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdempSearchHelp = $("#gridIdempSearchHelp");
}

//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';

    return tag;
}
function goGridRowChnlLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridChnl;
    var url = '<ifvm:url name="chnlDetail"/>?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    return tag;
}
function goGridRowPgmLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridPgm;
    var url = '<ifvm:url name="pgmDetail"/>?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';

    return tag;
}


//공통 조회 조건 목록 설정
function empSearchHelpSearchInit() {
    $.fn.ifvmSetCommonCondList("empSearchHelpSearchList","PGM_L_112");
}

//공통 조회 호출
function empSearchHelpSearch() {
    $.fn.ifvmSubmitSearchCondition("empSearchHelpSearchList", getempSearchHelpSearch);
}

// 상세 팝업 화면 호출
function emptyDtlPop(){

 $("#emptyDialog").ifvsfPopup({
  enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="empty"/>',
        contentType: "ajax",
        title: 'empty',
        width: '1000px',
        close : 'emptyPopClose'
    });
}

//팝업 닫기
function emptyPopClose() {
	emptyDialog._destroy();
}

//고객 상세 이동
function emptyDtl() {
    qtjs.href('<ifvm:url name="empty"/>' + '?rid=' + rid);
}

//저장
function saveEmpInfoFn(){
	if(obj!=null){
		obj.authNm = authNm;
		empSearchHelpPop.close(obj);
	}else{
		alert("<spring:message code='L00911'/>");
		return
	}
}

//닫기
function cancelEmpInfoFn(){
	empSearchHelpPop.close();
}

function defaultSearch(){
	 if(typeof name != "undefined" && name != "undefined"
		 && $.fn.ifvmIsNotEmpty(name) && name != "null") {
		 first ='';
		$("#pop_main_div_emp .SearchCondition .searchTextVal option:selected").filter(function(){
			if($(this).attr('joinsrcclm') == "NAME"){ $(this).parents('.SearchCondition').find('.changeTypeAreaCode input').val(name)}
			})
		}
}
function defaultSearchClose(){
	 if(typeof name != "undefined" && name != "undefined"  && $.fn.ifvmIsNotEmpty(name) && name != "null") {
		if(empSearchHelp.getRowData().length==1){
			empSearchHelpPop.close(empSearchHelp.getRowDatas(1));
		}
		name = "null";
	 }
}


$(document).ready(function() {
    //공통 조회 조건 목록 설정
    empSearchHelpSearchInit();
    defaultSearch();
    empSearchHelpSearch();
    //조회
    $('#empSearchHelpSearchBtn').on('click', function(){
     empSearchHelpSearch();
    });

    //초기화
    $("#empSearchHelpSearchInitBtn").on('click', function(){
     empSearchHelpSearchInit();
    });


    $.ifvEnterSetting(["#empSearchHelpSearchList input"], function(){
    	empSearchHelpSearch();
	});



});

</script>

<div id="pop_main_div_emp">
	    <div class="page_btn_area">
	        <div class="col-xs-7">
	            <span><spring:message code="L01838" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	            <button class="btn btn-sm" id="empSearchHelpSearchBtn" objCode="empSearchHelpSearchBtn_OBJ"><i class="fa fa-search"></i>
	                <spring:message code="M00135" />
	            </button>
	            <button class="btn btn-sm" id="empSearchHelpSearchInitBtn" objCode="empSearchHelpSearchInitBtn_OBJ">
	                <spring:message code="M00278" />
	            </button>
	        </div>
	    </div>
	    <div class="well form-horizontal well_bt5" id="empSearchHelpSearchList" >
	    </div>



	    <div class="page_btn_area" >
	        <div class="col-xs-7">
	            <span><spring:message code="M00277" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	        </div>
	    </div>
	    <div id="empSearchHelpGrid" class="white_bg grid_bd0"></div>
		<div class="pop_btn_area">
			<ifvm:inputNew type="button" btnType="save"  text="M00282"  id="saveEmpInfoBtn" btnFunc="saveEmpInfoFn" objCode="saveEmpInfoBtn_OBJ"/>
 			<ifvm:inputNew type="button"   text="L00913"  id="cancelEmpInfoBtn" btnFunc="cancelEmpInfoFn" objCode="cancelEmpInfoBtn_OBJ"/>
		</div>
</div>
