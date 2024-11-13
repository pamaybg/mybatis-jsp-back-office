<script>
	$("#ifvGridTemplete").remove();
	$("#ifvConfirmTemplete").remove();
</script>
<script id="ifvGridTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete" style="padding:5px 5px 5px 5px">
		<div class="filter_area">
			<div class="left pos_l0">
				<div class="total_area">{total}</div>
			</div>
			<div class="right pos_r0">
				{rowsBox}
			</div>
		</div>
		<div class="grid_con">
			{grid}
		</div>
		<div class="page">
			{page}
		</div>
	</div>
</script>

<script id="ifvGridOriginTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete" style="padding:5px 5px 5px 5px">
		{title}

		<div class="filter_area">
			<div class="left">
				{searchBox}
			</div>	
		</div>
		<div class="grid_con">
			{grid}
		</div>
			<div class="total_area">{total}</div>
		<div class="page">
			{page}
		<div>
		<div class="right pos_r0" id="rowBoxsId" style="top:10px;">
				{rowsBox}
		</div>
	</div>
</script>

<script id="ifvGridOriginTemplete3" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete" style="padding:5px 5px 5px 5px">
		{title}

		<div class="filter_area">
			<div class="left">
				{searchBox}
			</div>
			<div class="right">
				{authBox}
			</div>
		</div>

		<div class="grid_con">
			{grid}
		</div>
			<div class="total_area">{total}</div>
		<div class="page">
			{page}
		<div>
	<div class="right pos_r0" id="rowBoxsId" style="top:10px;">
				{rowsBox}
		</div>        
	</div>
</script>

<script id="ifvConfirmTemplete" type="text/ifvGrid-tmpl">
	<div class='dark_alpha_pop'>
		<div id='toastPop'>
			{txt_area}
			{img_area}
			<div class='btn_area'>
				{btn1}
				{btn2}
			</div>
		</div>
	</div>
</script>

<script id="ifvGridSimpleTemplete" type="text/ifvGrid-tmpl">
    <div class="ifv_grid_templete">
        {title}
        <div class="grid_con">
            {grid}
        </div>
        <div class="page">
            <div class="total_area">{total}</div>
        <div>
    </div>
</script>

<script id="ifvGridSimpleTemplete2" type="text/ifvGrid-tmpl">
    <div class="ifv_grid_templete">
        {title}
        <div class="grid_con">
            {grid}
        </div>
    </div>
</script>

<script id="ifvGridSimplePageTemplete2" type="text/ifvGrid-tmpl">
    <div class="ifv_grid_templete">
        <div class="grid_con">
            {grid}
        </div>
        <div class="page">
			{page}
			<div class="total_area">{total}</div>
		<div>
		<div class="right pos_r0" id="rowBoxsId" style="top:10px;">
			{rowsBox}
		</div>
    </div>
</script>

<script id="ifvGridSimplePageTemplete3" type="text/ifvGrid-tmpl">
    <div class="ifv_grid_templete">
        <div class="grid_con">
            {grid}
        </div>
        <div class="page">
			<div class="total_area">{total}</div>
		<div>
    </div>
</script>

<script id="ifvGridOriginTemplete2" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		{title}

		<div class="filter_area">
			<div class="left">
				{searchBox}
			</div>
		</div>

		<div class="grid_con">
			{grid}
		</div>
		<div class="page">
			{page}
			<div class="total_area">{total}</div>
		<div>
	</div>
</script>


<script id="ifvGridExcelTemplete" type="text/ifvGrid-tmpl">
    	<div class="ifv_grid_templete">
		{title}

		<div class="filter_area">
			<div class="right">
				{excelDown}
			</div>
		</div>

		<div class="grid_con">
			{grid}
		</div>
		<div class="total_area">{total}</div>
		<div class="page">
			{page}
		<div>
	</div>
</script>

<script id="ifvGridSimplePageTemplete" type="text/ifvGrid-tmpl">
    <div class="ifv_grid_templete">
        {title}
        <div class="grid_con">
            {grid}
        </div>
        <div class="page">
            {page}
            <div class="total_area">{total}</div>
			<div class="right pos_r0" id="rowBoxsId" style="top:10px;">
				{rowsBox}
		</div>        
<div>
    </div>
</script>


<script id="ifvGridOriginTemplete4" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		<div class="filter_area">
			<div class="left">
				{searchBox}
			</div>
		</div>

		<div class="grid_con">
			{grid}
		</div>
		<div class="page">
			{page}
			<div class="total_area">{total}</div>
		<div>
	</div>
</script>







<script id="ifvAccordionConTemplate" type="text/x-jquery-tmpl">
<h3 id="${'${'}id}">${'${'}text}</h3>
    <div id="con_${'${'}id}">${'${'}contents}</div>
</div>
</script>

<script id="ifvLogicalComponentTreeViewTemplate" type="text/x-jquery-tmpl">
<div id="{{:id}}" class="{{if colType != "P"}}tree_wrap{{else}}tree_1depth{{/if}}">
    <ul>
        <li>{{:text}}</li>
    </ul>
</div>
</script>

