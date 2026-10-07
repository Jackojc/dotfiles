// zoom
user_pref("browser.zoom.siteSpecific", false); // per tab zoom

// startup
user_pref("browser.startup.page", 3); // restore session

// interface
user_pref("browser.tabs.inTitlebar", 0); // server side decorations
user_pref("browser.toolbars.bookmarks.visibility", "always");
user_pref("browser.toolbars.bookmarks.showOtherBookmarks", false);
user_pref("sidebar.visibility", "hide-sidebar");
user_pref("general.smoothScroll", false);
user_pref("findbar.highlightAll", true);
user_pref("accessibility.browsewithcaret_shortcut.enabled", false); // no caret prompt on F7
user_pref("accessibility.typeaheadfind.flashBar", 0);

// address bar
user_pref("browser.urlbar.showSearchSuggestionsFirst", false);
user_pref("browser.urlbar.suggest.bookmark", false);
user_pref("browser.urlbar.suggest.history", false);
user_pref("browser.urlbar.suggest.openpage", false);
user_pref("browser.urlbar.suggest.topsites", false);
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.suggest.searches", false);

// downloads
user_pref("browser.download.useDownloadDir", false); // ask where to save
user_pref("browser.download.autohideButton", false);

// forms
user_pref("browser.formfill.enable", false);
user_pref("signon.generation.enabled", false);
user_pref("dom.forms.autocomplete.formautofill", true);

// privacy
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("nimbus.rollouts.enabled", false);
user_pref("browser.search.serpEventTelemetryCategorization.regionEnabled", false);
user_pref("browser.ml.linkPreview.enabled", false);
user_pref("browser.contentblocking.category", "custom");
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.allow_list.convenience.enabled", false);
user_pref("privacy.globalprivacycontrol.enabled", true);
user_pref("privacy.history.custom", true);
user_pref("places.history.expiration.max_pages", 100);

// network
user_pref("network.dns.disablePrefetch", true);
user_pref("network.prefetch-next", false);
user_pref("network.http.speculative-parallel-limit", 0);
user_pref("network.trr.mode", 5);
user_pref("doh-rollout.disable-heuristics", true);
user_pref("network.proxy.type", 0);

// media
user_pref("media.eme.enabled", true); // drm
user_pref("media.hardwaremediakeys.enabled", false);

// reader mode
user_pref("reader.font_type", "serif");
user_pref("reader.font_size", 10);
user_pref("reader.content_width", 4);
user_pref("reader.character_spacing", 2);

// locale
user_pref("intl.regional_prefs.use_os_locales", true);
