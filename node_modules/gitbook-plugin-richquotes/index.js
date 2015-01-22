var cheerio = require( "cheerio" )
	,$
	,options =
	{
		todos : false
	}
;

module.exports = {
	book : {
		assets: "./book",
		css   : [
			"plugin.css"
		]
	},
	hooks: {
		// For all the hooks, this represent the current generator
		// This is called before the book is generated
		init  : function ()
		{
			//console.log( "init!" );
			if( this.options.pluginsConfig && this.options.pluginsConfig.richquotes )
			{
				options = this.options.pluginsConfig.richquotes;
			}
		},

		// This is called for each page of the book
		// It can be used for modifing page content
		// It should return the new page
		page  : function ( page )
		{
			var section
				,$bq
				,$this
				,$strong
				,alert = "info"
				,picto = "fa-info"
				,isTodo = false
				;
			for ( var i in page.sections )
			{
				section = page.sections[i];
				if ( section.type == "normal" )
				{
					$ = cheerio.load( section.content );
					$bq = $( "blockquote" );
					if( $bq )
					{
						$bq.each
						(
							function ()
							{
								$this = $( this );
								$strong = $this.find( "p > strong" );
								if( $strong )
								{
									switch ( $strong.text().toLowerCase() )
									{
										/* info */
										case "info" :
											alert = "info";
											picto = "fa-info";
											break;
										case "note" :
											alert = "info";
											picto = "fa-edit";
											break;
										case "tag" :
											alert = "info";
											picto = "fa-tag";
											break;
										case "comment" :
											alert = "info";
											picto = "fa-comment-o";
											break;
										/* success */
										case "hint" :
										case "success" :
											alert = "success";
											picto = "fa-lightbulb-o";
											break;
										/* warning */
										case "warning" :
										case "caution" :
											alert = "warning";
											picto = "fa-exclamation-triangle";
											break;
										/* danger */
										case "danger" :
											alert = "danger";
											picto = "fa-times-circle";
											break;
										/* quote */
										case "quote" :
											alert = "quote";
											picto = "fa-quote-left";
											break;
										/* TODOs */
										case options.todos :
										case "todo" :
											alert = "info";
											picto = "fa-bookmark";
											isTodo = true;
											break;
										case options.todos :
										case "fixme" :
											alert = "danger";
											picto = "fa-bug";
											isTodo = true;
											break;
										case options.todos :
										case "xxx" :
											alert = "danger";
											picto = "fa-beer";
											isTodo = true;
											break;
										// Not a note
										default :
											return;
									}

									$strong
										.addClass( 'fa fa-4x ' + picto )
										.empty()
										.remove()
										;
									$this.addClass( 'clearfix alert alert-' + alert );
									$this.prepend( $strong );

									// Remove TODOs ?
									if( ! options.todos && isTodo )
									{
										$this.remove();
										isTodo = false;
									}

									// Replace by transform
									section.content = $.html();
								}
							}
						);
					}
				}
			}

			return page;
		}
	}
};