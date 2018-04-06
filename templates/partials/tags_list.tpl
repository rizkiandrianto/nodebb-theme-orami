<!-- BEGIN tags -->
<h3 class="pull-left tag-container">
	<a href="{config.relative_path}/tags/{tags.value}" data-value="{tags.value}" style="<!-- IF tags.bgColor -->background-color: {tags.bgColor};<!-- ENDIF tags.bgColor -->">
		<span class="tag-item" data-tag="{tags.value}" style="<!-- IF tags.color -->color: {tags.color};<!-- ENDIF tags.color -->">{tags.value}</span>
		<span class="tag-topic-count human-readable-number" title="{tags.score}" style="<!-- IF tags.color -->color: {tags.color};<!-- ENDIF tags.color -->">{tags.score}</span>
	</a>
</h3>
<!-- END tags -->