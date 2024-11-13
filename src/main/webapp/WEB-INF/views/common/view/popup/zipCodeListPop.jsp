<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var zipCodeListPop;
var gridIdzipCodeListPop;
var rid ;
var zipEmpty = true;
var obj=null;
//주소검색
function getzipCodeListPopSearch(){
	setTimeout(function(){}, 500);

    var jqGridOption = {
        ondblClickRow : function(data){
      var data = zipCodeListPop.getRowData()[data-1];
      rid = data.rid;




        },
        onSelectRow : function (data) {
        	$("#dtlAddrDiv").attr("hidden",false);
        	$("#roadAddr").val(data.roadAddr);
        	$("#jibunAddr").val(data.jibunAddr);
        	obj	= data;

        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }

        	/* data.currentPage = data.page; */
        	data.keyword = $('#addrText').val();
            return data;
        },
        loadComplete : function(obj){
        	$("#dtlAddrDiv").attr("hidden",true);
        },
        url : '<ifvm:action name="getZipCodeList"/>',
        colNames:[
                   '<spring:message code="L01722" />',
                   '<spring:message code="L00640" />',
                   '<spring:message code="L01865" />',

                   'bdMgtSn',
                   'siNm',
                   'sggNm'
                 ],
        colModel:[
             { name:'zipNo',   index:'',  width:'80px', align:'center',sortable:false},
             { name:'roadAddr',   index:'', width:'200px', align:'left',sortable:false},
             { name:'jibunAddr',   index:'', width:'200px', align:'left' ,sortable:false},

             { name:'bdMgtSn',    index:'',    hidden : true},
             { name:'siNm',    index:'',    hidden : true},
             { name:'sggNm',    index:'',    hidden : true}
        ],
        sortname: 'a.rid',
        sortorder: "desc",
        rows: [10],
        radio : true,
        autowidth:true
    };

    zipCodeListPop = $("#zipCodeListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdzipCodeListPop = $("#gridIdzipCodeListPop");
}





//공통 조회 호출
function zipCodeListPopSearch() {
    $.fn.ifvmSubmitSearchCondition("zipCodeListPopSearchList", getzipCodeListPopSearch);
}


function addrTextFieldFocus(){
	if(zipEmpty == true){
		$('#addrText').val("");
	}
}

function addrTextFieldBlur(){

	if( $('#addrText').val()==""){
		$('#addrText').val('<spring:message code="L01727" />');
		zipEmpty = true;

	}else{
		zipEmpty = false;
	}
}
function resetZipCode(){
	obj= "reset";
	addrSearchHelpPop.close(obj);
}

function fnAdrSelectZipCd(){

	obj.dtlAddr = $('#dtlAddr').val();
	addrSearchHelpPop.close(obj);
}
function fnCloseZipCode(){
	addrSearchHelpPop.close();
}

$(document).ready(function() {
	$("#dtlAddrDiv").attr("hidden",true);
	$('#addrText').val('<spring:message code="L01727" />');
   	zipCodeListPopSearch();
    //조회
    $('#zipCodeListPopSearchBtn').on('click', function(){
     zipCodeListPopSearch();
    });

    //초기화
    $("#zipCodeListPopSearchInitBtn").on('click', function(){
     zipCodeListPopSearchInit();
    });

    $('#addrText').on('focus', function(){
        addrTextFieldFocus();
       });
    $('#addrText').on('blur', function(){
        addrTextFieldBlur();
       });
    $('#addrText').focus();
    $('#adrSearchBtn').focus();



    $.ifvEnterSetting(["#searchFormArea input"], zipCodeListPopSearch);

});





</script>


<!-- commSearchList -->
	<div class="form-horizontal underline top_well" id="searchFormArea" >
		<div class="row">
			<ifvm:inputNew type="text" id="addrText" maxLength="500"  dto="addrText"     conClass="6" />
			<ifvm:inputNew type="button" id="adrSearchBtn" btnFunc="zipCodeListPopSearch" btnType="search" text="L00081" objCode="zipCodeadrSearchBtn_OBJ"/>
			<ifvm:inputNew type="button" id="adrSearchBtn" btnFunc="resetZipCode" text="L00082" objCode="resetZipadrSearchBtn_OBJ"/>
		</div>
	</div>

	<div id="guid" class="description_guide">


    			<spring:message code="L01720" />

	</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>
    <div id="zipCodeListPopGrid" class="white_bg grid_bd0"></div>
</div>


<!--  상세 주소 입력 창 -->

<div id ="dtlAddrDiv">
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="L01486" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>
   <div class="row">
			<ifvm:inputNew type="text" id="roadAddr" maxLength="500"  dto="roadAddr"  label="L00640"   labelClass="2" conClass="10" disabled="true" />

		</div>
		<div class="row">
			<ifvm:inputNew type="text" id="jibunAddr" maxLength="500"  dto="jibunAddr"  label="L01865"  labelClass="2" conClass="10" disabled="true" />

		</div>

		<div class="row">
			<ifvm:inputNew type="text" id="dtlAddr" maxLength="500"  dto="dtlAddr"  label="L01486"   labelClass="2" conClass="10" />

		</div>


	<div class="pop_btn_area">
	<ifvm:inputNew type="button" id="adrSelectBtn" btnFunc="fnAdrSelectZipCd" btnType="check" text="C00038" objCode="zipCodeadrSelectBtn"/>
	<ifvm:inputNew type="button" id="closeBtn" btnFunc="fnCloseZipCode" btnType="close" text="M00441" objCode="zipCodecloseBtn_OBJ"/>

	</div>

</div>









<div id="emptyDialog" class="popup_container"></div>



