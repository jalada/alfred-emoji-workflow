# Search Emoji codes and symbols using Alfred 2

This simple workflow lets you search for and type emoji codes and their symbols.

## Copy the emoji code to use on Campfire, GitHub, etc.
Usage: `: [query]`

After you hit `enter` the code of the selected emoji will be copied to your
clipboard and pasted into the foreground window.

## Copy the actual emoji symbol to use on any OS X app.
Usage: `; [query]`

After you hit `enter` the symbol of the selected emoji will be copied to your
clipboard and pasted into the foreground window.

## Customizing the keywords:

Use keyword **:** (colon) to find :emoji: codes

Use keyword **;** (semicolon) to find the actual emoji

You can change these in Alfred preferences

### Last but not least:

* __The `query` argument is optional for both commands. If you don't specify a `query`,
the whole list of emoji will be presented.__

* __You can also search an emoji using related words.__

* __You can add your own related words by editing custom_related.json and re-running generate.rb.__

![](http://i.imgur.com/g0GbJUY.png)

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