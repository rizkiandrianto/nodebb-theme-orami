<!DOCTYPE html>
<html lang="{function.localeToHTML, userLang, defaultLang}" <!-- IF languageDirection -->data-dir="{languageDirection}" style="direction: {languageDirection};" <!-- ENDIF languageDirection --> >
<head>
	<title>{browserTitle}</title>
	<!-- BEGIN metaTags -->{function.buildMetaTag}<!-- END metaTags -->
	<link rel="stylesheet" type="text/css" href="{relative_path}/assets/stylesheet.css?{config.cache-buster}" />
	<!-- IF bootswatchCSS --><link id="bootswatchCSS" href="{bootswatchCSS}" rel="stylesheet" media="screen"><!-- ENDIF bootswatchCSS -->
	<!-- BEGIN linkTags -->{function.buildLinkTag}<!-- END linkTags -->

	<script>
		var RELATIVE_PATH = "{relative_path}";
		var config = JSON.parse('{{configJSON}}');
		var app = {
			template: "{template.name}",
			user: JSON.parse('{{userJSON}}')
		};
	</script>

	<!-- IF useCustomHTML -->
	{{customHTML}}
	<!-- END -->
	<!-- IF useCustomCSS -->
	<style>{{customCSS}}</style>
	<!-- END -->
</head>

