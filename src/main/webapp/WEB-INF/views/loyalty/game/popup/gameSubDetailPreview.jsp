<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div id="stampBingoStepPopValid">
    <div class="form-horizontal underline top_well">
        <img src="" alt="game preview" class="" id="gamePreview" style="width: 60%; display: block; margin: 0px auto;"/>
    </div>
</div>

<script type="text/javascript">

$(document).ready(function(){
    //룰렛
    if($('#gameTypeCd').val() == 'R'){
        $('#gamePreview').attr("src",'<ifvm:image name='game_roulette_preview'/>')
     //조합           
    } else if($('#gameTypeCd').val() == 'C'){
          $('#gamePreview').attr("src",'<ifvm:image name='game_combination_preview'/>')
    //주사위
    } else {
        $('#gamePreview').attr("src",'<ifvm:image name='game_dice_preview'/>')
    }
});
</script>