<%--
  Created by IntelliJ IDEA.
  User: hr.noh
  Date: 2022-01-04
  Time: 오전 10:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page-title">
    <h1>
        브랜드 &gt; <spring:message code="M00568" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="brdListSearchBtn" objCode="brdListSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="brdListSearchInitBtn" objCode="brdListSearchInitBtn_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="brdSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="brdNewBtn" objCode="brandNewBtn_OBJ"><i class="fa fa-plus"></i>
                <spring:message code="M00136" />
            </button>
            <button class="btn btn-sm" id="brdRemoveBtn" objCode="brandDeleteBtn_OBJ"><i class="fa fa-minus"></i>
                <spring:message code="M00165" />
            </button>
        </div>
    </div>
    <div id="brdListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="popupContainer" class="popup_container"></div>

<script type="text/javascript">
var brandList;

var getBrandList = function(){
    var _rid = null;

    this.setRid = function (rid) {
        _rid = rid;
        ifvGlobal["brdRid"] = _rid;
    },
    this.getRid = function () {
        return _rid;
    },
    this.brandGrid = null,
    this.init = function(){
        this.action();
        this.bandListGrid();
        this.brdListSearchInit();
    },
    this.bandListGrid = function() {
        var ejGridOption = {
            serializeGridData: function (data) {
                if ($.fn.ifvmIsNotEmpty(requestitem)) {
                    data.item = requestitem;
                }
                return data;
            },
            rowSelected : function(args) {
                this.setRid(args.data.rid);
            }.bind(this),
            recordDoubleClick: function (args) {
                this.setRid(args.data.rid);
                getBrandDetail(this.getRid());
            }.bind(this),
            dataUrl: '<ifvm:action name="getBrandList"/>',
            columns: [
                {
                    field: 'pgmNm', headerText: '<spring:message code="L00037"/>', textAlign: 'left', width: '17%', customAttributes: {searchable: true}
                }, {
                    field: 'brdId', headerText: '<spring:message code="M01957"/>', textAlign: 'center', customAttributes: {searchable: true}
                }, {
                    field: 'brdNm', headerText: '<spring:message code="L00290"/>', textAlign: 'center', customAttributes: {searchable: true}
                }, {
                    field: 'brdDescTxt', headerText: '<spring:message code="L00219"/>', textAlign: 'left', width: '25%'
                }, {
                    field: 'modifyBy', headerText: '수정자', textAlign: 'center',
                }, {
                    field: 'modifyDate', headerText: '수정일자', textAlign: 'center',
                }, {
                    field: 'createDate', headerText: '<spring:message code="L01125"/>', textAlign: 'center',
                }, {
                    field: 'rid', headerText: 'rid', visible: false
                }, {
                    field: 'pgmRid', headerText: 'pgmRid', visible: false
                }
            ],
            requestGridData: {
                sidx: 'createDate',
                sord: 'desc',
            },
            gridDataInit: true,
            radio: true,
        };

        this.brandGrid = $('#brdListGrid').ifvsfGrid({
            ejGridOption: ejGridOption
        });
    },
    this.brdListSearch = function () {
        $.fn.ifvmSubmitSearchCondition('brdSearchList', function () {
            this.brandGrid.searchGrid({
                item: requestitem
            });
        }.bind(this));
    },
    this.brdListSearchInit = function() {
        $.fn.ifvmSetCommonCondList("brdSearchList","LOY_BRAND_LIST", this.brandGrid.attr('id'));
    },
    this.RemoveBrand =function(){
        if($.fn.ifvmIsNotEmpty(this.getRid())){

            var _callback = function (result) {
                if (result.success) {
                    alert('<spring:message code="M00003"/>');
                    this.bandListGrid();
                }

            }
            $.ifvSyncPostJSON('<ifvm:action name="removeBrand"/>', { rid: this.getRid() }, _callback.bind(this));

        }else{
            alert('<spring:message code="L00171"/>');
        }
    },
    this.action = function(){
        //조회
        $('#brdListSearchBtn').on('click', function(){
            this.brdListSearch();
        }.bind(this));

        //초기화
        $("#brdListSearchInitBtn").on('click', function(){
            this.brdListSearchInit();
        }.bind(this));

        //신규 클릭시
        $('#brdNewBtn').on('click', function(){
            this.setRid(null);
            getBrandDetail();
        }.bind(this));

        $('#brdRemoveBtn').on('click', function(){
            this.RemoveBrand();
        }.bind(this));
    }
}

function getBrandDetail(rid){
    openPop('<ifvm:url name="brdDtlPop"/>'+"?rid="+rid , '<spring:message code="L02927"/>', 'popupContainer');
}

//팝업
function openPop(url, title, id){
    $("#"+id).ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : url,
        contentType : "ajax",
        title : title,
        width : '1040px',
        close : 'closePop',
    });
}
function closePop(){
    $.fn.ifvmPopupClose();
}

$(document).ready(function() {
    brandList = new getBrandList();
    brandList.init();
});

</script>
