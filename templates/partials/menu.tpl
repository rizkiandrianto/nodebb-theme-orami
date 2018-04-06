<!-- IF !maintenanceHeader -->
<div class="main-header hidden-xs">
    <!-- Baris pertama -->
    <div class="row first-row">
        <div class="col-md-6">
            <ul class="top-left-menu">
                <li><span class="gratis-ongkir">Gratis Ongkir</span> Minimum Rp. 200.000*</li>
                <li><a class="detail-link" href="https://www.orami.co.id/free-shipping/?pr=cr1&pb=shipping-policy">Lihat Detil</a></li>
            </ul>
        </div>
        <div class="col-md-6">
            <ul>
                <li><a href="https://www.orami.co.id/konfirmasipembayaran">Konfirmasi Pembayaran</a></li>
                <li><a href="https://www.orami.co.id/login"><i class="favorite-icon icon-love-full"></i> Favoritku</a></li>
            </ul>
        </div>
    </div>

    <!-- Baris Kedua -->
    <div class="row second-row">
        <div class="col-xs-12">
            <div class="main-logo-wrapper">
                <!-- IF brand:logo -->
                    <a href="<!-- IF brand:logo:url -->{brand:logo:url}<!-- ELSE -->{relative_path}/<!-- ENDIF brand:logo:url -->">
                        <img alt="{brand:logo:alt}" class="{brand:logo:display} forum-logo" src="{brand:logo}" />
                    </a>
				<!-- ENDIF brand:logo -->
            </div>
            <div class="main-search-wrapper">
                <form action="https://www.orami.co.id/search" method="GET" autocomplete="off">
                    <input type="search" name="q" placeholder="Cari produk, kategori atau brand..."/>
                    <button type="submit">
                        <i class="icon-search"></i>
                    </button>
                </form>
            </div>
            <div class="main-detail-wrapper">
                <a href="https://www.orami.co.id/cart" class="btn square"><i class="icon-cart"></i></a>
                <!-- IF config.loggedIn -->
                    <div class="user-icon-wrapper">
                        <label for="user-control-list-check" class="dropdown-toggle" data-toggle="dropdown" id="user_dropdown" title="[[global:header.profile]]" role="button">
                            <!-- IF user.picture -->
                            <img width="100%" component="header/userpicture" src="{user.picture}" alt="{user.username}"/>
                            <!-- ELSE -->
                            <span component="header/usericon" class="user-icon" style="background-color: {user.icon:bgColor}; display: block;">{user.icon:text}</span>
                            <!-- ENDIF user.picture --> 
                            <span id="user-header-name" class="visible-xs-inline">{user.username}</span>
                        </label>
                        <input type="checkbox" class="hidden" id="user-control-list-check" aria-hidden="true">
                        <ul id="user-control-list" component="header/usercontrol" class="dropdown-menu" aria-labelledby="user_dropdown">
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
                    </div>
                <!-- ELSE -->
                    <a href="{relative_path}/login" class="btn-login oss-button">Login</a>
                <!-- ENDIF config.loggedIn -->
            </div>
        </div>
    </div>

    <!-- Baris Ketiga -->
    <div class="row third-row">
        <div class="col-md-12">
            <ul class="menu-promo">
                <li class="main-direktori">
                    <a>Direktori Belanja <i class="icon-down-arrow"></i></a>
                    <div id="globalHeader"></div>
                </li>
                <li><a href="https://www.orami.co.id/saldoorami">Saldo Orami</a></li>
                <li><a href="https://www.orami.co.id/pp/pengiriman-express/">Pengiriman Ekspres</a></li>
                <li><a href="https://www.orami.co.id/magazine/">Magazine</a></li>
                <li><a href="https://www.orami.co.id/pp/vaksinasi-prosehat">Vaksinasi Ke Rumah</a></li>
                <li><a class="new-list" href="https://www.orami.co.id/forum/">Forum</a></li>
            </ul>
        </div>
    </div>
</div>

<div class="navbar-header visible-xs">
    <button type="button" class="navbar-toggle pull-left" id="mobile-menu">
        <span component="notifications/icon" class="notification-icon fa fa-fw fa-bell-o unread-count" data-content="{unreadCount.notification}"></span>
        <i class="fa fa-lg fa-bars"></i>
    </button>
    <button type="button" class="navbar-toggle hidden" id="mobile-chats">
        <span component="chat/icon" class="notification-icon fa fa-fw fa-comments unread-count" data-content="{unreadCount.chat}"></span>
        <i class="fa fa-lg fa-comment-o"></i>
    </button>

    <!-- IF brand:logo -->
    <a href="<!-- IF brand:logo:url -->{brand:logo:url}<!-- ELSE -->{relative_path}/<!-- ENDIF brand:logo:url -->">
        <img alt="{brand:logo:alt}" class="{brand:logo:display} forum-logo" src="{brand:logo}" />
    </a>
    <!-- ENDIF brand:logo -->
    <!-- IF config.showSiteTitle -->
    <a href="<!-- IF title:url -->{title:url}<!-- ELSE -->{relative_path}/<!-- ENDIF title:url -->">
        <h1 class="navbar-brand forum-title">{config.siteTitle}</h1>
    </a>
    <!-- ENDIF config.showSiteTitle -->

    <div component="navbar/title" class="visible-xs hidden">
        <span></span>
    </div>
</div>
<!-- ENDIF !maintenanceHeader -->
