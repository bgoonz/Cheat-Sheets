"use strict";

!function() {
    var t = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyMWYxODMxZDcyMWU3MjA3M2Q2YTAxZCIsInRva2VuVHlwZSI6InB1YmxpYyIsImlhdCI6MTY0NjIwNDk3OCwiZXhwIjoxNDI2MDYwNDk3OH0.kd6Yf-w3kBWHvEWEUb8m_EIONkyH1k8uBULO8OllME0";
    function e() {
        var e = document.createElement("script"), a = navigator.language || navigator.userLanguage;
        e.type = "text/javascript", e.async = !0, e.src = "https://api.searchbar.org/v1/widget/" + t + "/" + a;
        var n = document.getElementsByTagName("script")[0];
        n.parentNode.insertBefore(e, n);
    }
    "complete" === document.readyState ? e() : window.attachEvent ? window.attachEvent("onload", e) : window.addEventListener("load", e, !1);
}();