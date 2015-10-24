# Search Emoji codes and symbols using Alfred 2

This simple workflow lets you search emoji codes and their symbols.

## Copy the emoji code to use on Campfire, GitHub, etc.
Usage: `emoji [query]`

After you hit `enter` the code of the selected emoji will be copied to your
clipboard.

## Copy the actual emoji symbol to use on any OS X app.
Usage: `symoji [query]`

After you hit `enter` the symbol of the selected emoji will be copied to your
clipboard.

## Customizing the keywords:

If you don't like the keywords that are used for triggering the search you can
customize it directly on Alfred. Some suggested using `:` for searching the
emoji code and `emoji` for the actual symbols.

### Last but not least:

* __The `query` argument is optional for both commands. If you don't specify a `query`,
the whole list of emoji will be presented.__

* __You can also search an emoji using related words. Check [the full list](related.json)

* __You can add your own related words by editing custom_related.json and re-running generate.rb.__

[DOWNLOAD](package/emoji-codes.alfredworkflow)

![](http://f.cl.ly/items/3B18383s2O0B2Z0b2g11/Screen%20Shot%202013-12-06%20at%201.06.25%20AM.png)

## Developing

There are two steps to developing...

1. Run the `generate.rb` script to produce `related.json` & `symbols.json` (and any new images)
        
        ruby generate.rb
        
1. Install data files into Alfred

### Generating the Emoji and Related Words

The `generate.rb` script pulls the official [full emoji list](http://unicode.org/emoji/charts/full-emoji-list.html) from the unicode.org website and...

- Extracts the Apple icons
- Generates the symbols.json file with a map of names to symbols
- Generates the related.json file with a map of names to annotation keywords & custom related words from custom_related.json

### Installing data files into Alfred

1. Open Alfred preferences and navigate to this workflow
1. Open the configuration for either of the script actions
1. Click `Open Workflow Folder`
1. Copy the changed `symbols.json` & `related.json` into the workflow folder
1. If there are any new images in the `images/` folder, copy those as well
1. Enjoy!