<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

/************************************************************ 1. 변수 선언부 **************************************************************************/

// 그리드를 담을 변수
var contactList; 					// Contact 리스트 그리드

var objContactDetailPop;

var currentRowData;					// 선택된 Row의 데이터

var removeTransactionFlag = 0;

/************************************************************ 변수 선언부 END **************************************************************************/



/************************************************************ 2. 화면 로드 시 처리 함수 **********************************************************************/

$(document).ready(function() {
   
    setContactListGrid(); // 초기 그리드 세팅
   
    $.ifvEnterSetting(["#bbsNm", "#title"], contactListSearch); // 엔터키 입력 시, 검색을 시키기 위함
    
    $('#contactListSearch').on('click', function(){
    	contactListSearch();
    });
    $('#btnDelContact').on('click', function(){
    	removeContactItems();
    });
});

/************************************************************ 화면 로드 시 처리 함수 END **********************************************************************/




/************************************************************ 3. 그리드 처리 함수 **********************************************************************/
// Contact 리스트 그리드를 그리는 함수
function setContactListGrid() {
    var jqGridOption = {    
           	ondblClickRow : function(data){
           		var rowData = contactList.getRowData()[data-1];
           		currentRowData = rowData;
           		contactDetailPopOpen();
           	},
          	serializeGridData : function( data ){
          		data.status	= $("#status").val().replace("전체", "")
          		data.bbsNm	= $("#bbsNm").val();
          		data.title	= $("#title").val();          	
           	},
           	
           	loadComplete : function(obj){
           	},	
                
      	    url : '<ifvm:action name="getContactList"/>',
    
            colNames:[                       
                      '게시판명', //게시판명
                      '<spring:message code="M00377"/>', //제목                    
                      '<spring:message code="M00465"/>', //업체명
                      '<spring:message code="M00955"/>', //성명
                      '<spring:message code="M00563"/>', //직위
                      '<spring:message code="M00576"/>', //전화번호
                      '<spring:message code="M00583"/>', //이메일     
                      '<spring:message code="M00185"/>', //등록일시
                      '상태',
                      'id',
                      'message',
                      'memo'
                    ],
                    
            colModel:[
                { name:'bbsNm'			, index:'bbsNm'			, resizable : false },
                { name:'title'			, index:'title'			, resizable : false },
                { name:'contCompany'	, index:'contCompany'	, resizable : false },
                { name:'contNm'			, index:'contNm'		, resizable : false },
                { name:'contPost'		, index:'contPost'		, resizable : false },
                { name:'contTel'		, index:'contTel'		, resizable : false },
                { name:'contEmail'		, index:'contEmail'		, resizable : false },
                { name:'createDate'		, index:'createDate'	, resizable : false },
                { name:'status'			, index:'status'		, resizable : false },
                { name:'id'				, index:'id'			, hidden : true },
                { name:'message'		, index:'message'		, hidden : true },
                { name:'memo'			, index:'memo'			, hidden : true }
            ],
                       
            sortname: 'createDate',
            sortorder: "DESC",
            multiselect: true,
            tempId : 'ifvGridOriginTemplete'
        };
        
    contactList = $("#contactListGrid").ifvGrid({ jqGridOption : jqGridOption });
}



//
function contactListSearch() {
    $.fn.ifvmSubmitSearchCondition("contactListGrid", setContactListGrid);
}


function contactDetailPopOpen() {
	objContactDetailPop = $("#contactDetailDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="contactDetailPop"/>',
        contentType: "ajax",
        title: 'Contact Detail',
        width: 1000,
        close : 'contactDetailPopClose'
    });
}

function contactDetailPopClose(closeFlag) {
	currentRowData = null;
	if(closeFlag == true) {
		contactListSearch();
	}
	objContactDetailPop.ejDialog('destroy');
}

function removeContactItems() {
	if($.fn.ifvmIsNotEmpty(contactList)) {
		var delList = contactList.getCheckedList();
		if($.fn.ifvmIsNotEmpty(delList)) {
			if(!confirm('<spring:message code="M00127" />')) return;
			
			removeTransactionFlag = 0;
			for(var idx = 0; idx < delList.length; idx++) {
				removeContactAction(delList[idx].id, delList.length);
			}
		} else {
			alert('<spring:message code="M00104"/>');
		}
	} else {
		alert('<spring:message code="M00104"/>');
	}
}

function removeContactAction(varContactId, delListLength) {
	$.ifvSyncPostJSON('<ifvm:action name="editContactDel"/>', {
		id: varContactId
	}, function(result) {
		if(removeTransactionFlag == delListLength - 1) {
			alert('<spring:message code="M01266" />');
			contactListSearch();
		} else {
			removeTransactionFlag++;
		}
	});
}

/************************************************************ 그리드 처리 함수 END **********************************************************************/
</script>

<div id="pop"></div>
<div class="page-title">
	<h1>
		<spring:message code="M01736"/>
		<span> &gt; CONTACT</span>
		
	</h1>
</div>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M00168"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="contactListSearch"><i class="fa fa-search"></i>
			<spring:message code="M00135"/>
		</button> 
	</div>
</div>

<!-- 조회조건  -->
<div class="well" id="commCodeListFormArea" >
	<div class="row  qt_border">
		<div class="form-horizontal">
			<label class="col-xs-1 control-label"><spring:message code="M00317"/></label>
			<div class="col-xs-3">
				<ifvm:input type="select" id="status" dto="status" text="C00037|M01745|M01745" values="전체|접수|처리완료" checkIndex="1"  />
			</div>
			<label class="col-xs-1 control-label two_line"><spring:message code="M01728"/></label>
			<div class="col-xs-3">
				<ifvm:input type="text" id="bbsNm" dto="bbsNm" maxLength="50" />
			</div>
			<label class="col-xs-1 control-label"><spring:message code="M00377"/></label>
			<div class="col-xs-3">
				<ifvm:input type="text" id="title" dto="title" maxLength="50" />
			</div>
		</div>
	</div>
</div>
<!-- 조회조건 끝 -->

<div class="page_btn_area">
	<div class="col-xs-7">
		<span>Contact List</span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm btn_gray" id='btnDelContact'>
			<i class="fa fa-minus"></i>
			 <spring:message code="M00165"/>
		</button> 	
	</div>
</div>
<div id="contactListGrid" class="white_bg grid_bd0"></div>

<div id="contactDetailDialog" class="popup_container"></div>