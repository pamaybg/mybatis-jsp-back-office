<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page-title">
    <h1>
    	<spring:message code="API등록 및 조회" /> &gt; <spring:message code="조회" />
    </h1>
</div>



<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="apiSpecSearchBtn" objCode="apiSpecListSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="apiSpecClearBtn" objCode="apiSpecListInit_OBJ">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="getApiSpec" >
    </div>
</div>

<div>
	<div class="page_btn_area">
	    <div class="col-xs-7">
	        <span>API 명세서 목록</span>
	    </div>
	    <div class="col-xs-5 searchbtn_r">
	    	<button class="btn btn-sm" id="apiSpecNewBtn" objCode="apiSpecListAdd_OBJ"><%-- 신규 --%>
	        	<spring:message code="M00274" />
	   		</button>
	   		<button class="btn btn-sm" id='apiSpecRemoveBtn' objCode="apiSpecListDel_OBJ"><%-- 삭제 --%>
	        	<spring:message code="M00165" />
	    	</button>
	    </div>
	 </div>
	 <div id="apiSpecGrid" class="white_bg grid_bd0"></div>
 </div>
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

var apiSpecGrid = '<%= cleanXss(request.getParameter("apiSpecGrid")) %>';
var rid = '<%= cleanXss(request.getParameter("rid")) %>';
function getApiSpecList(){
	var ejGridOption = {
	      	serializeGridData : function( data ){
	      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
	      			data.item = requestitem;
	            }
	      	
	       	},
	       	recordDoubleClick : function(args){
	    		rid = args.data.rid;
	    		qtjs.href('<ifvm:url name="apiSpecNew"/>' + '?rid=' + rid);
	    	},
	       	rowSelected : function(args){
	    		rid = args.data.rid;
	       	},
	       	dataUrl : '<ifvm:action name="getApiSpecList"/>',
	        columns:[ 
	        	  {
		      		  field : 'apiGrpCdNm', headerText : '분류', headerTextAlign : 'center', textAlign : 'center', customAttributes : { index : 'apiGrpCd'}, width : '9%'
		      	  },{
		      		  field : 'apiNo', headerText : 'API No', headerTextAlign : 'center', textAlign : 'center', width : '9%'
		      	  },{
		      		  field : 'apiNm', headerText : 'API명 ', headerTextAlign : 'center', textAlign : 'left'
		      	  },{
		      		  field : 'reqUrl', headerText : 'URL', headerTextAlign : 'center', textAlign : 'left', customAttributes : { index : 'lam.API_URL'}
		      	  },{
		      		  field : 'statCdNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center', customAttributes : { index : 'statCd'}, width : '7%'
		      	  },{  
		      		  field : 'modifyDate', headerText : '수정일', headerTextAlign : 'center', textAlign : 'center', width : '12%'
		      	  },{  
		      		  field : 'modifyBy', headerText : '수정자', headerTextAlign : 'center', textAlign : 'center', width : '12%'
		      	  }/*, {  
		      		  field : 'httpMethodCdNm', headerText : 'Http 메소드', headerTextAlign : 'center', textAlign : 'center'
		      	  },{
		      		  field : 'httpContentTypeCdNm', headerText : 'Http 컨텐츠', headerTextAlign : 'center', textAlign : 'center'
		      	  } */,{
		      		  field : 'rid', headerText : 'rid', visible : false /* rid */
		      	  },
		      	  
	        ],
	        requestGridData : {
		    
		      	  rows : 10,
		      	  sidx : 'apiNo ASC, createDate',
		      	  sord : 'DESC',
		      	  _search : false
		    },
		    rowList : [10,25,50,100],
	        autowidth : true ,
	        radio : true,
	        tempId : 'ifvGridNotSearchTemplete'
	    };
	apiSpecGrid = $("#apiSpecGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//삭제
function deleteApiSpec(){
	var list = apiSpecGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		var stat = list[0].statCd
		if(stat == "W"){
			var rid = list[0].rid;
			if(!confirm('<spring:message code="C00079" />')) return;
			$.ifvSyncPostJSON('<ifvm:action name="deleteApiSpec"/>', {
				rid: rid
			}, function(result) {
				alert('<spring:message code="M01266" />');
				getApiSpecList()
			});
		}else{
			alert('<spring:message code="작성중일때만 삭제가 가능합니다." />');
		}
		
	} else {
		alert('<spring:message code="L00066" />');
	}
}

 	
	
function apiSpecSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("getApiSpec","API_SPEC", gridId);

}

//공통 조회 호출
function apiSpecSearch() {
   $.fn.ifvmSubmitSearchCondition("getApiSpec", getApiSpecList);
}


$(document).ready(function() {
 	
	apiSpecSearchInit();
	apiSpecSearch();
 	
    $('#apiSpecSearchBtn').on('click', function(){
    	apiSpecSearch();
    });
 	//초기화
 	$("#apiSpecClearBtn").on('click', function(){
 		apiSpecSearchInit("getApiSpec");
 	});
 	getApiSpecList();
    //신규
    $("#apiSpecNewBtn").on('click', function(){
    	qtjs.href('<ifvm:url name="apiSpecNew"/>');
    });
  
    //삭제
    $("#apiSpecRemoveBtn").on('click', function(){
    	deleteApiSpec();
    });
    
});

</script>