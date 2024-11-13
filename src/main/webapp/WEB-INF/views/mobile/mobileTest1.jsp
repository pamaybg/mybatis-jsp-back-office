<%--
  Created by IntelliJ IDEA.
  User: hr.noh
  Date: 2021-12-20
  Time: 오전 11:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.icignal.auth.dto.response.LoginResDto" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <title>mobile Title 형래</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>--%>
    <%--<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
    <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>--%>
</head>

<style>
    .gridTable {
        table-layout:fixed;
        width:100%;
        text-align:center;
    }
    .gridTable th {
        background:#ccc;
    }

    .gridTable thead tr th{
        text-align: center;
    }
    .gridTable td, .gridTable th {
        padding:10px 20px;
        border-top:1px solid #ccc;
        word-break:break-all
    }

    /*.buttonArea{*/
    /*    background: teal; */
    /*    font-weight: bold; */
    /*    display: flex; */
    /*    justify-content: space-between; */
    /*    align-items: center;*/
    /*}*/

    @media screen and (max-width:768px) {
        /*block*/
        .gridTable thead {
            display:none;
        }
        .gridTable tr {
            display:block;
            margin-bottom:10px;
            border-top:none;
        }
        .gridTable thead th, .gridTable tbody td {
            display:block;
            position:relative;
            padding:10px 0;
            padding-left:50%;
            border-width:0 0 1px 0;
        }

        .gridTable td:before {
            display:block;
            position:absolute;
            left:0;
            top:0;
            width:50%;
            padding:10px 0;
            background:#ccc;
        }
        .gridTable td:nth-child(1):before {content:'선택';}
        .gridTable td:nth-child(2):before {content:'번호';}
        .gridTable td:nth-child(3):before {content:'캠페인명';}
        .gridTable td:nth-child(4):before {content:'시작일';}
        .gridTable td:nth-child(5):before {content:'종료일';}
        .gridTable td:nth-child(6):before {content:'상태';}
        .gridTable td:nth-child(7):before {content:'유형';}
        .gridTable td:nth-child(8):before {content:'기획자';}
    }
</style>
<div>
    <br>
    <div class="buttonArea" style="text-align: end;">
        <button type="button" class="btn-info" id="payment">결제</button>
        <button type="button" class="btn-info" id="admission">승인</button>
        <button type="button" class="" id="new">신규</button>
        <button type="button" class="" id="delete">삭제</button>
        <button type="button" class=" btn-success" id="active">실행</button>
        <button type="button" class=" btn-danger" id="pause">중지</button>
    </div>
    <hr>
    <div class="container">
        <div id="input-form">
            캠페인명 : <input type="text" id="keyword" />
        </div>
        <br>
        <table class="gridTable" id="gridTable" cellspacing="0" cellpadding="0" >
            <thead>
                <tr>
                    <th style="width:10%;">선택</th>
                    <th>번호</th>
                    <th>캠페인명</th>
                    <th>시작일</th>
                    <th>종료일</th>
                    <th>상태</th>
                    <th>유형</th>
                    <th>기획자</th>
                </tr>
            </thead>
            <tbody>
            <tr>
                <td><input type="checkbox" name="selected" id="ROW_1"></td>
                <td>C20210003429</td>
                <td class="item">신규 추가_ 테스트_2</td>
                <td>2021-12-09</td>
                <td>2021-12-09</td>
                <td name="act">작성중</td>
                <td>Target</td>
                <td>iCIGNAL Admin</td>
            </tr>
            <tr>
                <td><input type="checkbox" name="selected" id="ROW_2"></td>
                <td>C20210003428</td>
                <td class="item">Campaign 테스트</td>
                <td>2021-12-09</td>
                <td>2021-12-09</td>
                <td name="act">작성중</td>
                <td>Target</td>
                <td>로열티 마스터</td>
            </tr>
            <tr>
                <td><input type="checkbox" name="selected" id="ROW_3"></td>
                <td>C20210003394</td>
                <td class="item">신규 추가_ 테스트</td>
                <td>2021-12-09</td>
                <td>2021-12-09</td>
                <td name="act">중지</td>
                <td>Target</td>
                <td>iCIGNAL Admin</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<script type="text/javascript">
    var mobileTest;
    var userObj = new Object();
    <% LoginResDto rtnValue = (LoginResDto)session.getAttribute(com.icignal.common.util.CommonUtil.USER_INFO_PROP);
        if(rtnValue != null){%>
        userObj = $.parseJSON(replaceHtmlTag('<%= JSONObject.fromObject(rtnValue).toString().replace("'", "\\'")%>'));
        <%
    }
    %>

    var testPage = function(){

        this.init = function(){
            this.buttonDisable()
            this.action()
        },
        this.isChecked = function(){
            if($('input[name=selected]').is(':checked')) return true;
            else return false;
        },
        this.buttonDisable = function(){
            if(userObj.userId != 'loymaster@quintet.co.kr'){
                $("#payment").prop('disabled', true);
                $("#admission").prop('disabled', true);
                $("#payment").hide();
                $("#admission").hide();
            }
        },
        this.campaignRemove = function(){
            if(this.isChecked()) {
                if (confirm('삭제하시겠습니까?')) $("input:checkbox[name='selected']:checked").parents().parents()[0].remove();
            }else {
                alert('목록을 선택하세요.')
            }
        },
        this.campaignActivation = function(){
            if(this.isChecked()) {
                if(confirm('실행하시겠습니까??')) {
                    alert("활성")
                    $('input:checkbox').prop('checked',false);
                }
            }else {
                alert('실행할 목록을 선택하세요.')
            }
        },
        this.campaignPause = function(){
            if(this.isChecked()){
                if(confirm('중지하시겠습니까?')) {
                    alert('중지')
                    $('input:checkbox').prop('checked',false);
                }
            } else{
                alert('중지할 목록을 선택하세요.')
            }

        },
        this.action = function(){

            $('input[name=selected]').on('change', function(){
                if($('input[name=selected]:checked').length > 1){
                    $('input:checkbox').prop('checked',false);
                    $("#"+$(this)[0].id).prop('checked', true);
                }
            });

            $("#keyword").keyup(function() {
                var word = $("#keyword").val(); //$(this).val();
                $("#gridTable > tbody > tr").hide();
                var temp = $("#gridTable > tbody > tr > td:nth-child(3):contains('" + word + "')");

                $(temp).parent().show();
            });

            $("#payment").click(function(){ alert("결제") }.bind(this));

            $("#admission").click(function(){ alert("승인") }.bind(this));

            $("#new").click(function(){ location.href = '/mobile/campaignMobile'; });

            $("#delete").click(function(){ this.campaignRemove() }.bind(this));

            $("#active").click(function(){ this.campaignActivation() }.bind(this));

            $("#pause").click(function(){ this.campaignPause() }.bind(this));

        }
    }

    function replaceHtmlTag(value){
        return value.replace(/&/g, '&amp;')
            .replace(/>/g, '&gt;')
            .replace(/</g, '&lt;')
            .replace(/\n/g, ' <br>');
    }

    $(document).ready(function(){
        mobileTest = new testPage();
        mobileTest.init();
    })

</script>