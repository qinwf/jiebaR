Gitbook plugin : Transform annoted quotes to notes
==============

For gitbook 0.4.2+

Annotated notes are an extension of markdown blockquotes.
Supported annotations :

- `> **Info** Info`
- `> **Note** Note`
- `> **Tag** Tag`
- `> **Comment** Comment`
- `> **Hint** Hint`
- `> **Success** Success`
- `> **Warning** Warning`
- `> **Caution** Caution`
- `> **Danger** Danger`
- `> **Quote** Quote`

Lowercase are allowed for annotations too.

You can use special annotations for editorial purpose

- `> **todo** TODO`
- `> **fixme** FIXME`
- `> **xxx** XXX`


You can install this plugin via NPM :

```bash
$ npm install gitbook-plugin-richquotes
```

Be sure too activate the option from the `book.json` file :

```json
{
	"plugins"   	: ["richquotes"]
	,"pluginsConfig":
	{
		"richquotes" :
		{
			"todos" : true /*false by default*/
		}
	}
}
```
