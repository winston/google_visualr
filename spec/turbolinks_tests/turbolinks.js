(function() {
var CSRFToken, anchoredLink, browserCompatibleDocumentParser, browserIsntBuggy, browserSupportsPushState, browserSupportsTurbolinks, cacheCurrentPage, cacheSize, changePage, constrainPageCacheTo, createDocument, crossOriginLink, currentState, executeScriptTags, extractLink, extractTitleAndBody, fetchHistory, fetchReplacement, handleClick, ignoreClick, initializeTurbolinks, installClickHandlerLast, installDocumentReadyPageEventTriggers, installHistoryChangeHandler, installJqueryAjaxSuccessPageUpdateTrigger, loadedAssets, noTurbolink, nonHtmlLink, nonStandardClick, pageCache, pageChangePrevented, pagesCached, popCookie, processResponse, recallScrollPosition, referer, reflectNewUrl, reflectRedirectedUrl, rememberCurrentState, rememberCurrentUrl, rememberReferer, removeHash, removeHashForIE10compatiblity, removeNoscriptTags, requestMethodIsSafe, resetScrollPosition, targetLink, triggerEvent, visit, xhr, _ref,
  __hasProp = {}.hasOwnProperty,
  __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

pageCache = {};

cacheSize = 10;

currentState = null;

loadedAssets = null;

referer = null;

createDocument = null;

xhr = null;

fetchReplacement = function(url) {
  rememberReferer();
  cacheCurrentPage();
  triggerEvent('page:fetch', {
    url: url
  });
  if (xhr != null) {
    xhr.abort();
  }
  xhr = new XMLHttpRequest;
  xhr.open('GET', removeHashForIE10compatiblity(url), true);
  xhr.setRequestHeader('Accept', 'text/html, application/xhtml+xml, application/xml');
  xhr.setRequestHeader('X-XHR-Referer', referer);
  xhr.onload = function() {
    var doc;
    triggerEvent('page:receive');
    if (doc = processResponse()) {
      reflectNewUrl(url);
      reflectRedirectedUrl();
      changePage.apply(null, extractTitleAndBody(doc));
      resetScrollPosition();
      return triggerEvent('page:load');
    } else {
      return document.location.href = url;
    }
  };
  xhr.onloadend = function() {
    return xhr = null;
  };
  xhr.onabort = function() {
    return rememberCurrentUrl();
  };
  xhr.onerror = function() {
    return document.location.href = url;
  };
  return xhr.send();
};

fetchHistory = function(cachedPage) {
  cacheCurrentPage();
  if (xhr != null) {
    xhr.abort();
  }
  changePage(cachedPage.title, cachedPage.body);
  recallScrollPosition(cachedPage);
  return triggerEvent('page:restore');
};

cacheCurrentPage = function() {
  pageCache[currentState.position] = {
    url: document.location.href,
    body: document.body,
    title: document.title,
    positionY: window.pageYOffset,
    positionX: window.pageXOffset
  };
  return constrainPageCacheTo(cacheSize);
};

pagesCached = function(size) {
  if (size == null) {
    size = cacheSize;
  }
  if (/^[\d]+$/.test(size)) {
    return cacheSize = parseInt(size);
  }
};

constrainPageCacheTo = function(limit) {
  var key, value;
  for (key in pageCache) {
    if (!__hasProp.call(pageCache, key)) continue;
    value = pageCache[key];
    if (key <= currentState.position - limit) {
      pageCache[key] = null;
    }
  }
};

changePage = function(title, body, csrfToken, runScripts) {
  document.title = title;
  document.documentElement.replaceChild(body, document.body);
  if (csrfToken != null) {
    CSRFToken.update(csrfToken);
  }
  removeNoscriptTags();
  if (runScripts) {
    executeScriptTags();
  }
  currentState = window.history.state;
  triggerEvent('page:change');
  return triggerEvent('page:update');
};

executeScriptTags = function() {
  var attr, copy, nextSibling, parentNode, script, scripts, _i, _j, _len, _len1, _ref, _ref1;
  scripts = Array.prototype.slice.call(document.body.querySelectorAll('script:not([data-turbolinks-eval="false"])'));
  for (_i = 0, _len = scripts.length; _i < _len; _i++) {
    script = scripts[_i];
    if (!((_ref = script.type) === '' || _ref === 'text/javascript')) {
      continue;
    }
    copy = document.createElement('script');
    _ref1 = script.attributes;
    for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
      attr = _ref1[_j];
      copy.setAttribute(attr.name, attr.value);
    }
    copy.appendChild(document.createTextNode(script.innerHTML));
    parentNode = script.parentNode, nextSibling = script.nextSibling;
    parentNode.removeChild(script);
    parentNode.insertBefore(copy, nextSibling);
  }
};

removeNoscriptTags = function() {
  var noscript, noscriptTags, _i, _len;
  noscriptTags = Array.prototype.slice.call(document.body.getElementsByTagName('noscript'));
  for (_i = 0, _len = noscriptTags.length; _i < _len; _i++) {
    noscript = noscriptTags[_i];
    noscript.parentNode.removeChild(noscript);
  }
};

reflectNewUrl = function(url) {
  if (url !== referer) {
    return window.history.pushState({
      turbolinks: true,
      position: currentState.position + 1
    }, '', url);
  }
};

reflectRedirectedUrl = function() {
  var location, preservedHash;
  if (location = xhr.getResponseHeader('X-XHR-Redirected-To')) {
    preservedHash = removeHash(location) === location ? document.location.hash : '';
    return window.history.replaceState(currentState, '', location + preservedHash);
  }
};

rememberReferer = function() {
  return referer = document.location.href;
};

rememberCurrentUrl = function() {
  return window.history.replaceState({
    turbolinks: true,
    position: Date.now()
  }, '', document.location.href);
};

rememberCurrentState = function() {
  return currentState = window.history.state;
};

recallScrollPosition = function(page) {
  return window.scrollTo(page.positionX, page.positionY);
};

resetScrollPosition = function() {
  if (document.location.hash) {
    return document.location.href = document.location.href;
  } else {
    return window.scrollTo(0, 0);
  }
};

removeHashForIE10compatiblity = function(url) {
  return removeHash(url);
};

removeHash = function(url) {
  var link;
  link = url;
  if (url.href == null) {
    link = document.createElement('A');
    link.href = url;
  }
  return link.href.replace(link.hash, '');
};

popCookie = function(name) {
  var value, _ref;
  value = ((_ref = document.cookie.match(new RegExp(name + "=(\\w+)"))) != null ? _ref[1].toUpperCase() : void 0) || '';
  document.cookie = name + '=; expires=Thu, 01-Jan-70 00:00:01 GMT; path=/';
  return value;
};

triggerEvent = function(name, data) {
  var event;
  event = document.createEvent('Events');
  if (data) {
    event.data = data;
  }
  event.initEvent(name, true, true);
  return document.dispatchEvent(event);
};

pageChangePrevented = function() {
  return !triggerEvent('page:before-change');
};

processResponse = function() {
  var assetsChanged, clientOrServerError, doc, extractTrackAssets, intersection, validContent;
  clientOrServerError = function() {
    var _ref;
    return (400 <= (_ref = xhr.status) && _ref < 600);
  };
  validContent = function() {
    return xhr.getResponseHeader('Content-Type').match(/^(?:text\/html|application\/xhtml\+xml|application\/xml)(?:;|$)/);
  };
  extractTrackAssets = function(doc) {
    var node, _i, _len, _ref, _results;
    _ref = doc.head.childNodes;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      node = _ref[_i];
      if ((typeof node.getAttribute === "function" ? node.getAttribute('data-turbolinks-track') : void 0) != null) {
        _results.push(node.src || node.href);
      }
    }
    return _results;
  };
  assetsChanged = function(doc) {
    var fetchedAssets;
    loadedAssets || (loadedAssets = extractTrackAssets(document));
    fetchedAssets = extractTrackAssets(doc);
    return fetchedAssets.length !== loadedAssets.length || intersection(fetchedAssets, loadedAssets).length !== loadedAssets.length;
  };
  intersection = function(a, b) {
    var value, _i, _len, _ref, _results;
    if (a.length > b.length) {
      _ref = [b, a], a = _ref[0], b = _ref[1];
    }
    _results = [];
    for (_i = 0, _len = a.length; _i < _len; _i++) {
      value = a[_i];
      if (__indexOf.call(b, value) >= 0) {
        _results.push(value);
      }
    }
    return _results;
  };
  if (!clientOrServerError() && validContent()) {
    doc = createDocument(xhr.responseText);
    if (doc && !assetsChanged(doc)) {
      return doc;
    }
  }
};

