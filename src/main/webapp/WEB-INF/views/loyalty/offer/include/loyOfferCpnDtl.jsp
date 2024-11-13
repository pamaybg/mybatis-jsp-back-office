<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var loyOfferPntDtlListGrid;
var gridIdloyOfferPntDtlListGrid;

function initLoyOfferCpnDtlList() {
    
    //그리드 출력 
    setLoyOfferCpnDtlListGrid();
}

//쿠폰 목록 그리드 설정
function setLoyOfferCpnDtlListGrid() {
    
    //colnames
    var colNames = [];

    //colmodel
    var colModel = [];

    colNames.push("<spring:message code='L00528'/>"); /* 쿠폰유형 */
    colNames.push("<spring:message code='L00529'/>"); /* 발급상태 */
    colNames.push("<spring:message code='L00530'/>"); /* 회원유형 */
    colNames.push("<spring:message code='L00531'/>"); /* 발급유형 */
    colNames.push("<spring:message code='L00532'/>"); /* 쿠폰번호유형 */
    colNames.push("<spring:message code='L00533'/>"); /* 발행시작일 */
    colNames.push("<spring:message code='L00534'/>"); /* 발행종료일 */
    colNames.push("<spring:message code='L00535'/>"); /* 사용시작일 */
    colNames.push("<spring:message code='L00536'/>"); /* 사용종료일 */
    colNames.push('rid');
    
    colModel.push({name:'cpnTypeCdNm',index:'', width:'100px', align:'center', resizable : false});
    colModel.push({name:'issueFmatCdNm',index:'', width:'100px', align:'center', resizable : false});
    colModel.push({name:'mbrMappTypeCdNm',index:'', width:'100px', align:'center', resizable : false});
    colModel.push({name:'issueTmplCdNm',index:'', width:'100px', align:'center', resizable : false});
    colModel.push({name:'cpnNoTypeCdNm',index:'', width:'100px', align:'center', resizable : false});
    colModel.push({name:'prtStartdt',index:'', width:'100px', align:'center', resizable : false});
    colModel.push({name:'prtEnddt',index:'', width:'100px', align:'center', resizable : false});
    colModel.push({name:'',index:'', width:'100px', align:'center', resizable : false});
    colModel.push({name:'',index:'', width:'100px', align:'center', resizable : false});
    colModel.push({name:'rid', index:'', resizable : false,  hidden : true,  searchable : false});
    
    var jqGridOption = {
        loadComplete : function(obj) {
            //popup 높이 맞추기
            new ifvm.PopupHeight({
                popupDivId : 'dialog',
                contentsId : 'dialogPopupWrap'
            });
        },
        ondblClickRow : function (id) {
        },
        data: loyOfferData.cpnDtlList,
        datatype: 'clientSide',
        colNames: colNames,
        colModel: colModel,
        rowList : [100000],
        radio: true,
        tempId : 'ifvGridSimpleTemplete',
    };

        
    loyOfferPntDtlListGrid = $("#loyOfferPntDtlListGrid").ifvGrid({
        jqGridOption : jqGridOption
    });
    gridIdloyOfferPntDtlListGrid = $("#gridIdloyOfferPntDtlListGrid");
}


$(document).ready(function() {
    
    initLoyOfferCpnDtlList();
    
});

</script>

<div id="loyOfferCpnDtlWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="loyOfferCpnDtlNewBtn"><i class="fa fa-plus"></i>
                <spring:message code="M01852"/>
            </button> 
            <button class="btn btn-sm" id='loyOfferCpnDtlEditBtn'>
                <spring:message code="M01853"/>
            </button> 
            <button class="btn btn-sm" id='loyOfferCpnDtlRemoveBtn'>
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
    <div id="loyOfferCpnDtlListGrid" class="white_bg grid_bd0"></div>     
</div>
<div id="loyOfferCpnDtlInfoPopup"></div>
