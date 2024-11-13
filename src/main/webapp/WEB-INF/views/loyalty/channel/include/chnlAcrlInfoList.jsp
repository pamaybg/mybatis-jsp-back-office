<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var chnlAcrlInfoList;
var gridIdchnlAcrlInfoList;
var rid ;

//적립 기준정보
function getchnlAcrlInfoListSearch(){
    var jqGridOption = {
        ondblClickRow : function(data) {
            var data = chnlAcrlInfoList.getRowData()[data-1];
            rid = data.rid;
        },
        onSelectRow : function (data) {
        },
        serializeGridData : function(data) {
            data.rid = channelDetail_rid;
            return data;
        },
        loadComplete : function(obj) {
        },
        url : '<ifvm:action name="getChnlAcrlInfoList"/>',
        colNames:[
                   '<spring:message code="L00557" />',
                   '<spring:message code="L00180" />',
                   '<spring:message code="L00738" />',
                   '<spring:message code="L00592" />',
                   '<spring:message code="L00739" />',
                   '<spring:message code="M01139" />',
                   '<spring:message code="M00466" />',
                   '<spring:message code="M00467" />',
                   'rid'
                 ],
        colModel:[
             { name:'mbrDivCd',   index:'d.mark_name',  resizable : true, align:'center',    width:'100px' },
             { name:'tierCd',   index:'e.mark_name',  resizable : true, align:'center',    width:'100px' },
             { name:'acrlUnit',   index:'f.mark_name',  resizable : true, align:'center',  width:'100px' },
             { name:'acrlPnt',   index:'c.acrl_pnt',  resizable : true, align:'right',   width:'100px' },
             { name:'acrlPntLmt',   index:'c.acrl_pnt_lmt',  resizable : true, align:'right',  formatter:numberCommaForamtter ,   width:'100px' },
             { name:'activeYn',   index:'c.active_yn',  resizable : true, align:'center',    width:'100px' },
             { name:'aplyStartDd',   index:'c.aply_start_dd',  resizable : true, align:'center',  formatter:'date',  formatoptions:{newformat:"Y-m-d"} ,  width:'100px' },
             { name:'aplyEndDd',   index:'c.aply_end_dd',  resizable : true, align:'center',  formatter:'date',  formatoptions:{newformat:"Y-m-d"} ,  width:'100px' },
             { name:'rid',    index:'a.rid',    hidden : true}
        ],
        sortname: 'a.rid',
        autowidth : true ,
        
        sortorder: "desc"
    };

    chnlAcrlInfoList = $("#chnlAcrlInfoListGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdchnlAcrlInfoList = $("#gridIdchnlAcrlInfoList");
}

//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink(cellvalue, options, rowObjec) {
    var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';

    return tag;
}
function goGridRowChnlLink(cellvalue, options, rowObjec) {
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
function chnlAcrlInfoListSearch() {
    $.fn.ifvmSubmitSearchCondition("chnlAcrlInfoListSearchList", getchnlAcrlInfoListSearch);
}
function numberCommaForamtter(cellvalue, options, rowObjec) {
    var pnt = rowObjec.acrlPntLmt;
    if (pnt != null) {
        pnt = Math.round(pnt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
    else {
        pnt = '';
    }
    return pnt;
}

$(document).ready(function() {
    chnlAcrlInfoListSearch();
});

</script>



<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">

        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>
    <div id="chnlAcrlInfoListGrid" class="white_bg grid_bd0"></div>
</div>