extractTitleAndBody = function(doc) {
  var title;
  title = doc.querySelector('title');
  return [title != null ? title.textContent : void 0, doc.body, CSRFToken.get(doc).token, 'runScripts'];
};

CSRFToken = {
  get: function(doc) {
    var tag;
    if (doc == null) {
      doc = document;
    }
    return {
      node: tag = doc.querySelector('meta[name="csrf-token"]'),
      token: tag != null ? typeof tag.getAttribute === "function" ? tag.getAttribute('content') : void 0 : void 0
    };
  },
  update: function(latest) {
    var current;
    current = this.get();
    if ((current.token != null) && (latest != null) && current.token !== latest) {
      return current.node.setAttribute('content', latest);
    }
  }
};

browserCompatibleDocumentParser = function() {
  var createDocumentUsingDOM, createDocumentUsingParser, createDocumentUsingWrite, testDoc, _ref;
  createDocumentUsingParser = function(html) {
    return (new DOMParser).parseFromString(html, 'text/html');
  };
  createDocumentUsingDOM = function(html) {
    var doc;
    doc = document.implementation.createHTMLDocument('');
    doc.documentElement.innerHTML = html;
    return doc;
  };
  createDocumentUsingWrite = function(html) {
    var doc;
    doc = document.implementation.createHTMLDocument('');
    doc.open('replace');
    doc.write(html);
    doc.close();
    return doc;
  };
  try {
    if (window.DOMParser) {
      testDoc = createDocumentUsingParser('<html><body><p>test');
      return createDocumentUsingParser;
    }
  } catch (e) {
    testDoc = createDocumentUsingDOM('<html><body><p>test');
    return createDocumentUsingDOM;
  } finally {
    if ((testDoc != null ? (_ref = testDoc.body) != null ? _ref.childNodes.length : void 0 : void 0) !== 1) {
      return createDocumentUsingWrite;
    }
  }
};

