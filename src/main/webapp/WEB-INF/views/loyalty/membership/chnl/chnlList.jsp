<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var chnlListGrid;

//목록
function getChnlList(page){
    
    var page = $.fn.ifvmIsNotEmpty(page) ? page : 1; 
    
    var jqGridOption = {
        serializeGridData : function( data ){
        	
        	//페이지 설정
        	data.page = page;
        	
            return data;
        },
        ondblClickRow : function (rowNo) {
        	var data = chnlListGrid.getRowData()[rowNo-1];
        	
        	gochnlDetail(data.rid);
        },
        url : '<ifvm:action name="getChnlList"/>',
     
        colNames:[ 
                   '<spring:message code="L00128"/>',
                   '<spring:message code="L00129"/>',
                   '<spring:message code="L00132"/>',
                   '<spring:message code="L00133"/>',
                   '<spring:message code="L00336"/>',
                   '<spring:message code="L00130"/>',
                   '<spring:message code="L00410"/>',
                   '<spring:message code="L00131"/>',
                   '<spring:message code="L00090"/>',
                   'rid'                
                 ],
        colModel:[
            { name:'chnlNo', 		index:'a.chnl_no', 			width:'80px', 	align: 'center', 	resizable : false },
            { name:'chnlNm', 		index:'a.chnl_nm', 			width:'150px', 	align: 'left', 	    resizable : true  },
            { name:'chnlTypeNm', 	index:'e.mark_name', 		width:'100px', 	align: 'left', 		resizable : true  },
            { name:'chnlTypeSubNm', index:'f.mark_name', 	    width:'100px', 	align: 'left', 		resizable : true  },
            { name:'parChnlNo', 	index:'c.chnl_no', 		    width:'80px', 	align: 'center', 	resizable : true  },
            { name:'parChnlNm',     index:'c.chnl_nm',          width:'150px', 	align: 'left', 	resizable : true  },
            { name:'topChnlNo', 	index:'d.chnl_no', 		    width:'100px', 	align: 'center', 	resizable : true  },
            { name:'topChnlNm',     index:'d.chnl_nm',          width:'150px', 	align: 'left', 	resizable : true  },
            { name:'chnlStatNm',    index:'g.mark_name',        width:'80px', 	align: 'center', 	resizable : false },            
            { name:'rid', 			index:'a.rid', 				hidden : true } 
        ],
        sortname: 'a.chnl_no',
        autowidth : true , sortorder: "asc",
        radio: true,
        tempId : 'ifvGridOriginTemplete'
    };
    
    chnlListGrid = $("#chnlListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//상세 이동
function gochnlDetail(id) {
    qtjs.href('<ifvm:url name="chnlDetail"/>' + '?rid=' + id);
}

//그리드 텍스트 선택시 상세로 이동
function goGridRowLink(cellvalue, options, rowObjec){
    var id = rowObjec.rid;
    var url = '<ifvm:url name="chnlDetail"/>?rid=' + id; 
    var tag = '<a href="' + url + '" >' + cellvalue + '</a>';
    
    return tag;
}

//공통 조회 조건 목록 설정
function searchCondInit() {
    $.fn.ifvmSetCommonCondList("chnlSearchList","PLOY_020");
}

//공통 조회 호출
function chnlListSearch() {
    $.fn.ifvmSubmitSearchCondition("chnlSearchList", getChnlList);
}

//삭제
function removeAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(chnlListGrid.getCheckedGridData()[0])) {
    	v_rid = chnlListGrid.getCheckedGridData()[0].rid;
    }
    else {
        alert('<spring:message code="M00108"/>');
    }
    
    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        if (confirm('<spring:message code="L00086"/>')) {
            $.ifvProgressControl(true);
            
            // 삭제
            $.ifvPostJSON('<ifvm:action name="removeChnl"/>', {
                rid: v_rid
            },
            function(result) {
                alert('<spring:message code="L00085"/>');
                
                //목록
                getChnlList(getGridPage());
                
                $.ifvProgressControl(false);
            },
            function(result) {                
                $.errorChecker(result);                
                $.ifvProgressControl(false);
            });
        }
    } 
}

//페이지 구하기
function getGridPage() {
    var rtnVal = 1;
    var page = chnlListGrid.opt.data.page;
    var total = chnlListGrid.opt.data.records;
    
    if (total % page > 0) {
        rtnVal = page;
    }
    
    return rtnVal;
}

$(document).ready(function() {
    getChnlList();
    
    //공통 조회 조건 목록 설정
    searchCondInit();
    
    //조회
    $('#searchCondBtn').on('click', function(){
    	chnlListSearch();
    });
    
    //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit();
    });
    
    //신규 클릭시
    $('#addBtn').on('click', function(){
    	qtjs.href('<ifvm:url name="chnlDetail"/>');
    });
    
    //삭제 클릭시
    $('#removeBtn').on('click', function(){
        removeAction();
    });
});

</script>

<div class="page-title">
    <h1>
        <spring:message code="L00135"/>        
        &gt; <spring:message code="L00081"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button> 
            <button class="btn btn-sm" id="searchCondInitBtn">
                <spring:message code="L00082"/>
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="chnlSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="L00084"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="addBtn"><i class="fa fa-plus"></i>
                <spring:message code="L00078"/>
            </button>
            <button class="btn btn-sm" id="removeBtn"><i class="fa fa-minus"></i>
                <spring:message code="L00080"/>
            </button>  
        </div>
    </div>
    <div id="chnlListGrid" class="white_bg grid_bd0"></div>     
</div>