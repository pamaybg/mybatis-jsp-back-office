<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="page-title">
	<h1>
		<spring:message code="용어사전 관리" /> &gt; <spring:message code="조회" />
	</h1>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="wordDictionarySearchBtn" objCode="wordDictionarySearchBtn_OBJ">
				<i class="fa fa-search"></i>
				<spring:message code="M00135" />
			</button>
			<button class="btn btn-sm" id="wordDictionarySearchInitBtn" objCode="wordDictionarySearchInitBtn_OBJ">
				<spring:message code="M00278" />
			</button>
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="wordDicSearchList"></div>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-sm-7">
			<span><spring:message code="I02035" /></span>
		</div>
		<div class="col-sm-5 searchbtn_r">
			<ifvm:inputNew type="button" id="dictionaryDetailNewBtn" text="I00887" btnType="plus" objCode="wordDictionaryNewBtn_OBJ" />
			<ifvm:inputNew type="button" id="dictionaryEditBtn" text="M01853" btnType="save" objCode="wordDictionaryEditBtn_OBJ" />
			<ifvm:inputNew type="button" id="dictionaryDelBtn" text="I00888" btnType="minus" objCode="wordDictionaryDelBtn_OBJ" />
		</div>
	</div>
	<div id="wordDictionaryGrid" class="grid_bd0"></div>
</div>
<div id="dialog"></div>

<script>
var wordDictionaryList;
var rid;

function dictionaryList(){
	
	var ejGridOption = {
		rowSelected : function(args) {
			rid = args.data.rid
		}, 
       	recordDoubleClick : function(args){
       		var data = args.data;
       		rid = data.rid;
    		qtjs.href('<ifvm:url name="wordDictionaryDetail"/>?rid='+rid);
       	},
		serializeGridData : function( data ){
			 
			return data;
		},
        dataUrl : '<ifvm:action name="getWordDictionaryList"/>',
        columns: [
        	{
        		field: 'rid', headerText: 'rid', headerTextAlign: 'center', visible: false
        	},
        	{
        		field: 'tag', headerText: '분류', headerTextAlign: 'center',
        	},
        	{
        		field: 'logicalName', headerText: '논리명', headerTextAlign: 'center'
        	}, 
        	{
        		field: 'logicalDesc', headerText: '논리 설명', headerTextAlign: 'center'
        	}, 
        	{
        		field: 'physicalName', headerText: '물리명', headerTextAlign: 'center'
        	}, 
        	{
        		field: 'physicalDesc', headerText: '물리 설명', headerTextAlign: 'center'
        	},
        ],	
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'physicalName',
      	  sord : 'asc',
      	  _search : false
        },
        radio: true,
        tempId : 'ifvGridOriginTemplete',
    };

	wordDictionaryList = $("#wordDictionaryGrid").ifvsfGrid({ ejGridOption });
}

function wordDictionaryListNew(){
	qtjs.href('<ifvm:url name = "wordDictionaryDetail"/>');
}

function wordDicListSearchInit(gridId){
	$.fn.ifvmSetCommonCondList("wordDicSearchList","WORD_DIC_LIST",gridId);
}

//공통 조회 호출
function wordDicListSearch() {
    $.fn.ifvmSubmitSearchCondition("wordDicSearchList", function(){
    	wordDictionaryList.searchGrid({item: requestitem});
    });
} 


//용어사전 목록 삭제
function WordDictionaryDelete(){
	
		if($.fn.ifvmIsNotEmpty(wordDictionaryList)) {
			var delList = wordDictionaryList.opt.gridControl.getSelectedRecords();
			if($.fn.ifvmIsNotEmpty(delList)) {
				if(!confirm('<spring:message code="M00127" />')) return;

				$.ifvSyncPostJSON('<ifvm:action name="delWordDictionary"/>', {
					rid: delList[0].rid
				}, function(result) {
						alert('<spring:message code="M01266" />');
						dictionaryList(); 
				});
			} else {
				alert('<spring:message code="M00108"/>');
			}
		} else {
			alert('<spring:message code="M00108"/>');
		}
}
	
function modifyWordDic(rid){
	qtjs.href('<ifvm:url name="wordDictionaryDetail"/>?rid='+rid);
}

$(document).ready(function(){

    //공통 조회 조건 목록 설정
    wordDicListSearchInit();
	dictionaryList();
	
    //조회
    $('#wordDictionarySearchBtn').on('click', function(){
    	wordDicListSearch();
    });
    
    //초기화
    $("#wordDictionarySearchInitBtn").on('click', function(){
    	wordDicListSearchInit('wordDictionaryList');
    });

    //신규 클릭시
     $('#dictionaryDetailNewBtn').on('click', function(){
     	wordDictionaryListNew();
     }); 
    
    //수정
     $('#dictionaryEditBtn').on('click', function(){
    	 modifyWordDic(rid);
     }); 
    
    //삭제
    $("#dictionaryDelBtn").on('click',function(){
    	WordDictionaryDelete();
    });    
});

</script>