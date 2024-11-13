<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var cardTypeGrid;
var rid;

//등급그룹 목록 조회
function getCardTypeList(){
    var ejGridOption = {
    		recordDoubleClick : function(args){
                var data = args.data;
                rid = data.rid;
                qtjs.href('<ifvm:url name="cardTypeDtl"/>?rid=' + rid);
            },
            serializeGridData : function( data ){
                if ($.fn.ifvmIsNotEmpty(requestitem)) {
                    data.item = requestitem;
                }
                return data;
            },
            rowSelected: function (args) {
                var data = args.data;
                rid = data;
            },
            dataUrl : '<ifvm:action name="getCardTypeList"/>',
            columns:[
                  {
                      field : 'cardKindNo', headerText : '<spring:message code="M01942"/>', width:'100px',textAlign : 'center', customAttributes : {searchable : true}
                  },{
                      field : 'cardKindNm', headerText : '<spring:message code="M01949"/>', width:'200px', customAttributes : {searchable : true}
                  },{
                      field : 'cardTypeNm', headerText : '<spring:message code="M01943"/>', width:'100px', textAlign : 'center' , customAttributes : { index : 'cardType'}
                  },{
                      field : 'makeTypeNm', headerText : '<spring:message code="M01945"/>', width:'100px', textAlign : 'center' , customAttributes : { index : 'makeType'}
                  },{
                      field : 'createBy', headerText : '<spring:message code="M01810"/>', width:'100px', textAlign : 'center'
                  },{
                      field : 'createDate', headerText : '<spring:message code="M00222"/>', width:'100px', textAlign : 'center'
                  },{
                      field : 'rid', headerText : 'rid', visible : false ,
                  },
            ],
            requestGridData : {
              sidx : 'createDate',
            },
            radio: true
        };
        cardTypeGrid = $("#cardTypeGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function cardTypeListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("cardSearchList","PLOY_301",gridId);
}

//공통 조회 호출
function cardTypeListSearch() {
    $.fn.ifvmSubmitSearchCondition("cardSearchList", function(){
    	cardTypeGrid.searchGrid({item: requestitem});
    });
}


$(document).ready(function() {
	//공통 조회 조건 목록 설정
    cardTypeListSearchInit();
	getCardTypeList();

    //조회
    $('#cardTypeListSearchBtn').on('click', function(){
    	cardTypeListSearch();
    });

    //초기화
    $("#cardTypeListSearchInitBtn").on('click', function(){
    	cardTypeListSearchInit("cardTypeGrid");
    });

    //신규 클릭시
    $('#cardNewBtn').on('click', function(){
    	rid = null;
    	qtjs.href('<ifvm:url name="cardTypeDtl"/>');
    });
});

</script>

<div class="page-title">
    <h1>
        <spring:message code="M01952" />
        &gt; <spring:message code="M01943" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="cardTypeListSearchBtn" objCode="cardTypeListSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="cardTypeListSearchInitBtn" objCode="cardTypeListSearchInitBtn_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="cardSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="L00033" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <ifvm:inputNew type="button" btnType="plus" text="M01852" id="cardNewBtn" objCode="cardTypeListCardNewBtn_OBJ"/>
        </div>
    </div>
    <div id="cardTypeGrid" class="white_bg grid_bd0"></div>
</div>
