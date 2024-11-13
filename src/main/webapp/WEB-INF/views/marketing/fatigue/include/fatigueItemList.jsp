<%--
  Created by IntelliJ IDEA.
  User: hr.noh
  Date: 2022-01-24
  Time: 오전 11:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
    <div class="col-xs-3">
        <span><spring:message code="채널 아이템"/></span>
    </div>
    <div class="col-xs-9 searchbtn_r">
        <ifvm:inputNew type="button" id="newFatigueItemPopup" text="신규" objCode="newFatigueItemPopup_OBJ"/>
        <ifvm:inputNew type="button" id="editFatigueItemPopup" text="수정" objCode="editFatigueItemPopup_OBJ"/>
        <ifvm:inputNew type="button" id="removeFatigueItem" text="삭제" objCode="removeFatigueItem_OBJ"/>
    </div>
</div>
<div id="fatigueItemListGrid" class="white_bg grid_bd0"></div>
<div id="popupContainer" class="popup_container"></div>

<script type="text/javascript">
    var fatigueItemList;
    var fatigueItemListGrid = null;

    var getFatigueItemList = function(){
        var _rid = null;

        this.setRid = function (rid) {
            _rid = rid;
            ifvGlobal["fatigueChnlItemRid"] = _rid;
        },
        this.getRid = function () {
            return _rid;
        },
        this.init = function(){
            this.action();
            this.fatigueItemList();
        },
        this.fatigueItemList = function(){
            var ejGridOption = {
                serializeGridData: function (data) {
                    data.rid = fatigueid;
                    if ($.fn.ifvmIsNotEmpty(requestitem)) {
                        data.item = requestitem;
                    }
                    return data;
                },
                rowSelected : function(args) {
                    this.setRid(args.data.id);
                }.bind(this),
                recordDoubleClick: function (args) {
                    this.setRid(args.data.id);
                    this.getFatigueItemDetailPopup();
                }.bind(this),
                dataUrl: '<ifvm:action name="getFatigueChnlItemList"/>',
                columns: [
                    {
                        field: 'chnlTypeCd', headerText: '채널', textAlign: 'center' , customAttributes: {searchable: true, index: 'chnlTypeCd'}
                    }, {
                        field: 'fatiItemStateNm', headerText: '사용여부', textAlign: 'center', customAttributes: {searchable: true, index: 'fatiItemState'}
                    }, {
                        field: 'fatiItemRestrictionDayYnNm', headerText: '피로도 제한(일)', textAlign: 'center', customAttributes: {index: 'fatiItemRestrictionDayYn'}
                    }, {
                        field: 'fatiItemRestrictionDay', headerText: '기한(일)', textAlign: 'center',
                    },{
                        field: 'fatiItemMaxRestrictionDayCnt', headerText: '횟수(일)', textAlign: 'center',
                    }, {
                        field: 'id', headerText: 'id', visible: false
                    }
                ],
                requestGridData: {
                    sidx: '1',
                    sord: 'desc',
                },
                gridDataInit: true,
                radio: true,
            };

            fatigueItemListGrid = $('#fatigueItemListGrid').ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        this.RemovefatigueChnlItem =function(){
            if($.fn.ifvmIsNotEmpty(this.getRid())){
                if(confirm('<spring:message code="M00296"/>')){
                    var _callback = function (result) {
                        if (result.success) {
                            alert('<spring:message code="M00003"/>');
                            this.fatigueItemList();
                        }
                    }
                    $.ifvSyncPostJSON('<ifvm:action name="removeFatigueChnlItem"/>', { id: this.getRid() }, _callback.bind(this));
                }
            }else{
                alert('<spring:message code="I00728"/>');
            }
        },
        this.getFatigueItemDetailPopup = function(){
            $.fn.ifvmPopupOpen('popupContainer', this.getRid()
                , '<ifvm:url name="fatigueItemDetailPop"/>', "채널 아이템 상세 팝업", 860);
        },
        this.action = function(){

            //신규 클릭시
            $('#newFatigueItemPopup').on('click', function(){
                this.setRid(null);
                this.getFatigueItemDetailPopup();
            }.bind(this));

            //수정 클릭시
            $('#editFatigueItemPopup').on('click', function(){
                var selectRecords = fatigueItemListGrid.opt.gridControl.getSelectedRecords() || [];
                if (selectRecords.length > 0){
                    this.setRid(selectRecords[0].id);
                    this.getFatigueItemDetailPopup();
                } else{
                    alert('목록을 선택하세요.');
                }
            }.bind(this));

            $('#removeFatigueItem').on('click', function(){
                this.RemovefatigueChnlItem();
            }.bind(this));
        }
    }

    $(document).ready(function(){
        fatigueItemList = new getFatigueItemList();
        fatigueItemList.init();
    })
</script>