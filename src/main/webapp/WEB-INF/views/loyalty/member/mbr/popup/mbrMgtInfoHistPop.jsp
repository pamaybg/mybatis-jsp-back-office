<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 회원관리정보 이력 리스트 그리드 화면 -->
<%!
public String cleanXss(String str){ 
	
	if(str != null){
		str = str.replaceAll("<","&lt;"); 
		str = str.replaceAll(">","&gt;"); 
	}
	return str; 
}
%>
<div>
    <div id="mbrMgtInfoHistGrid" class="white_bg grid_bd0"></div>
</div>

<div class="pop_btn_area">
	<!-- 닫기 버튼 -->
	<button class="btn btn-sm btn_gray" id="btnClose">
		<spring:message code="L01781"/>
	</button>
</div>


<script>
	// 이력을 확인할 대상 레코드의 rid
	var recordRid = '<%= cleanXss(request.getParameter("recordRid")) %>';
	var mbrMgtInfoHistGrid = null;
	
	function getMbrMgtInfoHistList() {
		
		var ejGridOption = {
				serializeGridData : function(data) {
					data.ridMbrMgtAttr = recordRid;
					data.ridMbr = mbr_rid;
					return data;
				},
				//rowSelected : function(args) {},
				//recordDoubleClick : function(args){},
		        dataUrl : '<ifvm:action name="getMbrMgtInfoHistList"/>',
		        columns : [  
	        	  { field: 'attrCdNm', headerText: '회원관리 속성', width: '100px', textAlign : 'center', customAttributes: { searchable: true, index: 'attrCdNm' } }
					/*, { field: 'mgtYn', headerText: '관리여부', width: '50px', textAlign : 'center', customAttributes: { searchable: true, index: 'mgtYn'} }
                    , { field: 'attrSubCdNm', headerText: '속성값', width: '80px', textAlign : 'center', customAttributes: { searchable: true, index: 'attrSubCdNm' } }
                    , { field: 'evalCdNm', headerText: '활동평가', width: '50px', textAlign : 'center', customAttributes: { searchable: true, index: 'evalCdNm' } }*/
		      	, { field: 'modifyDate', headerText: '수정일자', width: '100px', textAlign : 'center' }
		      	, { field: 'modifyBy', headerText: '수정자', width: '80px',  textAlign : 'center' }
				, { field: 'xExpreDt', headerText: '만료일자', width: '100px', textAlign : 'center' }
		      	/*, { field: 'createDate', headerText: '등록일자', visible: false, width: '100px', textAlign : 'center' }
		      	, { field: 'createBy', headerText: '등록자', visible: false, width: '80px', textAlign : 'center' }*/
		      	, { field: 'rid', headerText: 'rid', visible: false }
		        ],
		 	    // 그리드 데이터 정렬 조건 부여
		        requestGridData : {
		      	  sidx : 'modifyDate',
		      	  sord : 'desc'
		      	  //nd   : new Date().getTime(),
		          //rows : 10,
		      	  //_search : false,
		        },
		        // 그리드 데이터 초기부터 출력될지 여부 설정
		        gridDataInit: true,
		        radio: true,
		        //tempId: 'ifvGridSimplePageTemplete2'
		        //rowList : [10,25,50,100]	          
		    };
		
		 mbrMgtInfoHistGrid = $("#mbrMgtInfoHistGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	}//end getMbrMgtInfoHistList
	
	//이력 팝업 닫기
	function closeMbrMgtInfoHistPopup(){
		mbrMgtInfoHistPopupContainer._destroy();
	}
	
	
	$(document).ready(function() {
		// 그리드 화면 구성
		getMbrMgtInfoHistList();
		
		// 닫기 클릭 시
		$("#btnClose").click(function(){
			closeMbrMgtInfoHistPopup();
		});
		
	});

</script>