<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var insureContList;
var gridIdinsureContList;
var rid ;

//보험이력조회
function getinsureContListSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
      var data = insureContList.getRowData()[data-1];
      rid = data.rid;
        },
        onSelectRow : function (data) {
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
        	data.startYM = $("#startYM").val();
            return data;
        },
        loadComplete : function(obj){
        },
        url : '<ifvm:action name="getInsureContList"/>',
        colNames:[
                   '<spring:message code="L01610" />',
                   '<spring:message code="L01611" />',
                   '<spring:message code="L01612" />',
                   '<spring:message code="L01613" />',
                   '<spring:message code="L01614" />',
                   '<spring:message code="L01615" />',
                   '<spring:message code="L01616" />',
                   '<spring:message code="L01617" />',
                   '<spring:message code="L01618" />',
                   '<spring:message code="L01619" />',
                   '<spring:message code="L01620" />',
                   '<spring:message code="L01621" />',
                   'rid',
                   '',
                   '',
                   '',
                   ''
                 ],
        colModel:[
             { name:'insuType',   index:'cc1.mark_name',  resizable : true, align:'center',    width:'100px' },
             { name:'policyNum',   index:'a.policy_num',  resizable : true, align:'center',    width:'100px' },
             { name:'eduMemberTypeCd',   index:'cc2.mark_name',  resizable : true, align:'center',    width:'100px' },
             { name:'startDt',   index:'a.start_dt',  resizable : true, align:'center' ,  width:'100px' },
             { name:'endDt',   index:'a.end_dt',  resizable : true, align:'center' ,  width:'100px' },
             { name:'cancelDt',   index:'a.cancel_dt',  resizable : true, align:'center',    width:'100px' },
             { name:'contractMbrNo',   index:'e.mbr_no',  resizable : true, align:'center',    width:'100px' ,formatter : goGridRowMbrLink1 },
             { name:'contractName',   index:'a.contract_name',  resizable : true, align:'center',    width:'100px' },
             { name:'insureMbrNo',   index:'c.mbr_no',  resizable : true, align:'center',    width:'100px' ,formatter : goGridRowMbrLink2},
             { name:'insureName',   index:'a.insure_name',  resizable : true, align:'center',    width:'100px' },
             { name:'insureGetYn',   index:'a.insure_get_yn',  resizable : true, align:'center',    width:'100px' },
             { name:'ligPromoMemSeq',   index:'a.lig_promo_mem_seq',  resizable : true, align:'center',    width:'100px' },

             { name:'rid',    index:'a.rid',    hidden : true},
             { name:'contractRidMbr',    index:'contractRidMbr',    hidden : true},
             { name:'contractMemDivCd',    index:'contractMemDivCd',    hidden : true},
             { name:'insureRidMbr',    index:'insureRidMbr',    hidden : true},
             { name:'insureMemDivCd',    index:'insureMemDivCd',    hidden : true}
        ],
        sortname: 'a.start_dt',
        autowidth : true , sortorder: "desc",
        radio : true
    };

    insureContList = $("#insureContListGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdinsureContList = $("#gridIdinsureContList");
}

//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink1(cellvalue, options, rowObjec){
	var id = rowObjec.contractRidMbr;

    if( id !=null){
    	if( rowObjec.contractMemDivCd == 'P' ||rowObjec.contractMemDivCd == 'T' ){
    	    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;

    	}else{
    	    var url = '<ifvm:url name="mbrGroupDetail"/>' + '?rid=' + id;

    	}
    	 var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    	 return tag;
    }else{
    	return "";
    }
}
function goGridRowMbrLink2(cellvalue, options, rowObjec){
	var id = rowObjec.insureRidMbr;

    if( id !=null){
    	if( rowObjec.insureMemDivCd == 'P' ||rowObjec.insureMemDivCd == 'T' ){
    	    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;

    	}else{
    	    var url = '<ifvm:url name="mbrGroupDetail"/>' + '?rid=' + id;

    	}
    	 var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    	 return tag;
    }else{
    	return "";
    }
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

//공통 조회 호출
function insureContListSearch() {
    $.fn.ifvmSubmitSearchCondition("insureContListSearchList", getinsureContListSearch);
}
// 상세 팝업 화면 호출
function emptyDtlPop(){

 $("#emptyDialog").ifvsfPopup({
  enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="empty"/>' + '?rid=' + rid ,
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

function getStartYm(){
	var result  = new Array();
	var date = new Date();
	var year  = date.getFullYear();
	var month = date.getMonth()+1; // 0부터 시작하므로 1더함 더함
	var monthText;
	result.push({yearMonth : "" ,yearMonthText: "=="+'<spring:message code="L02039" />'+"=="});
	for( i=0; i<12; i++){
		if(month-i==0){
			year = year-1;
			monthText = "12";
		}else{
			monthText = month-i;
			if(monthText<0){
				monthText = monthText+12;
			}
			if (("" + monthText).length == 1) {
				monthText = "0" + monthText;
			}else{
				monthText= "" + monthText;
			}
		}

		result.push({yearMonth: year+""+monthText ,
					yearMonthText: year+'<spring:message code="M01062" />'+monthText+'<spring:message code="M01061" />'});
}

 var temp = $("#startYMTemp").tmpl(result);
 $("#startYM").append(temp);

}

$(document).ready(function() {

	//$("#insureContListGrid").ifvGrid({ jqGridOption : {} });

    getStartYm();

    getinsureContListSearch();
    /* $("#startYM").change(function(){
    	insureContListSearch();
    	    }); */



});
</script>



<script id="startYMTemp" type="text/x-jquery-tmpl">
<option value="${'${'}yearMonth}">${'${'}yearMonthText}</option>
</script>

<div class="page-title">
    <h1>
       <spring:message code="L01623" />
       &gt;<spring:message code="L00081"/>
    </h1>
</div>

<div>

    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">

        </div>
    </div>


</div>


	<div class="form-horizontal underline top_well" id="searchFormArea" >
		<div class="row">
    	<ifvm:inputNew type="select" id="startYM" maxLength="50"  dto="startYM"  required="true"  labelClass="0" conClass="2" />
    	<ifvm:inputNew type="button" btnFunc="insureContListSearch" btnType="search" text="L00081" />
    	</div>
   </div>


<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload2('insureContListGrid')" />
        </div>
    </div>
    <div id="insureContListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="emptyDialog" class="popup_container"></div>


