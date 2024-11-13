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
var channelSearchHelp;
var gridIdchannelSearchHelp;
var rid ;
var ouTypeCd = '<%= cleanXss(request.getParameter("ouTypeCd")) %>';
var chnlNo = decodeURIComponent('<%= cleanXss(request.getParameter("chnlNo")) %>');
var chnlNm = decodeURIComponent('<%= cleanXss(request.getParameter("chnlNm")) %>');


var obj=null;

//가맹점 SearchHelp
function getchannelSearchHelpSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
      var data = channelSearchHelp.getRowData()[data-1];
      rid = data.rid;

      //retrunChannel();
        },
        onSelectRow : function (data) {

        },
        onSelectCell : function( data ){
         	obj	= data;
         },

       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }

      		data.ouTypeCd = ouTypeCd;
            return data;
        },
        loadComplete : function(data){
         	if(data.rows.length==1){
        		obj = data.rows[0];
        		choiceChannelFn();
        	}
        	defaultSearchClose();
        },
        url : '<ifvm:action name="getChannelSearchHelp"/>',
        colNames:[
                   '<spring:message code="L00564" />',
                   '<spring:message code="L00565" />',
                   '<spring:message code="L00383" />',
                   '<spring:message code="M01801" />',
                   '<spring:message code="L00400" />',
                   '<spring:message code="M01797" />',
                   'rid',
                   'apvRqtInstn',
                   'bizrNo'

                 ],
        colModel:[
             { name:'chnlNo',   index:'a.chnl_no',  resizable : true, align:'center',    width:'100px' },
             { name:'chnlNm',   index:'a.chnl_nm',  resizable : true, align:'center',    width:'100px' },
             { name:'zipCd',   index:'a.zip_cd',  resizable : true, align:'center',    width:'100px' },
             { name:'adrDtl',   index:'a.adr_Dtl',  resizable : true, align:'center',    width:'500px' },
             { name:'hpNo',   index:'a.hp_no',  resizable : true, align:'center',    width:'100px', sortable:false },
             { name:'reprNm',   index:'a.repr_nm',  resizable : true, align:'center',    width:'100px' },
             { name:'rid',    index:'a.rid',    hidden : true},
             { name:'apvRqtInstn',    index:'lvr.APV_RQT_INSTN',    hidden : true},
             { name:'bizrNo',    index:'a.bizr_no',    hidden : true}
        ],
        sortname: 'a.rid',
        sortorder: "desc",
        radio : true
    };

    channelSearchHelp = $("#channelSearchHelpGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdchannelSearchHelp = $("#gridIdchannelSearchHelp");
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
function channelSearchHelpSearchInit() {
    $.fn.ifvmSetCommonCondList("channelSearchHelpSearchList","PGM_L_108");
}

//공통 조회 호출
function channelSearchHelpSearch() {
    $.fn.ifvmSubmitSearchCondition("channelSearchHelpSearchList", getchannelSearchHelpSearch);
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

function retrunChannel(){

	gChannelSearchHelp.close();
}

//팝업 닫기
function emptyPopClose() {
	emptyDialog._destroy();
}

//고객 상세 이동
function emptyDtl() {
    qtjs.href('<ifvm:url name="empty"/>' + '?rid=' + rid);
}

function defaultSearch(){


	 if(typeof chnlNo != "undefined" && chnlNo != "undefined"
		 && $.fn.ifvmIsNotEmpty(chnlNo) && chnlNo != "null") {

	$("#pop_main_div_chnl .SearchCondition .searchTextVal option:selected").filter(function(){
		if($(this).attr('joinsrcclm') == "CHNL_NO"){ $(this).parents('.SearchCondition').find('.changeTypeAreaCode input').val(chnlNo)}
		})

	}
	 if(typeof chnlNm != "undefined" && chnlNo != "undefined"
		 && $.fn.ifvmIsNotEmpty(chnlNm) && chnlNm != "null") {

	$("#pop_main_div_chnl .SearchCondition .searchTextVal option:selected").filter(function(){
		if($(this).attr('joinsrcclm') == "CHNL_NM"){ $(this).parents('.SearchCondition').find('.changeTypeAreaCode input').val(chnlNm)}
		})

	}


}
function defaultSearchClose(){
	 if(typeof chnlNo != "undefined" && chnlNo != "undefined"  && $.fn.ifvmIsNotEmpty(chnlNo) && chnlNo != "null") {
		if(channelSearchHelp.getRowData().length==1){
			channelSearchHelpPop.close(channelSearchHelp.getRowDatas(1));
		}
		chnlNo = "null";
	 }
}

//선택
function choiceChannelFn(){
 	if(obj!=null){
		channelSearchHelpPop.close(obj);
	}else{
		alert('<spring:message code="L01393" />');
	}
}
//닫기
function cancelChnnelSearchHelpFn(){
	channelSearchHelpPop.close();
}

$(document).ready(function(){
    //공통 조회 조건 목록 설정
    channelSearchHelpSearchInit();
    defaultSearch();
    channelSearchHelpSearch();
    //조회
    $('#channelSearchHelpSearchBtn').on('click', function(){
     channelSearchHelpSearch();
    });

    //초기화
    $("#channelSearchHelpSearchInitBtn").on('click', function(){
     channelSearchHelpSearchInit();
    });




    $.ifvEnterSetting(["#channelSearchHelpSearchList input"], function(){
    	 channelSearchHelpSearch();
	});

});

</script>
<div id="pop_main_div_chnl">
	<div>
	    <div class="page_btn_area">
	        <div class="col-xs-7">
	            <span><spring:message code="L01838" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	            <button class="btn btn-sm" id="channelSearchHelpSearchBtn" objCode="channelSearchHelpSearchBtn_OBJ"><i class="fa fa-search"></i>
	                <spring:message code="M00135" />
	            </button>
	            <button class="btn btn-sm" id="channelSearchHelpSearchInitBtn" objCode="channelSearchHelpSearchInitBtn_OBJ">
	                <spring:message code="M00278" />
	            </button>
	        </div>
	    </div>
	    <div class="well form-horizontal well_bt5" id="channelSearchHelpSearchList" >
	    </div>
	</div>

	<div>
	    <div class="page_btn_area" >
	        <div class="col-xs-7">
	            <span><spring:message code="M00277" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	        </div>
	    </div>
	    <div id="channelSearchHelpGrid" class="white_bg grid_bd0"></div>
	</div>

	<div id="emptyDialog" class="popup_container"></div>
	<div class="pop_btn_area">
		<ifvm:inputNew type="button" btnType="save"  text="C00038"  id="choiceChannelBtn" btnFunc="choiceChannelFn" objCode="ChannelSearchchoiceChannelBtn_OBJ"/>
 		<ifvm:inputNew type="button"   text="M00441"  id="cancelChnnelSearchHelpBtn" btnFunc="cancelChnnelSearchHelpFn" objCode="cancelChnnelSearchHelpBtn_OBJ"/>
	</div>
</div>