<script id="ifvAttributeGroupColumnTreeViewTemplate" type="text/x-jquery-tmpl">
<div id="{{:id}}" class="{{if colType != "P"}}tree_wrap{{else}}tree_1depth{{/if}}">
    <ul class="{{if colType == "D"}} col_d{{/if}}{{if colType == "M"}} col_m{{/if}}">
        <li>{{:text}}</li>
    </ul>
</div>
</script>

<script id="baseTreeTemplate" type="text/x-jsrender">
{{if nodeType == "F"}}
	<span class="folder_icon sprite-folder"></span>{{:nodeText}}
{{else}}
	<span class="list_icon sprite-folder"></span>{{:nodeText}}
{{/if}}
</script>

<script id="baseTreeTemplate1" type="text/x-jsrender">
	<span class="list_icon sprite-folder"></span>{{:text}}
</script>


<script id="baseTreeTemplate2" type="text/x-jsrender">
{{if nodeType == "F"}}
    <span class="folder_icon sprite-folder"></span>{{:text}}
{{else}}
    <span class="list_icon sprite-folder"></span>{{:text}}
{{/if}}
</script>

<script id="baseTreeTemplate3" type="text/x-jsrender">
{{if nodeType == "F"}}
    <span class="folder_icon sprite-folder"></span>{{:text}}{{if comment != null && comment != ""}} ({{:comment}}){{/if}}
{{else}}
    <span class="list_icon sprite-folder"></span>{{:text}}{{if comment != null && comment != ""}} ({{:comment}}){{/if}}
{{/if}}
</script>

<script id="baseFolderTreeTemplate" type="text/x-jsrender">
	<span class="folder_icon sprite-folder"></span>{{:nodeText}}
</script>

<script id="commCodeSelectTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="commCodeCheckboxTemplate" type="text/x-jquery-tmpl">
<span class="icheckbox">
<label for="${codeId}">
<input type="checkbox" id="${codeId}" dtoparam="${codeId}" name="${domName}" value="${codeName}">${markName}
</label>
</span>
</script>

<script id="commCodeRadioTemplate" type="text/x-jquery-tmpl">
<span class="iradio">
<label for="${codeId}">
<input type="radio" id="${codeId}" dtoparam="${codeId}" name="${domName}" value="${codeName}">
</label>
</span>
</script>

<script id="ifvOnlyGridTemplate" type="text/ifvGrid-tmpl">
    <div class="ifv_grid_templete">
        <div class="grid_con">
            {grid}
        </div>
    </div>
</script>

<script id="ifvGridNotSearchTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		{title}
		<div class="filter_area">
			<div class="left">
			</div>
		</div>
		<div class="grid_con">
			{grid}
		</div>
			<div class="total_area">{total}</div>
		<div class="page">
			{page}
		<div>
		<div class="right pos_r0" id="rowBoxsId" style="top:10px;">
				{rowsBox}
		</div>
	</div>
</script>

<script id="ifvGridNoneLeftTemplete" type="text/ifvGrid-tmpl">
    <div class="ifv_grid_templete" style="padding:5px 5px 5px 5px">
            <div class="grid_con">
            {grid}
        </div>
        <div class="page">
            {page}
        <div class="total_area">{total}</div>
		<div class="right pos_r0" id="rowBoxsId" style="top:10px;">
			{rowsBox}
		</div>
        </div>
	
   </div>
</script>

<script id="ifvGridSimplePageTemplete5" type="text/ifvGrid-tmpl">
    <div class="ifv_grid_templete">
        <div class="grid_con">
            {grid}
        </div>
        <div class="page">
			{page}
			<div class="total_area">{total}</div>
		<div>
		<div class="right pos_r0" id="rowBoxsId" style="top:10px;">
				{rowsBox}
		</div>
    </div>
</script>

<script id="ifvGridTxnUniqNoTemplete" type="text/ifvGrid-tmpl">
    <div class="ifv_grid_templete" style="padding:5px 5px 5px 5px">
		{title}

		<div class="filter_area">
			<div class="left">
				{searchBox}
			</div>
			<div class="right">
			      <span id ="txnUniqNo"></span>
			</div>
		</div>
		<div class="grid_con">
			{grid}
		</div>
			<div class="total_area">{total}</div>
		<div class="page">
			{page}
		<div>
		<div class="right pos_r0" id="rowBoxsId" style="top:10px;">
				{rowsBox}
		</div>
	</div>
</script>

<script id="ifvGridOriginTemplete5" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete" style="padding:10px 5px 5px 5px">
		<div class="grid_con">
			{grid}
		</div>
			<div class="total_area">{total}</div>
		<div class="page">
			{page}
		<div>
		<div class="right pos_r0" id="rowBoxsId" style="top:10px;">
				{rowsBox}
		</div>
	</div>
</script>

<script id="ifvGridOriginNoneTemplete" type="text/ifvGrid-tmpl">
    <div class="ifv_grid_templete">
        <div class="grid_con">
            {grid}
        </div>
        <div class="page">
			{page}
			<div class="total_area">{total}</div>
		<div>
    </div>
</script>