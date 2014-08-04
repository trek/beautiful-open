/*
    requires: phantomjs, async
    usage: phantomjs snap.js
*/
var args = require('system').args;
var site = args[1];
var name = args[2];

var async = require('async'),
    sizes = [
        [1000, 800]
    ];

function capture(sizes, callback) {
    var page = require('webpage').create();
    page.viewportSize = {
        width: sizes[0],
        height: sizes[1]
    };
    page.clipRect = {
      top: 0,
      left: 0,
      width: sizes[0],
      height: sizes[1]
    };
    page.zoomFactor = 0.9;
    page.open(site, function (status) {
        setTimeout(function(){
            var filename = name + '.png';
            page.render('./screenshots/' + filename);
            page.close();
            callback.apply();
        }, 2000);
    });
}

async.eachSeries(sizes, capture, function (e) {
    if (e) console.log(e);
    console.log('done!');
    phantom.exit();
});