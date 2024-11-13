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
var mbrSearchHelp;
var gridIdmbrSearchHelp;
var rid ;
var mbrsel_obj=null;
var first;
var mbrNo = decodeURIComponent('<%= cleanXss(request.getParameter("mbrNo")) %>');
var mbrNm = decodeURIComponent('<%= cleanXss(request.getParameter("mbrNm")) %>');
var obj = null;

$(document).ready(function() {
    //공통 조회 조건 목록 설정

    mbrSearchHelpSearchInit();

    first = 'X';
    defaultSearch();
    mbrSearchHelpSearch(first);
    first = '';

    $("#mbrSearchHelpSearchList .searchTextVal option:selected").filter(function(){
    	if($(this).attr('joinsrcclm') != "CUST_NM"){
    		$(this).parents('.SearchCondition').find('.searchCondition option[value="NOT"]').remove();
    		$(this).parents('.SearchCondition').find('.searchCondition option[value="LIKE"]').remove();
    	}
    })
    //조회
    $('#mbrSearchHelpSearchBtn').on('click', function(){
     	mbrSearchHelpSearch(first);
    });

    //초기화
    $("#mbrSearchHelpSearchInitBtn").on('click', function(){
     	mbrSearchHelpSearchInit();
    });

    $.ifvEnterSetting(["#mbrSearchHelpSearchList input"], function(){
    	mbrSearchHelpSearch(first);
	});
});

//회원 SearchHelp
function getMbrSearchHelpSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
// 	      var data = mbrSearchHelp.getRowData()[data-1];
// 	      obj = data;
  			choiceMbrFn();
        },
        onSelectRow : function (data) {
        	obj = data
        },
        serializeGridData : function(data) {
        	if ($.fn.ifvmIsNotEmpty(requestitem)) {
        	    data.hhpSearhFlag = "N";
            	for(var i = 0; i < requestitem.length; i++) {
            		//핸드폰 번호 암호화해서 조회하기
            		if (requestitem[i].srcCol == "HHP_NO"  && requestitem[i].whereVal != "") {
            			requestitem[i].whereVal= requestitem[i].whereVal.replaceAll("-", "");

        		    	data.hhpSearhFlag = "Y";
        		    	data.hhpSearhOpType = requestitem[i].operationType;
        		    	data.hhpSearhValue = requestitem[i].whereVal;

        		    	requestitem[i].whereVal = "";
            		}
            	}
                data.item = requestitem;
                data.first = first;
            }
            return data;
        },
        onSelectCell : function(data) {
        	mbrsel_obj	= data;
        },
        loadComplete : function(data) {
        	
        	//로그 저장 -> 회원상세로 들어갈때만 로그저장 하게 바꿈
    		//$.fn.ifvmComCondLogging("STMP_POP_001", mbrSearchHelp.getRowData().length);
        	
//         	if (data.rows.length == 1) {
//         		obj = data.rows[0];
//         		choiceMbrFn();
//         	}
//         	defaultSearchClose();
        },
        url : '<ifvm:action name="getMbrSearchHelp"/>',
        colNames:[
                   '<spring:message code="M00688" />',	//회원번호
                   '<spring:message code="M02175" />',	//이름
                   '<spring:message code="L00436" />',	//휴대폰
                   '<spring:message code="M02018" />',	//생년월일
                   '<spring:message code="M00705" />',	//회원 구분
                   '<spring:message code="L01244" />',	//회원상태
                   '<spring:message code="M02168" />',	//이메일
                   'webMemId',
                   'tierCd',
                   'ridCust',
                   'rid'
		],
        colModel:[
             { name:'mbrNo',       index:'a.mbr_no',  		resizable : true, align:'center',},
             { name:'custNm',      index:'b.cust_nm',  		resizable : true, align:'center',},
             { name:'hhpNo',   	   index:'a.hhp_no',  		resizable : true, align:'center',},
             { name:'realBirthDt', index:'b.real_birth_dt', resizable : true, align:'center', formatter:insertDot },
             { name:'mbrType',     index:'c.mark_name',  	resizable : true, align:'center',},
             { name:'mbrStatNm',   index:'cc.mark_name',	resizable : true, align:'center',},
             { name:'emailAddr',   index:'a.email_addr', 	resizable : true, align:'center',},
             { name:'webMemId',    index:'a.wb_mem_id',  	hidden : true},
             { name:'tierCd',      index:'d.TIER_CD',   	hidden : true},
             { name:'ridCust',     index:'b.rid',    		hidden : true},
             { name:'rid',         index:'a.rid',    		hidden : true}
        ],
        sortname: 'a.rid',
        sortorder: "desc",
        radio: true,
        rowList:[5]
    };

    mbrSearchHelp = $("#mbrSearchHelpGrid").ifvGrid({
        jqGridOption : jqGridOption
    });
    gridIdmbrSearchHelp = $("#gridIdmbrSearchHelp");

    mbrSearchHelp.resize();
}
//생년월일 구분자 추가
function insertDot(cellvalue, options, rowObject){
	if(cellvalue){
		return cellvalue.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
	}
	else{
		return "";
	}
}
//공통 조회 조건 목록 설정
function mbrSearchHelpSearchInit() {
    $.fn.ifvmSetCommonCondList("mbrSearchHelpSearchList","STMP_POP_001");
    searchInitialize();
}
//조회조건 like default equal로 변경
function searchInitialize(){
	$(".SearchCondition .searchCondition").val("EQUAL(=)")
}

