function DC_getScript(t, e) {
    var a = document.getElementsByTagName("head")[0], n = document.createElement("script");
    n.src = t;
    var r = !1;
    return n.onload = n.onreadystatechange = function () {
        r || this.readyState && "loaded" != this.readyState && "complete" != this.readyState || (r = !0, e && e(), n.onload = n.onreadystatechange = null)
    }, void a.appendChild(n)
}
function DC_getScripts(t) {

    for (var r = 0; r < t.length; ++r)DC_getScript(t[r], 0)
}