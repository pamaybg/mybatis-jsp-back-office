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
  <div class="page_btn_area">
    <div class="col-xs-12 searchbtn_r">
      <ifvm:inputNew type="button" id="brazeCampaignLoad" text="캠페인 불러오기" objCode="camKeyPopupSaveBtn_OBJ"/>
    </div>
  </div>
  <div id="camKeyDialog" class="white_bg grid_bd0"></div>
</div>
<div class="pop_btn_area">
  <button class="btn btn-sm btn_gray" id="saveCamKeyBtn" objCode="camKeyPopupSaveBtn_OBJ">
    <i class="glyphicon glyphicon-check"></i>
    <spring:message code="M00282"/>
  </button>
  <button class="btn btn-sm btn_lightGray2" id="camKeyPopCloseBtn" objCode="camKeyPopuClosepBtn_OBJ">
    <spring:message code="M00284"/>
  </button>
</div>


<script type="text/javascript">


  var camKeyListGrid;
  var camKey;
  var contsId = '<%= cleanXss(request.getParameter("id")) %>';

  function getCamKeyList(){
    var ejGridOption = {
      serializeGridData : function(data) {

        return data;
      },rowSelected : function(args){
        camKey=args.data.camApiKey;
      },
      dataUrl : '<ifvm:action name="getCampaignKeyList"/>',
      columns : [
        {
          field : 'camNm', headerText : '캠페인명', headerTextAlign : 'center', textAlign : 'center',
          customAttributes : { searchable : true,
            index : 'CAM_NM'
          }
        },{
          field : 'camApiKey', headerText : '캠페인 키', headerTextAlign : 'center', textAlign : 'center',
          customAttributes : { searchable : true,
            index : 'CAM_API_KEY'
          }
        },{
          field : 'camCreateDate', headerText : '생성일자', headerTextAlign : 'center', textAlign : 'center',
          customAttributes : {
            index : '3'
          }
        }
      ],

      requestGridData : {
        rows : 10,
        sidx : 'CAM_CREATE_DATE',
        sord : 'desc',
        _search : false,

      },
      rowList : [10,25,50,100],
      gridDataInit: true,
      radio: true
    };

    camKeyListGrid = $("#camKeyDialog").ifvsfGrid({ ejGridOption : ejGridOption });
  }

  function saveCamKey(){
    var selectedData = camKeyListGrid.opt.gridControl.getSelectedRecords()[0];
    $('#brazeCamApiKey').val(selectedData.camApiKey);
    campaignKeyPopClose();
  }

  function brazeCampaignLoadFun(){
    $.ifvSyncPostJSON('<ifvm:action name="getBrazeCampaignLoad"/>'
     , {}
     ,function (result) {
        alert(result.message);
     }
     ,function (result) {
        alert(result.message);
     }
    );
    getCamKeyList();

  }

  $(document).ready(function() {

    $('#camKeyPopCloseBtn').on('click', function(){
      campaignKeyPopClose();
    });

    $('#saveCamKeyBtn').on('click', function(){
      saveCamKey();
    });

    $('#brazeCampaignLoad').on('click', function(){
      brazeCampaignLoadFun();
    });

    getCamKeyList();

  });
</script>


