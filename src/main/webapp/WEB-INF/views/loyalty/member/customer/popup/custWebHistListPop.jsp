<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="custWebHistListGird"></div>

<script type="text/javascript">

var custWebHistList = function() {
    var _ridCust = ifvGlobal.searchHelp.searchCond.custRid;
    this.getRidCust = function() {
    	return _ridCust;
    },
	this.setGridAndDataLoad = function () {
        var _serializeGridData = function(data) {
            data.rid = this.getRidCust();
            return data;
        };
		var ejGridOption = {
			serializeGridData : _serializeGridData.bind(this),
			dataUrl : '<ifvm:action name="getCustWebHistList"/>',
			columns : [ {
				field : 'rid',
				visible : false
			}, {
				field : 'chnlNm',
				headerText : '<spring:message code="채널명"/>',
                textAlign : 'center',
				customAttributes : {
					searchable : true
				}
			}, {
				field : 'acDeviceCdNm',
				headerText : '<spring:message code="로그인 매체"/>',
				customAttributes : {
					index : 'cc.MARK_NAME',
					searchable : true
				}
            }, {
				field : 'ipAddr',
				headerText : '<spring:message code="IP 주소"/>',
				textAlign : 'center',
				customAttributes : {
					index : 'lcwh.IP_ADDR'
				}
			}, /*{
				field : 'accessTypeCdNm',
				headerText : '<spring:message code="로그인 유형"/>',
                textAlign : 'center',
                width : '80px',
				customAttributes : {
					index : 'lcwh.ACCESS_TYPE_CD'
				}
			},*/ {
				field : 'logTypeCdNm',
				headerText : '<spring:message code="로그유형"/>',
				width : '80px',
                textAlign : 'center',
				customAttributes : {
					index : 'lcwh.LOG_TYPE_CD'
				}
			}, /*{
				field : 'deviceUuid',
				headerText : '<spring:message code="디바이스아이디"/>',
                textAlign : 'center',
				customAttributes : {
					index : 'lcwh.DEVICE_UUID'
				}
			},*/ {
				field : 'regDate',
				headerText : '<spring:message code="등록일자"/>',
                textAlign : 'center',
				customAttributes : {
                    index : 'lcwh.REG_DATE',
				}
			} ],
			requestGridData : {
				sidx : 'lcwh.REG_DATE'
                , sord : 'desc'
			},
			radio : false,
		};
		
		$("#custWebHistListGird").ifvsfGrid({
			ejGridOption : ejGridOption
		});
	},
    this.init = function() {
		this.setGridAndDataLoad();
    }
};

$(document).ready(function() {
	var custWebHistGrid = new custWebHistList();
	custWebHistGrid.init();
});

</script>