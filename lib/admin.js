'use strict';
/* globals $, app */

define('admin/plugins/orami', ['settings'], function(Settings) {

	var ACP = {};
	console.log(Settings);
	ACP.init = function() {
		Settings.load('orami', $('.orami-settings'), function(set) {
			console.log(set);
		});

		$('#save').on('click', function() {
			Settings.save('orami', $('.orami-settings'), function() {
				app.alert({
					type: 'success',
					alert_id: 'orami-saved',
					title: 'Settings Saved',
					message: 'orami settings saved'
				});
			});
		});
	};

	return ACP;
});