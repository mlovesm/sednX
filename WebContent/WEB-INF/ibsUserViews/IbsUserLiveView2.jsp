<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<link rel="stylesheet" href="//static.jstree.com/latest/assets/dist/themes/default/style.min.css" />
  <script src="//static.jstree.com/latest/assets/dist/libs/jquery.js"></script>
		<script src="//static.jstree.com/latest/assets/dist/jstree.min.js"></script>
<div id="container" role="main">
			<div id="tree" style="margin-top: 129px;"></div>
			<div id="data">
				<div class="content code" style="display:none;"><textarea id="code" readonly="readonly"></textarea></div>
				<div class="content folder" style="display:none;"></div>
				<div class="content image" style="display:none; position:relative;"><img src="" alt="" style="display:block; position:absolute; left:50%; top:50%; padding:0; max-height:90%; max-width:90%;" /></div>
				<div class="content default" style="text-align:center;">Select a file from the tree.</div>
			</div>
		</div>
		
		
		
		
	<style>
			html, body { background:#ebebeb; font-size:10px; font-family:Verdana; margin:0; padding:0; }
		#container { min-width:320px; margin:0px auto 0 auto; background:black; border-radius:0px; padding:0px; overflow:hidden; }
		#tree { float:left; min-width:319px; border-right:1px solid silver; overflow:auto; padding:0px 0; }
		#data { margin-left:320px; }
		#data textarea { margin:0; padding:0; height:100%; width:100%; border:0; background:black; display:block; line-height:18px; resize:none; }
		#data, #code { font: normal normal normal 12px/18px 'Consolas', monospace !important; }

		#tree .folder { background:url('./file_sprite.png') right bottom no-repeat; }
		#tree .file { background:url('./file_sprite.png') 0 0 no-repeat; }
		#tree .file-pdf { background-position: -32px 0 }
		#tree .file-as { background-position: -36px 0 }
		#tree .file-c { background-position: -72px -0px }
		#tree .file-iso { background-position: -108px -0px }
		#tree .file-htm, #tree .file-html, #tree .file-xml, #tree .file-xsl { background-position: -126px -0px }
		#tree .file-cf { background-position: -162px -0px }
		#tree .file-cpp { background-position: -216px -0px }
		#tree .file-cs { background-position: -236px -0px }
		#tree .file-sql { background-position: -272px -0px }
		#tree .file-xls, #tree .file-xlsx { background-position: -362px -0px }
		#tree .file-h { background-position: -488px -0px }
		#tree .file-crt, #tree .file-pem, #tree .file-cer { background-position: -452px -18px }
		#tree .file-php { background-position: -108px -18px }
		#tree .file-jpg, #tree .file-jpeg, #tree .file-png, #tree .file-gif, #tree .file-bmp { background-position: -126px -18px }
		#tree .file-ppt, #tree .file-pptx { background-position: -144px -18px }
		#tree .file-rb { background-position: -180px -18px }
		#tree .file-text, #tree .file-txt, #tree .file-md, #tree .file-log, #tree .file-htaccess { background-position: -254px -18px }
		#tree .file-doc, #tree .file-docx { background-position: -362px -18px }
		#tree .file-zip, #tree .file-gz, #tree .file-tar, #tree .file-rar { background-position: -416px -18px }
		#tree .file-js { background-position: -434px -18px }
		#tree .file-css { background-position: -144px -0px }
		#tree .file-fla { background-position: -398px -0px }
	
	</style>	
	<script>
	$(function () {
		$(window).resize(function () {
			var h = Math.max($(window).height() - 0, 420);
			$('#container, #data, #tree, #data .content').height(h).filter('.default').css('lineHeight', h + 'px');
		}).resize();

var odata = [ {"id":"1","parent":"#","text":"VOD[17]","name":"VOD","num":"17","state":{"opened":true,"selected":true}},
{"id":"2","parent":"1","text":"영화[0]","name":"영화","num":"0","state":{"opened":true}},
{"id":"3","parent":"1","text":"드라마[0]","name":"드라마","num":"0","state":{"opened":true}},
{"id":"4","parent":"1","text":"스포츠[0]","name":"스포츠","num":"0","state":{"opened":true}},
{"id":"5","parent":"1","text":"뉴스[0]","name":"뉴스","num":"0","state":{"opened":true}},
{"id":"94","parent":"1","text":"평창올림픽[4]","name":"평창올림픽","num":"4","state":{"opened":true}},
{"id":"6","parent":"2","text":"한국영화[0]","name":"한국영화","num":"0","state":{"opened":true}},
{"id":"89","parent":"2","text":"통합[0]","name":"통합","num":"0","state":{"opened":true}},
{"id":"21","parent":"3","text":"KBS[0]","name":"KBS","num":"0","state":{"opened":true}},
{"id":"22","parent":"3","text":"SBS[0]","name":"SBS","num":"0","state":{"opened":true}},
{"id":"23","parent":"3","text":"MBC[0]","name":"MBC","num":"0","state":{"opened":true}},
{"id":"24","parent":"3","text":"JTBC[2]","name":"JTBC","num":"2","state":{"opened":true}},
{"id":"26","parent":"4","text":"야구[0]","name":"야구","num":"0","state":{"opened":true}},
{"id":"27","parent":"4","text":"배구[0]","name":"배구","num":"0","state":{"opened":true}},
{"id":"28","parent":"5","text":"정치[0]","name":"정치","num":"0","state":{"opened":true}},
{"id":"29","parent":"5","text":"경제[0]","name":"경제","num":"0","state":{"opened":true}},
{"id":"17","parent":"6","text":"SF[0]","name":"SF","num":"0","state":{"opened":true}},
{"id":"18","parent":"6","text":"달콤멜로[2]","name":"달콤멜로","num":"2","state":{"opened":true}},
{"id":"19","parent":"6","text":"블랙코메디 [5]","name":"블랙코메디","num":"5","state":{"opened":true}},
{"id":"20","parent":"6","text":"호러[0]","name":"호러","num":"0","state":{"opened":true}},
{"id":"84","parent":"6","text":"액션[0]","name":"액션","num":"0","state":{"opened":true}}];

		$('#tree')
			.jstree({
				'core' : {
					'data' : odata,
					'check_callback' : function(o, n, p, i, m) {
						if(m && m.dnd && m.pos !== 'i') { return false; }
						if(o === "move_node" || o === "copy_node") {
							if(this.get_node(n).parent === this.get_node(p).id) { return false; }
						}
						return true;
					},
					'themes' : {
						'responsive' : false,
						'variant' : 'small',
						'stripes' : true
					}
				},
				'sort' : function(a, b) {
					return this.get_type(a) === this.get_type(b) ? (this.get_text(a) > this.get_text(b) ? 1 : -1) : (this.get_type(a) >= this.get_type(b) ? 1 : -1);
				},
				'contextmenu' : {
					'items' : function(node) {
						var tmp = $.jstree.defaults.contextmenu.items();
						delete tmp.create.action;
						tmp.create.label = "New";
						tmp.create.submenu = {
							"create_folder" : {
								"separator_after"	: true,
								"label"				: "Folder",
								"action"			: function (data) {
									var inst = $.jstree.reference(data.reference),
										obj = inst.get_node(data.reference);
									inst.create_node(obj, { type : "default" }, "last", function (new_node) {
										setTimeout(function () { inst.edit(new_node); },0);
									});
								}
							},
							"create_file" : {
								"label"				: "File",
								"action"			: function (data) {
									var inst = $.jstree.reference(data.reference),
										obj = inst.get_node(data.reference);
									inst.create_node(obj, { type : "file" }, "last", function (new_node) {
										setTimeout(function () { inst.edit(new_node); },0);
									});
								}
							}
						};
						if(this.get_type(node) === "file") {
							delete tmp.create;
						}
						return tmp;
					}
				},
				'types' : {
					'default' : { 'icon' : 'folder' },
					'file' : { 'valid_children' : [], 'icon' : 'file' }
				},
				'unique' : {
					'duplicate' : function (name, counter) {
						return name + ' ' + counter;
					}
				},
				'plugins' : ['state','dnd','sort','types','contextmenu','unique']
			})
			.on('delete_node.jstree', function (e, data) {
				$.get('?operation=delete_node', { 'id' : data.node.id })
					.fail(function () {
						data.instance.refresh();
					});
			})
			.on('create_node.jstree', function (e, data) {
				$.get('?operation=create_node', { 'type' : data.node.type, 'id' : data.node.parent, 'text' : data.node.text })
					.done(function (d) {
						data.instance.set_id(data.node, d.id);
					})
					.fail(function () {
						data.instance.refresh();
					});
			})
			.on('rename_node.jstree', function (e, data) {
				$.get('?operation=rename_node', { 'id' : data.node.id, 'text' : data.text })
					.done(function (d) {
						data.instance.set_id(data.node, d.id);
					})
					.fail(function () {
						data.instance.refresh();
					});
			})
			.on('move_node.jstree', function (e, data) {
				$.get('?operation=move_node', {"id":data.node.id,"parent":"5","text":data.node.text,"name":data.node.text,"num":1,"state":{"opened":true}}) // 이거 알맞게 넣으시면되요. 차장님
					.done(function (d) {
						//data.instance.load_node(data.parent);
						//data.instance.refresh();
					})
					.fail(function () {
						data.instance.refresh();
					});
			})
			.on('copy_node.jstree', function (e, data) {
				$.get('?operation=copy_node', { 'id' : data.original.id, 'parent' : data.parent })
					.done(function (d) {
						//data.instance.load_node(data.parent);
						data.instance.refresh();
					})
					.fail(function () {
						data.instance.refresh();
					});
			})
			.on('changed.jstree', function (e, data) {
				if(data && data.selected && data.selected.length) {
					$.get('?operation=get_content&id=' + data.selected.join(':'), function (d) {
						if(d && typeof d.type !== 'undefined') {
							$('#data .content').hide();
							switch(d.type) {
								case 'text':
								case 'txt':
								case 'md':
								case 'htaccess':
								case 'log':
								case 'sql':
								case 'php':
								case 'js':
								case 'json':
								case 'css':
								case 'html':
									$('#data .code').show();
									$('#code').val(d.content);
									break;
								case 'png':
								case 'jpg':
								case 'jpeg':
								case 'bmp':
								case 'gif':
									$('#data .image img').one('load', function () { $(this).css({'marginTop':'-' + $(this).height()/2 + 'px','marginLeft':'-' + $(this).width()/2 + 'px'}); }).attr('src',d.content);
									$('#data .image').show();
									break;
								default:
									$('#data .default').html(d.content).show();
									break;
							}
						}
					});
				}
				else {
					$('#data .content').hide();
					$('#data .default').html('Select a file from the tree.').show();
				}
			});
	});
	
	
	</script>