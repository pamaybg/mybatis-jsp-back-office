<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
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

<div class="content_pop_wrap">
    <div id="requestListGridDialog" class="white_bg grid_bd0"></div>
</div>
<div class="pop_btn_area">
    <button class="btn btn-sm btn_gray" id="saveRequestBtn" objCode="saveRequestBtn_OBJ">
        <i class="glyphicon glyphicon-check"></i>
        <spring:message code="선택"/>
    </button>
    <button class="btn btn-sm btn_lightGray2" id="requestPopCloseBtn" objCode="requestPopCloseBtn_OBJ">
        <spring:message code="M00284"/>
    </button>
</div>


<script type="text/javascript">


    var requestListGrid;
    var ridOfr;
    var contsId = '<%= cleanXss(request.getParameter("id")) %>';

    function getRequestList(){
        var ejGridOption = {
            serializeGridData : function(data) {
                return data;
            },rowSelected : function(args){

            },
            dataUrl : '<ifvm:action name="getEmpListPop"/>',
            columns : [
                {
                    field : 'empNo', headerText : '사번', headerTextAlign : 'center', textAlign : 'center',
                    customAttributes : { index : 'e.EMP_NO', searchable : true
                    }
                },{
                    field : 'name', headerText : '이름', headerTextAlign : 'center', textAlign : 'center',
                    customAttributes : { index: 'e.NAME', searchable : true
                    }
                },{
                    field : 'ridUser', headerText : 'ridUser',visible: false,
                    customAttributes : {
                        index : 't1.mem_ptbl_no'
                    }
                }

            ],

            requestGridData : {
                nd   : new Date().getTime(),
                rows : 10,
                allFlag : 'Y',
                sidx : '1',
                sord : 'desc',
                _search : false,

            },
            rowList : [10,25,50,100],
            //gridDataInit: true,
            radio: true,
        };

        requestListGrid = $("#requestListGridDialog").ifvsfGrid({ ejGridOption : ejGridOption });
    }

    function saveRequest(){
        if(requestListGrid.opt.gridControl.getSelectedRecords().length > 0) {
            $('#campaignRequestName').val(requestListGrid.opt.gridControl.getSelectedRecords()[0].name);
            $('#campaignRequestName').text(requestListGrid.opt.gridControl.getSelectedRecords()[0].employeeRid);
            showRequestNamePopClose();
        } else {
            alert("목록을 선택해주세요.");
        }
    }


    $(document).ready(function() {

        $('#requestPopCloseBtn').on('click', function(){
            showRequestNamePopClose();
        });

        $('#saveRequestBtn').on('click', function(){
            saveRequest();
        });

        getRequestList();

    });
</script>


