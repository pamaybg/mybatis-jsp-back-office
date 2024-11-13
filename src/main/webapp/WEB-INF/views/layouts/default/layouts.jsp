<%@page import="net.sf.json.JSONObject"%>

<%@page import="com.icignal.auth.dto.response.LoginResponseDto"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>  

<meta name="google-site-verification" content="eilK4ZPegUVjX1Zd_nMW3XaBY5SVrVY0ua5vH15LRLQ" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> -->
<meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1">
<!-- <meta http-equiv="X-UA-Compatible" content="IE=8" /> -->

<link rel ="shortcut icon" href='<ifvm:image name="icon_favicon" />'/>
<link rel="icon" href='<ifvm:image name="icon_favicon" />' type="image/x-icon" />

<!-- Default CSS -->
<%-- <link rel="stylesheet" type="text/css" media="screen" href='/resources/js/jqgrid_4.4.3/css/ui.jqgrid.css" />'/> --%>

<link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/css/themes/redmond/jquery-ui-1.8.23.custom.css'/>
<link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/css/themes/ui.jqgrid.css'/>
<link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/css/themes/ui.multiselect.css'/>
<link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/css/themes/jquery.smartPop.css'/>

<%-- <link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/css/showLoading.css'/> --%>
<%-- <link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/css/style.css'/> --%>
<link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/css/global.css'/>
<%-- <link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/css/popUp.css'/> --%>
<link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/css/button.css'/>
<link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/css/menu.css'/>
<%-- <link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/css/jquery.selectBox.css'/> --%>
<%--  <link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/css/jquery-ui-1.8.23.custom.css'/> --%>
<!--<link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/css/rating.css'/> 
<link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/css/themes/redmond/jquery-ui-1.8.23.custom.css'/>-->
<link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/js/fancybox/jquery.fancybox-1.3.4.css'/>
<%-- <link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/css/jquery.rating.css'/> --%>
<%-- <link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/js/toTop/ui.totop.css'/> --%>


<link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/css/tip-twitter.css'/>
<link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/css/tip-yellowsimple.css'/>

<!-- 
<link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/js/datePicker/jquery.datepick.css'/>
 -->
<script src='${pageContext.request.contextPath}/resources/js/jquery-1.8.3.js' type="text/javascript"></script>

<%-- 
<script src='${pageContext.request.contextPath}/resources/js/jquery-1.9.1.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jquery-migrate-1.1.1.js' type="text/javascript"></script>
 --%>
<script src='${pageContext.request.contextPath}/resources/js/lib/lib.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/lib/PopupComponents.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/lib/ValidationChecker.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/lib/MoveGrid.js' type="text/javascript"></script>

<script src='${pageContext.request.contextPath}/resources/js/jquery.validate.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jquery-ui-1.8.23.custom.min.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jquery.layout.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jquery.form.js' type="text/javascript"></script>
<!-- 
현재 구버전
<script src='${pageContext.request.contextPath}/resources/js/jquery.jqGrid.js' type="text/javascript"></script>

 -->
<script src='${pageContext.request.contextPath}/resources/js/jquery.tablednd.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jquery.contextmenu.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jquery.cookie.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jquery.session.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jquery.tmpl.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jquery.masonry.min.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jquery.selectBox.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jquery.imageradio.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jquery.imagecheckbox.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jquery.watermark.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jquery.blockUI.js' type="text/javascript"></script>
<!-- <script src='${pageContext.request.contextPath}/resources/js/icekake/rating.js' type="text/javascript"></script> 
-->



<script src='${pageContext.request.contextPath}/resources/js/jquery.xml2json.js' type="text/javascript"></script>

<script src='${pageContext.request.contextPath}/resources/js/fancybox/jquery.mousewheel-3.0.4.pack.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/fancybox/jquery.fancybox-1.3.4.pack.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/fileupload/util.js' type='text/javascript'></script>
<script src='${pageContext.request.contextPath}/resources/js/i18n/grid.locale-en.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/ui.multiselect.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/gibberish/gibberish-aes.js' type="text/javascript"></script>


<script src='${pageContext.request.contextPath}/resources/js/json2.js' type="text/javascript"></script>
 
<script src='${pageContext.request.contextPath}/resources/js/jquery.selectboxes.js' type="text/javascript"></script>

<script src='${pageContext.request.contextPath}/resources/js/icekake/date.js' type="text/javascript"></script>
 
<script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.pager.js' type="text/javascript"></script>
<%-- <script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.grid.js' type="text/javascript"></script> --%>

<script src='${pageContext.request.contextPath}/resources/js/smartEditor/js/HuskyEZCreator.js' type="text/javascript"></script>


<script src='${pageContext.request.contextPath}/resources/js/jquery.poshytip.js' type="text/javascript"></script>
<!-- 
<script src='${pageContext.request.contextPath}/resources/js/slider/slides.min.jquery.js' type="text/javascript"></script>

<script src='${pageContext.request.contextPath}/resources/js/icekake/calendar.js' type="text/javascript"></script>

<script src='${pageContext.request.contextPath}/resources/js/toTop/jquery.ui.totop.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.totop.js' type="text/javascript"></script>

<a href="#" id="toTop" style="display: none;"><span id="toTopHover"></span>To Top</a>
 -->
 
<script src='${pageContext.request.contextPath}/resources/js/jquery.editable.js' type="text/javascript"></script>
 
<script src='${pageContext.request.contextPath}/resources/js/jquery.progressbar/js/jquery.progressbar.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jquery.splitter.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jQueryRotate.2.2.js' type="text/javascript"></script>


<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/fileupload/jquery.ui.widget.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/fileupload/jquery.iframe-transport.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/fileupload/jquery.fileupload.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/fileupload/jquery.fileupload-ui.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/fileupload/jquery.fileupload-fp.js'></script>


<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/jquery.multiFilestyle.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/resources/js/jquery.tmpl.js'></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/lib/MultiUploader.js"></script>

<script>
$(document).ready(function(){
    
    
    document.oncontextmenu = function() {return false;};

  $(document).mousedown(function(e){ 
    if( e.button == 2 || e.which==3) { 
      return false; 
    } 
  }); 
  
  //$('.top_scroll').css('display','none');
  
    $(window).load(function(){
        //$('.top_scroll').fadeOut();
        
        $.ifvmScanPoshytip();
    });
    
    $(window).scroll(function(){
        //console.log($(this).scrollTop());
        
        if ($(this).scrollTop() > 100) {
            $('.top_scroll').show();
            $('.top_scroll').fadeIn();
        } else {
            $('.top_scroll').fadeOut();
            $('.top_scroll').hide();
        }
    }); 

    $('.top_scroll').click(function(){
        $("html, body").animate({ scrollTop: 0 }, 600);
        return false;
    });

});

$(document).keydown(function(event){
    if(event.keyCode == 27) {
        if(parent.$.smartPop.install)
             parent.$.smartPop.close();
    }
});
</script>


<div id="fullscreenLoading" class="fullscreen_loading"><img src='<ifvm:image name="moreLoading"/>' /></div>
<a href="#" class="top_scroll" style="display: none;"><spring:message code="M00113"/></a>




