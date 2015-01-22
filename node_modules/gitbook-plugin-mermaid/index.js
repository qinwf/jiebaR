

function processPage(page) {

  var mermaidMatches = page.content.match(/^```mermaid((.*\n)+?)?```$/igm);
  if (mermaidMatches) {
    var count = mermaidMatches.length;
    for (var i = 0; i < count; i++) {

      var mermaid = mermaidMatches[i];
      var mermaidClean = mermaid.replace(/```mermaid/igm, '');
      mermaidClean = mermaidClean.replace(/```/igm, '');

      page.content = page.content.replace(mermaid,
      '<div class="mermaid">' + mermaidClean + '</div>');
    }
  }

  return page;
}


module.exports = {
  book: {
    assets: "./book",
    js: [
      "plugin.js"
    ],
    html: {
      "head:end": function(options) {
         // script is added after head section and not via book:js section
         //   because otherwise 'require' definitions conflicts with
         //   gitbook's app.js script (I can not tell why and how to fix)
         return '<script src="' + options.staticBase + '/plugins/gitbook-plugin-mermaid/mermaid.full.min.js" id="mermaid-script"></script>';
      },
    }
  },
  hooks: {
    // Before parsing markdown
    "page:before": function(page) {
      return processPage(page);
    },
  }
};
