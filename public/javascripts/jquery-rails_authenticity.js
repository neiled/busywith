// Save this chunk as something like jquery.rails_autehticity.js and include it after you include jquery.js
// Rails jQuery ajaxSend()
//
// Original found here: http://henrik.nyh.se/2008/05/rails-authenticity-token-with-jquery
//
// Seems I needed to do a few other things as well to get the ajax request sent properly,
// and receive the proper response.
//
// For some reason DELETE requests were being sent to the server with Content-Type application/xml.
// That results in a FATAL: FAILSAFE error in rails.  (My action only had a respond_to for .js)
// Looking through the jquery code, it looks like it calls open() which for some reason is changing
// the default application/x-www-form-urlencoded to application/xml, so we force it to be correct here.
//
//
(function($) {

  $(document).ajaxSend(function(event, request, settings) { //Set request headers globally

    request.setRequestHeader("Accept", "text/javascript");
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    if (settings.type.toUpperCase() == 'GET' || typeof(AUTH_TOKEN) == "undefined") return;
    // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
    settings.data = settings.data || "";
    settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
  });

})(jQuery);