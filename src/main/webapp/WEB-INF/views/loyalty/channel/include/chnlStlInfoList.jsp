<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var chnlStlInfoList;
var gridIdchnlStlInfoList;
var rid ;

//사용 기준정보
function getchnlStlInfoListSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
            var data = chnlStlInfoList.getRowData()[data-1];
            rid = data.rid;
        },
        onSelectRow : function (data) {
        },
        serializeGridData : function( data ){
    	   data.rid = channelDetail_rid;
           return data;
        },
        loadComplete : function(obj){
        },
        url : '<ifvm:action name="getChnlStlInfoList"/>',
        colNames:[
                   '<spring:message code="L00557" />',
                   '<spring:message code="L00745" />',
                   '<spring:message code="L00746" />',
                   '<spring:message code="L00747" />',
                   '<spring:message code="L00748" />',
                   '<spring:message code="L00749" />',
                   '<spring:message code="M01139" />',
                   '<spring:message code="M00466" />',
                   '<spring:message code="M00467" />',

                   'rid'
                 ],
        colModel:[
             { name:'mbrDivCd',   index:'d.mark_name',  resizable : true, align:'center',    width:'100px' },
             { name:'adjustDivCd',   index:'e.mark_name',  resizable : true, align:'center',    width:'100px' },
             { name:'adjustMethCd',   index:'f.mark_name',  resizable : true, align:'center',    width:'100px' },
             { name:'e1ShrexpnsRate',   index:'c.shrexpns_rate',  resizable : true, align:'right',    width:'100px' },
             { name:'partnerShrexpnsRate',   index:'c.partner_shrexpns_rate',  resizable : true, align:'right',    width:'100px' },
             { name:'grntMinAmt',   index:'c.grnt_min_amt',  resizable : true, align:'right',  formatter:numberCommaForamtter ,    width:'100px' },
             { name:'activeYn',   index:'c.active_yn',  resizable : true, align:'center',    width:'100px' },
             { name:'aplyStartDd',   index:'c.aply_start_dd',  resizable : true, align:'center',   formatter:'date',  formatoptions:{newformat:"Y-m-d"} , width:'100px' },
             { name:'aplyEndDd',   index:'c.aply_end_dd',  resizable : true, align:'center',   formatter:'date',  formatoptions:{newformat:"Y-m-d"} , width:'100px' },

             { name:'rid',    index:'a.rid',    hidden : true}
        ],
        sortname: 'a.rid',
        autowidth : true ,
        
        sortorder: "desc"
    };

    chnlStlInfoList = $("#chnlStlInfoListGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdchnlStlInfoList = $("#gridIdchnlStlInfoList");
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

//공통 조회 호출
function chnlStlInfoListSearch() {
    $.fn.ifvmSubmitSearchCondition("chnlStlInfoListSearchList", getchnlStlInfoListSearch);
}

function numberCommaForamtter(cellvalue, options, rowObjec){
    var pnt = rowObjec.acrlPntLmt;
    if (pnt!=null) {
        pnt = Math.round(pnt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    } else {
        pnt='';
    }
    return pnt;
}

$(document).ready(function() {
    chnlStlInfoListSearch();
});

</script>


<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">

        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>
    <div id="chnlStlInfoListGrid" class="white_bg grid_bd0"></div>
</div>
