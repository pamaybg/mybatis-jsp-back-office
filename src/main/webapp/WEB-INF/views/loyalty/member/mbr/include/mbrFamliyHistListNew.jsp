<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script type="text/x-jsrender" id="famliyInfoLink">
		<a href="<ifvm:url name="familyDetail"/>?rid={{:rid}}" style="color:#1266FF; text-decoration:underline;" >{{:famNo}}</a>
</script>

<script>
var mbrTermsHistList;

function getMbrFamliyHistListNew_init() {
	getMbrFamliyHistList();
}
// 목록
function getMbrFamliyHistList(page){
    var page = $.fn.ifvmIsNotEmpty(page) ? page : 1;
    var ejGridOption = {
        serializeGridData : function( data ){
        	if ($.fn.ifvmIsNotEmpty(mbr_rid)) {
                data.ridMbr = mbr_rid;
            }
        	data.page = page;
            return data;
        },
        dataUrl : '<ifvm:action name="getMbrFamliyInfoList"/>',
        columns:[
        	  {
         		  field : 'eventDt', headerText : '일자', headerTextAlign : 'center', textAlign : 'center',
         		  customAttributes : {
         			  index : 'eventDt' }
         	  },{
           		  field : 'famNo', headerText : '패밀리 번호', headerTextAlign : 'center',template: "#famliyInfoLink",textAlign: 'center',
           		  customAttributes : {
           			  index : 'famNo' }
           	  },{
           		  field : 'famNm', headerText : '패밀리 명', headerTextAlign : 'center', textAlign : 'center',
           		  customAttributes : {
           			  index : 'famNm' }
           	  },{
           		  field : 'status', headerText : '상태', headerTextAlign : 'center', textAlign : 'center',
           		  customAttributes : {
           			  index : 'status' }
           	  },{
           		  field : 'rid', headerText : 'famRid', visible : false,
           		  customAttributes : {
           			  index : 'rid' }
           	  },{
           		  field : 'ridMbr', headerText : 'ridMbr', visible : false,
           		  customAttributes : {
           			  index : 'ridMbr' }
           	  },{
           		  field : 'txnYm', headerText : 'txnYm', visible : false,
           		  customAttributes : {
           			  index : 'txnYm' }
           	  }
        ],
        requestGridData : {
        	  nd   : new Date().getTime(),
        	  rows : 10,
        	  sidx : 'eventDt',
        	  sord : 'desc',
        	  _search : false
          },
          rowList : [10,25,50,100],
          radio: false,
        tempId : 'ifvGridNotSearchTemplete'
    };

    mbrTermsHistList = $("#mbrTermsHistList").ifvsfGrid({ ejGridOption : ejGridOption  });
}

function famOfferList(){
	 var v_rid= mbr_rid;
    famOfferPop = {
        open: function () {
            $('#famOfferListPop').ifvsfPopup({
                enableModal: true,
                enableResize: false,
                contentUrl: '<ifvm:url name="famOfferList"/>?ridMbr='+ v_rid,
                contentType: "ajax",
                title: "패밀리 혜택이력",
                width: '1000'
            });
        },
        beforeClose: function (obj) {
        },
        close: function (obj) {
            this.beforeClose(obj);
            famOfferListPop._destroy();
        }
    }
    famOfferPop.open();
}

$(document).ready(function(){
	getMbrFamliyHistListNew_init();
});

</script>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
        <ifvm:inputNew type="button" btnType="search" text="D10245" id="famOfferBtn"  btnFunc="famOfferList" />
        </div>
    </div>
    <div id="mbrTermsHistList" class="white_bg grid_bd0"></div>
</div>
<div id="famOfferListPop" class="popup_container"></div>