<body class="{bodyClass} skin-{config.bootswatchSkin}">
	<nav id="menu" class="slideout-menu hidden">
		<div class="menu-profile">
			<!-- IF user.uid -->
				<!-- IF user.picture -->
					<img src="{user.picture}"/>
					<!-- ELSE -->
					<div class="user-icon" style="background-color: {user.icon:bgColor};">{user.icon:text}</div>
				<!-- ENDIF user.picture -->
				<i component="user/status" class="fa fa-fw fa-circle status {user.status}"></i>
			<!-- ENDIF user.uid -->
		</div>

		<section class="menu-section" data-section="navigation">
			<h3 class="menu-section-title">[[global:header.navigation]]</h3>
			<ul class="menu-section-list">
				<!-- IF !maintenanceHeader -->
					<!-- BEGIN navigation -->
						<!-- IF function.displayMenuItem, @index -->
							<li class="{navigation.class}">
								<a class="navigation-link" href="{navigation.route}" title="{navigation.title}" <!-- IF navigation.id -->id="{navigation.id}"<!-- ENDIF navigation.id --><!-- IF navigation.properties.targetBlank --> target="_blank"<!-- ENDIF navigation.properties.targetBlank -->>
									<!-- IF navigation.iconClass -->
									<!--
										<i class="fa fa-fw {navigation.iconClass}" data-content="{navigation.content}"></i>
									-->
									<!-- ENDIF navigation.iconClass -->

									<!-- IF navigation.text -->
									<span class="{navigation.textClass}">{navigation.text}</span>
									<!-- ENDIF navigation.text -->
								</a>
								<div class="border"></div>
							</li>
						<!-- ENDIF function.displayMenuItem -->
					<!-- END navigation -->
				<!-- ENDIF !maintenanceHeader -->

				<!-- IF !maintenanceHeader && config.searchEnabled -->
				<li class="visible-xs" id="search-menu">
					<a href="{relative_path}/search">
						<i class="fa fa-search fa-fw"></i> [[global:search]]
					</a>
				</li>
				<!-- ENDIF !maintenanceHeader && config.searchEnabled -->
			</ul>
		</section>

		<!-- IF config.loggedIn -->
		<section class="menu-section" data-section="profile">
			<h3 class="menu-section-title">[[global:header.profile]]</h3>
			<ul class="menu-section-list" component="header/usercontrol">
				<li>
					<a component="header/profilelink" href="{relative_path}/user/{user.userslug}">
						<i component="user/status" class="fa fa-fw fa-circle status {user.status}"></i> <span component="header/username">{user.username}</span>
					</a>
				</li>
				<li role="presentation" class="divider"></li>
				<li>
					<a href="#" class="user-status" data-status="online">
						<i class="fa fa-fw fa-circle status online"></i><span> [[global:online]]</span>
					</a>
				</li>
				<li>
					<a href="#" class="user-status" data-status="away">
						<i class="fa fa-fw fa-circle status away"></i><span> [[global:away]]</span>
					</a>
				</li>
				<li>
					<a href="#" class="user-status" data-status="dnd">
						<i class="fa fa-fw fa-circle status dnd"></i><span> [[global:dnd]]</span>
					</a>
				</li>
				<li>
					<a href="#" class="user-status" data-status="offline">
						<i class="fa fa-fw fa-circle status offline"></i><span> [[global:invisible]]</span>
					</a>
				</li>
				<li role="presentation" class="divider"></li>
				<li>
					<a component="header/profilelink/edit" href="{relative_path}/user/{user.userslug}/edit">
						<i class="fa fa-fw fa-edit"></i> <span>[[user:edit-profile]]</span>
					</a>
				</li>
				<li>
					<a component="header/profilelink/settings" href="{relative_path}/user/{user.userslug}/settings">
						<i class="fa fa-fw fa-gear"></i> <span>[[user:settings]]</span>
					</a>
				</li>
				<!-- IF showModMenu -->
					<li role="presentation" class="divider"></li>
					<li class="dropdown-header">[[pages:moderator-tools]]</li>
					<li>
						<a href="{relative_path}/flags">
							<i class="fa fa-fw fa-flag"></i> <span>[[pages:flagged-content]]</span>
						</a>
					</li>
					<li>
						<a href="{relative_path}/post-queue">
							<i class="fa fa-fw fa-list-alt"></i> <span>[[pages:post-queue]]</span>
						</a>
					</li>
					<!-- IF isAdmin -->
						<li>
							<a href="{relative_path}/ip-blacklist">
								<i class="fa fa-fw fa-ban"></i> <span>[[pages:ip-blacklist]]</span>
							</a>
						</li>
					<!-- ENDIF isAdmin -->
				<!-- ENDIF showModMenu -->
				<li role="presentation" class="divider"></li>
				<li component="user/logout">
					<form method="post" action="{relative_path}/logout">
						<input type="hidden" name="_csrf" value="{config.csrf_token}">
						<input type="hidden" name="noscript" value="true">
						<button type="submit" class="btn btn-link">
							<i class="fa fa-fw fa-sign-out"></i><span> [[global:logout]]</span>
						</button>
					</form>
				</li>
			</ul>
		</section>

		<section class="menu-section" data-section="notifications">
			<h3 class="menu-section-title">
				[[global:header.notifications]]
				<span class="counter unread-count" component="notifications/icon" data-content="{unreadCount.notification}"></span>
			</h3>
			<ul class="menu-section-list notification-list-mobile" component="notifications/list"></ul>
			<p class="menu-section-list"><a href="{relative_path}/notifications">[[notifications:see_all]]</a></p>
		</section>
		<!-- ENDIF config.loggedIn -->
	</nav>
	<nav id="chats-menu" class="slideout-menu hidden">
		<!-- IF config.loggedIn -->
		<section class="menu-section" data-section="chats">
			<h3 class="menu-section-title">
				[[global:header.chats]]
				<i class="counter unread-count" component="chat/icon" data-content="{unreadCount.chat}"></i>
			</h3>
			<ul class="menu-section-list chat-list" component="chat/list"></ul>
		</section>
		<!-- ENDIF config.loggedIn -->
	</nav>

	<main id="panel" class="slideout-panel">
		 <nav class="navbar navbar-default navbar-fixed-top header" id="header-menu" component="navbar">
			<div id="header-container" class="container-fluid">
				<!-- {* IMPORT partials/menu.bak.tpl *} -->
				<!-- IMPORT partials/menu.tpl -->
			</div>
		</nav>
		<div class="container" id="content">
		<!-- IMPORT partials/noscript/warning.tpl -->
