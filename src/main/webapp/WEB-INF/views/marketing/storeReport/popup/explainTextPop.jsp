<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

function explainTextPopupClose() {
	$.fn.ifvmPopupClose();
}

$(document).ready(function(){
});
</script>

<div class="responsive_grid e-grid e-js e-waitingpopup e-wrap e-touch" gridid="grid" id="gridIdbrandStoreListPopGrid" tabindex="0" accesskey="e">
    <div class="e-gridheader">
        <div>
            <table class="e-table" cellspacing="0.25px" role="grid">
                <thead>
                <tr class="e-columnheader" style="cursor: pointer;">
                    <th class="e-headercell e-default e-resizer" role="columnheader" title="DST(데상트)">
                        <div class="e-headercelldiv sort_type" ej-mappingname="dst" style="text-align: center;">DST<br>(데상트)</div>
                    </th>
                    <th class="e-headercell e-default e-resizer" role="columnheader" title="LCS(르꼬끄 스포르티브)">
                        <div class="e-headercelldiv sort_type desc" ej-mappingname="lcs" style="text-align: center;">LCS<br>(르꼬끄 스포르티브)</div>
                    </th>
                    <th class="e-headercell e-default e-resizer" role="columnheader" title="UMB(엄브로)">
                        <div class="e-headercelldiv sort_type" ej-mappingname="umb" style="text-align: center;">UMB<br>(엄브로)</div>
                    </th>
                    <th class="e-headercell e-default e-resizer" role="columnheader" title="DSG(데상트골프)">
                        <div class="e-headercelldiv sort_type" ej-mappingname="dsg" style="text-align: center;">DSG<br>(데상트골프)</div>
                    </th>
                    <th class="e-headercell e-default e-resizer" role="columnheader" title="LCG(르꼬끄골프)">
                        <div class="e-headercelldiv sort_type" ej-mappingname="lcg" style="text-align: center;">LCG<br>(르꼬끄골프)</div>
                    </th>
                    <th class="e-headercell e-default e-resizer" role="columnheader" title="MSW(먼싱웨어)">
                        <div class="e-headercelldiv sort_type" ej-mappingname="msw" style="text-align: center;">MSW<br>(먼싱웨어)</div>
                    </th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
    <div class="e-gridcontent">
        <div>
            <table class="e-table" cellspacing="0.25px" role="grid">
                <tbody>
                <tr class="e-row" role="row">
                    <td class="e-rowcell" data-cell="dst" sortable="false" searchable="false" index="" role="gridcell" style="text-align: left;">
                        1) Bronze: 신규~50만원 미만<br>
                        2) Silver: 50만원 이상~100만원 미만<br>
                        3) Gold: 100만원 이상~200만원 미만<br>
                        4) VIP: 200만원 이상
                    </td>
                    <td class="e-rowcell" data-cell="lcs" sortable="false" searchable="false" index="O" role="gridcell" style="text-align: left;">
                        1) Bronze: 신규~50만원 미만<br>
                        2) Silver: 50만원 이상~100만원 미만<br>
                        3) Gold: 100만원 이상~200만원 미만<br>
                        4) VIP: 200만원 이상
                    </td>
                    <td class="e-rowcell" data-cell="umb" sortable="false" searchable="false" index="" role="gridcell" style="text-align: left;">
                        1) Bronze: 신규~50만원 미만<br>
                        2) Silver: 50만원 이상~100만원 미만<br>
                        3) Gold: 100만원 이상~200만원 미만<br>
                        4) VIP: 200만원 이상
                    </td>
                    <td class="e-rowcell" data-cell="dsg" sortable="false" searchable="false" index="" role="gridcell" style="text-align: left;">
                        1) Bronze: 신규~100만원 미만<br>
                        2) Silver: 100만원 이상~300만원 미만<br>
                        3) Gold: 300만원 이상~3천만원 미만<br>
                        4) VIP: 3천만원 이상
                    </td>
                    <td class="e-rowcell" data-cell="lcg" sortable="false" searchable="false" index="" role="gridcell" style="text-align: left;">
                        1) Bronze: 신규~100만원 미만<br>
                        2) Silver: 100만원 이상~300만원 미만<br>
                        3) Gold: 300만원 이상~2천5백만원 미만<br>
                        4) VIP: 2천5백만원 이상
                    </td>
                    <td class="e-rowcell" data-cell="msw" sortable="false" searchable="false" index="" role="gridcell" style="text-align: left;">
                        1) Bronze: 신규~100만원 미만<br>
                        2) Silver: 100만원 이상~300만원 미만<br>
                        3) Gold: 300만원 이상~2천5백만원 미만<br>
                        4) VIP: 2천5백만원 이상
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
