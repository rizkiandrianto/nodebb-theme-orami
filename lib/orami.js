"use strict";
/*globals ajaxify, config, utils, app, socket, NProgress*/

$(document).ready(function() {
	var HOST = 'https://vision.orami.co.id/api/';
	var COMMERCE = 'https://orami.co.id';
	setupNProgress();
	setupTaskbar();
	setupEditedByIcon();
	setupMobileMenu();
	setupQuickReply();
	setupSlider();
	getHeader();

	$(".navbar-fixed-top").autoHidingNavbar({
		showOnBottom: false
	});

	/* Megamenu  */
	$('.main-direktori').on('mouseenter', function() {
		$(this).addClass('active');
	});

	$('#globalHeader').on('mouseenter', 'li', function() {
		var _this = $(this);
		_this.closest('ul').find('li').removeClass('active');
		setTimeout(function() {
			_this.addClass('active');
			_this.children('ul').children('li:first-child').addClass('active');
		}, 10);
	});

	$('#globalHeader').on('mouseleave', function() {
		$('.main-direktori, .main-direktori #globalHeader li').removeClass('active');
	});
	/* Endof Megamenu */

	function setupSlider() {
		$(window).on('action:ajaxify.end', function(ev, data) {
			$('#bxslider').bxSlider({
				auto: true,
				stopAutoOnClick: true,
				infiniteLoop: false,
				prevText: '<i class="fa fa-angle-left"></i>',
				nextText: '<i class="fa fa-angle-right"></i>'
			});
			setTimeout(function() {
				$('.bx-wrapper a').each(function(e) {
					var target = $(this).attr('data-target');
					if (target) {
						$(this).attr('href', target);
					} else {
						$(this).removeAttr('href');
					}
				});
			}, 100);
		});
	}

	function setupNProgress() {
		$(window).on('action:ajaxify.start', function() {
			NProgress.set(0.7);
		});

		$(window).on('action:ajaxify.end', function(ev, data) {
			NProgress.done();
			setupHoverCards();

			if (data.url && data.url.match('user/')) {
				setupFavouriteButtonOnProfile();
			}
		});
	}

	function setupTaskbar() {
		$(window).on('filter:taskbar.push', function(ev, data) {
			data.options.className = 'taskbar-' + data.module;

			if (data.module === 'composer') {
				data.options.icon = 'fa-plus';
			} else if (data.module === 'chat') {
				if (!data.element.length) {
					createChatIcon(data);
					$(window).one('action:taskbar.pushed', function(ev, data) {
						updateChatCount(data.element);
					});

				} else if (!data.element.hasClass('active')) {
					updateChatCount(data.element);
				}
			}
		});

		socket.on('event:chats.markedAsRead', function(data) {
			$('#taskbar [data-roomId="' + data.roomId + '"]')
				.removeClass('new')
				.attr('data-content', 0);
		});

		function createChatIcon(data) {
			data.options.icon = 'fa-spinner fa-spin';

			$.getJSON(config.relative_path + '/api/user/' + utils.slugify(data.options.title), function(user) {
				var el = $('#taskbar [data-uuid="' + data.uuid + '"] a');
				el.find('i').remove();
				el.parent('[data-uuid]').attr('data-roomId', data.options.roomId);

				if (user.picture) {
					el.css('background-image', 'url(' + user.picture + ')');
				} else {
					el	.css('background-color', user['icon:bgColor'])
						.text(user['icon:text'])
						.addClass('user-icon');
				}
			});
		}

		function updateChatCount(el) {
			var count = (parseInt($(el).attr('data-content'), 10) || 0) + 1;
			$(el).attr('data-content', count);
		}
	}

	function setupEditedByIcon() {
		function activateEditedTooltips() {
			$('[data-pid] [component="post/editor"]').each(function() {
				var el = $(this), icon;

				if (!el.attr('data-editor')) {
					return;
				}

				icon = el.closest('[data-pid]').find('.edit-icon').first();
				icon.prop('title', el.text()).tooltip('fixTitle').removeClass('hidden');
			});
		}

		$(window).on('action:posts.edited', function(ev, data) {
			var parent = $('[data-pid="' + data.post.pid + '"]');
			var icon = parent.find('.edit-icon').filter(function (index, el) {
				return parseInt($(el).closest('[data-pid]').attr('data-pid'), 10) === parseInt(data.post.pid, 10);
			});
			var el = parent.find('[component="post/editor"]').first();
			icon.prop('title', el.text()).tooltip('fixTitle').removeClass('hidden');
		});

		$(window).on('action:topic.loaded', activateEditedTooltips);
		$(window).on('action:posts.loaded', activateEditedTooltips);
	}

	function setupMobileMenu() {
		if (!window.addEventListener) {
			return;
		}


		require(['pulling', 'storage'], function (Pulling, Storage) {
			// initialization

			var chatMenuVisible = !config.disableChat && app.user && parseInt(app.user.uid, 10);
			var swapped = !!Storage.getItem('orami:menus:legacy-layout');
			var margin = window.innerWidth;

			if (swapped) {
				$('#mobile-menu').removeClass('pull-left');
				$('#mobile-chats').addClass('pull-left');
			}

			if (document.documentElement.getAttribute('data-dir') === 'rtl') {
				swapped = !swapped;
			}

			var navSlideout = Pulling.create({
				panel: document.getElementById('panel'),
				menu: document.getElementById('menu'),
				width: 256,
				margin: margin,
				side: swapped ? 'right' : 'left',
			});
			$('#menu').removeClass('hidden');

			var chatsSlideout;
			if (chatMenuVisible) {
				chatsSlideout = Pulling.create({
					panel: document.getElementById('panel'),
					menu: document.getElementById('chats-menu'),
					width: 256,
					margin: margin,
					side: swapped ? 'left' : 'right',
				});
				$('#chats-menu').removeClass('hidden');
			}

			// all menus

			function closeOnClick() {
				navSlideout.close();
				if (chatsSlideout) { chatsSlideout.close(); }
			}

			function onBeforeOpen() {
				document.documentElement.classList.add('slideout-open');
			}

			function onClose() {
				document.documentElement.classList.remove('slideout-open');
				$('#panel').off('click', closeOnClick);
			}

			$(window).on('resize action:ajaxify.start', function () {
				navSlideout.close();
				if (chatsSlideout) { chatsSlideout.close(); }
				$('.account .cover').css('top', $('[component="navbar"]').height());
			});

			navSlideout
				.ignore('code, code *, .preventSlideout, .preventSlideout *')
				.on('closed', onClose)
				.on('beforeopen', onBeforeOpen)
				.on('opened', function () {
					$('#panel').one('click', closeOnClick);
				});

			if (chatMenuVisible) {
				chatsSlideout
					.ignore('code, code *, .preventSlideout, .preventSlideout *')
					.on('closed', onClose)
					.on('beforeopen', onBeforeOpen)
					.on('opened', function () {
						$('#panel').one('click', closeOnClick);
					});
			}

			// left slideout navigation menu

			$('#mobile-menu').on('click', function () {
				navSlideout.enable().toggle();
			});

			function loadNotifications() {
				require(['notifications'], function(notifications) {
					notifications.loadNotifications($('#menu [data-section="notifications"] ul'));
				});
			}

			navSlideout.on('opened', loadNotifications);

			if (chatMenuVisible) {
				navSlideout.on('beforeopen', function () {
					chatsSlideout.close();
					chatsSlideout.disable();
				}).on('closed', function () {
					chatsSlideout.enable();
				});
			}

			/* $('#menu [data-section="navigation"] ul').html(($('#main-nav').html() || "") + ($('#search-menu').html() || '') + ($('#logged-out-menu').html() || ''));
			$('#user-control-list').children().clone(true, true).appendTo($('#menu [data-section="profile"] ul'));
			$('#menu [data-section="profile"] ul').find('[component="user/status"]').remove(); */

			socket.on('event:user_status_change', function(data) {
				if (parseInt(data.uid, 10) === app.user.uid) {
					app.updateUserStatus($('#menu [component="user/status"]'), data.status);
					navSlideout.close();
				}
			});

			// right slideout chats menu

			function loadChats() {
				require(['chat'], function (chat) {
					chat.loadChatsDropdown($('#chats-menu .chat-list'));
				});
			}

			if (chatMenuVisible) {
				$('#mobile-chats').removeClass('hidden').on('click', function() {
					navSlideout.close();
					chatsSlideout.enable().toggle();
				});
				$('#chats-menu').on('click', 'li[data-roomid]', function () {
					chatsSlideout.close();
				});

				chatsSlideout
					.on('opened', loadChats)
					.on('beforeopen', function () {
						navSlideout.close().disable();
					})
					.on('closed', function () {
						navSlideout.enable();
					});
			}

			// add a checkbox in the user settings page
			// so users can swap the sides the menus appear on

			function setupSetting() {
				if (ajaxify.data.template['account/settings'] && !document.getElementById('orami:menus:legacy-layout')) {
					$('<div class="well checkbox"><label><input type="checkbox" id="orami:menus:legacy-layout"/><strong>Switch which side each mobile menu is on</strong></label></div>')
						.appendTo('#content .account > .row > div:first-child')
						.find('input')
						.prop('checked', Storage.getItem('orami:menus:legacy-layout', 'true'))
						.change(function (e) {
							if (e.target.checked) {
								Storage.setItem('orami:menus:legacy-layout', 'true');
							} else {
								Storage.removeItem('orami:menus:legacy-layout');
							}
						});
				}
			}

			$(window).on('action:ajaxify.end', setupSetting);
			setupSetting();
		});
	}

	function setupHoverCards() {
		require(['components'], function(components) {
			components.get('topic')
				.on('click', '[component="user/picture"],[component="user/status"]', generateUserCard);
		});

		$(window).on('action:posts.loading', function(ev, data) {
			for (var i = 0, ii = data.posts.length; i < ii; i++) {
				(ajaxify.data.topics || ajaxify.data.posts)[data.posts[i].index] = data.posts[i];
			}
		});
	}

	function generateUserCard(ev) {
		var avatar = $(this),
			index = avatar.parents('[data-index]').attr('data-index'),
			data = (ajaxify.data.topics || ajaxify.data.posts);

		for (var i = 0, ii = data.length; i < ii; i++) {
			if (parseInt(data[i].index, 10) === parseInt(index, 10)) {
				data = data[i].user;
				break;
			}
		}

		$('.orami-usercard').remove();

		if (parseInt(data.uid, 10) === 0) {
			return false;
		}

		socket.emit('user.isFollowing', {uid: data.uid}, function(err, isFollowing) {
			app.parseAndTranslate('modules/usercard', data, function(html) {
				var card = $(html);
				avatar.parents('a').after(card.hide());

				if (parseInt(app.user.uid, 10) === parseInt(data.uid, 10) || !app.user.uid) {
					card.find('.btn-morph').hide();
				} else {
					setupFavouriteMorph(card, data.uid, data.username);

					if (isFollowing) {
						$('.btn-morph').addClass('heart');
					} else {
						$('.btn-morph').addClass('plus');
					}
				}

				utils.makeNumbersHumanReadable(card.find('.human-readable-number'));
				setupCardRemoval(card);
				card.fadeIn();
			});
		});

		ev.preventDefault();
		return false;
	}

	function setupFavouriteButtonOnProfile() {
		setupFavouriteMorph($('[component="account/cover"]'), ajaxify.data.uid, ajaxify.data.username);
	}

	function setupCardRemoval(card) {
		function removeCard(ev) {
			if ($(ev.target).closest('.orami-usercard').length === 0) {
				card.fadeOut(function() {
					card.remove();
				});

				$(document).off('click', removeCard);
			}
		}

		$(document).on('click', removeCard);
	}

	function setupFavouriteMorph(parent, uid, username) {
		parent.find('.btn-morph').click(function(ev) {
			var type = $(this).hasClass('plus') ? 'follow' : 'unfollow';

			socket.emit('user.' + type, {uid: uid}, function(err) {
				if (err) {
					return app.alertError(err.message);
				}

				app.alertSuccess('[[global:alert.' + type + ', ' + username + ']]');
			});

			$(this).toggleClass('plus').toggleClass('heart');
			$(this).translateAttr('title', type  === 'follow' ? '[[global:unfollow]]' : '[[global:follow]]');

			if ($(this).find('b.drop').length === 0) {
				$(this).prepend('<b class="drop"></b>');
			}

			var drop = $(this).find('b.drop').removeClass('animate'),
				x = ev.pageX - drop.width() / 2 - $(this).offset().left,
				y = ev.pageY - drop.height() / 2 - $(this).offset().top;

			drop.css({top: y + 'px', left: x + 'px'}).addClass('animate');
		});
	}

	function setupQuickReply() {
		$(window).on('action:ajaxify.end', function(ev, data) {
			if (data.url && data.url.match('^topic/')) {
				require(['orami/quickreply'], function(quickreply) {
					quickreply.init();
				});
			}
		});
	}

	function getHeader() {
		require(['storage', 'moment'], function(Storage, moment) {
			$('#globalHeader').each(function() {
				var KEY = 'categories';
				var KEY_TIMESTAMP = 'categories_expired';
				var STORAGE = Storage.getItem(KEY);
				var STORAGE_EXPIRED = Storage.getItem(KEY_TIMESTAMP);
				var EXPIRED_IN_DAYS = 7;
				var _this = $(this);
				var TIMESTAMP = moment().add(EXPIRED_IN_DAYS, 'days').unix();
				var NOW = moment().unix();
				var ADDITION_MENU = [{
					title: 'Cek Pesanan',
					link: COMMERCE + '/cekpesanan'
				}, {
					title: 'Pesan Pagi Sore Sampai',
					link: COMMERCE + '/pengiriman-express'
				}, {
					title: 'Kartu Kredit',
					link: COMMERCE + '/kartu-kredit'
				}, {
					title: 'Magazine',
					link: COMMERCE + '/magazine',
					class: 'with-border'
				}, {
					title: 'Belanja Berdasarkan Kategori:',
					class: 'no-click',
				}];

				if (STORAGE !== null && (STORAGE_EXPIRED !== null && NOW < STORAGE_EXPIRED)) {
					_this.html(STORAGE);
				} else {
					$.ajax({
						url: HOST + 'megamenu/?tree_id=1',
						crossDomain: true,
					}).done(function(data) {
						var _data = ADDITION_MENU.concat(data);
						var HTML = templateHeader(_data, 1);
						Storage.setItem(KEY, HTML);
						Storage.setItem(KEY_TIMESTAMP, TIMESTAMP);
						_this.html(HTML);
					});
				}	
			});
		})
	}

	function templateHeader(data, level) {
		var HTML = '';
		var special = ['zeroth','first', 'second', 'third', 'fourth', 'fifth', 'sixth'];
		data.map(function(key, index) {
			if (index === 0) {
				HTML += '<ul class="megamenu-item ' + (special[level] + '-level') + '">';
			}
			var link = COMMERCE + key.link;
			var hasSubmenu = key.children && key.children.length;
			HTML += '<li class="' + ( hasSubmenu ? 'has-submenu' : '') + ' ' + (key.class || '') + '">' + 
						'<a href="' + (key.link ? link : '#') + '">' + key.title +
							'<i class="fa fa-chevron-right pull-right symbol"></i>' +
						'</a>';
			if (hasSubmenu) {
				HTML += templateHeader(key.children, level+1);
			}
			HTML += '</li>';
			if (index === data.length - 1) {
				HTML += '</ul>';
			}
		});
		return HTML;
	}
});