//공통 조회 호출
function mbrSearchHelpSearch(first) {

    if (first === '') {

        var input = false
        $($('#mbrSearchHelpSearchList').find('input')).each(function(index, item) {
            if ($(item).val() != '' && $(item).val() != null) {
                input = true;
            }
        });
        if (!input) {
            // 조회 조건을 입력하세요.
            alert("<spring:message code='L00911'/>");
            return;
        }
//         if ($("#mbrSearchHelpSearchList .searchTextVal option:selected[joinsrcclm='CUST_NM']").parents('.SearchCondition').find('.changeTypeAreaCode input').val().length == 1) {
//             alert('<spring:message code="L01986"/>');// 회원명은 한 자 이상 입력해주세요
//             return;
//         }
    }

    $.fn.ifvmSubmitSearchCondition("mbrSearchHelpSearchList", getMbrSearchHelpSearch);
}

//팝업 닫기
function emptyPopClose() {
 $('#emptyDialog').ejDialog('destroy');
}

//고객 상세 이동
function emptyDtl() {
    qtjs.href('<ifvm:url name="empty"/>' + '?rid=' + rid);
}

function retrunMbr() {
// 	gMbrSearchHelp.close();
	stmpMbrTgtNewPopClose();
}

function defaultSearch() {

    if (typeof mbrNo != "undefined" && mbrNo != "undefined" && $.fn.ifvmIsNotEmpty(mbrNm) && mbrNo != "null") {
        first = '';

        $("#pop_main_div_mbr .SearchCondition .searchTextVal option:selected").filter(function() {
            if ($(this).attr('joinsrcclm') == "MBR_NO") {
                $(this).parents('.SearchCondition').find('.changeTypeAreaCode input').val(mbrNo)
            }
        });
    }

    if (typeof mbrNm != "undefined" && mbrNm != "undefined" && $.fn.ifvmIsNotEmpty(mbrNm) && mbrNm != "null") {
        first = '';

        $("#pop_main_div_mbr .SearchCondition .searchTextVal option:selected").filter(function() {
            if ($(this).attr('joinsrcclm') == "CUST_NM") {
                $(this).parents('.SearchCondition').find('.changeTypeAreaCode input').val(mbrNm)
            }
        });
    }
}

//선택
function choiceMbrFn() {
	if (obj != null) {
// 		mbrsel_obj = obj;
// 		mbrSearchHelpPop.close(mbrsel_obj);
		$.ifvSyncPostJSON('<ifvm:action name="setLoyStmpMbrTgt"/>', {
			ridStmp : ridStmp
			, mbrNo : mbrsel_obj.mbrNo
		}, function(result) {
			alert("<spring:message code='L00076'/>"); //저장되었습니다.
			stmpMbrTgtList.searchGrid({});
			cancelMbrSearchHelpFn();
		}, function(result) {
			if(result.message === '1') {
				alert('이미 등록된 회원입니다.');
			} else {
				$.errorChecker(result);
			}
		});
	}
	else {
		alert('<spring:message code="L01393" />');
		return;
	}
}

//닫기
function cancelMbrSearchHelpFn() {
// 	mbrSearchHelpPop.close();
	stmpMbrTgtNewPopClose();
}

</script>

<div id="pop_main_div_mbr">
	<div>
	    <div class="page_btn_area">
	        <div class="col-xs-7">
	            <span><spring:message code="L01838" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	            <button class="btn btn-sm" id="mbrSearchHelpSearchBtn" objCode="mbrSearchHelpStmpSearchBtn_OBJ"><i class="fa fa-search"></i>
	                <spring:message code="M00135" />
	            </button>
	            <button class="btn btn-sm" id="mbrSearchHelpSearchInitBtn" objCode="mbrSearchHelpStmpSearchInitBtn_OBJ">
	                <spring:message code="M00278" />
	            </button>
	        </div>
	    </div>
	    <div class="well form-horizontal well_bt5" id="mbrSearchHelpSearchList" ></div>
	</div>

	<div class="page_btn_area" >
		<div class="col-xs-12">* 휴대폰 전체검색시 [-] 없이 입력 후 검색하세요. </div>
<!-- 		<div class="col-xs-12">* 휴대폰 Like 검색은 휴대폰번호 뒷자리 4자리만 검색 가능합니다.</div> -->
	</div>

	<div>
	    <div class="page_btn_area" >
	        <div class="col-xs-7">
	            <span><spring:message code="M00277" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	        </div>
	    </div>
	    <div id="mbrSearchHelpGrid" class="white_bg grid_bd0"></div>
	</div>

	<div id="emptyDialog" class="popup_container"></div>

	<div class="pop_btn_area">
		<ifvm:inputNew type="button" btnType="save"  text="C00038"  id="choiceMbrBtn" btnFunc="choiceMbrFn" objCode="choiceMbrStmpBtn_OBJ"/>
		<ifvm:inputNew type="button"   text="M00441"  id="cancelMbrSearchHelpBtn" btnFunc="cancelMbrSearchHelpFn" objCode="cancelMbrSearchHelpStmpBtn_OBJ"/>
	</div>
</div>