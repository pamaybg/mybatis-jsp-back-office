
<script id="htmlTemplate" type="text/x-jsrender">
<div></div>
</script>

<script id="segmentNodeTemplate" type="text/x-jquery-tmpl">
<div id="{{:addInfo.nodeId}}{{:addInfo._Suffix}}" ondrop="nodeondrop(event)" class="attribute_box text_nodrag {{:addInfo.attributeType}}">
    <span class="ellip"> <i class="fa fa-users" aria-hidden="true"></i>{{:addInfo.data.displayName}}</span>
    <ul id="attribute">
		<li class="attribute_num"><i class="fa fa-user" aria-hidden="true"></i> {{:addInfo.data.filterCount}}</li>
		{{if addInfo.attributeType != "attribute_all"}}
			<li class="ellip"><i class="fa fa-caret-right" aria-hidden="true"></i>{{:addInfo.data.filterText}} </li>
			{{if addInfo.data.filterText2 != "" && addInfo.data.filterText2 != null}}
				<li class="ellip"><i class="fa fa-caret-right" aria-hidden="true"></i>{{:addInfo.data.filterText2}} </li>
			{{/if}}
		{{/if}}
    </ul>
</div>
</script>

<script id="lgcCompTableNodeTemplate" type="text/x-jquery-tmpl">
    <div id="{{:addInfo.nodeId}}{{:addInfo._Suffix}}" class="foreignObject lgcComp_tbl_box {{:addInfo.tableType}}">
			<div class="icon_img" id="icon_img" ></div>
			<div id="aTblNm_{{:addInfo.nodeId}}" class="con text">
				{{:addInfo.tableName}}
            </div>
			<div id="divTableNodeDelete" class="del">
				<a id="aTableNodeDelete" href="#">
				<i class="fa fa-times"></i>
			</div>
	</div>
</script>