installClickHandlerLast = function(event) {
  if (!event.defaultPrevented) {
    document.removeEventListener('click', handleClick, false);
    return document.addEventListener('click', handleClick, false);
  }
};

handleClick = function(event) {
  var link;
  if (!event.defaultPrevented) {
    link = extractLink(event);
    if (link.nodeName === 'A' && !ignoreClick(event, link)) {
      if (!pageChangePrevented()) {
        visit(link.href);
      }
      return event.preventDefault();
    }
  }
};

extractLink = function(event) {
  var link;
  link = event.target;
  while (!(!link.parentNode || link.nodeName === 'A')) {
    link = link.parentNode;
  }
  return link;
};

crossOriginLink = function(link) {
  return location.protocol !== link.protocol || location.host !== link.host;
};

anchoredLink = function(link) {
  return ((link.hash && removeHash(link)) === removeHash(location)) || (link.href === location.href + '#');
};

nonHtmlLink = function(link) {
  var url;
  url = removeHash(link);
  return url.match(/\.[a-z]+(\?.*)?$/g) && !url.match(/\.html?(\?.*)?$/g);
};

noTurbolink = function(link) {
  var ignore;
  while (!(ignore || link === document)) {
    ignore = link.getAttribute('data-no-turbolink') != null;
    link = link.parentNode;
  }
  return ignore;
};

targetLink = function(link) {
  return link.target.length !== 0;
};

nonStandardClick = function(event) {
  return event.which > 1 || event.metaKey || event.ctrlKey || event.shiftKey || event.altKey;
};

ignoreClick = function(event, link) {
  return crossOriginLink(link) || anchoredLink(link) || nonHtmlLink(link) || noTurbolink(link) || targetLink(link) || nonStandardClick(event);
};

installDocumentReadyPageEventTriggers = function() {
  triggerEvent('page:change');
  return triggerEvent('page:update');
};

installJqueryAjaxSuccessPageUpdateTrigger = function() {
  if (typeof jQuery !== 'undefined') {
    return $(document).on('ajaxSuccess', function(event, xhr, settings) {
      if (!$.trim(xhr.responseText)) {
        return;
      }
      return triggerEvent('page:update');
    });
  }
};

installHistoryChangeHandler = function(event) {
  var cachedPage, _ref;
  if ((_ref = event.state) != null ? _ref.turbolinks : void 0) {
    if (cachedPage = pageCache[event.state.position]) {
      return fetchHistory(cachedPage);
    } else {
      return visit(event.target.location.href);
    }
  }
};

initializeTurbolinks = function() {
  rememberCurrentUrl();
  rememberCurrentState();
  createDocument = browserCompatibleDocumentParser();
  document.addEventListener('click', installClickHandlerLast, true);
  document.addEventListener('DOMContentLoaded', installDocumentReadyPageEventTriggers, true);
  installJqueryAjaxSuccessPageUpdateTrigger();
  return window.addEventListener('popstate', installHistoryChangeHandler, false);
};

browserSupportsPushState = window.history && window.history.pushState && window.history.replaceState && window.history.state !== void 0;

browserIsntBuggy = !navigator.userAgent.match(/CriOS\//);

requestMethodIsSafe = (_ref = popCookie('request_method')) === 'GET' || _ref === '';

browserSupportsTurbolinks = browserSupportsPushState && browserIsntBuggy && requestMethodIsSafe;

if (browserSupportsTurbolinks) {
  visit = fetchReplacement;
  initializeTurbolinks();
} else {
  visit = function(url) {
    return document.location.href = url;
  };
}

this.Turbolinks = {
  visit: visit,
  pagesCached: pagesCached,
  supported: browserSupportsTurbolinks
};
}).call(this);