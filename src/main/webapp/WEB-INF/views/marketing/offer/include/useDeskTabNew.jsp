<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var useDeskGrid;
var gridIduseDeskGrid;

var useDeskInfoPopup;

function initUseDesk() {

    //그리드 설정
    setTimeout(setUseDeskGrid, 100);
}

/**
 * 사용처 그리드 그리기
 */
function setUseDeskGrid() {
    var ejGridOption = {
        loadComplete : function(obj) {
            //popup 높이 맞추기
            new ifvm.PopupHeight({
                popupDivId : 'dialog',
                contentsId : 'dialogPopupWrap'
            });
        },
//         rowSelected : function (args) {
// //         	useDeskInfoRemove(args.data.rid);
//         },
		allowSorting: true,
	    editSettings: {
        	 allowAdding: true
        	,allowDeleting: true
        },
        dataSource: offerData.useDeskList,
        datatype: 'clientSide',
        columns :[
        	  { type:"checkbox", width: 50},
        	  {
        		  field : 'ouTypeCd', headerText : '<spring:message code="L00630"/>', headerTextAlign : 'center',
        		  customAttributes : {
        			  index : '' } //
        	  },{
          		  field : 'chnlNo', headerText : '<spring:message code="L00564"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : '' } //
          	  },{
          		  field : 'chnlNm', headerText : '<spring:message code="V00022"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : '' } //
          	  },{
          		  field : 'stnMgmtDiv', headerText : '<spring:message code="M02283"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : '' } //
          	  },{
          		  field : 'parChnlNm', headerText : '<spring:message code="L00621"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : '' } //
          	  },{
          		  field : 'pointContType', headerText : '<spring:message code="L00626"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : '' } //
          	  },{
          		  field : 'ridChnl', headerText : 'ridChnl', visible : false ,
          		  customAttributes : {
          			  searchable : false,
          			  index : '' } //
          	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  _search : false
        },
        rowList : [100000],
        multiselect: true,
        tempId : 'ifvGridSimpleTemplete',
    };
    useDeskGrid = $("#useDeskGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    gridIduseDeskGrid = $("#useDeskGrid");
//     gridIduseDeskGrid.resize();
}
function useDeskGridinit(){
	var jsonObj ={
			nd: new Date().getTime()
			,page:1
			,row :1000
			, sidx: "p.pgm_no"
		    , sord: "desc"
			,_search : false
	}
	setUseDeskGrid();
// 	$.ifvPostJSON('<ifvm:action name="getProgList"/>', jsonObj, function(result) {
// 		jsonData = result.rows;
}
/**
 * 사용처 추가를 위한 채널 팝업 오픈
 */
function useDeskInfoPopupOpen() {

    $("#useDeskInfoPopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="useDeskPopNew"/>',
        contentType: "ajax",
        title: "<spring:message code='M02429'/>",
        width: 800,
        close : 'useDeskPopClose'
    });
}

/**
 * 채널 팝업 닫기
 */
function useDeskPopClose() {
    useDeskInfoPopup._destroy();
}

/**
 * 채널을 사용처 그리드에 추가
 */
function useDeskAdd() {

    // 중복되지 않는 데이터만 사용처 그리드에 추가
    var checkedList = useDeskChannelList.opt.gridControl.getSelectedRecords();
    for (var i = 0; i < checkedList.length; i++) {
        var checkedData = checkedList[i];
        checkedData.ridChnl = checkedData.rid;

        // 수정 : U
        if (chkUseDeskList(checkedData) == true) {
            useDeskGrid.setRowDatas(checkedData);
        }
        // 추가 : I
        else {
            checkedData.rid = '';
            checkedData.dataStatus = "I";
            useDeskGrid.opt.gridControl.addRecord(checkedData);
        }
    }

    if (offerData.useDeskList == null) {
        offerData.useDeskList = [];
    }

    offerData.useDeskList = useDeskGrid.opt.gridControl.model.currentViewData;

    // 그리드 재설정
    setUseDeskGrid();

    // close popup
    useDeskPopClose();
}

/**
 * 현재 사용처 그리드에 채널이 저장되어있는지 체크 한다
 *
 * @param checkedData
 * @returns
 */
function chkUseDeskList(_checkedData) {
    for (var i = 0; i < offerData.useDeskList.length; i++) {
        var deskData = offerData.useDeskList[i];
        if (deskData.dataStatus != "D"
                && deskData.ridChnl == _checkedData.rid) {
            return true;
        }
    }
    return false;
}

/**
 * 사용처 삭제
 */
function useDeskInfoRemove() {

    var checkedList = useDeskGrid.opt.gridControl.getSelectedRows();
    if (checkedList.length > 0) {
		useDeskGrid.opt.gridControl.deleteRow(checkedList);
//      useDeskGrid.delRowData();
    }

    // 전역변수에 값 매핑
    offerData.useDeskList = useDeskGrid.opt.gridControl.model.currentViewData;

    // 그리드 재설정
    setUseDeskGrid();
}

$(document).ready(function() {

    initUseDesk();
});

</script>

<div id="loyOfferUseLmtChnlWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">

			<%-- 신규 --%>
        	<ifvm:inputNew type="button" btnFunc="useDeskInfoPopupOpen" text="M01852" />

        	<%-- 삭제 --%>
        	<ifvm:inputNew type="button" btnFunc="useDeskInfoRemove" text="M01854" />
        </div>
    </div>
    <div id="useDeskGrid" class="white_bg grid_bd0"></div>
</div>
<div id="useDeskInfoPopup"></div>
