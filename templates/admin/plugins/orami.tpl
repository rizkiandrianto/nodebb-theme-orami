<form role="form" class="orami-settings">
	<div class="row">
		<div class="col-sm-2 col-xs-12 settings-header">Theme Settings</div>
		<div class="col-sm-10 col-xs-12">	
				<div class="checkbox">
					<label class="mdl-switch mdl-js-switch mdl-js-ripple-effect">
						<input class="mdl-switch__input" type="checkbox" id="hideSubCategories" name="hideSubCategories">
						<span class="mdl-switch__label"><strong>Hide subcategories on categories view</strong></span>
					</label>
				</div>
				<div class="checkbox">
					<label class="mdl-switch mdl-js-switch mdl-js-ripple-effect">
						<input class="mdl-switch__input" type="checkbox" id="hideCategoryLastPost" name="hideCategoryLastPost">
						<span class="mdl-switch__label"><strong>Hide last post on categories view</strong></span>
					</label>
				</div>
				<div class="checkbox">
					<label class="mdl-switch mdl-js-switch mdl-js-ripple-effect">
						<input class="mdl-switch__input" type="checkbox" id="enableQuickReply" name="enableQuickReply">
						<span class="mdl-switch__label"><strong>Enable quick reply</strong></span>
					</label>
				</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-2 col-xs-12 settings-header">Homepage</div>
		<div class="col-sm-10 col-xs-12">
			<div class="form-group">
				<label for="mainLogo">Main Logo on Homepage</label>
				<input type="text" class="form-control" id="mainLogo" placeholder="Main Logo on Homepage" name="mainLogo">
			</div>
			<div class="form-group">
				<label for="slider">Slider</label>
				<textarea class="form-control" rows="10" placeholder="Slider on Homepage" name="slider"></textarea>
			</div>
		</div>
	</div>
</form>
	
<button id="save" class="floating-button mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored">
    <i class="material-icons">save</i>
</button>