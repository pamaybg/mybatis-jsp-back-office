<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
    .ui-jqgrid .ui-jqgrid-bdiv {
        overflow: hidden;
    }
</style>
<script type="text/javascript">
    var ipAccessControlHistListCon = null;

    function ipAccessControlHistList() {
        var ejGridOption = {
            serializeGridData: function (data) {
// 			data.rid = rid;
// 			return data;
            },
            dataUrl: '<ifvm:action name="getIpAccessControlHistList"/>',
            columns: [
                {
                    field: 'modifyDate',
                    headerText: '<spring:message code="L01603" />',
                    resizable: true,
                    width: '100px',
                    textAlign: 'left',
                    customAttributes: {
                        searchable: true
                    }
                },
                {
                    field: 'modifyBy',
                    headerText: '<spring:message code="L01604" />',
                    resizable: true,
                    width: '100px',
                    textAlign: 'left',
                    customAttributes: {
                        searchable: true
                    }
                },
                {
                    field: 'accessIpAddr',
                    headerText: '<spring:message code="V00160" />',
                    resizable: true,
                    width: '60px',
                    textAlign: 'center',
                    customAttributes: {
                        searchable: true
                    }
                },
                {
                    field: 'aclType',
                    headerText: '<spring:message code="V00161" />',
                    resizable: true,
                    width: '80px',
                    textAlign: 'center',
                    customAttributes: {
                        searchable: true
                    }
                },
                {
                    field: 'useYn',
                    headerText: '<spring:message code="V00162" />',
                    resizable: true,
                    width: '60px',
                    textAlign: 'center',
                    customAttributes: {
                        searchable: true
                    }
                },
                {
                    field: 'userId',
                    headerText: '<spring:message code="V00164" />',
                    resizable: true,
                    width: '100px',
                    textAlign: 'left',
                    customAttributes: {
                        searchable: true
                    }
                },
                {field: 'rid', headerText: 'rid', index: 'a.rid', visible: false},
            ],
            requestGridData: {
                sidx: 'a.modify_date',
                sord: 'desc'
            },
            rowList : [10,25,50,100],
            radio: false,
            tempId: 'ifvGridOriginTemplete'
        };
        ipAccessControlHistListCon = $("#ipAccessControlHistListCon").ifvsfGrid({ejGridOption: ejGridOption});
    };

    //로그인 사용자 팝업 IP접근제어 팝업 닫기
    function ipAcesCtrlHistPopClose() {
        //ipAcesCtrlHist.close();
// 	$('#ipAcesCtrlHist').ejDialog('destroy');
        $.fn.ifvmPopupClose();
    }

    $(document).ready(function () {
        ipAccessControlHistList();
    });

</script>
<div class="import_form_area pop_inner_wrap">
    <div class="pop_inner_wrap">
        <div id="ipAccessControlHistListCon"></div><!-- class="con_size" -->
    </div>
</div>
<div class="pop_btn_area">
    <div class="row qt_border">
        <ifvm:inputNew type="button" id="" text="L00913" btnFunc="ipAcesCtrlHistPopClose"
                       objCode="ipAcesCtrlHistPopClose_OBJ"/>
    </div>
</div>
