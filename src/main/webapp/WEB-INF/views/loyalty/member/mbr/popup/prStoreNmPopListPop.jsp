<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="PrStoreNmListPopGrid"></div>
<div class="pop_btn_area">
    <button class="btn btn-sm btn_gray"  id="selectPrStoreBtn" objCode="selectPrStoreBtn_OBJ">
        <spring:message code="선택" />
    </button> 
    <button class="btn btn-sm btn_gray"  id="closePrStoreBtn" objCode="closePrStoreBtn_OBJ">
        <spring:message code="L00941" />
    </button> 
</div>
<script type="text/javascript">
var PrStoreNmListPopGrid;
var chnlRid;
var chnlNo;
var chnlNm;

function getPrStoreNmListPopGrid() {
    var ejGridOption = {
                serializeGridData : function(data) {
                    return data;
                },
                rowSelected : function (args) {
                    chnlRid = args.data.rid;
                    chnlNo = args.data.chnlNo;
                    chnlNm = args.data.chnlNm;
                },
            dataUrl : '<ifvm:action name="getPrStoreNmPopList"/>',
            columns: [
                {
                    field: 'chnlNo',headerText: '<spring:message code="L00128"/>',textAlign : 'center',customAttributes: { searchable: true }
                }, {
                    field: 'chnlNm',headerText: '<spring:message code="L00129"/>',customAttributes: { searchable: true  }
                }, {
                    field: 'chnlTypeCdNm', headerText: '<spring:message code="L00165"/>', textAlign : 'center', customAttributes: { index: 'chnlTypeCd' }
                }, {
                    field: 'parChnlNm', headerText: '<spring:message code="L00130"/>', textAlign : 'center',
                }, {
                    field: 'modifyBy',headerText: '<spring:message code="L00095"/>',visible : false
                }, {
                    field: 'modifyDate',headerText: '<spring:message code="L00094"/>', visible : false
                }, {
                    field: 'rid', headerText: 'rid',visible: false,
                }],
            requestGridData : {
                nd   : new Date().getTime(),
                rows : 10,
                sord : 'desc',
                sidx: 'chnlNo',
                _search : false
              },
              rowList : [10,25,50,100],
              radio: true
        };
    
    PrStoreNmListPopGrid = $("#PrStoreNmListPopGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function(){
    getPrStoreNmListPopGrid();
    
    $('#selectPrStoreBtn').on('click', function(){
        $("#custValidForm #prStoreNo").val(chnlNo);
        $("#custValidForm #prStoreNm").val(chnlNm);
        $.fn.ifvmPopupClose();
    });
    
    $('#closePrStoreBtn').on('click', function(){
        $.fn.ifvmPopupClose();
    });
});
</script>